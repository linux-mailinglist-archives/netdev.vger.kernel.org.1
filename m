Return-Path: <netdev+bounces-238869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A0C60913
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 18:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5637354089
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77521D00A;
	Sat, 15 Nov 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zRMbXJvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB41DD0D4
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227212; cv=none; b=WuGzFeSCsZ62/NZA/mnn+B0g7jDjT8f556wZnuvoxIXXPSsCGNyqHBErioeB91YMXAJVD6JFHi2CDM6XQqlDgzrVt8PW9YKwzbnTegrhpQAZ8Lv8y/k/xQ9SCntCoPzgWI+RIVlmfzyQjL0UWIiv0QYyDkjxz/AIhMtQZpeRzJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227212; c=relaxed/simple;
	bh=Fvg+zSa33OzBJik8GobBe1itJBeFf8IE31MdO3o/JA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wcgc5Ljoo3J7EMMMmWqzRcyDkv7lqnLP88rrEOJDGnBn5S3QTop04QtNdfgzgkzQqfN8fruflmsRGc6pHq5Z0KIBPstpruNzYr4XCAeb4tQohUkELXZHmrFBMHvTHWKUbCHkihWperNQvmXRswraEbYaDr/yfR6oifylyNwcFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=zRMbXJvF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so1708059a12.2
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763227209; x=1763832009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PItxQzz5S9pJJjPVcp/gtL09P5itjOWKBUyNof04qU=;
        b=zRMbXJvFcC5Bhs/+gN0ezkWUyesp8YVwWf3CwkLfqzuXi//+L+9ZC2W93/k6OJvk3+
         UJ/DQXeUqLm6MqKsqtbB+Lmi17QRuBeDOgpG1cvM7vRYAafDKxg/gAg4WmH6X5d5/+Eu
         O0D+7SN3+fSqOAw9lKPjtJARoECWGvNy6lmHK1vWFQ4KBjDcHlrQRef7uukHDoNvOpiG
         Vmq339Eyz9voaYKiDTyMEF/dVRV2+yJ8/tsXJ6ZUc0pRwyM+4iwAc1yA2SoQ18wtcUdd
         ptgIUV9FffHS+G79JzQYvPNT/zSnch/RLwrI079YuQlVIXspA10YpJf/DvHnhS2/KS24
         9BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763227209; x=1763832009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PItxQzz5S9pJJjPVcp/gtL09P5itjOWKBUyNof04qU=;
        b=Xh4Bisd7H2q6VSNqfedZcHea3atJKDx0qeVXgwLc3Vk1aeX++ddMtiGDGxsokk4lAe
         WY9C0uczNCuilAfrKV5hwmFPYgeFZPvBDDYRjR0miiD74xdroxLqqWoU4DNijMwt3Chk
         HYM2BJoA2G0hBhwGB/Huz5mMgymWwOBq4jqi8UoFMSQOeJgyEwz1ObJpaGr8e81xe45t
         jzOLbKH48goAKZiyRghG9a4Jzzxw1n2XM7KvjX9YNWk6sq3y4pQklAnm9x7wR3l/fbz0
         1/cF05VMQ1vzgi/tYdX5zYQBaZtbxTs9aRlT9FrxKFqu19jAOWrr1DqQsNlkmVUEiXM3
         6lvQ==
X-Gm-Message-State: AOJu0Yx58ID9vVNiKLEqhXJX+4N8GjPNRynsyNIJfTYysMK66FCcfTfV
	0H9A5XMT3TuJ4IEziPLvw1hEx9uOpfjOk2m5Mg5YS9N/cIf3zC8uhBPb3zQDWbK+MSv62a8xKhW
	4ddN1
