Return-Path: <netdev+bounces-101083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08D8FD3BB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26411C22212
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7B425777;
	Wed,  5 Jun 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF+ioGQ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61717BCB
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607806; cv=none; b=kRZZ1xqmmfZwMJateDRqhnvZ+muV26oAvEvdduq8E/a468Mp9/e0evGnCmty9tsDY0eeOAcDU2IlxP8getigzmCHez6psyK9cQxPIegPR/tnfpvKRTy1zRUwSPjSGQvnNPAO8f02ZK5AdBgKleQTGy9/21vPsl/fX7XjU3tKPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607806; c=relaxed/simple;
	bh=5orS7KFEABzG/pK5IWz8CzBAOlUZhOHLIrkRzh53WJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwzilLTExQhXjJ/NoI7s9JuOT/l9/PU3HgOoanNSyZ2jp/bLbW1Zp3hdeoVkFNMww+jdmvW2UyLFYMiZWwgCdEy1PhojnwxJJBp8jVIlpjqznZqJyy12uiaOwR9Y5VuZgsYzZtV+qOdKAVmnGOfUZxsvCPaLIetu0oeGq2WLZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF+ioGQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C150C2BD11;
	Wed,  5 Jun 2024 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717607805;
	bh=5orS7KFEABzG/pK5IWz8CzBAOlUZhOHLIrkRzh53WJA=;
	h=From:To:Cc:Subject:Date:From;
	b=LF+ioGQ9VSLwFX/uL7aYFUt0qfKjfo7fW1QqVG3aQGrJjmOmuDS9zwO7sbZahOIcZ
	 Dkmei+JUoTEH37vu5JvRLW8SSVUwv1olXAahQjg1eRrtVMofgL0rjvxxkoEZhN67TW
	 z7uEvMxQP6njCDyhgLN9APpAf9OTZrVTL3SgDREw3TLAKAoQ3kZguw83lLeJL4Ywy7
	 rdUV2761lwxHAsjrm42f6kK93Rzd96UgWw6FMbmkQlBc1LgQT9sMzjORCtHwa1/2uR
	 qhEmOJnvtxwrkfeQ+Ci8DgBMJp9HxD9OczclT98UdOoOm11OeQeTH2QTbgk0E1wumM
	 BVH3r5gCMdAyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Dan Melnic <dmm@meta.com>,
	donald.hunter@gmail.com,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next] tools: ynl: make user space policies const
Date: Wed,  5 Jun 2024 10:16:44 -0700
Message-ID: <20240605171644.1638533-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan, who's working on C++ YNL, pointed out that the C code
does not make policies const. Sprinkle some 'const's around.

Reported-by: Dan Melnic <dmm@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: nicolas.dichtel@6wind.com
---
 tools/net/ynl/lib/ynl-priv.h |  8 ++++----
 tools/net/ynl/lib/ynl.c      | 10 +++++-----
 tools/net/ynl/lib/ynl.h      |  2 +-
 tools/net/ynl/ynl-gen-c.py   |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 80791c34730c..3c09a7bbfba5 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -45,17 +45,17 @@ struct ynl_policy_attr {
 	enum ynl_policy_type type;
 	unsigned int len;
 	const char *name;
-	struct ynl_policy_nest *nest;
+	const struct ynl_policy_nest *nest;
 };
 
 struct ynl_policy_nest {
 	unsigned int max_attr;
-	struct ynl_policy_attr *table;
+	const struct ynl_policy_attr *table;
 };
 
 struct ynl_parse_arg {
 	struct ynl_sock *ys;
-	struct ynl_policy_nest *rsp_policy;
+	const struct ynl_policy_nest *rsp_policy;
 	void *data;
 };
 
@@ -119,7 +119,7 @@ struct ynl_dump_state {
 };
 
 struct ynl_ntf_info {
-	struct ynl_policy_nest *policy;
+	const struct ynl_policy_nest *policy;
 	ynl_parse_cb_t cb;
 	size_t alloc_sz;
 	void (*free)(struct ynl_ntf_base_type *ntf);
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 4b9c091fc86b..fcb18a5a6d70 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -46,7 +46,7 @@
 
 /* -- Netlink boiler plate */
 static int
-ynl_err_walk_report_one(struct ynl_policy_nest *policy, unsigned int type,
+ynl_err_walk_report_one(const struct ynl_policy_nest *policy, unsigned int type,
 			char *str, int str_sz, int *n)
 {
 	if (!policy) {
@@ -75,8 +75,8 @@ ynl_err_walk_report_one(struct ynl_policy_nest *policy, unsigned int type,
 
 static int
 ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
-	     struct ynl_policy_nest *policy, char *str, int str_sz,
-	     struct ynl_policy_nest **nest_pol)
+	     const struct ynl_policy_nest *policy, char *str, int str_sz,
+	     const struct ynl_policy_nest **nest_pol)
 {
 	unsigned int astart_off, aend_off;
 	const struct nlattr *attr;
@@ -206,7 +206,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		bad_attr[n] = '\0';
 	}
 	if (tb[NLMSGERR_ATTR_MISS_TYPE]) {
-		struct ynl_policy_nest *nest_pol = NULL;
+		const struct ynl_policy_nest *nest_pol = NULL;
 		unsigned int n, off, type;
 		void *start, *end;
 		int n2;
@@ -296,7 +296,7 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 {
-	struct ynl_policy_attr *policy;
+	const struct ynl_policy_attr *policy;
 	unsigned int type, len;
 	unsigned char *data;
 
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index eef7c6324ed4..6cd570b283ea 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -76,7 +76,7 @@ struct ynl_sock {
 	struct ynl_ntf_base_type **ntf_last_next;
 
 	struct nlmsghdr *nlh;
-	struct ynl_policy_nest *req_policy;
+	const struct ynl_policy_nest *req_policy;
 	unsigned char *tx_buf;
 	unsigned char *rx_buf;
 	unsigned char raw_buf[];
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index a42d62b23ee0..374ca5e86e24 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1507,12 +1507,12 @@ _C_KW = {
 
 
 def put_typol_fwd(cw, struct):
-    cw.p(f'extern struct ynl_policy_nest {struct.render_name}_nest;')
+    cw.p(f'extern const struct ynl_policy_nest {struct.render_name}_nest;')
 
 
 def put_typol(cw, struct):
     type_max = struct.attr_set.max_name
-    cw.block_start(line=f'struct ynl_policy_attr {struct.render_name}_policy[{type_max} + 1] =')
+    cw.block_start(line=f'const struct ynl_policy_attr {struct.render_name}_policy[{type_max} + 1] =')
 
     for _, arg in struct.member_list():
         arg.attr_typol(cw)
@@ -1520,7 +1520,7 @@ _C_KW = {
     cw.block_end(line=';')
     cw.nl()
 
-    cw.block_start(line=f'struct ynl_policy_nest {struct.render_name}_nest =')
+    cw.block_start(line=f'const struct ynl_policy_nest {struct.render_name}_nest =')
     cw.p(f'.max_attr = {type_max},')
     cw.p(f'.table = {struct.render_name}_policy,')
     cw.block_end(line=';')
-- 
2.45.2


