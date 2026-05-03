Return-Path: <netdev+bounces-283626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dw0Oult92nYhgIAu9opvQ
	(envelope-from <netdev+bounces-283626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:46:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B44B64D3
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70166300C5BB
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D8838423D;
	Sun,  3 May 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihuDVGA9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF33806CD
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823137; cv=none; b=IfcIXKXc1ZCnyEn3xpAFzjIPO1mdc4Q/nA4YpMoCFx/T2Vjxhpn8NOrTet7NZnJnaSMakztZwtCcDpi9LygJOtSFilMLhfq7/gB/lYxVAyadOzAUB4Hqdy5PynBXMcxf4LmQFmbOElO3c9espUwaIyDk519ndJjjWePnGTrCXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823137; c=relaxed/simple;
	bh=o0P9uSwVi64qgMlnqkrAnB95e0bM9xPu6QzPhskIjAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRm8MVtXyvZqr2j9VzTeambDSoUE4eohMAROn1xkU26c55m5Hetni503D5l6u5YgqjYag+2E0W7OQJLiHeYctPl8sf90DiFTqotrn1ZtW3fGxOd6BX3jun45MEv6EEFjg0vCdqmU8pgGjXy3foxDmA90e4mTV48fDDxN0I1pC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihuDVGA9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3652546e41aso435758a91.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777823135; x=1778427935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddQCiovV9ee98Z8Ln2EaXKwGbcTLIXt1V+VEqUmKoW0=;
        b=ihuDVGA9I8uxldXoS+9GF55bvzp4ziXfxv7jxYoWnQP4F2iUdD6f6ZJ77+XgaDwWgO
         KrASVX4UfTJn0QEpwHAE3VnbI4vojXcNgTZYUTB6GT9E+VScRhfpwCDeQRLqhzNwutrg
         Acz72K3Kz73D3okyWm3cT545kH4m2MX6ZHNnJtc9cgiHW86iH8pSK+B7EIwHT9SbQyN0
         kudXyYzaSMUL2J2H29/x6JMOQql+UsUQZkqXDgGi+qID/rvBJ0qhvrK+5+BmOydxjY15
         QfXX6wO6p08dRWE42Nh1q9u8wXQ0pdgWtLDnetNx0y/2O4E4rtM3P/6CFU7j3059WRsn
         CEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777823135; x=1778427935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddQCiovV9ee98Z8Ln2EaXKwGbcTLIXt1V+VEqUmKoW0=;
        b=BLad4tgiWOGpYd8Gfi3kxxM8sCuzVFKHsPyOln81E+fcVOSEQkxBEaRr7IBo8/FO3B
         hbCrWzavcu6CRA9Qc5mxWxHPGikPjjnJDifvOQ9PI128kbYFNJZ2GtjPe9xffW8n1Dmm
         z21Bd+cbtqoZW2HkXvTrY3omifqf30OzxxzdL9051gp953PSLWJroh7jWkRFYI0A01qJ
         +3wqyby4bGGrG++5LOpA2dXo//ZXOWvGSU+JQchdSmmEPPokoCUhXMDzNjLyGcM/Km//
         bD9N2L+9VZH7c40hKe8VSsxRmePrBsN9mtX6EkisId6Y8s/B6ZBO4Fw9ULDjAQp/eHBf
         9rjQ==
X-Gm-Message-State: AOJu0YwgnmJPuIJw/NS31rudhv3ZUgnzj0JnyYLZyuh6emVC1H8XvikI
	t6vMG1eb3VIQHp6vCtTEEr/WO4Qc1XtJbPoHqr60m4OSqcU6Rn252ANK
X-Gm-Gg: AeBDieuHg9hYjVCUSeY6UUKi4eed4BLnDep7piNxqsQtJyxgEAr1DkL7irA/O6h//zJ
	JHVdIitEb5ktz1cGVweK3FhUaTjOU7jDzGn1BqQ8ZCWZgYV8lRqGi32zrJlZ8H24jqDQiV30Pch
	7zLS6u9RUElC0k3zBKW8N06NgAq7MPXdgLbLuE3Mil7MNnDx6WamYxVrjH9NyKhONAYGlSf+SHF
	tlLN+5Fk1+kqe9C2J9Ao6EKTiNl6dLw/kYHplscwvfdjf4c0WK1pTSOLtpcHmQRSCbHfzQHU9AV
	JuCcMxPn5ie3NJrcYyRoRdrrCb34JcENyUE088rREelyLJ9euQd2l9+z972vrXto1NC66E8NCd3
	/tdQdfHdLGeJ1KbksJPjPUPgqveZ8dq5UTRDlfQ7+cDVsRJQIk2qbYXo5yom7cn9mk1rpbh8B3Q
	Dn3/XNZ3SgG/k1YRAfXLuTv8DuIuo=
X-Received: by 2002:a05:6a20:6a08:b0:3a3:17f8:bedd with SMTP id adf61e73a8af0-3a7f1a9a450mr6682580637.17.1777823135003;
        Sun, 03 May 2026 08:45:35 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6ec67sm7207421a12.17.2026.05.03.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:45:34 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next v1 RESEND 5/6] seg6: add support for the End.M.GTP6.D.Di behavior
