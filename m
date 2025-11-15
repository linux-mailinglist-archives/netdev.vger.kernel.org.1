Return-Path: <netdev+bounces-238870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FADAC60916
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFE2635446A
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4B238176;
	Sat, 15 Nov 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1UOzUBRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D901B87EB
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227212; cv=none; b=rTxNJhrKf3r6IUCvu7UnjDzXxleOKUisqvfLBHVkaypI/6ySxm1H66uOt8CpxMEu5k0EfMlgpk7JiZUxpFntmr4PdtXsQ84Uo4ayrq67uTRrDD3qzXT4rO19EIH0jJmDYcO4kqgbi0QZDQO7fLw6ll7pEwybfINSuosWd5If+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227212; c=relaxed/simple;
	bh=caEw2j0KEppKqY/aJmRoInrE3X7yjCp/nR6vl6z6wVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC6lGtdBwTll5q5Gzqa6Bd5GQd9h/nDLJmXNMWjxNEfXctHENsMkzdjvWGyaLyB+4/fLY3vX9HNgQyX91mAr0thoDmQHTBPHSt2s6DAebZw1g84iY33UjaVz7uEszq/RC94NXtMO/CDHk5U/8n4M1Sgz3TcUSv6r0O/Ed1RKp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1UOzUBRy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc0d7255434so1795356a12.0
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763227209; x=1763832009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Jiqlt7JWkzBR6Di9mBGSJCWyGxFWvbtG9FG3joX8s=;
        b=1UOzUBRyyb/v/kb61aEs9om7h9Vgx461IQMGmIzt6vt1oWxzWWBVnMHxnNBqAKHoqD
         9+jm8TjXSkfigQAw+KIUAzf4AheXw5BNA6R6GQ+GhmUxNan+S0qR9s+UGLGBghV2dBGT
         zqTg0EiX3tdlnjdF1baOocYK9vM/7F+ILWON23n+aibCXzprT5wo6FfYIfTDGS7+mXX8
         mHvk/plMOhCk7frof41e6P3tNN/Dzmul1cY/r4jzg6TVMf2g7M8shK3oVnjSQAnIHX+N
         onVl27/QTMg4oLqPW7PX4PgWbcEuArN/0WIcQy88MJSejfe5SBKRjDiVhos+e1hAB9PL
         wKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763227209; x=1763832009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9Jiqlt7JWkzBR6Di9mBGSJCWyGxFWvbtG9FG3joX8s=;
        b=nBlBfpEh9dFRwpxQw05g6S9ZYxPeM8yca2VkPPvL23ZKXnZLE8CLWS8BucXOwCLRmZ
         0LOY3izBkXmabZlkFAsDNDek8ofY0MiRFmSzMCqZPw+ZPQ3ozhq5+QQRTy0mRGXlCAQy
         pl07s2DLbr6jrgvIlpc0Gu0ZbByAjOoCIJMsA/ClapzZlGgWuKFjPGx/8zD2kjmD63U9
         UmnsFcQsMWb7IN7XhkgZ9KCPDPN5P6PW+VJnydX2UIX1qdEosbaBwr2wV+l9wn8a6Xqg
         AnJzJ2k1oP3BCv0XFwUbUWNk0GZGJ9qNo2okZJUR6y/a8nHbJtyQ9VBDsfuuO40MfKwa
         16DA==
X-Gm-Message-State: AOJu0Yy81OGBh84qcsHTlmLXALSCe6m0dQbv/1P5KbKsGCf5VWU00Kgg
	/eTgRGtv52pXM/qhTQ8y9NrwgOAkFkIW4E8xylpTZJhYPfrIRlyhtyLWs+dtb1DcTQ/DODKr2Ri
	r8KSg
X-Gm-Gg: ASbGncvRmshlmbcJhzESBknCpuAiRg5f2fxCV1UsTd2JiFlE1Kj4LXAMvRdJthR5ilQ
	NcMiCBkWW61xhymPge0tqsNpFVtBqG9T3KY8XQCK/08VMJPHtoxnWiSmDMdCniZpy/PwMFmdvwd
	lctYkH3uvOrvdw9i21mhaGy93FeYQ59Qm92njM94vPdiH325zWN+YCDaTgH4wcFy27+Shx57dyK
	3qPEam4WrcCWO04k7hPDQtGiycVBk9XAS/2ft5i+/5pZKRqgobZbxpV4IiBtxiVLYTrlAWO3lDj
	CjeHHKy2GdUfY8gBi+Gw+GqQuTsma5fQU7tKt0bCmaSjJJLn/LHUmOl+N6wKw7gsF02DKTR+HfM
	o0F4DKA0duWuL1lGQPWS+ypzIawRUBJrJx6MOUkiH/7a+5wK1FjYiFgc+gSGmlkclZW2JjiU+4I
	QVAmQtD7V7hz43gFR6VHCaqzLPgxsG25oi6rzUMWr0Q+GrP8v8y8eCv8veYAcS
