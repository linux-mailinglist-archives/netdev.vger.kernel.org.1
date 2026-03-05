Return-Path: <netdev+bounces-264427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILF5MiuYqWm7AgEAu9opvQ
	(envelope-from <netdev+bounces-264427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28080213D88
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 302C832A05D7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D163A1A59;
	Thu,  5 Mar 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTThY1TT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdmoGwB3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAF39F167
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721259; cv=none; b=Mo3rUc8mJsPGkbUpGukEGDHA5+HEp2+kLv6XRius86CfWhvh2jCfH6HJMFZyxK/tz1WEM6R7KIo08iGz0TJ+TxvSzZeESuqiHZCXugKEmsr8SAQFMzptU5QCH4C/q2BWXqB4fTG/u6EBnasJ/B2E1YcTAG1jDQTgbpYcLhBXRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721259; c=relaxed/simple;
	bh=V96aM1UsEiTcg5S5KBCbJgOhJNdsi5qbQBjPUQwfksU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjTCrjH5Yv6/JbLyPFiKMIjzFQiqMRUnfB0HelaoZZ8fj3RTnQeHMuds2tEZVd4Y9KKyB4N1qNZYq4NvNrPrFANQhh/qLXdCpKw87z/FyNHTWrgXG9B1qEM1FmUfC+1Jw3eoeksr/oPpMzCpXuWbMdDAm0UwCF+z4gem2hoPK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTThY1TT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdmoGwB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772721256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSTv6fh3L9upW88q5siNNXN3YxjnKXJJObquMeHeDzA=;
	b=bTThY1TTT0A6PGoI8N+UBGJ9RFjaBzC51FW+5KTYo7Mh2JXYqEAk6Qk6E4deLhV8zQI7+9
	5Lkv7o69P4NGh+rRiWv4waMvC6/ZEBCQHMjrqjZ2Voz0bzqYJkv/Z0++ugO/YhZNnpjtg5
	+HtM/i9WvJ5MYwEgafyNPi8lf4pJBLA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-NAVcREyNMEmZt7nrXCWPNw-1; Thu, 05 Mar 2026 09:34:15 -0500
X-MC-Unique: NAVcREyNMEmZt7nrXCWPNw-1
X-Mimecast-MFC-AGG-ID: NAVcREyNMEmZt7nrXCWPNw_1772721255
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b7903f3so107372355e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772721254; x=1773326054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSTv6fh3L9upW88q5siNNXN3YxjnKXJJObquMeHeDzA=;
        b=DdmoGwB3YGcby1sGiS1TEY+4KJTL5ZslRsYj13nWrzdHYAk1DjwBeGR860SZi8ffJM
         67b/+DYyd+1XGrFFHK9eWZMDg/QahQCLpxlNstF7sWU2UGp8BLerk2Q1mJgUnsq2IiBs
         eGoy86u7ZkhbqZ3FiJRJkAIVcobQ+/VR2icdGFtPWJV9gjKbX0SzPZlMfrzu8R075FVK
         G3RwGo5PwaX1xu9I6Gfxt2/T4S6IibIzQ90ystohyi0dtBVlkqeM8WFDqpc89V6oajfV
         H4zJusFmuCBHJSUEFpaWL4s2BWda+o08nmhk++jOybF065aOKgR8gDwOg7PxogAQxK3t
         j/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721254; x=1773326054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSTv6fh3L9upW88q5siNNXN3YxjnKXJJObquMeHeDzA=;
        b=Ungn8cPMb0zedcdXlRsk7j0Whh7Om0/IYs0wEv71Y95MYMsyQxoe0y/DofbNJBg4of
         UfVLYX7FGYhndXsq7cc8tB2addiY1IgRxec07qzafke0zjPCZhptA2SVZrQm/sWKn5P9
         KI2YX3BqjIefGfQl+SPKMB60L0XECF98Y7ONkYVTRosuzi7OXAgba26sTIQ5hCUZ3HWX
         J3rs7oTx7KUM/6fVoaoLj+RWfi37lXWLAN1Ccts0WYtPmUOdxzP8v3FajuXTeS7dsEpl
         usETFDhHsB9KnTK5R9c7/FlNwrAVxf6ypQFzZOjLJBNFpsy+Wr/kAwC+mMB1aHb963Oz
         0d3A==
X-Forwarded-Encrypted: i=1; AJvYcCXJqdk2+kvQ+LDK73kXh1mcnIN8XnvQ1a/qLqZBnGcsLuCe7Bk0ddj50WJOlryG5hePQCD0KAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWanCqQEcg+WoNcNZX4ckguLNMqCW9sMxa5YjGRWkKfMzw02Q
	K+4BgbzTjG0Zvx6wy0GorIC0OcVHOzGzK/jgS/d9h8Bva/M7IyTfq3NR1TZ/rsFvKEk8gPLr1K8
	bSeAs1I9knQC9dDE0f93fCtz5/b1OfW+Aii7SeER/uryktcDxygixODmJwdsYHBnYQQ==
X-Gm-Gg: ATEYQzxmgi0J7s0fkNYYa/tQJGv1RsqS3wwVa6Ff8/VpkCnMpX1J1g8a0oKJ7ckiuDw
	3l5o1AhZXK+7BtIu5SkMzOKzjXOVNdTmBlWouvlNJ5uiS8yVax8NdGO/oPAwEkO/yancOuqPBaY
	IvAt1HyPNFUZ2kDtF0u6I8Pf/Gss3GJ63TRKCXj7rC1PuNESTNAoO2jm08RKkgVr1sjeMjt/QlJ
	Zq3MH4XuXNt4+5205knaEWygZIk/sScxCYlfXj9mSJ3ZNo/SLk/hGQ58333EixrDDaTc35SE2u2
	DFYqgzWFrPmbaNpgXloUK5+ksUuX+UI3IK6WZlGMfAK/T3ih2iLWmqkt56jpy4rCXqbPG3/dRah
	Gy3C8oeDM4GiBd4L3ejW4jVX00g==
X-Received: by 2002:a05:600c:6992:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-4851985764fmr108356505e9.14.1772721254208;
        Thu, 05 Mar 2026 06:34:14 -0800 (PST)
X-Received: by 2002:a05:600c:6992:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-4851985764fmr108355885e9.14.1772721253690;
        Thu, 05 Mar 2026 06:34:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae00absm42747825e9.4.2026.03.05.06.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:34:13 -0800 (PST)
Message-ID: <a8a81818-459f-4c09-8448-31a191f7b2bb@redhat.com>
Date: Thu, 5 Mar 2026 15:34:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: add xmit recursion limit to tunnel drivers
To: bestswngs@gmail.com, security@kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xmei5@asu.edu
References: <20260303164326.1803916-2-bestswngs@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260303164326.1803916-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28080213D88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264427-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Action: no action

On 3/3/26 5:43 PM, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> __dev_queue_xmit() has two transmit code paths depending on whether the
> device has a qdisc attached:
> 
>  1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
>  2. No-qdisc path: calls dev_hard_start_xmit() directly
> 
> Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
> recursion protection to the no-qdisc path via dev_xmit_recursion()
> check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
> path performs no recursion depth checking at all.
> 
> This allows unbounded recursion through qdisc-attached devices. For
> example, a bond interface in broadcast mode with gretap slaves whose
> remote endpoints route back through the bond creates an infinite
> transmit loop that exhausts the kernel stack:
> 
>  BUG: KASAN: stack-out-of-bounds in blake2s.constprop.0+0xe7/0x160
>  Write of size 32 at addr ffff88810033fed0 by task kworker/0:1/11
>  Workqueue: mld mld_ifc_work
>  Call Trace:
>   <TASK>
>   __build_flow_key.constprop.0 (net/ipv4/route.c:515)
>   ip_rt_update_pmtu (net/ipv4/route.c:1073)
>   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:84)
>   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
>   gre_tap_xmit (net/ipv4/ip_gre.c:779)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   sch_direct_xmit (net/sched/sch_generic.c:347)
>   __dev_queue_xmit (net/core/dev.c:4802)
>   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
>   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
>   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   __dev_queue_xmit (net/core/dev.c:4841)
>   ip_finish_output2 (net/ipv4/ip_output.c:237)
>   ip_output (net/ipv4/ip_output.c:438)
>   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
>   gre_tap_xmit (net/ipv4/ip_gre.c:779)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   sch_direct_xmit (net/sched/sch_generic.c:347)
>   __dev_queue_xmit (net/core/dev.c:4802)
>   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
>   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
>   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   __dev_queue_xmit (net/core/dev.c:4841)
>   ip_finish_output2 (net/ipv4/ip_output.c:237)
>   ip_output (net/ipv4/ip_output.c:438)
>   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
>   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
>   gre_tap_xmit (net/ipv4/ip_gre.c:779)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   sch_direct_xmit (net/sched/sch_generic.c:347)
>   __dev_queue_xmit (net/core/dev.c:4802)
>   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
>   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
>   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   __dev_queue_xmit (net/core/dev.c:4841)
>   mld_sendpack
>   mld_ifc_work
>   process_one_work
>   worker_thread
>   </TASK>
> 
> Rather than adding an expensive recursion check to the common qdisc
> fast path, add recursion detection directly in tunnel drivers where
> route lookups can create these loops, as suggested by Eric Dumazet.
> 
> Use a lower limit (IP_TUNNEL_RECURSION_LIMIT=4) than XMIT_RECURSION_LIMIT
> (8) because each tunnel recursion level involves route lookups and full
> IP output processing, consuming significantly more stack per level.
> 
> Move dev_xmit_recursion helpers from the private net/core/dev.h header
> to the public include/linux/netdevice.h so tunnel drivers can use them.
> 
> Fixes: 745e20f1b626 ("net: add a recursion limit in xmit path")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
>   - Move recursion check from qdisc path to tunnel drivers (Eric Dumazet)
>   - Add IPv6 tunnel (ip6_tunnel) coverage
>   - Use lower recursion limit (4) for tunnel-specific stack consumption
> 
>  include/linux/netdevice.h | 32 ++++++++++++++++++++++++++++++++
>  include/net/ip_tunnels.h  |  7 +++++++
>  net/core/dev.h            | 34 ----------------------------------
>  net/ipv4/ip_tunnel.c      | 10 ++++++++++
>  net/ipv6/ip6_tunnel.c     | 10 ++++++++++
>  5 files changed, 59 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d4e6e00bb90a..1a4d2542dbab 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3576,17 +3576,49 @@ struct page_pool_bh {
>  };
>  DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
>  
> +#define XMIT_RECURSION_LIMIT	8
> +
>  #ifndef CONFIG_PREEMPT_RT
>  static inline int dev_recursion_level(void)
>  {
>  	return this_cpu_read(softnet_data.xmit.recursion);
>  }
> +
> +static inline bool dev_xmit_recursion(void)
> +{
> +	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
> +			XMIT_RECURSION_LIMIT);
> +}
> +
> +static inline void dev_xmit_recursion_inc(void)
> +{
> +	__this_cpu_inc(softnet_data.xmit.recursion);
> +}
> +
> +static inline void dev_xmit_recursion_dec(void)
> +{
> +	__this_cpu_dec(softnet_data.xmit.recursion);
> +}
>  #else
>  static inline int dev_recursion_level(void)
>  {
>  	return current->net_xmit.recursion;
>  }
>  
> +static inline bool dev_xmit_recursion(void)
> +{
> +	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
> +}
> +
> +static inline void dev_xmit_recursion_inc(void)
> +{
> +	current->net_xmit.recursion++;
> +}
> +
> +static inline void dev_xmit_recursion_dec(void)
> +{
> +	current->net_xmit.recursion--;
> +}
>  #endif
>  
>  void __netif_schedule(struct Qdisc *q);
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 4021e6a73e32..80662f812080 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -27,6 +27,13 @@
>  #include <net/ip6_route.h>
>  #endif
>  
> +/* Recursion limit for tunnel xmit to detect routing loops.
> + * Unlike XMIT_RECURSION_LIMIT (8) used in the no-qdisc path, tunnel
> + * recursion involves route lookups and full IP output, consuming much
> + * more stack per level, so a lower limit is needed.
> + */
> +#define IP_TUNNEL_RECURSION_LIMIT	4
> +
>  /* Keep error state on tunnel for 30 sec */
>  #define IPTUNNEL_ERR_TIMEO	(30*HZ)
>  
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 98793a738f43..ec974b3c42d9 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -366,40 +366,6 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
>  
>  void kick_defer_list_purge(unsigned int cpu);
>  
> -#define XMIT_RECURSION_LIMIT	8
> -
> -#ifndef CONFIG_PREEMPT_RT
> -static inline bool dev_xmit_recursion(void)
> -{
> -	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
> -			XMIT_RECURSION_LIMIT);
> -}
> -
> -static inline void dev_xmit_recursion_inc(void)
> -{
> -	__this_cpu_inc(softnet_data.xmit.recursion);
> -}
> -
> -static inline void dev_xmit_recursion_dec(void)
> -{
> -	__this_cpu_dec(softnet_data.xmit.recursion);
> -}
> -#else
> -static inline bool dev_xmit_recursion(void)
> -{
> -	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
> -}
> -
> -static inline void dev_xmit_recursion_inc(void)
> -{
> -	current->net_xmit.recursion++;
> -}
> -
> -static inline void dev_xmit_recursion_dec(void)
> -{
> -	current->net_xmit.recursion--;
> -}
> -#endif
>  
>  int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg,
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 50d0f5fe4e4c..39822e845a06 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -683,6 +683,14 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  	__be32 dst;
>  	__be16 df;
>  
> +	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> +		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> +				     dev->name);
> +		DEV_STATS_INC(dev, tx_errors);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>  	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
>  	connected = (tunnel->parms.iph.daddr != 0);
>  	payload_protocol = skb_protocol(skb, true);
> @@ -842,8 +850,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  	ip_tunnel_adj_headroom(dev, max_headroom);
>  
> +	dev_xmit_recursion_inc();
>  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
>  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);

I think this check should go in iptunnel_xmit(), or UDP tunnels will
remain unprotected.

Same thing for the IPv6 case.

> +	dev_xmit_recursion_dec();
>  	return;
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 4c29aa94e86e..55bedd5cd656 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1101,6 +1101,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	u8 hop_limit;
>  	int err = -1;
>  
> +	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> +		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> +				     dev->name);
> +		DEV_STATS_INC(dev, tx_errors);
> +		kfree_skb(skb);
> +		return -1;

I think an standard error code is expected here. Possibly -ELOOP?

/P


