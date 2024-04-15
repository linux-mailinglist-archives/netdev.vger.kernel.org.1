Return-Path: <netdev+bounces-87942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7A8A507B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B83428606C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BA7EF06;
	Mon, 15 Apr 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/FN9BM0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE07E108
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185544; cv=none; b=pqDLj7UDn4UIRgQs+k+tBFEipy5mCHWbKcwxAHK7xrXiWyaI8XYnsrar1Gakdz11CcYNndWP4Z1J9gIeBD8+Cwdz15hbKHdqQ9Aw4bm92X9d0/+GCfO0d1jf3BbKp+6K9vGFNVe05dgwh0/tE8yDQPoQkPkjmtKrOzb42YhK33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185544; c=relaxed/simple;
	bh=GdsYZCKfehYypQYF6o0yBDZrEadwYgnML5dbV0kjXKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcSRmnpTX2WGVfj95bj5G0XI+XqPe3/ibLfwNsV8fC9Sqzy8hFkWV4G61AlJpvnfVNOVyAUYhE1JHH6c9bSqklGbhwJJjpvXrvMgxoSyPdqtD/IrSBbcggMc0ZdBlde3RwGzDDy6YpgNqFOHtrzEplKY/qfEsC3jNEQC4RkMseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/FN9BM0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713185543; x=1744721543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdsYZCKfehYypQYF6o0yBDZrEadwYgnML5dbV0kjXKI=;
  b=n/FN9BM0DDgv5DZO+j190vWf0jHP0e1nAw2epQ6Ud04cGiyxpsHAfVk5
   owpZhu3ShtUccpu0a130eM69X3a0YB1bOLlNVW2cNsBstEor3TgiN/kJ/
   VQ2SnfGx/jiio/jr7IwI7jHmnc6IUi9rnsa2Zz0quVBwTScoC5bThsnvC
   zGf8b2y+f6SdX8fiX1GgrbZyzrdw5Vqq1XN00WDA6E8Jfh2HYMLzCNxqJ
   hsMlhcbwdsDBX6LuQWxT8l2gb50U4+FhEq22ww2lXEFEcoOPHS0qQCyw/
   FQ1OncxSqSDD4+pWD0RPPTR1eUUpZVLoXCXaW4E91SM0hrGAHSQaPsLvH
   A==;
X-CSE-ConnectionGUID: MBIACHJ/RGWBPGju2GOFCQ==
X-CSE-MsgGUID: kt0TpmGhREq5E+wZX981/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="11522781"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="11522781"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 05:52:22 -0700
X-CSE-ConnectionGUID: 3jqbQUu/Tm6I48EE8Ivo8w==
X-CSE-MsgGUID: /US9VIuZRf6prqgTFBMT/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26323467"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 15 Apr 2024 05:52:20 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9FD02333DB;
	Mon, 15 Apr 2024 13:52:14 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v2 2/2] f_flower: implement pfcp opts
Date: Mon, 15 Apr 2024 14:50:00 +0200
Message-Id: <20240415125000.12846-3-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415125000.12846-1-wojciech.drewek@intel.com>
References: <20240415125000.12846-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Allow adding tc filter for PFCP header.

Add support for parsing TCA_FLOWER_KEY_ENC_OPTS_PFCP.
Options are as follows: TYPE:SEID.

TYPE is a 8-bit value represented in hex and can be  1
for session header and 0 for node header. In PFCP packet
this is S flag in header.

SEID is a 64-bit session id value represented in hex.

This patch enables adding hardware filters using PFCP fields, see [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d823265dd45bbf14bd67aa476057108feb4143ce

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: improve pfcp_opts man description
---
 include/libnetlink.h         |   6 ++
 include/uapi/linux/pkt_cls.h |  14 ++++
 man/man8/tc-flower.8         |  11 +++
 tc/f_flower.c                | 126 +++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 35a9bb57d685..30f0c2d22d49 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -274,6 +274,12 @@ static inline __u64 rta_getattr_uint(const struct rtattr *rta)
 	}
 	return -1ULL;
 }
