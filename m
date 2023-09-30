Return-Path: <netdev+bounces-37175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952EA7B40FB
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D3CE42827AC
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE12DF68;
	Sat, 30 Sep 2023 14:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6908156F8
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:16 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E4F9
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:12 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65b0557ec77so68469146d6.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084571; x=1696689371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCu8RcWKOWQ8Yntc0tHGGTX1X7lBOz4kMGRqoLeV1sQ=;
        b=E2i8bSFlPCJik5Ky/FeIguUteDhvPStDx0iG8GU8AKaAOOTyKLZgcyZJVuejfC31xB
         zGkdgfcGgBNEVupIJRDok+DNzj5r+SeMVLwzS9DjtX+5n3W9JSSXcci3Dw7ofgofV4yS
         MrSOMqpYEP/peCz76JiKk05qJiQYoy/Ukm8VjV6SBZrg1HG5CWSqSzTMGmrFhsvbNlGP
         +fkhPgjDpfQ8QEMWZ82xnc+S09ho5pgmrlDagKkhRi6/CLYbA/LzxV0Hnv/HZ8SMKyTr
         +kUyxAoX43PZoOSvIcBb6xR6bV1TNFjBUlYxu4iyjdk7YmPDhSRKSMTclWgkvXRIsfg2
         uAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084571; x=1696689371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCu8RcWKOWQ8Yntc0tHGGTX1X7lBOz4kMGRqoLeV1sQ=;
        b=YfxGA4covefUVbQwMPOu0q4JN40we0NzjqLwQFulx4uH2fH6lIAcuN4/POn6riOabv
         yW/eBvHEr5vDfw/WN1Tf8phJIgI1/FQo+bSsv1FMaQDHgbSgd59s77xIyRhXvKJlvxwN
         tqFlzAxSXOOyi0VfqshCAQA3pZkEJM7m4ec5loYCIx3QbsQUiPIwrvzhVauVg1+5cy+u
         Cq+EljTLEkgsm6X1fU550TraTqZCDjM5zpdnx/tVtYEQUrf2lmkEyYw9ZgH5bJgrwnFp
         XAWRfAF+wvdC4ipthG8NCDjDY6gBJx2nm7KNEnr+Bw5gDrId3rghBeBJL756K4WGszim
         OfXg==
X-Gm-Message-State: AOJu0YzqucP6YO6MNPkp4Ir+36EbQwhcVttIJuRyKHCtObbBi3ZrSkZw
	J/dEVuBR0g199Qe66l3VgmyZaKU3oGtSnoYsnjE=
X-Google-Smtp-Source: AGHT+IHkoNg2SXgikTGUs4eW5FwN6xGoJXZVdCz+mAftKURM7tvs/y0AV6SS4IfBeUTK27MxKPVNJg==
X-Received: by 2002:a05:6214:3d0a:b0:658:2857:ed69 with SMTP id ol10-20020a0562143d0a00b006582857ed69mr8099640qvb.1.1696084571135;
        Sat, 30 Sep 2023 07:36:11 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:36:10 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 14/17] p4tc: add set of P4TC table kfuncs
Date: Sat, 30 Sep 2023 10:35:39 -0400
Message-Id: <20230930143542.101000-15-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We add an initial set of kfuncs to allow interactions from eBPF programs
to the P4TC domain.

- bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in TC. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use the skb to get the network namespace structure where all the
pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in XDP. To find the table entry we take in an xdp_md,
the pipeline ID, the table ID, a key and a key size.
We use struct xdp_md to get the network namespace structure where all
the pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- bpf_p4tc_entry_create: Used to create a table entry from a BPF
program installed in TC. To create the table entry we take an skb, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_create: Used to create a table entry from a BPF
program installed in XDP. To create the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
First does a lookup using the passed key and upon a miss will add the entry
to the table.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
First does a lookup using the passed key and upon a miss will add the entry
to the table.
We return 0 on success and a negative errno on failure

