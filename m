Return-Path: <netdev+bounces-251396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A225BD3C291
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D7726459A1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9034214A;
	Tue, 20 Jan 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrVomxHq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqbUgeYm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9CC26B2AD
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898268; cv=none; b=YW1RzNJXGlLEvB9hnqKpOiVjit1iRb4IKUUuXKxTn75MQiwk3j9qy1NRXYtVxh7AuWgh5/frx2R7g1TKTLxU2keMqiWEAadqcE6jVgRDXKnilWxVQFFqiKgTHL8VlNSwPv8Pn7NJrsHsdAJtFAttV7B99dSx4/mQtBhHwdEW8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898268; c=relaxed/simple;
	bh=K/0w0bD+ys57Yv0EbKOdOiAsg36TeepUAg1Ff8NcxaI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pjkL8tUAY45eIkRyJsaVprlbJzdoWRwkfaAk64ZxBEAXnkcT6uegLd5PDHGB/eWxP7mtC1ZLRWX9Jl64jTst41DLrmVtAgKlFZgUamjXasOVvqsBk9tvFK5XmYnzYnB/99UVFVoW1037vWNRMI/l+4sxDHMmN0Ns8t5/DPctkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrVomxHq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqbUgeYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768898265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taxyLFXto58cYgvDkEr9Pa3Oat2fQNZrg2C/xvHLOrQ=;
	b=TrVomxHqhAwszy6a1Y1g6T+JSANBQBbj39SYFphLeNWdonx8oJKTgpgMO3XvC5CQ5jt6lT
	mg/Wr577w3zbM80w0HK3Zd5yQYwuxSV8jE2MmLEuaNpGr+pmrNNPfKt3itObwwUHXZK2FG
	Ls+p3WHjJ/621III0sF+DQ94PjzBrdc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-FFV59paeMW-MguTbkMFbTg-1; Tue, 20 Jan 2026 03:37:43 -0500
X-MC-Unique: FFV59paeMW-MguTbkMFbTg-1
X-Mimecast-MFC-AGG-ID: FFV59paeMW-MguTbkMFbTg_1768898262
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso53032525e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768898262; x=1769503062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=taxyLFXto58cYgvDkEr9Pa3Oat2fQNZrg2C/xvHLOrQ=;
        b=XqbUgeYmAYifBzE9GwwD/k1OT2Pcpg8nVesASHJtt+FoBcBV6fvOB4oUW2ydiHlS71
         YY/cOk7vwINY2kBs51bk1wokKMQKHY8dNe3/NZH3Ry5BkBWb4OP4GqxIH8QZWQnbaiU7
         IkdsRPCIMLryuo2otiOl1rCc0+ONf42QdyfX9jXhzq/FUCYagVOE8vFmxeRdOg/z841M
         r9dXaE02T2QPwdmgPRWu+Rph361HvyHFcJihfh3cBSaghLVQq8dNlec9MJVIl1VOND6I
         rwhhhxTqvV/A8tpXl0RqA7/O0GSfBux0ivIs94m5u5s7QceXQj747aD+rdJV8qAtVDUs
         LZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768898262; x=1769503062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taxyLFXto58cYgvDkEr9Pa3Oat2fQNZrg2C/xvHLOrQ=;
        b=NDKke8ql58eOpM2dLnZxM8KvhGHqMxDcIED/ET/Af+1N69FAY5ALXq9bIVwVUv2yn8
         bv16oRSgNZXMOkMeLDgHh+QehJNPczBoumbRmwNdw3gqD5R0wUCOmWIjuwuiArWnIb1k
         dCB7sxIwYO4TPRtcHb2XAAh490LubEkMh3b2RVdnqg5ag1xHL48rK0o8WLEdaKA7qAhP
         uQMdJXIOTMZC5+EmlFa2RVsAd9ykS9vBcjEg4RHGSTO7EIEpdQkQrK04zWLLRsvKfuyB
         ZEgH4f3Z874ugPIpC93r4A/3xTAbmuNt2FTgFUkbxu7GHXaPUOQtVs2qwbgo3Hlx/llm
         R1NQ==
X-Gm-Message-State: AOJu0Yy0xMoR5Aoyy6RHDWfc6+OUYylsdF/nQDaNd8VIj6bHNTTIXDq5
	VzpJwN8bH0aLyCmFm62cLLlIzrsjOt8YOdmVX5vqcVBCRGLyjrQSdIR+6/kB7bD2FJbo9aKjuNh
	L1cxrCbDMzkY97OAKKOCVgPg5vllZs962haPWlrJej26ddg+8hRBpYLOItY7MT4ENk6lJEVhuiy
	iKilXzAhYScOBq1vcnPt0BVQM6S0EZtRd0KvcMT3I=
