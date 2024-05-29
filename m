Return-Path: <netdev+bounces-99177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ACF8D3ED6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A710F1F22A1C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A73815A861;
	Wed, 29 May 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIHO5j6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46306522A
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010434; cv=none; b=glE+nUp/pGpCJc68svZojWmIyMhFVPGQq5+lkcL2e9MtzsgWrmc1xpvHyvuoXXM2qADfy4Fta/t5WUyigV3IFk4nYRMR+NEPCjIvFfJFZUKc9jlszZ/eIMCr7zRrhdmYfDTRZEzvVqOY9IPj9AgqJkSSnF4JdnOquDGXJh9volM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010434; c=relaxed/simple;
	bh=4rBiJ+uhC2f87vGmlbeK+ozZSaHxHU1jMFjrX6aHqVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDba4zunHuW4uk3EgbtqBdCCXSdBoIgMtmr8cmkQqMhN4+YWMPavTVGAXArUEIfDfqzbxaz3EquWwyDD0B/7wAFPZOkVEsqZFaVRBY2Y4IAW+82iTTbytjijV5zoWVHlRND8loId/HTBVqwyIc/aCqZ3lycJOxq/g3lrHwU+fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIHO5j6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BB4C113CC;
	Wed, 29 May 2024 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717010433;
	bh=4rBiJ+uhC2f87vGmlbeK+ozZSaHxHU1jMFjrX6aHqVo=;
	h=From:To:Cc:Subject:Date:From;
	b=HIHO5j6MdpgyfiIkZIbpIjcwSKsUCox+7uvU4YcCKLLV8X1hpUrYfQ6yzdh75Yuan
	 97TV86HWbVwN3NWqLbtRyWcpIJ9V26LKaEekXTQCG704RW4wc5RDhABHFnJgEyi7k2
	 SnApyfCw+1BNrloDNvB767jLFenCMFPcag2+DIOPkn10LTmnqhhYWJJyEN9vRIBSZ1
	 q2RQc0MWzDqXzfoW8v2IpjjxtsiShbBTyQxALq8O3HSgIzHn3OR815D9adQHKh8HaY
	 ym+TrdLxP22i78wW8aFLIIR/DHTCTPTBuL2YAz0P/GT2XjOM2SvP6zj9++Sdtt7+b8
	 ohR1vM0IYG5+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next] tools: ynl: make the attr and msg helpers more C++ friendly
Date: Wed, 29 May 2024 12:20:31 -0700
Message-ID: <20240529192031.3785761-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Folks working on a C++ codegen would like to reuse the attribute
helpers directly. Add the few necessary casts, it's not too ugly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: nicolas.dichtel@6wind.com
---
 tools/net/ynl/lib/ynl-priv.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 6cf890080dc0..80791c34730c 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -79,7 +79,7 @@ static inline void *ynl_dump_obj_next(void *obj)
 	struct ynl_dump_list_type *list;
 
 	uptr -= offsetof(struct ynl_dump_list_type, data);
-	list = (void *)uptr;
+	list = (struct ynl_dump_list_type *)uptr;
 	uptr = (unsigned long)list->next;
 	uptr += offsetof(struct ynl_dump_list_type, data);
 
@@ -139,7 +139,7 @@ int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
 
 static inline struct nlmsghdr *ynl_nlmsg_put_header(void *buf)
 {
-	struct nlmsghdr *nlh = buf;
+	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
 
 	memset(nlh, 0, sizeof(*nlh));
 	nlh->nlmsg_len = NLMSG_HDRLEN;
@@ -196,7 +196,7 @@ static inline void *ynl_attr_data(const struct nlattr *attr)
 
 static inline void *ynl_attr_data_end(const struct nlattr *attr)
 {
-	return ynl_attr_data(attr) + ynl_attr_data_len(attr);
+	return (char *)ynl_attr_data(attr) + ynl_attr_data_len(attr);
 }
 
 #define ynl_attr_for_each(attr, nlh, fixed_hdr_sz)			\
@@ -228,7 +228,7 @@ ynl_attr_next(const void *end, const struct nlattr *prev)
 {
 	struct nlattr *attr;
 
-	attr = (void *)((char *)prev + NLA_ALIGN(prev->nla_len));
+	attr = (struct nlattr *)((char *)prev + NLA_ALIGN(prev->nla_len));
 	return ynl_attr_if_good(end, attr);
 }
 
@@ -237,8 +237,8 @@ ynl_attr_first(const void *start, size_t len, size_t skip)
 {
 	struct nlattr *attr;
 
-	attr = (void *)((char *)start + NLMSG_ALIGN(skip));
-	return ynl_attr_if_good(start + len, attr);
+	attr = (struct nlattr *)((char *)start + NLMSG_ALIGN(skip));
+	return ynl_attr_if_good((char *)start + len, attr);
 }
 
 static inline bool
@@ -262,9 +262,9 @@ ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
 	struct nlattr *attr;
 
 	if (__ynl_attr_put_overflow(nlh, 0))
-		return ynl_nlmsg_end_addr(nlh) - NLA_HDRLEN;
+		return (struct nlattr *)ynl_nlmsg_end_addr(nlh) - 1;
 
-	attr = ynl_nlmsg_end_addr(nlh);
+	attr = (struct nlattr *)ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type | NLA_F_NESTED;
 	nlh->nlmsg_len += NLA_HDRLEN;
 
@@ -286,7 +286,7 @@ ynl_attr_put(struct nlmsghdr *nlh, unsigned int attr_type,
 	if (__ynl_attr_put_overflow(nlh, size))
 		return;
 
-	attr = ynl_nlmsg_end_addr(nlh);
+	attr = (struct nlattr *)ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type;
 	attr->nla_len = NLA_HDRLEN + size;
 
@@ -305,10 +305,10 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
 	if (__ynl_attr_put_overflow(nlh, len))
 		return;
 
-	attr = ynl_nlmsg_end_addr(nlh);
+	attr = (struct nlattr *)ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type;
 
-	strcpy(ynl_attr_data(attr), str);
+	strcpy((char *)ynl_attr_data(attr), str);
 	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
 
 	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
-- 
2.45.1


