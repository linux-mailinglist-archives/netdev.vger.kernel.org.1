Return-Path: <netdev+bounces-302880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ORm0KKUbQ2rgQgoAu9opvQ
	(envelope-from <netdev+bounces-302880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:28:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B36DF990
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:28:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YJbV8DBa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302880-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302880-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A9AD30205E1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E226E6F2;
	Tue, 30 Jun 2026 01:28:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAD36606E;
	Tue, 30 Jun 2026 01:27:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782882; cv=none; b=HFrahKCK01GOPitdPHkffhxnXzwV9jZsP4DQrrJesuL2imEIf7wXMYF+o+920zeEg5fe0iAQstuqr4K0eZXUcZ65ueDEuUkTLXtf8gtwDXTwdajbkb2qcH96vRoumRiEqpDxhwQPUg19heL+ieSF0j7sllJ7jAUmZ22urLcODMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782882; c=relaxed/simple;
	bh=n0Q03oMq1VcCfXhvekl565SOJz1b0o770JUf5Z4i55s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf/5d4DyPc72Amaber48WxKQFdhTdOC+/WogOV2xznegnS8bg+DQ9ABx4pE5kfOEvNBmDRQhiJtbSUvhyfZXdIkM9YrPygR1nRtxkEXFfmaCkAszWfBnyahvaSMIsXHqE1gkz4/EL8x5s89W3RG53nUIqGW29qEhEa+iiPGK6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJbV8DBa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404DC1F00A3D;
	Tue, 30 Jun 2026 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782782871;
	bh=yVETr4XUokXJ1cJuqH/TtHYGeREA5Y23TNC11MMLh2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJbV8DBaa2iFO9gO3CBTPk3AzNZ+no+M7bXydY20ZCTMmH6x7qXcCiQe3F5kgLaT4
	 niuhezgbycoSXPVzJLA4d26BkGAKmdZQTVyGFJZMd3LYi3Uok76gWu+xKCegAV/W8G
	 FxLRk9ztgLhtIXMQ7sa3FTmQJR15Zza52CqBxE/TPx1BVyZjz8rL8txgZyybZ0iYlK
	 x9zti9Y5tNboITlEs6jKKeh8ByWpqwwK70/ZTAxcV0EtROEC9nQTrAw+cFRTYZXMUO
	 jvwG9FlVtZ16O/4nz+fhiIjAMHs6r+AgDyRSOl1jrQNSM0w3uXVMZOVVy0AYeLJLHh
	 8GF129SZfpT9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.bommarito@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] amt: don't read the IP header from a reallocated skb head
Date: Mon, 29 Jun 2026 18:25:15 -0700
Message-ID: <20260630012514.2305633-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626111917.802243-1-michael.bommarito@gmail.com>
References: <20260626111917.802243-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302880-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:kuba@kernel.org,m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 190B36DF990

This is an AI-generated review of your patch. The human sending this
says: "Sashiko points out more, let's fix them all cause the approach
of making a copy is fairy unusual, IDK if it will work for all headers."
---
amt: don't read the IP header from a reallocated skb head

This commit fixes several use-after-free bugs in AMT receive paths by
caching the source address before calling pskb_may_pull() or similar
helpers. It notes that pskb_may_pull() can reallocate the skb head,
making cached pointers like ip_hdr() dangling.

> The sibling handlers that re-derive ip_hdr() after the pull
> (amt_multicast_data_handler(), amt_membership_query_handler()) and
> the handlers that read the source address with no intervening pull
> (amt_discovery_handler(), amt_request_handler(), the IGMPv2/MLDv1
> report and leave handlers) are not affected.

[Severity: Critical]
This isn't a bug introduced by this patch, but the commit message states
that amt_multicast_data_handler() and amt_membership_query_handler() are
not affected.

Looking at amt_multicast_data_handler(), while ip_hdr() is re-derived,
the eth pointer is cached before calling pskb_may_pull():

amt_multicast_data_handler() {
    ...
    eth = eth_hdr(skb);

    if (!pskb_may_pull(skb, sizeof(*iph)))
        return true;

    iph = ip_hdr(skb);
    if (iph->version == 4) {
        ...
        eth->h_proto = htons(ETH_P_IP);
        ip_eth_mc_map(iph->daddr, eth->h_dest);
    }
}

Does this result in a use-after-free write if pskb_may_pull() reallocates
the skb head and frees the old buffer?

[Severity: Critical]
This isn't a bug introduced by this patch, but a similar issue exists in
amt_membership_query_handler(). The pointers amtmq, oeth, eth, and iph
are cached before calling pskb_may_pull().

