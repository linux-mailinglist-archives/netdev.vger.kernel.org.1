Return-Path: <netdev+bounces-283955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJQwHU7K+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:33:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 312554C16ED
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3830D304E66C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC421C9EA;
	Mon,  4 May 2026 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcIQawil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5E3E3D8D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912232; cv=none; b=t3eNPGvNBCxozAgep/QUME56MN7NkGUwS4M6HuhPHhNwHmzUulDDI6mBr61C3+L4MATgd8Y4QDsEzaojzD13IVh5Q/JQaNG9wIjODdHRp8/4CUInytSVDypgJaplVRHKZalF7P1+Zt0bpl2cxzkXzOBQ2Y2pyBrZHcgBu5qW1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912232; c=relaxed/simple;
	bh=1LaG0ASJMw4t8jbb6Tu0Cg5jYLHprf7y+uH7ZGrEkE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxGvB7fIF+aJeW9Ml9cpgHBPYkHD5CPwSILwijTPjdTwhyA2QvrKQwrne14+fCfPd82A0JMT6tnRmq98tNWXOQ4ymtE6ALaxfE4TdqVxnXRkeYAPsSk+1guW9OyPAGgOYbM2jXzyxeBTsF2unJkCL6F2EcDs+1IsEIMePjZbdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcIQawil; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1126199b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777912226; x=1778517026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35WV+8MITyakcGtXSDr/pelPv35Kihy1np4EZFfzYw0=;
        b=lcIQawilBDeIvWWjSMFwjrtSB8nS6p6voEUvGY6rwJXQeNrAzcTWEY9ScaISzdHA6U
         UrLrTW3o7gW43qZclpm0efv2+lOSvJjFhl0E9yQjAYo+qTY3xDmc/psrIhrE6urY5gGz
         IHXgN/y8AiWAfFmAML18GD6/VCqnH/4i1IugLucmp13OgY2noHFi+GJV4bEsfQ5ND9kU
         IXIRayJ97yknbwDlyWWF4e7DQ/iVQPDkSaGaNLuoiIOLc/VtDbeKsulUUNZaeHPoHwhx
         AbgHq4jJ+EDLXtMfmdK8yFYppCaVmIhEUAEdEH2I/l+LxPAXLLsxhnqd4JcN2/Yuf0K8
         2aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912226; x=1778517026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=35WV+8MITyakcGtXSDr/pelPv35Kihy1np4EZFfzYw0=;
        b=DeYeRIfpbcgYGfDtPuP7bvANvXDCNos9dSYL3+5s7CtvBV1MzrP3g6mc1dtx+NH44d
         CodvV/6zLg3c3ULKMXZ3cIhuj2228BuWyLTq8qqsqB5vq9QRXQUeKFD7dxpQG3mJmR1J
         a2WRRiKJismg1l0qkrdCJBGC0qLipcQwcKOe7icXQnTS75KE5H/Rxrntaaf6P/ws1t5q
         EAg2KBz1JwpNj2HFFFg3YzMXKWtR1qzV6dUnCMUXZcoQqCemNXBoPysO+1kCH5HDMIRi
         d6UiYe50O+lnUN05YTBYoU8wGvsR97xidpdj6xagwxMN9CBhWcAFBXLAabXJny+qon1L
         pH8A==
X-Forwarded-Encrypted: i=1; AFNElJ9grgotsRNqv07XBMUeCaV8l1i2YsOqF8XnQ9XPxnEszGVxp9GvWERyM99RFr6tiqzSka3JxPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOF462VOlO0RZIJVtkU3zZibqLPFCPySzbB2j0cjmtGbs4yiy
	QWGf9k7B7kHj30V67Ek7yHAYfIhXGOZCUFVH8dVNQ2l6ErKSb+c2tgmD
X-Gm-Gg: AeBDiesoJyS6hGPFwtOsObj7XKGtgKMLhyr2OfanxndfogJytt6BYHbldxg5kKYw23R
	qFtksyU6PghZ7GuXxBLCwtPtPWxKQ0hqO8+nhUexwjf7mzjGughBR7g/e3zz9y8QD4lSGLvNrNz
	R2GeTbL7SQ312OP7poQMI66hXnhZCPi4lnVOqXFlc67Py9p0/a00Y9TKsQ0ooUboQdy2QmpNAy7
	yOn6IxOrqmZEe+k4ZtK0sPUlzvILgvJhQUMvCgGWmDkgqmcOeNGFUMz5Ck+xczORa55bnD8xBSS
	HXcC5sIokv4vyxbhXQDr78WKcc1QMVzJ4L+kPOfwkrmxM43dDnM3zPn5CVvS/0DnRR2mt23jyIU
	XUdsyuU/A6Ub66U/0jCxrVUHcPmZaU0l6LjjsGLzvxYumQzl2QiC6G3yRJ0q9mxfFBi+JXIGIAs
	5eysSQKaM9236Yg7g8AcNAY+vbq4DUKfXVOzcpSt0tIO5f