X-Gm-Gg: ASbGnctTRZwM6bnzv7s9TW7cCDp75/sAN2gpKQeoFekdgArh4AtCZ7KE7jkziF2lksP
	JM6WgZ0IjGhpx0j7oVsM9zUg/Vn+ipv24SKdf9acXeZD+GlYQw0yhKa8qg7ptKI4BHFua9sqqvL
	L+vh2neUDa7vIPGPMnqoY3mYPBIxRcR4nf+OfwngCjsXSsVAdsTOb5m14W6YE2s80aIbPXoqjTF
	foIxyMR7sslR+CV7rZhuZW0Fm8iRlKKbgod65pPESo01bQIzkhalaOTE0CREaDKy/Q6RltW/e7V
	B0BYzlCToKIHLYNNdCm6pEKLK3g+5Xt8+/ED5m0W+yQV+/2PRje493Z3u95pkMF1ITMPL+s+GDd
	OUZtuH22njjN1Oh9r53/UhO4leSoYqqLh02qan9NXL1aQHWUF/v6SlDLikmvdBp4wpDnCeSeIpA
	iNvIhslnKWKG6TAc0uBea3EQ68teFKJnj2nx0kbqskl/FF0dhFLMVPmxeVzQAC
X-Google-Smtp-Source: AGHT+IHvPYw688QD9zWzTiaZ6h9T7U48Fzyljc+q+IWKq6touzyDtIeSFYyTd3MKPu09p9mqNi9fWA==
X-Received: by 2002:a05:7301:162c:b0:2a4:6ff4:ab9c with SMTP id 5a478bee46e88-2a4abb1dc98mr1903280eec.17.1763227208565;
        Sat, 15 Nov 2025 09:20:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d695821sm27382524eec.0.2025.11.15.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:20:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v2 1/2] genl: add json support
Date: Sat, 15 Nov 2025 09:19:16 -0800
Message-ID: <20251115171958.1517032-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup the old code and support for JSON output.
The non-json output is the same as before the patch.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - shorten lines and extra blanks in non-json output

 genl/ctrl.c          | 261 ++++++++++++++++++++++++-------------------
 genl/genl.c          |   8 +-
 include/libnetlink.h |   2 +-
 lib/libnetlink.c     |  87 +++++++++------
 man/man8/genl.8      |  16 ++-
 5 files changed, 218 insertions(+), 156 deletions(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index 72a9b013..17930b30 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -36,66 +36,143 @@ static int usage(void)
 	return -1;
 }
 
-static void print_ctrl_cmd_flags(FILE *fp, __u32 fl)
+static void
+print_ctrl_flag(const char *json_str, const char *fp_str)
 {
-	fprintf(fp, "\n\t\tCapabilities (0x%x):\n ", fl);
-	if (!fl) {
-		fprintf(fp, "\n");
-		return;
-	}
-	fprintf(fp, "\t\t ");
+	print_string(PRINT_JSON, NULL, NULL, json_str);
+	print_string(PRINT_FP, NULL, " %s", fp_str);
+}
+
+static void print_ctrl_cmd_flags(__u32 fl)
+{
+	print_0xhex(PRINT_FP, "flags", "\n\t\tCapabilities (0x%x):\n ", fl);
+	open_json_array(PRINT_JSON, "capabilities");
+
+	if (fl != 0)
+		print_string(PRINT_FP, NULL, "\t\t ", NULL);
 
 	if (fl & GENL_ADMIN_PERM)
-		fprintf(fp, " requires admin permission;");
+		print_ctrl_flag("admin", "requires admin permission;");
 	if (fl & GENL_CMD_CAP_DO)
-		fprintf(fp, " can doit;");
+		print_ctrl_flag("do", "can doit;");
 	if (fl & GENL_CMD_CAP_DUMP)
-		fprintf(fp, " can dumpit;");
+		print_ctrl_flag("dump", "can dumpit;");
 	if (fl & GENL_CMD_CAP_HASPOL)
-		fprintf(fp, " has policy");
-
-	fprintf(fp, "\n");
+		print_ctrl_flag("policy", "has policy");
+	close_json_array(PRINT_ANY, "\n");
 }
 