Date: Mon,  4 May 2026 00:45:09 +0900
Message-ID: <20260503154510.912576-6-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503154510.912576-5-yuya.kusakabe@gmail.com>
References: <20260503154510.912576-1-yuya.kusakabe@gmail.com>
 <20260503154510.912576-2-yuya.kusakabe@gmail.com>
 <20260503154510.912576-3-yuya.kusakabe@gmail.com>
 <20260503154510.912576-4-yuya.kusakabe@gmail.com>
 <20260503154510.912576-5-yuya.kusakabe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 439B44B64D3
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283626-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,end.am:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.map:url,end.bm:url,end.as:url]

Add support for the End.M.GTP6.D.Di drop-in interconnect behavior,
which translates IPv6/GTP-U traffic into an SRv6 SR Policy while
preserving the original outer IPv6 destination as the final SRH
segment.  Unlike End.M.GTP6.D, this behavior does not take
sr_prefix_len.

Example:
ip -6 r a 2001:db8:f::/64 encap seg6local action End.M.GTP6.D.Di \
    srh segs 2001:db8:2::1,2001:db8:3::e \
    src 2001:db8::1 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           | 10 ++++++++++
 man/man8/ip-route.8.in          | 16 ++++++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index ed44fb858600..0ca8405df2f2 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -80,6 +80,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
 	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
+	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 8ced32a4f84e..1604545febc8 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -107,7 +107,7 @@ static void usage(void)
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
 		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
-		"            End.M.GTP6.D }\n"
+		"            End.M.GTP6.D | End.M.GTP6.D.Di }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index d54bf4628f6f..1234c9f146bf 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -409,6 +409,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_D_DI]	= "End.M.GTP6.D.Di",
 };
 
 static const char *format_action_type(int action)
@@ -632,6 +633,7 @@ static bool seg6local_action_excludes_final_seg(int action)
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
 	case SEG6_LOCAL_ACTION_END_M_GTP6_D:
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D_DI:
 		return true;
 	default:
 		return false;
@@ -663,6 +665,14 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 			invarg("End.M.GTP6.D requires \"srh segs\", \"src\","
 			       " and \"sr_prefix_len\"\n", "");
 		break;
+	case SEG6_LOCAL_ACTION_END_M_GTP6_D_DI:
+		if (!srh_ok || !mobile_src_ok)
+			invarg("End.M.GTP6.D.Di requires \"srh segs\" and \"src\"\n",
+			       "");
+		if (mobile_sr_plen_ok)
+			invarg("End.M.GTP6.D.Di does not accept \"sr_prefix_len\"\n",
+			       "");
+		break;
 	case SEG6_LOCAL_ACTION_END_M_GTP4_E:
 		if (!mobile_src_ok || !mobile_v4mask_ok)
 			invarg("End.M.GTP4.E requires \"src\" and \"v4_mask_len\"\n",
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 35e6e2080a1f..0487338707c6 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1117,6 +1117,22 @@ The action requires either no SRH or an SRH with
 equal to zero on the inbound packet; other matching packets are
 dropped.
 
+.B End.M.GTP6.D.Di srh segs
+.IR SEGMENTS
+.B src
+.IR ADDRESS
+- SRv6 Mobile User Plane End.M.GTP6.D.Di drop-in interconnect behavior
+(RFC 9433 Section 6.4).  Identical to
+.B End.M.GTP6.D
+except that the original outer IPv6 destination address of the
+incoming GTP-U packet is preserved as the final segment of the new
+SRH, allowing existing SRv6 networks to be inserted into a legacy
+mobile path without changing the destination semantics.
+.B sr_prefix_len
+is rejected for this action: the original outer destination is
+preserved verbatim instead of being repacked with an Args.Mob.Session
+field, so no locator length needs to be carried.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


