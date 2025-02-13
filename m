Return-Path: <netdev+bounces-166132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD1A34B7C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB516C0F5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8F1C863C;
	Thu, 13 Feb 2025 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaXJvBPX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D21FFC75
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466786; cv=none; b=dRR3DyvQJi2yQ54SC/ULn1ReybGSEv7sF106zFazVXtrOUgv2prD1xSTwiMazpjh6RqAhJPHySktQbUl/W9Rq/4w5MZ5fCT2xE2IEo06qGC98c4AXIl972mDhFcAeEtRLoHE6r1emVsfJOchN7j4KV4GlDv4zKKYywAAKr6LAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466786; c=relaxed/simple;
	bh=0GZ69eyNE1N4uiNq4iczn+3mHzCxciNa6ttKLEikQ+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHA4Nxc/K5fW3fvpIxnbXNRa75+r0vAoS5sQsae8cZI2QSwnwMv6qzSVwkLzZmM8rDG4gEBMqqTKCTT8wq4rim8MyMMrfARh/bnAnC9RFsXRoI1gugZrhlrZyiFdB9O196hwXtY54RlwqgZTxRuj+jKMfCg7xGB/lcv0mwxFTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaXJvBPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739466783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ltDbX9KEAdbsG/W4EuHH+sXIUdOFwfPGk5LTGWC0SY=;
	b=VaXJvBPXFuT/2cJdsab2ittE415kTCZv02FtpItXqqtD1WGKflhj9yJootk5aLjUKzipG8
	fLUBLDGXAIMe3gfuaweNM/xJdnamwP82kzn/6j2IxXExqH+1FBOb4KHse0VGRbJJCKFSef
	Mah7ORTPSMYTatV33ppg4PwZwPrIqVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-zzsPLAQPPBiONBY0ur7jdA-1; Thu, 13 Feb 2025 12:13:01 -0500
X-MC-Unique: zzsPLAQPPBiONBY0ur7jdA-1
X-Mimecast-MFC-AGG-ID: zzsPLAQPPBiONBY0ur7jdA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-439640a1a8dso3925305e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466780; x=1740071580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ltDbX9KEAdbsG/W4EuHH+sXIUdOFwfPGk5LTGWC0SY=;
        b=noy5SQjacm/IVClyll4Rdrd+92lkqLW/kMme2zH3ZF6oydJI080VNKM1FAjxkTSOhf
         T4mUoNsclmvgfzfLpzmgE+ffApv1cIaiCEckwZ537hZaNfbr1qa+AEPvPf/SQIFDHtto
         ostkqp7B/j71rKB3QnO51YiCadclRSwUafi6iZ9rP5eRplyadDPLqTGVxrvJJQ0P6KgR
         e1C/7iXTjdmy8gWVHPNMTSZKmItPGPCabS+MR9cyxJujh6iDdRHyUtXleCtVwriGbXKb
         zHx4jBySBZ+6PobgCe1gwmELRxNlxUxLZ0fvcJm+Lb4vK5T66IPrUE/4x1VZduwMSuaP
         azIA==
X-Gm-Message-State: AOJu0Yyd1EbOZxCFYalfzppL6/Gvz4+1mwCA48j5n539gaPoiYYG+/ps
	EE03jNEA2OQC9Aou+9/vt3YO/6pMdbdOevxhUJZocCQKj5TulSf93Xf2NiLnaVvSfFP+Gsb3JV/
	hsaxZlRdpKqv5/2blFheTJk24G0bQ698bajgBZLlyf+bv9seEW0EzcQ==
X-Gm-Gg: ASbGnctlKGeMri9g8REc0wdZemdRbBerYLt1a9JEwqVYNRFTh2B/J6NybBEskLeqpa2
	bhaG7P+m4JQXxJIl+BY6S/pkIHUHQYadiXE51Y4gbZoegjg66lWMhhL1qcg6s24BPCv7y0yjfj5
	50d/PDV4FvF+sCB9meaG1WkSC8RWOIodKAOnDNZIrcfZ4OsuTB0dFEc/+WLfu8znqkqvJ6GlWPJ
	B3NnZ2VO/7FsA4k7aIygdHlKUrCwTI8MgPF9BZ9+4wScJ0V8pyn0+X4eg/+9yex5fJDGrN4QMEv
	PFfVnaQmui6GMLd94bJk5xmb8CX33Cb8+6s=
X-Received: by 2002:a05:600c:4e16:b0:439:3050:1abc with SMTP id 5b1f17b1804b1-4395817a5edmr93856245e9.15.1739466780552;
        Thu, 13 Feb 2025 09:13:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtTz73sGL0amgxoVi0AIn5/OLrwPdW0aUTYBPcG9DHJi03I6bWDq1emTkXoJ1lX/rzOvNqRw==
X-Received: by 2002:a05:600c:4e16:b0:439:3050:1abc with SMTP id 5b1f17b1804b1-4395817a5edmr93855835e9.15.1739466780140;
        Thu, 13 Feb 2025 09:13:00 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm2435158f8f.39.2025.02.13.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 09:12:59 -0800 (PST)
Message-ID: <12199ed2-ca9e-4658-9fc0-44e5b05ca7c3@redhat.com>
Date: Thu, 13 Feb 2025 18:12:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
 <504a90ea-8234-4732-b4d0-ec498312dcd9@redhat.com>
 <CANn89i+us2jYB6ayce=8GuSKJjjyfH4xj=FvB9ykfMD3=Sp=tw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+us2jYB6ayce=8GuSKJjjyfH4xj=FvB9ykfMD3=Sp=tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 2:44 PM, Eric Dumazet wrote:
> On Wed, Feb 12, 2025 at 11:08 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 2/12/25 9:47 PM, Eric Dumazet wrote:
>>> This patch still gives a warning if  MAX_TCP_HEADER < GRO_MAX_HEAD +
>>> 64 (in my local build)
>>
>> Oops, I did not consider MAX_TCP_HEADER and GRO_MAX_HEAD could diverge.
>>
>>> Why not simply use SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) , and
>>> remove the 1024 value ?
>>
>> With CONFIG_MAX_SKB_FRAGS=17, SKB_SMALL_HEAD_CACHE_SIZE is considerably
>> smaller than 1024, I feared decreasing such limit could re-introduce a
>> variation of the issue addressed by commit 3226b158e67c ("net: avoid 32
>> x truesize under-estimation for tiny skbs").
>>
>> Do you feel it would be safe?
> 
> As long as we are using kmalloc() for those, we are good I think.

Due to ENOCOFFEE it took me a while to understand you mean that we just
need to ensure GRO_MAX_HEAD and GOOD_COPY_LEN allocations are backed by
kmalloc to avoid the mentioned issue.

I guess eventual nic drivers shooting themselves in the foot
consistently doing napi_alloc_skb(<max small cache + 1>), if any should
be fixed in their own code.

I concur using SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) as the limit
would be safe.

Will you send formally the patch or do you prefer otherwise?

Thanks,

Paolo


