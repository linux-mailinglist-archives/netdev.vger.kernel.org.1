Return-Path: <netdev+bounces-79780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A57687B5BF
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 01:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1511F2264B
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047D624;
	Thu, 14 Mar 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="EYdry30j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD77F
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710375866; cv=none; b=qQnD1yiJ7WwLD8308LHvYxb+vfxASItTi0u2yIP8opvYsOzSTB1JcY8YwgWf3UfLDXiAXoq0ufIPN1XuIJW7qHZnS5rd7iCd2POonlpz0NkRICK1Yp5l9W2acepW4JGMfNZj0O5uHNIqtE0UjX8CAByoUVfIgB5ojsezwRBM/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710375866; c=relaxed/simple;
	bh=L5O84ryike75MDybfkTk8/Zk67XcfCqweGycbcSyhMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skKa4v0WByqflVJQGmwbLchR9gwDeCsUVvayUYxeSKXYJ6acW4vmcuth+4iL9jHtEvC9keYtK7+Mw/8aGhvLBMoVRoS6p85W/53XcVRaa4+ACwLvIMcWDoW5rGCB1s82deR8KPU2qaVC2ed4njKgONBAMs8QF1YTirH5cWmaAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=EYdry30j; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6cb0f782bso162757b3a.1
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710375863; x=1710980663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YZ7ZIOWTfRsYMyBgPqVgLQEBTT9tUvKsFP1uwbGjVE=;
        b=EYdry30jKUYdjP8CiO1T7fgqJt2kMQqIZQPR/ttrsxVd0PvtA8tmSfx5pryE757Dxd
         Yq3EbEhYbeBbULv67U3FBaEC0qe8VdFSkbwivr8k/QXO+/TRDwZavmGm7XPgknhyXXTZ
         cmEElr7xqL7ObRloDpOXvizcKo7LSuzeCo/n1Rm9FKIpR5RzKkPrjRvvVT7Ewr5uGcwq
         VJGVNwTlvlZIrf+t8qRVa5UZyZKlUlhmxRorEG5R/nMiCPwBalst9OZUDa3hKMdW8a9s
         2kUoN4wpCTErRkVGeJkjZPsVx8MQhtKhJB4ZAcCmxUQcNBihZkbwyPII/XsUS1TAXQDZ
         DWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710375863; x=1710980663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YZ7ZIOWTfRsYMyBgPqVgLQEBTT9tUvKsFP1uwbGjVE=;
        b=AFOJWXgDI/95Thm7E2TTuJ5BuCivB6jw4fK3azoq/UEQk5wpUmpw3QnHqRNcBHeJkp
         1+xoP7xsFTAhwq7uBRl9baEJ0kDRnAhME4kShDGD1O+pZvjDtm/T+GfKZ8v2TR4mjBP4
         74zHZqmm1UZnQ5le1KzvCMw4tKoVU2jp2fmUceXiMvtXIoVKISCvKzs4HnGhXqfZ7jAJ
         dd5xL1chNg6sGqWMPiIfEsGaefXW0POcnAqJ3v8JXP5FOWFq1qiGZA0bbnzNZVj+KhaW
         g40SS0z38iNkgZNsmUf8rksUDfHBSTOJQ/E3Y+O4UDR8MdgroODD2v+P6dXExvFVVepo
         X0Ow==
X-Gm-Message-State: AOJu0YxBsL5LJmbhcxkb5dxRyCllU0udFTGnEqKc8iLyCJC3ezrc94T2
	j5mUvcaNT+pIpDhQUKRiVDOlXv/C3Y3D52kS1PUUqVE8HkYGFrB0GQHzBpB3sdDZ23MpNsKK6T0
	v
X-Google-Smtp-Source: AGHT+IE4gByrxJNavV1lnPykkrqnzLzVBvbxtfkTN6ykn4duc/2UCJctGKdWed3lKwVy3NgYJxpMVA==
X-Received: by 2002:a05:6a20:94cd:b0:1a1:8c6c:2b91 with SMTP id ht13-20020a056a2094cd00b001a18c6c2b91mr563705pzb.27.1710375862867;
        Wed, 13 Mar 2024 17:24:22 -0700 (PDT)
