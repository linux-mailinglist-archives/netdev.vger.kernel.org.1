Return-Path: <netdev+bounces-283958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G24NLbK+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:35:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD864C1790
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C28B530656A1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A863E5EE0;
	Mon,  4 May 2026 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSJfJITT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59B3E3DAB
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912239; cv=none; b=IaYXmfqbJy4WHh4GuowIMbuXmElV4OcaZLOomJ+UfONn46VT2+kSzDuRXAAaEXI6c1WCI+pv/nMz0mfmlwp8VpNQjuCFIghC605cXWr5MMq1GdB2htjK3pojCbK1ZBP1AAobABS/zDoNDrN9g8J/60vCi5W0ycQk6f9BltKwFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912239; c=relaxed/simple;
	bh=Rts57TKOLHYmZie/hEuNwj4kmKStmvQ6EvXrr9deFZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5kc8+xUx/0FZ0K6MCNjKp7TjdvUtfI148Axr9VuuCRW0aQ8vPYNcJGwbWOR+WwH/p4vYNJmCsQ4XMX9KxlURK3xaZtK/Xpb2I/VEOWFbOsuhjyu3ZekSQoNshj5XZkIqEi45G6sp5skgezESmVP2nVz1IX4KEdTFZa22UfYkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSJfJITT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-837c09d2268so485910b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777912235; x=1778517035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA8tkG9m2j6XHtSwAjY7knzGrXKI3a/3oSQ20T+VKco=;
        b=lSJfJITTgwzFSA0M6da2jczXAiCGXgKK3VPI8iCJPavWKqR/isItbV0YgdaIc2occq
         5UBpdo+1LkfqoALIVD/3jlg2L7pwG/ROAEp8ssInb9fQpgv+l90xnj7Pw37W7nNTmmNT
         pMSLQTWHSr2aiUeAGWxI/TWPSp1Nhy6ZHaXRltpSs2wtd1vpaBEm9srBFOz2YVPzGgUf
         37DvT2asNhDsbuPEpbtRaNp2Y5/EfsQuStV+LQMDxWSxl/fbkNPq8J6oY+zBhh1U2gTP
         A9+tN0uW2W+nA/rPqT53wM6ekojDwI+fNqboY932CTN78D9u9dIJjTEQwZ2AmK1lZViq
         fhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912235; x=1778517035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oA8tkG9m2j6XHtSwAjY7knzGrXKI3a/3oSQ20T+VKco=;
        b=P0LlVVAKMqXe1+nY0X8WmJIWVph7VTz4YkyQw1+sDgS+FDYpXVHeJgh7b7YAIa7U/9
         PssLlyYP7UzXO5XtxBEBz8uFGpAU//fVdSxRLDDaWHoa9LKcBKnsHzu82lACuCaWx+6v
         cB9BGBtdioFpGxdMe+b/MGEZ5EkXnKooLB6iO+qBM5cEVQp8noTQffuIghur77s9BRvN
         tpkZRfk5EL7/hLrLL1R1+9BEBUwH1LZTYgRNj/TvoSHnj2ei1G/IWcQb7qKRDhwapjdp
         kxj7O+C3VA0mtIxtEgVsadBE2IfnzRiFKz1UowNnjvdrIFr1W/ZZrZlnHpHZX+HrJDVh
         5v8A==
X-Forwarded-Encrypted: i=1; AFNElJ/P/ULLng/taw4vG3IphIVQ/0TzVOao9Mz/w5x6m7h3CQVS4WZ2/Lp7yD3ku7UQEyy2+XiIF1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK20vybbslzfKGeFzu9s1oANnZlMh0J/JLPva9iBT764xHQG2g
	+Xk69bOmOE2K0FMe2gp1IrquhxfFAEwq2jFQjyVz/dxiEg5mgLzoiJMl
X-Gm-Gg: AeBDievdKubRQxQXyxCO9EM9PlI6ffOkkXOlSDvu+d1lbnlx8PHI7LMmU+O3mxCFqmE
	OZIjuBoy+gvdcmLrvzkKhx1OyByBFFjO7npoRB1A2TfxkekAWIab9JgfHkts65A2oOL65XhfoJA
	HYRYLDAmBi5ELe5rJY9NmKNwqURSqGZbNr7fLEt4pO7UhYLd0nmLHWkjroXQyAiGFxPkI3XSFlU
	dLJyGdPqi8j1oElduM/wi4v1uEIH7WIBtZTUeeqK4GqIxxpjsTP2Trj+MFjXmI0nCMGX9W+yD0V
	Hv/d/bHI8ChxciZjQVz36/qQFhwwVOM7W4+Y6cbLJsOcF9L2w5GMrfCqOHhsmBCKG3kmCiE6Nh7
	FueBNRm3FPtHPuzcXADu6wbEFTScnPtb3vf2L6NXXQIurc+iqPwh1/N2YK4SzWzLsEN399kUtPd
	whi9NoEt9PN7hC2MAPKpyb2q1b+zL4xEoZwz25exT4BC+d
X-Received: by 2002:a05:6a00:8506:b0:835:6388:655d with SMTP id d2e1a72fcca58-83563886e73mr3752254b3a.14.1777912234440;
        Mon, 04 May 2026 09:30:34 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837081abadfsm4998663b3a.42.2026.05.04.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:30:33 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:30:16 +0900
