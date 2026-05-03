Return-Path: <netdev+bounces-283624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEoCMslt92nYhgIAu9opvQ
	(envelope-from <netdev+bounces-283624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:46:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F954B64C4
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9053B30160F7
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4237F753;
	Sun,  3 May 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVjxUS/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25237F725
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823132; cv=none; b=l7zrCU8N4TWIDx+jJb15NGphf5VmTy6OfqEF+AQ2V5QvJkEh6Qvy+WXos8TYgXqITXiAhsbJhYaSwDnWAJO0irfqbicslLR96oc05nTuD218WcoRfJCVB39iKy/F/RCLaoGiyxTLhVm0xmkNwmPhcamK/xsQd2Z8R3gfZ7pnC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823132; c=relaxed/simple;
	bh=K02cz+TBDSg3gYDQEgyHGGHcfuxAMPGqYdYLnXhcGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ48RP4o+rxy2czlDDuug33CrKsuUeaQoMWSNpLCKFJE+ttleCPwveniyE7/7wkIoJv6A6gW9qqTiWa576/uy/hjzb3l+vCRO5e+Sj7QmFPcAdOoaZMGvSIlyHDvArbEKSUcKutK4lRnUC2gFMil9xXPftqAnl28oQGrBPAg9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVjxUS/v; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1952896a12.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777823130; x=1778427930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65VHnwW+SeeZMb0brhirn+XfX9WAd/iKmMupNSiBCCE=;
        b=iVjxUS/vf2PbSfUe7tiMdXv60xCwtTAlPJer16Avmut3ySOoXAE2hqysb329qwDluR
         7edWsn1VonD8LVSvAI/rNQhJjTSDHj/w0dyv6fyRpDJj3l02YKj3fDugCqjyXMpg1eQk
         GA+/PEEjbN9gcSwgPfOogrRlnxYGNKI6gf/WPWmE7vYKYXSnX6KXg1KbHmOSI77+sQVK
         nRH0Sh2vTRgyzUaSGLW4V7bvVsfDpKKqCFkSzl1AvT06MtD4PQXkhLIR0tQV2LOIiDM5
         ALtt0fARIw+4ESWaSg5jmZPIAJCz/gHbWa44E2Z6jXDNZmYGXmWZsX/aWTOLFZ1lDomk
         Joug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777823130; x=1778427930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65VHnwW+SeeZMb0brhirn+XfX9WAd/iKmMupNSiBCCE=;
        b=FpQiB2j6CYy2Z0TVrsavHtbrjPFZCxb0oNGyKFET2PiQl30zzlCKfd9SIs5n3Sv92m
         BLNj1LMb7etUMfxYGrMgp75N0MEZ293uh3UqVCT7XEFhn1Ge9z5DhQmK4afLK+e5wQxd
         fMU+TybvZ3uxms8zZLeLe57fXouka76+exn7gsmptxINypYM6yKUxwmgXatErzp6Tjkk
         GfVNfq9cw/xholyRuJi3EHb2d9jMMflEZF3qJqCra7fl98pyt0wS7PWU0NoUmWMam6q3
         BRkUkAgeV7fRgPDkmLGNmVk9aERXgg31vVBcMFMxp6E5IvU3Oxre5/BfQVlL47DU21zw
         yqEg==
X-Gm-Message-State: AOJu0YweGLRCQAW6na1n9aZm4RjqFO6A5h8/VUq7y/NRH+E14pKuYQLj
	e3za1yC2OVz7PFhsMdCWEw7mQfZJUedIpjV+htsd4KxV8tzQmFIzsX70
X-Gm-Gg: AeBDiet1o9MDFx7H1P80jBGZjnRU7AZwP3sQWhuapIQwJYKWGjX+jAYWOQXsQSpabcm
	Fsa4kn68eqdGPSSa0FQbiAsDY+seBG2sqc0uiH7VYpoe3zMqrsTejK11kWf/P2n9FcVba9QAWdb
	fnbM/PUPx00F6AeMu+zf720Rr5ItML8/NDQi6E+5isRg/j7G6FQUWWfoPSh42Nbzq+fVLUg8uOx
	F4FUHD0lyBeLdYBeG08c5YU01r3NFVUe4bXdGQzzL+KqxWpbMj5VbhaSdNZmL5Ej+KtTzGKuId1
	hVtAShSm2QxrmeLsqq5B5F6tnqvtNoZ2h77ENuqi8p3tvKP1EtM2C+8ns20wz7H7O8Eo+uBY1Oz
	WV6Eu7hdflp6CmxFzGJE4vbC7DqXjGJYre9IRg5i8aeBAyLWKPbNbF0EV3PDBfAXZggulagPmNR
	Nlu/bfyD8Mu/q+12h7+7gd2mjPR+c=
X-Received: by 2002:a05:6a20:9188:b0:398:7d6e:27f4 with SMTP id adf61e73a8af0-3a7f1c24481mr7023199637.1.1777823130036;
        Sun, 03 May 2026 08:45:30 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6ec67sm7207421a12.17.2026.05.03.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:45:28 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next v1 RESEND 3/6] seg6: add support for the End.M.GTP6.E behavior