-static int print_ctrl_cmds(FILE *fp, struct rtattr *arg)
+static void
+print_ctrl_cmd(const struct rtattr *arg)
 {
 	struct rtattr *tb[CTRL_ATTR_OP_MAX + 1];
 
-	if (arg == NULL)
-		return -1;
-
 	parse_rtattr_nested(tb, CTRL_ATTR_OP_MAX, arg);
-	if (tb[CTRL_ATTR_OP_ID]) {
-		__u32 *id = RTA_DATA(tb[CTRL_ATTR_OP_ID]);
-		fprintf(fp, " ID-0x%x ",*id);
-	}
+	if (tb[CTRL_ATTR_OP_ID])
+		print_0xhex(PRINT_ANY, "id", " ID-0x%x ",
+			    rta_getattr_u32(tb[CTRL_ATTR_OP_ID]));
+
 	/* we are only gonna do this for newer version of the controller */
-	if (tb[CTRL_ATTR_OP_FLAGS]) {
-		__u32 *fl = RTA_DATA(tb[CTRL_ATTR_OP_FLAGS]);
-		print_ctrl_cmd_flags(fp, *fl);
+	if (tb[CTRL_ATTR_OP_FLAGS])
+		print_ctrl_cmd_flags(rta_getattr_u32(tb[CTRL_ATTR_OP_FLAGS]));
+}
+
+static void
+print_ctrl_ops(const struct rtattr *attr)
+{
+	struct rtattr *tb2[GENL_MAX_FAM_OPS];
+	unsigned int i;
+
+	parse_rtattr_nested(tb2, GENL_MAX_FAM_OPS, attr);
+
+	open_json_array(PRINT_JSON, "operations");
+	print_string(PRINT_FP, NULL, "\tcommands supported: \n", NULL);
+
+	for (i = 0; i < GENL_MAX_FAM_OPS; i++) {
+		if (!tb2[i])
+			continue;
+
+		open_json_object(NULL);
+		print_uint(PRINT_FP, NULL, "\t\t#%u: ", i);
+		print_ctrl_cmd(tb2[i]);
+		print_string(PRINT_FP, NULL, "\n", NULL);
+		close_json_object();
 	}
-	return 0;
 
+	/* end of family::cmds definitions .. */
+	close_json_array(PRINT_JSON, NULL);
+	print_string(PRINT_FP, NULL, "\n", NULL);
 }
 
-static int print_ctrl_grp(FILE *fp, struct rtattr *arg)
+static void print_ctrl_grp(const struct rtattr *arg)
 {
 	struct rtattr *tb[CTRL_ATTR_MCAST_GRP_MAX + 1];
 
-	if (arg == NULL)
-		return -1;
+	open_json_object(NULL);
 
 	parse_rtattr_nested(tb, CTRL_ATTR_MCAST_GRP_MAX, arg);
-	if (tb[2]) {
-		__u32 *id = RTA_DATA(tb[CTRL_ATTR_MCAST_GRP_ID]);
-		fprintf(fp, " ID-0x%x ",*id);
+	if (tb[CTRL_ATTR_MCAST_GRP_ID])
+		print_0xhex(PRINT_ANY, "id", " ID-0x%x ",
+			    rta_getattr_u32(tb[CTRL_ATTR_MCAST_GRP_ID]));
+	if (tb[CTRL_ATTR_MCAST_GRP_NAME]) {
+		const char *name = RTA_DATA(tb[CTRL_ATTR_MCAST_GRP_NAME]);
+		print_string(PRINT_ANY, "name", " name: %s ", name);
 	}
-	if (tb[1]) {
-		char *name = RTA_DATA(tb[CTRL_ATTR_MCAST_GRP_NAME]);
-		fprintf(fp, " name: %s ", name);
+	close_json_object();
+}
+
+static void print_ops(const struct rtattr *attr)
+{
+	const struct rtattr *pos;
+
+	open_json_array(PRINT_JSON, "op");
+
+	rtattr_for_each_nested(pos, attr) {
+		struct rtattr *ptb[CTRL_ATTR_POLICY_DUMP_MAX + 1];
+		struct rtattr *pattrs = RTA_DATA(pos);
+		int plen = RTA_PAYLOAD(pos);
+
+		parse_rtattr_flags(ptb, CTRL_ATTR_POLICY_DUMP_MAX, pattrs, plen, NLA_F_NESTED);
+
+		print_uint(PRINT_ANY, "bits", " op %d policies:",
+			   pos->rta_type & ~NLA_F_NESTED);
+
+		if (ptb[CTRL_ATTR_POLICY_DO])
+			print_uint(PRINT_ANY, "do", " do=%u",
+				   rta_getattr_u32(ptb[CTRL_ATTR_POLICY_DO]));
+
+		if (ptb[CTRL_ATTR_POLICY_DUMP])
+			print_uint(PRINT_ANY, "dump", " dump=%d",
+				   rta_getattr_u32(ptb[CTRL_ATTR_POLICY_DUMP]));
+
 	}
-	return 0;
+	close_json_array(PRINT_JSON, NULL);
+}
+
+static void print_ctrl_mcast(const struct rtattr *attr)
+{
+	struct rtattr *tb2[GENL_MAX_FAM_GRPS + 1];
+	unsigned int i;
+
+	parse_rtattr_nested(tb2, GENL_MAX_FAM_GRPS, attr);
 
+	open_json_array(PRINT_JSON, "mcast");
+	print_string(PRINT_FP, NULL, "\tmulticast groups:\n", NULL);
+
+	for (i = 0; i < GENL_MAX_FAM_GRPS; i++) {
+		if (!tb2[i])
+			continue;
+
+		print_uint(PRINT_FP, NULL, "\t\t#%d: ", i);
+		print_ctrl_grp(tb2[i]);
+
+		/* for next group */
+		print_string(PRINT_FP, NULL, "\n", NULL);
+	}
+
+	/* end of family::groups definitions .. */
+	close_json_array(PRINT_JSON, NULL);
+	print_string(PRINT_FP, NULL, "\n", NULL);
 }
 
 /*
@@ -137,98 +214,40 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 	parse_rtattr_flags(tb, CTRL_ATTR_MAX, attrs, len, NLA_F_NESTED);
 
 	if (tb[CTRL_ATTR_FAMILY_NAME]) {
-		char *name = RTA_DATA(tb[CTRL_ATTR_FAMILY_NAME]);
-		fprintf(fp, "\nName: %s\n",name);
-	}
-	if (tb[CTRL_ATTR_FAMILY_ID]) {
-		__u16 *id = RTA_DATA(tb[CTRL_ATTR_FAMILY_ID]);
-		fprintf(fp, "\tID: 0x%x ",*id);
-	}
-	if (tb[CTRL_ATTR_VERSION]) {
-		__u32 *v = RTA_DATA(tb[CTRL_ATTR_VERSION]);
-		fprintf(fp, " Version: 0x%x ",*v);
-	}
-	if (tb[CTRL_ATTR_HDRSIZE]) {
-		__u32 *h = RTA_DATA(tb[CTRL_ATTR_HDRSIZE]);
-		fprintf(fp, " header size: %d ",*h);
+		const char *name = RTA_DATA(tb[CTRL_ATTR_FAMILY_NAME]);
+		print_string(PRINT_ANY, "family", "\nName: %s\n", name);
 	}
-	if (tb[CTRL_ATTR_MAXATTR]) {
-		__u32 *ma = RTA_DATA(tb[CTRL_ATTR_MAXATTR]);
-		fprintf(fp, " max attribs: %d ",*ma);
-	}
-	if (tb[CTRL_ATTR_OP_POLICY]) {
-		const struct rtattr *pos;
-
-		rtattr_for_each_nested(pos, tb[CTRL_ATTR_OP_POLICY]) {
-			struct rtattr *ptb[CTRL_ATTR_POLICY_DUMP_MAX + 1];
-			struct rtattr *pattrs = RTA_DATA(pos);
-			int plen = RTA_PAYLOAD(pos);
 
-			parse_rtattr_flags(ptb, CTRL_ATTR_POLICY_DUMP_MAX,
-					   pattrs, plen, NLA_F_NESTED);
+	if (tb[CTRL_ATTR_FAMILY_ID])
+		print_0xhex(PRINT_ANY, "id", "\tID: 0x%x ",
+			    rta_getattr_u16(tb[CTRL_ATTR_FAMILY_ID]));
 
-			fprintf(fp, " op %d policies:",
-				pos->rta_type & ~NLA_F_NESTED);
+	if (tb[CTRL_ATTR_VERSION])
+		print_0xhex(PRINT_ANY, "version", " Version: 0x%x ",
+			    rta_getattr_u32(tb[CTRL_ATTR_VERSION]));
 
-			if (ptb[CTRL_ATTR_POLICY_DO]) {
-				__u32 *v = RTA_DATA(ptb[CTRL_ATTR_POLICY_DO]);
+	if (tb[CTRL_ATTR_HDRSIZE])
+		print_uint(PRINT_ANY, "header_size", " header size: %u ",
+			   rta_getattr_u32(tb[CTRL_ATTR_HDRSIZE]));
 
-				fprintf(fp, " do=%d", *v);
-			}
+	if (tb[CTRL_ATTR_MAXATTR])
+		print_uint(PRINT_ANY, "max_attr", " max attribs: %u ",
+			   rta_getattr_u32(tb[CTRL_ATTR_MAXATTR]));
 
-			if (ptb[CTRL_ATTR_POLICY_DUMP]) {
-				__u32 *v = RTA_DATA(ptb[CTRL_ATTR_POLICY_DUMP]);
+	if (tb[CTRL_ATTR_OP_POLICY])
+		print_ops(tb[CTRL_ATTR_OP_POLICY]);
 
-				fprintf(fp, " dump=%d", *v);
-			}
-		}
-	}
 	if (tb[CTRL_ATTR_POLICY])
-		nl_print_policy(tb[CTRL_ATTR_POLICY], fp);
+		nl_print_policy(tb[CTRL_ATTR_POLICY]);
 
 	/* end of family definitions .. */
-	fprintf(fp,"\n");
-	if (tb[CTRL_ATTR_OPS]) {
-		struct rtattr *tb2[GENL_MAX_FAM_OPS];
-		int i=0;
-		parse_rtattr_nested(tb2, GENL_MAX_FAM_OPS, tb[CTRL_ATTR_OPS]);
-		fprintf(fp, "\tcommands supported: \n");
-		for (i = 0; i < GENL_MAX_FAM_OPS; i++) {
-			if (tb2[i]) {
-				fprintf(fp, "\t\t#%d: ", i);
-				if (0 > print_ctrl_cmds(fp, tb2[i])) {
-					fprintf(fp, "Error printing command\n");
-				}
-				/* for next command */
-				fprintf(fp,"\n");
-			}
-		}
-
-		/* end of family::cmds definitions .. */
-		fprintf(fp,"\n");
-	}
+	print_string(PRINT_FP, NULL,  "\n", NULL);
 
-	if (tb[CTRL_ATTR_MCAST_GROUPS]) {
-		struct rtattr *tb2[GENL_MAX_FAM_GRPS + 1];
-		int i;
-
-		parse_rtattr_nested(tb2, GENL_MAX_FAM_GRPS,
-				    tb[CTRL_ATTR_MCAST_GROUPS]);
-		fprintf(fp, "\tmulticast groups:\n");
-
-		for (i = 0; i < GENL_MAX_FAM_GRPS; i++) {
-			if (tb2[i]) {
-				fprintf(fp, "\t\t#%d: ", i);
-				if (0 > print_ctrl_grp(fp, tb2[i]))
-					fprintf(fp, "Error printing group\n");
-				/* for next group */
-				fprintf(fp,"\n");
-			}
-		}
+	if (tb[CTRL_ATTR_OPS])
+		print_ctrl_ops(tb[CTRL_ATTR_OPS]);
 
-		/* end of family::groups definitions .. */
-		fprintf(fp,"\n");
-	}
+	if (tb[CTRL_ATTR_MCAST_GROUPS])
+		print_ctrl_mcast(tb[CTRL_ATTR_MCAST_GROUPS]);
 
 	fflush(fp);
 	return 0;
@@ -236,7 +255,10 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 
 static int print_ctrl2(struct nlmsghdr *n, void *arg)
 {
-	return print_ctrl(NULL, n, arg);
+	open_json_object(NULL);
+	print_ctrl(NULL, n, arg);
+	close_json_object();
+	return 0;
 }
 
 static int ctrl_list(int cmd, int argc, char **argv)
@@ -291,6 +313,8 @@ static int ctrl_list(int cmd, int argc, char **argv)
 		}
 	}
 
+	new_json_obj(json);
+
 	if (cmd == CTRL_CMD_GETFAMILY) {
 		if (rtnl_talk(&rth, nlh, &answer) < 0) {
 			fprintf(stderr, "Error talking to the kernel\n");
@@ -319,6 +343,7 @@ static int ctrl_list(int cmd, int argc, char **argv)
 
 	ret = 0;
 ctrl_done:
+	delete_json_obj();
 	free(answer);
 	rtnl_close(&rth);
 	return ret;
@@ -335,8 +360,8 @@ static int ctrl_listen(int argc, char **argv)
 
 	if (rtnl_listen(&rth, print_ctrl, (void *) stdout) < 0)
 		exit(2);
-	
-	rtnl_close(&rth);	
+
+	rtnl_close(&rth);
 	return 0;
 }
 
diff --git a/genl/genl.c b/genl/genl.c
index 85cc73bb..b497a3ad 100644
--- a/genl/genl.c
+++ b/genl/genl.c
@@ -24,6 +24,7 @@
 int show_stats;
 int show_details;
 int show_raw;
+int json;
 
 static void *BODY;
 static struct genl_util *genl_list;
@@ -96,7 +97,8 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: genl [ OPTIONS ] OBJECT [help] }\n"
 		"where  OBJECT := { ctrl etc }\n"
-		"       OPTIONS := { -s[tatistics] | -d[etails] | -r[aw] | -V[ersion] | -h[elp] }\n");
+		"       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[aw] |\n"
+		"                    -j[son] | -p[retty] }\n");
 	exit(-1);
 }
 
