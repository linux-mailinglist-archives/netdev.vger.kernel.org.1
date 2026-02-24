Return-Path: <netdev+bounces-260356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPzoDhBLnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:54:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56E182910
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAD6A3043975
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2E3093CF;
	Tue, 24 Feb 2026 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ+DoYCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78530BB8D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916000; cv=none; b=lpEPlfCGbsXHhgINuRymiZQxl/HEhzF7rgafwXAdPc1ggV05b5f57iT9u1Ao4Etqk8+1g7UA0qs2OtBZKGQ3idYP7Iu6GxDmYNdgFgTsR/+oow7D7SEXtAG6xhGUmuMNdBLHMbz66EcPasrGhFC9tYijZKMqv8zOp8C094rFvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916000; c=relaxed/simple;
	bh=MgqFP+kEIYkaJNFbJG3TL6RfVtetCetfNmpFyY7dGco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3QXmZCHIgx3GE+mbjGGDSry1ceca9fSh70ru27fDfkh1GJPA0293zT3LYzpNxX9/cyWMIEWM+g5zziv9LjxpxOzL0WRydFbwyI+2v+zrEkC2ENcveIahXkD+qFeBe0ev5s7ULdLs2hzHOccG7B6dMXeuCa1bb0gj0DxH9TcHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ+DoYCO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65807298140so7666521a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915998; x=1772520798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=CQ+DoYCOlzAgyFbGVpRPcmWRPkpG/RypGlbSy1ZnsweMdS0iyyr+wQN+APNNkdmGWL
         q4x0mbMEk7Vr31fJkhPTFnoEXFFayVNjMZb3NY3mjJh8ShoqmXbTMpYGePXeGd75rd7w
         ojHxNNYQgAlfNr+lyngy/Vm9DdHJYcZQugEltn8w973v+2KlUW8l1fRPypndPUPa8WXn
         R5y74s6Jv8uQ1QwbZu8xFPPNGsDToogEocprzBEJHcamaRg4shKGE+WesN/ZUktK55bA
         uwubQ5Mmb4+cZVt2TFzBj3JATGi7farJAgza564AZgtXPlHU5Fjauiv3KNoB2xrdfMmU
         gZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915998; x=1772520798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+3Us/40ma9gw7n/u08hiyPrq5670jVo0kM4Qwre1Os=;
        b=JawLf3IPB5Yyfpxmtz+FZICTG6+nyUf3VC85UNkZeUFVfsl4Yu1Pz4fzELD0/1KHua
         8P1lm6T5QkOSeYuwr7P9K0X+RSfE+c2GWOGi4pBS4zoqPipNiWl5OJH0oPDEtToiULef
         +4HE0wZPkenTgtafX9Y/lZt1JRxSImfsdCMdxm5KWb5ODwfzrXLUIK3ADVJMh8TQkLC2
         /99XUwB+0u4Xkhca0LYuBbxZE4ysWh+irM8C4b9kuW/B1zja4eW5tPvHOZN9f6vpYSmY
         Neg2mlpUdtzIPxIZ1nFe4SjoRJknD3f7zWAkZ61AjIa0bSN73Eu3e+4dHtgcb3qcUc37
         GCeA==
X-Gm-Message-State: AOJu0Yx8k4qYip7Me2pydCO/jrbpq3KSh+6nfIhHpVzEI7nQV9Ev8gy+
	gfCQ0uFOegsBI8E6Aw2WFcd7vWR3cGdqYLbuZwVps/tng7uqaOEBNBZ9
X-Gm-Gg: ATEYQzz4mrjAvAcJFGnEVubjXQ2QgYcheX5GOGh+iCWBcx2/BKGQsf3BporM5qny3Yi
	Z9J4mJiNha0UuMK6R3hcbgu0n8YUPOz4uitOeanl76C7IvPiPMPgEMLGJfe5ugDS/FcJmvVPPY4
	ctUhrLD0DIR8l3cIKpO/BPp503tYIaU1rDG5NWPSLc12SinU6vzQkllAbWUQCz2NH1UpmvcKbyR
	suoaPU50bGm3Xn4l32lPqr8AEekzuO8e5Dmhj48jQwm24CdKCw0sIY17uoxTxJ+kHvmIKmf/ntC
	ai6E6yxWFrvhuqW8yopYE5KCsP7PdOoWtiHeCvZ8uf9VQSLgbF9Z9nZymQ6vhREdTwdFxcjZytS
	gLsVUVsuEovUFDL4dV4M8DR5+Kz6EBCAyjHYy3Bl9J2z33G8E0wLdcc1d96E3BJC41ydTM0gVN2
	2Phv2xIdYkFWDAHvxTN5H2HcM17UijPZkVO9tximpNr5OTCnG13E+yYSB+52TjblqDmo3fpKX/9
	8NTFNTF1jbssuDhCDDDaAa6PpoDQ/hx3zMkJwWlv8QG5tuZ+JBZiRE=
X-Received: by 2002:a05:6402:440a:b0:65a:4202:640b with SMTP id 4fb4d7f45d1cf-65ea4ef5ff8mr6889632a12.19.1771915997684;
        Mon, 23 Feb 2026 22:53:17 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:16 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v19 nf-next 3/5] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue, 24 Feb 2026 07:53:04 +0100
Message-ID: <20260224065307.120768-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-1-ericwouds@gmail.com>
References: <20260224065307.120768-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DC56E182910
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


