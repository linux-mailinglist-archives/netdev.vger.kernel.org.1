Return-Path: <netdev+bounces-283620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDpoAX1q92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D44B6437
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28BD301DBB4
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7163624DB;
	Sun,  3 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRCRxF5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6F36213E
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822253; cv=none; b=FGygkDZSDCxQ4PJod/MuRk6xMRImlWuZH5hprjCTqx1JxqY7JDvAO/ZZmLvEgU3TCVyWrNoQXqRENfkhAJ0ukg0/Y7SsweggTl8uaJj0OR9khT6kImOcXVoFjtM+OrWxHqbNFWr477RoVcSqIocZBbRzvtyqKQADg2IAD7OOYPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822253; c=relaxed/simple;
	bh=zYlecJCnWmQl0gJYa0BXpS6RUzSuix/1Pegf4E93/qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEby+KXqK5sbKdyx05oluX6rwwWqG6G3uRyf9ytzh3HVmd0PSREL+8armHBkUhd9IzY4flVIA3u4PHqJr+A0bbhqF5mMQXbXNyRcOAlqyRjEC0YYljnJWi0LvINA84bxCxrkI8JVsaLrb+D7KzQjp6DjwngApR2uj3gri8qTc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRCRxF5k; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so395208b3a.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822251; x=1778427051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRZMR2wKJaL1y2Lh7uqY4H3sJS4QUXJ6YuJN8Va3OLA=;
        b=SRCRxF5kbcrsTJHrTUFF3TUc86o5fGEzweUfsgqg3+6mFKOBaEXukuUt1RUhrDl4NP
         7tZk5B+xDIfzxIc5vq3Fc6W2oSbiXiE3176kIJQW+RSMZYIWqHj6ZuNz2Gv+6KjBYcnE
         WjGcA6Ufi35rdNtqV2n6OSLnk29xT23xVZOfIfwqRIl2iyq4OeAFWYkM3jG7WGW1y5jG
         Pv76i8sBw6W0lI1q4mpWAfDEsqy18Ym2vBUug8/Hi5sDiJa8EjuPAUymuGu4zrcXmI7I
         U64fxlItI0cj6aYo/Zlq35nXasdjqtRgi2ND8pnkfxEgcXtut7a8D63OB8VP9gkTzbC4
         qZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822251; x=1778427051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRZMR2wKJaL1y2Lh7uqY4H3sJS4QUXJ6YuJN8Va3OLA=;
        b=G+Gl6onPxEIlwUhneSOJ2j+RJkbKM0x3/yakZcH/Ky35eMqtXF8vbjNkTHMkraK9Gc
         Qtev0HxIkfj7SyCoKhIakdaOXFo3d3mCiwJ7CcoHBP9qcol4Pg8tZd6hLAfAJH614ESX
         p6chTrBvnwD/V/5+7M41gQ0TuXYMXefwXY8yDD3fyKinMTA5mNyjELVkDYFI73rhWVsS
         dFxD3F3FxULBAlmEt/ApI0054lUqUwbIuNZMkN1YlMCUZa+6VHIYwQ2VdFTpSer78Q91
         2WgSiJntHbtxl2sGcaNWHu53UNzUSUODIh8n8LLW3PWd9SNdKZ7HWER0D/DzS9LqEC3h
         y+cg==
X-Gm-Message-State: AOJu0YyHt5rxYAGdjylwtMETyxWfyN1L3w8MLxEfemPnmu9sMabyptdp
	x+sOVsKdHoxnadjLD9URJdMiPUiXrOI3oUeBbLdlo838/0UkFbLb2L+4LFQdzg==
X-Gm-Gg: AeBDietirOa33nfIgxNqIxSCW9jP0QmR+a9+pw9Pfj64gpaCUW5kbfLE6+Z7ldrun4z
	gv3O1hOxibd69oURnBLXbtRBWfgbLOUIwcfUKrW0PIkX6k/QPqlOljlaGv+jABoIrFUQSNcxM0W
	9HXxElaWbS980Ng/oXL6OAkx6uSC2l9SGkLTwViI7KTENT6AjUO7stk9TWmGdZKWSYu0IkIj/Ai
	56LYl744lrwBbYKI70idbaVZJqmkD2QOVoL3qLCQlRbv/JqkPy0A19R76/wwu/n+fhiuGlLCa+M
	CnCm92VSuFaK/xqWxNhFUs+oK3HUBfe8whcWUj7ddmyIvuC14fuz2bJIvt5BDxkqWC6AdhRB0KM
	vnlK44sZa2pgKIfRPs+XUXL5wP20QH8stGMcfNlwAf4vNzmUIZRHiNZgqENiBjdVXWC51QNihJ+
	ChQevvX+pVzzez1QnrOU3/oruiEng=