Subject: [PATCH v2 6/7] seg6: add H.M.GTP4.D behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-6-9e8022bdfdb6@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=35726;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=Rts57TKOLHYmZie/hEuNwj4kmKStmvQ6EvXrr9deFZA=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MmWE3zn6CKrJVXDj9OtNdzEVt/vDM2oGVlZE
 R/wuBDcHOSJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjJlgAKCRAq19F1Kl0b
 TS0FD/wPzsX1v+L9OTUHG8U3t6wWa8BURKQo6ycWPJE+/Qm63fwj5GR71483oZ8CXY460VjNTAe
 x4nmwQciruQ1+qGdsaPyK6cbmu+s/e7YSQ6hBWfCRagGNZ3hJO7VDEan+3lv07Z418IEkrUXlfK
 RBipos82GbCb/cGWDkvlWscwb9CM+Fm2cwzvwoq8+6ghubo6HM+PYj1ki4eT5sDClsccRxu2Zyx
 jKxxsNQc9p2gltalBxqPTAymmgnTnrD5adDbdGetJPUbOaTqg2PriCNSg+BdwWM2nNeJQ2m4cCg
 IfG0kva1ssTMLQe/cqrXhjgOzu1d0Dbd51JtEFNm6K+t1D646iguI8lylyJZsZmpfxMoLFlO6vt
 IwbybrfsGg/DDNR7ODUuSIHII8pFR5vTRfJHd5CmfqnNlM3Rpx7DSWHNHwHqHlWlBr8i//LJnEj
 XeN0BS7DDM0gWoDqVhbaX/7bakp0aQXhG8SR1bH3WFXVvTb5XTQDFebvWWQw+2pJ5Ez6RAn11CG
 yx+PIA2MEBXBm7p9SQMuCAASi1YxJ4hGLQSRRsCBFT5Bm/VCqynMTQcr3h58TncAK8QfDYjSyoY
 43QIOGGEwiJDxEGG5F34CWOwti94rhO+kuvYD9FsvuJv/fhOVdn3kM0wbUaUVSXwAhcmyxfGEYN
 /kD9f7SQR913MoA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: 6BD864C1790
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
	TAGGED_FROM(0.00)[bounces-283958-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dst.dev:url,srv6_h_m_gtp4_d_test.sh:url,lib.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rfc-editor.org:url]

Add the H.M.GTP4.D headend behavior (RFC 9433 Section 6.7), which
receives an IPv4/UDP/GTP-U packet on a configured IPv4 route and
re-encapsulates it in IPv6 + (optional) SRH toward an SR Gateway
running End.M.GTP4.E.  The constructed End.M.GTP4.E SID encodes
the legacy IPv4 destination and the per-session arguments derived
from the GTP-U header so the egress can decapsulate it (RFC 9433
Section 6.6 Figure 9).

This is the only behavior in seg6_local that runs on AF_INET routes;
the rest has been IPv6-only.  To support that, the seg6_action_desc
framework gains an explicit input_family field, the build_state
path now accepts AF_INET in addition to AF_INET6, and
seg6_local_input() switches to a NF_HOOK that uses the right
nfproto for the inbound packet.

PMTU is honored on the encap side: when the post-encap length
exceeds the egress MTU and the IPv4 outer carries DF, the kernel
sends an ICMP Fragmentation Needed back to the originator before
dropping; GSO packets that would not fit get dropped without a
notification because the GSO segmenter cannot fix this up after
the network protocol has changed from IPv4 to IPv6.

When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
NF_INET_PRE_ROUTING between the GTP-U strip and the SRv6 push,
mirroring End.DX4 / End.DX6.

Non-T-PDU GTP-U messages are forwarded the same way as in
End.M.GTP6.D: passed through via the lwtunnel's saved orig_input
to a downstream peer that owns the GTP-U control plane.

Configuration:

  ip -4 route add 10.99.0.0/24 \
      encap seg6local action H.M.GTP4.D \
          nh6 2001:db8:: \
          src 2001:db8:2::1 \
          v4_mask_len 32 sr_prefix_len 32 \
      dev <dev>

Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.7
Link: https://www.rfc-editor.org/rfc/rfc6040
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h                    |   2 +
 net/ipv6/seg6_local.c                              | 422 +++++++++++++++++-
 tools/testing/selftests/net/Makefile               |   1 +
 .../testing/selftests/net/srv6_h_m_gtp4_d_test.sh  | 487 +++++++++++++++++++++
 4 files changed, 909 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 326da65ad5aa..e6bb57129fdc 100644
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
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index a6cd57ebcbde..fe7799aeaa53 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -38,6 +38,7 @@
 #include <linux/unaligned.h>
 #include <net/gso.h>
 #include <net/gtp.h>
+#include <net/icmp.h>
 
 #define SEG6_F_ATTR(i)		BIT(i)
 
