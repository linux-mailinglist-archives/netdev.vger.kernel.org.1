Return-Path: <netdev+bounces-260358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOZKIh5LnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:54:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B27182937
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4E83039020
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22530C632;
	Tue, 24 Feb 2026 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDi+Eww/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C130BBBF
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916004; cv=none; b=lrApIDSwzFywpFs/ZgHGNV3jFoKcZkgse15wNGB2TMF6Kt/oHe736/6vXPbhMdYryxCdd4lbbQ3E8e47zJGWIkB/vTjb+rIfKwsMIBkl6IVgGn+vTXDWoRb2RLccYkTVlWBkIhV4MJHUzAI1rHdH0jjq9NStilbmVtkH6FU9URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916004; c=relaxed/simple;
	bh=otw/sidfsrVAXpxIAPSAHcc1JnUEwkQzo3iMewEEbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNM58rmzrJvPqqLFQdrkNhVfOHVF8MVkkDkr2rdDI7SAXwW+vxAmvtmhhcyzIdaTeZ+ozeVM1HbErntj9iaQDS6/5xvR5Y06NtPBz+S/Q13gTjbXLKMSbfX4Ej3xcPYz0r2OPyaqvHMYkFQdQiDLBfg3bGTCf9vjB7+YqdgJcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDi+Eww/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so6979313a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771916001; x=1772520801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coP60IDvUwENZ4G8REzPur6qzEmmqfojoUutShryN4c=;
        b=MDi+Eww/pw94u6xHqF0tz18BMsf7tuVhogQtdfWVLjch7+IYeLGrJ8xFbhvq4JGXcy
         8ERihOa5D+h/LePO9YzjvtR23MqXs6L7aPBmEaFkonhkHJxvFoP+7iPjNUiaK8lqqC+v
         eKiKIkxX5tqzyp3d8AN9ig1YQTnrKrrO8hXUcsYZ6ctjOoh1W7RBogCFAbdwqQETeGWf
         yfUHh0btuUYCxMKKyxwT7bPeufU1nP8rqs06A0fZf46TXNFZ7Cu5fbIqA9uGQPgq8TM2
         RhMB6Zxhztzf0LB9qb25JViHrQuB9wDI4HErh04oRbKYz8iCkEiuSRjYtXrv4qIw4QH/
         cLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771916001; x=1772520801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coP60IDvUwENZ4G8REzPur6qzEmmqfojoUutShryN4c=;
        b=hz3zmdSLbgm0nWX5nEJQp4Xd34ktMCtQJI/7sd+KMktkyDxbwQDT/QVoRPs0GLKInd
         v0btmoXI7YQfs8cOKEQG56GTD15RVNN5bbTh1hcZsfvOi0DycRFS/MkABztczU7pRllo
         LWU44Xv3WMNCZoEN5DfRffUb+zZdv5HknboHM5ejXc8COM6ad7y9JQTF4mW2iItBYCGs
         2GjSjR/zfhey2bVbje/jGtgIVcP6uTqQDFh+wMnX0cs7j37QBlKMNasy/8+TJ/jy/l/3
         kgR95HcvxveQ5SFJoultT4rj4qhne+AFfogBg/h4MHCTqSAK0h2FLaZt6tcvlPKhnj8K
         poSw==
X-Gm-Message-State: AOJu0YzqfO3bCOUY3HXX9m8mPSXbmc/rO7ugau3BBBNRIuG6KTRZ4JS2
	2XJnhqKfKWidu4rp/cPhlfsBhzuGEZjhjpAlFu1XpnDtZckW063ugY8m
X-Gm-Gg: ATEYQzwRb8gIbD3KhdJyNFznzt6jK7vZMmOcD2hFEVqWXpMkT+I3aOOXB0msUfyZ807
	ZSOJhOhhRE0Nqtr5NGJElqAHLEUn+hIWvKEDayZEdEIx5w12VgwTAICO5WFIsRqyacypySsHiHD
	R+dIkXNDvxGfP6a2Dlw+oSe95C0XNGs1sGO/LHQwvPTeX4hPUF8LRFRg7wuNVJmt1kA6ERI3q9/
	QLcEH5+n4iHB/CGA7dD9DjH6P6UdY8B8QwvYdJGZRH9sSUSRYnoE6qCFz4GkNoRvTMn4oEaHPwY
	pVgPtwRuW5g/FVHZJYkwoUNVroLXNUfeMX/xmtSve69C+VgS1nQW2wk/iEzYhx23Fg6s1pZ8LNG
	s/6hLg4r8PjGG0ucToonnqU2fnkYmYoziFnrL1d/d7opbVLZ/bO3tzp9E7b7AbMZl2YNBEPX0ZF
	MIkWcmu57S18xhTx0W5fMN7SjNRvljppiG+2ma1hDwbQ6K4IyQ+FUW2+FcAYbknBQl5++nlD3Bo
	XpRWH7Gcng8wh1BrURdpACLbI4jUEWeHO64ZZLoqEuBEAAg0gNTY2M=
X-Received: by 2002:a05:6402:50d2:b0:64b:58c0:a393 with SMTP id 4fb4d7f45d1cf-65ea4f07f63mr7024950a12.30.1771916001174;
        Mon, 23 Feb 2026 22:53:21 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:20 -0800 (PST)
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
Subject: [PATCH v19 nf-next 5/5] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue, 24 Feb 2026 07:53:06 +0100
Message-ID: <20260224065307.120768-6-ericwouds@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260358-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76B27182937
X-Rspamd-Action: no action

In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
and packets encapsulated in single 802.1q or 802.1ad.

When implementing the software bridge-fastpath and testing all possible
encapulations, there can be more encapsulations:

The packet could (also) be encapsulated in PPPoE, or the packet could be
encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
encapsulation.

nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
known from the conntrack-tuplehash. To access the header it uses
nft_thoff(), but for these packets it returns zero.

Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
offsets.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index d4d5eadaba9c..66ef30c60e56 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV6 */
 
 #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
+				  const struct nf_hook_state *state,
+				  __be16 *proto)
+{
+	nft_set_pktinfo(pkt, skb, state);
+
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph, _ph;
+
+		ph = skb_header_pointer(skb, 0, sizeof(_ph), &_ph);
+		if (!ph) {
+			*proto = 0;
+			return -1;
+		}
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr, _vhdr;
+
+		vhdr = skb_header_pointer(skb, 0, sizeof(_vhdr), &_vhdr);
+		if (!vhdr) {
+			*proto = 0;
+			return -1;
+		}
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int
 nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
+	__be16 proto;
+	int offset;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	proto = eth_hdr(skb)->h_proto;
+
+	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (proto) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt, 0);
+		nft_set_pktinfo_ipv4_validate(&pkt, offset);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt, 0);
+		nft_set_pktinfo_ipv6_validate(&pkt, offset);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
-- 
2.53.0


