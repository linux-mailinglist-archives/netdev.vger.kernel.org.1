Return-Path: <netdev+bounces-247454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F8ACFAD91
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0604A302BA52
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0B2DF151;
	Tue,  6 Jan 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpx2AwBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617942D1936
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729313; cv=none; b=KsbLumgWE04RNmy83TezUkcFURLZS5YvohjH8qJ8x2Hwar7RshcFhYv585Uc/o2CNTMUdGL6cOC9rifdYy6uwBBUnpbq700qBUV4kZV8u2RXDtZy/vC98KvI2O68kPRSqjgLsIgQTq8g3dwTkpUBLi2WbLP5qwASKv/e54GWPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729313; c=relaxed/simple;
	bh=ezRQarOjjBM21zauRZItcnGzBQWgx/j7g7YBZfAhrFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLa9yi12fgOSeAT2jIflJI5Xq1rtzNDADU/wuaGdS7GOoNi0w6dDESNi4XnoKhka/TCFr2qKHDkSJihU0cn4xSgSaeVCDHqG5Fxm2RPEfUFyOSj+kJecbY70dYMD7iWQc45L7iuZ73HfjWWGTba7VJAwutlXQ0pJA+wpOS4NwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpx2AwBw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so2178074a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767729310; x=1768334110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmSo9DVOGxS+EqfPBwMvHqn9WrIYsrAaibtCJtd/X8c=;
        b=kpx2AwBwqmt402iWht+jAPHIOEBlGQ/Go+EXWvSs5dk42obdR8Hztd2zlKIrJzKQx5
         fp5gWD5xjViZoTX+gg3Zqj9JUMOZg/v4g7n7X4Nbq8n0c0A70ohxm9GuAXmeftI3Hsft
         zOLPcVAHN0D38x++HVtF2tFj1lWVDKYml+VJycdA7ZM3VLaR9csZbqaqJqoHvP9wu59Y
         Wp35a0KQtmVR9XPTSJsVY6oHGt12QGk8fsQeC7VbXTc+12RQXAiNNzbZdQcKNIZwWstS
         sb/99L0dvplQw4+PFleU3/saPlHf8cU5HpeAmwuxFm67n9LmgqaB45IhJgVhqtoO0gKD
         iJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767729310; x=1768334110;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmSo9DVOGxS+EqfPBwMvHqn9WrIYsrAaibtCJtd/X8c=;
        b=Ty9Sigh/LcgCqYRMUB6hbihWvS+EiwmBI3kwsZDXv4msfjC/a8UxH87WUjI7YBvw4t
         D6OkVu+8uhjoCXrShrwkHIHulexxJYhJN/55+n0MaL5cSL5+kryk3c83WXsgfEXrPeTi
         rVvN/j7E0Km8eVPvOQ1N+/wzUKeQCbLCxNoAioZtpg+YYQGdFHoXKVUDloGhACv9Bp4l
         KHxv/YlQZszjYqrQt1qoyrNKIFt5R/BcaSuKvVnzstYSBzCXlOaMxPLRXeBmrpZQIy1t
         jogqmj4bS6DrGXR+b87UOYRuKZ4eOAWgrFsSgwODHT5N17bz4J14ZGVxOk8wTc4MfmpY
         e8nw==
X-Forwarded-Encrypted: i=1; AJvYcCWfzwf61XZElEI48EJYXzTlrspHkoYxKOOkV+9Ff6smNVlpT20L8nafj7l0Pqtu9fS6u+L648M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43P0OEEE8SvRRhwAdrQXBacZfUgaRIbtimcItSaWr815S0/ew
	fnxu1ZxbMSFsK902p8PGhmdO8x8pzMbRB9/Kh+S4dbnCnow1966HtUkF
X-Gm-Gg: AY/fxX6gn3/ama4HqGk2joplholkyb94Dlv7N3ZHWf3VhLLVfX8byzTVci5pGZOGW/D
	jORAtAviifHUe0Y9SiohhlmKVsLcRouOTMm2G6v/5/TGTu0j+JSxk4iVeur5cKahRtLGhxf3n7Z
	72hqD1HCm9f9U+f0wG+9Ghs5mtGNdVZ0ecEjD+DgC+mUYO0e+U8d69+wl5Ye84yztGQherO+x8q
	T2XFvuXUD/TvXo9GvCz6b7FJIQ/S4xmhXdEPxfDVAi1cWOM+c3m7O/MJUcM9fpLv1q+l6JLKOe+
	EOwNwVIpPG9lFxsXA1EjI2HojB1xwdSiJa1XyyyqXlvjcNGv37uIWkrMMPOouP0R0Jwfw1ZAwaj
	0cjssnSbMDkmFYC+k3MMRhkZlyTU+IV6h0fQfLxrac1I2vi6HzrPBmI1B+urnhvjnB+D/R7LzmN
	Ow75wQLU8Dp96UUKSP9EaYrtUAsLP93RmZ+3S63+uN6yl7IWzgHssY/DGO3T+vkHB7ZT0/yVcj1
	g+lNMdz2OIdrNssqIca42022ayMVgEMEJifk/pofahNGMLXcoenvoOjB4Xb4kDdQQ==