- bpf_p4tc_entry_update: Used to update a table entry from a BPF
program installed in TC. To update the table entry we take an skb, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_update: Used to update a table entry from a BPF
program installed in XDP. To update the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
program installed in TC. To delete the table entry we take an skb, the
pipeline ID, the table ID, a key and a key size.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
program installed in XDP. To delete the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and a key size.
We return 0 on success and a negative errno on failure

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  58 +++++-
 include/net/tc_act/p4tc.h       |  25 +++
 include/uapi/linux/p4tc.h       |   6 +-
 net/sched/Kconfig               |   1 +
 net/sched/p4tc/Makefile         |   2 +-
 net/sched/p4tc/p4tc_action.c    |  78 +++++++-
 net/sched/p4tc/p4tc_bpf.c       | 311 ++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  43 +++++
 net/sched/p4tc/p4tc_table.c     |   8 +
 net/sched/p4tc/p4tc_tbl_entry.c | 282 ++++++++++++++++++++++++++++-
 net/sched/p4tc/p4tc_tmpl_api.c  |   2 +
 12 files changed, 802 insertions(+), 15 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_bpf.c

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e06..290c2399a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -19,6 +19,7 @@
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_U16(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u16))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 649741e57..0e6e048ec 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -92,8 +92,26 @@ struct p4tc_pipeline {
 	u8                          p_state;
 };
 
+#define P4TC_PIPELINE_MAX_ARRAY 32
+
+struct p4tc_table;
+
+struct p4tc_tbl_cache_key {
+	u32 pipeid;
+	u32 tblid;
+};
+
+extern const struct rhashtable_params tbl_cache_ht_params;
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid, struct p4tc_table *table);
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table);
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid, u32 tblid);
+
+#define P4TC_TBLS_CACHE_SIZE 32
+
 struct p4tc_pipeline_net {
-	struct idr pipeline_idr;
+	struct list_head  tbls_cache[P4TC_TBLS_CACHE_SIZE];
+	struct idr        pipeline_idr;
 };
 
 static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
