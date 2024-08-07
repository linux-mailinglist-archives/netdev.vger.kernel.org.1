Return-Path: <netdev+bounces-116364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3A94A24B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2D81C24C0E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3D1CB316;
	Wed,  7 Aug 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T/VhrMjv"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE01CB313;
	Wed,  7 Aug 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017596; cv=none; b=W4z/vtWTLivmRbyWqqRWpew4URXCFVZBZ5JJvstZ7160z+7RuNfNX7cOoxlNyRmImKIYMBBhH54CdLb41NmGjtmQN0tjmkPXgR3XTHsbx/xOCIpi+3MHTf/q5SxPFJH83ZhCDT9r0mHvOyBC3+IedewadlVWrrMo/pX4heaxzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017596; c=relaxed/simple;
	bh=VMAAsSjC53JpXHDuLGA5O9++zEKGe5nFhFgXFMHkaQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQoO0sajXWoK8hM8e5LpC3PjJBFIQ1uuFSFJ5vnkqMxBCXi1935NSSnMPyZPPd5+AWHxuwyx130fE1QN/jhJbj2FrZFsSvLWw7Wh6btduFD5w3tS0m7GHeFAM+TkybHBHvANVaLEpFMrqYbCa8i8xlNAXhR9ZILIbfnCIkP2EcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T/VhrMjv; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723017586; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7Ld1tY91ktkffR5f+V/hYWEOUkcFMhpD0gHnz4JpaZQ=;
	b=T/VhrMjvCCXP4cSQIcFZcKA25XKmUGJrm5ZvOvMOAmTm4vH41nSGiqbg3JTP9eP4AQZRhrn1f1teQQahXRuQFlWcohYaBz3BNN2OYYTdTZ2cyeQaoMTTOXaMgPBBbbh1y9nhNWX8NyPPDXGItmB9TyY6oz5WXmgu8ngK8jcjTtc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WCIAZ-J_1723017584;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCIAZ-J_1723017584)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:59:45 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net/smc: introduce statistics for ringbufs usage of net namespace
Date: Wed,  7 Aug 2024 15:59:39 +0800
Message-Id: <20240807075939.57882-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240807075939.57882-1-guwen@linux.alibaba.com>
References: <20240807075939.57882-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer size histograms in smc_stats, namely rx/tx_rmbsize, record
the sizes of ringbufs for all connections that have ever appeared in
the net namespace. They are incremental and we cannot know the actual
ringbufs usage from these. So here introduces statistics for current
ringbufs usage of existing smc connections in the net namespace into
smc_stats, it will be incremented when new connection uses a ringbuf
and decremented when the ringbuf is unused.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/uapi/linux/smc.h |  2 ++
 net/smc/smc_core.c       | 22 +++++++++++++++-------
 net/smc/smc_stats.c      |  8 ++++++++
 net/smc/smc_stats.h      | 28 +++++++++++++++++++---------
 4 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index d27b8dc50f90..304e202c03bb 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -253,6 +253,8 @@ enum {
 	SMC_NLA_STATS_T_TX_BYTES,	/* u64 */
 	SMC_NLA_STATS_T_RX_CNT,		/* u64 */
 	SMC_NLA_STATS_T_TX_CNT,		/* u64 */
+	SMC_NLA_STATS_T_RX_RMB_USAGE,	/* u64 */
+	SMC_NLA_STATS_T_TX_RMB_USAGE,	/* u64 */
 	__SMC_NLA_STATS_T_MAX,
 	SMC_NLA_STATS_T_MAX = __SMC_NLA_STATS_T_MAX - 1
 };
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index b1ff44d72fe4..72c6c7363f93 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1207,22 +1207,30 @@ static void smcd_buf_detach(struct smc_connection *conn)
 static void smc_buf_unuse(struct smc_connection *conn,
 			  struct smc_link_group *lgr)
 {
+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
+	bool is_smcd = lgr->is_smcd;
+	int bufsize;
+
 	if (conn->sndbuf_desc) {
-		if (!lgr->is_smcd && conn->sndbuf_desc->is_vm) {
+		bufsize = conn->sndbuf_desc->len;
+		if (!is_smcd && conn->sndbuf_desc->is_vm) {
 			smcr_buf_unuse(conn->sndbuf_desc, false, lgr);
 		} else {
-			memzero_explicit(conn->sndbuf_desc->cpu_addr, conn->sndbuf_desc->len);
+			memzero_explicit(conn->sndbuf_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->sndbuf_desc->used, 0);
 		}
+		SMC_STAT_RMB_SIZE(smc, is_smcd, false, false, bufsize);
 	}
 	if (conn->rmb_desc) {
-		if (!lgr->is_smcd) {
+		bufsize = conn->rmb_desc->len;
+		if (!is_smcd) {
 			smcr_buf_unuse(conn->rmb_desc, true, lgr);
 		} else {
-			memzero_explicit(conn->rmb_desc->cpu_addr,
-					 conn->rmb_desc->len + sizeof(struct smcd_cdc_msg));
+			bufsize += sizeof(struct smcd_cdc_msg);
+			memzero_explicit(conn->rmb_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->rmb_desc->used, 0);
 		}
+		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
 	}
 }
 
@@ -2431,7 +2439,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
-			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
+			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
 			SMC_STAT_BUF_REUSE(smc, is_smcd, is_rmb);
 			break; /* found reusable slot */
 		}
@@ -2452,7 +2460,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		}
 
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
-		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
+		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
 		buf_desc->used = 1;
 		down_write(lock);
 		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
