Return-Path: <netdev+bounces-173328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CEA58588
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB5F7A49ED
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625E1DE4F8;
	Sun,  9 Mar 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHfaVmCd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C39335C0
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535732; cv=none; b=Sqbim3ALUUgnR+94K+5VGjbe+Drqk9JHdStma957It8epOTiLR+UF4owGPyyNExvBKXqH+RWELUcuDDfcG605hRs0dHqfjAW/X8kMyLUMtSsRwQt6dpU5oqt6KZ5CKIbwaKPJX/SD8k2DpbFdLawsE3LN7TJTJq41CWZTmJGSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535732; c=relaxed/simple;
	bh=Emj/E4LnjFn23AzhxtdOQV2NJ7sCpkWQy+MXWkFE6ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otsGvzSYfJvgkQvFJYXbbNrtnBBvFBAdo1N4m2nh0mGD+GJa8+brzVLqKlMnON8mI6FJ2M4GxrchsXQzZDI8N8V/FphV/m3OFavuLSBM/YkfnQI/pCsopFu8XFSNe7xldW0tkWYjn1n+KgGWWEGUFhl1ZFKpdkFmotlERTIDuIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHfaVmCd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741535729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLPPAvMk9HmrjHGFgm8cafTlErHX55+RcJ6djlaYs0g=;
	b=CHfaVmCd/LKunXzLoQiGolKycPtM8sJIQU12L6jiz8OXIaQa9CUKJMTujso2rM0Jw9RmHA
	2wANGktczqgirPfhW+3cDQBtBlibYulRffxgDcRrkSdoKRIbLtPJz+Cub904HTEpbO500j
	BsKwieSi9Imc4LgcNMIwmlzkPfP2DzE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-XY9i_1TEPnO6Ot2KECfqhw-1; Sun, 09 Mar 2025 11:55:28 -0400
X-MC-Unique: XY9i_1TEPnO6Ot2KECfqhw-1
X-Mimecast-MFC-AGG-ID: XY9i_1TEPnO6Ot2KECfqhw_1741535727
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so28178275e9.2
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 08:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741535727; x=1742140527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLPPAvMk9HmrjHGFgm8cafTlErHX55+RcJ6djlaYs0g=;
        b=KozixDiqFeNSzRQxIOOG+UtcsfodCrCaOunU34gWQdguGmo6nrQRq0zlgcpWxqFRC4
         r2fIgDcjq/Bqzo1TmWxMkmjLwTHhHPd7+2bpK6zuytSF/fkPw/NPE61l5jcEbVVC385E
         HCr9AcWv9P+8zAbnV13K/lDO146uUTLrqv4z9SyHYVwnBPMVM87HA4AerLjJOFd+zpOM
         +UZuTWj75b3EwjOlOISDy4LSIhbQXGmHWhmSydBFuBkr0dTDAHl5q0JQZyxKVu5/+JL+
         srRRs7fRQJKIJhKlcqc+KBnXlqz26lURu5bsvbvOSCBzukG8QE1Pm8B69Zzxsm8FGQ63
         mZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlipQ44iMyCIBMPQeCAKyoFKemdMTDXxoxsO/F6/x10K+3PKlweWCVJd1TE29rPv3mvYO1TYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUB5GvqoRtXUSQRRbGtyJXp5KnG2Dc/fIHFu5vBczQu550x4K2
	yfl1qYTtMNI75FKrIznR6sZlNs4NesUWdgYs/UpcpEUhuLFIDBok6NXZvku2MlLTrjMi4zwXkBM
	ycwW17HvUAjsM2nffSP0SJZEc2yPAVD9sLeZ15bbEj4xQ4o2jUdo0qw==
X-Gm-Gg: ASbGncvlrrM5MYO5OcR7ldpwfKYIzJu9YyWAnhv9bxd59OY/REF9jrlLCXA7vMmAILz
	kk8qnYplxqsyB93BtvIOJtlTV8EpQb87OEuQ1SuOV0c5SiuMzM8kizBHT72BbpUO7xWVkDCbT2u
	22yRbtFBYlIk/CslqVzpjRIMcWLzF9blp4ooJ6kqpuhDmK+gD6nGl3kL4OxPmdkWssvnP3Vgbak
	K8XKC//2Ei/2s5A7PLPR6OPOAMsMKOUqwIVLolEMiG9QxDpi0itThYGbeCQ0NYxQr35/+2y81ct
	DESReF+VyKwRD/6Vg07BQ4+YxiE26LEzwV4upr1OTZS3VQ==
X-Received: by 2002:a05:600c:1908:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43cec28d58fmr30919785e9.10.1741535727074;
        Sun, 09 Mar 2025 08:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj7zZQIjC1M1e3OF1aZMuQBjPcO+VNJz5Eyvy0PY/Hzevl8Ki+RLZ87DbS3D5ijJ+/XRn2dQ==
X-Received: by 2002:a05:600c:1908:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43cec28d58fmr30919675e9.10.1741535726733;
        Sun, 09 Mar 2025 08:55:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8dad73sm120249245e9.19.2025.03.09.08.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 08:55:26 -0700 (PDT)
Message-ID: <4bc191e2-b4f3-4e6b-8c9f-eaa67853aaae@redhat.com>
Date: Sun, 9 Mar 2025 16:55:24 +0100
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67cc8e796ee81_14b9f929496@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 7:37 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index 2c0725583be39..054d4d4a8927f 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -12,6 +12,38 @@
>>  #include <net/udp.h>
>>  #include <net/protocol.h>
>>  #include <net/inet_common.h>
>> +#include <net/udp_tunnel.h>
>> +
>> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
>> +
>> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
>> +{
>> +	bool is_ipv6 = sk->sk_family == AF_INET6;
>> +	struct udp_sock *tup, *up = udp_sk(sk);
>> +	struct udp_tunnel_gro *udp_tunnel_gro;
>> +
>> +	spin_lock(&udp_tunnel_gro_lock);
>> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
>> +	if (add)
>> +		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
>> +	else
>> +		hlist_del_init(&up->tunnel_list);
>> +
>> +	if (udp_tunnel_gro->list.first &&
>> +	    !udp_tunnel_gro->list.first->next) {
>> +		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
>> +				  tunnel_list);
>> +
>> +		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
> 
> If the targeted case is a single tunnel, is it worth maintaining the list?
> 
> If I understand correctly, it is only there to choose a fall-back when the
> current tup is removed. But complicates the code quite a bit.

I'll try to answer the questions on both patches here.

I guess in the end there is a relevant amount of personal preferences.
Overall accounting is ~20 lines, IMHO it's not much.

I think we should at least preserve the optimization when the relevant
tunnel is deleted and re-created, and the minimal accounting required
for that will drop just a bunch of lines from
udp_tunnel_update_gro_lookup(), while keeping all the hooking.

Additionally I think it would be surprising transiently applying some
unusual configuration and as a side effect get lower performances up to
the next reboot (lacking complete accounting).

> Just curious: what does tup stand for?

Tunnel Udp Pointer. Suggestion for better name welcome!

Thanks,

Paolo


