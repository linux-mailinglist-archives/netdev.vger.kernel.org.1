Return-Path: <netdev+bounces-115679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED79477F1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD61C2148E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96014D6E9;
	Mon,  5 Aug 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SGfjmw2t"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87A13D503;
	Mon,  5 Aug 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848766; cv=none; b=TxFgL0qowId7pLR9ab2e2jMnfC4JuwFDtTndbmXlRJQL3lQnwgoc5mGOB9EsBO9vhNvNo3A8LrFW6UtqHASVskGMNiAywm1JbgAEhfmpawCyyjyI7KidC46CtpzGM5C5mGf5vG01CCcXTuis4SiXcVHsvXF+00EBlFG+HY3YJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848766; c=relaxed/simple;
	bh=2LNri9DZCw8jb242iUb2ExDCNVLEy/Hge3Y/4Oba+RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kq7GirvQXC1GXwO/kf5jpj47UiKjQyeZRu5Ny9sqjNiM1hV3w00tLRAmcunIdHEYxlpIbYUD2742wI7MuMSozC/yHKWZ7e0AFNkWs0FUn9qlXv9zRCYbJNz1ypULG36ELD7rCJX4sC2WeXC2A4W+QLmCSwoCTyXVsf+B+EqCKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SGfjmw2t; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722848756; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wFs9kn8DEBz8rJvQywTcv6fWKB5QUQwPL/bshdSq8es=;
	b=SGfjmw2t0YNTNlT5qYLi9p/u4Eq6mWGxkr/MNb1QseNtxXmVERC7K7tyky5kbuxGK/HDopIO82vXLCcGObgobwP2dud1zg7akyVrHoKP+CY2jNEVPFhcKFa5Z3eRQ59LGMZ8Rm2pXeOx+y8g/3JWMfim7eMW1XsbQ0psEoZmLik=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WC7URGa_1722848753;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WC7URGa_1722848753)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 17:05:55 +0800
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
Subject: [PATCH net-next 1/2] net/smc: introduce statistics for allocated ringbufs of link group
Date: Mon,  5 Aug 2024 17:05:50 +0800
Message-Id: <20240805090551.80786-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240805090551.80786-1-guwen@linux.alibaba.com>
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have the statistics on sndbuf/RMB sizes of all connections
that have ever been on the link group, namely smc_stats_memsize. However
these statistics are incremental and since the ringbufs of link group
are allowed to be reused, we cannot know the actual allocated buffers
through these. So here introduces the statistic on actual allocated
ringbufs of the link group, it will be incremented when a new ringbuf is
added into buf_list and decremented when it is deleted from buf_list.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/uapi/linux/smc.h |  4 ++++
 net/smc/smc_core.c       | 52 ++++++++++++++++++++++++++++++++++++----
 net/smc/smc_core.h       |  2 ++
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index b531e3ef011a..d27b8dc50f90 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -127,6 +127,8 @@ enum {
 	SMC_NLA_LGR_R_NET_COOKIE,	/* u64 */
 	SMC_NLA_LGR_R_PAD,		/* flag */
 	SMC_NLA_LGR_R_BUF_TYPE,		/* u8 */
+	SMC_NLA_LGR_R_SNDBUF_ALLOC,	/* u64 */
+	SMC_NLA_LGR_R_RMB_ALLOC,	/* u64 */
 	__SMC_NLA_LGR_R_MAX,
 	SMC_NLA_LGR_R_MAX = __SMC_NLA_LGR_R_MAX - 1
 };
@@ -162,6 +164,8 @@ enum {
 	SMC_NLA_LGR_D_V2_COMMON,	/* nest */
 	SMC_NLA_LGR_D_EXT_GID,		/* u64 */
 	SMC_NLA_LGR_D_PEER_EXT_GID,	/* u64 */
+	SMC_NLA_LGR_D_SNDBUF_ALLOC,	/* u64 */
+	SMC_NLA_LGR_D_DMB_ALLOC,	/* u64 */
 	__SMC_NLA_LGR_D_MAX,
 	SMC_NLA_LGR_D_MAX = __SMC_NLA_LGR_D_MAX - 1
 };
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 71fb334d8234..73c7999fc74f 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -221,6 +221,37 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	write_unlock_bh(&lgr->conns_lock);
 }
 