@@ -199,6 +217,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_idr;
@@ -281,6 +300,17 @@ extern const struct p4tc_template_ops p4tc_act_ops;
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
+struct p4tc_table_entry_create_bpf_params {
+	u64 aging_ms;
+	u32 pipeid;
+	u32 tblid;
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -302,6 +332,7 @@ struct p4tc_table_entry_value {
 	u32                              prio;
 	int                              num_acts;
 	struct tc_action                 **acts;
+	struct p4tc_table_entry_act_bpf  *act_bpf;
 	refcount_t                       entries_ref;
 	u32                              permissions;
 	struct p4tc_table_entry_tm __rcu *tm;
@@ -327,6 +358,13 @@ struct p4tc_table_entry {
 	/* fallthrough: key data + value */
 };
 
+struct p4tc_entry_key_bpf {
+	void *key;
+	void *mask;
+	u32 key_sz;
+	u32 mask_sz;
+};
+
 #define P4TC_KEYSZ_BYTES(bits) (round_up(BITS_TO_BYTES(bits), 8))
 
 #define ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
@@ -355,6 +393,24 @@ struct p4tc_table_entry *
 p4tc_table_entry_lookup_direct(struct p4tc_table *table,
 			       struct p4tc_table_entry_key *key);
 
+struct p4tc_table_entry_act_bpf *
+p4tc_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack);
+int register_p4tc_tbl_bpf(void);
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms);
+int p4tc_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+			       struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key,
+			       struct p4tc_table_entry_act_bpf *act_bpf,
+			       u64 aging_ms);
+
+int p4tc_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			    struct p4tc_table *table,
+			    struct p4tc_table_entry_key *key);
 struct p4tc_parser {
 	char parser_name[PARSERNAMSIZ];
 	struct idr hdrfield_idr;
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
index 6b4666972..08e074b7f 100644
--- a/include/net/tc_act/p4tc.h
+++ b/include/net/tc_act/p4tc.h
@@ -13,15 +13,40 @@ struct tcf_p4act_params {
 	u32 num_params;
 	u32 tot_params_sz;
 };
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
+struct p4tc_table_entry_act_bpf {
+	u32 act_id;
+	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
+} __packed;
+
+struct p4tc_table_entry_act_bpf_kern {
+	struct rcu_head rcu;
+	struct p4tc_table_entry_act_bpf act_bpf;
+} __packed;
+
 
 struct tcf_p4act {
 	struct tc_action common;
 	/* Params IDR reference passed during runtime */
 	struct tcf_p4act_params __rcu *params;
+	struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
 	u32 p_id;
 	u32 act_id;
 	struct list_head node;
 };
+
 #define to_p4act(a) ((struct tcf_p4act *)a)
 
+static inline struct p4tc_table_entry_act_bpf *
+p4tc_table_entry_act_bpf(struct tc_action *action)
+{
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
+	struct tcf_p4act *p4act = to_p4act(action);
+
+	act_bpf = rcu_dereference(p4act->act_bpf);
+
+	return &act_bpf->act_bpf;
+}
+
 #endif /* __NET_TC_ACT_P4_H */
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 1b54c9f02..80a0c1234 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -17,6 +17,8 @@ struct p4tcmsg {
 #define P4TC_MINTABLES_COUNT 0
 #define P4TC_MSGBATCH_SIZE 16
 
+#define P4TC_ACT_MAX_NUM_PARAMS P4TC_MSGBATCH_SIZE
+
 #define P4TC_MAX_KEYSZ 512
 #define HEADER_MAX_LEN 512
 #define P4TC_DEFAULT_NUM_PREALLOC 16
@@ -77,7 +79,7 @@ enum {
 #define p4tc_ctrl_exec_ok(perm)     (perm & P4TC_CTRL_PERM_X)
 
 #define p4tc_ctrl_perm_rm_create(perm) \
-	((perm & ~P4TC_CTRL_PERM_C_BIT))
+	((perm & ~P4TC_CTRL_PERM_C))
 
 #define p4tc_data_create_ok(perm)   (perm & P4TC_DATA_PERM_C)
 #define p4tc_data_read_ok(perm)     (perm & P4TC_DATA_PERM_R)
@@ -86,7 +88,7 @@ enum {
 #define p4tc_data_exec_ok(perm)     (perm & P4TC_DATA_PERM_X)
 
 #define p4tc_data_perm_rm_create(perm) \
-	((perm & ~P4TC_DATA_PERM_C_BIT))
+	((perm & ~P4TC_DATA_PERM_C))
 
 struct p4tc_table_parm {
 	__u64 tbl_aging;
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index df6d5e15f..44bc1a703 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -677,6 +677,7 @@ config NET_EMATCH_IPT
 
 config NET_P4_TC
 	bool "P4 TC support"
+	depends on DEBUG_INFO_BTF
 	select NET_CLS_ACT
 	help
 	  Say Y here if you want to use P4 features on top of TC.
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index c9e2555a8..161a515ad 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -2,4 +2,4 @@
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
 	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o \
-	p4tc_tbl_entry.o p4tc_runtime_api.o
+	p4tc_tbl_entry.o p4tc_runtime_api.o p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index cac1b821f..1f5e9c461 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -28,6 +28,7 @@
 #include <net/p4tc.h>
 #include <net/sch_generic.h>
 #include <net/sock.h>
+
 #include <net/tc_act/p4tc.h>
 
 static LIST_HEAD(dynact_list);
@@ -286,29 +287,83 @@ static void tcf_p4_act_params_destroy_rcu(struct rcu_head *head)
 	tcf_p4_act_params_destroy(params);
 }
 
+static struct p4tc_table_entry_act_bpf_kern *
+p4tc_create_act_bpf(struct tcf_p4act *p4act,
+		    struct tcf_p4act_params *act_params,
+		    struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_ACT_MAX_NUM_PARAMS];
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	size_t tot_params_sz = 0;
+	u8 *params_cursor;
+	int nparams = 0;
+	int i;
+
+	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
+	if (!act_bpf)
+		return ERR_PTR(-ENOMEM);
+
+	idr_for_each_entry_ul(&act_params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+
+		if (tot_params_sz > P4TC_MAX_PARAM_DATA_SIZE) {
+			NL_SET_ERR_MSG(extack, "Maximum parameter byte size reached");
+			kfree(act_bpf);
+			return ERR_PTR(-EINVAL);
+		}
+
+		tot_params_sz += BITS_TO_BYTES(type->container_bitsz);
+		params[nparams++] = param;
+	}
+
+	act_bpf->act_bpf.act_id = p4act->act_id;
+	params_cursor = act_bpf->act_bpf.params;
+	for (i = 0; i < nparams; i++) {
+		const struct p4tc_act_param *param = params[i];
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memcpy(params_cursor, param->value, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	return act_bpf;
+}
+
 static int __tcf_p4_dyna_init_set(struct p4tc_act *act, struct tc_action **a,
 				  struct tcf_p4act_params *params,
 				  struct tcf_chain *goto_ch,
 				  struct tc_act_dyna *parm, bool exists,
 				  struct netlink_ext_ack *extack)
 {
+	struct p4tc_table_entry_act_bpf_kern *act_bpf = NULL, *act_bpf_old;
 	struct tcf_p4act_params *params_old;
 	struct tcf_p4act *p;
 
 	p = to_p4act(*a);
 
+	if (!((*a)->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)) {
+		act_bpf = p4tc_create_act_bpf(p, params, extack);
+		if (IS_ERR(act_bpf))
+			return PTR_ERR(act_bpf);
+	}
+
 	/* sparse is fooled by lock under conditionals.
-	 * To avoid false positives, we are repeating these two lines in both
+	 * To avoid false positives, we are repeating these 3 lines in both
 	 * branches of the if-statement
 	 */
 	if (exists) {
 		spin_lock_bh(&p->tcf_lock);
 		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 		params_old = rcu_replace_pointer(p->params, params, 1);
+		act_bpf_old = rcu_replace_pointer(p->act_bpf, act_bpf, 1);
 		spin_unlock_bh(&p->tcf_lock);
 	} else {
 		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 		params_old = rcu_replace_pointer(p->params, params, 1);
+		act_bpf_old = rcu_replace_pointer(p->act_bpf, act_bpf, 1);
 	}
 
 	if (goto_ch)
@@ -317,6 +372,9 @@ static int __tcf_p4_dyna_init_set(struct p4tc_act *act, struct tc_action **a,
 	if (params_old)
 		call_rcu(&params_old->rcu, tcf_p4_act_params_destroy_rcu);
 
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	return 0;
 }
 
@@ -495,7 +553,7 @@ tcf_p4_get_next_prealloc_act(struct p4tc_act *act)
 {
 	struct tcf_p4act *p4_act;
 
-	spin_lock(&act->list_lock);
+	spin_lock_bh(&act->list_lock);
 	p4_act = list_first_entry_or_null(&act->prealloc_list, struct tcf_p4act,
 					  node);
 	if (p4_act) {
@@ -503,7 +561,7 @@ tcf_p4_get_next_prealloc_act(struct p4tc_act *act)
 		refcount_set(&p4_act->common.tcfa_refcnt, 1);
 		atomic_set(&p4_act->common.tcfa_bindcnt, 1);
 	}
-	spin_unlock(&act->list_lock);
+	spin_unlock_bh(&act->list_lock);
 
 	return p4_act;
 }
@@ -519,6 +577,7 @@ void tcf_p4_set_init_flags(struct tcf_p4act *p4act)
 static void __tcf_p4_put_prealloc_act(struct p4tc_act *act,
 				      struct tcf_p4act *p4act)
 {
+	struct p4tc_table_entry_act_bpf_kern *act_bpf_old;
 	struct p4tc_act_param *param;
 	unsigned long param_id, tmp;
 
@@ -533,9 +592,13 @@ static void __tcf_p4_put_prealloc_act(struct p4tc_act *act,
 	}
 	p4act->common.tcfa_flags |= TCA_ACT_FLAGS_UNREFERENCED;
 
-	spin_lock(&act->list_lock);
+	act_bpf_old = rcu_replace_pointer(p4act->act_bpf, NULL, 1);
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
+	spin_lock_bh(&act->list_lock);
 	list_add_tail(&p4act->node, &act->prealloc_list);
-	spin_unlock(&act->list_lock);
+	spin_unlock_bh(&act->list_lock);
 }
 
 void
@@ -1269,16 +1332,21 @@ static int tcf_p4_dyna_walker(struct net *net, struct sk_buff *skb,
 static void tcf_p4_dyna_cleanup(struct tc_action *a)
 {
 	struct tc_action_ops *ops = (struct tc_action_ops *)a->ops;
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
 	struct tcf_p4act *m = to_p4act(a);
 	struct tcf_p4act_params *params;
 
 	params = rcu_dereference_protected(m->params, 1);
+	act_bpf = rcu_dereference_protected(m->act_bpf, 1);
 
 	if (refcount_read(&ops->dyn_ref) > 1)
 		refcount_dec(&ops->dyn_ref);
 
 	if (params)
 		call_rcu(&params->rcu, tcf_p4_act_params_destroy_rcu);
+
+	if (act_bpf)
+		kfree_rcu(act_bpf, rcu);
 }
 
 static struct p4tc_act *
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
new file mode 100644
index 000000000..9c47f562e
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/filter.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/btf_ids.h>
+#include <linux/net_namespace.h>
+#include <net/p4tc.h>
+#include <linux/netdevice.h>
+#include <net/sock.h>
+#include <linux/filter.h>
+#include <net/xdp.h>
+
+BTF_ID_LIST(btf_p4tc_ids)
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_act_bpf_params)
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_create_bpf_params)
+
+static struct p4tc_table_entry_act_bpf *
+__bpf_p4tc_tbl_read(struct net *caller_net,
+		    struct p4tc_table_entry_act_bpf_params *params,
+		    void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_table_entry_value *value;
+	const u32 pipeid = params->pipeid;
+	const u32 tblid = params->tblid;
+	struct p4tc_table_entry *entry;
+	struct p4tc_table *table;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	table = p4tc_tbl_cache_lookup(caller_net, pipeid, tblid);
+	if (!table)
+		return NULL;
+
+	entry = p4tc_table_entry_lookup_direct(table, entry_key);
+	if (!entry) {
+		struct p4tc_table_defact *defact;
+
+		defact = rcu_dereference(table->tbl_default_missact);
+		return defact ?
+			p4tc_table_entry_act_bpf(defact->default_acts[0]) : NULL;
+	}
+
+	value = p4tc_table_entry_value(entry);
+
+	return value->acts ? p4tc_table_entry_act_bpf(value->acts[0]) : NULL;
+}
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc struct p4tc_table_entry_act_bpf *
+bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,
+		  struct p4tc_table_entry_act_bpf_params *params,
+		  void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *caller_net;
+
+	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+__bpf_kfunc struct p4tc_table_entry_act_bpf *
+xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
+		  struct p4tc_table_entry_act_bpf_params *params,
+		  void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *caller_net;
+
+	caller_net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+static int
+__bpf_p4tc_entry_create(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz,
+			struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	return p4tc_table_entry_create_bpf(pipeline, table, key, act_bpf,
+					   params->aging_ms);
+}
+
+__bpf_kfunc int
+bpf_p4tc_entry_create(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc int
+xdp_p4tc_entry_create(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc int
+bpf_p4tc_entry_create_on_miss(struct __sk_buff *skb_ctx,
+			      struct p4tc_table_entry_create_bpf_params *params,
+			      void *key, const u32 key__sz,
+			      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc int
+xdp_p4tc_entry_create_on_miss(struct xdp_md *xdp_ctx,
+			      struct p4tc_table_entry_create_bpf_params *params,
+			      void *key, const u32 key__sz,
+			      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_update(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz,
+			struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	return p4tc_table_entry_update_bpf(pipeline, table, entry_key,
+					  act_bpf, params->aging_ms);
+}
+
+__bpf_kfunc int
+bpf_p4tc_entry_update(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_update(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc int
+xdp_p4tc_entry_update(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_update(net, params, key, key__sz, act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_delete(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	return p4tc_table_entry_del_bpf(pipeline, table, entry_key);
+}
+
+__bpf_kfunc int
+bpf_p4tc_entry_delete(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
+}
+
+__bpf_kfunc int
+xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
+}
+
+__diag_pop();
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
+BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_skb,
+};
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_xdp)
+BTF_ID_FLAGS(func, xdp_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_create);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_update);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_delete);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_xdp)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_xdp = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_xdp,
+};
+
+int register_p4tc_tbl_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_kfunc_tbl_set_skb);
+	if (ret < 0)
+		return ret;
+
+	/* There is no unregister_btf_kfunc_id_set function */
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &p4tc_kfunc_tbl_set_xdp);
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index c1dca798d..2707c2af4 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -37,6 +37,44 @@ static __net_init int pipeline_init_net(struct net *net)
 
 	idr_init(&pipe_net->pipeline_idr);
 
+	for (int i = 0; i < P4TC_TBLS_CACHE_SIZE; i++)
+		INIT_LIST_HEAD(&pipe_net->tbls_cache[i]);
+
+	return 0;
+}
+
+static inline size_t p4tc_tbl_cache_hash(u32 pipeid, u32 tblid)
+{
+	return (pipeid + tblid) % P4TC_TBLS_CACHE_SIZE;
+}
+
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid, u32 tblid)
+{
+	size_t hash = p4tc_tbl_cache_hash(pipeid, tblid);
+	struct p4tc_pipeline_net *pipe_net;
+	struct p4tc_table *pos, *tmp;
+	struct net_generic *ng;
+
+	/* RCU read lock is already being held */
+	ng = rcu_dereference(net->gen);
+	pipe_net = ng->ptr[pipeline_net_id];
+
+	list_for_each_entry_safe(pos, tmp, &pipe_net->tbls_cache[hash],
+				 tbl_cache_node) {
+		if (pos->common.p_id == pipeid && pos->tbl_id == tblid)
+			return pos;
+	}
+
+	return NULL;
+}
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid, struct p4tc_table *table)
+{
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+	size_t hash = p4tc_tbl_cache_hash(pipeid, table->tbl_id);
+
+	list_add_tail(&table->tbl_cache_node, &pipe_net->tbls_cache[hash]);
+
 	return 0;
 }
 
@@ -44,6 +82,11 @@ static int __p4tc_pipeline_put(struct p4tc_pipeline *pipeline,
 			       struct p4tc_template_common *template,
 			       struct netlink_ext_ack *extack);
 
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table)
+{
+	list_del(&table->tbl_cache_node);
+}
+
 static void __net_exit pipeline_exit_net(struct net *net)
 {
 	struct p4tc_pipeline_net *pipe_net;
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index bc137e5c7..5d603faef 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -364,6 +364,7 @@ static inline int _p4tc_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  p4tc_table_entry_destroy_hash, table);
+	p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_idr);
@@ -1128,6 +1129,10 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 		goto defaultacts_destroy;
 	}
 
