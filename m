Return-Path: <netdev+bounces-240852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5CC7B3E1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2CA3A2423
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9A238159;
	Fri, 21 Nov 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CM6MW+NP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B12E7F29
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748773; cv=none; b=iMCzYGj+DA+C6+XaYEDJfwPGREE+wJRodlegb0BTOom2m8wpZHLHwKOoCMFZlL47G4Fb1+qnZa3D1tY7dEFTdVmaHg8eHXDftwES7tdgmjEmd4Kn3KrxEIIcWvoRs3p5MmZdBXpt1fA+KMXPOkljckJPV/TW0uBDcYrAN6TI1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748773; c=relaxed/simple;
	bh=V2rl29mqriwhAnlsHjtzcu3GsnqXlReDtL/8tOgyfhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzK6IKzW5BoBP0kXk5n3d1ytrvWNjcN7woRrN3S+TJBH+J0tvbH3qPjZUKJaTVsuks7UdVgRgV5Jelto1q1lFx7+BrD6kCOLWOvtUoa7FRp4hlfOr5s0RHwxrqZTVAJLZuM2xGA2++vRHiaDgQgouxWEGv/PloOHWi2Kv+Bxg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CM6MW+NP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgl6R022356;
	Fri, 21 Nov 2025 18:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=kYX1Gk4dES8tof6Kf6Gh9UwnN5dCo
	8P7bdBZeloEg3g=; b=CM6MW+NPbBn9Yn7xif9fp0putZBRCbW+AaiYhx2cIQzXz
	p2phunl19bPgJBo88d3Dv+fDVC93XaQQrnVOYkWGKZ/L3ypL5z0tOaT3IOO1E4ns
	qWNb939bcAubhpz5cgoOQQdcGbSRKMy0cM2kpE4URPJufCjv5Ema9akh2Ru5ab5J
	V8XgZExWVtLJF8uTNzDws/T5LrnqI3jHAmp/b3IPIrfKyMfpGub9A90X1ITMDL3X
	fl2m+bZsGYbe9eTtRLYLnzr9Ik9nWKu0m6CxOQ/Xc38YbJJflVa1aAgtKtOE1jYi
	clfXfSi/9o8NManqPeFp1hO2ymoJfQPYZ+3T/CfGA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbmf7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:12:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALHjPvh040560;
	Fri, 21 Nov 2025 18:12:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyr9eqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:12:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ALICYod002160;
	Fri, 21 Nov 2025 18:12:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-241.vpn.oracle.com [10.154.61.241])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefyr9epe-1;
	Fri, 21 Nov 2025 18:12:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: bharat@chelsio.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
        gustavoars@kernel.org, hariprasad@chelsio.com,
        rahul.lakkireddy@chelsio.com, netdev@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH net] cxgb4: Rename sched_class to avoid type clash
Date: Fri, 21 Nov 2025 18:12:31 +0000
Message-ID: <20251121181231.64337-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210136
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=6920ab93 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=N54-gffFAAAA:8
 a=yPCof4ZbAAAA:8 a=qtLb9DiJaHN4ZRJ1sf0A:9 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: _M4IMzHmuEFjFtOqd08rvrhFAWsZ-kMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2Hi0LG4oHT92
 GNCDJ0I7nMlcFHrxr3MarXPxA0BuuCGxz7TiSsCO+giobxzf57j8Nu2Iyku0i2m+i7dT4knqd9d
 5Ci27/aA/niUBWmLeQR0x7PtrdS43/iw8tp8nZA/Uc0fZk2xMFZgxfqkNFBDEfPHyj67ZEJkAuF
 YCQn49GSpNX1LPezZHjghR+KroEHOaafMBSgVRd178B45/X2WI+VwCZHqmYab+D1B8Ppr/JjDUg
 7KyuACWe6zD0Y7Gn8ofT7Vq8d5J5jWDh3Jth4uFDQNv/RSLB+EEHsh8yRLE4kcCXQGamhp/yxYX
 IZQfSvhbgpIhT25TDxGGjVOhw7LGwVRjFKSKKXssYUAT4QTGWD4DVHldtCU+nQfW8ERSZZ0v2KT
 elgmiI7iEddnoUVwVBVAvcpyhtfRLVpuMsof1i06zeA91Ve47u4=
X-Proofpoint-GUID: _M4IMzHmuEFjFtOqd08rvrhFAWsZ-kMc

drivers/net/ethernet/chelsio/cxgb4/sched.h declares a sched_class
struct which has a type name clash with struct sched_class
in kernel/sched/sched.h (a type used in a field in task_struct).

