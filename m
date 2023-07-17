Return-Path: <netdev+bounces-18316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E37566BC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315BD1C20A27
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB456253B2;
	Mon, 17 Jul 2023 14:47:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1033253A9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:47:11 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCA00E45
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=IoKkUJVfjEUNM/wkHf
	3tItOA17kNcjPEttXoqh397lo=; b=RI1Mu1XMK6dmc8sWY7mbFEx+Bdlcw8oRkL
	MN7YfeKvj6aM8X3AbIbtmmxgIcgsaIZn0k7ITYk/ew6cdCDJINkuBROOLEGfvFTp
	Y/XxhZmJAvRRmc6vOl7xCCOGC8dphAal2UEv1u3lqf0nIZiLeFNXohgytI5D5v4h
	AvAvNaBmM=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wAnbbpRVLVkbvtAAg--.4294S4;
	Mon, 17 Jul 2023 22:46:46 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] drivers:net: fix return value check in mlx5e_ipsec_remove_trailer
Date: Mon, 17 Jul 2023 22:46:40 +0800
Message-Id: <20230717144640.23166-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAnbbpRVLVkbvtAAg--.4294S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1Dur1xGFyftr4fAF4kXrb_yoWkJrc_G3
	WxXrWkJryF9Fnrtr4Y93y5XrWIqr1kWF9YvFZrKFW3tw43uryrAr95uFn7Xr1kGF18Ga4D
	GF4avFW5C3yDAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKo7KUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQav5WDESThQ1gABsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

mlx5e_ipsec_remove_trailer should return an error code if function
pskb_trim returns an unexpected value.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index eab5bc718771..8d995e304869 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -58,7 +58,9 @@ static int mlx5e_ipsec_remove_trailer(struct sk_buff *skb, struct xfrm_state *x)
 
 	trailer_len = alen + plen + 2;
 
-	pskb_trim(skb, skb->len - trailer_len);
+	ret = pskb_trim(skb, skb->len - trailer_len);
+	if (unlikely(ret))
+		return ret;
 	if (skb->protocol == htons(ETH_P_IP)) {
 		ipv4hdr->tot_len = htons(ntohs(ipv4hdr->tot_len) - trailer_len);
 		ip_send_check(ipv4hdr);
-- 
2.17.1


