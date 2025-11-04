Return-Path: <netdev+bounces-235513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244EFC31B5B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CD2425BC2
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F153314D2;
	Tue,  4 Nov 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enDtNJyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E932F760
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268301; cv=none; b=aOl2k4D+yNPFpCP0Gs+fpMACrfeMQ1bb1AFLt3BNHbDo7vBiQal9InvKu01+nO/OKsJklRBVgrN5VM+x/ZVO31PUyiJv5v2bwno/LjvS5kQd4nNWbwB7sTAsIgB9IFwMd4/uHmpkY0vO3BXQ36WoORu8A/XePMDZPVg5EvzhgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268301; c=relaxed/simple;
	bh=NfMwE8dlBybLdyHrMU5tp+2O3dmiRVolCqKrdaLCBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc97aH+b9nA/AGPJLeQZh2gxc7ry1647Ue1SPgGNlNTyKET3BRVGWMh54J9B5EK8VJDyG+VpHbm/Rvw0L32JhDGfATm28+z67dDpSZuMTA4CPuUC4P291W+oWaYVVMJJ0iuD/mVH3F4yFTfpQ8iOXWixOM7cdRjpxC60LVv3HSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enDtNJyo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7155207964so377363866b.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 06:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268296; x=1762873096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS4vmMYkkCMh57/80KWcAsjRY0+LD1ZQh8tlkeNEwTE=;
        b=enDtNJyo6gd2xWxdoMQynXypH05rX5ToadiKZJuvDN/2NOI/l/LFmIy2K8x08X+qlD
         V1CX3kPT5IrYmI1dqQgidtC21BI19SaT1Z1UjUDNWY8tIovDYU+L2Z1M0+GykTVwbQMh
         l2f/axRUdbbOWEkh9okqtKng42gegmxPwYzQZemTQtI0kHrxfLgXozntLDMRVmA0oNQ7
         M1ogIzPxYe39Kkaj0DVFV2OJUbVwYpfZuQnre4eFwm17rVdu5EebJ5QGqWdBD+pW9A3g
         ADWTvNDU9MQ0dnp+14RxvE5sHS2Qrmh9gSmlPg0U2ht97GjIGuJywIjrz9F3R5iPwmyp
         LuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268296; x=1762873096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS4vmMYkkCMh57/80KWcAsjRY0+LD1ZQh8tlkeNEwTE=;
        b=P3wltKqHyB7NvPjFvV9s7DIdWeKnZxNlTsJfPvpoNujmPCzFgNXOeq0BmD8JnVfiFI
         Sw29L7QXiS1nnRjaYkwf9/wP0dN0kb3Zp7tbq892PogfqPL5zWZI2EK+oGnyd+A6tBEm
         ao4UdSMF3CnMtfjSSMAcwISngmlYRQXLYuyKukb/3BojKWqJJwpUTfvFr2Y8qpjmBC+r
         VumVPXsxtR5GMh589sJj4KUFEJS5IDhX95Yk5q7Nf6grT3d5Lg6BdBWvbQVtQOzsTfJE
         L3fx3mUgBBHuoJtNNUpNvXsT3kZp8bRXueWqCz/rE/Y9F/Y9r78+rllk47zqK0+VBHlx
         QriA==
X-Forwarded-Encrypted: i=1; AJvYcCVkPcUt+WdIGLNHKhUbiQFmqT5kt6DBR3ZFJ/nj2uDpNszTdYMFso5NeZlYW0K4+2cjoXeADdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wV6CXjAVIM12QyAvBxTZ8EQuuvfvDEPV3jxa6u3qDS8nhNNw
	Nr3CStM7DJ6tCaJxbiEITdbvuAZiF2IFX6c27UwwtG7fx5pwjnpyckiL
X-Gm-Gg: ASbGncs2sFLF7SuUi5LNrrpkCDF9+8wCl7U1SVdvy8j+m1ty3Ji03q2Btax5aDhu+HH
	ycR2++vmmiGC2PMV3mTMq0LPfiPRyJ03Wo3w54qSBiHfp+diuGgKKzcPPxvnk07eebpaBwafWxB
	Gl8L8X2kSeK3y+GskHMjVoUctYRXQZrY8hG2R5n2t7Vkd8ZnbKF/tDpBr/mvmwCQqaBNkJcFsjH
	IFLtpFRNrkn7JUxUm+LMBkfVhGxZFfTLxJqfx+7xIjBUoZG+EWj05Tjgl0iedBEQqbhkECI6qmL
	VqsnhAkS7tZ/XTYXl3Xa5lCpidTX0Vxq4S2LyFX7T60WMu4XBqhEX+ObYShhQGYgXizlzSUTgKk
	Tkiz998HxLTvBjtRetBTmMLqXSEXJqGvy9eX2ul80tHMblqi8EH6nXp3YOaKMzmlRww0UlkVRfK
	y/eZaX2sbB4sQhbzSHQxG2bFOS/RAVXAf6VG/sQc8FgCg4IUKcZ8ir379galzVqEmySyFQQAo=
X-Google-Smtp-Source: AGHT+IEzyqLNCwkiIEcsmd4yqk6UOJ2lkQsHu2qKvUmx/if9TQ0V8rUE84bH+QRg7d80a1B6xxzGPg==
X-Received: by 2002:a17:906:6051:b0:b70:8519:44a3 with SMTP id a640c23a62f3a-b7085195e4amr1116437366b.21.1762268295938;
        Tue, 04 Nov 2025 06:58:15 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm232681666b.46.2025.11.04.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:15 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v16 nf-next 2/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue,  4 Nov 2025 15:57:27 +0100
Message-ID: <20251104145728.517197-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251104145728.517197-1-ericwouds@gmail.com>
References: <20251104145728.517197-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..39e844b3d3c4 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -237,58 +237,116 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
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


