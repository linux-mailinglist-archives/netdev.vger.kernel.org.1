Return-Path: <netdev+bounces-271444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFaPHeSSw2ncrgQAu9opvQ
	(envelope-from <netdev+bounces-271444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:46:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5E320E38
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B9A43034E2C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A138A70F;
	Wed, 25 Mar 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="jEMTsP2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DEF38C2BA
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424801; cv=none; b=tUL0itxfrnAJboSWIh+LdOrGtSJSloKvWvcwribyrAYuzCV3qNAPrhVXRhcGhuanxey67jxamo9P0qi4kvaUxU/bosSZ8toNibv8FqtTKVCL6YQBb4ICdofCuScv/GhSs5yzQiBn0/TIToF95cqFA7vtbnzMJ4pz3tRUoy+TepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424801; c=relaxed/simple;
	bh=dZYOh4XrYy5rxi9XVMMD1JfT9YZNj3TOU35ZtYGqb1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5BSDcarkfBmG5M4UPbQesw8Ty+cERxBtSAorxjocsHBxwJHBdFxFoTlsRn1Gb7MdCNZ7aZwXsX1eIZ2iJLu7Sr+OnjBnu7Zjl4lXRIyIYSWj7bU3dUsYNZjbU7cVmk4GBcBAAcV6E+8wQwSLTEe72yLMwLGrCqPigeLxKRFwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=jEMTsP2i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48704db565eso38779595e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774424794; x=1775029594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXYQ+HYt37DNeCQ0SFHpfNm2D/xmqdQlJV/hZeJHWhc=;
        b=jEMTsP2iGoW6h3+9AN1UmoxxLGmfJaHU7kJOXw25UEXpIsaiCsX8fpFIMSrGw50rrB
         mxULmizuy1STC7nGCvwKLpF0R047m8aR6eCMTnewMeQQafr5sjqClweMBTpk7kdmpQaZ
         GGHxa3B0+Rmb09y5ZbzuIxKDlqDHKhi4w5lUr0Z3CS9lj8IkHywD0cYfleVTh0gifAIJ
         cClcb6NuxIpEEFve4TEZ0hLsmnJmWsi6anZVvcnLOHIyAO520gYBM9buZ24B90gGuLB0
         coP8NJUOpuszWFUI/25f0jkX9smVKrPpSQWQcp47MWfT+VRcpKYwrMf+HMkWXD2ecDfH
         Hh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774424794; x=1775029594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXYQ+HYt37DNeCQ0SFHpfNm2D/xmqdQlJV/hZeJHWhc=;
        b=CkiTd1i6+G+T4GZMoEkXKS5ENtUsjI6ToOdDs+q2MBmYFJNsbCxVcdfLLXvbiauXsH
         Ng6jmrSi+sroWibM8FPRNxdx+lDO5B/DOzVt04ACtYMKseb0d2gbVQ7RwQDt+artyfzl
         6e+AvGEkaUkpSJtS2H9efBqieRPjp/D0WMoV1DNfYjvrhu7vEFvozb5iGEzw88up0JRa
         J2fgO1OIeGHBwt4qpdDu4wYTGbwDvcPvC83quCVi34yJ157huY1TGEdw+x5FE4AgQkKD
         +8wmMx7fjgKaKAg7V14VH5+iAnlz2PW9SsC0wEWbyhbCWkQZ1stjZDrtBgFHHj0FiYZL
         rc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG7W/+Mxa5sn2kam5VcwgzVC+GYQOf2eKN8YbYGDnnK2uwuEasgPRRJ05cxbA04N+ZQhowYYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmiCPZx3tOrPFOvYNq0Yb5Sh82GAoYhtgNZMn9CFpl13PQDym
	jelS4u6N8mCdK75MRaw15XKqlXrQW0Dd8W+UR9CjLKL6bLm205TS6hEMA+7Rtw4DdLs=
X-Gm-Gg: ATEYQzyz1Y7vDUcyrOucTdgKs1oCxJ/BhwYCbiaf1zM5dlZPR7cQSXjRWmmO+PO3Exa
	ocYsgFAm/9FZLHxoXEofuY/LsUoLyJyXE9b1po208hSeWfA9Q6Kj07YlH1NoRMIsljRwBu+avec
	fEnNV2ETL5qIBZtv1h+2LGjFZkEEKxCQkIhUUgkHk54qM9u8MJYDwFq8HEDrUCT7QQu2+BpNEuS
	JJfNM4nY6VU7BUVGiAUgR5fIyPqjjAuUd0XkNlZ9XaA55hsFIDyN78xLqfxglKqpFjZbF1UfJ/z
	wf5+Lj16WSsFIh3Zf3M8tofar8tcl2tco6nwP9EmhK3/swIDN06LALHkdcFWpRhtUF95SwEAhOt
	11yFBZkJFu3AoavDBufMTJr4M1u1Lt7xjkA1dpLaPinsCQ/Uc10tH1gu3EUxJsMhaCi80Q8En60
	I1JTNBRwy60HGb9qo2F3Zhv3BT6nP0NAwrUL8YOEZrd4JJ17pUo1QDOA==
X-Received: by 2002:a05:600c:1f8e:b0:485:4006:960c with SMTP id 5b1f17b1804b1-4871605aa53mr35214235e9.16.1774424794227;
        Wed, 25 Mar 2026 00:46:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c086dsm118615395e9.8.2026.03.25.00.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 00:46:33 -0700 (PDT)
Message-ID: <34a996fd-acfd-49c7-ac76-81ae12573029@blackwall.org>
Date: Wed, 25 Mar 2026 09:46:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: bridge: add stp_mode attribute for STP
 mode selection
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260324184942.2828691-1-aroulin@nvidia.com>
 <20260324184942.2828691-2-aroulin@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260324184942.2828691-2-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271444-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,blackwall.org:dkim,blackwall.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3E5E320E38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/2026 20:49, Andy Roulin wrote:
> The bridge-stp usermode helper is currently restricted to the initial
> network namespace, preventing userspace STP daemons (e.g. mstpd) from
> operating on bridges in other network namespaces. Since commit
> ff62198553e4 ("bridge: Only call /sbin/bridge-stp for the initial
> network namespace"), bridges in non-init namespaces silently fall back
> to kernel STP with no way to use userspace STP.
> 
> Add a new bridge attribute IFLA_BR_STP_MODE that allows explicit
> per-bridge control over STP mode selection:
> 
>    BR_STP_MODE_AUTO (default) - Existing behavior: invoke the
>      /sbin/bridge-stp helper in init_net only; fall back to kernel STP
>      if it fails or in non-init namespaces.
> 
>    BR_STP_MODE_USER - Directly enable userspace STP (BR_USER_STP)
>      without invoking the helper. Works in any network namespace. The
>      caller is responsible for registering the bridge with the STP
>      daemon after enabling STP.
> 
>    BR_STP_MODE_KERNEL - Directly enable kernel STP (BR_KERNEL_STP)
>      without invoking the helper.
> 
> The mode can only be changed while STP is disabled (-EBUSY otherwise).
> IFLA_BR_STP_MODE is processed before IFLA_BR_STP_STATE in
> br_changelink(), so both can be set atomically in a single netlink
> message.
> 
> This eliminates the need for call_usermodehelper() in user/kernel
> modes, addressing the security concerns discussed in the thread at
> https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/ and providing
> a cleaner alternative to extending the helper into namespaces.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Andy Roulin <aroulin@nvidia.com>
> ---
>   include/uapi/linux/if_link.h | 40 ++++++++++++++++++++++++++++++++++++
>   net/bridge/br_device.c       |  1 +
>   net/bridge/br_netlink.c      | 18 +++++++++++++++-
>   net/bridge/br_private.h      |  1 +
>   net/bridge/br_stp_if.c       | 17 ++++++++-------
>   5 files changed, 69 insertions(+), 8 deletions(-)
> 
[snip]
>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 6dbca845e625d..e4bb9c3f28726 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -540,6 +540,7 @@ struct net_bridge {
>   		BR_KERNEL_STP,		/* old STP in kernel */
>   		BR_USER_STP,		/* new RSTP in userspace */
>   	} stp_enabled;
> +	u32				stp_mode;
>   
>   	struct net_bridge_mcast		multicast_ctx;
>   
[snip]

Not critical but there's a 4 byte hole in the same cache line betwen root_port
and max_age, if you move stp_mode there we get:

/* size: 1728, cachelines: 27, members: 53 */
/* sum members: 1722, holes: 2, sum holes: 6 */

vs

/* size: 1736, cachelines: 28, members: 53 */
/* sum members: 1722, holes: 4, sum holes: 14 */