@@ -115,6 +117,10 @@ int main(int argc, char **argv)
 		} else if (matches(argv[1], "-Version") == 0) {
 			printf("genl utility, iproute2-%s\n", version);
 			exit(0);
+		} else if (matches(argv[1], "-json") == 0) {
+			++json;
+		} else if (matches(argv[1], "-pretty") == 0) {
+			++pretty;
 		} else if (matches(argv[1], "-help") == 0) {
 			usage();
 		} else {
diff --git a/include/libnetlink.h b/include/libnetlink.h
index 7074e913..3cd0931a 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -374,6 +374,6 @@ int rtnl_from_file(FILE *, rtnl_listen_filter_t handler,
 	     RTA_OK(attr, RTA_PAYLOAD(nest) - ((char *)(attr) - (char *)RTA_DATA((nest)))); \
 	     (attr) = RTA_TAIL((attr)))
 
-void nl_print_policy(const struct rtattr *attr, FILE *fp);
+void nl_print_policy(const struct rtattr *attr);
 
 #endif /* __LIBNETLINK_H__ */
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index e2b284e6..305bd4b0 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -23,6 +23,7 @@
 #include <linux/nexthop.h>
 
 #include "libnetlink.h"
+#include "json_print.h"
 #include "utils.h"
 
 #ifndef __aligned
@@ -1146,7 +1147,7 @@ static int __rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
 	return __rtnl_talk_iov(rtnl, &iov, 1, answer, show_rtnl_err, errfn);
 }
 
