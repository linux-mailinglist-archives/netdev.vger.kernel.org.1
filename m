Return-Path: <netdev+bounces-28278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078D77EDF5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCDE1C211B4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0F1DA46;
	Wed, 16 Aug 2023 23:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9E1ED32
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF802C433CA;
	Wed, 16 Aug 2023 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229397;
	bh=CqYRXIL5JSUIHfVOJJtbwp5UAql1Yux6yiJUug9WX2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gckCqxb9VyYIXKr0QuJnzSykvpxMG6Ge8Xvl1bF15sgozPTBvS4BlE1T+HDL6oHxO
	 deH5cVD69BYtEF2NqdjHBPnZlMsRxAhB2KIvI153dMCHFt7He8afnf+LERD+TT/5o6
	 rD6y6Jk9DqH8PspJG8GrRIJ9aVfbiTDSUkUDYZVMb/es3tmBc2SCLGNjefvIhnPkUY
	 Zl1TrvPcan0CJtiywIUd4a/mhIH+sKwE/pZMcaZzechWR9QweMBq8mSPoMs3QdrBYc
	 y8ZN58WyeG4av0TgFSVmxuWiBCteLsDmPOgrUb09kRIR0Trie2pGPb4fG3DREHSeZC
	 Ogw2Rnq0VYY4w==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 13/13] tools: netdev: regen after page pool changes
Date: Wed, 16 Aug 2023 16:43:02 -0700
Message-ID: <20230816234303.3786178-14-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816234303.3786178-1-kuba@kernel.org>
References: <20230816234303.3786178-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regenerate the code in tools/ after page pool addition
to the netdev netlink family.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/include/uapi/linux/netdev.h     |  37 +++
 tools/net/ynl/generated/netdev-user.c | 415 ++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h | 169 +++++++++++
 3 files changed, 621 insertions(+)

diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index c1634b95c223..25754237eb2f 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -48,16 +48,53 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_PAGE_POOL_ID = 1,
+	NETDEV_A_PAGE_POOL_PAD,
+	NETDEV_A_PAGE_POOL_IFINDEX,
+	NETDEV_A_PAGE_POOL_NAPI_ID,
+	NETDEV_A_PAGE_POOL_DESTROYED,
+	NETDEV_A_PAGE_POOL_INFLIGHT,
+
+	__NETDEV_A_PAGE_POOL_MAX,
+	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
+};
+
+enum {
+	NETDEV_A_PAGE_POOL_STATS_INFO = 1,
+	NETDEV_A_PAGE_POOL_STATS_PAD,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST = 8,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL,
+	NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL,
+	NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT,
+
+	__NETDEV_A_PAGE_POOL_STATS_MAX,
+	NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_PAGE_POOL_GET,
+	NETDEV_CMD_PAGE_POOL_ADD_NTF,
+	NETDEV_CMD_PAGE_POOL_DEL_NTF,
+	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
+	NETDEV_CMD_PAGE_POOL_STATS_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
 };
 
 #define NETDEV_MCGRP_MGMT	"mgmt"
+#define NETDEV_MCGRP_PAGE_POOL	"page-pool"
 
 #endif /* _UAPI_LINUX_NETDEV_H */
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 68b408ca0f7f..d58eb01c436e 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -18,6 +18,11 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
+	[NETDEV_CMD_PAGE_POOL_GET] = "page-pool-get",
+	[NETDEV_CMD_PAGE_POOL_ADD_NTF] = "page-pool-add-ntf",
+	[NETDEV_CMD_PAGE_POOL_DEL_NTF] = "page-pool-del-ntf",
+	[NETDEV_CMD_PAGE_POOL_CHANGE_NTF] = "page-pool-change-ntf",
+	[NETDEV_CMD_PAGE_POOL_STATS_GET] = "page-pool-stats-get",
 };
 
 const char *netdev_op_str(int op)
@@ -46,6 +51,16 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value)
 }
 
 /* Policies */
