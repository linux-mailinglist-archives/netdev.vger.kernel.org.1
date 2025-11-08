Return-Path: <netdev+bounces-237019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3817C4348F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 21:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A1B64E0672
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 20:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4926B0B3;
	Sat,  8 Nov 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="n0p2/aST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406C1E32D3
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762633396; cv=none; b=I3wMmfaxzczv3eahJ3hmdlWkEg1rDJ7wls1wXSnYlScT5gMbyGYC3/XqtMUNWF5fV/Pr0uZ4qzNuLJBaZb0h677GO825nL5h9M/98tnkZnRNjz6HgblUtrBBibb/QR0xXbHNO62YhkCQ8FH0w4yTiDlMhY/QWQZ5nKwF9+hY3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762633396; c=relaxed/simple;
	bh=fcuglugxARTexAYFumUs0e8X1Wx9Ad+aXLLvBqOcPJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNLqWYyztAwSRaThBluAKQOgwDohbH6pjDLldhpAXSaW5aZmMuvkCgnKKz69QspAufDD7/+/lUFEBpiruAnaP927tJ8HprwPcrUbEkevmc+JVVP4UgWou9ceXpYudZ/eh9fhvJ24qQCrab83Y6WcgLMnvPF9V+Y5EBIlUuKwM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=n0p2/aST; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b996c8db896so1467094a12.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 12:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762633393; x=1763238193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2S55kmkflXAaOfY2xL08QD1KZUKT5HMPBIWTJn5OmG8=;
        b=n0p2/aSTvzhQ07tDIEV85IH59+bNOPBTJbHzdUjVT/+kZA7epNZLKUJdyvFc0uxhk2
         eGMpY6Ged8RcS57oTJx0R0z3H9TR+m6fbWstkGudRgA6q64P5z8AgfiGD//JidCmI7TF
         87D90FiBhlPJKKTZf3bM34ClVvrOgPy0xI2phJCLKGedAMFlOA4MGowz+XTzAOApvjXp
         bxlHw3zqQPOygN83faPCAt7MUFWNKGq5VNjrvP9apQIjt9WP2FDtXu+Rh6gONtjoEBM6
         QVWCEf5LQF6m1Xj+nRjryJT9u+C+HsSl+6graHByUI6gNSy9eSYn2iOuRqpqmKsV7zpa
         GJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633393; x=1763238193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S55kmkflXAaOfY2xL08QD1KZUKT5HMPBIWTJn5OmG8=;
        b=cP78Y+T6xK1G5pKKFB7nwkz7BUZlTtBNiN1MbMYce4/ukxz9jNo5XSruprjHRg0PYi
         SB+WXrGOK4n9WqaK6wUtXl61275w0qAhAR31fA3RyQI2cRW120bMeP7QkryepPP9MCjU
         5XltJ4EWJV+0JllcNMVxMhmTWM03bDJ45Hf5ou0Jk7sLoshmZ5DWgBWOkREVndcS+TWl
         dEh9QiiOKrMejg2t0gfokM4sCOlIgOuU7asN9bvpHDQApkIMhutzAMc9u1QGD261+QB3
         7flIuQYH9VKbCE2aQe08jMYraxXDPpXS3xjYBOleaJ6gOFDbeVJO0Lsdy4u9P/S04PQa
         UwEw==
X-Gm-Message-State: AOJu0YxoHRx3gpT950Mqr3E7EglazMW7tWX5FNnqRojTDll8InHQsTdz
	N3fRd6T+EHFCK87H7Ov6kb8fhPTqcSj1Nl5lIYV9g1lBNbIoLM4lrepHr1ktwrMXCADrPDbdcAP
	4secnM7s=
X-Gm-Gg: ASbGncsphD7JuT96S+RYw934PcYhWHeUkfsRQGTNq0WGzh8Bv2s7XkKnWIdwxVJzlk5
	GswPMnmzgHf6AFp1rcLTD/w29Qpl3lIRV0FajdUyaS3+jzi7CvY4i4+RDYc4YkCZxPXwhHG5lBG
	35Jr45IXUWnqsmyBZudycI/euxUkbkj9/oZz0lvzKm+VneR9C+L5VSw97y2AqtTkPrG87RTqeJg
	SdlYn4NZ/GG2TD4SHWrCbspkzUiN49/geCww2k7/VgAsAqYMBQBlvpBzTo/wjOff5flNc31b8PQ
	UlVb0odeEBoOGoaWKp8CZtn1l+xWI/XqMrpKrIf9y7rrzqdoH4j4EBOJlH1acw3+A+y6rG4Naj7
	Six6lJI8SbEMBnj9exFet67ZgKlGePfj0LroQ1/C3PB7PA1Ub7tXBFy9rVXv92ZsdkaYcZR/sak
	JPBTYwjz75JvPtcJ7XSX9SUJQ8ofiA+CsHuDFZUXw=
X-Google-Smtp-Source: AGHT+IGd6o/z0uczY7RPpevt6+Wl8eRRQdtxdc8/t3p/VrmiScIsw/SK8S9ra5ZcAp6vk1R410L1lg==
X-Received: by 2002:a05:6a20:6a2c:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-3539f99f2b0mr4925364637.2.1762633393232;
        Sat, 08 Nov 2025 12:23:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7ee8bsm8429196a12.8.2025.11.08.12.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:23:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] genl: add json support