+	ret = p4tc_tbl_cache_insert(net, pipeline->common.p_id, table);
+	if (ret < 0)
+		goto entries_hashtable_destroy;
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
@@ -1135,6 +1140,9 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 
 	return table;
 
+entries_hashtable_destroy:
+	rhltable_destroy(&table->tbl_entries);
+
 defaultacts_destroy:
 	p4tc_table_defact_destroy(table->tbl_default_missact);
 	p4tc_table_defact_destroy(table->tbl_default_hitact);
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index 533c455ba..acc4f6ac0 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -702,8 +702,10 @@ static void __p4tc_table_entry_put(struct p4tc_table_entry *entry)
 
 	value = p4tc_table_entry_value(entry);
 
-	if (value->acts)
+	if (value->acts) {
 		p4tc_action_destroy(value->acts);
+		kfree(value->act_bpf);
+	}
 
 	kfree(value->entry_work);
 	tm = rcu_dereference_protected(value->tm, 1);
@@ -1028,6 +1030,48 @@ __must_hold(RCU)
 	return 0;
 }
 
+/* Internal function which will be called by the data path */
+static int __p4tc_table_entry_del(struct p4tc_pipeline *pipeline,
+				  struct p4tc_table *table,
+				  struct p4tc_table_entry_key *key,
+				  struct p4tc_table_entry_mask *mask, u32 prio)
+{
+	struct p4tc_table_entry *entry;
+	int ret;
+
+	p4tc_table_entry_build_key(table, key, mask);
+
+	entry = p4tc_entry_lookup(table, key, prio);
+	if (!entry)
+		return -ENOENT;
+
+	ret = ___p4tc_table_entry_del(pipeline, table, entry, false);
+
+	return ret;
+}
+
+int p4tc_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			     struct p4tc_table *table,
+			     struct p4tc_table_entry_key *key)
+{
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	const u32 keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	const u32 keysz_bits = table->tbl_keysz;
+	struct p4tc_table_entry entry = {0};
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		return -EINVAL;
+
+	if (keysz_bytes != P4TC_KEYSZ_BYTES(key->keysz))
+		return -EINVAL;
+
+	entry.key.keysz = keysz_bits;
+
+	return __p4tc_table_entry_del(pipeline, table, key, mask, 0);
+}
+
 static int p4tc_table_entry_gd(struct net *net, struct sk_buff *skb, bool del,
 			       struct nlattr *arg, u32 *ids,
 			       struct p4tc_nl_pname *nl_pname,
@@ -1302,6 +1346,51 @@ static int p4tc_table_entry_flush(struct net *net, struct sk_buff *skb,
 	return ret;
 }
 
+static int
+p4tc_table_tc_act_from_bpf_act(struct tcf_p4act *p4act,
+			       struct p4tc_table_entry_value *value,
+			       struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_act_bpf_kern *new_act_bpf;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	u8 *params_cursor;
+	int err;
+
+	/* Skip act_id */
+	params_cursor = (u8 *)act_bpf + sizeof(act_bpf->act_id);
+	idr_for_each_entry_ul(&p4act->params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memcpy(param->value, params_cursor, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	new_act_bpf = kzalloc(sizeof(*new_act_bpf), GFP_ATOMIC);
+	if (unlikely(!new_act_bpf))
+		return -ENOMEM;
+
+	value->acts = kcalloc(TCA_ACT_MAX_PRIO, sizeof(struct tc_action *),
+			      GFP_ATOMIC);
+	if (unlikely(!value->acts)) {
+		err = -ENOMEM;
+		goto free_act_bpf;
+	}
+
+	new_act_bpf->act_bpf = *act_bpf;
+
+	rcu_assign_pointer(p4act->act_bpf, new_act_bpf);
+	value->num_acts = 1;
+	value->acts[0] = (struct tc_action *)p4act;
+
+	return 0;
+
+free_act_bpf:
+	kfree(new_act_bpf);
+	return err;
+}
+
 static enum hrtimer_restart entry_timer_handle(struct hrtimer *timer)
 {
 	struct p4tc_table_entry_value *value =
@@ -1463,6 +1552,109 @@ __must_hold(RCU)
 	return ret;
 }
 
+struct p4tc_table_entry_create_state {
+	struct p4tc_act *act;
+	struct tcf_p4act *p4_act;
+	struct p4tc_table_entry *entry;
+	u64 aging_ms;
+	u16 permissions;
+};
+
+static int
+p4tc_table_entry_init_bpf(struct p4tc_pipeline *pipeline,
+			  struct p4tc_table *table, u32 entry_key_sz,
+			  struct p4tc_table_entry_act_bpf *act_bpf,
+			  struct p4tc_table_entry_create_state *state)
+{
+	const u32 keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+	struct p4tc_table_entry_value *entry_value;
+	const u32 keysz_bits = table->tbl_keysz;
+	struct p4tc_table_entry *entry;
+	u32 act_id = act_bpf->act_id;
+	struct tcf_p4act *p4_act;
+	struct p4tc_act *act;
+	int err = -EINVAL;
+	u32 entrysz;
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		goto out;
+
+	if (keysz_bytes != P4TC_KEYSZ_BYTES(entry_key_sz))
+		goto out;
+
+	if (atomic_read(&table->tbl_nelems) + 1 > table->tbl_max_entries)
+		goto out;
+
+	act = p4tc_action_find_get(pipeline, NULL, act_id, NULL);
+	if (!act) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	entrysz = sizeof(*entry) + keysz_bytes +
+		  sizeof(struct p4tc_table_entry_value);
+
+	entry = kzalloc(entrysz, GFP_ATOMIC);
+	if (unlikely(!entry)) {
+		err = -ENOMEM;
+		goto act_put;
+	}
+	entry->key.keysz = keysz_bits;
+
+	entry_value = p4tc_table_entry_value(entry);
+	entry_value->prio = p4tc_table_entry_exact_prio();
+	entry_value->permissions = state->permissions;
+	entry_value->aging_ms = state->aging_ms;
+
+	p4_act = tcf_p4_get_next_prealloc_act(act);
+	if (!p4_act) {
+		err = -ENOENT;
+		goto idr_rm;
+	}
+
+	err = p4tc_table_tc_act_from_bpf_act(p4_act, entry_value, act_bpf);
+	if (err < 0)
+		goto free_prealloc;
+
+	state->act = act;
+	state->p4_act = p4_act;
+	state->entry = entry;
+
+	return 0;
+
+free_prealloc:
+	tcf_p4_put_prealloc_act(act, p4_act);
+
+idr_rm:
+	p4tc_table_entry_free_prio(table, entry_value->prio);
+
+	kfree(entry);
+
+act_put:
+	p4tc_action_put_ref(act);
+out:
+	return err;
+}
+
+static inline void
+p4tc_table_entry_create_state_put(struct p4tc_table *table,
+				  struct p4tc_table_entry_create_state *state)
+{
+	struct p4tc_table_entry_value *value;
+
+	tcf_p4_put_prealloc_act(state->act, state->p4_act);
+
+	value = p4tc_table_entry_value(state->entry);
+	p4tc_table_entry_free_prio(table, value->prio);
+
+	kfree(value->act_bpf);
+	kfree(value->acts);
+
+	kfree(state->entry);
+
+	p4tc_action_put_ref(state->act);
+}
+
 /* Invoked from both control and data path  */
 static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
 				     struct p4tc_table *table,
@@ -1604,6 +1796,89 @@ __must_hold(RCU)
 	(P4TC_CTRL_PERM_R | P4TC_CTRL_PERM_U | P4TC_CTRL_PERM_D | \
 	 P4TC_DATA_PERM_R | P4TC_DATA_PERM_X)
 
+static inline u16 p4tc_table_entry_tbl_permcpy(const u16 tblperm)
+{
+	return p4tc_ctrl_perm_rm_create(p4tc_data_perm_rm_create(tblperm));
+}
+
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms)
+{
+	u16 tblperm = rcu_dereference(table->tbl_permissions)->permissions;
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_create_state state = {0};
+	int err;
+
+	state.aging_ms = aging_ms;
+	state.permissions = p4tc_table_entry_tbl_permcpy(tblperm);
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz,
+					act_bpf, &state);
+	if (err < 0)
+		return err;
+
+	p4tc_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	err = __p4tc_table_entry_create(pipeline, table, state.entry, mask,
+					P4TC_ENTITY_KERNEL, false);
+	if (err < 0)
+		goto put_state;
+
+	value = p4tc_table_entry_value(state.entry);
+	refcount_set(&value->entries_ref, 1);
+	tcf_p4_set_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	p4tc_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
+int p4tc_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms)
+{
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
+
+	state.aging_ms = aging_ms;
+	state.permissions = P4TC_PERMISSIONS_UNINIT;
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz, act_bpf,
+					&state);
+	if (err < 0)
+		return err;
+
+	p4tc_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	value = p4tc_table_entry_value(state.entry);
+	value->is_dyn = !!aging_ms;
+	err = __p4tc_table_entry_update(pipeline, table, state.entry, NULL,
+					P4TC_ENTITY_KERNEL, false);
+
+	if (err < 0)
+		goto put_state;
+
+	refcount_set(&value->entries_ref, 1);
+	tcf_p4_set_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	p4tc_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
 static bool p4tc_table_check_entry_acts(struct p4tc_table *table,
 					struct tc_action *entry_acts[],
 					int num_entry_acts)
@@ -1682,11 +1957,6 @@ update_tbl_attrs(struct net *net, struct p4tc_table *table,
 	return err;
 }
 
-static inline u16 p4tc_table_entry_tbl_permcpy(const u16 tblperm)
-{
-	return p4tc_ctrl_perm_rm_create(p4tc_data_perm_rm_create(tblperm));
-}
-
 static struct p4tc_table_entry *
 __p4tc_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 		      struct p4tc_pipeline *pipeline, struct p4tc_table *table,
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 7fbe0bca5..a8606c599 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -599,6 +599,8 @@ static int __init p4tc_template_init(void)
 			op->init();
 	}
 
+	register_p4tc_tbl_bpf();
+
 	return 0;
 }
 
-- 
2.34.1