X-Google-Smtp-Source: AGHT+IF4G8arXFczu576HXYWAMRcByiYMt9JYk/UCjEjabMhpa1NwTBUy7xZsWQg8h1z44s81hoetg==
X-Received: by 2002:a05:693c:40dc:b0:2a4:3593:4679 with SMTP id 5a478bee46e88-2a4abd973e6mr3598312eec.21.1763227209428;
        Sat, 15 Nov 2025 09:20:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d695821sm27382524eec.0.2025.11.15.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:20:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v2 2/2] genl: move print_policy into genl
Date: Sat, 15 Nov 2025 09:19:17 -0800
Message-ID: <20251115171958.1517032-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115171958.1517032-1-stephen@networkplumber.org>
References: <20251115171958.1517032-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function nl_print_policy was only used in the genl code
so it should be moved to that file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 genl/ctrl.c          | 92 +++++++++++++++++++++++++++++++++++++++++++-
 include/libnetlink.h |  2 -
 lib/libnetlink.c     | 90 -------------------------------------------
 3 files changed, 91 insertions(+), 93 deletions(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index 17930b30..9412c2f0 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -175,6 +175,96 @@ static void print_ctrl_mcast(const struct rtattr *attr)
 	print_string(PRINT_FP, NULL, "\n", NULL);
 }
 