X-Gm-Gg: AY/fxX7N9lS3Bs9ynwTdNGA1C9EmsaEMszWTYhy5+hXXF3AkEXOG0cpF8B79BYGX5J1
	fj6s93X2HHcix72b+zh5BJAVBnz2aoSW+H/gk0NTyTlfSegd4G+4tzddYMpEcbXNcVQxdsHCn8H
	7i0Uj7JCv3MYAEwT+NdQj2ByX2gyOhMJpiOPpNZmbOJP6UiQvluuf+IsLneILzS0PXHMW7Md90P
	bEs7vlVrMUX7AEIklpRMpga6gh0gKaXhRQowstAqBXccqmSu5er8QLPv+Kp6qYPU6J/cEMN833n
	2L9Yf//PDG0wHxrG3WGIDgTIKabjufZBvd1aQqKzNSzbrsfxeYql1QcBZGkEaEVFywWNqmmqA6S
	0nsHHCw60W+Kc
X-Received: by 2002:a05:600c:1d28:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-4801eb0d727mr180023135e9.26.1768898262177;
        Tue, 20 Jan 2026 00:37:42 -0800 (PST)
X-Received: by 2002:a05:600c:1d28:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-4801eb0d727mr180022605e9.26.1768898261727;
        Tue, 20 Jan 2026 00:37:41 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c00esm232138795e9.2.2026.01.20.00.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 00:37:41 -0800 (PST)
Message-ID: <e3738b0f-a18c-48ff-993d-eb8a1e989dd9@redhat.com>
Date: Tue, 20 Jan 2026 09:37:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/10] geneve: introduce double tunnel GSO/GRO
 support
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
References: <cover.1768820066.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cover.1768820066.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 4:09 PM, Paolo Abeni wrote:
> This is the [belated] incarnation of topic discussed in the last Neconf
> [1].
> 
> In container orchestration in virtual environments there is a consistent
> usage of double UDP tunneling - specifically geneve. Such setup lack
> support of GRO and GSO for inter VM traffic.
> 
> After commit b430f6c38da6 ("Merge branch 'virtio_udp_tunnel_08_07_2025'
> of https://github.com/pabeni/linux-devel") and the qemu cunter-part, VMs
> are able to send/receive GSO over UDP aggregated packets.
> 
> This series introduces the missing bit for full end-to-end aggregation
> in the above mentioned scenario. Specifically:
> 
> - introduces a new netdev feature set to generalize existing per device
> driver GSO admission check.1
> - adds GSO partial support for the geneve and vxlan drivers
> - introduces and use a geneve option to assist double tunnel GRO
> - adds some simple functional tests for the above.
> 
> The new device features set is not strictly needed for the following
> work, but avoids the introduction of trivial `ndo_features_check` to
> support GSO partial and thus possible performance regression due to the
> additional indirect call. Such feature set could be leveraged by a
> number of existing drivers (intel, meta and possibly wangxun) to avoid
> duplicate code/tests. Such part has been omitted here to keep the series
> small.
> 
> Both GSO partial support and double GRO support have some downsides.
> With the first in place, GSO partial packets will traverse the network
> stack 'downstream' the outer geneve UDP tunnel and will be visible by
> the udp/IP/IPv6 and by netfilter. Currently only H/W NICs implement GSO
> partial support and such packets are visible only via software taps.
> 
> Double UDP tunnel GRO will cook 'GSO partial' like aggregate packets,
> i.e. the inner UDP encapsulation headers set will still carry the
> wire-level lengths and csum, so that segmentation considering such
> headers parts of a giant, constant encapsulation header will yield the
> correct result.
> 
> The correct GSO packet layout is applied when the packet traverse the
> outermost geneve encapsulation.
> 
> Both GSO partial and double UDP encap are disabled by default and must
> be explicitly enabled via, respectively ethtool and geneve device
> configuration.
> 
> Finally note that the GSO partial feature could potentially be applied
> to all the other UDP tunnels, but this series limits its usage to geneve
> and vxlan devices.
> 
> Link: https://netdev.bots.linux.dev/netconf/2024/paolo.pdf [1]
> ---
> v3 -> v4:
>   - better mangleid handling in patch 1
>   - use xfail_on_slow in patch 10
> v3: https://lore.kernel.org/netdev/cover.1768410519.git.pabeni@redhat.com/
> 
> v2 -> v3:
>   - addressed AI-reported possible UaF
> v2: https://lore.kernel.org/netdev/cover.1768250796.git.pabeni@redhat.com/
> 
> v1 -> v2:
>   - addressed AI and checker feedback
>   - more stable self-tests
>   - avoid GRO cells for double encap GSO pkts
> v1: https://lore.kernel.org/netdev/cover.1764056123.git.pabeni@redhat.com/#t
> 
> Paolo Abeni (10):
>   net: introduce mangleid_features
>   geneve: expose gso partial features for tunnel offload
>   vxlan: expose gso partial features for tunnel  offload
>   geneve: add netlink support for GRO hint
>   geneve: constify geneve_hlen()
>   geneve: pass the geneve device ptr to geneve_build_skb()
>   geneve: add GRO hint output path
>   geneve: extract hint option at GRO stage
>   geneve: use GRO hint option in the RX path
>   selftests: net: tests for add double tunneling GRO/GSO

It looks like the last 3 patches did not land on the ML. I have no idea
about the root cause. I'll wait a bit more and I'll resend the whole series.

/P


