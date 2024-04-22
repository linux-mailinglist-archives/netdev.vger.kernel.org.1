Return-Path: <netdev+bounces-90093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604F8ACC7A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF65028470F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3561474B5;
	Mon, 22 Apr 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mljLDFXn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CA1474A2
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787709; cv=none; b=ZKrYqHJVCrNi3tjIgefmwKoQLGssSSW3/0f8oA4TEhgjkPA/QuO0CBkggI7ydTppkyIxkD+SnB2ErnFvfLosW3MNorPF8zppu2bfUFX3NCpsANF64/fVcBx0+7RLXKq1lHu/0WhTWy/Uung0zAud8D/elEIagEM3extqHdvvexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787709; c=relaxed/simple;
	bh=QE4M9czyTbr7Vc4bAC9a+zozeboVMElbJcswr/dotS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mK4wawWNsyIDEEixA2x8PQkTPnJ4at7ZRWU1pSLgqO3YWOXx4u6EMuqfOq/2F8zYLgiVSzYMwehYhOHajlSkSKKR8xWVPISSOxESTwWhcMxRDaJuqcW+HEIp85QsLdkNMXtfLjXd7qhAraZFKoMbBwK6nbQK2vgO+Bd4lEF+NsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mljLDFXn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713787709; x=1745323709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QE4M9czyTbr7Vc4bAC9a+zozeboVMElbJcswr/dotS4=;
  b=mljLDFXnO1zDOwyAnMskqLm5wOEZ3bGwnhRRmPos3kTHWOUzHIqfexYe
   fWUv4vi07dgnZZuyHryDkK0IUm0UYRMzXPp+II58MfwU+UoI3dAH0k/+n
   q852+RkIo0kxDtjtTUIp8Qtr+oVLE8p8FphnZo8ZCKMvN8shQ6tjG5k4q
   45Bsr6FSPOJ/QHolwhQMYLclmtRaT9X9CmqXWBqjUcWl/kunHb13ZebT+
   2o6ZuDKR4LAnL2pxdXiMW2e0c8YT16VPau/tmD1PHhQBZg9ECALh4evNU
   qyU7Z/c7FuBcJtKgxcgNjNLQ9xk/gsWc3dgbClu6S3hKHPH8fARNoEsKU
   A==;
X-CSE-ConnectionGUID: V8exSyNNTiGNYVxjjwKnBQ==
X-CSE-MsgGUID: j2SIsTkfTP2mOJ1gtPm16Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9147828"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9147828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:08:28 -0700
X-CSE-ConnectionGUID: uj6cluTaRrONGAy1Xk2QdQ==
X-CSE-MsgGUID: +KEUb6QARWimyXQGv1Tw1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="54926279"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2024 05:08:26 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4BF4D2878D;
	Mon, 22 Apr 2024 13:08:18 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v3 2/2] f_flower: implement pfcp opts
Date: Mon, 22 Apr 2024 14:05:51 +0200
Message-Id: <20240422120551.4616-3-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240422120551.4616-1-wojciech.drewek@intel.com>
References: <20240422120551.4616-1-wojciech.drewek@intel.com>
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
v3: add json support
---
 include/libnetlink.h |   6 ++
 man/man8/tc-flower.8 |  11 ++++
 tc/f_flower.c        | 133 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

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
index cfcd7b2f6ddf..08c1001af7b4 100644
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
@@ -2150,6 +2241,13 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
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
@@ -2646,6 +2744,29 @@ static void flower_print_gtp_opts(const char *name, struct rtattr *attr,
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
+	open_json_array(PRINT_JSON, name);
+	open_json_object(NULL);
+	print_uint(PRINT_JSON, "type", NULL, type);
+	print_uint(PRINT_JSON, "seid", NULL, seid);
+	close_json_object();
+	close_json_array(PRINT_JSON, name);
+
+	snprintf(strbuf, len, "%02x:%llx", type, seid);
+}
+
 static void __attribute__((format(printf, 2, 0)))
 flower_print_enc_parts(const char *name, const char *namefrm,
 		       struct rtattr *attr, char *key, char *mask)
@@ -2738,6 +2859,18 @@ static void flower_print_enc_opts(const char *name, struct rtattr *attr,
 
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


