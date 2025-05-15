Return-Path: <netdev+bounces-190885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD2AB92C2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04204A2D2E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A602957C2;
	Thu, 15 May 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpTX1MYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6529551A
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351031; cv=none; b=JvgpyyCXtNR79K6FLACa3o7ZaZG5nilvzCZF30eSS1TWiqi9Lyju/h89kfIrplfrEFXrUphg6AiXHsUR2qYah7VFljSJEdY5F5ooOETePom46NPjBKVrZ19OM+7a/bAgroCUYPRdedGd6WpqiGXIh7sGo5/UrsJQqww4FieFLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351031; c=relaxed/simple;
	bh=uzD8xHq1iSv/cAAQ+WpmY2klC57rY6akIeqhvXATKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+0bn2oteyphcExdVA/HiMYlmMgKG0DAMNVgTt7YRWXved/8aCN+RqhB7erzZwTxLgRCDRpcNBfAwMETFxtSlGPhkV4lPAH1mz0bgMhEAWAG7aljEdRDlHBqcfUJy4FlyF8kk3frrGgXMWNUT6IpxxIBy6DGz0EwwLQGjIWzMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpTX1MYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B23C4CEF0;
	Thu, 15 May 2025 23:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351030;
	bh=uzD8xHq1iSv/cAAQ+WpmY2klC57rY6akIeqhvXATKGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpTX1MYsH39ukxY81mr7zsPGkdH67rnbnDYRC5x8GFf0cN0JCSld5R81fOrrbN0q1
	 7HP/WvHYSSs7J9WARl0AO/F+8eDjfbX7R1ZG4zJjELl3Wvpgz5YByjiOrfnVZ1N6he
	 xs+egarUgFbv6a6iO4VqHrK7GPWqNbwMigSl/rWr2uJuwVJy1trmzdXWJ0l/UNOrmT
	 JyYPiiJheZszjR2LGTRQuLUzKYZWllEpTtA/Z9RqW6SeztWtVMxUAGtSgGlW9TbR+A
	 zNU6VV0RfN7axS+YmmznvPrgNJOyt56cFBYn15FJA8K/YqAq0+WQRp/7lzRCPBHE2X
	 mr3OGTM1BvpCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/9] tools: ynl: submsg: reverse parse / error reporting
