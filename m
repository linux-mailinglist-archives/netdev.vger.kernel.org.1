Return-Path: <netdev+bounces-18318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B67566BF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA811C20904
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514F253BA;
	Mon, 17 Jul 2023 14:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB288253AD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:47:30 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EAD8E45
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=8qRaC1dbtXxPWCPuEF
	gLXVxpIK2CJwO8GLh+N5nuga4=; b=RbvwPFRhOmxXAiqmo1eKwwxI2aiSc9UgEu
	RcDFRGc1gZToY5raJwbfk6t40Z4fOkeoWcAaqZssEt3kJmK+LvbzS/YCY8EGob9V
	TA7hN9Cr1WBbo5S0zmJAeTotkDxRQQmPbcgVIKjyixarf9ehvktFsCy2Dlvn8bvR
	qAANowJ50=
Received: from localhost.localdomain (unknown [202.112.113.212])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wCnTdY_VLVkKWg6Ag--.14517S4;
	Mon, 17 Jul 2023 22:46:29 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Timur Tabi <timur@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] drivers: net: fix return value check in emac_tso_csum()
Date: Mon, 17 Jul 2023 22:46:21 +0800
Message-Id: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wCnTdY_VLVkKWg6Ag--.14517S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1fZFyDGFWUJw13AFW3trb_yoWDGrX_Gw
	10q3W7XF4UuF13Cr4xtwnxX34v9rs7XFWkWFyxKFW3Ar9rZFn8A3ykGrZ5Ar17GFWxCrnr
	Gr1fCFWxC345KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNdgAUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQav5VaEH4U9LQAAsd
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

in emac_tso_csum(), return an error code if an unexpected value
is returned by pskb_trim().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index 0d80447d4d3b..d5c688a8d7be 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -1260,8 +1260,11 @@ static int emac_tso_csum(struct emac_adapter *adpt,
 		if (skb->protocol == htons(ETH_P_IP)) {
 			u32 pkt_len = ((unsigned char *)ip_hdr(skb) - skb->data)
 				       + ntohs(ip_hdr(skb)->tot_len);
-			if (skb->len > pkt_len)
-				pskb_trim(skb, pkt_len);
+			if (skb->len > pkt_len) {
+				ret = pskb_trim(skb, pkt_len);
+				if (unlikely(ret))
+					return ret;
+			}
 		}
 
 		hdr_len = skb_tcp_all_headers(skb);
-- 
2.17.1