+
+static inline __be64 rta_getattr_be64(const struct rtattr *rta)
+{
+	return htobe64(rta_getattr_u64(rta));
+}
+
 static inline __s32 rta_getattr_s32(const struct rtattr *rta)
 {
 	return *(__s32 *)RTA_DATA(rta);
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index ea277039f89d..229fc925ec3a 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -587,6 +587,10 @@ enum {
 					 * TCA_FLOWER_KEY_ENC_OPT_GTP_
 					 * attributes
 					 */
+	TCA_FLOWER_KEY_ENC_OPTS_PFCP,	/* Nested
+					 * TCA_FLOWER_KEY_ENC_IPT_PFCP
+					 * attributes
+					 */
 	__TCA_FLOWER_KEY_ENC_OPTS_MAX,
 };
 
@@ -636,6 +640,16 @@ enum {
 #define TCA_FLOWER_KEY_ENC_OPT_GTP_MAX \
 		(__TCA_FLOWER_KEY_ENC_OPT_GTP_MAX - 1)
 
+enum {
+	TCA_FLOWER_KEY_ENC_OPT_PFCP_UNSPEC,
+	TCA_FLOWER_KEY_ENC_OPT_PFCP_TYPE,		/* u8 */
+	TCA_FLOWER_KEY_ENC_OPT_PFCP_SEID,		/* be64 */
+	__TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX,
+};
+
+#define TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX \
+		(__TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX - 1)
+
 enum {
 	TCA_FLOWER_KEY_MPLS_OPTS_UNSPEC,
 	TCA_FLOWER_KEY_MPLS_OPTS_LSE,
diff --git a/man/man8/tc-flower.8 b/man/man8/tc-flower.8
index 832458138c74..6b56640503d5 100644
--- a/man/man8/tc-flower.8
+++ b/man/man8/tc-flower.8
@@ -97,6 +97,8 @@ flower \- flow based traffic control filter
 .B erspan_opts
 |
 .B gtp_opts
+|
+.B pfcp_opts
 }
 .IR OPTIONS " | "
 .BR ip_flags
@@ -453,6 +455,8 @@ Match the connection zone, and can be masked.
 .BI erspan_opts " OPTIONS"
 .TQ
 .BI gtp_opts " OPTIONS"
+.TQ
+.BI pfcp_opts " OPTIONS"
 Match on IP tunnel metadata. Key id
 .I NUMBER
 is a 32 bit tunnel key id (e.g. VNI for VXLAN tunnel).
@@ -494,6 +498,13 @@ doesn't support multiple options, and it consists of a key followed by a slash
 and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
 match. The option can be described in the form PDU_TYPE:QFI/PDU_TYPE_MASK:QFI_MASK
 where both PDU_TYPE and QFI are represented as a 8bit hexadecimal values.
+pfcp_opts
+.I OPTIONS
+does not support multiple options. It consists of a key followed by a slash
+and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
+match. The option can be described in the form TYPE:SEID/TYPE_MASK:SEID_MASK
+where TYPE is represented as a 8bit number, SEID is represented by 64bit. Both
+TYPE and SEID are provided in hex.
 .TP
 .BI ip_flags " IP_FLAGS"
 .I IP_FLAGS
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 53188f1cd87a..bc918b4bd3ff 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -91,6 +91,7 @@ static void explain(void)
 		"			vxlan_opts MASKED-OPTIONS |\n"
 		"			erspan_opts MASKED-OPTIONS |\n"
 		"			gtp_opts MASKED-OPTIONS |\n"
+		"			pfcp_opts MASKED-OPTIONS |\n"
 		"			ip_flags IP-FLAGS |\n"
 		"			l2_miss L2_MISS |\n"
 		"			enc_dst_port [ port_number ] |\n"
@@ -1152,6 +1153,58 @@ static int flower_parse_gtp_opt(char *str, struct nlmsghdr *n)
 	return 0;
 }
 
+static int flower_parse_pfcp_opt(char *str, struct nlmsghdr *n)
+{
+	struct rtattr *nest;
+	char *token;
+	int i, err;
+
+	nest = addattr_nest(n, MAX_MSG,
+			    TCA_FLOWER_KEY_ENC_OPTS_PFCP | NLA_F_NESTED);
+
+	i = 1;
+	token = strsep(&str, ":");
+	while (token) {
+		switch (i) {
+		case TCA_FLOWER_KEY_ENC_OPT_PFCP_TYPE:
+		{
+			__u8 opt_type;
+
+			if (!strlen(token))
+				break;
+			err = get_u8(&opt_type, token, 16);
+			if (err)
+				return err;
+
+			addattr8(n, MAX_MSG, i, opt_type);
+			break;
+		}
+		case TCA_FLOWER_KEY_ENC_OPT_PFCP_SEID:
+		{
+			__be64 opt_seid;;
+
+			if (!strlen(token))
+				break;
+			err = get_be64(&opt_seid, token, 16);
+			if (err)
+				return err;
+
+			addattr64(n, MAX_MSG, i, opt_seid);
+			break;
+		}
+		default:
+			fprintf(stderr, "Unknown \"pfcp_opts\" type\n");
+			return -1;
+		}
+
+		token = strsep(&str, ":");
+		i++;
+	}
+	addattr_nest_end(n, nest);
+
+	return 0;
+}
+
 static int flower_parse_geneve_opts(char *str, struct nlmsghdr *n)
 {
 	char *token;
@@ -1370,6 +1423,44 @@ static int flower_parse_enc_opts_gtp(char *str, struct nlmsghdr *n)
 	return 0;
 }
 
+static int flower_parse_enc_opts_pfcp(char *str, struct nlmsghdr *n)
+{
+	char key[XATTR_SIZE_MAX], mask[XATTR_SIZE_MAX];
+	struct rtattr *nest;
+	char *slash;
+	int err;
+
+
+	slash = strchr(str, '/');
+	if (slash) {
+		*slash++ = '\0';
+		if (strlen(slash) > XATTR_SIZE_MAX)
+			return -1;
+		strcpy(mask, slash);
+	} else {
+		strcpy(mask, "ff:ffffffffffffffff");
+	}
+
+	if (strlen(str) > XATTR_SIZE_MAX)
+		return -1;
+	strcpy(key, str);
+
+	nest = addattr_nest(n, MAX_MSG, TCA_FLOWER_KEY_ENC_OPTS | NLA_F_NESTED);
+	err = flower_parse_pfcp_opt(key, n);
+	if (err)
+		return err;
+	addattr_nest_end(n, nest);
+
+	nest = addattr_nest(n, MAX_MSG,
+			    TCA_FLOWER_KEY_ENC_OPTS_MASK | NLA_F_NESTED);
+	err = flower_parse_pfcp_opt(mask, n);
+	if (err)
+		return err;
+	addattr_nest_end(n, nest);
+
+	return 0;
+}
+
 static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
 				 struct nlmsghdr *nlh)
 {
@@ -2150,6 +2241,13 @@ static int flower_parse_opt(struct filter_util *qu, char *handle,
 				fprintf(stderr, "Illegal \"gtp_opts\"\n");
 				return -1;
 			}
+		} else if (!strcmp(*argv, "pfcp_opts")) {
+			NEXT_ARG();
+			ret = flower_parse_enc_opts_pfcp(*argv, n);
+			if (ret < 0) {
+				fprintf(stderr, "Illegal \"pfcp_opts\"\n");
+				return -1;
+			}
 		} else if (matches(*argv, "action") == 0) {
 			NEXT_ARG();
 			ret = parse_action(&argc, &argv, TCA_FLOWER_ACT, n);
@@ -2646,6 +2744,22 @@ static void flower_print_gtp_opts(const char *name, struct rtattr *attr,
 	snprintf(strbuf, len, "%02x:%02x", pdu_type, qfi);
 }
 
+static void flower_print_pfcp_opts(const char *name, struct rtattr *attr,
+				   char *strbuf, int len)
+{
+	struct rtattr *tb[TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX + 1];
+	struct rtattr *i = RTA_DATA(attr);
+	int rem = RTA_PAYLOAD(attr);
+	__be64 seid;
+	__u8 type;
+
+	parse_rtattr(tb, TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX, i, rem);
+	type = rta_getattr_u8(tb[TCA_FLOWER_KEY_ENC_OPT_PFCP_TYPE]);
+	seid = rta_getattr_be64(tb[TCA_FLOWER_KEY_ENC_OPT_PFCP_SEID]);
+
+	snprintf(strbuf, len, "%02x:%llx", type, seid);
+}
+
 static void __attribute__((format(printf, 2, 0)))
 flower_print_enc_parts(const char *name, const char *namefrm,
 		       struct rtattr *attr, char *key, char *mask)
@@ -2738,6 +2852,18 @@ static void flower_print_enc_opts(const char *name, struct rtattr *attr,
 
 		flower_print_enc_parts(name, "  gtp_opts %s", attr, key,
 				       msk);
+	} else if (key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP]) {
+		flower_print_pfcp_opts("pfcp_opt_key",
+				key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
+				key, len);
+
+		if (msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP])
+			flower_print_pfcp_opts("pfcp_opt_mask",
+				msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
+				msk, len);
+
+		flower_print_enc_parts(name, "  pfcp_opts %s", attr, key,
+				       msk);
 	}
 
 	free(msk);
-- 
2.40.1


