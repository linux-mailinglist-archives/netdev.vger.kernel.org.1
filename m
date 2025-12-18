Return-Path: <netdev+bounces-245358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA92CCC475
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E1F301B2CD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004ED286430;
	Thu, 18 Dec 2025 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DlbcuYmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA528506A
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067855; cv=none; b=N7+XkBAfJUM5ldh2uAvWCGi1TarcpqsSopjxg0fKS2w3eDdjfhmDGnbz3Mm0XwNHSr969egg8pIT7EcU/Cxhz9OWvBXCVucTs8OdIjSUVz3xnBkmTghtvlEOwZ+FJF9fOPowgglWxwAo4PfK4P4y/oBV1bet6bc8xSnHelqDrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067855; c=relaxed/simple;
	bh=eZzYTqg8PinqqNdKiqKDF1uBs1DOI54IBa+Ht0eTr/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0PsAyjKRiD7wopD/jytdguACe8ltCtp+lTpABJMhuAPvP22LLxnkEroyNvBfC39gUDX3fkrJBzLRBvpkq9On9EyeytWsitllg/nLtwIaENlwbdHcEUxUIpt18ALUGr7vuQHSnEPKj/MxLMl/yoS1BZ6SFzYDJ+DFj/68pvTzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DlbcuYmO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779d8286d8so654045e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 06:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1766067852; x=1766672652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/nzBF6PMqa+Ew77aJFLIstWF/lTIFX7jKNDwHELEAMU=;
        b=DlbcuYmOUH0dwaQ6TQqR/TV6cmDp5GpmNth8on6HQHBNIvuef1lMaN7d01p97trxar
         aVFFmBNNVoDixMedP/PaSGc7GG9lQ+xPacwnJL/KSt2MWzRuxTAqpymuQLuX6ohEDhgl
         LFpT+16TjhdKFsKKRhqMroRhQHSP4NwsBRAtLsPwEU+8PaZnEL+zHYB2WYSIm3RIuRlF
         8Xig+CTiM3AvNbn/JIGDrQJ/Thy5rZUbrBvwE76wRyOeVRj6p9pRAg5gmeKqliHsmuw5
         p1dJsa3sL0x9Id/vg0bIDifdWqGTV8hfF+OYYA4lZ0PmoJynoI9VPPRHdSPX98EYdwEd
         HyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766067852; x=1766672652;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nzBF6PMqa+Ew77aJFLIstWF/lTIFX7jKNDwHELEAMU=;
        b=uu4HRr3hSVMvDt1xa1flo0LpTNm+rTa+jeo5zToR9eqh5VgcnbkdaZxGmq1PpTToxj
         huLmkTE0dXcz4sTksmYAj8/SOjWQu4PmySA8HsdUC+jZob65e/zyM4qah1V6YfBSDSAy
         Ae9j7N06ulk2qr+1QAaFlLCcn2zXMiTNGvCi22QlutS0SitVq0XBewNFyUj5R/EahbfZ
         I4uuhU1H8bpHwKtUu140pxgmrIx40MOHKhyOzpW39nRvvJ/ZmWqSceSMwJICtEsdvWMi
         g8WXNAYqw5YmGbklB3BjiM5ks5VS6D75ugMKn97wZIywzHfMLc/DPLaqBcHA9l3h4KCH
         /KBA==
X-Forwarded-Encrypted: i=1; AJvYcCV+2j4zsN6q2RwCXVXg5X/bgpYVQTNthD0YEEsB5vy8KhBV79P9SEUfY7oF23fUI1vYPrRZOFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvi+QvfybPw2AnsnQVX30eWaW0S7FapppDuGsOr0w5flSfDD8L
	ZMla0Ji18ObIjTrs0+RbzdKD+iqY6TBQXOcIpYM4mj5nD4lziUTHAJXLT6at4XAjDpA=
X-Gm-Gg: AY/fxX4QV7UPpYpj8Sie0gVhQKcSEOWoeb3tXQn2Ls7WR0b8EapGHPIy/60g1gBcOxd
	vzzcmMR+TwcisDKPOTGtIeaDZYr2Z8UtNHDIFHXriETqHO1/8aOC1zoFl/Yzm8Ng3AFyZjBs6E8
	5RtBDc8iUnBRTu2MSU3rE4KEZM7jINzusfHLBPdPwezlSlcK/rvSzFMEps/aJmbWHYBI8/rlzj8
	6xakFxl9weK2u+rbpK+9iMR16Sn15KOQMiIlnZiflRgQ5TGB77wOHdKHtqGTBi474nCR3ss1nEr
	m542rM0z5jeurMd0EHc5azYBvUihgKhpcy99TA8xpSIFWoeKGzO3SrI48Js3jsUbNSF9aBvSn1h
	6sM/PrUx21fc67bgn1muDCGWCtJkaykSfjrGz7QpCRpQC9JReQ76VCvrzyKjDjyFaYK2Cb+9tWG
	YBBC56S6PHwH+nkVtDGb1EJjc/Vm5M4Jk+M3f+Fh/d3hkmvsafg9sZpyOF1veNfms=