Received: from hermes.lan (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id sz4-20020a17090b2d4400b0029bb1bb298dsm208895pjb.35.2024.03.13.17.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 17:24:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] ematch: support JSON output
Date: Wed, 13 Mar 2024 17:24:08 -0700
Message-ID: <20240314002415.26518-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ematch in filter was missing support JSON output
and therefore would generate bogus output.

Note: support for JSON output with ipt would be difficult
to implement since xtables API doesn't have a JSON API,
and anyway ipt is legacy. Therefore attempts to JSON
output for ematch ipt generates an error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/em_canid.c | 31 +++++++++-------
 tc/em_cmp.c   | 30 ++++++++++------
 tc/em_ipset.c |  9 +++--
 tc/em_ipt.c   |  6 ++++
 tc/em_meta.c  | 99 ++++++++++++++++++++++++++++-----------------------
 tc/em_nbyte.c | 12 ++++---
 tc/em_u32.c   | 10 +++---
 tc/m_ematch.c | 47 +++++++++++++++---------
 8 files changed, 149 insertions(+), 95 deletions(-)

diff --git a/tc/em_canid.c b/tc/em_canid.c
index 228547529134..815ed8c7bce0 100644
--- a/tc/em_canid.c
+++ b/tc/em_canid.c
@@ -154,24 +154,29 @@ static int canid_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 
 		if (pcfltr->can_id & CAN_EFF_FLAG) {
 			if (pcfltr->can_mask == (CAN_EFF_FLAG | CAN_EFF_MASK))
-				fprintf(fd, "eff 0x%"PRIX32,
-						pcfltr->can_id & CAN_EFF_MASK);
-			else
-				fprintf(fd, "eff 0x%"PRIX32":0x%"PRIX32,
-						pcfltr->can_id & CAN_EFF_MASK,
-						pcfltr->can_mask & CAN_EFF_MASK);
+				print_0xhex(PRINT_ANY, "eff", "eff 0x%"PRIX32,
+					    pcfltr->can_id & CAN_EFF_MASK);
+			else {
+				print_0xhex(PRINT_ANY, "eff", "eff 0x%"PRIX32,
+					    pcfltr->can_id & CAN_EFF_MASK);
+				print_0xhex(PRINT_ANY, "mask", ":0x%"PRIX32,
+					    pcfltr->can_mask & CAN_EFF_MASK);
+			}
 		} else {
+			
 			if (pcfltr->can_mask == (CAN_EFF_FLAG | CAN_SFF_MASK))
-				fprintf(fd, "sff 0x%"PRIX32,
-						pcfltr->can_id & CAN_SFF_MASK);
-			else
-				fprintf(fd, "sff 0x%"PRIX32":0x%"PRIX32,
-						pcfltr->can_id & CAN_SFF_MASK,
-						pcfltr->can_mask & CAN_SFF_MASK);
+				print_0xhex(PRINT_ANY, "sff", "sff 0x%"PRIX32,
+					    pcfltr->can_id & CAN_SFF_MASK);
+			else {
+				print_0xhex(PRINT_ANY, "sff", "sff 0x%"PRIX32,
+					    pcfltr->can_id & CAN_SFF_MASK);
+				print_0xhex(PRINT_ANY, "mask", ":0x%"PRIX32,
+					    pcfltr->can_mask & CAN_SFF_MASK);
+			}
 		}
 
 		if ((i + 1) < rules_count)
-			fprintf(fd, " ");
+			print_string(PRINT_FP, NULL, " ", NULL);
 	}
 
 	return 0;
