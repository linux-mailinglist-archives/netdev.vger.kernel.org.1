Return-Path: <netdev+bounces-24060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A576EA2D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3489B281F10
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAB1F926;
	Thu,  3 Aug 2023 13:24:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB5200CF
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:24:34 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDEB1BFA;
	Thu,  3 Aug 2023 06:24:32 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Voz-FRv_1691069068;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Voz-FRv_1691069068)
          by smtp.aliyun-inc.com;
          Thu, 03 Aug 2023 21:24:29 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	kgraul@linux.ibm.com,
	tonylu@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 6/6] net/smc: Extend SMCR v2 linkgroup netlink attribute
Date: Thu,  3 Aug 2023 21:24:22 +0800
Message-Id: <20230803132422.6280-7-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add SMC_NLA_LGR_R_V2_MAX_CONNS and SMC_NLA_LGR_R_V2_MAX_LINKS
to SMCR v2 linkgroup netlink attribute SMC_NLA_LGR_R_V2 for
linkgroup's detail info showing.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 include/uapi/linux/smc.h | 2 ++
 net/smc/smc_core.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index bb4dacca31e7..837fcd4b0abc 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -107,6 +107,8 @@ enum {
 enum {
 	SMC_NLA_LGR_R_V2_UNSPEC,
 	SMC_NLA_LGR_R_V2_DIRECT,	/* u8 */
+	SMC_NLA_LGR_R_V2_MAX_CONNS,	/* u8 */
+	SMC_NLA_LGR_R_V2_MAX_LINKS,	/* u8 */
 	__SMC_NLA_LGR_R_V2_MAX,
 	SMC_NLA_LGR_R_V2_MAX = __SMC_NLA_LGR_R_V2_MAX - 1
 };
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d5967826bcdf..182ac69d25c8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -319,6 +319,10 @@ static int smc_nl_fill_smcr_lgr_v2(struct smc_link_group *lgr,
 		goto errattr;
 	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_DIRECT, !lgr->uses_gateway))
 		goto errv2attr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_MAX_CONNS, lgr->max_conns))
+		goto errv2attr;
+	if (nla_put_u8(skb, SMC_NLA_LGR_R_V2_MAX_LINKS, lgr->max_links))
+		goto errv2attr;
 
 	nla_nest_end(skb, v2_attrs);
 	return 0;
-- 
2.24.3 (Apple Git-128)


