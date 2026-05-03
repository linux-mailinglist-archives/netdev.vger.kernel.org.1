Return-Path: <netdev+bounces-283618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKLWLVdq92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA214B6427
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE6A300B13B
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A536165D;
	Sun,  3 May 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYU/MMjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175F35F60E
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822250; cv=none; b=CspwIm4GHwIyE5SfPLmn9HH8yZBm/Hu3XLJ0iZZ5drXpwzzFqFJHMzfclu0E/1vElvCBPx2GZgE7sqdeRUr0aVxiYQBolhwPTd+k35ru86xzSkC9KBjeCgoW9uFZZi3L4a+oL7UOlxS0gOFPFjjE/jQHKFEHICjgOsdP6riVmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822250; c=relaxed/simple;
	bh=cTGAbBxsOliSgh/ewSY+N6HWsy/dqi22kYlsNfljYeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJH+TlZ005gA3up2fA42ZJf3NwZBtKj6XaTpoQ7VLCietNjtim/odcALaSpraXFfAsyAFicVbtQo0lTWVUM2s4KGgyK/4d76lq5RZgBp5pOFmsERDOfKHkUF1uAosCyi+Mg0MdrM6SGPhhAgLXTcZDKEBxdTLciqKUOs4sH9tKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYU/MMjc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8379e010b01so25434b3a.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822248; x=1778427048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0wkmxkaXrfmpkCOETj0vw0pEw3MOZ108Wwda620NUc=;
        b=aYU/MMjcH0NvLhItNdQToleT7bpAtTiBnXAgn92uVCO8tG38UEFqSZHlWnisPVCanC
         tl0TLrZcQOBRmUpUPuvmE/I9Vb6m/Scn9ZUdaRmCxYabPp7tb81zhRAoehrEw0AWIqt3
         k2LXMirXsBoVR7bkzU9/QLPKGkXT41Hc5HZON+qmr84JiyoGbb+N6br2lhmo5jK7VqIC
         1XR+Q7lBzUWw5mQGcd2i3rKT+hw3kvyO4awvVK93SpGvg3XeAOclle4iyMxoxF9xmIqb
         73FF6ckFDK1U+xlkmj6b8gTPSYoLlZsJ9r0zNa11TN9qbYQdi8rOq+BZLZ2CA1qU1I+d
         KUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822248; x=1778427048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0wkmxkaXrfmpkCOETj0vw0pEw3MOZ108Wwda620NUc=;
        b=as4506fddTmCIGST7Nv9o9FkLH10LXf14xwuxuBST2topAKRnXHnJMLG5cYNX1pCAK
         svedBlMgFEjoxLIStQ9F990wW5s18ooUsHi9BHAN3nynsHYGxUZCjTK6JBULwtP0A9w6
         5TOY1UHWlclJujid5Sxk0hYfrjC6EWX5q2eFpm8d7amQMypX7JQODVyqgEk9+riW1GdX
         lWBZKs8e/oC6auRnWx7qKXSDm+bft2/vMcYYdPNF4I5PO/UR5LtUE3TYqtBD7ukP0L7f
         OcvhbGIbBFtSxRl1SRBR7gwP2IG2ZFd7oXIIgHIYZu2x8W98DTnssFROHOtreKrtAIom
         m7zw==
X-Gm-Message-State: AOJu0YxeuMN16aghfKVdb2iG1YRXuXAuP/p24vNDSb2aDd//Z5jqVToj
	Rs2Y5AcgcUr7+4nWdbQfeZvOyAfiQrQBi65HXA6aX6BQXUiPff/gaP7W
X-Gm-Gg: AeBDietQhy7oY0+LDvq3F68jQHrjpTCrMcgVoiXScO7VmdtX3XJPwGhwXqp1y1/nCpM
	pAsmLHwQvstT6oB/KFPB6jlg6VRLZtsvw/X0nFwpnYu/xNSxnUPJd+XkNSUxGA7gJtwYR9CDUeE
	0CAm/3HvUGd+ybnuJQ679nlCQkhhB5jXzfCfPYEuAg7PX361Z/2TOjzBAu7sI66CblKSGAAnNVa
	UDzuVsIPAfb5SYBt62soTRyElZ/BE6OVfj+v9aNu2/SfIqDPujMge7T7HVyCVsCYmkVQYm8QR86
	AxTNX36CAYliL3fXsU0A8XrHJXW2XlSLZdRjASAOdXIK/mTpQoiTdggBzPJdsvf7pGFzG8F2gYy
	H9j15uMHlICMABNcdGAQ3VGehnJsjobutQPPrPrUQ8UqfROGRdi64DrPiR9tXFYIxqUJso5dpEz
	L1tUeu7AGcVfz8E5pB9y+4SQRg8I8=
