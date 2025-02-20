Return-Path: <netdev+bounces-168032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C7A3D2A9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01C43B85A5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444001E9B09;
	Thu, 20 Feb 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE6RBLog"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA551E990A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038328; cv=none; b=X+poFpviEU9czHR6fapwArNpky5pK0gLklyDLwjfwYYF+kzigrgpkHSkdkxGpSjTh+HJSsxU6WRVVycGvXyWL1PXptFZLN6ESatIbMwM7gBrGHeFSh8OuwsxaOyYDbRJd4ot2o3+DjhUvN7l1PnL6FcX072c2mcKB/SKxDz6heY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038328; c=relaxed/simple;
	bh=PpJNYD2lhmYApKCUTFbnIB2Oz9xNpyPKhkXzhRQ1kRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aOn9yx2KzZB8UP3G2icq2i9PdpXNSuJpdR2au5e4P435amUzZV8NwYlTIDw+8zF6ErLfWCYOpvvb48NW1zv4hoSN6fFPC8YlU3+NlHpxinmq/KeJy3Fz3j/Qx3dEt6enl4fcONBtIWzQWH1yVjJBK9a14Jjp1J1P5yWqhL+QONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE6RBLog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740038325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
	b=XE6RBLogwAGAyaC8nSRcY5sY+KefFsdVfwnpGsX7noVe4dR+ge2TtxbfHnuArbBfblVp4C
	JcfL+0rIh7nOc/So4R/7gBjKHatV6U4el0kt6gC96qXCQF/OZVoP3vBoYOPSpUn5i9SoQl
	Dy8lkEy5AeJ16HISm+MqI7Vc2dmI64A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-OodVB09kMPulPDktVmovDQ-1; Thu, 20 Feb 2025 02:58:43 -0500
X-MC-Unique: OodVB09kMPulPDktVmovDQ-1
X-Mimecast-MFC-AGG-ID: OodVB09kMPulPDktVmovDQ_1740038322
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so2534955e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740038322; x=1740643122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDyq9aCOU4k6/OxS5NyOrQ8zBZnEHt3wS9LzAF8nhU4=;
        b=lhG0Of5h1WcDbWlpCvlC7MrAkmMOs5zfuwJVytYy2Eoa3KL8dNLSiagzrUie/ygaa5
         zN3TWrPhwHA7qpdjCMdtcd9LHC2JXKk84uJmjfwLHXmXPzkAK8C6wo92yd7Mi3ejF8mW
         XkSgo7pij/2Osgaz7ZmaX25+85UM9JZOoHInEyjsKNbGf6VKBzX/13y/HHVSNCDgm1YB
         A08YYQ8DClq79EybgfyodbOC8BcLW6kx/HD+x69XDMSRbicrSmaBkec8U8rq9FLUnoKO
         sm5dCwJ7SQIZDcB8TJV7isWv6rxUvyRjCfxxKBw18lgWlWV2001V0yZ04cYMsyY1lWez
         /+bA==
X-Forwarded-Encrypted: i=1; AJvYcCUX/WoyNplhLnfPJGJCz+jJv/ysnT5OQ/NjI0E5AXSemlbt12q9HxwjEk/5dx7jdJhh7MsZohg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WhVxdt5mfCwKlbjhE0g4RXS5/psiGUoY74xwDdLCySj6qOS5
	bzDi1CV7A8WIAaYHNi1/epNppMDlaXhHUfth8r7BurGXXrp5f46BI+izaB3oXc1745oRTWO4Ql2
	DIgupwxzJu7X+ZygH7tySEQ00U4GoZ9v4+uT32g+gF96c9uqOEayswQ==
X-Gm-Gg: ASbGncsXZbmiJ5BYIYhVDFzH4fNco1buJv3xwbEA4noec8B/H1Bz5b3cYO1p4/8mpI1
	ioXxeyy4jvYU0rKo2CH1O0zU7QWFyeUwRA7SIIKkmEGPVJSfyPSaPyFpyQM9q38Nd1TYyO9oQKW
	OXjmH6EdpJadrcxiHTp7U0YNAGkW614XGg+bLLV1+BvCva68+8GLnW4sVHe2vC6nUnlS4SR6aew
	g6Gce7LJ4fsa2J4uBOMQ+mTDwieWj0MCWrqSCNqK2qaLOGptGz4FMjXcowvFFyXbEGPS0rHCVLJ
	1+locajme9BEpWO/q0MEz7bcCzqkbxoRrO4=
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230795e9.17.1740038321785;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMZ/J4mT4eh+w4zVIHYL3J2TeyMMFBaqTsZEuN7XJULLXJfI3m9ZBVAO4oeESyI4i7d0LvUQ==
X-Received: by 2002:a05:600c:1e89:b0:439:9828:c447 with SMTP id 5b1f17b1804b1-439a7b81c85mr5230655e9.17.1740038321375;
        Wed, 19 Feb 2025 23:58:41 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7bcsm232584425e9.28.2025.02.19.23.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 23:58:40 -0800 (PST)
Message-ID: <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
Date: Thu, 20 Feb 2025 08:58:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet
 <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> tun simply advances iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This will become
> especially problematic when tun starts to allow enabling the hash
> reporting feature; even if the feature is enabled, the packet may lack a
> hash value and may contain a hole in the virtio header because the
> packet arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.

Should virtio starting sending packets only after feature negotiation?
In other words, can the above happen without another bug somewhere else?

I guess the following question is mostly for Jason and Michael: could be
possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
to explicitly signal the hash fields presence? i.e. making the actual
virtio_net_hdr size 'dynamic'.

> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so replace advancing the iterator with writing zeros.
> 
> A user might have initialized the buffer to some non-zero value,
> expecting tun to skip writing it. As this was never a documented
> feature, this seems unlikely.
> 
> The overhead of filling the hole in the header is negligible when the
> header size is specified according to the specification as doing so will
> not make another cache line dirty under a reasonable assumption. Below
> is a proof of this statement:
> 
> The first 10 bytes of the header is always written and tun also writes
> the packet itself immediately after the 
> packet unless the packet is

 ^^^^^ this possibly should be 'virtio header'. Otherwise the sentence
is hard to follow for me.

> empty. This makes a hole between these writes whose size is: sz - 10
> where sz is the specified header size.
> 
> Therefore, we will never make another cache line dirty when:
> sz < L1_CACHE_BYTES + 10
> where L1_CACHE_BYTES is the cache line size. Assuming
> L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.
> 
> sz <= 20 according to the current specification so we even have a
> margin of 5 bytes in case that the header size grows in a future version
> of the specification.

FTR, the upcoming GSO over UDP tunnel support will add other 4 bytes to
the header. but that will still fit the given boundary.

/P


