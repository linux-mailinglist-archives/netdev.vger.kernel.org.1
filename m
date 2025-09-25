Return-Path: <netdev+bounces-226497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3CBA106F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E081BC7451
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879931A7EB;
	Thu, 25 Sep 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETSmPDXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A762512DE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825064; cv=none; b=CmCxQDI0I8S3w+E324NojKTx45fBmvFfEboTJ/X1xpafdgSBWXLmCutItqJOox3ItFgoeM4kEfm6lembxdSVoPNFnDDBlGtyriYGtBtT4enzqO1xuYL936ivce4GrzPq7gbVXtrq2BxQjgyMN8t1h86OWyi8fnYQoP4STkVzVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825064; c=relaxed/simple;
	bh=ovH7NLxlzzSK9WVYC0PhEMqPjPiuDuf7OAcH4fUbX94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXg0zruVc++T9pu2CjheIztLCWBWlgduI5Opcy/WNGWJy4yJSJfau2frFYoa8T+46CvYIA6PIyqpIFYHxiWD1cMHGAZA2bWJAM0wEhdoiRo7nfRdF7xIOYRkGXAFxAalWKseKB04Cqdxl8fW8w1FpCl2RkjsoFOiqXcKLcCMsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETSmPDXJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso3240861a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825061; x=1759429861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4i+bCQ5MlHbYcO9KO5Yge1iebjxDWaZWFM7hLHP88c=;
        b=ETSmPDXJW13GXtpQeg2tt13VmcgunpPIRGW0sfpUT6Un8ozYAUY9fKwgE4QPNV9q/Z
         JatTnvQDvUK+OU6qNdqtCSABrbWBC0s16TzbCI2VM3dgOY9zfId+iIE9FLFfDJqPzDLG
         9n8jQEVTQTTLkGal9WmY0ndz5c6amPMvaWEexIx5JLLkrI8k/8eJ5xQIwHo2JMcfcAww
         fSRD09rmGtTzUZP28X7ehiBKUsAXp3OznY32IFou3N4XfkSVeBZWSW+6EV4zHQiykvON
         o/mCL5d4vye9cPMVF1zJJW6SR8fs5Hc+AYzYgK8fXCA2Q/6kqY+jXDxMG5wooPnPTolf
         qg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825061; x=1759429861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4i+bCQ5MlHbYcO9KO5Yge1iebjxDWaZWFM7hLHP88c=;
        b=WJrfpjsjclP0eToR+edZxcMJwCBRnQrKCDLFiXv+n41m/42Mj9uXuBWfNj0E8U2K6Z
         WJwK7oWgB0a9tgJo+8Ft33b9UT/pgcBszU5TTI+0yIma9dhGrCrLlsW9aEVnlKRhFCN9
         Kpv38eUL3ojlHWBN7DHRhogcCJaMIu5MxojBewLGrFhBHfU0+03akMPM1Oto9spr5FWb
         f1toWOhU0ZZCSLTmtaRCM8hGs/58dL9m/frOq+bTy8stEoKn7AhQjC0B0sAaOJ9JlFU0
         xxyL+quYAdBX1dyiBW4Ol8Yd65LDpKMCXnIOYiMokyQAylgvSxiEI7KiL1Mytn6MytGq
         b3hA==
X-Forwarded-Encrypted: i=1; AJvYcCXAinauxrOCskd2vC+9Y9JCP+NWsqVJMNzt+ogOz1ogmjcCbx8+aynFlYc4+j2BXThb1VHl1jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXztoHGob8sJTv4HXoL3elFxnwnxFuN0jGxgoM9ieSl51L+xY
	fh0w1AThDz16v2ICSuptKzcVEE+QLAewc560DL0f08wOqkN/qX4vNrwo
X-Gm-Gg: ASbGncslDE3l8iVE5hKxMhEKNqXphCqd1JQppWvOJURQOwvimJ/Tjby7SqeusM3aPfN
	fIaKS/NzFlW3Y8gGLzpZ2SxsVpp0mU85bO0gbiy1mTsuRkTIMcPfyDoBKIRhaRXT9PFguGQefo/
	+e5pDig7/K0NV4c88etlRwS0h/8CWX+lBUYl+TLJNPTmGRu9crpsWF8+1CiFiA0AL5Y2g/iiuPO
	EwyLXgk9XcWaQx1XtzxfvPGUX8HD99ERL4W7KygM2L3iWB8vFhH9ZazrH3Htpo1nZFPC4UFJuQY
	+pLBmhhNSV5TTs0vD2ulaiEUAb4eNvxUSBRW6L4C/VFTzpfgBgpm8kiVQT778NiKQeBPJUBgDYq
	yRZPbrtrK+P0cb+/q+3eiJRMX1S1a6ICUahYX3xrZ0bHHZtiJERmMTdAu5omSizPV42qiLlzkyv
	h2aJbOc3hEOW1GEhnU2Q==
X-Google-Smtp-Source: AGHT+IFPe/dbeDF6Im7/W1h15NLhKANyKOEKqP6yxsuAyUtLh3wQ4f95Oj+7V/uEOpOQCqQ3G+kRuA==
X-Received: by 2002:a17:907:7f8a:b0:af9:8739:10ca with SMTP id a640c23a62f3a-b354e31bbacmr390106366b.28.1758825060520;
        Thu, 25 Sep 2025 11:31:00 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9c560sm211198666b.107.2025.09.25.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:31:00 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
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
Subject: [PATCH v15 nf-next 2/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Thu, 25 Sep 2025 20:30:42 +0200
Message-ID: <20250925183043.114660-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250925183043.114660-1-ericwouds@gmail.com>
References: <20250925183043.114660-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge, only when a conntrack zone is set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 97 ++++++++++++++++++----
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..d3745af60f3a 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -237,58 +237,121 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
+/**
+ * nf_ct_bridge_pre_inner - advances network_header to the header that follows
+ * the pppoe- or vlan-header.
+ */
+
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
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
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
2.50.0