X-Received: by 2002:a05:6a00:430a:b0:81f:852b:a925 with SMTP id d2e1a72fcca58-8352d03bf06mr5605571b3a.1.1777822248027;
        Sun, 03 May 2026 08:30:48 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:46 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 4/6] seg6: add support for the End.M.GTP6.D behavior
Date: Mon,  4 May 2026 00:30:04 +0900
Message-ID: <20260503153006.900533-5-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503153006.900533-4-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
 <20260503153006.900533-2-y-kusakabe@bbsakura.net>
 <20260503153006.900533-3-y-kusakabe@bbsakura.net>
 <20260503153006.900533-4-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FA214B6427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283618-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bbsakura.net:mid,end.am:url,end.map:url,ietf.org:url,end.bm:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.as:url]

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Add support for the End.M.GTP6.D behavior, which translates IPv6/GTP-U
traffic into an SRv6 SR Policy.  The SR Policy is supplied through the
existing srh segs syntax, and a new sr_prefix_len keyword specifies
the locator length of the egress End.M.GTP6.E SID (1..88, leaving
40 bits for the Args.Mob.Session field).

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.M.GTP6.D \
    srh segs 2001:db8:2::1,2001:db8:3::e \
    src 2001:db8::1 sr_prefix_len 88 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  3 ++
 ip/iproute.c                    |  6 ++--
 ip/iproute_lwtunnel.c           | 61 +++++++++++++++++++++++++++++----
 man/man8/ip-route.8.in          | 29 ++++++++++++++++
 4 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 6af145259ffb..ed44fb858600 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -33,6 +33,7 @@ enum {
 	SEG6_LOCAL_MOBILE_V4_MASK_LEN,
 	SEG6_LOCAL_MOBILE_PDU_TYPE,
 	SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
+	SEG6_LOCAL_MOBILE_SR_PREFIX_LEN,
 	__SEG6_LOCAL_MAX,
 };
 #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
