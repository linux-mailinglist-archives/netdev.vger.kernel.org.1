Return-Path: <netdev+bounces-273690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGmkOCv3y2kGNAYAu9opvQ
	(envelope-from <netdev+bounces-273690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D646036CBC1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78B5C302F4C3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC0423A70;
	Tue, 31 Mar 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LHShZf+M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831B421EE4
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973740; cv=none; b=VGhv3xF2brkGw8a22pK/ARyoczNrvHfqtPLFIoa3GC2ajff06CJDF5Mb5IOoVz5VxKawyFkbgEO7jzCi4X/DWR7bwMm12FBWdTJikRf1pYh/kXiSfHRppUc9/50v0VdHYHY+0iCdrfRVe11mirxppfiqsOVn/Y7z4RqnQmZF+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973740; c=relaxed/simple;
	bh=hKEMFqZfvgYOMO1YrT/7Y7rOFl5qkcvC8gepax7N8Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE5ccVfyrqrx4Ec4Qj25SK2xnVAYXVq22KbuzUE3hxQwjjSlHXwvZUDTCPLkFs6g/Q9xBxrQfzhWTMU/lOcznzemJTQ29XrUjXLUY1agHGmKEKpMay34wYDEKLOSXAJNoaCeLQsFaDLQ9AUsB94+QEZySjXsNVxOHsuVpE+27l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LHShZf+M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887c4f3011so768045e9.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774973732; x=1775578532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xWJoAs4lXlq756+zLnymiNe5wTpOT6F6tvNtftPeNbM=;
        b=LHShZf+MiYc0Zvm1c2Bt9GVk9oIqswt4l0xdgVpxpP8h2BklEr5ub2i2J8g5GGbK0I
         GC2xKmeZmKC3PramCc8KRyDJ4qIgxf4ZOK1OChYVjnb3G5vq3NaJgsyazT9rCd0MJ2v0
         ms6PTR2ZwP7LpX83t172o15EWpWzAXHRKGmh0Jgi3aKLkfAo1rLHbI5BCglolycwPP86
         7kPsmm0FguAvDWKpB63Q1DihSWELi+Oe9liqzVw0yzHhIxNQOlVSubIYjWUSzdfq5Y5C
         9CKUh3wlXFJX0xcF49Jncq0b1EketWE1y9fLg7Gtt9Dkx1YRwL23XYBP0qQDAJjAXw90
         4epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973732; x=1775578532;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWJoAs4lXlq756+zLnymiNe5wTpOT6F6tvNtftPeNbM=;
        b=Vb55al6LngDaMWX4U3/JmNl3Y6fRlrjKLO0rMebDnUNk4oS1lbJHs8X4q2tV/5at6F
         K8rpZ+PFzphstfpE2T56rbJ5oY/onthvhiLaDCE16WXA8vHSFMXBTmcK1JgX0WpX3nU3
         NvvXwV/z9oztkK/imL3/iOUvAvua8XQg4sxqqMGEKtYG40WRMcBbG58LHpADV96A6Xvx
         uaKU7FOLlJBMiAwQJo8KHQBR/j8Ej1sjBQoyX8uqqBiYnVL4RQp4rJ+98VFTr9kfKyLS
         Rk9rrlILtOzB8pomqT+NgkrrLg5C4+/E0GxnloqQ/A1xKJ4TkLJpMC9945L048PybmzC
         4xsg==
X-Forwarded-Encrypted: i=1; AJvYcCWbfqVGLGGzx8L2AKGCOvcoOYa5wou2ZywvpD1RfesNaAT/W4gN+mbLhPJI2P56mGboTCsfHE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYhEOcpX9bv8hgXXXnNmVCtMGy7Nejd/8oT3PoYQeziQV8mnm
	p7jJb2IV1eNXtdNawTq5hkExqepJPPaXbPJAZR4Ym8zaYd2lmY33FPRMcw0nil/wdrE=
X-Gm-Gg: ATEYQzxnCAlI94u/PFE0H1p4DnHy/Mha0lvgjv9hZrLhGwnDBTq4WJlKwwJUqAZp1fa
	cLjXCq9SEK0wwc7KmHLlFbfFN2/QGypAW39NKzqffC5jNeN5ksq5F0lWjPY0r1Vt8h1375M2xYB
	3ml18Nik2BBQfkfukKdGElbwvuuaxWXeU9wEPYgYs78I6938842xj/fvUYhbjCm8kHseQBpcdIb
	1CXCZTjUeVf+EWrprrXmdeWyNtdkmoV2jLrUqe/SHKwmWhBTm/JDiAYuOT6ZTeClHJKFvBehEwH
	dU+mLz6XY63536W/QLoAgiFVuzspqAYjKdABbns+gyetBk7wqAYm3Ia15uZEliNG6s5IY7A8K3D
	G2Olcn5pA3M/nXOnvEw4vjgDMBc9iXAHV7r6zI8DNf3OIzVUuG88xyD49viQ8fkqPKHwQD36WOo
	KuloLOvd2pRCuvqvhbv2QbC7dAKT9RyhAgpEKTFUmMv7UFPgxm7wHUdTSARbrhtnngbo8FFSvni
	knx
X-Received: by 2002:a05:600c:4755:b0:486:f7fd:9d7d with SMTP id 5b1f17b1804b1-48727f2ce17mr148692005e9.3.1774973731968;
        Tue, 31 Mar 2026 09:15:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e26basm26421086f8f.3.2026.03.31.09.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:15:31 -0700 (PDT)
Message-ID: <b6ec7b55-d883-45fd-a227-db8fb29e48f2@6wind.com>
Date: Tue, 31 Mar 2026 18:15:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 2/2] selftests: seg6: add test for dst_cache isolation
 in seg6 lwtunnel
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20260331110755.25042-1-andrea.mayer@uniroma2.it>
 <20260331110755.25042-3-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260331110755.25042-3-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-273690-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:dkim,6wind.com:email,6wind.com:replyto,6wind.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniroma2.it:email]