When cxgb4 is a builtin we end up with both sched_class types,
and as a result of this we wind up with DWARF (and derived from
that BTF) with a duplicate incorrect task_struct representation.
When cxgb4 is built-in this type clash can cause kernel builds to
fail as resolve_btfids will fail when confused which task_struct
to use. See [1] for more details.

As such, renaming sched_class to ch_sched_class (in line with
other structs like ch_sched_flowc) makes sense.

[1] https://lore.kernel.org/bpf/2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org/

Fixes: b72a32dacdfa ("cxgb4: add support for tx traffic scheduling classes")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../chelsio/cxgb4/cxgb4_tc_matchall.c         |  4 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.c    | 44 +++++++++----------
 drivers/net/ethernet/chelsio/cxgb4/sched.h    | 12 ++---
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 392723ef14e5..ac0c7fe5743b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3485,7 +3485,7 @@ static int cxgb_set_tx_maxrate(struct net_device *dev, int index, u32 rate)
 	struct adapter *adap = pi->adapter;
 	struct ch_sched_queue qe = { 0 };
 	struct ch_sched_params p = { 0 };
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	u32 req_rate;
 	int err = 0;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
index 1672d3afe5be..f8dcf0b4abcd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
@@ -56,7 +56,7 @@ static int cxgb4_matchall_egress_validate(struct net_device *dev,
 	struct port_info *pi = netdev2pinfo(dev);
 	struct flow_action_entry *entry;
 	struct ch_sched_queue qe;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	u64 max_link_rate;
 	u32 i, speed;
 	int ret;
@@ -180,7 +180,7 @@ static int cxgb4_matchall_alloc_tc(struct net_device *dev,
 	struct port_info *pi = netdev2pinfo(dev);
 	struct adapter *adap = netdev2adap(dev);
 	struct flow_action_entry *entry;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int ret;
 	u32 i;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
index 338b04f339b3..a2dcd2e24263 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
@@ -330,7 +330,7 @@ static int cxgb4_mqprio_alloc_tc(struct net_device *dev,
 	struct cxgb4_tc_port_mqprio *tc_port_mqprio;
 	struct port_info *pi = netdev2pinfo(dev);
 	struct adapter *adap = netdev2adap(dev);
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int ret;
 	u8 i;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.c b/drivers/net/ethernet/chelsio/cxgb4/sched.c
index a1b14468d1ff..38a30aeee122 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.c
@@ -44,7 +44,7 @@ static int t4_sched_class_fw_cmd(struct port_info *pi,
 {
 	struct adapter *adap = pi->adapter;
 	struct sched_table *s = pi->sched_tbl;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	e = &s->tab[p->u.params.class];
@@ -122,7 +122,7 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
 				   const u32 val)
 {
 	struct sched_table *s = pi->sched_tbl;
-	struct sched_class *e, *end;
+	struct ch_sched_class *e, *end;
 	void *found = NULL;
 
 	/* Look for an entry with matching @val */
@@ -166,8 +166,8 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
 	return found;
 }
 
-struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
-					     struct ch_sched_queue *p)
+struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
+						struct ch_sched_queue *p)
 {
 	struct port_info *pi = netdev2pinfo(dev);
 	struct sched_queue_entry *qe = NULL;
@@ -187,7 +187,7 @@ static int t4_sched_queue_unbind(struct port_info *pi, struct ch_sched_queue *p)
 	struct sched_queue_entry *qe = NULL;
 	struct adapter *adap = pi->adapter;
 	struct sge_eth_txq *txq;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	if (p->queue < 0 || p->queue >= pi->nqsets)
@@ -218,7 +218,7 @@ static int t4_sched_queue_bind(struct port_info *pi, struct ch_sched_queue *p)
 	struct sched_queue_entry *qe = NULL;
 	struct adapter *adap = pi->adapter;
 	struct sge_eth_txq *txq;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	unsigned int qid;
 	int err = 0;
 
@@ -260,7 +260,7 @@ static int t4_sched_flowc_unbind(struct port_info *pi, struct ch_sched_flowc *p)
 {
 	struct sched_flowc_entry *fe = NULL;
 	struct adapter *adap = pi->adapter;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	if (p->tid < 0 || p->tid >= adap->tids.neotids)
@@ -288,7 +288,7 @@ static int t4_sched_flowc_bind(struct port_info *pi, struct ch_sched_flowc *p)
 	struct sched_table *s = pi->sched_tbl;
 	struct sched_flowc_entry *fe = NULL;
 	struct adapter *adap = pi->adapter;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	int err = 0;
 
 	if (p->tid < 0 || p->tid >= adap->tids.neotids)
@@ -322,7 +322,7 @@ static int t4_sched_flowc_bind(struct port_info *pi, struct ch_sched_flowc *p)
 }
 
 static void t4_sched_class_unbind_all(struct port_info *pi,
-				      struct sched_class *e,
+				      struct ch_sched_class *e,
 				      enum sched_bind_type type)
 {
 	if (!e)
@@ -476,12 +476,12 @@ int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
 }
 
 /* If @p is NULL, fetch any available unused class */
-static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
-						const struct ch_sched_params *p)
+static struct ch_sched_class *t4_sched_class_lookup(struct port_info *pi,
+						    const struct ch_sched_params *p)
 {
 	struct sched_table *s = pi->sched_tbl;
-	struct sched_class *found = NULL;
-	struct sched_class *e, *end;
+	struct ch_sched_class *found = NULL;
+	struct ch_sched_class *e, *end;
 
 	if (!p) {
 		/* Get any available unused class */
@@ -522,10 +522,10 @@ static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
 	return found;
 }
 
-static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
-						struct ch_sched_params *p)
+static struct ch_sched_class *t4_sched_class_alloc(struct port_info *pi,
+						   struct ch_sched_params *p)
 {
-	struct sched_class *e = NULL;
+	struct ch_sched_class *e = NULL;
 	u8 class_id;
 	int err;
 
@@ -579,8 +579,8 @@ static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
  * scheduling class with matching @p is found, then the matching class is
  * returned.
  */
-struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
-					    struct ch_sched_params *p)
+struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
+					       struct ch_sched_params *p)
 {
 	struct port_info *pi = netdev2pinfo(dev);
 	u8 class_id;
@@ -607,7 +607,7 @@ void cxgb4_sched_class_free(struct net_device *dev, u8 classid)
 	struct port_info *pi = netdev2pinfo(dev);
 	struct sched_table *s = pi->sched_tbl;
 	struct ch_sched_params p;
-	struct sched_class *e;
+	struct ch_sched_class *e;
 	u32 speed;
 	int ret;
 
@@ -640,7 +640,7 @@ void cxgb4_sched_class_free(struct net_device *dev, u8 classid)
 	}
 }
 
