Return-Path: <netdev+bounces-205093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A45AFD478
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7F5476E7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD32E62C2;
	Tue,  8 Jul 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECGMAPn5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECB2E5B3E
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994026; cv=none; b=R5EX3p6RhEWtk64unX1ZkXbonvvdxDk49E8SNFXhkrtpiCJvfXOIg7kC5iZg/qfsqjyx0G3QpTTKb+mFmS0hy9p9ZT22lguvW3F9Gb61onlohRiU9UKBOGyGFMdQMi6N1rwEuXjtvSzfiBE7RX4GEpMbqbM0rk37cD5CyD4GrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994026; c=relaxed/simple;
	bh=vqmP40l2sQm+jo5YrbdEYj98+Uk19D7cUQ2Z6s1E4Hg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g2ALVxvB7nksVnUQIo1yhLrAsfObinqPGyoCOJR02vmoeeigyHd/kJgH2eNwUWVIazPJV0FI9Rwu+z9DKrXqJjarPoumj6ikjOFfeRJIrfZah/xZ2Vbww/OU3OM6MgVjyU/b5TBYp1uHcWXhxw/6aLiJqnkCkB1mcePLZR/vYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECGMAPn5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751994024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOAUOdDQ/Ohpve7MT0b5vBpxcHJyYUTcEvYHV9S4P7A=;
	b=ECGMAPn5LrV70INWAjv/wks1TyciBzQEGQvV8MfGa0BMUEfKsBZsmHfZLc8fAy20hGIQHw
	nUD6ETqsVVWPjHwEVIoOf7Pt8k9BFkOuLFwLbrIUV5WdJwmGZQgABXk1HBJcAE48nPWjOq
	rzde0zkD585akeZcH9sPxIYndturZVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-6H3XbQ14PHCavhWURSUiEg-1; Tue, 08 Jul 2025 13:00:23 -0400
X-MC-Unique: 6H3XbQ14PHCavhWURSUiEg-1
X-Mimecast-MFC-AGG-ID: 6H3XbQ14PHCavhWURSUiEg_1751994022
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so24684375e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 10:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751994021; x=1752598821;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOAUOdDQ/Ohpve7MT0b5vBpxcHJyYUTcEvYHV9S4P7A=;
        b=ABO+p/vqAW6iiDV3NGFnH0GUttkt509bvjYNcPEy+NI10gTqGLvyobGa48ieS+lqA2
         L5ldukXqvgayw+WMLLXcdJjxo4kyl4jKhzOLqrWTSURvne0dCZTFp8NBhjstYv/RD0g2
         DdTrNSDVY7VwZdUELtoN1EFQg5P8cOQF6OzAjVJzw8QXrXiLu75OkL71jSXU2o6tmM95
         /S9pltcFC6UkjaXp7TAfQ2aCuc4YJaHCDwYbo3jpOtd1FoSedmOm4npjSMDH7Bv7lnIv
         jvQInVbfvPz0Dz4/ZjiEpAFdteXoZ8zrKpdRubzqzeCr+KHuRmsP4Fs2gypTfMRcMWhm
         0inQ==
X-Gm-Message-State: AOJu0YwWto02XjHstH4W7JSwMGyE4sxzUn0L6RkpgRkkfv80ADaS5pOn
	ir7Nasrcw/jcvL/yR5pCn31GYE9SQABGqlUWyRY0RGVAwYNHFYnKjYp8hRTl8yOxw3nAh8bXNZJ
	4tCWfFFroHOYLfMkLV5hkGairwxcEdaquWw8VHnFrypTOOsNc/yDOsKMMbe/J43jkwQ==
