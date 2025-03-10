Return-Path: <netdev+bounces-173488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD02A592BD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6014A16B511
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061A21E0AE;
	Mon, 10 Mar 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv3XnVGC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062228EA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606148; cv=none; b=IXLPZxQ+T3jhfiLXJRM7Jqc+oQNAxX+/jP2xDLvOSKtcYZygcoJrGOUO+bO/UmAt89n9XzKcUwkwAMK0rQPCgIkF8AXBPOCoEBPnTN3oTthIH/IxCb/SRXmaUsY5Ai80go64XM6ZBsA8cM2+zyxsZqlo5fQlyCosPaUaxdxp5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606148; c=relaxed/simple;
	bh=nzm+QROPgNlTgv5Etl0vu3jI3ntSMxIpJG28wx827bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6rzOw+HTQ2tG7+Q4rjIDplVvBUZ2HN6It2IuRqHWWh74fKIeeQKhVG/e1+HJc51pQpuXZM1kmZdcADgVpsi8oqcQ7AioYywj4+lgbTHy7JK7Ehiz7IYa7aEYDGWNc5alE4NJP+CqS5SGS+RsuAfhQj/adW+faQo9QZeIeknOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv3XnVGC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741606145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5z0JpiHujt35jhHokiICXA3nb7oZBkAm98GfGBWkb4U=;
	b=Uv3XnVGCkF4l9TA4GjtkYLGftD7dDc4difzyxayiEGKg99JL+jT5vX8KuHEz22UlOhIZ+w
	yfCuI5cXbUTOslwoMTCWrYRB9bXJPR+6r3bqytttNGZsoXczGwi2IxG1UgWSsLpXJTXSxQ
	U2sUPpwXx7aThpMRFNQVXpY9+h+dufU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-5i-7LM4zMbS0LtYIYT4a8A-1; Mon, 10 Mar 2025 07:29:04 -0400
X-MC-Unique: 5i-7LM4zMbS0LtYIYT4a8A-1
X-Mimecast-MFC-AGG-ID: 5i-7LM4zMbS0LtYIYT4a8A_1741606143
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso27396685e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 04:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741606143; x=1742210943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z0JpiHujt35jhHokiICXA3nb7oZBkAm98GfGBWkb4U=;
        b=LTd8mCAXerNt9K5+7KtAUmgJ4y8pp0HHWgGLhwqnd1RVO/q3oFpNvuVyh1FK9vG06c
         DjxF6xsfnLCT8vJzXDwuQdPttoAMkMXHenkgFPBHrWKppycwBr/Dq6bNmzda5ylVuoQ5
         jFvPOD/qWsTTTZDwYGagXNAXJYpq2FTO8TZSCR/FVX2qJgliT51OvjFiPcJCPvYsHwvq
         QbpenmvnrYvWB4iJtaivmRK5dpyhHYFls7V1rfbSMiKbOCV2TFH/18oCE+igL68F7Now
         5lyDX8rirg7Ib86X8DyoRmzav03ngH2GbniMeE99r+mSw0k817BeQTX1ysEoAXO0klEG
         N+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ck4lN6PcFDjj1sEW/mGk4UGn+e+sF/8gHmZiXbSLfsVEKcb8aEFbZCqoY0VwpAv9MhWeyB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmkZzh5UCZXnGea90x4lsCD1kzMerVWh2s6n1sfUbtZEq6vfS
	ZOf+mo6ACa3+MX5mx3a+B0ylnlTM0ShBYm4Fm8JHeTHVCdcLFWUA3/QAHDL3Bi4oTM+aQkiiZrC
	jrzHHN/BYz4Ru9FwvPkg39+wDHTpKfdhEmdXMk0KxLAdItEWc1F2a/A==
X-Gm-Gg: ASbGncsF8O6RE+zjIv7D1jIWRqf+4PFjOL/KGJlnq1zcptuuQAdc7XbjetvI+ZR1yMT
	MKs3nF57M0KA220NdmOA+coLxIE2VRv2Wb+JZj1c/3NzkkqNKkNCp22eyfjSZRibwLs+zIJouyR
	H47nAJdCr3jF7e/Ryh6RSeTpyS0Zn0Y67c2eEx/QW39UwgL7O+GAhCBjmL4sClGA5PjT0QaanXR
	GxRR/0IsL4Guw60QleFAPiuOJxjwkghk4H6UG8IF+gIy81WtTqY0XptnAymvwxa6wq1f4piiLi3
	HZgD7enlXqncppox1BB3XVMHXVCIVSEMZ7FB0IBmM2o=