diff --git a/net/smc/smc_stats.c b/net/smc/smc_stats.c
index ca14c0f3a07d..3f2ebc6c06ba 100644
--- a/net/smc/smc_stats.c
+++ b/net/smc/smc_stats.c
@@ -218,6 +218,14 @@ static int smc_nl_fill_stats_tech_data(struct sk_buff *skb,
 			      smc_tech->tx_bytes,
 			      SMC_NLA_STATS_PAD))
 		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_STATS_T_RX_RMB_USAGE,
+			      smc_tech->rx_rmbuse,
+			      SMC_NLA_STATS_PAD))
+		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_STATS_T_TX_RMB_USAGE,
+			      smc_tech->tx_rmbuse,
+			      SMC_NLA_STATS_PAD))
+		goto errattr;
 	if (nla_put_u64_64bit(skb, SMC_NLA_STATS_T_RX_CNT,
 			      smc_tech->rx_cnt,
 			      SMC_NLA_STATS_PAD))
diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 9d32058db2b5..6ac465380431 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -79,6 +79,8 @@ struct smc_stats_tech {
 	u64			tx_bytes;
 	u64			rx_cnt;
 	u64			tx_cnt;
+	u64			rx_rmbuse;
+	u64			tx_rmbuse;
 };
 
 struct smc_stats {
@@ -135,38 +137,46 @@ do { \
 } \
 while (0)
 
-#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _len) \
+#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _is_add, _len) \
 do { \
+	typeof(_smc_stats) stats = (_smc_stats); \
+	typeof(_is_add) is_a = (_is_add); \
 	typeof(_len) _l = (_len); \
 	typeof(_tech) t = (_tech); \
 	int _pos; \
 	int m = SMC_BUF_MAX - 1; \
 	if (_l <= 0) \
 		break; \
-	_pos = fls((_l - 1) >> 13); \
-	_pos = (_pos <= m) ? _pos : m; \
-	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
+	if (is_a) { \
+		_pos = fls((_l - 1) >> 13); \
+		_pos = (_pos <= m) ? _pos : m; \
+		this_cpu_inc((*stats).smc[t].k ## _rmbsize.buf[_pos]); \
+		this_cpu_add((*stats).smc[t].k ## _rmbuse, _l); \
+	} else { \
+		this_cpu_sub((*stats).smc[t].k ## _rmbuse, _l); \
+	} \
 } \
 while (0)
 
 #define SMC_STAT_RMB_SUB(_smc_stats, type, t, key) \
 	this_cpu_inc((*(_smc_stats)).smc[t].rmb ## _ ## key.type ## _cnt)
 
-#define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _len) \
+#define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _is_add, _len) \
 do { \
 	struct net *_net = sock_net(&(_smc)->sk); \
 	struct smc_stats __percpu *_smc_stats = _net->smc.smc_stats; \
+	typeof(_is_add) is_add = (_is_add); \
 	typeof(_is_smcd) is_d = (_is_smcd); \
 	typeof(_is_rx) is_r = (_is_rx); \
 	typeof(_len) l = (_len); \
 	if ((is_d) && (is_r)) \
-		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, rx, l); \
+		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, rx, is_add, l); \
 	if ((is_d) && !(is_r)) \
-		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, tx, l); \
+		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, tx, is_add, l); \
 	if (!(is_d) && (is_r)) \
-		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, rx, l); \
+		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, rx, is_add, l); \
 	if (!(is_d) && !(is_r)) \
-		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, tx, l); \
+		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, tx, is_add, l); \
 } \
 while (0)
 
-- 
2.32.0.3.g01195cf9f