X-Received: by 2002:a05:6a00:3317:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-8352cdc8f1amr8967647b3a.0.1777912225973;
        Mon, 04 May 2026 09:30:25 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837081abadfsm4998663b3a.42.2026.05.04.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:30:25 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:30:13 +0900
Subject: [PATCH v2 3/7] seg6: add End.M.GTP6.E behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-3-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=28254;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=1LaG0ASJMw4t8jbb6Tu0Cg5jYLHprf7y+uH7ZGrEkE4=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MmVeUpIScX8mkxWnbsJj6aFZAFp96ex8ubLr
 MoArA6LOqyJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjJlQAKCRAq19F1Kl0b
 TQg5D/0bEFr5P8k4Xl9M0uBsJSaZg1b6FcoDtnmQD/BQQTCX3GhmKjNvcKrGT+R9pLpNUYSa0v0
 DlvWhF9hpAE9Z2nrQkO9fctGnlxPj0/FQKCTE9awAFVVI+Uty/H0TtaP6uNr8/RcYBLjm+JBJdl
 4yNOD5nbHLqD5s2+2oLUvg9VOBb7Hj5Mmejh8mWNqbZ1RkvDK1MehtoGRIV7VzVbnLhWgQQEcFq
 vZ9tjAfA5AmV8NbvBBtkAcRWxjFgaZzOgqKgqdfPKaDRzzHH6UOwh87QI6pFxtUp0AdXEGS9xJr
 modJTgpus942EYUsr663kKf2xxhQvAhUumeRpjL5/oo7eIDuF2Zk+XpFqxpUYqknMduvWN84AxG
 RARycwxraoUgDPMjk4DVChKSzuEhKBV7rZz2b6xx6R6TcLA+PXiWAE2RSYRdKexwNHxeKfE1oYu
 z45oDLaEmKv60mYxsWwAbtowR3vYD/uqCPE8fVSP/9MQLbTBYmwaOxLmf4osJ5+EKDNevlLQwfZ
 LR4hUutzdT7lPiN3qNdj1uJ8/ZWh8awYUxfHwlEJLcRKVx8A+rrHiFjAN6hB5QEJ+7LXh0/CZ3h
 eHjpNIh2cCfjmngIbQ6X4YUCT8vmDQaaAoFsE3QVEmO3ph1YSdSQI8LqozNphw82SXvlNHOVbua
 p37+9z8DJDs2z6A==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 312554C16ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,srv6_end_m_gtp6_e_test.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,end.map:url,rfc-editor.org:url]

Add the End.M.GTP6.E behavior (RFC 9433 Section 6.5), the IPv6 dual
of End.M.GTP4.E.  An End.M.GTP6.E SID always sits in the penultimate
position of an SR Policy (RFC 9433 Section 6.5 Notes); when it
becomes the active SID (segments_left == 1) the kernel pops the
IPv6/SRH outer, recovers TEID and QFI from the 40-bit
Args.Mob.Session field encoded in the locator-relative slice of the
SID, and re-encapsulates the inner T-PDU in IPv6/UDP/GTP-U toward
the next segment held in SRH[0].

The flow info, traffic class and hop limit are propagated from the
inbound IPv6 outer to the new outer (RFC 6040).

When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
NF_INET_PRE_ROUTING between the SRv6 strip and the GTP-U push,
mirroring End.DX4 / End.DX6.

Configuration:

  ip -6 route add 2001:db8:e::/64 \
      encap seg6local action End.M.GTP6.E src 2001:db8:2::1 \
      dev <dev>

Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.5
Link: https://www.rfc-editor.org/rfc/rfc6040
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h                    |   2 +
 net/ipv6/seg6_local.c                              | 312 ++++++++++++++++
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/net/srv6_end_m_gtp6_e_test.sh        | 402 +++++++++++++++++++++
 4 files changed, 717 insertions(+)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index b42cb526bb81..8e46ede2980d 100644
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
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 4051fe89e6d1..4e5d138c3657 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -22,6 +22,7 @@
 #include <linux/seg6.h>
 #include <linux/seg6_local.h>
 #include <net/addrconf.h>
+#include <net/ip6_checksum.h>
 #include <net/ip6_route.h>
 #include <net/dst_cache.h>
 #include <net/ip_tunnels.h>
@@ -1622,6 +1623,21 @@ static unsigned int seg6_mobile_skb_prefix_bits(const struct sk_buff *skb)
 	return plen;
 }
 
