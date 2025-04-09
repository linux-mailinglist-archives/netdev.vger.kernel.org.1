Return-Path: <netdev+bounces-180528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD57BA81995
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E4C1900316
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5E2B2CF;
	Wed,  9 Apr 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQjQRRWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DA2AEE1
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157067; cv=none; b=Kpyrl+JBjo/veze48gYbhJ0kIACl0pOR/B+kAOOV7tHJF2YYkWvjaUGTB20qZTA/rflFybg1JyZhtH15tCGGRBRRfKeIOAJIyQfTo+xwdwrafBYo376DLXOzj3DkuZskSg1cXk7SZZxpeAc7t+mLUuukD59wGWXmNH+tdEvm4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157067; c=relaxed/simple;
	bh=WA3K01+amqsIlW1NqwzGiquAfdjsMHpFI8PKdliB2IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgAkmOeP9KN9tuLZFp6paLz/E/99KiLLBTYqRIFf2+7ffrA5KFzQ7U2dlggYf8mK2thYL8OD/a7E7XL87x76gIC07oJpDy0WH7a7vyuwocSBvPewrL3CJO1vz7M2Tk36d39C35sOUuZEFqxMasnm0XYyTU3TSO3GZJZp6BtSygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQjQRRWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA76C4CEE5;
	Wed,  9 Apr 2025 00:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157067;
	bh=WA3K01+amqsIlW1NqwzGiquAfdjsMHpFI8PKdliB2IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQjQRRWFOtte8/DBH8o30NW1odoVHZbMzcXQNkoIUCe2OA9NAduVWiOgm2777zpn2
	 weOuJ4R35RBHXv8+N6AJ/ZglsTUUMp/nHjiszh1CCgf8NnLW9N5yJLLvLse5buqFtR
	 P3h16dBzFOmYY4V6G4aUZlZB5TISING0qM2ImFSp+2fJsZQMCanZ7UZ2Xjc7F7MLtK
	 00yiyAEbsoYHOVAlMPcMtQMsaycWC9SbhGKjHlHlUFsZc/fCgzC3l4K5ddC1pdtoia
	 qg9Qt5YLxArtWnpfTyCDK0LiKAamZzomiGipezxUhOx5YMS7OJRPmHX6728Gy6jwE5
	 03c9rOK2pNZ8A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/13] tools: ynl: support creating non-genl sockets
Date: Tue,  8 Apr 2025 17:03:54 -0700
Message-ID: <20250409000400.492371-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Classic netlink has static family IDs specified in YAML,
there is no family name -> ID lookup. Support providing
the ID info to the library via the generated struct and
make library use it. Since NETLINK_ROUTE is ID 0 we need
an extra boolean to indicate classic_id is to be used.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.h          |  3 ++
 tools/net/ynl/lib/ynl.c          | 51 +++++++++++++++++++++-----------
 tools/net/ynl/pyynl/ynl_gen_c.py |  9 ++++--
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 6cd570b283ea..59256e258130 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -2,6 +2,7 @@
 #ifndef __YNL_C_H
 #define __YNL_C_H 1
 
+#include <stdbool.h>
 #include <stddef.h>
 #include <linux/genetlink.h>
 #include <linux/types.h>
@@ -48,6 +49,8 @@ struct ynl_family {
 /* private: */
 	const char *name;
 	size_t hdr_len;
+	bool is_classic;
+	__u16 classic_id;
 	const struct ynl_ntf_info *ntf_info;
 	unsigned int ntf_info_size;
 };
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index ce32cb35007d..b9fda1a99453 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -663,6 +663,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	struct sockaddr_nl addr;
 	struct ynl_sock *ys;
 	socklen_t addrlen;
+	int sock_type;
 	int one = 1;
 
 	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
@@ -675,7 +676,9 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	ys->rx_buf = &ys->raw_buf[YNL_SOCKET_BUFFER_SIZE];
 	ys->ntf_last_next = &ys->ntf_first;
 