-int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int json,
+int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int use_json,
 		   int (*print_info)(struct nlmsghdr *n, void *arg))
 {
 	struct nlmsghdr *answer;
@@ -1158,7 +1159,7 @@ int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int json,
 	if (ret)
 		return ret;
 
-	new_json_obj(json);
+	new_json_obj(use_json);
 	open_json_object(NULL);
 	print_info(answer, stdout);
 	close_json_object();
@@ -1585,52 +1586,70 @@ static const char *get_nla_type_str(unsigned int attr)
 	}
 }
 
-void nl_print_policy(const struct rtattr *attr, FILE *fp)
+static void _nl_print_policy(const struct rtattr *attr)
 {
-	const struct rtattr *pos;
+	struct rtattr *tp[NL_POLICY_TYPE_ATTR_MAX + 1];
 
-	rtattr_for_each_nested(pos, attr) {
-		const struct rtattr *attr;
+	parse_rtattr_nested(tp, ARRAY_SIZE(tp) - 1, attr);
 
-		fprintf(fp, " policy[%u]:", pos->rta_type & ~NLA_F_NESTED);
+	if (tp[NL_POLICY_TYPE_ATTR_TYPE]) {
+		print_uint(PRINT_ANY, "attr", "attr[%u]:",
+			   attr->rta_type & ~NLA_F_NESTED);
+		print_string(PRINT_ANY, "type", " type=%s",
+			get_nla_type_str(rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_TYPE])));
+	}
 
