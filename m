Return-Path: <netdev+bounces-36027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7E7ACA3E
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2D9C51C2091F
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96952D290;
	Sun, 24 Sep 2023 15:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6326D27D
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 15:17:08 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8412FCF;
	Sun, 24 Sep 2023 08:17:05 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VsilXe4_1695568619;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsilXe4_1695568619)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 23:17:02 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: wintera@linux.ibm.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	pasic@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 01/18] net/smc: decouple ism_dev from SMC-D device dump
Date: Sun, 24 Sep 2023 23:16:36 +0800
Message-Id: <1695568613-125057-2-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This patch helps to decouple ISM device from SMC-D device, allowing
different underlying device forms, such as virtual ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index fbee249..fc551f4 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -230,12 +230,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
 	struct smc_pci_dev smc_pci_dev;
 	struct nlattr *port_attrs;
+	struct device *priv_dev;
 	struct nlattr *attrs;
-	struct ism_dev *ism;
 	int use_cnt = 0;
 	void *nlh;
 
-	ism = smcd->priv;
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &smc_gen_nl_family, NLM_F_MULTI,
 			  SMC_NETLINK_GET_DEV_SMCD);
@@ -250,7 +249,9 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
 		goto errattr;
 	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
+	priv_dev = smcd->ops->get_dev(smcd);
+	if (priv_dev && priv_dev->parent)
+		smc_set_pci_values(to_pci_dev(priv_dev->parent), &smc_pci_dev);
 	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
 		goto errattr;
 	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
-- 
1.8.3.1