Date: Mon,  4 May 2026 00:45:07 +0900
Message-ID: <20260503154510.912576-4-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503154510.912576-3-yuya.kusakabe@gmail.com>
References: <20260503154510.912576-1-yuya.kusakabe@gmail.com>
 <20260503154510.912576-2-yuya.kusakabe@gmail.com>
 <20260503154510.912576-3-yuya.kusakabe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32F954B64C4
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
	TAGGED_FROM(0.00)[bounces-283624-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,end.map:url,end.am:url,end.as:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.bm:url]

Add support for the End.M.GTP6.E behavior, which translates SRv6
traffic into IPv6/GTP-U.  The behavior reuses the src and
pdu_session_type keywords introduced for End.M.GTP4.E; v4_mask_len is
not meaningful for an IPv6/GTP-U tunnel and is rejected.

Example:
ip -6 r a 2001:db8:1::/64 encap seg6local action End.M.GTP6.E \
    src 2001:db8::1 pdu_session_type ul dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           |  7 +++++++
 man/man8/ip-route.8.in          | 21 +++++++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 8bb3cdc3a649..6af145259ffb 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -75,6 +75,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_MAP	= 17,
 	/* SRv6 to IPv4/GTP-U encap (RFC 9433 Section 6.6) */
 	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
+	/* SRv6 to IPv6/GTP-U encap (RFC 9433 Section 6.5) */
+	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 628bccc28074..a77df0da0efe 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -106,7 +106,7 @@ static void usage(void)
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
-		"            End.MAP | End.M.GTP4.E }\n"
+		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 1a92b7d94e88..7a4acc33602b 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -407,6 +407,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
 	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
 	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
+	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 };
 
 static const char *format_action_type(int action)
@@ -628,6 +629,12 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 		if (!nh6_ok)
 			invarg("End.MAP requires \"nh6\"\n", "");
 		break;
+	case SEG6_LOCAL_ACTION_END_M_GTP6_E:
+		if (!mobile_src_ok)
+			invarg("End.M.GTP6.E requires \"src\"\n", "");
+		if (srh_ok)
+			invarg("End.M.GTP6.E does not accept \"srh\"\n", "");
+		break;
 	case SEG6_LOCAL_ACTION_END_M_GTP4_E:
 		if (!mobile_src_ok || !mobile_v4mask_ok)
 			invarg("End.M.GTP4.E requires \"src\" and \"v4_mask_len\"\n",
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index a878d4375f03..7cf97924d699 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1067,6 +1067,27 @@ PDU Type; when omitted no Container is inserted, so 5G N3 deployments
 must set it explicitly.
 The action only accepts packets with Segments Left = 0 or no SRH.
 
+.B End.M.GTP6.E src
+.IR ADDRESS
+.RB [ "pdu_type"
+.IR DIR ]
+- SRv6 Mobile User Plane End.M.GTP6.E behavior (RFC 9433 Section 6.5).
+At the SR egress gateway, an SRv6 packet whose current SID is an
+End.M.GTP6.E SID is converted into an IPv6/UDP/GTP-U packet directed at
+the next segment held in
+.IR SRH[0] .
+The 40-bit Args.Mob.Session field defined in RFC 9433 Section 6.1 is
+read from the right-aligned tail of the matching SID, and its 32-bit
+PDU Session ID portion is used as the GTP-U TEID.  The IPv6 source
+address of the new tunnel is set to the user-provided template
+.BR src .
+The action requires Segments Left to equal 1; other matching packets are
+dropped.  The optional
+.B pdu_type
+takes the same syntax and semantics as in
+.B End.M.GTP4.E
+above (no PDU Session Container is inserted unless explicitly set).
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


