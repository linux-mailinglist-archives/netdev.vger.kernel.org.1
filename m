Return-Path: <netdev+bounces-111694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBF9321A8
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83327281F40
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB544C89;
	Tue, 16 Jul 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkCe07RQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDD2D05E
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117396; cv=none; b=m84AOFQn0rMugHYtP72U0ThBmPLsZABZoWNJLP/TYOgl1fJ0iB3NKY2fH4SHf8MTah1rT3ryRZkSyrjK780XScKfsQBfEZU2mE+3pnh6NugOlIStYF/HmZSCg/fe1Br/s5NIpVjUWV42ylqPecrSj+XLg8Pf8gQsW9Pf1mO5ITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117396; c=relaxed/simple;
	bh=EpFkgOL7xTPn+B8YJlDKyR7sBpRwo61VHFYt1ZHUsY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfofRGhxNAXMFsaieROTMYlL5seVVvpfYIU+MgA+iBSlOZPq8cvnRxK6hPTcffNvgpuwh3enlwUV24qBuTWCWuXnTWlznTiy0XNNP2nHsZH3p3z7maAjlMuZ+7lzh8LWmG02L0iyjA7JPeZcr9CbF09/iDsCfvSL3iFHEmgXe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkCe07RQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721117393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3xPrfpGJO/qVymnXl9Zy775xCSIp8+rW++Zn6vnr1bg=;
	b=UkCe07RQieHcwsjEykfSzFM4VU7PzWTydXWeMj/qqnkADh8CNRp+e+xmOW7HhCprq3h6Bp
	42UXhvM8twHesVFBHhosu5E0xptFheBM2SoMRrkVF5xSK1K31faFVt/FCltVwOf0f+wsZQ
	Pby5H6QlnSO+zq5Slc1ub8cnqLvpCgQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-Dxha4vPJNfWiwOa0Jn2yqQ-1; Tue,
 16 Jul 2024 04:09:52 -0400
X-MC-Unique: Dxha4vPJNfWiwOa0Jn2yqQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBF871955D4E;
	Tue, 16 Jul 2024 08:09:50 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.170])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E88471955D42;
	Tue, 16 Jul 2024 08:09:47 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
Cc: David Ahern <dsahern@kernel.org>,
	aclaudi@redhat.com,
	Ilya Maximets <i.maximets@ovn.org>,
	echaudro@redhat.com,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH iproute2-next v2] tc: f_flower: add support for matching on tunnel metadata
Date: Tue, 16 Jul 2024 10:09:33 +0200
Message-ID: <7e7ca47b658bda63b763f0ba22d607d77546d1e1.1721117171.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

extend TC flower for matching on tunnel metadata.

Changes since v1:
 - fix incostintent naming in explain() and in tc-flower.8 (Asbjørn)

Changes since RFC:
 - update uAPI bits to Asbjørn's most recent code [1]
 - add 'tun' prefix to all flag names (Asbjørn)
 - allow parsing 'enc_flags' multiple times, without clearing the match
   mask every time, like happens for 'ip_flags' (Asbjørn)
 - don't use "matches()" for parsing argv[]  (Stephen)
 - (hopefully) improve usage() printout (Asbjørn)
 - update man page

[1] https://lore.kernel.org/netdev/20240709163825.1210046-1-ast@fiberby.net/

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/pkt_cls.h |  7 +++++++
 man/man8/tc-flower.8         | 28 ++++++++++++++++++++++++--
 tc/f_flower.c                | 38 +++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 229fc925ec3a..19e25bceb24c 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -554,6 +554,9 @@ enum {
 	TCA_FLOWER_KEY_SPI,		/* be32 */
 	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
 
+	TCA_FLOWER_KEY_ENC_FLAGS,	/* be32 */
+	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* be32 */
+
 	__TCA_FLOWER_MAX,
 };
 
