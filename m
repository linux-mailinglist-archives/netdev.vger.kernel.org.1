Return-Path: <netdev+bounces-27148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C377A7BF
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85EA280F6E
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E58825;
	Sun, 13 Aug 2023 15:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A2849C
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 15:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D3CC433CD;
	Sun, 13 Aug 2023 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691941829;
	bh=T1ipUjyWapBEp+xLdE4se2hvvu5d1xSQrBSrhA9V8TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYxEDYVxmYMzOaHkq4A/LGkvEUSHAc+038NBf+72WUWTiKOdggI+MYR3dVqGG569l
	 uZi84UoZEbmt/p1tyvqXxXWK47a3Zp/MouFkrFeJLx/YGkGOKEqxdTGAzLttzg15Gh
	 cSvzU9SqDQU3/LzhLdEq/bkaqGno8J0hDhTjv1wpVenr8an5UFxyw7iCthK2L12HJs
	 8vfQUt3J9qEAdeHudV4MsOIcMM/mzH/UDvNVV34I36DHg59bWfRRk2dmoLxp3gcJXi
	 7XglvcEKZ2DbL3V1weUe72M9TPw1r1N8WgxflK2ZL8i3nsoKnw2sXSEzpZ4JvEIivw
	 iNKYFXevb24LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	chris.snook@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mkl@pengutronix.de,
	trix@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 20/54] ethernet: atheros: fix return value check in atl1c_tso_csum()
Date: Sun, 13 Aug 2023 11:48:59 -0400
Message-Id: <20230813154934.1067569-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit 8d01da0a1db237c44c92859ce3612df7af8d3a53 ]

in atl1c_tso_csum, it should check the return value of pskb_trim(),
and return an error code if an unexpected value is returned
by pskb_trim().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 4a288799633f8..940c5d1ff9cfc 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2094,8 +2094,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = skb_tcp_all_headers(skb);
 			if (unlikely(skb->len == hdr_len)) {
-- 
2.40.1