X-Google-Smtp-Source: AGHT+IEk/b/xVP8nFQ+cHU4pwdiz6PiOm4MYI3P9sgm1sNy37wfIKsAj9tK3x+1vyvDSJRRsOBT0cw==
X-Received: by 2002:a05:600c:8b64:b0:468:7a5a:14cc with SMTP id 5b1f17b1804b1-47be3cddde5mr14619795e9.3.1766067852074;
        Thu, 18 Dec 2025 06:24:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3017fa3sm39940355e9.2.2025.12.18.06.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 06:24:11 -0800 (PST)
Message-ID: <ed575eb5-013c-413f-b411-be14f7acc249@6wind.com>
Date: Thu, 18 Dec 2025 15:24:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] seg6: fix route leak for encap routes
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Lebrun
 <david.lebrun@uclouvain.be>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 stefano.salsano@uniroma2.it
References: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
 <20251210113745.145c55825034b2fe98522860@uniroma2.it>
 <051053d9-65f2-43bf-936b-c12848367acd@6wind.com>
 <20251214143942.ccc2ec1a46ce6a8fcc3ede55@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251214143942.ccc2ec1a46ce6a8fcc3ede55@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 14/12/2025 à 14:39, Andrea Mayer a écrit :
[snip]
>>> I've got your point. However, I'm still concerned about the implications of
>>> using the *dev* field in the root lookup. This field has been ignored for this
>>> purpose so far, so some existing configurations/scripts may need to be adapted
>>> to work again. The adjustments made to the self-tests below show what might
>>> happen.
>> Yes, I was wondering how users use this *dev* arg. Maybe adding a new attribute,
>> something like SEG6_IPTUNNEL_USE_NH_DEV will avoid any regressions.
>>
> 
> IMHO using a new attribute seems to be a safer approach.
> 
> Is this new attribute intended to be used (a) to enable/disable the use of *dev*
> during the route lookup, or (b) to carry the interface identifier (oif)
> explicitly for use in the lookup?
> In the latter case (b), the route *dev* would no longer be consulted at all for 
> this purpose.
I would tend to prefer option (a), something like:
> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] use_dev dev eth0

With option (b), we could end up with this kind of route:
> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] vrf blue dev eth0
where eth0 is not in vrf blue. This is confusing.

[snip]

>>>> --- a/net/ipv6/seg6_iptunnel.c
>>>> +++ b/net/ipv6/seg6_iptunnel.c
>>>> @@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>>>>  	 * now and use it later as a comparison.
>>>>  	 */
>>>>  	lwtst = orig_dst->lwtstate;
>>>> +	if (orig_dst->dev) {
>>>
>>> When can 'orig_dst->dev' be NULL in this context?
>> I was cautious to avoid any unpleasant surprises. A dst can have dst->dev set to
>> NULL.
>>
> 
> I see your point regarding caution.
> 
> However, if 'orig_dst->dev' were NULL at this point, the kernel would crash
> anyway because subsequent functions (e.g., __seg6_do_srh_encap()) rely on
> 'orig_dst->dev' (not NULL) to retrieve the net.
Right, I will remove the test.

> 
> 
>>>> +		rcu_read_lock();
>>>> +		skb->dev = l3mdev_master_dev_rcu(orig_dst->dev) ?:
>>>> +			dev_net(skb->dev)->loopback_dev;
> 
> One issue here is that the outgoing device (*dev*) is being treated as the
> packet's *incoming* interface.
> 
> ip6_route_input() uses 'skb->dev->ifindex' to populate 'flowi6_iif'.
> Consequently, if there is an 'ip rule' matching on 'iif' (ingress interface),
> it will evaluate against the *dev* (the VRF or the loopback) instead of the
> actual interface the packet was received on.
> This can lead to incorrect policy routing lookups.
Hmm, right, it should be changed only in case of x-vrf.

Thanks,
Nicolas