-static void t4_sched_class_free(struct net_device *dev, struct sched_class *e)
+static void t4_sched_class_free(struct net_device *dev, struct ch_sched_class *e)
 {
 	struct port_info *pi = netdev2pinfo(dev);
 
@@ -660,7 +660,7 @@ struct sched_table *t4_init_sched(unsigned int sched_size)
 	s->sched_size = sched_size;
 
 	for (i = 0; i < s->sched_size; i++) {
-		memset(&s->tab[i], 0, sizeof(struct sched_class));
+		memset(&s->tab[i], 0, sizeof(struct ch_sched_class));
 		s->tab[i].idx = i;
 		s->tab[i].state = SCHED_STATE_UNUSED;
 		INIT_LIST_HEAD(&s->tab[i].entry_list);
@@ -682,7 +682,7 @@ void t4_cleanup_sched(struct adapter *adap)
 			continue;
 
 		for (i = 0; i < s->sched_size; i++) {
-			struct sched_class *e;
+			struct ch_sched_class *e;
 
 			e = &s->tab[i];
 			if (e->state == SCHED_STATE_ACTIVE)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.h b/drivers/net/ethernet/chelsio/cxgb4/sched.h
index 6b3c778815f0..4d3b5a757536 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.h
@@ -71,7 +71,7 @@ struct sched_flowc_entry {
 	struct ch_sched_flowc param;
 };
 
-struct sched_class {
+struct ch_sched_class {
 	u8 state;
 	u8 idx;
 	struct ch_sched_params info;
@@ -82,7 +82,7 @@ struct sched_class {
 
 struct sched_table {      /* per port scheduling table */
 	u8 sched_size;
-	struct sched_class tab[] __counted_by(sched_size);
+	struct ch_sched_class tab[] __counted_by(sched_size);
 };
 
 static inline bool can_sched(struct net_device *dev)
@@ -103,15 +103,15 @@ static inline bool valid_class_id(struct net_device *dev, u8 class_id)
 	return true;
 }
 
-struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
-					     struct ch_sched_queue *p);
+struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
+						struct ch_sched_queue *p);
 int cxgb4_sched_class_bind(struct net_device *dev, void *arg,
 			   enum sched_bind_type type);
 int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
 			     enum sched_bind_type type);
 
-struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
-					    struct ch_sched_params *p);
+struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
+					       struct ch_sched_params *p);
 void cxgb4_sched_class_free(struct net_device *dev, u8 classid);
 
 struct sched_table *t4_init_sched(unsigned int size);
-- 
2.39.3