Date: Thu, 15 May 2025 16:16:48 -0700
Message-ID: <20250515231650.1325372-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reverse parsing lets YNL convert bad and missing attr pointers
from extack into a string like "missing attribute nest1.nest2.attr_name".
It's a feature that's unique to YNL C AFAIU (even the Python YNL
can't do nested reverse parsing). Add support for reverse-parsing
of sub-messages.

To simplify the logic and the code annotate the type policies
with extra metadata. Mark the selectors and the messages with
the information we need. We assume that key / selector always
precedes the sub-message while parsing (and also if there are
multiple sub-messages like in rt-link they are interleaved
selector 1 ... submsg 1 ... selector 2 .. submsg 2, not
selector 1 ... selector 2 ... submsg 1 ... submsg 2).

The rt-link sample in a subsequent changes shows reverse parsing
of sub-messages in action.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h     |  5 +-
 tools/net/ynl/lib/ynl.c          | 84 ++++++++++++++++++++++++++++----
 tools/net/ynl/pyynl/ynl_gen_c.py | 29 ++++++++++-
 3 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index fbc058dd1c3e..416866f85820 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -43,7 +43,10 @@ typedef int (*ynl_parse_cb_t)(const struct nlmsghdr *nlh,
 			      struct ynl_parse_arg *yarg);
 
 struct ynl_policy_attr {
-	enum ynl_policy_type type;
+	enum ynl_policy_type type:8;
+	__u8 is_submsg:1;
+	__u8 is_selector:1;
+	__u16 selector_type;
 	unsigned int len;
 	const char *name;
 	const struct ynl_policy_nest *nest;
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 25fc6501349b..2a169c3c0797 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -45,8 +45,39 @@
 #define perr(_ys, _msg)			__yerr(&(_ys)->err, errno, _msg)
 
 /* -- Netlink boiler plate */
+static bool
+ynl_err_walk_is_sel(const struct ynl_policy_nest *policy,
+		    const struct nlattr *attr)
+{
+	unsigned int type = ynl_attr_type(attr);
+
+	return policy && type <= policy->max_attr &&
+		policy->table[type].is_selector;
+}
+
+static const struct ynl_policy_nest *
+ynl_err_walk_sel_policy(const struct ynl_policy_attr *policy_attr,
+			const struct nlattr *selector)
+{
+	const struct ynl_policy_nest *policy = policy_attr->nest;
+	const char *sel;
+	unsigned int i;
+
+	if (!policy_attr->is_submsg)
+		return policy;
+
+	sel = ynl_attr_get_str(selector);
+	for (i = 0; i <= policy->max_attr; i++) {
+		if (!strcmp(sel, policy->table[i].name))
+			return policy->table[i].nest;
+	}
+
+	return NULL;
+}
+
 static int
-ynl_err_walk_report_one(const struct ynl_policy_nest *policy, unsigned int type,
+ynl_err_walk_report_one(const struct ynl_policy_nest *policy,
+			const struct nlattr *selector, unsigned int type,
 			char *str, int str_sz, int *n)
 {
 	if (!policy) {
@@ -67,9 +98,34 @@ ynl_err_walk_report_one(const struct ynl_policy_nest *policy, unsigned int type,
 		return 1;
 	}
 
-	if (*n < str_sz)
-		*n += snprintf(str, str_sz - *n,
-			       ".%s", policy->table[type].name);
+	if (*n < str_sz) {
+		int sz;
+
+		sz = snprintf(str, str_sz - *n,
+			      ".%s", policy->table[type].name);
+		*n += sz;
+		str += sz;
+	}
+
+	if (policy->table[type].is_submsg) {
+		if (!selector) {
+			if (*n < str_sz)
+				*n += snprintf(str, str_sz, "(!selector)");
+			return 1;
+		}
+
+		if (ynl_attr_type(selector) !=
+		    policy->table[type].selector_type) {
+			if (*n < str_sz)
+				*n += snprintf(str, str_sz, "(!=selector)");
+			return 1;
+		}
+
+		if (*n < str_sz)
+			*n += snprintf(str, str_sz - *n, "(%s)",
+				       ynl_attr_get_str(selector));
+	}
+
 	return 0;
 }
 
@@ -78,6 +134,8 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 	     const struct ynl_policy_nest *policy, char *str, int str_sz,
 	     const struct ynl_policy_nest **nest_pol)
 {
+	const struct ynl_policy_nest *next_pol;
+	const struct nlattr *selector = NULL;
 	unsigned int astart_off, aend_off;
 	const struct nlattr *attr;
 	unsigned int data_len;
@@ -96,6 +154,10 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 	ynl_attr_for_each_payload(start, data_len, attr) {
 		astart_off = (char *)attr - (char *)start;
 		aend_off = (char *)ynl_attr_data_end(attr) - (char *)start;
+
+		if (ynl_err_walk_is_sel(policy, attr))
+			selector = attr;
+
 		if (aend_off <= off)
 			continue;
 
@@ -109,16 +171,20 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 
 	type = ynl_attr_type(attr);
 
-	if (ynl_err_walk_report_one(policy, type, str, str_sz, &n))
+	if (ynl_err_walk_report_one(policy, selector, type, str, str_sz, &n))
+		return n;
+
+	next_pol = ynl_err_walk_sel_policy(&policy->table[type], selector);
+	if (!next_pol)
 		return n;
 
 	if (!off) {
 		if (nest_pol)
-			*nest_pol = policy->table[type].nest;
+			*nest_pol = next_pol;
 		return n;
 	}
 
-	if (!policy->table[type].nest) {
+	if (!next_pol) {
 		if (n < str_sz)
 			n += snprintf(str, str_sz, "!nest");
 		return n;
@@ -128,7 +194,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 	start =  ynl_attr_data(attr);
 	end = start + ynl_attr_data_len(attr);
 
-	return n + ynl_err_walk(ys, start, end, off, policy->table[type].nest,
+	return n + ynl_err_walk(ys, start, end, off, next_pol,
 				&str[n], str_sz - n, nest_pol);
 }
 
@@ -231,7 +297,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		}
 
 		n2 = 0;
-		ynl_err_walk_report_one(nest_pol, type, &miss_attr[n],
+		ynl_err_walk_report_one(nest_pol, NULL, type, &miss_attr[n],
 					sizeof(miss_attr) - n, &n2);
 		n += n2;
 
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b6b54d6fa906..1f8cc34ab3f0 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -57,6 +57,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         self.request = False
         self.reply = False
 
+        self.is_selector = False
+
         if 'len' in attr:
             self.len = attr['len']
 
@@ -484,7 +486,10 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         ri.cw.p(f"char *{self.c_name};")
 
     def _attr_typol(self):
-        return f'.type = YNL_PT_NUL_STR, '
+        typol = f'.type = YNL_PT_NUL_STR, '
+        if self.is_selector:
+            typol += '.is_selector = 1, '
+        return typol
 
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
@@ -878,6 +883,16 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
 
 class TypeSubMessage(TypeNest):
+    def __init__(self, family, attr_set, attr, value):
+        super().__init__(family, attr_set, attr, value)
+
+        self.selector = Selector(attr, attr_set)
+
+    def _attr_typol(self):
+        typol = f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
+        typol += f'.is_submsg = 1, .selector_type = {self.attr_set[self["selector"]].value} '
+        return typol
+
     def _attr_get(self, ri, var):
         sel = c_lower(self['selector'])
         get_lines = [f'if (!{var}->{sel})',
@@ -890,6 +905,18 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         return get_lines, init_lines, None
 
 
+class Selector:
+    def __init__(self, msg_attr, attr_set):
+        self.name = msg_attr["selector"]
+
+        if self.name in attr_set:
+            self.attr = attr_set[self.name]
+            self.attr.is_selector = True
+            self._external = False
+        else:
+            raise Exception("Passing selectors from external nests not supported")
+
+
 class Struct:
     def __init__(self, family, space_name, type_list=None,
                  inherited=None, submsg=None):
-- 
2.49.0