@@ -77,6 +78,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
 	/* SRv6 to IPv6/GTP-U encap (RFC 9433 Section 6.5) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
+	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index a77df0da0efe..8ced32a4f84e 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -106,11 +106,13 @@ static void usage(void)
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
-		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E }\n"
+		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
+		"            End.M.GTP6.D }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
-		"MOBILE_OPTION := { src ADDR | v4_mask_len BITS | v6_src_prefix_len BITS |\n"
+		"MOBILE_OPTION := { src ADDR | v4_mask_len BITS | sr_prefix_len BITS |\n"
+		"                   v6_src_prefix_len BITS |\n"
 		"                   pdu_type { downlink | dl | uplink | ul | 0..15 } }\n"
 		"FLAVORS := { FLAVOR[,FLAVOR] }\n"
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 7a4acc33602b..d54bf4628f6f 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -408,6 +408,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
 };
 
 static const char *format_action_type(int action)
@@ -589,6 +590,11 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 		print_uint(PRINT_ANY, "v4_mask_len", "v4_mask_len %u ",
 			   rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_V4_MASK_LEN]));
 
+	if (tb[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN])
+		print_uint(PRINT_ANY, "sr_prefix_len",
+			   "sr_prefix_len %u ",
+			   rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_SR_PREFIX_LEN]));
+
 	if (tb[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN])
 		print_uint(PRINT_ANY, "v6_src_prefix_len",
 			   "v6_src_prefix_len %u ",
@@ -616,9 +622,26 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 	}
 }
 
+/*
+ * SRH-supplying actions (the seg6local equivalents of seg6 inline mode)
+ * pass the entire segment list explicitly; parse_srh() must not append the
+ * implicit terminating SID it adds for inline-style callers.
+ */
+static bool seg6local_action_excludes_final_seg(int action)
+{
+	switch (action) {
+	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 					 int mobile_src_ok,
 					 int mobile_v4mask_ok,
+					 int mobile_sr_plen_ok,
 					 int mobile_v6src_plen_ok,
 					 __u8 v4_mask_len,
 					 __u8 v6_src_prefix_len,
@@ -635,6 +658,11 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 		if (srh_ok)
 			invarg("End.M.GTP6.E does not accept \"srh\"\n", "");
 		break;
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D:
+		if (!srh_ok || !mobile_src_ok || !mobile_sr_plen_ok)
+			invarg("End.M.GTP6.D requires \"srh segs\", \"src\","
+			       " and \"sr_prefix_len\"\n", "");
+		break;
 	case SEG6_LOCAL_ACTION_END_M_GTP4_E:
 		if (!mobile_src_ok || !mobile_v4mask_ok)
 			invarg("End.M.GTP4.E requires \"src\" and \"v4_mask_len\"\n",
@@ -666,9 +694,10 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 			       " \"v4_mask_len\" + 40 <= 128\n", "");
 		break;
 	default:
-		if (mobile_src_ok || mobile_v4mask_ok || mobile_v6src_plen_ok)
-			invarg("\"src\", \"v4_mask_len\", and"
-			       " \"v6_src_prefix_len\" are only valid for"
+		if (mobile_src_ok || mobile_v4mask_ok || mobile_sr_plen_ok ||
+		    mobile_v6src_plen_ok)
+			invarg("\"src\", \"v4_mask_len\", \"sr_prefix_len\","
+			       " and \"v6_src_prefix_len\" are only valid for"
 			       " SRv6 Mobile User Plane actions\n", "");
 		break;
 	}
@@ -1547,7 +1576,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	int segs_ok = 0, hmac_ok = 0, table_ok = 0, vrftable_ok = 0;
 	int action_ok = 0, srh_ok = 0, bpf_ok = 0, counters_ok = 0;
 	int mobile_src_ok = 0, mobile_v4mask_ok = 0, mobile_pdusess_ok = 0;
-	int mobile_v6src_plen_ok = 0;
+	int mobile_sr_plen_ok = 0, mobile_v6src_plen_ok = 0;
 	__u32 action = 0, table, vrftable, iif, oif;
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
@@ -1555,7 +1584,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	char segbuf[1024];
 	inet_prefix addr;
 	__u32 hmac = 0;
-	__u8 v4_mask_len = 0, v6_src_prefix_len = 0;
+	__u8 v4_mask_len = 0, sr_prefix_len = 0, v6_src_prefix_len = 0;
 	int ret = 0;
 
 	while (argc > 0) {
@@ -1679,6 +1708,23 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 				       *argv);
 			ret = rta_addattr8(rta, len, SEG6_LOCAL_MOBILE_V4_MASK_LEN,
 					   v4_mask_len);
+		} else if (strcmp(*argv, "sr_prefix_len") == 0) {
+			NEXT_ARG();
+			if (mobile_sr_plen_ok++)
+				duparg2("sr_prefix_len", *argv);
+			/*
+			 * The egress SID must leave room for the 40-bit
+			 * Args.Mob.Session field, so the locator can be at
+			 * most (128 - 40) = 88 bits.
+			 */
+			if (get_u8(&sr_prefix_len, *argv, 0) ||
+			    sr_prefix_len == 0 ||
+			    sr_prefix_len > 88)
+				invarg("\"sr_prefix_len\" must be in the range 1..88\n",
+				       *argv);
+			ret = rta_addattr8(rta, len,
+					   SEG6_LOCAL_MOBILE_SR_PREFIX_LEN,
+					   sr_prefix_len);
 		} else if (strcmp(*argv, "v6_src_prefix_len") == 0) {
 			NEXT_ARG();
 			if (mobile_v6src_plen_ok++)
@@ -1737,14 +1783,15 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	}
 
 	seg6local_action_check_attrs(action, srh_ok, nh6_ok, mobile_src_ok,
-				     mobile_v4mask_ok, mobile_v6src_plen_ok,
+				     mobile_v4mask_ok, mobile_sr_plen_ok,
+				     mobile_v6src_plen_ok,
 				     v4_mask_len, v6_src_prefix_len, dst_len);
 
 	if (srh_ok) {
 		int srhlen;
 
 		srh = parse_srh(segbuf, hmac,
-				action == SEG6_LOCAL_ACTION_END_B6_ENCAP);
+				seg6local_action_excludes_final_seg(action));
 		srhlen = (srh->hdrlen + 1) << 3;
 		ret = rta_addattr_l(rta, len, SEG6_LOCAL_SRH, srh, srhlen);
 		free(srh);
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 7cf97924d699..35e6e2080a1f 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1088,6 +1088,35 @@ takes the same syntax and semantics as in
 .B End.M.GTP4.E
 above (no PDU Session Container is inserted unless explicitly set).
 
+.B End.M.GTP6.D srh segs
+.IR SEGMENTS
+.B src
+.IR ADDRESS
+.B sr_prefix_len
+.IR BITS
+- SRv6 Mobile User Plane End.M.GTP6.D behavior (RFC 9433 Section 6.3).
+At the SR ingress gateway, the matching IPv6/UDP/GTP-U packet has its
+GTP-U envelope removed and the inner T-PDU is re-encapsulated in SRv6
+using the supplied SR Policy
+.RI ( srh
+\fBsegs\fR\~\fISEGMENTS\fR).  The TEID is folded into the 40-bit
+Args.Mob.Session field placed immediately after the egress
+End.M.GTP6.E SID's locator (RFC 9433 Section 6.5),
+.B sr_prefix_len
+specifying the locator length in bits (1..88 -- the upper bound
+leaves room for the 40-bit Args.Mob.Session field within the
+128-bit egress SID).  The egress SID's locator
+length cannot be inferred from local state at the SR Gateway.  The
+egress
+.B End.M.GTP6.E
+SID can then recover the per-session identifier from the same offset.
+The new outer IPv6 source address is taken from
+.BR src .
+The action requires either no SRH or an SRH with
+.B Segments Left
+equal to zero on the inbound packet; other matching packets are
+dropped.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