-	ys->socket = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	sock_type = yf->is_classic ? yf->classic_id : NETLINK_GENERIC;
+
+	ys->socket = socket(AF_NETLINK, SOCK_RAW, sock_type);
 	if (ys->socket < 0) {
 		__perr(yse, "failed to create a netlink socket");
 		goto err_free_sock;
@@ -708,8 +711,9 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	ys->portid = addr.nl_pid;
 	ys->seq = random();
 
-
-	if (ynl_sock_read_family(ys, yf->name)) {
+	if (yf->is_classic) {
+		ys->family_id = yf->classic_id;
+	} else if (ynl_sock_read_family(ys, yf->name)) {
 		if (yse)
 			memcpy(yse, &ys->err, sizeof(*yse));
 		goto err_close_sock;
@@ -791,13 +795,21 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	struct ynl_parse_arg yarg = { .ys = ys, };
 	const struct ynl_ntf_info *info;
 	struct ynl_ntf_base_type *rsp;
-	struct genlmsghdr *gehdr;
+	__u32 cmd;
 	int ret;
 
-	gehdr = ynl_nlmsg_data(nlh);
-	if (gehdr->cmd >= ys->family->ntf_info_size)
+	if (ys->family->is_classic) {
+		cmd = nlh->nlmsg_type;
+	} else {
+		struct genlmsghdr *gehdr;
+
+		gehdr = ynl_nlmsg_data(nlh);
+		cmd = gehdr->cmd;
+	}
+
+	if (cmd >= ys->family->ntf_info_size)
 		return YNL_PARSE_CB_ERROR;
-	info = &ys->family->ntf_info[gehdr->cmd];
+	info = &ys->family->ntf_info[cmd];
 	if (!info->cb)
 		return YNL_PARSE_CB_ERROR;
 
@@ -811,7 +823,7 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 		goto err_free;
 
 	rsp->family = nlh->nlmsg_type;
-	rsp->cmd = gehdr->cmd;
+	rsp->cmd = cmd;
 
 	*ys->ntf_last_next = rsp;
 	ys->ntf_last_next = &rsp->next;
@@ -863,18 +875,23 @@ int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg)
 static int
 ynl_check_alien(struct ynl_sock *ys, const struct nlmsghdr *nlh, __u32 rsp_cmd)
 {
-	struct genlmsghdr *gehdr;
+	if (ys->family->is_classic) {
+		if (nlh->nlmsg_type != rsp_cmd)
+			return ynl_ntf_parse(ys, nlh);
+	} else {
+		struct genlmsghdr *gehdr;
 
-	if (ynl_nlmsg_data_len(nlh) < sizeof(*gehdr)) {
-		yerr(ys, YNL_ERROR_INV_RESP,
-		     "Kernel responded with truncated message");
-		return -1;
+		if (ynl_nlmsg_data_len(nlh) < sizeof(*gehdr)) {
+			yerr(ys, YNL_ERROR_INV_RESP,
+			     "Kernel responded with truncated message");
+			return -1;
+		}
+
+		gehdr = ynl_nlmsg_data(nlh);
+		if (gehdr->cmd != rsp_cmd)
+			return ynl_ntf_parse(ys, nlh);
 	}
 
-	gehdr = ynl_nlmsg_data(nlh);
-	if (gehdr->cmd != rsp_cmd)
-		return ynl_ntf_parse(ys, nlh);
-
 	return 0;
 }
 
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index a1427c537030..9e00aac4801c 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -971,9 +971,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def resolve(self):
         self.resolve_up(super())
 
-        if self.yaml.get('protocol', 'genetlink') not in {'genetlink', 'genetlink-c', 'genetlink-legacy'}:
-            raise Exception("Codegen only supported for genetlink")
-
         self.c_name = c_lower(self.ident_name)
         if 'name-prefix' in self.yaml['operations']:
             self.op_prefix = c_upper(self.yaml['operations']['name-prefix'])
@@ -1020,6 +1017,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def new_operation(self, elem, req_value, rsp_value):
         return Operation(self, elem, req_value, rsp_value)
 
+    def is_classic(self):
+        return self.proto == 'netlink-raw'
+
     def _mark_notify(self):
         for op in self.msgs.values():
             if 'notify' in op:
@@ -2730,6 +2730,9 @@ _C_KW = {
 
     cw.block_start(f'{symbol} = ')
     cw.p(f'.name\t\t= "{family.c_name}",')
+    if family.is_classic():
+        cw.p(f'.is_classic\t= true,')
+        cw.p(f'.classic_id\t= {family.get("protonum")},')
     if family.fixed_header:
         cw.p(f'.hdr_len\t= sizeof(struct genlmsghdr) + sizeof(struct {c_lower(family.fixed_header)}),')
     else:
-- 
2.49.0