X-Received: by 2002:a05:6a00:3387:b0:82f:24e:6a48 with SMTP id d2e1a72fcca58-8352d01eaebmr6125019b3a.5.1777822251416;
        Sun, 03 May 2026 08:30:51 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:50 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 6/6] seg6: add support for the H.M.GTP4.D behavior
Date: Mon,  4 May 2026 00:30:06 +0900
Message-ID: <20260503153006.900533-7-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503153006.900533-6-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
 <20260503153006.900533-2-y-kusakabe@bbsakura.net>
 <20260503153006.900533-3-y-kusakabe@bbsakura.net>
 <20260503153006.900533-4-y-kusakabe@bbsakura.net>
 <20260503153006.900533-5-y-kusakabe@bbsakura.net>
 <20260503153006.900533-6-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 617D44B6437
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
	TAGGED_FROM(0.00)[bounces-283620-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.984];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bbsakura.net:mid,end.am:url,end.map:url,ietf.org:url,end.bm:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.as:url]

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Add support for the H.M.GTP4.D headend behavior, which translates
IPv4/GTP-U traffic into an SRv6 SR Policy.  H.M.GTP4.D is installed
on an IPv4 route and reuses the existing src, v4_mask_len,
sr_prefix_len, and v6_src_prefix_len keywords.

The userspace parser fails fast when sr_prefix_len + v4_mask_len
exceeds 88 bits, since the locator, the embedded IPv4 destination,
and the 40-bit Args.Mob.Session field together must fit inside the
128-bit egress SID.

Example:
ip -4 r a 10.0.0.0/24 encap seg6local action H.M.GTP4.D \
    nh6 2001:db8:f:: src 2001:db8::1 \
    v4_mask_len 32 sr_prefix_len 56 v6_src_prefix_len 64 dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |  2 ++
 ip/iproute.c                    |  2 +-
 ip/iproute_lwtunnel.c           | 31 ++++++++++++++++++++++-
 man/man8/ip-route.8.in          | 45 +++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 0ca8405df2f2..69a875fcad73 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -82,6 +82,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
 	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
 	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
+	/* SR headend: IPv4/GTP-U decap, encap in SRv6 (RFC 9433 Section 6.7) */
+	SEG6_LOCAL_ACTION_H_M_GTP4_D	= 22,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index 1604545febc8..c3025f426f2e 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -107,7 +107,7 @@ static void usage(void)
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
 		"            End.MAP | End.M.GTP4.E | End.M.GTP6.E |\n"
-		"            End.M.GTP6.D | End.M.GTP6.D.Di }\n"
+		"            End.M.GTP6.D | End.M.GTP6.D.Di | H.M.GTP4.D }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 1234c9f146bf..dfbe8899bca0 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -410,6 +410,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_M_GTP6_E]	= "End.M.GTP6.E",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D]	= "End.M.GTP6.D",
 	[SEG6_LOCAL_ACTION_END_M_GTP6_D_DI]	= "End.M.GTP6.D.Di",
+	[SEG6_LOCAL_ACTION_H_M_GTP4_D]		= "H.M.GTP4.D",
 };
 
 static const char *format_action_type(int action)
@@ -646,6 +647,7 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 					 int mobile_sr_plen_ok,
 					 int mobile_v6src_plen_ok,
 					 __u8 v4_mask_len,