-		rtattr_for_each_nested(attr, pos) {
-			struct rtattr *tp[NL_POLICY_TYPE_ATTR_MAX + 1];
+	if (tp[NL_POLICY_TYPE_ATTR_POLICY_IDX])
+		print_uint(PRINT_ANY, "policy", " policy:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_IDX]));
 
-			parse_rtattr_nested(tp, ARRAY_SIZE(tp) - 1, attr);
+	if (tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE])
+		print_uint(PRINT_ANY, "maxattr", " maxattr:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE]));
 
-			if (tp[NL_POLICY_TYPE_ATTR_TYPE])
-				fprintf(fp, "attr[%u]: type=%s",
-					attr->rta_type & ~NLA_F_NESTED,
-					get_nla_type_str(rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_TYPE])));
+	if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]) {
+		print_s64(PRINT_ANY, "min_value", " range:[%lld",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S]));
+		print_s64(PRINT_ANY, "max_value", "%lld]",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]));
+	}
 
-			if (tp[NL_POLICY_TYPE_ATTR_POLICY_IDX])
-				fprintf(fp, " policy:%u",
-					rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_IDX]));
+	if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]) {
+		print_u64(PRINT_ANY, "min_value", " range:[%llu",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U]));
+		print_u64(PRINT_ANY, "max_value", "%llu]",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]));
+	}
 
