Return-Path: <netdev+bounces-45795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D07DFA5D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AF6281230
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A31DDD6;
	Thu,  2 Nov 2023 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlRso0A0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C768C8D6
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 18:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08AFC433C8;
	Thu,  2 Nov 2023 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698951155;
	bh=hXDWnrfL3OTN0MYUNnUbKci7Ji1PBcGttUuRsSZ8yHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dlRso0A0pF6o5yWGx9Zy3K6mFwYPjigvy0l1QZJeMSYpP9lniG5Z0IZyVgCQL9BXJ
	 SqFWbD6DFnQjsGyEi5S9/kKBRfvhsQ5dzK3lb7QD2JDMit3U1ZN/zwQ0c7Bfc9ZiDP
	 t114H8jz3vtV1Dk1wyewG6M5ekY6/SLRZCTIEic6m195Y3M/qD+ZOS02Y8mrz6IuBz
	 QR4zdgiiTwMohqQ372IhHbrBzJHxivPiPeH5cDcdwEPg3HLkkbIT4+1kiuTBQsgeKl
	 VNhdfy8V6byC6MRvuJI+HoKDpLZ629ZjCqmHVljHPiV9QOPU/i+AXLjHDJES/wix2t
	 rqhSDDeWKvcFQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	chuck.lever@oracle.com,
	lorenzo@kernel.org
Subject: [PATCH net] nfsd: regenerate user space parsers after ynl-gen changes
Date: Thu,  2 Nov 2023 11:52:27 -0700
Message-ID: <20231102185227.2604416-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8cea95b0bd79 ("tools: ynl-gen: handle do ops with no input attrs")
added support for some of the previously-skipped ops in nfsd.
Regenerate the user space parsers to fill them in.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: chuck.lever@oracle.com
CC: lorenzo@kernel.org
---
 include/uapi/linux/nfsd_netlink.h   |   6 +-
 tools/net/ynl/generated/nfsd-user.c | 120 ++++++++++++++++++++++++++--
 tools/net/ynl/generated/nfsd-user.h |  44 ++++++++--
 3 files changed, 156 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index c8ae72466ee6..3cd044edee5d 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -3,8 +3,8 @@
 /*	Documentation/netlink/specs/nfsd.yaml */
 /* YNL-GEN uapi header */
 
-#ifndef _UAPI_LINUX_NFSD_H
-#define _UAPI_LINUX_NFSD_H
+#ifndef _UAPI_LINUX_NFSD_NETLINK_H
+#define _UAPI_LINUX_NFSD_NETLINK_H
 
 #define NFSD_FAMILY_NAME	"nfsd"
 #define NFSD_FAMILY_VERSION	1
@@ -36,4 +36,4 @@ enum {
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
 };
 
-#endif /* _UAPI_LINUX_NFSD_H */
+#endif /* _UAPI_LINUX_NFSD_NETLINK_H */
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
index fec6828680ce..360b6448c6e9 100644
--- a/tools/net/ynl/generated/nfsd-user.c
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -50,9 +50,116 @@ struct ynl_policy_nest nfsd_rpc_status_nest = {
 /* Common nested types */
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
-void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp)
+int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, void *data)
 {
-	struct nfsd_rpc_status_get_list *next = rsp;
+	struct nfsd_rpc_status_get_rsp_dump *dst;
+	struct ynl_parse_arg *yarg = data;
+	unsigned int n_compound_ops = 0;
+	const struct nlattr *attr;
+	int i;
+
+	dst = yarg->data;
+
+	if (dst->compound_ops)
+		return ynl_error_parse(yarg, "attribute already present (rpc-status.compound-ops)");
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NFSD_A_RPC_STATUS_XID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.xid = 1;
+			dst->xid = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_RPC_STATUS_FLAGS) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.flags = 1;
+			dst->flags = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_RPC_STATUS_PROG) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.prog = 1;
+			dst->prog = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_RPC_STATUS_VERSION) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.version = 1;
+			dst->version = mnl_attr_get_u8(attr);
+		} else if (type == NFSD_A_RPC_STATUS_PROC) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.proc = 1;
+			dst->proc = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_RPC_STATUS_SERVICE_TIME) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.service_time = 1;
+			dst->service_time = mnl_attr_get_u64(attr);
+		} else if (type == NFSD_A_RPC_STATUS_SADDR4) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.saddr4 = 1;
+			dst->saddr4 = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_RPC_STATUS_DADDR4) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.daddr4 = 1;
+			dst->daddr4 = mnl_attr_get_u32(attr);
+		} else if (type == NFSD_A_RPC_STATUS_SADDR6) {
+			unsigned int len;
+
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+
+			len = mnl_attr_get_payload_len(attr);
+			dst->_present.saddr6_len = len;
+			dst->saddr6 = malloc(len);
+			memcpy(dst->saddr6, mnl_attr_get_payload(attr), len);
+		} else if (type == NFSD_A_RPC_STATUS_DADDR6) {
+			unsigned int len;
+
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+
+			len = mnl_attr_get_payload_len(attr);
+			dst->_present.daddr6_len = len;
+			dst->daddr6 = malloc(len);
+			memcpy(dst->daddr6, mnl_attr_get_payload(attr), len);
+		} else if (type == NFSD_A_RPC_STATUS_SPORT) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.sport = 1;
+			dst->sport = mnl_attr_get_u16(attr);
+		} else if (type == NFSD_A_RPC_STATUS_DPORT) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.dport = 1;
+			dst->dport = mnl_attr_get_u16(attr);
+		} else if (type == NFSD_A_RPC_STATUS_COMPOUND_OPS) {
+			n_compound_ops++;
+		}
+	}
+
+	if (n_compound_ops) {
+		dst->compound_ops = calloc(n_compound_ops, sizeof(*dst->compound_ops));
+		dst->n_compound_ops = n_compound_ops;
+		i = 0;
+		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+			if (mnl_attr_get_type(attr) == NFSD_A_RPC_STATUS_COMPOUND_OPS) {
+				dst->compound_ops[i] = mnl_attr_get_u32(attr);
+				i++;
+			}
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+void
+nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp)
+{
+	struct nfsd_rpc_status_get_rsp_list *next = rsp;
 
 	while ((void *)next != YNL_LIST_END) {
 		rsp = next;
@@ -65,15 +172,16 @@ void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp)
 	}
 }
 
-struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
+struct nfsd_rpc_status_get_rsp_list *
+nfsd_rpc_status_get_dump(struct ynl_sock *ys)
 {
 	struct ynl_dump_state yds = {};
 	struct nlmsghdr *nlh;
 	int err;
 
 	yds.ys = ys;
-	yds.alloc_sz = sizeof(struct nfsd_rpc_status_get_list);
-	yds.cb = nfsd_rpc_status_get_rsp_parse;
+	yds.alloc_sz = sizeof(struct nfsd_rpc_status_get_rsp_list);
+	yds.cb = nfsd_rpc_status_get_rsp_dump_parse;
 	yds.rsp_cmd = NFSD_CMD_RPC_STATUS_GET;
 	yds.rsp_policy = &nfsd_rpc_status_nest;
 
@@ -86,7 +194,7 @@ struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
 	return yds.first;
 
 free_list:
-	nfsd_rpc_status_get_list_free(yds.first);
+	nfsd_rpc_status_get_rsp_list_free(yds.first);
 	return NULL;
 }
 
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index b6b69501031a..989c6e209ced 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -21,13 +21,47 @@ const char *nfsd_op_str(int op);
 /* Common nested types */
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
-struct nfsd_rpc_status_get_list {
-	struct nfsd_rpc_status_get_list *next;
-	struct nfsd_rpc_status_get_rsp obj __attribute__ ((aligned (8)));
+struct nfsd_rpc_status_get_rsp_dump {
+	struct {
+		__u32 xid:1;
+		__u32 flags:1;
+		__u32 prog:1;
+		__u32 version:1;
+		__u32 proc:1;
+		__u32 service_time:1;
+		__u32 saddr4:1;
+		__u32 daddr4:1;
+		__u32 saddr6_len;
+		__u32 daddr6_len;
+		__u32 sport:1;
+		__u32 dport:1;
+	} _present;
+
+	__u32 xid /* big-endian */;
+	__u32 flags;
+	__u32 prog;
+	__u8 version;
+	__u32 proc;
+	__s64 service_time;
+	__u32 saddr4 /* big-endian */;
+	__u32 daddr4 /* big-endian */;
+	void *saddr6;
+	void *daddr6;
+	__u16 sport /* big-endian */;
+	__u16 dport /* big-endian */;
+	unsigned int n_compound_ops;
+	__u32 *compound_ops;
 };
 
-void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp);
+struct nfsd_rpc_status_get_rsp_list {
+	struct nfsd_rpc_status_get_rsp_list *next;
+	struct nfsd_rpc_status_get_rsp_dump obj __attribute__((aligned(8)));
+};
 
-struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys);
+void
+nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_status_get_rsp_list *rsp);
+
+struct nfsd_rpc_status_get_rsp_list *
+nfsd_rpc_status_get_dump(struct ynl_sock *ys);
 
 #endif /* _LINUX_NFSD_GEN_H */
-- 
2.41.0