Date: Sat,  8 Nov 2025 12:22:54 -0800
Message-ID: <20251108202310.31505-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaup the old code and support for JSON.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 genl/ctrl.c          | 253 +++++++++++++++++++++++--------------------
 genl/genl.c          |   8 +-
 include/libnetlink.h |   2 +-
 lib/libnetlink.c     |  87 +++++++++------
 man/man8/genl.8      |  16 ++-
 5 files changed, 210 insertions(+), 156 deletions(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index 72a9b013..75856d74 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -36,66 +36,139 @@ static int usage(void)
 	return -1;
 }
 
-static void print_ctrl_cmd_flags(FILE *fp, __u32 fl)
+static void print_ctrl_flag(const char *json_str, const char *fp_str)
 {
-	fprintf(fp, "\n\t\tCapabilities (0x%x):\n ", fl);
-	if (!fl) {
-		fprintf(fp, "\n");
-		return;
-	}
-	fprintf(fp, "\t\t ");
+	print_string(PRINT_JSON, NULL, NULL, json_str);
+	print_string(PRINT_FP, NULL, fp_str, NULL);
+}
+
+static void print_ctrl_cmd_flags(__u32 fl)
+{
+	print_0xhex(PRINT_FP, "flags", "\n\t\tCapabilities (0x%x):\n", fl);
+	open_json_array(PRINT_JSON, "capabilities");
+
+	if (fl != 0)
+		print_string(PRINT_FP, NULL, "\t\t ", NULL);
 
 	if (fl & GENL_ADMIN_PERM)
-		fprintf(fp, " requires admin permission;");
+		print_ctrl_flag("admin", " requires admin permission;");
 	if (fl & GENL_CMD_CAP_DO)
-		fprintf(fp, " can doit;");
+		print_ctrl_flag("do", " can doit;");
 	if (fl & GENL_CMD_CAP_DUMP)
-		fprintf(fp, " can dumpit;");
+		print_ctrl_flag("dump", " can dumpit;");
 	if (fl & GENL_CMD_CAP_HASPOL)
-		fprintf(fp, " has policy");
-
-	fprintf(fp, "\n");
+		print_ctrl_flag("policy", " has policy");
+	close_json_array(PRINT_ANY, "\n");
 }
 
-static int print_ctrl_cmds(FILE *fp, struct rtattr *arg)
+static void print_ctrl_cmd(const struct rtattr *arg)
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
+		print_0xhex(PRINT_ANY, "id", " ID-0x%x ", rta_getattr_u32(tb[CTRL_ATTR_OP_ID]));
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
+		print_uint(PRINT_ANY, "bits", " op %d policies:", pos->rta_type & ~NLA_F_NESTED);
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
@@ -137,98 +210,36 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
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
+		print_0xhex(PRINT_ANY, "id", "\tID: 0x%x ", rta_getattr_u16(tb[CTRL_ATTR_FAMILY_ID]));
 
-			fprintf(fp, " op %d policies:",
-				pos->rta_type & ~NLA_F_NESTED);
+	if (tb[CTRL_ATTR_VERSION])
+		print_0xhex(PRINT_ANY, "version", " Version: 0x%x ", rta_getattr_u32(tb[CTRL_ATTR_VERSION]));
 
-			if (ptb[CTRL_ATTR_POLICY_DO]) {
-				__u32 *v = RTA_DATA(ptb[CTRL_ATTR_POLICY_DO]);
+	if (tb[CTRL_ATTR_HDRSIZE])
+		print_uint(PRINT_ANY, "header_size", " header size: %u ", rta_getattr_u32(tb[CTRL_ATTR_HDRSIZE]));
 
-				fprintf(fp, " do=%d", *v);
-			}
+	if (tb[CTRL_ATTR_MAXATTR])
+		print_uint(PRINT_ANY, "max_attr", " max attribs: %u ", rta_getattr_u32(tb[CTRL_ATTR_MAXATTR]));
 
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
@@ -236,7 +247,10 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 
 static int print_ctrl2(struct nlmsghdr *n, void *arg)
 {
-	return print_ctrl(NULL, n, arg);
+	open_json_object(NULL);
+	print_ctrl(NULL, n, arg);
+	close_json_object();
+	return 0;
 }
 
 static int ctrl_list(int cmd, int argc, char **argv)
@@ -291,6 +305,8 @@ static int ctrl_list(int cmd, int argc, char **argv)
 		}
 	}
 
+	new_json_obj(json);
+
 	if (cmd == CTRL_CMD_GETFAMILY) {
 		if (rtnl_talk(&rth, nlh, &answer) < 0) {
 			fprintf(stderr, "Error talking to the kernel\n");
@@ -319,6 +335,7 @@ static int ctrl_list(int cmd, int argc, char **argv)
 
 	ret = 0;
 ctrl_done:
+	delete_json_obj();
 	free(answer);
 	rtnl_close(&rth);
 	return ret;
@@ -335,8 +352,8 @@ static int ctrl_listen(int argc, char **argv)
 
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