X-Gm-Gg: ASbGncstc57WHdTyPjn27l+TX2aTRyc6OHHi2gzy1GDU7SeZnys9Ozl4yhhm13a03hl
	HAcZTj6qBG5wLqoKxPxZcnO1f2fqhWfPzV3mA9PzaUA58x8yEpy8/ELi43k++YPfHIOT+CE+sxw
	9I840SJH8xuKqF+f4oQ1Fo8QtHvEmT8hnr3ky7PDN+EgqbuGF6brutqoKOoItDd7axzqr0xmUMI
	IRj9LTVbsHx4u0onCKSxqN5K4VyngRbIhgdGHtx8A4Z7wxHcKZU8Nru6K5TTtUYSuzzROYZ3h7M
	0H5h5coQo57kNHYo9cNNBjztrO9u8jslNXm3TOo8nJQniRzOeg/1zsDt2CVqRV94sFEMYg==
X-Received: by 2002:a05:600c:1d1f:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-454d3564b66mr5873955e9.0.1751994021589;
        Tue, 08 Jul 2025 10:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs2z8yosruby7WptbVhLXHCy2dc1fLMqvjmukcchZaNusQYuScrXtah/V+6PVdS+yzg4/ynA==
X-Received: by 2002:a05:600c:1d1f:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-454d3564b66mr5873475e9.0.1751994021106;
        Tue, 08 Jul 2025 10:00:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd39d0f6sm27320025e9.16.2025.07.08.10.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 10:00:20 -0700 (PDT)
Message-ID: <ef9864e5-3198-4e85-81eb-a491dfbda0d2@redhat.com>
Date: Tue, 8 Jul 2025 19:00:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 0/9] virtio: introduce GSO over UDP tunnel
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1751874094.git.pabeni@redhat.com>
 <20250708105816-mutt-send-email-mst@kernel.org>
 <20250708082404.21d1fe61@kernel.org>
 <20250708120014-mutt-send-email-mst@kernel.org>
 <27d6b80a-3153-4523-9ccf-0471a85cb245@redhat.com>
Content-Language: en-US
In-Reply-To: <27d6b80a-3153-4523-9ccf-0471a85cb245@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 6:43 PM, Paolo Abeni wrote:
> On 7/8/25 6:00 PM, Michael S. Tsirkin wrote:
>> On Tue, Jul 08, 2025 at 08:24:04AM -0700, Jakub Kicinski wrote:
>>> On Tue, 8 Jul 2025 11:01:30 -0400 Michael S. Tsirkin wrote:
>>>>> git@github.com:pabeni/linux-devel.git virtio_udp_tunnel_07_07_2025
>>>>>
>>>>> The first 5 patches in this series, that is, the virtio features
>>>>> extension bits are also available at [2]:
>>>>>
>>>>> git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
>>>>>
>>>>> Ideally the virtio features extension bit should go via the virtio tree
>>>>> and the virtio_net/tun patches via the net-next tree. The latter have
>>>>> a dependency in the first and will cause conflicts if merged via the
>>>>> virtio tree, both when applied and at merge window time - inside Linus
>>>>> tree.
>>>>>
>>>>> To avoid such conflicts and duplicate commits I think the net-next
>>>>> could pull from [1], while the virtio tree could pull from [2].  
>>>>
>>>> Or I could just merge all of this in my tree, if that's ok
>>>> with others?
>>>
>>> No strong preference here. My first choice would be a branch based
>>> on v6.16-rc5 so we can all pull in and resolve the conflicts that
>>> already exist. But I haven't looked how bad the conflicts would 
>>> be for virtio if we did that. On net-next side they look manageable.
>>
>> OK, let's do it the way Paolo wants then.
> 
> I actually messed a bit with my proposal, as I forgot I need to use a
> common ancestor for the branches I shared.
> 
> git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
> 
> is based on current net-next and pulling from such tag will take a lot
> of unwanted stuff into the vhost tree.
> 
> @Michael: AFAICS the current vhost devel tree is based on top of
> v6.15-rc7, am I correct?

Which in turn means that you rebase your tree (before sending the PR to
Linus), am I correct? If so we can't have stable hashes shared between
net-next and vhost.

/P