X-Rspamd-Queue-Id: D646036CBC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 31/03/2026 à 13:07, Andrea Mayer a écrit :
> Add a selftest that verifies the dst_cache in seg6 lwtunnel is not
> shared between the input (forwarding) and output (locally generated)
> paths.
> 
> The test creates three namespaces (ns_src, ns_router, ns_dst)
> connected in a line. An SRv6 encap route on ns_router encapsulates
> traffic destined to cafe::1 with SID fc00::100. The SID is
> reachable only for forwarded traffic (from ns_src) via an ip rule
> matching the ingress interface (iif veth-r0 lookup 100), and
> blackholed in the main table.
> 
> The test verifies that:
> 
>   1. A packet generated locally on ns_router does not reach
>      ns_dst with an empty cache, since the SID is blackholed;
>   2. A forwarded packet from ns_src populates the input cache
>      from table 100 and reaches ns_dst;
>   3. A packet generated locally on ns_router still does not
>      reach ns_dst after the input cache is populated,
>      confirming the output path does not reuse the input
>      cache entry.
> 
> Both the forwarded and local packets are pinned to the same CPU
> with taskset, since dst_cache is per-cpu.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---

[snip]

> +test_cache_isolation()
> +{
> +	RET=0
> +
> +	# local ping with empty cache: must fail (SID is blackholed)
> +	if ip netns exec "${NS_RTR}" taskset -c 0 \
> +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> +		echo "SKIP: local ping succeeded with empty cache"
Nit: maybe the same message as the forwarding case:
"SKIP: local ping succeeded, topology broken"

> +		exit "${ksft_skip}"
> +	fi
> +
> +	# forward from ns_src to populate the input cache
> +	if ! ip netns exec "${NS_SRC}" taskset -c 0 \
> +			ping6 -c 1 -W 2 "${DEST}" &>/dev/null; then
> +		echo "SKIP: forwarded ping failed, topology broken"
> +		exit "${ksft_skip}"
> +	fi
> +
[snip]

After that:
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