diff --git a/tc/em_cmp.c b/tc/em_cmp.c
index dfd123df1e10..9e2d14077c6c 100644
--- a/tc/em_cmp.c
+++ b/tc/em_cmp.c
@@ -138,6 +138,8 @@ static int cmp_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 			  int data_len)
 {
 	struct tcf_em_cmp *cmp = data;
+	const char *align = NULL;
+	const char *op = NULL;
 
 	if (data_len < sizeof(*cmp)) {
 		fprintf(stderr, "CMP header size mismatch\n");
@@ -145,28 +147,36 @@ static int cmp_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 	}
 
 	if (cmp->align == TCF_EM_ALIGN_U8)
-		fprintf(fd, "u8 ");
+		align = "u8";
 	else if (cmp->align == TCF_EM_ALIGN_U16)
-		fprintf(fd, "u16 ");
+		align = "u16";
 	else if (cmp->align == TCF_EM_ALIGN_U32)
-		fprintf(fd, "u32 ");
+		align = "u32";
 
-	fprintf(fd, "at %d layer %d ", cmp->off, cmp->layer);
+	print_uint(PRINT_JSON, "align", "%u ", cmp->align);
+	if (align)
+		print_string(PRINT_FP, NULL, "%s ", align);
+
+	print_uint(PRINT_ANY, "offset", "at %u ", cmp->off);
+	print_uint(PRINT_ANY, "layer", "layer %u ", cmp->layer);
 
 	if (cmp->mask)
-		fprintf(fd, "mask 0x%x ", cmp->mask);
+		print_0xhex(PRINT_ANY, "mask", "mask 0x%x ", cmp->mask);
 
 	if (cmp->flags & TCF_EM_CMP_TRANS)
-		fprintf(fd, "trans ");
+		print_null(PRINT_ANY, "trans", "trans ", NULL);
 
 	if (cmp->opnd == TCF_EM_OPND_EQ)
-		fprintf(fd, "eq ");
+		op = "eq";
 	else if (cmp->opnd == TCF_EM_OPND_LT)
-		fprintf(fd, "lt ");
+		op = "lt";
 	else if (cmp->opnd == TCF_EM_OPND_GT)
-		fprintf(fd, "gt ");
+		op = "gt";
+
+	if (op)
+		print_string(PRINT_ANY, "opnd", "%s ", op);
 
-	fprintf(fd, "%d", cmp->val);
+	print_uint(PRINT_ANY, "val", "%u", cmp->val);
 
 	return 0;
 }
diff --git a/tc/em_ipset.c b/tc/em_ipset.c
index f97abaf3cfb7..ce2c8e75fc58 100644
--- a/tc/em_ipset.c
+++ b/tc/em_ipset.c
@@ -243,10 +243,15 @@ static int ipset_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 
 	if (get_set_byid(setname, set_info->index))
 		return -1;
-	fputs(setname, fd);
+
+	open_json_array(PRINT_ANY, setname);
+
 	for (i = 1; i <= set_info->dim; i++) {
-		fprintf(fd, "%s%s", i == 1 ? " " : ",", set_info->flags & (1 << i) ? "src" : "dst");
+		print_string(PRINT_FP, NULL, "%s", i == 1 ? " " : ",");
+		print_string(PRINT_ANY, NULL, "%s", 
+			     set_info->flags & (1 << i) ? "src" : "dst");
 	}
+	close_json_array(PRINT_JSON, NULL);
 
 	return 0;
 }