+static const char *get_nla_type_str(unsigned int attr)
+{
+	switch (attr) {
+#define C(x) case NL_ATTR_TYPE_ ## x: return #x
+	C(U8);
+	C(U16);
+	C(U32);
+	C(U64);
+	C(STRING);
+	C(FLAG);
+	C(NESTED);
+	C(NESTED_ARRAY);
+	C(NUL_STRING);
+	C(BINARY);
+	C(S8);
+	C(S16);
+	C(S32);
+	C(S64);
+	C(BITFIELD32);
+	default:
+		return "unknown";
+	}
+}
+
+static void print_policy_attr(const struct rtattr *attr)
+{
+	struct rtattr *tp[NL_POLICY_TYPE_ATTR_MAX + 1];
+
+	parse_rtattr_nested(tp, ARRAY_SIZE(tp) - 1, attr);
+
+	if (tp[NL_POLICY_TYPE_ATTR_TYPE]) {
+		print_uint(PRINT_ANY, "attr", "attr[%u]:",
+			   attr->rta_type & ~NLA_F_NESTED);
+		print_string(PRINT_ANY, "type", " type=%s",
+			get_nla_type_str(rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_TYPE])));
+	}
+
+	if (tp[NL_POLICY_TYPE_ATTR_POLICY_IDX])
+		print_uint(PRINT_ANY, "policy", " policy:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_IDX]));
+
+	if (tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE])
+		print_uint(PRINT_ANY, "maxattr", " maxattr:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE]));
+
+	if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]) {
+		print_s64(PRINT_ANY, "min_value", " range:[%lld",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S]));
+		print_s64(PRINT_ANY, "max_value", "%lld]",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]));
+	}
+
+	if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]) {
+		print_u64(PRINT_ANY, "min_value", " range:[%llu",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U]));
+		print_u64(PRINT_ANY, "max_value", "%llu]",
+			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]));
+	}
+
+	if (tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH])
+		print_uint(PRINT_ANY, "min_length", " min len:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH]));
+
+	if (tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH])
+		print_uint(PRINT_ANY, "max_length", " max len:%u",
+			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH]));
+}
+
+static void print_policy(const struct rtattr *attr)
+{
+	const struct rtattr *pos;
+
+	open_json_array(PRINT_JSON, NULL);
+	rtattr_for_each_nested(pos, attr) {
+		const struct rtattr *a;
+
+		open_json_array(PRINT_JSON, NULL);
+
+		print_uint(PRINT_ANY, "policy", " policy[%u]:", pos->rta_type & ~NLA_F_NESTED);
+
+		rtattr_for_each_nested(a, pos) {
+			open_json_object(NULL);
+			print_policy_attr(a);
+			close_json_object();
+		}
+		close_json_array(PRINT_JSON, NULL);
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
 /*
  * The controller sends one nlmsg per family
 */
@@ -238,7 +328,7 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 		print_ops(tb[CTRL_ATTR_OP_POLICY]);
 
 	if (tb[CTRL_ATTR_POLICY])
-		nl_print_policy(tb[CTRL_ATTR_POLICY]);
+		print_policy(tb[CTRL_ATTR_POLICY]);
 
 	/* end of family definitions .. */
 	print_string(PRINT_FP, NULL,  "\n", NULL);
diff --git a/include/libnetlink.h b/include/libnetlink.h
index 3cd0931a..e91505d9 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -374,6 +374,4 @@ int rtnl_from_file(FILE *, rtnl_listen_filter_t handler,
 	     RTA_OK(attr, RTA_PAYLOAD(nest) - ((char *)(attr) - (char *)RTA_DATA((nest)))); \
 	     (attr) = RTA_TAIL((attr)))
 
-void nl_print_policy(const struct rtattr *attr);
-
 #endif /* __LIBNETLINK_H__ */
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 305bd4b0..6b275a1f 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -1562,96 +1562,6 @@ int __parse_rtattr_nested_compat(struct rtattr *tb[], int max,
 	return 0;
 }
 
-static const char *get_nla_type_str(unsigned int attr)
-{
-	switch (attr) {
-#define C(x) case NL_ATTR_TYPE_ ## x: return #x
-	C(U8);
-	C(U16);
-	C(U32);
-	C(U64);
-	C(STRING);
-	C(FLAG);
-	C(NESTED);
-	C(NESTED_ARRAY);
-	C(NUL_STRING);
-	C(BINARY);
-	C(S8);
-	C(S16);
-	C(S32);
-	C(S64);
-	C(BITFIELD32);
-	default:
-		return "unknown";
-	}
-}
-
-static void _nl_print_policy(const struct rtattr *attr)
-{
-	struct rtattr *tp[NL_POLICY_TYPE_ATTR_MAX + 1];
-
-	parse_rtattr_nested(tp, ARRAY_SIZE(tp) - 1, attr);
-
-	if (tp[NL_POLICY_TYPE_ATTR_TYPE]) {
-		print_uint(PRINT_ANY, "attr", "attr[%u]:",
-			   attr->rta_type & ~NLA_F_NESTED);
-		print_string(PRINT_ANY, "type", " type=%s",
-			get_nla_type_str(rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_TYPE])));
-	}
-
-	if (tp[NL_POLICY_TYPE_ATTR_POLICY_IDX])
-		print_uint(PRINT_ANY, "policy", " policy:%u",
-			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_IDX]));
-
-	if (tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE])
-		print_uint(PRINT_ANY, "maxattr", " maxattr:%u",
-			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE]));
-
-	if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]) {
-		print_s64(PRINT_ANY, "min_value", " range:[%lld",
-			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_S]));
-		print_s64(PRINT_ANY, "max_value", "%lld]",
-			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_S]));
-	}
-
-	if (tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U] && tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]) {
-		print_u64(PRINT_ANY, "min_value", " range:[%llu",
-			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MIN_VALUE_U]));
-		print_u64(PRINT_ANY, "max_value", "%llu]",
-			  rta_getattr_u64(tp[NL_POLICY_TYPE_ATTR_MAX_VALUE_U]));
-	}
-
-	if (tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH])
-		print_uint(PRINT_ANY, "min_length", " min len:%u",
-			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MIN_LENGTH]));
-
-	if (tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH])
-		print_uint(PRINT_ANY, "max_length", " max len:%u",
-			rta_getattr_u32(tp[NL_POLICY_TYPE_ATTR_MAX_LENGTH]));
-}
-
-void nl_print_policy(const struct rtattr *attr)
-{
-	const struct rtattr *pos;
-
-	open_json_array(PRINT_JSON, NULL);
-	rtattr_for_each_nested(pos, attr) {
-		const struct rtattr *a;
-
-		open_json_array(PRINT_JSON, NULL);
-
-		print_uint(PRINT_ANY, "policy", " policy[%u]:", pos->rta_type & ~NLA_F_NESTED);
-
-		rtattr_for_each_nested(a, pos) {
-			open_json_object(NULL);
-			_nl_print_policy(a);
-			close_json_object();
-		}
-		close_json_array(PRINT_JSON, NULL);
-	}
-	close_json_array(PRINT_JSON, NULL);
-}
-
 int rtnl_tunneldump_req(struct rtnl_handle *rth, int family, int ifindex,
 			__u8 flags)
 {
-- 
2.51.0


