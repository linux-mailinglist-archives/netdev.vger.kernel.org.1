Return-Path: <netdev+bounces-50072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07857F4851
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F19B1F22062
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F344E638;
	Wed, 22 Nov 2023 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC2D5C;
	Wed, 22 Nov 2023 05:53:07 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vww0FYJ_1700661184;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vww0FYJ_1700661184)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 21:53:04 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	kgraul@linux.ibm.com,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: tonylu@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net/smc: add sysctl for max conns per lgr for SMC-R v2.1
Date: Wed, 22 Nov 2023 21:52:58 +0800
Message-Id: <20231122135258.38746-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
References: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new sysctl: net.smc.smcr_max_conns_per_lgr, which is
used to control the preferred max connections per lgr for
SMC-R v2.1. The default value of this sysctl is 255, and
the acceptable value ranges from 16 to 255.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 Documentation/networking/smc-sysctl.rst |  6 ++++++
 include/net/netns/smc.h                 |  1 +
 net/smc/smc_clc.c                       |  5 +++--
 net/smc/smc_sysctl.c                    | 12 ++++++++++++
 net/smc/smc_sysctl.h                    |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index c6ef86ef4c4f..a874d007f2db 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -65,3 +65,9 @@ smcr_max_links_per_lgr - INTEGER
 	for SMC-R v2.1 and later.
 
 	Default: 2
+
+smcr_max_conns_per_lgr - INTEGER
+	Controls the max number of connections can be added to a SMC-R link group. The
+	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
+
+	Default: 255
diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index da7023587824..fc752a50f91b 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -23,5 +23,6 @@ struct netns_smc {
 	int				sysctl_wmem;
 	int				sysctl_rmem;
 	int				sysctl_max_links_per_lgr;
+	int				sysctl_max_conns_per_lgr;
 };
 #endif
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 1f87c8895a27..0fda5156eef0 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -944,7 +944,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	}
 	if (smcr_indicated(ini->smc_type_v2)) {
 		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
-		v2_ext->max_conns = SMC_CONN_PER_LGR_PREFER;
+		v2_ext->max_conns = net->smc.sysctl_max_conns_per_lgr;
 		v2_ext->max_links = net->smc.sysctl_max_links_per_lgr;
 	}
 
@@ -1191,7 +1191,8 @@ int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
 		return SMC_CLC_DECL_NOV2EXT;
 
 	if (ini->smcr_version & SMC_V2) {
-		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns, SMC_CONN_PER_LGR_PREFER);
+		ini->max_conns = min_t(u8, pclc_v2_ext->max_conns,
+				       net->smc.sysctl_max_conns_per_lgr);
 		if (ini->max_conns < SMC_CONN_PER_LGR_MIN)
 			return SMC_CLC_DECL_MAXCONNERR;
 
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 3e9bb921e40a..a5946d1b9d60 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -27,6 +27,8 @@ static const int net_smc_wmem_init = (64 * 1024);
 static const int net_smc_rmem_init = (64 * 1024);
 static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
 static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
+static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
+static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
 
 static struct ctl_table smc_table[] = {
 	{
@@ -79,6 +81,15 @@ static struct ctl_table smc_table[] = {
 		.extra1		= &links_per_lgr_min,
 		.extra2		= &links_per_lgr_max,
 	},
+	{
+		.procname	= "smcr_max_conns_per_lgr",
+		.data		= &init_net.smc.sysctl_max_conns_per_lgr,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &conns_per_lgr_min,
+		.extra2		= &conns_per_lgr_max,
+	},
 	{  }
 };
 
@@ -109,6 +120,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
 	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
+	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
 
 	return 0;
 
diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
index 5783dd7575dd..eb2465ae1e15 100644
--- a/net/smc/smc_sysctl.h
+++ b/net/smc/smc_sysctl.h
@@ -24,6 +24,7 @@ static inline int smc_sysctl_net_init(struct net *net)
 {
 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
+	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
 	return 0;
 }
 
-- 
2.24.3 (Apple Git-128)


