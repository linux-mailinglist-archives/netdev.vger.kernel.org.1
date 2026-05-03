Return-Path: <netdev+bounces-283617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIIjCURq92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A544B6420
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 568373012C5B
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4635CB61;
	Sun,  3 May 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqIDBW34"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439135DA65
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822248; cv=none; b=bPo2VRc0odz9SCJKljWehekc7gK3TaeKIOF4h1QPQQZJ6HeM+NTtShIuHZOxgwB+cH+0sIhn+1ValH0flYN7VyaaVpO7wVlk9AVDN58wxMnyQNJ73oBRea64DbXVRxsHCfypz7adjCegGZdF59q+UH6UzeTdeBJ5rWnz1u+vO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822248; c=relaxed/simple;
	bh=5sFyqI+mD9VCLPkXEDww63Vvp8C328AQXnsdrvMY7Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spru7p2y/J/5lxnVbzif1sRdRrAK0l1M37cSVryEgEvw7e+I5pewXAtIR0XizyHaMMpCLudTADgsJzABYRKduX6SKpmKbMMQNpwbYT/pAavi+ipRgwEMVWgc5K8Tn7Ej5Ew25xSapIplA/AoX/ULuERQb8O6lB5fz3oPCbB0cD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqIDBW34; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so308193b3a.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822246; x=1778427046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2v2SkjyPFSKDoAs1R95ZQZ4kNSCXVeGi04Do/Nm88A=;
        b=cqIDBW3482wLs/8d0eO7d6Z/e59prQUmK1/r8TkJ8BM4Q1ad+GuRHfk5o1hMAt5f57
         IMgQIuge+7OySMsZ84LBJ/ffl4/rszHeo8d0tT9y8qeLgf8Zj32m/hwRt7xrP4otMijv
         4OD80yHXTEPS+qd+w5U5DgogiRVMfKumBsQtpj3HOwVJOZqEIdwX107hoL7G2GbCqQqb
         SJYw8jUL43ZOBdogetWD+NpeVBt5uL3BVNtzX41x6k0c7pSM+3F37ViI1kEhK5EJpVWi
         vFOWm5prxnBiLYCPpzNoIIblTSIPFY3fDmahCH9ov0+vdmpQwxqMDC/Bdy20IEjf6anl
         M4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822246; x=1778427046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y2v2SkjyPFSKDoAs1R95ZQZ4kNSCXVeGi04Do/Nm88A=;
        b=E6DcwZ2BwLqiJQA5edV26PddsUQSwEVMgIxH7OxM7mmmTIKivpfQu8XDajGITNof9j
         v+wE+ApKWxE/TPqJt2KYI+UhcqcYEcnrUpuqbNXXU7fTzeG32CsuZFI9jfxjvM+LBgT2
         dVOQUlRJ/mNONs79P0QPTK1xjpP0BU0NbW+sEVNNNwaoe0eR3Whme3WyV2MjPFtdDTUD
         AGtJisAgb5jVc0TmkyBBSnxZZwaM8qW5wIZ7Gk2nrSSmhT6y/q0YjhJeAVRSdYwHpfHs
         GcMYJQjJp9jixRn0L7HvP5M4ju6T7C6vFH4JGAJwJHjysmY3m6+jmFkhHu5d9kuWsmeW
         CjBg==
X-Gm-Message-State: AOJu0YwHPPxr0QNT9t8TSxOzor99ek7mlp8/0zi8K4MwHWzPCt6KugkI
	giYY5qAOvicujWTurQqAIn0fnQhI3SL9Mx58vlcC+dcowwIM0/1ufs8vQ+0Pdw==
X-Gm-Gg: AeBDietNKWYwRm9WEhkNTqymZC6ScgRVlFl0TelqE7p9O9tR20k/7rTUsmeNr0Phfu/
	7kkto43g9qbtUWhaQT7BWp0EYarsIouMp9UDD8ivKbHXeZfwj6MggverQ4iTpHlc6m/53YziG2Y
	vrDaKvhEJu0Q9mdGd8WrRdAqXbyQbt7k3j1XzM8HpsReYeDoOkiIChs06pgBAq1HjyOIq5l9fq1
	5dTzh3WoM7iR+W94UbnHMZrTd1NFyZ5UKJTwjasnYNhCJBF9zLChV89xhEDFSOqQPQpMwZS0jtC
	LhuiWJQgT5qfKVxWRyIqkBUBRWPo2SA7NaBxXsow9RYayuL9bJDmUhn1YBjTRHrPKyBHD4P+KJG
	ypIJrfmZJchgj4pUOPFtzAWKFLjpsgZ0dSTEoQVj0WvzrFU3lxNNrfAPkbvt8LPLf96xVP4Fnqk
	5h2yox6rwoR+vW4tDZRE/YNr1YGgI=
X-Received: by 2002:a05:6a00:1989:b0:831:7627:4ab7 with SMTP id d2e1a72fcca58-8352d26ccb3mr6686962b3a.29.1777822245924;
        Sun, 03 May 2026 08:30:45 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:45 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 3/6] seg6: add support for the End.M.GTP6.E behavior
Date: Mon,  4 May 2026 00:30:03 +0900
Message-ID: <20260503153006.900533-4-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503153006.900533-3-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
 <20260503153006.900533-2-y-kusakabe@bbsakura.net>
 <20260503153006.900533-3-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90A544B6420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283617-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


