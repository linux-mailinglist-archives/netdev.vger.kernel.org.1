Return-Path: <netdev+bounces-283627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKGpOPdt92nYhgIAu9opvQ
	(envelope-from <netdev+bounces-283627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131D4B64DA
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64E1301E5AB
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD638644D;
	Sun,  3 May 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxHZXjdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049336E483
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777823139; cv=none; b=P4zKyNN4k4PyMwAJRmyIJwpTu5+1PIOQpQYakhyBEVrTnKNAB6SJsz6e4nha6Vw+nsoY8zaqK4JlkbUZi+B9ziOeAgby/kLkXFrnQ4L+wCAjut0X0dQiyJRfTpGOQOEnETPt27U7SR1EU3a1vC0aP6oxjr0sMjvTW8Vc4+JTe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777823139; c=relaxed/simple;
	bh=mNOPHzMTEu8C3ConjHz9EmywIWnbfJnJIr//7wQLyhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxcP9mBxh2h1WOlkxYNUGnidmhKZVjQ1GpxhVuccEFQ5qeJBGGiNQRIIBJU12Dn6ADI72O7uBp6wGt9gLEdMpod7O+FvZxkVG3pidRwBsQZpG/8Ys0ATWEhDr2EcF7iiwGVb24O6RP037rmR9Bye2wapv2fKgEpmgzaXP1cpeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxHZXjdQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so1203481a12.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777823137; x=1778427937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zitD8JKr+Cawo59bfQ5tOogDnbSLhTKpFDSJvhpu9cM=;
        b=pxHZXjdQtEuDrycPgkI1EjK9+EI4s33k3VC//ABoz6S7duonmuJJ4YyHzTXUgmuyX1
         lKDecu2+r6b3YmqcWsNJvlUTbuUop1jUPGmWIqVx7GVPTPVjk+7LKuDJQ5rBPTa1vq1i
         BrnkDQitTlMMBPa4VitedulhBkxHFTosIu5cw5GIp5BsuupD4jMukezKsNL59dI6QQkM
         lIcvXkA9kJRyQm+VBW9N/C35pXJvd00kyE4AzAXKliYT2X2dWUS/SKn9Y7cfd0jF7aaN
         YnAEIlzTRTr5tyIqt55ODWei3nNzE51mixxGX5CFLed4616V952ixpiU21UcQz/34a02
         jcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777823137; x=1778427937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zitD8JKr+Cawo59bfQ5tOogDnbSLhTKpFDSJvhpu9cM=;
        b=Jozlkwl9Ex1l4GNiBbX/BTDJG6a7RT15aEbfWmidUYglWqbxfXOt/ywc2Nm9FlREbP
         f+V2VEA8Uo0WG0b4wPWrjfrAwr641jlCnQCAbNV0Jt9kcgMDeyRL1NeiOTCpBVjVCzoX
         uAgRR54h6M8sCXQTjKGYGOLkWeePEuQ7W3DLGR8W0s2DJ1ZgP2HWIGnnO87WzajtPuHd
         btEVhdWsuOzf+/XAqtw24WkT0+qQSTJtKCSacuaLM9qIn3TRjPf55v+Ne+oqfiZhOyXr
         KpszbVh3TKyrT+85gTgGh+yIjYVyD6Tw1Blvu0D+/35A1xy5n3cKeBsey5LKekS4nSu5
         OlsA==
X-Gm-Message-State: AOJu0Yyber1G/in+Z/bxtuxGwCN0kuj21TDtw0KbYvNmTsqWAVN+xBS+
	zBp1dETtznnZVPsDycED+muJJjLQpEYpanEgvKWqsGVcd4UZwEj93BMb
X-Gm-Gg: AeBDiet4egc66KYznMMb6o+xOlRPzB4Goigp2gcYZCQqADyKvK96MgpkiRvm7/GiOYB
	vtu/ga2E6RFP0KNUFIMeiBDOQcNy4qXN20zZf/1VEE97dmFJ5/kANpsZ2k6ajJTWyKfMQuDjd2S
	oB7WayZrYpY200kiqi3tNev+TEQOh1VPvK6YZ5J4nDyzL068DMPvLZ7nahz6I6+L/o3T027bpNQ
	dV2hwxzgqhrALXzVRAwc+ZtmGCqUT7OMrDfbcl//mVFDVh1fgibSFeTbM2g/Nrapdh2wTDZIg7B
	79YngGsw15+znkUqH8TRAbuVuBxph9xtiquNESofiFUca5eI/RgHRIcgSqMGcILfMhdZjtnW8qs
	O3Ef4Pnl/QoZGjuo5+QHvzNCGnbnGhq8K5hrOinB8TH7BHfuoH0bww+SfswVcMQkRIDhjG003jb
	URM9O6xwB8zUNFOhEO/nX2txdOgVA=
X-Received: by 2002:a05:6a20:72a7:b0:39b:ba95:b128 with SMTP id adf61e73a8af0-3a7f1d24b16mr6605324637.50.1777823136722;
        Sun, 03 May 2026 08:45:36 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6ec67sm7207421a12.17.2026.05.03.08.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:45:35 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next v1 RESEND 6/6] seg6: add support for the H.M.GTP4.D behavior
Date: Mon,  4 May 2026 00:45:10 +0900
Message-ID: <20260503154510.912576-7-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503154510.912576-6-yuya.kusakabe@gmail.com>
References: <20260503154510.912576-1-yuya.kusakabe@gmail.com>
 <20260503154510.912576-2-yuya.kusakabe@gmail.com>
 <20260503154510.912576-3-yuya.kusakabe@gmail.com>
 <20260503154510.912576-4-yuya.kusakabe@gmail.com>
 <20260503154510.912576-5-yuya.kusakabe@gmail.com>
 <20260503154510.912576-6-yuya.kusakabe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6131D4B64DA
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283627-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,end.am:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.map:url,end.bm:url,end.as:url]

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


