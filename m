Return-Path: <netdev+bounces-283724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAeeCytO+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:43:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD14B9871
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A059D3020FD1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE0304BA3;
	Mon,  4 May 2026 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WeYFLsZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6E3033F7
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880540; cv=none; b=nt2wemP7y22SmyErLKOh5VGhsYCh37I9tzq4DNLHY19V7b/oERFCbQwnk480INs/H49hN8v7myDe0b5Fnm6WUbOyrlezIlMOY2JSNrZeIu7be1XWnMWl7tewDA0MdDUvE3y3Fed1giWquz2DDlVqnOh9GoCpoa54QTSDZwvOkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880540; c=relaxed/simple;
	bh=hHzDI6EMEZ3+srDe6h4vdcHCJcs8q+VRUhyZDMfJZv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8IwQiR2SUg3a2yBVNQylp7777f4ACZ3XKhkA5P1k+daLdQQLI44xb87U4OnDLJ+UjN2UdQyI4FLh66bH8g4hPDbuusj6Rf1W43pSiv9qYd8Mib6RfdQ3iDA+Y6in2OxOjoWx42KpjqzQKBlb8dBuuzNxLpqFr1DuW0D2MCvZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WeYFLsZN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso19029785e9.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880537; x=1778485337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNrn/1ULknS0mXajard4wubGCARfDXT/OU6gNTwLGDM=;
        b=WeYFLsZNLykqUHyRDgLBoibh9HFqW64z29hoVdecEZdhZ224ktKyvg0tM76GDA3JPp
         hUciyqHp6pD2rOdzI3hikSXeJJsDtZdjtg7qgfWMHOT5IiUM5sHs44+yRw+45Mecx4pB
         LLF6OcY0+uOFmrqztAM0RyulUwzZ4msCLP+DGJ7OjebDy4PZtWrH03YFghOOnRyfMsRW
         +a9FUhInnHPS9Dl59H214Lr/j7KAG77/fJu5SIq/EzswNYedqP9E3P7uHzcp6bjZ0LIV
         lvfwpjdd0LeUKqXclNOspQD670JQdWYW0syIP+cB76TMrzgyJ7a3Nvk4whsxLrGjd/2u
         HrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880537; x=1778485337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNrn/1ULknS0mXajard4wubGCARfDXT/OU6gNTwLGDM=;
        b=XUkW/V9USwX1yw+FofvGj6qQuCCok/BXhjKn8gUae3Pkv/oAW5bnS5uzYAKXTAXZQb
         S9M4WDJ8GDfvL6ORfO1BFWmyJt+Y78rH+QoseFTWtbx9AVfTiWsedy5DKjpvnLWf9kP+
         pK0N2qXvBEZW/OfdX4IJx/uWzRcPyTVI39wahg2Y/AFR9XcHEpshoLXMO7GeAzHZyuSq
         vUbeS4y7YhZEoV5CVg6VciIziYR8mkoSynLIwg3/mo4LwUynSTHQSyJRGLlekTHCHe1Y
         mvtGBKKncxoDAbbe1mXY2niB9N9ZW7vZkqgIXm50HHQL+q3Oh+BfBOXcASAxVoK75vcx
         aPIg==
X-Forwarded-Encrypted: i=1; AFNElJ8HU1mNhp1dW4M5gzR8FfOrWqHnQI0RFDVIRPp816KOMoMCsH+Dx0Yn5jXmWksNTPJyHKI+H3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7P8JLImrBn+q78R0GrIGlSDzywWr5IC5RY5sek/YW1Iri10U+
	T03dy1tjcGBe+gUWtGJGHGKeKixGTtEZcSBdckSMc9Abe5LEaAVmH0HjievP1RANesU=
X-Gm-Gg: AeBDieuNOeziDQDGL02Ldu47hiMY0EBJK3gyC/eLJS9lgHmbEWficYr+kapH4ZR9MxE
	9gIuzAm/ZfReiMJvKKGC+gCVMACeBocIzsGA6Ky3F2rZBlb+/o2TrXMBuxsZbaO+5cP5lluFC8N
	zW5Xyj19a8pfjqfOs5jxpIOVg38dSSyAoq0DFfcQY2Oji13twOj67Dv40zEYk8uUCXEuFbDKZpx
	xmhtnrbw1Jc9JW+pBNNg2D7zvG6uOy/hvXC8yBqZbWT0BvW4N6KASyb1Hfh/1aquppny5nZti0e
	f5NNNySPon5K+bUgo4SWShL7I3+OFqK5VrQ6IOkGWEEjABHscai/KMYWXbBCA82L0usp/vtnCat
	eeemY5UfN3UsyLZOD3KKCyhdoy9q4qHhhCGqwgsiQsYUWlFJUS6X2geF+7RqitfjD0Qquh8r3fK
	5c5q8HaDVp56olU9EOlsIurQKcf3ISiQby9oD9kcl3/7N5U7ITz0GD405OZPz6+BaRyv7ZfO9KX
	6E=
X-Received: by 2002:a05:600c:4342:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-48c6d455f69mr68414675e9.2.1777880537124;
        Mon, 04 May 2026 00:42:17 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe3cae3sm100998215e9.0.2026.05.04.00.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:42:16 -0700 (PDT)
Message-ID: <ed569c78-129b-4db4-8a73-e1728a6d5032@blackwall.org>
Date: Mon, 4 May 2026 10:42:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] bridge: Add port-level netlink handling for
 neigh_forward_grat
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-5-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-5-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9BAD14B9871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283724-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add netlink handlers for the port-level neigh_forward_grat option via
> IFLA_BRPORT_NEIGH_FORWARD_GRAT attribute.
> 
> The default value of OFF preserves existing behavior, i.e. gratuitous ARP
> and unsolicited NA are suppressed when neigh_suppress is enabled. Users can
> explicitly set it to ON to allow these packets through.
> 
> Example for enabling control via 'bridge link' command:
>   # bridge link set dev eth0 neigh_suppress on
>   # bridge link set dev eth0 neigh_forward_grat on
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_netlink.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 6fd5386a1d64..898326c201ef 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -190,6 +190,7 @@ static inline size_t br_port_info_size(void)
>   		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
>   		+ nla_total_size(1)	/* IFLA_BRPORT_MAB */
>   		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_VLAN_SUPPRESS */
> +		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_FORWARD_GRAT */
>   		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
>   		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
>   		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
> @@ -282,7 +283,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>   	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)) ||
>   	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)) ||
>   	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
> -		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)))
> +		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
> +		       !!(p->flags & BR_NEIGH_FORWARD_GRAT)))
>   		return -EMSGSIZE;
>   
>   	timerval = br_timer_value(&p->message_age_timer);
> @@ -902,6 +905,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
>   	[IFLA_BRPORT_MCAST_MAX_GROUPS] = { .type = NLA_U32 },
>   	[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS] = NLA_POLICY_MAX(NLA_U8, 1),
>   	[IFLA_BRPORT_BACKUP_NHID] = { .type = NLA_U32 },
> +	[IFLA_BRPORT_NEIGH_FORWARD_GRAT] = NLA_POLICY_MAX(NLA_U8, 1),
>   };
>   
>   /* Change the state of the port and notify spanning tree */
> @@ -970,6 +974,8 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
>   	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
>   	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
>   			 BR_NEIGH_VLAN_SUPPRESS);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
> +			 BR_NEIGH_FORWARD_GRAT);
>   
>   	if ((p->flags & BR_PORT_MAB) &&
>   	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