X-Received: by 2002:a05:600c:4448:b0:43b:cf9c:6ffc with SMTP id 5b1f17b1804b1-43c5a5fe767mr77788095e9.12.1741606143344;
        Mon, 10 Mar 2025 04:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/kS0BlHLMFCXXSJUElGAit73qlmOd3d/94x1AOYxfIpXEmLIKVfuRRgSyDa5RVR/hO4ZeUQ==
X-Received: by 2002:a05:600c:4448:b0:43b:cf9c:6ffc with SMTP id 5b1f17b1804b1-43c5a5fe767mr77787845e9.12.1741606142963;
        Mon, 10 Mar 2025 04:29:02 -0700 (PDT)
Received: from [192.168.88.253] (146-241-65-56.dyn.eolo.it. [146.241.65.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm80662645e9.1.2025.03.10.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:29:02 -0700 (PDT)
Message-ID: <0d6ed067-9509-4caf-9404-973ad7ae340f@redhat.com>
Date: Mon, 10 Mar 2025 12:29:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
References: <cover.1741338765.git.pabeni@redhat.com>
 <800d15eb0bd55fd2863120147e497af36e61e3ca.1741338765.git.pabeni@redhat.com>
 <67cc8e796ee81_14b9f929496@willemb.c.googlers.com.notmuch>
 <4bc191e2-b4f3-4e6b-8c9f-eaa67853aaae@redhat.com>
 <67ce61b338efd_20941f2949f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67ce61b338efd_20941f2949f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 4:51 AM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> On 3/8/25 7:37 PM, Willem de Bruijn wrote:
>>> Paolo Abeni wrote:
>>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>>> index 2c0725583be39..054d4d4a8927f 100644
>>>> --- a/net/ipv4/udp_offload.c
>>>> +++ b/net/ipv4/udp_offload.c
>>>> @@ -12,6 +12,38 @@
>>>>  #include <net/udp.h>
>>>>  #include <net/protocol.h>
>>>>  #include <net/inet_common.h>
>>>> +#include <net/udp_tunnel.h>
>>>> +
>>>> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>>>> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
>>>> +
>>>> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
>>>> +{
>>>> +	bool is_ipv6 = sk->sk_family == AF_INET6;
>>>> +	struct udp_sock *tup, *up = udp_sk(sk);
>>>> +	struct udp_tunnel_gro *udp_tunnel_gro;
>>>> +
>>>> +	spin_lock(&udp_tunnel_gro_lock);
>>>> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
>>>> +	if (add)
>>>> +		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
>>>> +	else
>>>> +		hlist_del_init(&up->tunnel_list);
>>>> +
>>>> +	if (udp_tunnel_gro->list.first &&
>>>> +	    !udp_tunnel_gro->list.first->next) {
>>>> +		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
>>>> +				  tunnel_list);
>>>> +
>>>> +		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
>>>
>>> If the targeted case is a single tunnel, is it worth maintaining the list?
>>>
>>> If I understand correctly, it is only there to choose a fall-back when the
>>> current tup is removed. But complicates the code quite a bit.
>>
>> I'll try to answer the questions on both patches here.
>>
>> I guess in the end there is a relevant amount of personal preferences.
>> Overall accounting is ~20 lines, IMHO it's not much.
> 
> In the next patch almost the entire body of udp_tunnel_update_gro_rcv
> is there to maintain the refcount and list of tunnels.
> 
> Agreed that in the end it is subjective. Just that both patches
> mention optimizing for the common case of a single tunnel type.
> If you feel strongly, keep the list, of course.
> 
> Specific to the implementation
> 
> +	if (enabled && !old_enabled) {
> 
> Does enabled imply !old_enabled, once we get here? All paths
> that do not modify udp_tunnel_gro_type_nr goto out.

You are right, this can be simplified a bit just checking for the
current `udp_tunnel_gro_type_nr` value.

> 
> +		for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
> +			cur = &udp_tunnel_gro_types[i];
> +			if (refcount_read(&cur->count)) {
> +				static_call_update(udp_tunnel_gro_rcv,
> +						   cur->gro_receive);
> +				static_branch_enable(&udp_tunnel_static_call);
> +			}
> +		}
> 
> Can you use avail, rather than walk the list again?

When we reach the above code due to a tunnel deletion, `avail` will
point to an unused array entry - that is "available" to store new tunnel
info. Instead we are looking for the only entry currently in use.

WRT the code complexity in patch 2/2, I attempted a few simplified
tracking approaches, and the only one leading to measurably simpler code
requires permanently (up to the next reboot) disabling the optimization
as soon as any additional tunnel of any type is created in the system
(child netns included).

I think the code complexity delta is worthy avoiding such restriction.

Thanks,

Paolo