+/* Read Args.Mob.Session from @daddr right after a @prefix_bits-bit
+ * locator (RFC 9433 Section 6.5).  Returns false if it would overflow.
+ */
+static bool seg6_mobile_extract_args_mob(const struct in6_addr *daddr,
+					 unsigned int prefix_bits,
+					 u64 *args_out)
+{
+	if (prefix_bits + SEG6_MOBILE_ARGS_MOB_LEN > 128)
+		return false;
+
+	*args_out = seg6_mobile_addr_get_bits(daddr->s6_addr, prefix_bits,
+					      SEG6_MOBILE_ARGS_MOB_LEN);
+	return true;
+}
+
 /* GTP-U PDU Session extension header (3GPP TS 38.415).
  * 4-byte minimum unit: ext_len=1, PDU Type in high 4 bits of @pdu_type_spare,
  * QFI in low 6 bits of @spare_qfi, next_ext=0.
@@ -1997,6 +2013,265 @@ static int input_action_end_m_gtp4_e(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+/* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
+ * the inner T-PDU exposed by End.M.GTP6.E.  After the outer SRv6 is
+ * popped the inner IP is briefly visible to netfilter; the finish
+ * half then builds the new IPv6/UDP/GTP-U outer using these fields.
+ */
+struct seg6_mobile_gtp6_e_cb {
+	struct in6_addr	next_sid;
+	__be32		flowlabel;
+	u32		teid;
+	u8		qfi;
+	u8		tclass;
+	u8		hop_limit;
+	u8		pdu_type;
+	bool		pdu_type_set;
+};
+
+#define SEG6_MOBILE_GTP6_E_CB(skb)	\
+	((struct seg6_mobile_gtp6_e_cb *)((skb)->cb))
+
+static int input_action_end_m_gtp6_e_finish(struct net *net,
+					    struct sock *sk,
+					    struct sk_buff *skb)
+{
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
+	struct seg6_mobile_gtp6_e_cb cb = *SEG6_MOBILE_GTP6_E_CB(skb);
+	struct dst_entry *orig_dst = skb_dst(skb);
+	const struct seg6_mobile_info *minfo;
+	struct seg6_local_lwt *slwt;
+	struct ipv6hdr *new_ip6h;
+	struct udphdr *uh;
+
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	minfo = &slwt->mobile_info;
+
+	/* Reject GSO packets that would not fit the egress IPv6/UDP/GTP-U
+	 * path after our outer headers are added; the GSO segmenter cannot
+	 * adjust mss across SRv6 -> GTP-U conversion.  Skip the check
+	 * entirely when no MTU is known on the current dst.
+	 */
+	if (skb_is_gso(skb)) {
+		unsigned int ovhd = sizeof(*new_ip6h) + sizeof(*uh) +
+				    sizeof(struct gtp1_header_long) +
+				    sizeof(struct seg6_mobile_pdu_session_ext);
+		unsigned int mtu = dst_mtu(skb_dst(skb));
+
+		if (mtu && (mtu <= ovhd ||
+			    !skb_gso_validate_network_len(skb, mtu - ovhd))) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED;
+			goto drop;
+		}
+	}
+
+	/* Reserve worst-case headroom for the entire outer chain we are about
+	 * to push: IPv6 + UDP + GTP-U long header + PDU Session extension.
+	 * Subsequent skb_cow_head() calls inside seg6_mobile_push_gtpu() then
+	 * become no-ops.
+	 */
+	if (skb_cow_head(skb,
+			 sizeof(*new_ip6h) + sizeof(*uh) +
+			 sizeof(struct gtp1_header_long) +
+			 sizeof(struct seg6_mobile_pdu_session_ext)))
+		goto drop;
+
+	if (seg6_mobile_push_gtpu(skb, cb.teid, cb.qfi, cb.pdu_type,
+				  cb.pdu_type_set))
+		goto drop;
+
+	uh = skb_push(skb, sizeof(*uh));
+	skb_reset_transport_header(skb);
+	uh->source = htons(GTP1U_PORT);
+	uh->dest = htons(GTP1U_PORT);
+	uh->len = htons(skb->len);
+
+	new_ip6h = skb_push(skb, sizeof(*new_ip6h));
+	skb_reset_network_header(skb);
+	memset(new_ip6h, 0, sizeof(*new_ip6h));
+	ip6_flow_hdr(new_ip6h, cb.tclass, cb.flowlabel);
+	new_ip6h->payload_len = htons(skb->len - sizeof(*new_ip6h));
+	new_ip6h->nexthdr = IPPROTO_UDP;
+	new_ip6h->hop_limit = cb.hop_limit;
+	new_ip6h->saddr = minfo->src_addr;
+	new_ip6h->daddr = cb.next_sid;
+
+	/* RFC 8200 requires UDP/IPv6 checksums.  Initialise the
+	 * pseudo-header sum and let the stack/NIC complete it via
+	 * CHECKSUM_PARTIAL so we do not pay a per-packet linear sum and
+	 * we cooperate with offload.
+	 */
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	skb->csum_start = (unsigned char *)uh - skb->head;
+	skb->csum_offset = offsetof(struct udphdr, check);
+	uh->check = ~csum_ipv6_magic(&new_ip6h->saddr, &new_ip6h->daddr,
+				     skb->len - sizeof(*new_ip6h),
+				     IPPROTO_UDP, 0);
+
+	skb->protocol = htons(ETH_P_IPV6);
+	nf_reset_ct(skb);
+	skb_dst_drop(skb);
+
+	seg6_lookup_any_nexthop(skb, &cb.next_sid, 0, false, slwt->oif);
+	return dst_input(skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
+/* RFC 9433 Section 6.5 -- End.M.GTP6.E
+ * Receives an SRv6 packet whose current SID is an End.M.GTP6.E SID
+ * (Segments Left == 1) and re-encapsulates the inner payload in
+ * IPv6/UDP/GTP-U (with an optional PDU Session extension header
+ * carrying the QFI) toward the next segment held in SRH[0].
+ *
+ * When net.netfilter.nf_hooks_lwtunnel=1 and the inner is a valid
+ * IPv4 / IPv6 packet, NF_INET_PRE_ROUTING fires on the bare inner
+ * T-PDU between the SRv6 strip and the GTP-U push.
+ */
+static int input_action_end_m_gtp6_e(struct sk_buff *skb,
+				     struct seg6_local_lwt *slwt)
+{
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;
+	const struct seg6_mobile_info *minfo = &slwt->mobile_info;
+	struct seg6_mobile_gtp6_e_cb *cb;
+	struct in6_addr next_sid;
+	struct ipv6_sr_hdr *srh;
+	u8 hop_limit, tclass, qfi;
+	unsigned int outer_len;
+	struct ipv6hdr *ip6h;
+	int inner_nfproto;
+	__be32 flowlabel;
+	__be16 frag_off;
+	u64 args_mob;
+	u32 teid;
+	int off;
+	u8 nh;
+
+	BUILD_BUG_ON(sizeof(struct seg6_mobile_gtp6_e_cb) >
+		     sizeof_field(struct sk_buff, cb));
+
+	/* End.M.GTP6.E SRH-S02 (RFC 9433 Section 6.5) mandates the SRH be
+	 * present with segments_left == 1.  Use the legacy seg6 helper
+	 * that enforces "SRH present" + HMAC; seg6_mobile_get_validated_srh()
+	 * tolerates SRH-less packets via its @missing out-parameter, which
+	 * is the wrong semantic here.
+	 */
+	srh = get_and_validate_srh(skb);
+	if (!srh) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+		goto drop;
+	}
+
+	/* RFC 9433 Section 6.5 SRH-S02: Segments Left MUST be 1 */
+	if (srh->segments_left != 1) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
+		goto drop;
+	}
+
+	/* @ip6h is fresh: get_and_validate_srh() already pulled at least
+	 * sizeof(struct ipv6hdr) via pskb_may_pull(), so ipv6_hdr(skb) here
+	 * is valid even though pskb_may_pull() may have reallocated
+	 * skb->head inside that call.
+	 */
+	ip6h = ipv6_hdr(skb);
+
+	if (!seg6_mobile_extract_args_mob(&ip6h->daddr,
+					  seg6_mobile_skb_prefix_bits(skb),
+					  &args_mob))
+		goto drop;
+	teid = seg6_mobile_teid_from_args(args_mob);
+	qfi = seg6_mobile_qfi_from_args(args_mob);
+
+	/* SRH[0] is the next segment for the new GTP-U tunnel */
+	next_sid = srh->segments[0];
+
+	/* RFC 6040 outer-to-outer propagation: copy DSCP+ECN (tclass) and
+	 * the flow label from the SRv6 outer to the new IPv6 outer.  Use
+	 * ip6_flowlabel() (not ip6_flowinfo()) so the tclass byte is
+	 * supplied exactly once via the @tclass argument of ip6_flow_hdr().
+	 */
+	flowlabel = ip6_flowlabel(ip6h);
+	tclass = ipv6_get_dsfield(ip6h);
+	hop_limit = ip6h->hop_limit;
+
+	/* RFC 9433 Section 6.5 upper-layer S02 mandates "Pop the IPv6
+	 * header and all its extension headers".  ipv6_skip_exthdr()
+	 * walks every extension header (HBH/Routing/Dest-Opts/Fragment)
+	 * so HBH-before-SRH and DOpts-after-SRH are handled too.  The
+	 * terminal next-header value also selects NFPROTO_IPV4 /
+	 * NFPROTO_IPV6 for the NF_INET_PRE_ROUTING hook below.
+	 */
+	nh = ip6h->nexthdr;
+	off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh, &frag_off);
+	if (off < 0) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+	outer_len = off;
+
+	switch (nh) {
+	case IPPROTO_IPIP:
+		inner_nfproto = NFPROTO_IPV4;
+		break;
+	case IPPROTO_IPV6:
+		inner_nfproto = NFPROTO_IPV6;
+		break;
+	default:
+		inner_nfproto = -1;
+		break;
+	}
+
+	/* For inner IP traffic that may traverse NF_INET_PRE_ROUTING below,
+	 * pull the full inner IP header into the linear area so a netfilter
+	 * hook reading skb_transport_header() does not access stale data.
+	 * Non-IP inner is forwarded as-is via the GTP-U T-PDU payload.
+	 */
+	if (!pskb_may_pull(skb, outer_len + ((inner_nfproto == NFPROTO_IPV4) ?
+					     sizeof(struct iphdr) :
+					     (inner_nfproto == NFPROTO_IPV6) ?
+					     sizeof(struct ipv6hdr) : 0))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb_pull_rcsum(skb, outer_len);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	cb = SEG6_MOBILE_GTP6_E_CB(skb);
+	cb->next_sid = next_sid;
+	cb->flowlabel = flowlabel;
+	cb->teid = teid;
+	cb->qfi = qfi;
+	cb->tclass = tclass;
+	cb->hop_limit = hop_limit;
+	cb->pdu_type = minfo->pdu_type;
+	cb->pdu_type_set = minfo->pdu_type_set;
+
+	if (inner_nfproto >= 0 &&
+	    static_branch_unlikely(&nf_hooks_lwtunnel_enabled)) {
+		skb->protocol = (inner_nfproto == NFPROTO_IPV4) ?
+				htons(ETH_P_IP) : htons(ETH_P_IPV6);
+		skb_set_transport_header(skb,
+					 (inner_nfproto == NFPROTO_IPV4) ?
+					 sizeof(struct iphdr) :
+					 sizeof(struct ipv6hdr));
+		nf_reset_ct(skb);
+
+		return NF_HOOK(inner_nfproto, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_end_m_gtp6_e_finish);
+	}
+
+	return input_action_end_m_gtp6_e_finish(dev_net(skb->dev), NULL, skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
 /* RFC 9433 Section 6.2 -- End.MAP
  * Replace the outer IPv6 destination address with the configured next
  * SID, decrement the Hop Limit, and forward via IPv6 routing.  The
@@ -2042,6 +2317,9 @@ static int input_action_end_map(struct sk_buff *skb,
 static int seg6_mobile_v4_validate(struct seg6_local_lwt *slwt,
 				   const void *cfg,
 				   struct netlink_ext_ack *extack);
+static int seg6_mobile_gtp6_e_validate(struct seg6_local_lwt *slwt,
+				       const void *cfg,
+				       struct netlink_ext_ack *extack);
 
 static struct seg6_action_desc seg6_action_table[] = {
 	{
@@ -2153,6 +2431,17 @@ static struct seg6_action_desc seg6_action_table[] = {
 			.build_state = seg6_mobile_v4_validate,
 		},
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_END_M_GTP6_E,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_PDU_TYPE) |
+				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
+		.input		= input_action_end_m_gtp6_e,
+		.slwt_ops	= {
+			.build_state = seg6_mobile_gtp6_e_validate,
+		},
+	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_MAP,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
@@ -2645,6 +2934,29 @@ static int seg6_mobile_v4_validate(struct seg6_local_lwt *slwt,
 	return 0;
 }
 
+/* End.M.GTP6.E SID layout (RFC 9433 Section 6.5):
+ *
+ *   | locator (route prefix)  | Args.Mob.Session (40) | pad |
+ *
+ * The locator length is the route's IPv6 destination prefix length.
+ * Reject route additions whose prefix leaves no room for the 40-bit
+ * Args.Mob.Session field at setup time so the operator gets a clear
+ * error from `ip route add` instead of silent per-packet drops.
+ */
+static int seg6_mobile_gtp6_e_validate(struct seg6_local_lwt *slwt,
+				       const void *cfg,
+				       struct netlink_ext_ack *extack)
+{
+	const struct fib6_config *fib6_cfg = cfg;
+
+	if ((unsigned int)fib6_cfg->fc_dst_len + SEG6_MOBILE_ARGS_MOB_LEN > 128) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "End.M.GTP6.E route prefix length must leave room for the 40-bit Args.Mob.Session (prefix_len <= 88)");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 #define MAX_PROG_NAME 256
 static const struct nla_policy bpf_prog_policy[SEG6_LOCAL_BPF_PROG_MAX + 1] = {
 	[SEG6_LOCAL_BPF_PROG]	   = { .type = NLA_U32, },
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index db1b3ef48f19..01dafec5b60f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -91,6 +91,7 @@ TEST_PROGS := \
 	srv6_end_dx6_netfilter_test.sh \
 	srv6_end_flavors_test.sh \
 	srv6_end_m_gtp4_e_test.sh \
+	srv6_end_m_gtp6_e_test.sh \
 	srv6_end_map_test.sh \
 	srv6_end_next_csid_l3vpn_test.sh \
 	srv6_end_x_next_csid_l3vpn_test.sh \
diff --git a/tools/testing/selftests/net/srv6_end_m_gtp6_e_test.sh b/tools/testing/selftests/net/srv6_end_m_gtp6_e_test.sh
new file mode 100755
index 000000000000..a0f7fb37db37
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_end_m_gtp6_e_test.sh
@@ -0,0 +1,402 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154
+#
+# Selftest for the SRv6 End.M.GTP6.E behavior (RFC 9433 Section 6.5).
+#
+#   +-------+   2001:db8:1::/64   +-------+   2001:db8:2::/64   +-------+
+#   | srupf | ------------------- | srgw  | ------------------- |  gnb  |
+#   +-------+        veth-n9      +-------+        veth-n3      +-------+
+#
+# srupf is the SR-domain-side SRv6-aware UPF (RFC 9433 sense, not a
+# 3GPP UPF) that injects the SRv6 packets, gnb is the GTP-U-side
+# test peer, and srgw runs the End.M.GTP6.E behavior under test.
+#
+# An End.M.GTP6.E SID is installed on srgw for locator
+# 2001:db8:f::/64 with src=2001:db8:2::1.  Args.Mob.Session is the
+# fixed 40-bit field defined by RFC 9433 Section 6.1, Figure 8, immediately
+# after the locator (here at byte offset 8).  The bytes after
+# Args.Mob.Session are SID padding and are ignored by the egress.
+# The srupf uses scapy to inject an SRv6 packet with:
+#
+#   outer DA               = 2001:db8:f::1400:1:2300:0
+#                            (locator 2001:db8:f::/64 followed by
+#                             Args.Mob.Session bytes 14 00 00 01 23 at
+#                             offset 8, which encode QFI=5 and
+#                             PDU Session ID=0x123, plus 24 bits of
+#                             SID padding)
+#   SRH segments[0]        = 2001:db8:2::2  (gNB, next destination)
+#   SRH segments[1]        = 2001:db8:f::1400:1:2300:0 (current SID)
+#   SRH segments_left      = 1
+#
+# The expected output on veth-n3-gnb is an IPv6/UDP/GTP-U(long)/PDU-Session-ext
+# packet toward 2001:db8:2::2 carrying TEID 0x00000123 and QFI 5.
+
+source lib.sh
+
+readonly TIMEOUT=4
+
+tcpdump_pid=""
+have_vrf=0
+
+cleanup()
+{
+	if [ -n "$tcpdump_pid" ]; then
+		kill "$tcpdump_pid" 2>/dev/null
+		wait "$tcpdump_pid" 2>/dev/null
+	fi
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup()
+{
+	setup_ns srupf srgw gnb gnb_vrf
+
+	ip -n "$srupf" link set lo up
+	ip -n "$srgw" link set lo up
+	ip -n "$gnb" link set lo up
+	ip -n "$gnb_vrf" link set lo up
+
+	ip link add veth-n9 netns "$srupf" type veth peer name veth-n9-srgw \
+		netns "$srgw"
+	ip -n "$srupf" addr add 2001:db8:1::1/64 dev veth-n9 nodad
+	ip -n "$srgw" addr add 2001:db8:1::2/64 dev veth-n9-srgw nodad
+	ip -n "$srupf" link set veth-n9 up
+	ip -n "$srgw" link set veth-n9-srgw up
+
+	ip link add veth-n3 netns "$srgw" type veth peer name veth-n3-gnb \
+		netns "$gnb"
+	ip -n "$srgw" addr add 2001:db8:2::1/64 dev veth-n3 nodad
+	ip -n "$gnb" addr add 2001:db8:2::2/64 dev veth-n3-gnb nodad
+	ip -n "$srgw" link set veth-n3 up
+	ip -n "$gnb" link set veth-n3-gnb up
+
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.all.forwarding=1
+
+	# install End.M.GTP6.E on srgw with PDU Session Container (5G N3:
+	# pdu_type dl), /64 locator.
+	ip -n "$srgw" -6 route add 2001:db8:f::/64 \
+		encap seg6local action End.M.GTP6.E \
+			src 2001:db8:2::1 pdu_type dl \
+		dev veth-n3
+
+	# install End.M.GTP6.E on srgw WITHOUT pdu_type: short GTPv1-U
+	# (LTE-style, no PDU Session Container) regardless of QFI.
+	ip -n "$srgw" -6 route add 2001:db8:fa::/64 \
+		encap seg6local action End.M.GTP6.E \
+			src 2001:db8:2::1 \
+		dev veth-n3
+
+	# Per-route VRF case: a second egress IPv6 path in its own VRF so we
+	# can verify that the End.M.GTP6.E SID's egress GTP-U lookup uses
+	# the configured 'oif' rather than the main routing table.
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	modprobe vrf 2>/dev/null
+	if ip -n "$srgw" link add vrf-n3 type vrf table 100 2>/dev/null; then
+		have_vrf=1
+		ip -n "$srgw" link set dev vrf-n3 up
+
+		ip link add veth-n3-2 netns "$srgw" type veth peer name \
+			veth-n3-2-gnb netns "$gnb_vrf"
+		ip -n "$srgw" link set dev veth-n3-2 master vrf-n3
+		ip -n "$srgw" addr add 2001:db8:3::1/64 dev veth-n3-2 nodad
+		ip -n "$gnb_vrf" addr add 2001:db8:3::2/64 dev veth-n3-2-gnb nodad
+		ip -n "$srgw" link set dev veth-n3-2 up
+		ip -n "$gnb_vrf" link set dev veth-n3-2-gnb up
+
+		ip -n "$srgw" -6 route add 2001:db8:e::/64 \
+			encap seg6local action End.M.GTP6.E \
+				src 2001:db8:3::1 oif vrf-n3 pdu_type dl \
+			dev veth-n3-2
+	fi
+}
+
+check_dependencies()
+{
+	if ! command -v tcpdump >/dev/null; then
+		echo "SKIP: tcpdump is required"; exit "$ksft_skip"
+	fi
+	if ! command -v python3 >/dev/null; then
+		echo "SKIP: python3 is required"; exit "$ksft_skip"
+	fi
+	if ! python3 -c "from scapy.layers.inet6 import IPv6ExtHdrSegmentRouting" 2>/dev/null; then
+		echo "SKIP: python3-scapy with SRv6 support is required"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "End.M.GTP6.E"; then
+		echo "SKIP: iproute2 too old, missing seg6local action End.M.GTP6.E"
+		exit "$ksft_skip"
+	fi
+}
+
+inject_srv6()
+{
+	local sid="$1"		# outer IPv6 DA (current End.M.GTP6.E SID)
+	local next_seg="$2"	# SRH segments[0] (next destination = gNB)
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n9-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" SID="$sid" NEXT_SEG="$next_seg" \
+		ip netns exec "$srupf" python3 - <<'PY'
+import os
+from scapy.all import IPv6, ICMPv6EchoRequest, sendp, Ether
+from scapy.layers.inet6 import IPv6ExtHdrSegmentRouting
+
+mac = os.environ['SRGW_MAC']
+sid = os.environ['SID']
+next_seg = os.environ['NEXT_SEG']
+inner = IPv6(src='2001:db8:1::1', dst='2001:db8:dead::1') / \
+        ICMPv6EchoRequest(data=b'X' * 16)
+srh = IPv6ExtHdrSegmentRouting(
+    addresses=[next_seg, sid],
+    segleft=1, lastentry=1, nh=41)
+pkt = Ether(dst=mac) / \
+      IPv6(src='2001:db8:1::1', dst=sid, nh=43) / \
+      srh / inner
+sendp(pkt, iface='veth-n9', verbose=False)
+PY
+}
+
+capture_traffic()
+{
+	local capture_ns="$1"
+	local capture_iface="$2"
+	local sid="$3"
+	local next_seg="$4"
+	local out="$5"
+
+	ip netns exec "$capture_ns" tcpdump -U -nni "$capture_iface" -w "$out" \
+		'ip6 and udp port 2152' 2>/dev/null &
+	tcpdump_pid=$!
+	# Give tcpdump a brief moment to attach the BPF filter.
+	sleep 1
+
+	inject_srv6 "$sid" "$next_seg"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+}
+
+run_test()
+{
+	local sid="$1"			# End.M.GTP6.E SID to send to
+	local next_seg="$2"		# expected outer IPv6 DA in egress GTP-U
+	local capture_ns="${3:-$gnb}"	# netns where GTP-U is expected to land
+	local capture_iface="${4:-veth-n3-gnb}"
+	local out
+
+	out=$(mktemp)
+	capture_traffic "$capture_ns" "$capture_iface" "$sid" "$next_seg" "$out"
+
+	# Verify with scapy field comparison: the captured frame must be
+	# IPv6/UDP(2152)/GTP-U toward $next_seg, carry TEID 0x00000123 and a
+	# PDU Session ext with QFI=5.
+	NEXT_SEG="$next_seg" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, UDP
+
+next_seg = os.environ['NEXT_SEG']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if not (IPv6 in p and UDP in p):
+        continue
+    if str(p[IPv6].dst) != next_seg:
+        continue
+    if p[UDP].dport != 2152:
+        continue
+    payload = bytes(p[UDP].payload)
+    if len(payload) < 12:
+        continue
+    teid = int.from_bytes(payload[4:8], 'big')
+    if teid != 0x00000123:
+        sys.exit(f"unexpected TEID 0x{teid:08x}, want 0x00000123")
+    if payload[11] != 0x85:
+        sys.exit(f"missing PDU Session ext (next={payload[11]:#04x}, want 0x85)")
+    pdu_session = payload[12:16]
+    if pdu_session[0] != 0x01 or (pdu_session[2] & 0x3f) != 5:
+        sys.exit(f"PDU Session fields unexpected: {pdu_session.hex()} (want 01 ?? 05 00)")
+    sys.exit(0)
+sys.exit(f"no IPv6/UDP/GTP-U packet observed toward {next_seg}")
+PYEOF
+	local rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify the short-GTPv1-U output produced when pdu_type is unset on the
+# route: 8-byte GTP-U header, no extension flag, no PDU Session
+# Container, regardless of the QFI extracted from Args.Mob.Session.
+run_test_short()
+{
+	local sid="$1"
+	local next_seg="$2"
+	local out
+	local rc
+
+	out=$(mktemp)
+	capture_traffic "$gnb" "veth-n3-gnb" "$sid" "$next_seg" "$out"
+
+	NEXT_SEG="$next_seg" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, UDP
+
+next_seg = os.environ['NEXT_SEG']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if not (IPv6 in p and UDP in p):
+        continue
+    if str(p[IPv6].dst) != next_seg:
+        continue
+    if p[UDP].dport != 2152:
+        continue
+    payload = bytes(p[UDP].payload)
+    if len(payload) < 8:
+        continue
+    flags = payload[0]
+    if flags != 0x30:
+        sys.exit(f"unexpected GTP-U flags {flags:#04x}, want 0x30 (short)")
+    teid = int.from_bytes(payload[4:8], 'big')
+    if teid != 0x00000123:
+        sys.exit(f"unexpected TEID 0x{teid:08x}, want 0x00000123")
+    sys.exit(0)
+sys.exit(f"no IPv6/UDP/GTP-U packet observed toward {next_seg}")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify that nf_hooks_lwtunnel=1 makes the inner T-PDU 5-tuple
+# visible to nftables on the SR Gateway.  The inner is IPv6
+# (2001:db8:1::1 -> 2001:db8:dead::1, set by inject_srv6()); the nft
+# rule matches on its IPv6 source address.  DROP must suppress the
+# GTP-U at the gnb, ACCEPT must let it through.
+run_nf_test()
+{
+	local verdict="$1"		# drop | accept
+	local expect="$2"		# 1 if GTP-U expected, empty otherwise
+	local sid="2001:db8:f::1400:1:2300:0"
+	local next_seg="2001:db8:2::2"
+	local out
+
+	ip netns exec "$srgw" nft flush chain ip6 filter prerouting
+	ip netns exec "$srgw" nft add rule ip6 filter prerouting \
+		ip6 saddr 2001:db8:1::1 "$verdict"
+
+	out=$(mktemp)
+	capture_traffic "$gnb" "veth-n3-gnb" "$sid" "$next_seg" "$out"
+
+	if [ -n "$expect" ]; then
+		NEXT_SEG="$next_seg" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IPv6, UDP
+
+next_seg = os.environ['NEXT_SEG']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 in p and UDP in p and \
+       str(p[IPv6].dst) == next_seg and p[UDP].dport == 2152:
+        sys.exit(0)
+sys.exit("expected GTP-U packet not observed at gnb despite nft accept")
+PYEOF
+	else
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IPv6, UDP
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 in p and UDP in p and p[UDP].dport == 2152:
+        sys.exit("GTP-U packet leaked to gnb despite nft drop on inner")
+sys.exit(0)
+PYEOF
+	fi
+	local rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+main()
+{
+	local rc=0
+
+	check_dependencies
+	setup
+
+	if run_test "2001:db8:f::1400:1:2300:0" "2001:db8:2::2"; then
+		echo "TEST: End.M.GTP6.E (default) [PASS]"
+	else
+		echo "TEST: End.M.GTP6.E (default) [FAIL]"
+		rc=1
+	fi
+
+	# pdu_type unset: emit short GTPv1-U with no PDU Session Container
+	# even though Args.Mob.Session encodes QFI=5.
+	if run_test_short "2001:db8:fa::1400:1:2300:0" "2001:db8:2::2"; then
+		echo "TEST: End.M.GTP6.E (pdu_type unset, short header) [PASS]"
+	else
+		echo "TEST: End.M.GTP6.E (pdu_type unset, short header) [FAIL]"
+		rc=1
+	fi
+
+	# VRF binding: egress IPv6 GTP-U goes through vrf-n3 (table 100),
+	# where the route to 2001:db8:3::/64 lives.  Without "oif vrf-n3"
+	# the main-table lookup would fall through; the GTP-U observed in
+	# gnb_vrf demonstrates the binding.
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	if [ "$have_vrf" = "1" ]; then
+		if run_test "2001:db8:e::1400:1:2300:0" "2001:db8:3::2" \
+			    "$gnb_vrf" "veth-n3-2-gnb"; then
+			echo "TEST: End.M.GTP6.E (oif vrf-n3) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.E (oif vrf-n3) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP6.E (oif vrf-n3) [SKIP] (CONFIG_NET_VRF not loaded)"
+	fi
+
+	# Inner T-PDU netfilter hook: only meaningful when nft is present
+	# and the kernel exposes net.netfilter.nf_hooks_lwtunnel.
+	if command -v nft >/dev/null && \
+	   ip netns exec "$srgw" sysctl -wq \
+		net.netfilter.nf_hooks_lwtunnel=1 2>/dev/null; then
+		ip netns exec "$srgw" nft add table ip6 filter
+		ip netns exec "$srgw" nft 'add chain ip6 filter prerouting' \
+			'{ type filter hook prerouting priority 0; }'
+
+		if run_nf_test drop ""; then
+			echo "TEST: End.M.GTP6.E (nft drop on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.E (nft drop on inner) [FAIL]"
+			rc=1
+		fi
+
+		if run_nf_test accept "1"; then
+			echo "TEST: End.M.GTP6.E (nft accept on inner) [PASS]"
+		else
+			echo "TEST: End.M.GTP6.E (nft accept on inner) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: End.M.GTP6.E (inner-flow netfilter hook) [SKIP]" \
+		     "(nft or nf_hooks_lwtunnel unavailable)"
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		echo "TEST: End.M.GTP6.E [PASS]"
+		exit "$ksft_pass"
+	else
+		echo "TEST: End.M.GTP6.E [FAIL]"
+		exit "$ksft_fail"
+	fi
+}
+
+main "$@"

-- 
2.50.1