@@ -674,6 +677,10 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 2),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 5),
 };
 
 enum {
diff --git a/man/man8/tc-flower.8 b/man/man8/tc-flower.8
index 6b56640503d5..adde21688237 100644
--- a/man/man8/tc-flower.8
+++ b/man/man8/tc-flower.8
@@ -106,7 +106,9 @@ flower \- flow based traffic control filter
 .B l2_miss
 .IR L2_MISS " | "
 .BR cfm
-.IR CFM_OPTIONS " }"
+.IR CFM_OPTIONS " | "
+.BR enc_flags
+.IR ENCFLAG-LIST " }"
 
 .ti -8
 .IR LSE_LIST " := [ " LSE_LIST " ] " LSE
@@ -131,6 +133,16 @@ flower \- flow based traffic control filter
 .B op
 .IR OPCODE "
 
+.ti -8
+.IR ENCFLAG-LIST " := [ " ENCFLAG-LIST "/ ] " ENCFLAG
+
+.ti -8
+.IR ENCFLAG " := { "
+.BR [no]tuncsum " | "
+.BR [no]tundf " | "
+.BR [no]tunoam " | "
+.BR [no]tuncrit " } "
+
 .SH DESCRIPTION
 The
 .B flower
@@ -538,11 +550,23 @@ Match on the Maintenance Domain (MD) level field.
 .BI op " OPCODE "
 Match on the CFM opcode field. \fIOPCODE\fR is an unsigned 8 bit value in
 decimal format.
+.RE
+.TP
+.BI enc_flags " ENCFLAG-LIST "
+Match on tunnel control flags.
+.I ENCFLAG-LIST
+is a list of the following tunnel control flags:
+.BR [no]tuncsum ", "
+.BR [no]tundf ", "
+.BR [no]tunoam ", "
+.BR [no]tuncrit ", "
+each separated by '/'.
+.TP
 
 .SH NOTES
 As stated above where applicable, matches of a certain layer implicitly depend
 on the matches of the next lower layer. Precisely, layer one and two matches
-(\fBindev\fR,  \fBdst_mac\fR and \fBsrc_mac\fR)
+(\fBindev\fR,  \fBdst_mac\fR, \fBsrc_mac\fR and \fBenc_flags\fR)
 have no dependency,
 MPLS and layer three matches
 (\fBmpls\fR, \fBmpls_label\fR, \fBmpls_tc\fR, \fBmpls_bos\fR, \fBmpls_ttl\fR,
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 08c1001af7b4..4b3dddde2bc9 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -28,6 +28,7 @@
 
 enum flower_matching_flags {
 	FLOWER_IP_FLAGS,
+	FLOWER_ENC_DST_FLAGS,
 };
 
 enum flower_endpoint {
@@ -99,13 +100,16 @@ static void explain(void)
 		"			ct_label MASKED_CT_LABEL |\n"
 		"			ct_mark MASKED_CT_MARK |\n"
 		"			ct_zone MASKED_CT_ZONE |\n"
-		"			cfm CFM }\n"
+		"			cfm CFM |\n"
+		"			enc_flags ENCFLAG-LIST }\n"
 		"	LSE-LIST := [ LSE-LIST ] LSE\n"
 		"	LSE := lse depth DEPTH { label LABEL | tc TC | bos BOS | ttl TTL }\n"
 		"	FILTERID := X:Y:Z\n"
 		"	MASKED_LLADDR := { LLADDR | LLADDR/MASK | LLADDR/BITS }\n"
 		"	MASKED_CT_STATE := combination of {+|-} and flags trk,est,new,rel,rpl,inv\n"
 		"	CFM := { mdl LEVEL | op OPCODE }\n"
+		"	ENCFLAG-LIST := [ ENCFLAG-LIST/ ]ENCFLAG\n"
+		"	ENCFLAG := { [no]tuncsum | [no]tundf | [no]tunoam | [no]tuncrit }\n"
 		"	ACTION-SPEC := ... look at individual actions\n"
 		"\n"
 		"NOTE:	CLASSID, IP-PROTO are parsed as hexadecimal input.\n"
@@ -205,6 +209,10 @@ struct flag_to_string {
 static struct flag_to_string flags_str[] = {
 	{ TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT, FLOWER_IP_FLAGS, "frag" },
 	{ TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST, FLOWER_IP_FLAGS, "firstfrag" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM, FLOWER_ENC_DST_FLAGS, "tuncsum" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT, FLOWER_ENC_DST_FLAGS, "tundf" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOWER_ENC_DST_FLAGS, "tunoam" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT, FLOWER_ENC_DST_FLAGS, "tuncrit" },
 };
 
 static int flower_parse_matching_flags(char *str,
@@ -1642,6 +1650,8 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
 	__u32 flags = 0;
 	__u32 mtf = 0;
 	__u32 mtf_mask = 0;
+	__u32 dst_flags = 0;
+	__u32 dst_flags_mask = 0;
 
 	if (handle) {
 		ret = get_u32(&t->tcm_handle, handle, 0);
@@ -2248,6 +2258,17 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
 				fprintf(stderr, "Illegal \"pfcp_opts\"\n");
 				return -1;
 			}
+		} else if (!strcmp(*argv, "enc_flags")) {
+			NEXT_ARG();
+			ret = flower_parse_matching_flags(*argv,
+							  FLOWER_ENC_DST_FLAGS,
+							  &dst_flags,
+							  &dst_flags_mask);
+
+			if (ret < 0) {
+				fprintf(stderr, "Illegal \"enc_flags\"\n");
+				return -1;
+			}
 		} else if (matches(*argv, "action") == 0) {
 			NEXT_ARG();
 			ret = parse_action(&argc, &argv, TCA_FLOWER_ACT, n);
@@ -2286,6 +2307,17 @@ parse_done:
 			return ret;
 	}
 
+	if (dst_flags_mask) {
+		ret = addattr32(n, MAX_MSG, TCA_FLOWER_KEY_ENC_FLAGS,
+				htonl(dst_flags));
+		if (ret)
+			return ret;
+		ret = addattr32(n, MAX_MSG, TCA_FLOWER_KEY_ENC_FLAGS_MASK,
+				htonl(dst_flags_mask));
+		if (ret)
+			return ret;
+	}
+
 	if (tc_proto != htons(ETH_P_ALL)) {
 		ret = addattr16(n, MAX_MSG, TCA_FLOWER_KEY_ETH_TYPE, tc_proto);
 		if (ret)
@@ -3262,6 +3294,10 @@ static int flower_print_opt(const struct filter_util *qu, FILE *f,
 				    tb[TCA_FLOWER_KEY_FLAGS],
 				    tb[TCA_FLOWER_KEY_FLAGS_MASK]);
 
+	flower_print_matching_flags("enc_flags", FLOWER_ENC_DST_FLAGS,
+				    tb[TCA_FLOWER_KEY_ENC_FLAGS],
+				    tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
+
 	if (tb[TCA_FLOWER_L2_MISS]) {
 		struct rtattr *attr = tb[TCA_FLOWER_L2_MISS];
 
-- 
2.45.2