-			if (tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE])
-				fprintf(fp, " maxattr:%u",
-					rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE]));
+	if (tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH])
+		print_uint(PRINT_ANY, "min_length", " min len:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH]));
 
-			if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S])
-				fprintf(fp, " range:[%lld,%lld]",
-					(signed long long)rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S]),
-					(signed long long)rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]));
+	if (tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH])
+		print_uint(PRINT_ANY, "max_length", " max len:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH]));
+}
+
+void nl_print_policy(const struct rtattr *attr)
+{
+	const struct rtattr *pos;
+
+	open_json_array(PRINT_JSON, NULL);
+	rtattr_for_each_nested(pos, attr) {
+		const struct rtattr *a;
 
-			if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U])
-				fprintf(fp, " range:[%llu,%llu]",
-					(unsigned long long)rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U]),
-					(unsigned long long)rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]));
+		open_json_array(PRINT_JSON, NULL);
 
-			if (tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH])
-				fprintf(fp, " min len:%u",
-					rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH]));
+		print_uint(PRINT_ANY, "policy", " policy[%u]:", pos->rta_type & ~NLA_F_NESTED);
 
-			if (tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH])
-				fprintf(fp, " max len:%u",
-					rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH]));
+		rtattr_for_each_nested(a, pos) {
+			open_json_object(NULL);
+			_nl_print_policy(a);
+			close_json_object();
 		}
+		close_json_array(PRINT_JSON, NULL);
 	}
+	close_json_array(PRINT_JSON, NULL);
 }
 
 int rtnl_tunneldump_req(struct rtnl_handle *rth, int family, int ifindex,
diff --git a/man/man8/genl.8 b/man/man8/genl.8
index b9de594d..7ffde866 100644
--- a/man/man8/genl.8
+++ b/man/man8/genl.8
@@ -4,11 +4,17 @@ genl \- generic netlink utility frontend
 .SH SYNOPSIS
 .in +8
 .ti -8
-.BR genl " [ " -s [ tatistics "] ] [ " -d [ etails "] ] [ " -r [ aw "] ] " OBJECT
-
+.BR genl "[ " OPTIONS " ] "  OBJECT
 .ti -8
 .BR genl " { " -V [ ersion "] | " -h [ elp "] }"
 
+.ti -8
+.IR OPTIONS " := { "
+\fB\-s\fR[\fItatistics\fR] |
+\fB\-d\fR[\fIetails\fR] |
+\fB\-j\fR[son\fR] |
+\fB\-p\fR[retty\fR] }
+
 .ti -8
 .IR OBJECT " := { "
 .B ctrl
@@ -66,6 +72,12 @@ Show object statistics.
 .B \-d, \-details
 Show object details.
 .TP
+.B -j, \-json
+Output results in JavaScript Object Notation (JSON).
+.TP
+.B -p, \-pretty
+Add indentation for readability.
+.TP
 .B \-r, \-raw
 Dump raw output only.
 .SH SEE ALSO
-- 
2.51.0