diff --git a/tc/em_ipt.c b/tc/em_ipt.c
index 69efefd8c5e3..6102b5513853 100644
--- a/tc/em_ipt.c
+++ b/tc/em_ipt.c
@@ -175,6 +175,12 @@ static int em_ipt_print_epot(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 	const char *mname;
 	__u8 nfproto;
 
+	/* xtables-legacy doesn't support JSON print so skip it */
+	if (is_json_context()) {
+		fprintf(stderr, "xtables-legacy json not supported\n");
+		return -1;
+	}
+	
 	if (parse_rtattr(tb, TCA_EM_IPT_MAX, data, data_len) < 0)
 		return -1;
 
diff --git a/tc/em_meta.c b/tc/em_meta.c
index 6a5654f3a28b..662596283d12 100644
--- a/tc/em_meta.c
+++ b/tc/em_meta.c
@@ -406,29 +406,38 @@ static int meta_parse_eopt(struct nlmsghdr *n, struct tcf_ematch_hdr *hdr,
 }
 #undef PARSE_ERR
 
-static inline void print_binary(FILE *fd, unsigned char *str, int len)
+static void print_binary(const unsigned char *str, int len)
 {
 	int i;
 
+	if (is_json_context()) {
+		open_json_array(PRINT_JSON, "data");
+
+		for (i = 0; i < len; i++)
+			print_0xhex(PRINT_JSON, NULL, NULL, str[i]);
+		close_json_array(PRINT_JSON, NULL);
+		return;
+	}
+	
 	for (i = 0; i < len; i++)
 		if (!isprint(str[i]))
 			goto binary;
 
 	for (i = 0; i < len; i++)
-		fprintf(fd, "%c", str[i]);
+		putchar(str[i]);
 	return;
 
 binary:
 	for (i = 0; i < len; i++)
-		fprintf(fd, "%02x ", str[i]);
+		printf("%02x ", str[i]);
 
-	fprintf(fd, "\"");
+	putchar ('"');
 	for (i = 0; i < len; i++)
-		fprintf(fd, "%c", isprint(str[i]) ? str[i] : '.');
-	fprintf(fd, "\"");
+		putchar(isprint(str[i]) ? str[i] : '.');
+	putchar ('"');
 }
 
-static inline int print_value(FILE *fd, int type, struct rtattr *rta)
+static int print_value(int type, struct rtattr *rta)
 {
 	if (rta == NULL) {
 		fprintf(stderr, "Missing value TLV\n");
@@ -436,53 +445,51 @@ static inline int print_value(FILE *fd, int type, struct rtattr *rta)
 	}
 
 	switch (type) {
-		case TCF_META_TYPE_INT:
-			if (RTA_PAYLOAD(rta) < sizeof(__u32)) {
-				fprintf(stderr, "meta int type value TLV " \
-				    "size mismatch.\n");
-				return -1;
-			}
-			fprintf(fd, "%d", rta_getattr_u32(rta));
-			break;
+	case TCF_META_TYPE_INT:
+		if (RTA_PAYLOAD(rta) < sizeof(__u32)) {
+			fprintf(stderr,
+				"meta int type value TLV size mismatch.\n");
+			return -1;
+		}
+		print_uint(PRINT_ANY, "value", "%u", rta_getattr_u32(rta));
+		break;
 
-		case TCF_META_TYPE_VAR:
-			print_binary(fd, RTA_DATA(rta), RTA_PAYLOAD(rta));
-			break;
+	case TCF_META_TYPE_VAR:
+		print_binary(RTA_DATA(rta), RTA_PAYLOAD(rta));
+		break;
 	}
 
 	return 0;
 }
 
-static int print_object(FILE *fd, struct tcf_meta_val *obj, struct rtattr *rta)
+static int print_object(struct tcf_meta_val *obj, struct rtattr *rta)
 {
 	int id = TCF_META_ID(obj->kind);
 	int type = TCF_META_TYPE(obj->kind);
 	const struct meta_entry *entry;
 
 	if (id == TCF_META_ID_VALUE)
-		return print_value(fd, type, rta);
+		return print_value(type, rta);
 
 	entry = lookup_meta_entry_byid(id);
 
 	if (entry == NULL)
-		fprintf(fd, "[unknown meta id %d]", id);
+		print_int(PRINT_ANY, "id", "[unknown meta id %d]", id);
 	else
-		fprintf(fd, "%s", entry->kind);
+		print_string(PRINT_ANY, "id", "%s", entry->kind);
 
 	if (obj->shift)
-		fprintf(fd, " shift %d", obj->shift);
+		print_int(PRINT_ANY, "shift", " shift %d", obj->shift);
 
-	switch (type) {
-		case TCF_META_TYPE_INT:
-			if (rta) {
-				if (RTA_PAYLOAD(rta) < sizeof(__u32))
-					goto size_mismatch;
+	if (type == TCF_META_TYPE_INT && rta) {
+		__u32 mask;
+			
+		if (RTA_PAYLOAD(rta) < sizeof(__u32))
+			goto size_mismatch;
 
-				if (rta_getattr_u32(rta))
-					fprintf(fd, " mask 0x%08x",
-						rta_getattr_u32(rta));
-			}
-			break;
+		mask = rta_getattr_u32(rta);
+		if (mask)
+			print_0xhex(PRINT_ANY, "mask", " mask 0x%08x", mask);
 	}
 
 	return 0;
@@ -498,6 +505,7 @@ static int meta_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 {
 	struct rtattr *tb[TCA_EM_META_MAX+1];
 	struct tcf_meta_hdr *meta_hdr;
+	const char *op = NULL;
 
 	if (parse_rtattr(tb, TCA_EM_META_MAX, data, data_len) < 0)
 		return -1;
@@ -514,22 +522,25 @@ static int meta_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 
 	meta_hdr = RTA_DATA(tb[TCA_EM_META_HDR]);
 
-	if (print_object(fd, &meta_hdr->left, tb[TCA_EM_META_LVALUE]) < 0)
+	if (print_object(&meta_hdr->left, tb[TCA_EM_META_LVALUE]) < 0)
 		return -1;
 
 	switch (meta_hdr->left.op) {
-		case TCF_EM_OPND_EQ:
-			fprintf(fd, " eq ");
-			break;
-		case TCF_EM_OPND_LT:
-			fprintf(fd, " lt ");
-			break;
-		case TCF_EM_OPND_GT:
-			fprintf(fd, " gt ");
-			break;
+	case TCF_EM_OPND_EQ:
+		op = "eq";
+		break;
+	case TCF_EM_OPND_LT:
+		op = "lt";
+		break;
+	case TCF_EM_OPND_GT:
+		op = "gt";
+		break;
 	}
 
-	return print_object(fd, &meta_hdr->right, tb[TCA_EM_META_RVALUE]);
+	if (op)
+		print_string(PRINT_ANY, "opnd", " %s ", op);
+
+	return print_object(&meta_hdr->right, tb[TCA_EM_META_RVALUE]);
 }
 
 struct ematch_util meta_ematch_util = {
diff --git a/tc/em_nbyte.c b/tc/em_nbyte.c
index 9f421fb423a6..cfcd1b413baa 100644
--- a/tc/em_nbyte.c
+++ b/tc/em_nbyte.c
@@ -116,13 +116,17 @@ static int nbyte_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 
 	needle = data + sizeof(*nb);
 
+	open_json_array(PRINT_JSON, "needle");
 	for (i = 0; i < nb->len; i++)
-		fprintf(fd, "%02x ", needle[i]);
+		print_0xhex(PRINT_ANY, NULL, "%02x ", needle[i]);
 
-	fprintf(fd, "\"");
+	close_json_array(PRINT_ANY, "\"");
 	for (i = 0; i < nb->len; i++)
-		fprintf(fd, "%c", isprint(needle[i]) ? needle[i] : '.');
-	fprintf(fd, "\" at %d layer %d", nb->off, nb->layer);
+		print_0xhex(PRINT_FP, NULL, "%c",
+			    isprint(needle[i]) ? needle[i] : '.');
+
+	print_uint(PRINT_ANY, "offset", "\" at %u ", nb->off);
+	print_uint(PRINT_ANY, "layer", "layer %u", nb->layer);
 
 	return 0;
 }
diff --git a/tc/em_u32.c b/tc/em_u32.c
index a83382ba4417..88feb0de8317 100644
--- a/tc/em_u32.c
+++ b/tc/em_u32.c
@@ -153,11 +153,11 @@ static int u32_print_eopt(FILE *fd, struct tcf_ematch_hdr *hdr, void *data,
 		return -1;
 	}
 
-	fprintf(fd, "%08x/%08x at %s%d",
-	    (unsigned int) ntohl(u_key->val),
-	    (unsigned int) ntohl(u_key->mask),
-	    u_key->offmask ? "nexthdr+" : "",
-	    u_key->off);
+	print_0xhex(PRINT_ANY, "val", "%08x", ntohl(u_key->val));
+	print_0xhex(PRINT_ANY, "mask", "/%08x at ", ntohl(u_key->mask));
+	if (u_key->offmask)
+		print_null(PRINT_ANY, "nexthdr", "nexthdr+", NULL);
+	print_int(PRINT_ANY, "offset", "%d", u_key->off);
 
 	return 0;
 }
diff --git a/tc/m_ematch.c b/tc/m_ematch.c
index fefc78608d6f..81590ad18011 100644
--- a/tc/m_ematch.c
+++ b/tc/m_ematch.c
@@ -390,10 +390,18 @@ int parse_ematch(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n)
 	return 0;
 }
 
+static void print_ematch_indent(int prefix)
+{
+	int n;
+	
+	for (n = 0; n < prefix; n++)
+		print_string(PRINT_FP, NULL, "  ", NULL);
+}
+
 static int print_ematch_seq(FILE *fd, struct rtattr **tb, int start,
 			    int prefix)
 {
-	int n, i = start;
+	int i = start;
 	struct tcf_ematch_hdr *hdr;
 	int dlen;
 	void *data;
@@ -411,7 +419,7 @@ static int print_ematch_seq(FILE *fd, struct rtattr **tb, int start,
 		hdr = RTA_DATA(tb[i]);
 
 		if (hdr->flags & TCF_EM_INVERT)
-			fprintf(fd, "NOT ");
+			print_null(PRINT_ANY, "not", "NOT ", NULL);
 
 		if (hdr->kind == 0) {
 			__u32 ref;
@@ -420,40 +428,45 @@ static int print_ematch_seq(FILE *fd, struct rtattr **tb, int start,
 				return -1;
 
 			ref = *(__u32 *) data;
-			fprintf(fd, "(\n");
-			for (n = 0; n <= prefix; n++)
-				fprintf(fd, "  ");
+			print_string(PRINT_FP, NULL, "(%s", _SL_);
+			print_ematch_indent(prefix);
+			open_json_object("match");
+			
 			if (print_ematch_seq(fd, tb, ref + 1, prefix + 1) < 0)
 				return -1;
-			for (n = 0; n < prefix; n++)
-				fprintf(fd, "  ");
-			fprintf(fd, ") ");
+
+			close_json_object();
+			print_ematch_indent(prefix);
+			print_string(PRINT_FP, NULL, ") ", NULL);
 
 		} else {
 			struct ematch_util *e;
 
 			e = get_ematch_kind_num(hdr->kind);
 			if (e == NULL)
-				fprintf(fd, "[unknown ematch %d]\n",
-				    hdr->kind);
+				fprintf(stderr, "[unknown ematch %d]\n",
+					hdr->kind);
 			else {
-				fprintf(fd, "%s(", e->kind);
+				print_string(PRINT_FP, NULL, "%s(", e->kind);
+				open_json_object(e->kind);
+
 				if (e->print_eopt(fd, hdr, data, dlen) < 0)
 					return -1;
-				fprintf(fd, ")\n");
+
+				close_json_object();
+				print_string(PRINT_FP, NULL, ")%s", _SL_);
 			}
 			if (hdr->flags & TCF_EM_REL_MASK)
-				for (n = 0; n < prefix; n++)
-					fprintf(fd, "  ");
+				print_ematch_indent(prefix);
 		}
 
 		switch (hdr->flags & TCF_EM_REL_MASK) {
 			case TCF_EM_REL_AND:
-				fprintf(fd, "AND ");
+				print_null(PRINT_ANY, "and", "AND ", NULL);
 				break;
 
 			case TCF_EM_REL_OR:
-				fprintf(fd, "OR ");
+				print_null(PRINT_ANY, "or",  "OR ", NULL);
 				break;
 
 			default:
@@ -480,7 +493,7 @@ static int print_ematch_list(FILE *fd, struct tcf_ematch_tree_hdr *hdr,
 		if (parse_rtattr_nested(tb, hdr->nmatches, rta) < 0)
 			goto errout;
 
-		fprintf(fd, "\n  ");
+		print_string(PRINT_FP, NULL, "%s  ", _SL_);
 		if (print_ematch_seq(fd, tb, 1, 1) < 0)
 			goto errout;
 	}
-- 
2.43.0