If pskb_may_pull() reallocates the skb head, do these pointers become
dangling, causing use-after-free reads and writes when the function later
accesses amtmq->response_mac, iph->daddr, and modifies eth->h_proto?

[Severity: High]
This isn't a bug introduced by this patch, but in amt_multicast_data_handler(),
the code directly modifies the skb headroom by writing to eth->h_proto and
eth->h_dest.

Since the ethernet header overlays the pulled outer headers, this writes
directly into the skb's underlying data buffer. If the received skb is cloned
(for example, via tcpdump), does this corrupt the packet data seen by other
consumers since skb_unshare() or skb_cow_head() is not called?

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 724a8163a5142..7094bdab0f463 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -2000,13 +2000,15 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
>  	struct igmpv3_report *ihrv3 = igmpv3_report_hdr(skb);
>  	int len = skb_transport_offset(skb) + sizeof(*ihrv3);
>  	void *zero_grec = (void *)&igmpv3_zero_grec;
>  	struct amt_group_node *gnode;
>  	union amt_addr group, host;
>  	struct igmpv3_grec *grec;
> +	__be32 saddr;
>  	u16 nsrcs;
>  	int i;
>  
> +	saddr = ip_hdr(skb)->saddr;
> +
>  	for (i = 0; i < ntohs(ihrv3->ngrec); i++) {
>  		len += sizeof(*grec);
>  		if (!ip_mc_may_pull(skb, len))

[Severity: Critical]
This isn't a bug introduced by this patch, but since ip_mc_may_pull() can
reallocate the skb head, does evaluating ihrv3->ngrec in the loop condition
result in a use-after-free on the next iteration?

Additionally, grec is assigned inside the loop, followed immediately by
another ip_mc_may_pull() call. If this second pull reallocates the head,
does grec become dangling before grec->grec_mca and grec->grec_type are
accessed?

[ ... ]

> @@ -2162,13 +2164,15 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
>  	struct mld2_report *mld2r = (struct mld2_report *)icmp6_hdr(skb);
>  	int len = skb_transport_offset(skb) + sizeof(*mld2r);
>  	void *zero_grec = (void *)&mldv2_zero_grec;
>  	struct amt_group_node *gnode;
>  	union amt_addr group, host;
>  	struct mld2_grec *grec;
> +	struct in6_addr saddr;
>  	u16 nsrcs;
>  	int i;
>  
> +	saddr = ipv6_hdr(skb)->saddr;
> +
>  	for (i = 0; i < ntohs(mld2r->mld2r_ngrec); i++) {
>  		len += sizeof(*grec);
>  		if (!ipv6_mc_may_pull(skb, len))

[Severity: Critical]
This isn't a bug introduced by this patch, but similarly, does evaluating
mld2r->mld2r_ngrec in this loop condition cause a use-after-free if
ipv6_mc_may_pull() reallocates the skb head?

[ ... ]

> @@ -2455,8 +2459,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
>  	struct ethhdr *eth;
>  	struct iphdr *iph;
>  	int len, hdr_size;
> +	__be32 saddr;
>  
>  	iph = ip_hdr(skb);
> +	saddr = iph->saddr;
>  
>  	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
>  	if (!pskb_may_pull(skb, hdr_size))

[Severity: Critical]
This isn't a bug introduced by this patch, but iph is cached here and used
later in the function to read iph->daddr:

amt_update_handler() {
    ...
    iph = ip_hdr(skb);
    if (iph->version == 4) {
        if (ip_mc_check_igmp(skb)) { ... }

        spin_lock_bh(&tunnel->lock);
        amt_igmp_report_handler(amt, skb, tunnel);
        spin_unlock_bh(&tunnel->lock);

        ...
        ip_eth_mc_map(iph->daddr, eth->h_dest);
    }
}

Both ip_mc_check_igmp() and amt_igmp_report_handler() can internally invoke
pskb_may_pull() or similar helpers. Does this cause a use-after-free read
of iph->daddr if the skb head is reallocated?

A similar pattern appears to exist in amt_dev_xmit() where iph->daddr is
read after ip_mc_check_igmp().

[Severity: High]
This isn't a bug introduced by this patch, but similar to the issue in
amt_multicast_data_handler(), amt_update_handler() directly modifies the
skb headroom:

amt_update_handler() {
    ...
    eth->h_proto = htons(ETH_P_IP);
    ip_eth_mc_map(iph->daddr, eth->h_dest);
}

Does this modify shared skb data without unsharing, potentially causing
silent data corruption if the skb is cloned?
-- 
pw-bot: cr