@@ -52,6 +53,11 @@ struct seg6_local_lwtunnel_ops {
 
 struct seg6_action_desc {
 	int action;
+	/* Address family of the FIB hook the route is installed on.
+	 * Defaults to AF_INET6 when 0; entries that run on IPv4 routes
+	 * (currently only H.M.GTP4.D) set this to AF_INET explicitly.
+	 */
+	int input_family;
 	unsigned long attrs;
 
 	/* The optattrs field is used for specifying all the optional
@@ -2788,6 +2794,342 @@ static int input_action_end_m_gtp6_d_di(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+/* Overlay @v4 into @addr right after a @v6_src_prefix_len-bit prefix
+ * (default /64), per RFC 9433 Section 6.6 Figure 10.
+ */
+static void seg6_mobile_overlay_v4(struct in6_addr *addr, u8 v4_mask_len,
+				   u8 v6_src_prefix_len, __be32 v4)
+{
+	u8 p_bits = v6_src_prefix_len ? : SEG6_MOBILE_V6_SRC_PREFIX_LEN_DEFAULT;
+	u8 sa_bits = min_t(u8, v4_mask_len, 32);
+	u64 v4_left;
+
+	if (!sa_bits || (unsigned int)p_bits + sa_bits > 128)
+		return;
+
+	v4_left = (u64)ntohl(v4) << 32;
+	seg6_mobile_addr_set_bits(addr->s6_addr, p_bits, sa_bits, v4_left);
+}
+
+/* Encode the IPv4 DA and Args.Mob.Session into @sid right after a
+ * @prefix_bits-bit locator, per RFC 9433 Section 6.7 Figure 11.
+ */
+static int seg6_mobile_fill_egress_sid(struct in6_addr *sid,
+				       unsigned int prefix_bits,
+				       u8 v4_mask_len, __be32 v4, u64 args)
+{
+	u8 sa_bits = min_t(u8, v4_mask_len, 32);
+	u64 v4_left;
+
+	if (prefix_bits + sa_bits + SEG6_MOBILE_ARGS_MOB_LEN > 128)
+		return -EINVAL;
+
+	if (sa_bits) {
+		v4_left = (u64)ntohl(v4) << 32;
+		seg6_mobile_addr_set_bits(sid->s6_addr, prefix_bits, sa_bits,
+					  v4_left);
+	}
+
+	seg6_mobile_addr_set_bits(sid->s6_addr, prefix_bits + sa_bits,
+				  SEG6_MOBILE_ARGS_MOB_LEN, args);
+	return 0;
+}
+
+/* Per-skb context preserved across the NF_INET_PRE_ROUTING hook on
+ * the inner T-PDU exposed by H.M.GTP4.D.  The inbound IPv4 outer is
+ * gone by the time the finish half runs, but the new SRv6 outer
+ * still needs the constructed End.M.GTP4.E SID and the source IPv6
+ * address (both derived from the IPv4 outer, the SID, and TEID/QFI).
+ */
+struct seg6_mobile_h_gtp4_d_cb {
+	struct in6_addr	new_da;
+	struct in6_addr	new_sa;
+	u8		outer_tclass;
+};
+
+#define SEG6_MOBILE_H_GTP4_D_CB(skb)	\
+	((struct seg6_mobile_h_gtp4_d_cb *)((skb)->cb))
+
+static int input_action_h_m_gtp4_d_finish(struct net *net,
+					  struct sock *sk,
+					  struct sk_buff *skb)
+{
+	struct seg6_mobile_h_gtp4_d_cb cb = *SEG6_MOBILE_H_GTP4_D_CB(skb);
+	struct dst_entry *orig_dst = skb_dst(skb);
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
+	struct seg6_local_lwt *slwt;
+	struct ipv6_sr_hdr *new_srh;
+	struct ipv6hdr *new_ip6h;
+	int inner_proto;
+	int err;
+
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+
+	inner_proto = (skb->protocol == htons(ETH_P_IP)) ? IPPROTO_IPIP
+							 : IPPROTO_IPV6;
+
+	if (slwt->srh) {
+		struct ipv6hdr *outer_ip6h;
+
+		/* Multi-segment SR Policy: prepend ipv6 + SRH and
+		 * overwrite the last segment with the constructed
+		 * End.M.GTP4.E SID.
+		 */
+		err = seg6_do_srh_encap(skb, slwt->srh, inner_proto);
+		if (err) {
+			if (err != -ENOMEM)
+				reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+			goto drop;
+		}
+
+		skb->protocol = htons(ETH_P_IPV6);
+
+		new_srh = (struct ipv6_sr_hdr *)(skb_network_header(skb) +
+						 sizeof(struct ipv6hdr));
+		new_srh->segments[0] = cb.new_da;
+
+		/* seg6_do_srh_encap() zeroes the outer Traffic Class for
+		 * IPv4 inners.  Overwrite it with the RFC 6040 normal-mode
+		 * value computed at the input half so the SR domain sees
+		 * the inner DSCP/ECN.
+		 */
+		outer_ip6h = ipv6_hdr(skb);
+		ipv6_change_dsfield(outer_ip6h, 0, cb.outer_tclass);
+
+		/* seg6_do_srh_encap() sets the outer daddr from
+		 * segments[first_segment].  When first_segment == 0 the
+		 * write above replaced that slot's content, so the outer
+		 * daddr would still point at the user-provided segment
+		 * value rather than the constructed End.M.GTP4.E SID.
+		 * Re-read from segments[first_segment] after the write
+		 * for correctness in that case (no-op when
+		 * first_segment > 0).
+		 */
+		ipv6_hdr(skb)->daddr =
+			new_srh->segments[new_srh->first_segment];
+		ipv6_hdr(skb)->saddr = cb.new_sa;
+
+		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+	} else {
+		/* Single-segment encap (no SRH): RFC 8754 Section 4.1
+		 * allows omitting the SRH when there is exactly one
+		 * segment.
+		 */
+		if (skb_cow_head(skb, sizeof(*new_ip6h)))
+			goto drop;
+
+		new_ip6h = skb_push(skb, sizeof(*new_ip6h));
+		skb_reset_network_header(skb);
+		memset(new_ip6h, 0, sizeof(*new_ip6h));
+		/* RFC 6040 normal-mode propagation of inner DSCP/ECN. */
+		ip6_flow_hdr(new_ip6h, cb.outer_tclass, 0);
+		new_ip6h->payload_len = htons(skb->len - sizeof(*new_ip6h));
+		new_ip6h->nexthdr = inner_proto;
+		new_ip6h->hop_limit = IPV6_DEFAULT_HOPLIMIT;
+		new_ip6h->saddr = cb.new_sa;
+		new_ip6h->daddr = cb.new_da;
+		skb->protocol = htons(ETH_P_IPV6);
+		skb_set_transport_header(skb, sizeof(*new_ip6h));
+	}
+
+	nf_reset_ct(skb);
+	skb_dst_drop(skb);
+
+	seg6_lookup_any_nexthop(skb, NULL, 0, false, slwt->oif);
+	return dst_input(skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
+static int input_action_h_m_gtp4_d(struct sk_buff *skb,
+				   struct seg6_local_lwt *slwt)
+{
+	unsigned int outer_len, inner_off;
+	struct in6_addr new_da, new_sa;
+	struct seg6_mobile_h_gtp4_d_cb *cb;
+	int gtp_hdrlen;
+	__be32 v4_da, v4_sa;
+	struct iphdr *ip4h;
+	__be16 frag_off;
+	struct udphdr *uh;
+	int inner_nfproto;
+	u8 inner_first;
+	u8 inner_dsfield;
+	u8 inner_proto;
+	u64 args_mob;
+	u32 teid;
+	int ihl;
+	u8 qfi;
+	const struct seg6_mobile_info *minfo = &slwt->mobile_info;
+	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+
+	BUILD_BUG_ON(sizeof(struct seg6_mobile_h_gtp4_d_cb) >
+		     sizeof_field(struct sk_buff, cb));
+
+	if (!pskb_may_pull(skb, sizeof(*ip4h))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	ip4h = ip_hdr(skb);
+	if (ip4h->protocol != IPPROTO_UDP) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	/* ip_rcv_core() rejects ihl < 5, but enforce it here too so the
+	 * lwtunnel is self-contained against future callers that bypass
+	 * the IPv4 receive entry path.
+	 */
+	if (ip4h->ihl < 5) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	ihl = ip4h->ihl * 4;
+	if (!pskb_may_pull(skb, ihl + sizeof(*uh))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
+		goto drop;
+	}
+
+	ip4h = ip_hdr(skb);
+	uh = (struct udphdr *)((u8 *)ip4h + ihl);
+	if (uh->dest != htons(GTP1U_PORT))
+		goto drop;
+
+	/* Snapshot the outer IPv4 fields before seg6_mobile_parse_gtpu(),
+	 * whose internal pskb_may_pull() calls may reallocate skb->head
+	 * and invalidate ip4h.
+	 */
+	v4_da = ip4h->daddr;
+	v4_sa = ip4h->saddr;
+	frag_off = ip4h->frag_off;
+	inner_dsfield = ipv4_get_dsfield(ip4h);
+
+	gtp_hdrlen = seg6_mobile_parse_gtpu(skb, ihl + sizeof(*uh),
+					    &teid, &qfi);
+	if (gtp_hdrlen == -EOPNOTSUPP)
+		return seg6_mobile_passthrough_non_tpdu(skb);
+	if (gtp_hdrlen < 0)
+		goto drop;
+
+	args_mob = seg6_mobile_args_from_teid_qfi(teid, qfi);
+
+	new_da = slwt->nh6;
+	if (seg6_mobile_fill_egress_sid(&new_da, minfo->sr_prefix_len,
+					minfo->v4_mask_len, v4_da, args_mob)) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;
+		goto drop;
+	}
+
+	new_sa = minfo->src_addr;
+	seg6_mobile_overlay_v4(&new_sa, minfo->v4_mask_len, minfo->v6_src_prefix_len,
+			       v4_sa);
+
+	outer_len = ihl + sizeof(*uh) + gtp_hdrlen;
+	if (!pskb_may_pull(skb, outer_len + 1)) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	inner_off = outer_len;
+	inner_first = *((u8 *)skb->data + inner_off);
+	switch (inner_first >> 4) {
+	case 4:
+		inner_proto = IPPROTO_IPIP;
+		inner_nfproto = NFPROTO_IPV4;
+		break;
+	case 6:
+		inner_proto = IPPROTO_IPV6;
+		inner_nfproto = NFPROTO_IPV6;
+		break;
+	default:
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	/* PMTU: H.M.GTP4.D strips IPv4/UDP/GTP-U (>=36 B) and prepends
+	 * IPv6 + (optional) SRH (40 B base + segments).  Net delta can
+	 * be positive (encap grows) when the SR Policy has multiple
+	 * segments or when GTP-U was a short header.  Reject and
+	 * inform the source via ICMP_DEST_UNREACH/FRAG_NEEDED if the
+	 * result would not fit.
+	 */
+	{
+		unsigned int srh_len = slwt->srh ?
+			((slwt->srh->hdrlen + 1) << 3) : 0;
+		unsigned int new_outer = sizeof(struct ipv6hdr) + srh_len;
+		unsigned int post_encap = skb->len - outer_len + new_outer;
+		unsigned int mtu = dst_mtu(skb_dst(skb));
+		/* Compute the upstream-equivalent MTU as a signed delta:
+		 * IPv4 options can make outer_len > new_outer, in which
+		 * case unsigned subtraction would wrap.  All values fit
+		 * comfortably in int (mtu <= 64K, outer_len <= ~84,
+		 * new_outer <= ~2 KiB).
+		 */
+		int upstream_mtu = (int)mtu + (int)outer_len - (int)new_outer;
+
+		if (mtu && post_encap > mtu) {
+			if (frag_off & htons(IP_DF)) {
+				icmp_ndo_send(skb, ICMP_DEST_UNREACH,
+					      ICMP_FRAG_NEEDED,
+					      htonl(upstream_mtu > 0 ?
+						    upstream_mtu : 0));
+			}
+			reason = SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED;
+			goto drop;
+		}
+
+		if (skb_is_gso(skb) && mtu &&
+		    (upstream_mtu <= 0 ||
+		     !skb_gso_validate_network_len(skb, upstream_mtu))) {
+			reason = SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED;
+			goto drop;
+		}
+	}
+
+	if (!pskb_may_pull(skb, outer_len +
+			   ((inner_proto == IPPROTO_IPIP) ?
+			    sizeof(struct iphdr) : sizeof(struct ipv6hdr)))) {
+		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
+		goto drop;
+	}
+
+	skb_pull_rcsum(skb, outer_len);
+	skb_reset_network_header(skb);
+
+	skb->protocol = (inner_proto == IPPROTO_IPIP) ? htons(ETH_P_IP)
+						      : htons(ETH_P_IPV6);
+
+	skb_set_transport_header(skb,
+				 (inner_proto == IPPROTO_IPIP) ?
+				 sizeof(struct iphdr) :
+				 sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
+
+	cb = SEG6_MOBILE_H_GTP4_D_CB(skb);
+	cb->new_da = new_da;
+	cb->new_sa = new_sa;
+	/* RFC 6040 normal-mode propagation: copy the outer IPv4 (incoming
+	 * GTP-U envelope) DSCP+ECN verbatim into the new outer IPv6
+	 * Traffic Class.
+	 */
+	cb->outer_tclass = inner_dsfield;
+
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(inner_nfproto, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, skb->dev,
+			       NULL, input_action_h_m_gtp4_d_finish);
+
+	return input_action_h_m_gtp4_d_finish(dev_net(skb->dev), NULL, skb);
+
+drop:
+	kfree_skb_reason(skb, reason);
+	return -EINVAL;
+}
+
 /* RFC 9433 Section 6.5 -- End.M.GTP6.E
  * Receives an SRv6 packet whose current SID is an End.M.GTP6.E SID
  * (Segments Left == 1) and re-encapsulates the inner payload in
@@ -3135,6 +3477,22 @@ static struct seg6_action_desc seg6_action_table[] = {
 			.destroy_state = seg6_end_m_gtp6_d_aug_destroy,
 		},
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_H_M_GTP4_D,
+		.input_family	= AF_INET,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6)		     |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR)    |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V4_MASK_LEN) |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SR_PREFIX_LEN),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS |
+				  SEG6_F_ATTR(SEG6_LOCAL_SRH) |
+				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN) |
+				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
+		.input		= input_action_h_m_gtp4_d,
+		.slwt_ops	= {
+			.build_state = seg6_mobile_v4_validate,
+		},
+	},
 	{
 		.action		= SEG6_LOCAL_ACTION_END_MAP,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
@@ -3206,13 +3564,22 @@ static int seg6_local_input_core(struct net *net, struct sock *sk,
 
 static int seg6_local_input(struct sk_buff *skb)
 {
-	if (skb->protocol != htons(ETH_P_IPV6)) {
+	int nfproto;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IPV6):
+		nfproto = NFPROTO_IPV6;
+		break;
+	case htons(ETH_P_IP):
+		nfproto = NFPROTO_IPV4;
+		break;
+	default:
 		kfree_skb(skb);
 		return -EINVAL;
 	}
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
-		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
+		return NF_HOOK(nfproto, NF_INET_LOCAL_IN,
 			       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
 			       seg6_local_input_core);
 
@@ -3625,6 +3992,44 @@ static int seg6_mobile_v4_validate(struct seg6_local_lwt *slwt,
 				   "SRv6 Mobile v6_src_prefix_len must leave room for the 32-bit IPv4 source template (prefix_len <= 96)");
 		return -EINVAL;
 	}
+
+	/* H.M.GTP4.D constructs an End.M.GTP4.E SID at egress time whose
+	 * layout (RFC 9433 Section 6.7 / 6.6 Figure 9) is
+	 *   locator (sr_prefix_len) | IPv4 DA (v4_mask_len) | Args.Mob.Session (40)
+	 * so the three lengths together must fit in 128 bits.  End.M.GTP4.E
+	 * leaves sr_prefix_len at 0 (the attribute is not in its action_table
+	 * entry), so this check is a no-op for End.M.GTP4.E.
+	 */
+	if (minfo->sr_prefix_len &&
+	    (unsigned int)minfo->sr_prefix_len + (unsigned int)minfo->v4_mask_len +
+	    SEG6_MOBILE_ARGS_MOB_LEN > 128) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SRv6 Mobile sr_prefix_len + v4_mask_len + 40 (Args.Mob.Session) must not exceed 128");
+		return -EINVAL;
+	}
+
+	/* End.M.GTP4.E SID layout (RFC 9433 Section 6.6 Figure 10):
+	 *   locator (route prefix) | IPv4 DA (v4_mask_len) | Args.Mob.Session (40) | pad
+	 *
+	 * The locator length comes from the IPv6 route's destination prefix
+	 * length, not from sr_prefix_len.  Only End.M.GTP4.E (AF_INET6 route)
+	 * needs this check; H.M.GTP4.D requires sr_prefix_len so this branch
+	 * is unreachable for it.  Gate on input_family so the @cfg cast to
+	 * struct fib6_config * is type-correct.
+	 */
+	if (!minfo->sr_prefix_len &&
+	    (slwt->desc->input_family ? : AF_INET6) == AF_INET6) {
+		const struct fib6_config *fib6_cfg = cfg;
+
+		if ((unsigned int)fib6_cfg->fc_dst_len +
+		    (unsigned int)minfo->v4_mask_len +
+		    SEG6_MOBILE_ARGS_MOB_LEN > 128) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "End.M.GTP4.E route prefix length + v4_mask_len + 40 (Args.Mob.Session) must not exceed 128");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -4323,7 +4728,7 @@ static int seg6_local_build_state(struct net *net, struct nlattr *nla,
 	struct seg6_local_lwt *slwt;
 	int err;
 
-	if (family != AF_INET6)
+	if (family != AF_INET6 && family != AF_INET)
 		return -EINVAL;
 
 	err = nla_parse_nested_deprecated(tb, SEG6_LOCAL_MAX, nla,
@@ -4346,6 +4751,17 @@ static int seg6_local_build_state(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		goto out_free;
 
+	/* Reject behaviors that are not registered for the route family
+	 * the lwtunnel is being installed on.  input_family defaults to
+	 * AF_INET6; H.M.GTP4.D is the only AF_INET behavior.
+	 */
+	if ((slwt->desc->input_family ? : AF_INET6) != family) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "seg6local action does not support this address family");
+		err = -EINVAL;
+		goto out_destroy_attrs;
+	}
+
 	err = seg6_local_lwtunnel_build_state(slwt, cfg, extack);
 	if (err < 0)
 		goto out_destroy_attrs;
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a770e711652e..30adf2474c45 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,6 +97,7 @@ TEST_PROGS := \
 	srv6_end_map_test.sh \
 	srv6_end_next_csid_l3vpn_test.sh \
 	srv6_end_x_next_csid_l3vpn_test.sh \
+	srv6_h_m_gtp4_d_test.sh \
 	srv6_hencap_red_l3vpn_test.sh \
 	srv6_hl2encap_red_l2vpn_test.sh \
 	srv6_iptunnel_cache.sh \
diff --git a/tools/testing/selftests/net/srv6_h_m_gtp4_d_test.sh b/tools/testing/selftests/net/srv6_h_m_gtp4_d_test.sh
new file mode 100755
index 000000000000..3e5f4f74c656
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_h_m_gtp4_d_test.sh
@@ -0,0 +1,487 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154
+#
+# Selftest for the SRv6 H.M.GTP4.D behavior (RFC 9433 Section 6.7).
+#
+#   +-------+     10.0.0.0/24     +-------+   2001:db8:2::/64   +-------+
+#   |  gnb  | ------------------- | srgw  | ------------------- | srupf |
+#   +-------+        veth-n3      +-------+        veth-n9      +-------+
+#                                     |
+#                                     |        10.10.0.0/24
+#                                     +--------veth-n6--------- +-------+
+#                                                               | lupf  |
+#                                                               +-------+
+#
+# gnb is the GTP-U-side test peer that injects the GTP-U packets.
+# srupf is the SR-domain-side SRv6-aware UPF (RFC 9433 sense, not
+# a 3GPP UPF) that receives the resulting SRv6 T-PDU.  lupf is the
+# SRv6-non-aware legacy UPF that owns the GTP-U control plane and
+# receives non-T-PDU GTP-U (Echo Request, Error Indication, ...)
+# forwarded by srgw via the H.M.GTP4.D route's dev.  srgw runs the
+# H.M.GTP4.D behavior under test.
+#
+# An H.M.GTP4.D SID is installed on the SR ingress for IPv4 destination
+# 10.99.0.0/24 with v4_mask_len=32 and sr_prefix_len=32; Args.Mob.Session is
+# the fixed 40-bit field defined by RFC 9433 Section 6.1, Figure 8.  The
+# H.M.GTP4.D SID locator prefix is 2001:db8::, so an inbound IPv4/UDP/GTP-U
+# packet to 10.99.0.2 with TEID 0x123 (and PDU Session ext carrying QFI=5) is
+# expected to come out as IPv6 toward 2001:db8:a63:2:1400:1:2300:0,
+# where:
+#
+#   bytes 0-3  (locator /32)        = 20 01 0d b8
+#   bytes 4-7  (IPv4 DA, 32-bit)    = 0a 63 00 02   (= 10.99.0.2)
+#   bytes 8-12 (Args.Mob.Session)   = 14 00 00 01 23
+#                              (QFI byte 0x14 + 32-bit PDU/TEID 0x123)
+#   bytes 13-15 (SID padding)       = 00 00 00
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
+	setup_ns gnb srgw srupf lupf srupf_vrf
+
+	ip -n "$gnb" link set lo up
+	ip -n "$srgw" link set lo up
+	ip -n "$srupf" link set lo up
+	ip -n "$lupf" link set lo up
+	ip -n "$srupf_vrf" link set lo up
+
+	ip link add veth-n3 netns "$gnb" type veth peer name veth-n3-srgw \
+		netns "$srgw"
+	ip -n "$gnb" addr add 10.0.0.2/24 dev veth-n3
+	ip -n "$srgw" addr add 10.0.0.1/24 dev veth-n3-srgw
+	ip -n "$gnb" link set veth-n3 up
+	ip -n "$srgw" link set veth-n3-srgw up
+
+	ip link add veth-n9 netns "$srgw" type veth peer name veth-n9-srupf \
+		netns "$srupf"
+	ip -n "$srgw" addr add 2001:db8:2::1/64 dev veth-n9 nodad
+	ip -n "$srupf" addr add 2001:db8:2::e/64 dev veth-n9-srupf nodad
+	ip -n "$srgw" link set veth-n9 up
+	ip -n "$srupf" link set veth-n9-srupf up
+
+	# Legacy IPv4 UPF reachable from srgw; non-T-PDU GTP-U is forwarded
+	# here via the H.M.GTP4.D route's dev so the legacy GTP-U control
+	# plane (Echo Request / Response) can be answered downstream.
+	ip link add veth-n6 netns "$srgw" type veth peer name veth-n6-lupf \
+		netns "$lupf"
+	ip -n "$srgw" addr add 10.10.0.1/24 dev veth-n6
+	ip -n "$lupf" addr add 10.10.0.2/24 dev veth-n6-lupf
+	ip -n "$srgw" link set veth-n6 up
+	ip -n "$lupf" link set veth-n6-lupf up
+
+	ip netns exec "$srgw" sysctl -wq net.ipv4.ip_forward=1
+	ip netns exec "$srgw" sysctl -wq net.ipv6.conf.all.forwarding=1
+
+	ip -n "$gnb" route add 10.99.0.0/24 via 10.0.0.1
+
+	# Install H.M.GTP4.D on an IPv4 route.  sr_prefix_len declares the
+	# locator length used by the remote End.M.GTP4.E SID.  dev veth-n6
+	# is the legacy UPF leg: T-PDU encap takes the IPv6 SR Policy path
+	# (independent of dst.dev) while non-T-PDU is forwarded out veth-n6
+	# via ip_forward.
+	ip -n "$srgw" -4 route add 10.99.0.0/24 \
+		encap seg6local action H.M.GTP4.D \
+			nh6 2001:db8:: \
+			src 2001:db8:2::1 \
+			v4_mask_len 32 sr_prefix_len 32 \
+		dev veth-n6
+
+	# srgw needs to reach the constructed SID; the /32 prefix covers
+	# any IPv4 DA + Args.Mob.Session combination derived from the
+	# locator 2001:db8::.
+	ip -n "$srgw" -6 route add 2001:db8::/32 \
+		via 2001:db8:2::e dev veth-n9
+	ip -n "$srupf" -6 route add 2001:db8::/32 dev veth-n9-srupf
+
+	local upf_mac
+	upf_mac=$(ip -n "$srupf" -j link show veth-n9-srupf | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	ip -n "$srgw" -6 neigh replace 2001:db8:2::e dev veth-n9 \
+		lladdr "$upf_mac" nud permanent 2>/dev/null || true
+
+	# Pre-resolve the IPv4 ARP entry for the SID-prefix DA so non-T-PDU
+	# Echo can be forwarded to lupf without ARP delay.
+	local lupf_mac
+	lupf_mac=$(ip -n "$lupf" -j link show veth-n6-lupf | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+	ip -n "$srgw" neigh replace 10.99.0.2 dev veth-n6 \
+		lladdr "$lupf_mac" nud permanent 2>/dev/null || true
+
+	# Per-route VRF case: a second SR-side upf in its own VRF.  The
+	# H.M.GTP4.D SID for this tenant binds the SRv6 underlay output to
+	# the VRF via 'oif'.  Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	modprobe vrf 2>/dev/null
+	if ip -n "$srgw" link add vrf-n9 type vrf table 100 2>/dev/null; then
+		have_vrf=1
+		ip -n "$srgw" link set dev vrf-n9 up
+
+		ip link add veth-n9-2 netns "$srgw" type veth peer name \
+			veth-n9-2-srupf netns "$srupf_vrf"
+		ip -n "$srgw" link set dev veth-n9-2 master vrf-n9
+		ip -n "$srgw" addr add 2001:db8:4::1/64 dev veth-n9-2 nodad
+		ip -n "$srupf_vrf" addr add 2001:db8:4::e/64 dev veth-n9-2-srupf \
+			nodad
+		ip -n "$srgw" link set dev veth-n9-2 up
+		ip -n "$srupf_vrf" link set dev veth-n9-2-srupf up
+
+		# H.M.GTP4.D for a second IPv4 prefix bound to vrf-n9; the
+		# constructed SID's locator is 2001:db9::/32 (a separate locator
+		# so the two routes never collide).
+		ip -n "$srgw" -4 route add 10.99.1.0/24 \
+			encap seg6local action H.M.GTP4.D \
+				nh6 2001:db9:: \
+				src 2001:db8:2::1 \
+				v4_mask_len 32 sr_prefix_len 32 \
+				oif vrf-n9 \
+			dev veth-n9-2
+
+		# Reach the constructed SID via the VRF table.
+		ip -n "$srgw" -6 route add 2001:db9::/32 \
+			via 2001:db8:4::e dev veth-n9-2 vrf vrf-n9
+		ip -n "$srupf_vrf" -6 route add 2001:db9::/32 \
+			dev veth-n9-2-srupf
+
+		local upf_vrf_mac
+		upf_vrf_mac=$(ip -n "$srupf_vrf" -j link show \
+			veth-n9-2-srupf | python3 -c \
+			'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+		ip -n "$srgw" -6 neigh replace 2001:db8:4::e dev veth-n9-2 \
+			lladdr "$upf_vrf_mac" nud permanent 2>/dev/null || true
+
+		ip -n "$gnb" route add 10.99.1.0/24 via 10.0.0.1
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
+	if ! python3 -c "import scapy.all" 2>/dev/null; then
+		echo "SKIP: python3-scapy is required"; exit "$ksft_skip"
+	fi
+
+	if ! ip route help 2>&1 | grep -qF "H.M.GTP4.D"; then
+		echo "SKIP: iproute2 too old, missing seg6local action H.M.GTP4.D"
+		exit "$ksft_skip"
+	fi
+}
+
+send_gtpu()
+{
+	local v4_dst="$1"
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n3-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" V4_DST="$v4_dst" ip netns exec "$gnb" python3 - <<'PY'
+import os
+from scapy.all import IP, UDP, ICMP, sendp, Ether
+mac = os.environ['SRGW_MAC']
+v4_dst = os.environ['V4_DST']
+gtpu = bytes.fromhex(
+    "34 ff 00 24 00 00 01 23 00 00 00 85"
+    "01 00 05 00")
+inner = bytes(IP(src='10.0.0.2', dst=v4_dst) / ICMP())
+pkt = (Ether(dst=mac) /
+       IP(src='10.0.0.2', dst=v4_dst) /
+       UDP(sport=2152, dport=2152) /
+       (gtpu + inner))
+sendp(pkt, iface='veth-n3', verbose=False)
+PY
+}
+
+# Send a GTPv1-U Echo Request; H.M.GTP4.D must NOT consume it but
+# pass it through to the configured forwarding path so the legacy UPF
+# (which owns the GTP-U control plane) can answer.  Verified by
+# capturing the unaltered Echo Request (type 0x01) on the lupf side.
+send_gtpu_echo()
+{
+	local v4_dst="$1"
+	local srgw_mac
+
+	srgw_mac=$(ip -n "$srgw" -j link show veth-n3-srgw | \
+		python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["address"])')
+
+	SRGW_MAC="$srgw_mac" V4_DST="$v4_dst" ip netns exec "$gnb" python3 - <<'PY'
+import os
+from scapy.all import IP, UDP, sendp, Ether
+mac = os.environ['SRGW_MAC']
+v4_dst = os.environ['V4_DST']
+gtpu_echo = bytes.fromhex("32 01 00 04 00 00 00 00 42 42 00 00")
+pkt = (Ether(dst=mac) /
+       IP(src='10.0.0.2', dst=v4_dst) /
+       UDP(sport=2152, dport=2152) /
+       gtpu_echo)
+sendp(pkt, iface='veth-n3', verbose=False)
+PY
+}
+
+run_echo_test()
+{
+	local v4_dst="$1"
+	local out
+	local rc
+
+	out=$(mktemp)
+
+	ip netns exec "$lupf" tcpdump -U -nni veth-n6-lupf -w "$out" \
+		'udp port 2152' 2>/dev/null &
+	tcpdump_pid=$!
+	sleep 1
+
+	send_gtpu_echo "$v4_dst"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+
+	V4_DST="$v4_dst" python3 - "$out" <<'PYEOF'
+import os, sys
+from scapy.all import rdpcap, IP, UDP
+
+want_dst = os.environ['V4_DST']
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IP not in p or UDP not in p:
+        continue
+    if p[UDP].sport != 2152 or p[UDP].dport != 2152:
+        continue
+    if p[IP].dst != want_dst:
+        continue
+    payload = bytes(p[UDP].payload)
+    if len(payload) >= 2 and payload[1] == 0x01:
+        sys.exit(0)
+sys.exit("no GTPv1-U Echo Request observed at lupf "
+         "(H.M.GTP4.D failed to pass non-T-PDU through)")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+capture_traffic()
+{
+	local capture_ns="$1"
+	local capture_iface="$2"
+	local v4_dst="$3"
+	local out="$4"
+
+	ip netns exec "$capture_ns" tcpdump -U -nni "$capture_iface" -w "$out" \
+		'ip6' 2>/dev/null &
+	tcpdump_pid=$!
+	# Give tcpdump a brief moment to attach the BPF filter.
+	sleep 1
+
+	send_gtpu "$v4_dst"
+
+	sleep 1
+	kill -INT "$tcpdump_pid" 2>/dev/null
+	wait "$tcpdump_pid" 2>/dev/null
+	tcpdump_pid=""
+}
+
+run_test()
+{
+	local v4_dst="$1"		# inner IPv4 DA fed into the gNB
+	local locator_octets="$2"	# "20 01 0d b8"
+	local v4_dst_octets="$3"	# "0a 63 00 02" (10.99.0.2) etc
+	local sa_pos="$4"		# byte offset of expected IPv4 SA in IPv6 SA
+	local capture_ns="${5:-$srupf}"
+	local capture_iface="${6:-veth-n9-srupf}"
+	local out
+	local rc
+
+	out=$(mktemp)
+	capture_traffic "$capture_ns" "$capture_iface" "$v4_dst" "$out"
+
+	# scapy field check: an IPv6 packet must reach upf with:
+	# - DST address whose bytes 0..3 = locator, bytes 4..7 = original
+	#   IPv4 DA, bytes 8..12 = 40-bit Args.Mob.Session
+	#   (0x14 = QFI=5, then TEID 0x00000123), bytes 13..15 = padding.
+	# - SRC address whose bytes [sa_pos..sa_pos+4) = original IPv4 SA
+	#   (10.0.0.2) per RFC 9433 Section 6.6 Figure 10.
+	LOC="$locator_octets" V4="$v4_dst_octets" SA_POS="$sa_pos" \
+	python3 - "$out" <<'PYEOF'
+import ipaddress
+import os
+import sys
+from scapy.all import rdpcap, IPv6
+
+loc = bytes.fromhex(os.environ['LOC'])
+v4_dst = bytes.fromhex(os.environ['V4'])
+sa_pos = int(os.environ['SA_POS'])
+expected_v4_sa = bytes.fromhex('0a 00 00 02')
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 not in p:
+        continue
+    da = ipaddress.IPv6Address(str(p[IPv6].dst)).packed
+    sa = ipaddress.IPv6Address(str(p[IPv6].src)).packed
+    if da[0:4] != loc:
+        continue
+    if da[4:8] != v4_dst:
+        sys.exit(f"unexpected SID v4-DA slice {da[4:8].hex()}, want {v4_dst.hex()}")
+    if da[8:13] != bytes.fromhex("1400000123"):
+        sys.exit(f"unexpected Args.Mob.Session {da[8:13].hex()}")
+    if sa[sa_pos:sa_pos + 4] != expected_v4_sa:
+        sys.exit(f"unexpected IPv4 SA at byte {sa_pos}: "
+                 f"{sa[sa_pos:sa_pos + 4].hex()}, want {expected_v4_sa.hex()}")
+    sys.exit(0)
+sys.exit("no IPv6 packet matching the expected SID locator")
+PYEOF
+	rc=$?
+	rm -f "$out"
+	return $rc
+}
+
+# Verify that nf_hooks_lwtunnel=1 makes the inner T-PDU 5-tuple
+# visible to nftables on the SR Gateway.  The inner is IPv4
+# (10.0.0.2 -> v4_dst, set by send_gtpu()); the nft rule matches on
+# the inner IPv4 source.  DROP must suppress the SRv6 packet at the
+# upf, ACCEPT must let it through.
+run_nf_test()
+{
+	local verdict="$1"		# drop | accept
+	local expect="$2"		# 1 if SRv6 expected, empty otherwise
+	local v4_dst="10.99.0.2"
+	local out
+
+	ip netns exec "$srgw" nft flush chain ip filter prerouting
+	ip netns exec "$srgw" nft add rule ip filter prerouting \
+		ip saddr 10.0.0.2 "$verdict"
+
+	out=$(mktemp)
+	capture_traffic "$srupf" "veth-n9-srupf" "$v4_dst" "$out"
+
+	if [ -n "$expect" ]; then
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IPv6
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 in p:
+        sys.exit(0)
+sys.exit("expected SRv6 packet not observed at upf despite nft accept")
+PYEOF
+	else
+		python3 - "$out" <<'PYEOF'
+import sys
+from scapy.all import rdpcap, IPv6
+
+pkts = rdpcap(sys.argv[1])
+for p in pkts:
+    if IPv6 in p and bytes(p[IPv6])[6] == 0x29:
+        # nexthdr == IPIP (41) means an SRv6-encapped IPIP packet
+        sys.exit("SRv6 packet leaked to upf despite nft drop on inner")
+    if IPv6 in p and bytes(p[IPv6])[6] == 0x2b:
+        # nexthdr == 43 (Routing) means SRH present
+        sys.exit("SRv6 packet leaked to upf despite nft drop on inner")
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
+	# Hard-coded /64 layout: IPv4 SA at IPv6 bytes 8..11.
+	if run_test "10.99.0.2" "20 01 0d b8" "0a 63 00 02" 8; then
+		echo "TEST: H.M.GTP4.D (default) [PASS]"
+	else
+		echo "TEST: H.M.GTP4.D (default) [FAIL]"
+		rc=1
+	fi
+
+	if run_echo_test "10.99.0.2"; then
+		echo "TEST: H.M.GTP4.D (non-T-PDU passthrough) [PASS]"
+	else
+		echo "TEST: H.M.GTP4.D (non-T-PDU passthrough) [FAIL]"
+		rc=1
+	fi
+
+	# VRF binding: SRv6 underlay output goes through vrf-n9 (table 100).
+	# Reported as [SKIP] when CONFIG_NET_VRF is not loaded.
+	if [ "$have_vrf" = "1" ]; then
+		# Locator 2001:db9::/32 -> "20 01 0d b9", v4 dst 10.99.1.2 ->
+		# "0a 63 01 02".
+		if run_test "10.99.1.2" "20 01 0d b9" "0a 63 01 02" 8 \
+			    "$srupf_vrf" "veth-n9-2-srupf"; then
+			echo "TEST: H.M.GTP4.D (oif vrf-n9) [PASS]"
+		else
+			echo "TEST: H.M.GTP4.D (oif vrf-n9) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: H.M.GTP4.D (oif vrf-n9) [SKIP] (CONFIG_NET_VRF not loaded)"
+	fi
+
+	# Inner T-PDU netfilter hook: only meaningful when nft is present
+	# and the kernel exposes net.netfilter.nf_hooks_lwtunnel.
+	if command -v nft >/dev/null && \
+	   ip netns exec "$srgw" sysctl -wq \
+		net.netfilter.nf_hooks_lwtunnel=1 2>/dev/null; then
+		ip netns exec "$srgw" nft add table ip filter
+		ip netns exec "$srgw" nft 'add chain ip filter prerouting' \
+			'{ type filter hook prerouting priority 0; }'
+
+		if run_nf_test drop ""; then
+			echo "TEST: H.M.GTP4.D (nft drop on inner) [PASS]"
+		else
+			echo "TEST: H.M.GTP4.D (nft drop on inner) [FAIL]"
+			rc=1
+		fi
+
+		if run_nf_test accept "1"; then
+			echo "TEST: H.M.GTP4.D (nft accept on inner) [PASS]"
+		else
+			echo "TEST: H.M.GTP4.D (nft accept on inner) [FAIL]"
+			rc=1
+		fi
+	else
+		echo "TEST: H.M.GTP4.D (inner-flow netfilter hook) [SKIP]" \
+		     "(nft or nf_hooks_lwtunnel unavailable)"
+	fi
+
+	if [ "$rc" -eq 0 ]; then
+		echo "TEST: H.M.GTP4.D [PASS]"
+		exit "$ksft_pass"
+	else
+		echo "TEST: H.M.GTP4.D [FAIL]"
+		exit "$ksft_fail"
+	fi
+}
+
+main "$@"

-- 
2.50.1