X-Google-Smtp-Source: AGHT+IGFE95wEtpfFwtjTiCcDiqd/x/VRp77b5we3rDpWf3zlfvwo6wItKcd0BaEkVYOWNXABbIVMg==
X-Received: by 2002:a05:6402:42c4:b0:64b:7b73:7d50 with SMTP id 4fb4d7f45d1cf-65097de8202mr162574a12.1.1767729309560;
        Tue, 06 Jan 2026 11:55:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4454sm2902324a12.3.2026.01.06.11.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:55:09 -0800 (PST)
Message-ID: <6d77bdc4-a385-43bf-a8a5-6787f99d2b7d@gmail.com>
Date: Tue, 6 Jan 2026 20:55:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 nf-next 0/4] conntrack: bridge: add double vlan, pppoe
 and pppoe-in-q
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Phil Sutter <phil@nwl.cc>, Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jozsef Kadlecsik <kadlec@netfilter.org>
References: <20251109192427.617142-1-ericwouds@gmail.com>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/25 8:24 PM, Eric Woudstra wrote:
> Conntrack bridge only tracks untagged and 802.1q.
> 
> To make the bridge-fastpath experience more similar to the
> forward-fastpath experience, introduce patches for double vlan,
> pppoe and pppoe-in-q tagged packets to bridge conntrack and to
> bridge filter chain.
> 
> Changes in v17:
> 
> - Add patch for nft_set_pktinfo_ipv4/6_validate() adding nhoff argument.
> - Stopped using skb_set_network_header() in nft_set_bridge_pktinfo,
>    using the new offset for nft_set_pktinfo_ipv4/6_validate instead.
> - When pskb_may_pull() fails in nft_set_bridge_pktinfo() set proto to 0,
>    resulting in pktinfo unspecified.
> 
> Changes in v16:
> 
> - Changed nft_chain_filter patch: Only help populating pktinfo offsets,
>    call nft_do_chain() with original network_offset.
> - Changed commit messages.
> - Removed kernel-doc comments.
> 
> Changes in v15:
> 
> - Do not munge skb->protocol.
> - Introduce nft_set_bridge_pktinfo() helper.
> - Introduce nf_ct_bridge_pre_inner() helper.
> - nf_ct_bridge_pre(): Don't trim on ph->hdr.length, only compare to what
>    ip header claims and return NF_ACCEPT if it does not match.
> - nf_ct_bridge_pre(): Renamed u32 data_len to pppoe_len.
> - nf_ct_bridge_pre(): Reset network_header only when ret == NF_ACCEPT.
> - nf_checksum(_partial)(): Use of skb_network_offset().
> - nf_checksum(_partial)(): Use 'if (WARN_ON()) return 0' instead.
> - nf_checksum(_partial)(): Added comments
> 
> Changes in v14:
> 
> - nf_checksum(_patial): Use DEBUG_NET_WARN_ON_ONCE(
>    !skb_pointer_if_linear()) instead of pskb_may_pull().
> - nft_do_chain_bridge: Added default case ph->proto is neither
>    ipv4 nor ipv6.
> - nft_do_chain_bridge: only reset network header when ret == NF_ACCEPT.
> 
> Changes in v13:
> 
> - Do not use pull/push before/after calling nf_conntrack_in() or
>    nft_do_chain().
> - Add patch to correct calculating checksum when skb->data !=
>    skb_network_header(skb).
> 
> Changes in v12:
> 
> - Only allow tracking this traffic when a conntrack zone is set.
> - nf_ct_bridge_pre(): skb pull/push without touching the checksum,
>    because the pull is always restored with push.
> - nft_do_chain_bridge(): handle the extra header similar to
>    nf_ct_bridge_pre(), using pull/push.
> 
> Changes in v11:
> 
> - nft_do_chain_bridge(): Proper readout of encapsulated proto.
> - nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
> - removed test script, it is now in separate patch.
> 
> v10 split from patch-set: bridge-fastpath and related improvements v9
> 
> Eric Woudstra (4):
>   netfilter: utils: nf_checksum(_partial) correct data!=networkheader
>   netfilter: bridge: Add conntrack double vlan and pppoe
>   netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
>   netfilter: nft_chain_filter: Add bridge double vlan and pppoe
> 
>  include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
>  include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
>  net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
>  net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
>  net/netfilter/utils.c                      | 28 +++++--
>  5 files changed, 176 insertions(+), 45 deletions(-)
> 

Can I kindly ask, what is the status of this patch-set?

Regards,

Eric