+					 __u8 sr_prefix_len,
 					 __u8 v6_src_prefix_len,
 					 __u8 dst_len)
 {
@@ -673,6 +675,32 @@ static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
 			invarg("End.M.GTP6.D.Di does not accept \"sr_prefix_len\"\n",
 			       "");
 		break;
+	case SEG6_LOCAL_ACTION_H_M_GTP4_D:
+		if (!nh6_ok || !mobile_src_ok || !mobile_v4mask_ok ||
+		    !mobile_sr_plen_ok)
+			invarg("H.M.GTP4.D requires \"nh6\", \"src\","
+			       " \"v4_mask_len\", and \"sr_prefix_len\"\n", "");
+		/*
+		 * The 128-bit egress SID built by H.M.GTP4.D packs the SR
+		 * locator, the embedded IPv4 destination, and the 40-bit
+		 * Args.Mob.Session field, so sr_prefix_len + v4_mask_len
+		 * must leave room for it.
+		 */
+		if ((unsigned int)sr_prefix_len +
+		    (unsigned int)v4_mask_len > 88)
+			invarg("H.M.GTP4.D requires \"sr_prefix_len\" +"
+			       " \"v4_mask_len\" <= 88"
+			       " (40 bits reserved for Args.Mob.Session)\n", "");
+		/*
+		 * IPv6 SA layout per RFC 9433 Section 6.6 Figure 10 reused
+		 * by H.M.GTP4.D headend; same combined bound as End.M.GTP4.E.
+		 */
+		if (mobile_v6src_plen_ok &&
+		    (unsigned int)v6_src_prefix_len +
+		    (unsigned int)v4_mask_len > 128)
+			invarg("H.M.GTP4.D requires \"v6_src_prefix_len\" +"
+			       " \"v4_mask_len\" <= 128\n", "");
+		break;
 	case SEG6_LOCAL_ACTION_END_M_GTP4_E:
 		if (!mobile_src_ok || !mobile_v4mask_ok)
 			invarg("End.M.GTP4.E requires \"src\" and \"v4_mask_len\"\n",
@@ -1795,7 +1823,8 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	seg6local_action_check_attrs(action, srh_ok, nh6_ok, mobile_src_ok,
 				     mobile_v4mask_ok, mobile_sr_plen_ok,
 				     mobile_v6src_plen_ok,
-				     v4_mask_len, v6_src_prefix_len, dst_len);
+				     v4_mask_len, sr_prefix_len,
+				     v6_src_prefix_len, dst_len);
 
 	if (srh_ok) {
 		int srhlen;
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 0487338707c6..7badfcc1e8c3 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1133,6 +1133,51 @@ is rejected for this action: the original outer destination is
 preserved verbatim instead of being repacked with an Args.Mob.Session
 field, so no locator length needs to be carried.
 
+.B H.M.GTP4.D nh6
+.IR ADDRESS
+.B src
+.IR ADDRESS
+.B v4_mask_len
+.IR BITS
+.B sr_prefix_len
+.IR BITS
+.RB [ "v6_src_prefix_len"
+.IR BITS ]
+- SRv6 Mobile User Plane H.M.GTP4.D headend behavior (RFC 9433 Section
+6.7).  Match an IPv4/UDP/GTP-U packet, strip the GTP-U envelope, and
+re-encapsulate the inner T-PDU in a new IPv6 header whose addresses
+encode the per-session identifiers expected by an
+.B End.M.GTP4.E
+SID at the egress SR gateway.  The destination UPF prefix template is
+specified by
+.BR nh6 ,
+the source UPF prefix template by
+.BR src ;
+.B v4_mask_len
+is the bit length reserved for the original IPv4 destination/source
+address, and
+.B sr_prefix_len
+is the locator length of the egress End.M.GTP4.E SID (1..88).
+The 40-bit Args.Mob.Session field defined
+by RFC 9433 Section 6.1 follows the embedded IPv4 destination at the
+offset implied by
+.BR sr_prefix_len " + " v4_mask_len ;
+its width is fixed by the RFC and is not exposed as a knob.
+.BR sr_prefix_len " + " v4_mask_len
+must therefore be at most 88 bits so the resulting 128-bit SID can
+hold all three fields.
+.B v6_src_prefix_len
+controls the IPv6 SA layout per RFC 9433 Section 6.6 Figure 10
+(\fIP\fR | IPv4 SA | padding) in the same way as for End.M.GTP4.E:
+1..127, and
+.BR v6_src_prefix_len " + " v4_mask_len " <= 128" ;
+defaults to 64 when omitted.
+.PP
+.B Note:
+because H.M.GTP4.D matches IPv4/GTP-U packets, the route must be
+installed on the IPv4 FIB (\fBip -4 route add ...\fR); installing it
+under \fBip -6 route\fR is rejected by the kernel.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


