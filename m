Return-Path: <netdev+bounces-27157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1965377A8D6
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D543E1C20944
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C38BFD;
	Sun, 13 Aug 2023 16:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F38F40
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0567DC433C7;
	Sun, 13 Aug 2023 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691942825;
	bh=EE69y2n4jyxguhjq6tl8wyqyVHq3h5bcYnULPLF2nu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mscWTRAD9rMPjYsOYgmHAl/dEXznK7SMzpmHXmvgqLAGhNCaiWmmAGzv2KlKxRJHI
	 ruaFK/JlC3Of3n66MenU28KhgeI2OnNA3ddr+Xw0HiXvl+xYOr88ImVB4+pX8yjWq7
	 OviTNU/5W39PJEYWXvEAh2a0KJVF2Hwodc8W56qw5EGliZwasLR9kXUtasetcYt79T
	 RtkL9eHqcKszZIapNM8o9Jc63Rwp0hU9isIgMD5MeLu5qWWwcOi2Dc9l3PEsRfKoZZ
	 IpqlHi+T+bADSQ6hm6wEXt0RQ9RUp5o8Kgn5Hpf4cubMKHWTf1kuKAZwtOvd7Zxtnf
	 B/b/k5qT01A+g==
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
	pavan.chebbi@broadcom.com,
	trix@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/31] ethernet: atheros: fix return value check in atl1c_tso_csum()
Date: Sun, 13 Aug 2023 12:05:43 -0400
Message-Id: <20230813160605.1080385-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
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
index 5cbd815c737e7..dad21b4fbc0bc 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2104,8 +2104,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
-- 
2.40.1