+/* must be called under lgr->{sndbufs|rmbs} lock */
+static inline void smc_lgr_buf_list_add(struct smc_link_group *lgr,
+					bool is_rmb,
+					struct list_head *buf_list,
+					struct smc_buf_desc *buf_desc)
+{
+	list_add(&buf_desc->list, buf_list);
+	if (is_rmb) {
+		lgr->alloc_rmbs += buf_desc->len;
+		lgr->alloc_rmbs +=
+			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
+	} else {
+		lgr->alloc_sndbufs += buf_desc->len;
+	}
+}
+
+/* must be called under lgr->{sndbufs|rmbs} lock */
+static inline void smc_lgr_buf_list_del(struct smc_link_group *lgr,
+					bool is_rmb,
+					struct smc_buf_desc *buf_desc)
+{
+	list_del(&buf_desc->list);
+	if (is_rmb) {
+		lgr->alloc_rmbs -= buf_desc->len;
+		lgr->alloc_rmbs -=
+			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
+	} else {
+		lgr->alloc_sndbufs -= buf_desc->len;
+	}
+}
+
 int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
@@ -363,6 +394,12 @@ static int smc_nl_fill_lgr(struct smc_link_group *lgr,
 	smc_target[SMC_MAX_PNETID_LEN] = 0;
 	if (nla_put_string(skb, SMC_NLA_LGR_R_PNETID, smc_target))
 		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC,
+			      lgr->alloc_sndbufs, SMC_NLA_LGR_R_PAD))
+		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_R_RMB_ALLOC,
+			      lgr->alloc_rmbs, SMC_NLA_LGR_R_PAD))
+		goto errattr;
 	if (lgr->smc_version > SMC_V1) {
 		v2_attrs = nla_nest_start(skb, SMC_NLA_LGR_R_V2_COMMON);
 		if (!v2_attrs)
@@ -541,6 +578,12 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 		goto errattr;
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_CHID, smc_ism_get_chid(lgr->smcd)))
 		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_SNDBUF_ALLOC,
+			      lgr->alloc_sndbufs, SMC_NLA_LGR_D_PAD))
+		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_DMB_ALLOC,
+			      lgr->alloc_rmbs, SMC_NLA_LGR_D_PAD))
+		goto errattr;
 	memcpy(smc_pnet, lgr->smcd->pnetid, SMC_MAX_PNETID_LEN);
 	smc_pnet[SMC_MAX_PNETID_LEN] = 0;
 	if (nla_put_string(skb, SMC_NLA_LGR_D_PNETID, smc_pnet))
@@ -1138,7 +1181,7 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		lock = is_rmb ? &lgr->rmbs_lock :
 				&lgr->sndbufs_lock;
 		down_write(lock);
-		list_del(&buf_desc->list);
+		smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
 		up_write(lock);
 
 		smc_buf_free(lgr, is_rmb, buf_desc);
@@ -1377,7 +1420,7 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 			buf_list = &lgr->sndbufs[i];
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
-			list_del(&buf_desc->list);
+			smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
 			smc_buf_free(lgr, is_rmb, buf_desc);
 		}
 	}
@@ -2414,7 +2457,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
 		buf_desc->used = 1;
 		down_write(lock);
-		list_add(&buf_desc->list, buf_list);
+		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
 		up_write(lock);
 		break; /* found */
 	}
@@ -2496,7 +2539,8 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	rc = __smc_buf_create(smc, is_smcd, true);
 	if (rc && smc->conn.sndbuf_desc) {
 		down_write(&smc->conn.lgr->sndbufs_lock);
-		list_del(&smc->conn.sndbuf_desc->list);
+		smc_lgr_buf_list_del(smc->conn.lgr, false,
+				     smc->conn.sndbuf_desc);
 		up_write(&smc->conn.lgr->sndbufs_lock);
 		smc_buf_free(smc->conn.lgr, false, smc->conn.sndbuf_desc);
 		smc->conn.sndbuf_desc = NULL;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d93cf51dbd7c..0db4e5f79ac4 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -281,6 +281,8 @@ struct smc_link_group {
 	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
 	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
+	u64			alloc_sndbufs;	/* stats of tx buffers */
+	u64			alloc_rmbs;	/* stats of rx buffers */
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
-- 
2.32.0.3.g01195cf9f


