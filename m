Return-Path: <netdev+bounces-20696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A02760B06
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B128124E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C18F5E;
	Tue, 25 Jul 2023 06:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61008F5A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:57:22 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D56F91B3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=fI/3QGduitCKqSYrPM
	hP1msRrOx8ZJz64CBjrC3Fwg0=; b=OtJ8fNb+6RtpQezJJlEqks/IkcU5H82nVY
	H4p4YzuhHfY/KbY//TesxFeMzjD0qF93KuA8JG9VUStDVLhRDDZe/8l3DZpY4iZD
	1qZYP6rwu+Gke0e+pmeXhtPA675RmeZLnpOcKEdHwo+pgoHrx+td/XsB8Bdnwltu
	nAZy8tJm0=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wAnbcE4cr9kHYPuBA--.41827S4;
	Tue, 25 Jul 2023 14:57:02 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: leon@kernel.org
Cc: borisp@nvidia.com,
	netdev@vger.kernel.org,
	ruc_gongyuanjun@163.com,
	saeedm@nvidia.com
Subject: [PATCH net v2 1/1] net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
Date: Tue, 25 Jul 2023 14:56:55 +0800
Message-Id: <20230725065655.6964-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717185533.GA8808@unreal>
References: <20230717185533.GA8808@unreal>
X-CM-TRANSID:_____wAnbcE4cr9kHYPuBA--.41827S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1DGF1rZr4xJw4rZF4xJFb_yoWkuFb_Gw
	1fXrWkJryS9Fnxtr4F9w45XrWIqrykWFnavFZ2gFW3tw43ur95Ar95uF97XF1kGF18Ga4D
	GF4avFW5Ca4DAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtKsjUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQG35VaEH-NPlQAAs+
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

mlx5e_ipsec_remove_trailer() should return an error code if function
pskb_trim() returns an unexpected value.

Fixes: 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
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


