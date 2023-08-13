Return-Path: <netdev+bounces-27170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8A77A98E
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED6D281059
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ABF8F66;
	Sun, 13 Aug 2023 16:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7188F40
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07375C433C7;
	Sun, 13 Aug 2023 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691943283;
	bh=3dbjnZxrVUMKozJ/mrwEA8HZKfj3QGCrkecUWGfJmNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUMDuK61bUjmfXPs70mYulu53CDl8HFURLNR31vmO+oGojw/BSEgGneixhP2RzbRs
	 DnDdUVqENCsufvdOOgbsM7TzQwqJLW6CK8Dy+O1KuQ8H8Wx1v3LxQyTnaEsdqpDCDD
	 JdEtq93xXM4gpyHDtQZjKQE7NyN0hViOnY3cRk/gbSDf77rl4tDoLVD4UxZeOXProd
	 oJeZzXMAxYNTpG9WoGBqvyI08QdS639dtLmcbGFeZxPylOs4lLw1Sc1hW2Z8mvfWvw
	 hiYMS7PSbg7IxO1sqc5wxpAOiUTtcrW39C8BLGRI70/kCp90fuNQGnz1GXoJqyMdnf
	 FvnNNTlCPBocg==
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
	pavan.chebbi@broadcom.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/9] ethernet: atheros: fix return value check in atl1c_tso_csum()
Date: Sun, 13 Aug 2023 12:14:21 -0400
Message-Id: <20230813161427.1089101-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
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
index 3615c2a06fdad..6f5c7c1401ce0 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2001,8 +2001,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
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


