Return-Path: <netdev+bounces-259905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNQVJ29gm2kmywMAu9opvQ
	(envelope-from <netdev+bounces-259905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:00:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1317040B
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D8C3035D47
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B335C195;
	Sun, 22 Feb 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESMJOTpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32735BDC9
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790347; cv=none; b=mYy+6z24oa71b2RiUsryJ8cwsroOzA+CnkSD5/uYTSU8hxYjBgtAM+5ciUe66/T2fHvv1tnwZiibhqYLgKgLRqRe+NrYmOakvQCBnm5Vndm7c1bwCOa1quZ1S1d7iK+ycgxWDyQDF9cawI8eqhPfQaFpvJhy8qGH1hrKs0IJ4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790347; c=relaxed/simple;
	bh=MgqFP+kEIYkaJNFbJG3TL6RfVtetCetfNmpFyY7dGco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q819vprmj3SKnbZCjz5zWrdzmif9VbOBb5O1bOgH2MzfZ80/IUPclSOehlJz9YQl7ddN4uUcfIOmNZipSy03G6xZnhkKMF4WcfNKo4wRcFYcMwXrT9LCBT2Mu1x+UVNRcw+KlshRczCuBJ7M45BhvwuKAUl+4pgZxcd3W8vreh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESMJOTpH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8fd976e90cso493590166b.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790344; x=1772395144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=ESMJOTpHZMN/avWIryT1rp+H53Su4+qRs+FwE3WVK+VgvWjp2FlnqxbyG3Dp2J9hEk
         +KPUPWX7DQkd18IgDyPcHMQCxpU2AKw6sfnvuz966IGRUG5RgDkD+K03k+KCHaH7adfR
         29WUl/EQsvSrkxUfLZm/k2U+uaLln4OeJ46uUGS4W8CoHadG+x1khFR6CykZe8ZjpsqT
         lg5Egb3SENYVnqgJLG5sp9ooHa1MKLyexDgfyDGE3InMZyscv8zHdRdjK8PFvJi9eLrG
         bc+FZcNuZ4piC0t65nlSoPVEZgPgFufUNbKss7PaxPl2J0RFFwdFuAtZAYTXvk6Mi4GN
         swsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790344; x=1772395144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=a+KUr9l5UVU3FyHSOZYuz2l8Hv4ALEo1tEHRiCsnAQjN/mZUqS886lVZeglW2P4aIe
         UM9fxEBWhSnT8qySAU5nNZOzLUmkhjN/4WyrXLcb5z4tiK3Kwl9NGngsNRi5ZWERWTH4
         NIo+3rYrXfWrLQULagbZR935hGPSOwTzIpjySCDzaocSQa/fvCkAXUb/Coj/KW/oIfmb
         0K796hTLrNXW1WOu6rG+S+ZIi4qFIdywa2Y76RDfxdFTjduzKjk19J1/aVRDc0mkrCqP
         xQHiHlhVQhlA36W9ybgJgfd/jeFkjdPc+hn/JjcL0BvzFJxB2vpZsCo5Zyv57Ca3Qiql
         mFHA==
X-Forwarded-Encrypted: i=1; AJvYcCXfgPpfKlG9o1bR9GXQx8EgS1M43KFjfsJd12GsAAFQC1qiCkmDxXcj2Sg0wIQiFraSZRKqw8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Eq4LsjvQ8Ata0OS/ZxIvLsjdAUODaklM3ghyxfsFzmx2BZdH
	xNvb7mOQD5Ul20jwmUVq5zqLwIVPPbLs4ByC0wz7bfvUC2odlBcG2IZR
X-Gm-Gg: AZuq6aLX/Tvbe/21ASzAHZ3uUGlk6VPVTsNwcfaQn8hRFmXZCiuhWkmSdbVBFKDvc4b
	V47BNrJqOEza2deya4t95WiV4UGYzRYxPM1Fna+e1sDQr/T1AoOOUgAtV9j2SEQjxdlSdi4DjQF
	gtSrJjsB75/exfvA4l5Lgc278Y3MtDbUaQqH1igIcxKhZ1Q6qZd84OwFqGWIUa6I4f9dY17tI5J
	n0MPPMoE1A1vukt6JOndgwq6YNJ7IYCxeiXwrZsP0mO36Yuahh/ZjqEeBYRGCO8L9+B+q0o+t2P
	jU+OP8/8MKir6XGQPf/oMjhCKJpNktz70xMfUR8M+50rPMXd9EfmPI51ZVbGiaE2rqjCRex6fzY
	R6q85vd1/EXu9DeDeRRms84zoJGPPlMgAyec54UdbZeMdTmP/IE8yktsSqiMTyWUQUs9f31vZ6s
	jel+CTVhfQmTw/Vn6XtyuYhH5qpisRLcFLEUDQL5Jl+Cq8TlvGZjZnbLeC8pzDJq2wj/cu8PPT9
	VlAMFBB72RjGeUI9v2DCutvp1FPqWyCP/uK3zffJez8WaELZAUSSjM=
X-Received: by 2002:a17:906:2699:b0:b88:4b1f:5aff with SMTP id a640c23a62f3a-b9081b89670mr286298566b.44.1771790344085;
        Sun, 22 Feb 2026 11:59:04 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:02 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v18 nf-next 2/4] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sun, 22 Feb 2026 20:58:41 +0100
Message-ID: <20260222195845.77880-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222195845.77880-1-ericwouds@gmail.com>
References: <20260222195845.77880-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-259905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bridge_state.pf:url]
X-Rspamd-Queue-Id: F2B1317040B
X-Rspamd-Action: no action

In a bridge, until now, it is possible to track connections of plain
ip(v6) and ip(v6) encapsulated in single 802.1q or 802.1ad.

This patch adds the capability to track connections when the connection
is (also) encapsulated in PPPoE. It also adds the capability to track
connections that are encapsulated in an inner 802.1q, combined with an
outer 802.1ad or 802.1q encapsulation.

To prevent mixing connections that are tagged differently in the L2
encapsulations, one should separate them using conntrack zones.
Using a conntrack zone is a hard requirement for the newly added
encapsulations of the tracking capability inside a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 58a33d0380b0..49e01083278c 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_bridge.h>
 
+#include <linux/ppp_defs.h>
 #include <linux/netfilter_ipv4.h>
 
 #include "../br_private.h"
@@ -236,58 +237,116 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
+static int nf_ct_bridge_pre_inner(struct sk_buff *skb, __be16 *proto, u32 *len)
+{
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			return -1;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			return -1;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		skb_set_network_header(skb, VLAN_HLEN);
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	int ret = NF_ACCEPT, offset = 0;
 	enum ip_conntrack_info ctinfo;
+	u32 len, pppoe_len = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 proto;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	proto = skb->protocol;
+
+	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
+			NF_CT_DEFAULT_ZONE_ID) {
+		offset = nf_ct_bridge_pre_inner(skb, &proto, &pppoe_len);
+		if (offset < 0)
 			return NF_ACCEPT;
+	}
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+		if (!pskb_may_pull(skb, offset + sizeof(struct ipv6hdr)))
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ipv6_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV6;
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-		return NF_ACCEPT;
+		goto do_not_track;
 	}
 
-	if (ret != NF_ACCEPT)
-		return ret;
+	if (ret == NF_ACCEPT)
+		ret = nf_conntrack_in(skb, &bridge_state);
+
+do_not_track:
+	if (offset && ret == NF_ACCEPT)
+		skb_reset_network_header(skb);
 
-	return nf_conntrack_in(skb, &bridge_state);
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.53.0