+struct ynl_policy_attr netdev_page_pool_info_policy[NETDEV_A_PAGE_POOL_MAX + 1] = {
+	[NETDEV_A_PAGE_POOL_ID] = { .name = "id", .type = YNL_PT_U32, },
+	[NETDEV_A_PAGE_POOL_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_page_pool_info_nest = {
+	.max_attr = NETDEV_A_PAGE_POOL_MAX,
+	.table = netdev_page_pool_info_policy,
+};
+
 struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_DEV_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
@@ -58,7 +73,86 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_page_pool_policy[NETDEV_A_PAGE_POOL_MAX + 1] = {
+	[NETDEV_A_PAGE_POOL_ID] = { .name = "id", .type = YNL_PT_U32, },
+	[NETDEV_A_PAGE_POOL_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
+	[NETDEV_A_PAGE_POOL_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_PAGE_POOL_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
+	[NETDEV_A_PAGE_POOL_DESTROYED] = { .name = "destroyed", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_INFLIGHT] = { .name = "inflight", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_page_pool_nest = {
+	.max_attr = NETDEV_A_PAGE_POOL_MAX,
+	.table = netdev_page_pool_policy,
+};
+
+struct ynl_policy_attr netdev_page_pool_stats_policy[NETDEV_A_PAGE_POOL_STATS_MAX + 1] = {
+	[NETDEV_A_PAGE_POOL_STATS_INFO] = { .name = "info", .type = YNL_PT_NEST, .nest = &netdev_page_pool_info_nest, },
+	[NETDEV_A_PAGE_POOL_STATS_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
+	[NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST] = { .name = "alloc-fast", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW] = { .name = "alloc-slow", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER] = { .name = "alloc-slow-high-order", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY] = { .name = "alloc-empty", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL] = { .name = "alloc-refill", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE] = { .name = "alloc-waive", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED] = { .name = "recycle-cached", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL] = { .name = "recycle-cache-full", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING] = { .name = "recycle-ring", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL] = { .name = "recycle-ring-full", .type = YNL_PT_U64, },
+	[NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT] = { .name = "recycle-released-refcnt", .type = YNL_PT_U64, },
+};
+
+struct ynl_policy_nest netdev_page_pool_stats_nest = {
+	.max_attr = NETDEV_A_PAGE_POOL_STATS_MAX,
+	.table = netdev_page_pool_stats_policy,
+};
+
 /* Common nested types */
+void netdev_page_pool_info_free(struct netdev_page_pool_info *obj)
+{
+}
+
+int netdev_page_pool_info_put(struct nlmsghdr *nlh, unsigned int attr_type,
+			      struct netdev_page_pool_info *obj)
+{
+	struct nlattr *nest;
+
+	nest = mnl_attr_nest_start(nlh, attr_type);
+	if (obj->_present.id)
+		mnl_attr_put_u32(nlh, NETDEV_A_PAGE_POOL_ID, obj->id);
+	if (obj->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_PAGE_POOL_IFINDEX, obj->ifindex);
+	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
+}
+
+int netdev_page_pool_info_parse(struct ynl_parse_arg *yarg,
+				const struct nlattr *nested)
+{
+	struct netdev_page_pool_info *dst = yarg->data;
+	const struct nlattr *attr;
+
+	mnl_attr_for_each_nested(attr, nested) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_PAGE_POOL_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.id = 1;
+			dst->id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_IFINDEX) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.ifindex = 1;
+			dst->ifindex = mnl_attr_get_u32(attr);
+		}
+	}
+
+	return 0;
+}
+
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
 void netdev_dev_get_req_free(struct netdev_dev_get_req *req)
@@ -178,6 +272,309 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
 	free(rsp);
 }
 
+/* ============== NETDEV_CMD_PAGE_POOL_GET ============== */
+/* NETDEV_CMD_PAGE_POOL_GET - do */
+void netdev_page_pool_get_req_free(struct netdev_page_pool_get_req *req)
+{
+	free(req);
+}
+
+void netdev_page_pool_get_rsp_free(struct netdev_page_pool_get_rsp *rsp)
+{
+	free(rsp);
+}
+
+int netdev_page_pool_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct netdev_page_pool_get_rsp *dst;
+	struct ynl_parse_arg *yarg = data;
+	const struct nlattr *attr;
+
+	dst = yarg->data;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_PAGE_POOL_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.id = 1;
+			dst->id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_IFINDEX) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.ifindex = 1;
+			dst->ifindex = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_NAPI_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.napi_id = 1;
+			dst->napi_id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_DESTROYED) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.destroyed = 1;
+			dst->destroyed = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_INFLIGHT) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.inflight = 1;
+			dst->inflight = mnl_attr_get_u32(attr);
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+struct netdev_page_pool_get_rsp *
+netdev_page_pool_get(struct ynl_sock *ys, struct netdev_page_pool_get_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct netdev_page_pool_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_GET, 1);
+	ys->req_policy = &netdev_page_pool_nest;
+	yrs.yarg.rsp_policy = &netdev_page_pool_nest;
+
+	if (req->_present.id)
+		mnl_attr_put_u32(nlh, NETDEV_A_PAGE_POOL_ID, req->id);
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = netdev_page_pool_get_rsp_parse;
+	yrs.rsp_cmd = NETDEV_CMD_PAGE_POOL_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	netdev_page_pool_get_rsp_free(rsp);
+	return NULL;
+}
+
+/* NETDEV_CMD_PAGE_POOL_GET - dump */
+void netdev_page_pool_get_list_free(struct netdev_page_pool_get_list *rsp)
+{
+	struct netdev_page_pool_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp);
+	}
+}
+
+struct netdev_page_pool_get_list *
+netdev_page_pool_get_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct netdev_page_pool_get_list);
+	yds.cb = netdev_page_pool_get_rsp_parse;
+	yds.rsp_cmd = NETDEV_CMD_PAGE_POOL_GET;
+	yds.rsp_policy = &netdev_page_pool_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_GET, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	netdev_page_pool_get_list_free(yds.first);
+	return NULL;
+}
+
+/* NETDEV_CMD_PAGE_POOL_GET - notify */
+void netdev_page_pool_get_ntf_free(struct netdev_page_pool_get_ntf *rsp)
+{
+	free(rsp);
+}
+
+/* ============== NETDEV_CMD_PAGE_POOL_STATS_GET ============== */
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
+void
+netdev_page_pool_stats_get_req_free(struct netdev_page_pool_stats_get_req *req)
+{
+	netdev_page_pool_info_free(&req->info);
+	free(req);
+}
+
+void
+netdev_page_pool_stats_get_rsp_free(struct netdev_page_pool_stats_get_rsp *rsp)
+{
+	netdev_page_pool_info_free(&rsp->info);
+	free(rsp);
+}
+
+int netdev_page_pool_stats_get_rsp_parse(const struct nlmsghdr *nlh,
+					 void *data)
+{
+	struct netdev_page_pool_stats_get_rsp *dst;
+	struct ynl_parse_arg *yarg = data;
+	const struct nlattr *attr;
+	struct ynl_parse_arg parg;
+
+	dst = yarg->data;
+	parg.ys = yarg->ys;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_PAGE_POOL_STATS_INFO) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.info = 1;
+
+			parg.rsp_policy = &netdev_page_pool_info_nest;
+			parg.data = &dst->info;
+			if (netdev_page_pool_info_parse(&parg, attr))
+				return MNL_CB_ERROR;
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_FAST) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.alloc_fast = 1;
+			dst->alloc_fast = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.alloc_slow = 1;
+			dst->alloc_slow = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_SLOW_HIGH_ORDER) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.alloc_slow_high_order = 1;
+			dst->alloc_slow_high_order = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_EMPTY) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.alloc_empty = 1;
+			dst->alloc_empty = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_REFILL) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.alloc_refill = 1;
+			dst->alloc_refill = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_ALLOC_WAIVE) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.alloc_waive = 1;
+			dst->alloc_waive = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHED) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.recycle_cached = 1;
+			dst->recycle_cached = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_CACHE_FULL) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.recycle_cache_full = 1;
+			dst->recycle_cache_full = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.recycle_ring = 1;
+			dst->recycle_ring = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_RING_FULL) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.recycle_ring_full = 1;
+			dst->recycle_ring_full = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_PAGE_POOL_STATS_RECYCLE_RELEASED_REFCNT) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.recycle_released_refcnt = 1;
+			dst->recycle_released_refcnt = mnl_attr_get_u64(attr);
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+struct netdev_page_pool_stats_get_rsp *
+netdev_page_pool_stats_get(struct ynl_sock *ys,
+			   struct netdev_page_pool_stats_get_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct netdev_page_pool_stats_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_STATS_GET, 1);
+	ys->req_policy = &netdev_page_pool_stats_nest;
+	yrs.yarg.rsp_policy = &netdev_page_pool_stats_nest;
+
+	if (req->_present.info)
+		netdev_page_pool_info_put(nlh, NETDEV_A_PAGE_POOL_STATS_INFO, &req->info);
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = netdev_page_pool_stats_get_rsp_parse;
+	yrs.rsp_cmd = NETDEV_CMD_PAGE_POOL_STATS_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	netdev_page_pool_stats_get_rsp_free(rsp);
+	return NULL;
+}
+
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - dump */
+void
+netdev_page_pool_stats_get_list_free(struct netdev_page_pool_stats_get_list *rsp)
+{
+	struct netdev_page_pool_stats_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		netdev_page_pool_info_free(&rsp->obj.info);
+		free(rsp);
+	}
+}
+
+struct netdev_page_pool_stats_get_list *
+netdev_page_pool_stats_get_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct netdev_page_pool_stats_get_list);
+	yds.cb = netdev_page_pool_stats_get_rsp_parse;
+	yds.rsp_cmd = NETDEV_CMD_PAGE_POOL_STATS_GET;
+	yds.rsp_policy = &netdev_page_pool_stats_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_PAGE_POOL_STATS_GET, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	netdev_page_pool_stats_get_list_free(yds.first);
+	return NULL;
+}
+
 static const struct ynl_ntf_info netdev_ntf_info[] =  {
 	[NETDEV_CMD_DEV_ADD_NTF] =  {
 		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
@@ -197,6 +594,24 @@ static const struct ynl_ntf_info netdev_ntf_info[] =  {
 		.policy		= &netdev_dev_nest,
 		.free		= (void *)netdev_dev_get_ntf_free,
 	},
+	[NETDEV_CMD_PAGE_POOL_ADD_NTF] =  {
+		.alloc_sz	= sizeof(struct netdev_page_pool_get_ntf),
+		.cb		= netdev_page_pool_get_rsp_parse,
+		.policy		= &netdev_page_pool_nest,
+		.free		= (void *)netdev_page_pool_get_ntf_free,
+	},
+	[NETDEV_CMD_PAGE_POOL_DEL_NTF] =  {
+		.alloc_sz	= sizeof(struct netdev_page_pool_get_ntf),
+		.cb		= netdev_page_pool_get_rsp_parse,
+		.policy		= &netdev_page_pool_nest,
+		.free		= (void *)netdev_page_pool_get_ntf_free,
+	},
+	[NETDEV_CMD_PAGE_POOL_CHANGE_NTF] =  {
+		.alloc_sz	= sizeof(struct netdev_page_pool_get_ntf),
+		.cb		= netdev_page_pool_get_rsp_parse,
+		.policy		= &netdev_page_pool_nest,
+		.free		= (void *)netdev_page_pool_get_ntf_free,
+	},
 };
 
 const struct ynl_family ynl_netdev_family =  {
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 0952d3261f4d..4462dbe1369b 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -20,6 +20,16 @@ const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
 
 /* Common nested types */
+struct netdev_page_pool_info {
+	struct {
+		__u32 id:1;
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 id;
+	__u32 ifindex;
+};
+
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
 struct netdev_dev_get_req {
@@ -84,4 +94,163 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_PAGE_POOL_GET ============== */
+/* NETDEV_CMD_PAGE_POOL_GET - do */
+struct netdev_page_pool_get_req {
+	struct {
+		__u32 id:1;
+	} _present;
+
+	__u32 id;
+};
+
+static inline struct netdev_page_pool_get_req *
+netdev_page_pool_get_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_page_pool_get_req));
+}
+void netdev_page_pool_get_req_free(struct netdev_page_pool_get_req *req);
+
+static inline void
+netdev_page_pool_get_req_set_id(struct netdev_page_pool_get_req *req, __u32 id)
+{
+	req->_present.id = 1;
+	req->id = id;
+}
+
+struct netdev_page_pool_get_rsp {
+	struct {
+		__u32 id:1;
+		__u32 ifindex:1;
+		__u32 napi_id:1;
+		__u32 destroyed:1;
+		__u32 inflight:1;
+	} _present;
+
+	__u32 id;
+	__u32 ifindex;
+	__u32 napi_id;
+	__u64 destroyed;
+	__u32 inflight;
+};
+
+void netdev_page_pool_get_rsp_free(struct netdev_page_pool_get_rsp *rsp);
+
+/*
+ * Get / dump information about Page Pools.
+(Only Page Pools associated with a net_device can be listed.)
+
+ */
+struct netdev_page_pool_get_rsp *
+netdev_page_pool_get(struct ynl_sock *ys, struct netdev_page_pool_get_req *req);
+
+/* NETDEV_CMD_PAGE_POOL_GET - dump */
+struct netdev_page_pool_get_list {
+	struct netdev_page_pool_get_list *next;
+	struct netdev_page_pool_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void netdev_page_pool_get_list_free(struct netdev_page_pool_get_list *rsp);
+
+struct netdev_page_pool_get_list *
+netdev_page_pool_get_dump(struct ynl_sock *ys);
+
+/* NETDEV_CMD_PAGE_POOL_GET - notify */
+struct netdev_page_pool_get_ntf {
+	__u16 family;
+	__u8 cmd;
+	struct ynl_ntf_base_type *next;
+	void (*free)(struct netdev_page_pool_get_ntf *ntf);
+	struct netdev_page_pool_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void netdev_page_pool_get_ntf_free(struct netdev_page_pool_get_ntf *rsp);
+
+/* ============== NETDEV_CMD_PAGE_POOL_STATS_GET ============== */
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - do */
+struct netdev_page_pool_stats_get_req {
+	struct {
+		__u32 info:1;
+	} _present;
+
+	struct netdev_page_pool_info info;
+};
+
+static inline struct netdev_page_pool_stats_get_req *
+netdev_page_pool_stats_get_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_page_pool_stats_get_req));
+}
+void
+netdev_page_pool_stats_get_req_free(struct netdev_page_pool_stats_get_req *req);
+
+static inline void
+netdev_page_pool_stats_get_req_set_info_id(struct netdev_page_pool_stats_get_req *req,
+					   __u32 id)
+{
+	req->_present.info = 1;
+	req->info._present.id = 1;
+	req->info.id = id;
+}
+static inline void
+netdev_page_pool_stats_get_req_set_info_ifindex(struct netdev_page_pool_stats_get_req *req,
+						__u32 ifindex)
+{
+	req->_present.info = 1;
+	req->info._present.ifindex = 1;
+	req->info.ifindex = ifindex;
+}
+
+struct netdev_page_pool_stats_get_rsp {
+	struct {
+		__u32 info:1;
+		__u32 alloc_fast:1;
+		__u32 alloc_slow:1;
+		__u32 alloc_slow_high_order:1;
+		__u32 alloc_empty:1;
+		__u32 alloc_refill:1;
+		__u32 alloc_waive:1;
+		__u32 recycle_cached:1;
+		__u32 recycle_cache_full:1;
+		__u32 recycle_ring:1;
+		__u32 recycle_ring_full:1;
+		__u32 recycle_released_refcnt:1;
+	} _present;
+
+	struct netdev_page_pool_info info;
+	__u64 alloc_fast;
+	__u64 alloc_slow;
+	__u64 alloc_slow_high_order;
+	__u64 alloc_empty;
+	__u64 alloc_refill;
+	__u64 alloc_waive;
+	__u64 recycle_cached;
+	__u64 recycle_cache_full;
+	__u64 recycle_ring;
+	__u64 recycle_ring_full;
+	__u64 recycle_released_refcnt;
+};
+
+void
+netdev_page_pool_stats_get_rsp_free(struct netdev_page_pool_stats_get_rsp *rsp);
+
+/*
+ * Get page pool statistics.
+ */
+struct netdev_page_pool_stats_get_rsp *
+netdev_page_pool_stats_get(struct ynl_sock *ys,
+			   struct netdev_page_pool_stats_get_req *req);
+
+/* NETDEV_CMD_PAGE_POOL_STATS_GET - dump */
+struct netdev_page_pool_stats_get_list {
+	struct netdev_page_pool_stats_get_list *next;
+	struct netdev_page_pool_stats_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void
+netdev_page_pool_stats_get_list_free(struct netdev_page_pool_stats_get_list *rsp);
+
+struct netdev_page_pool_stats_get_list *
+netdev_page_pool_stats_get_dump(struct ynl_sock *ys);
+
 #endif /* _LINUX_NETDEV_GEN_H */
-- 
2.41.0


