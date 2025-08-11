Return-Path: <netdev+bounces-212434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FCB20487
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F0E4E2C84
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C128201113;
	Mon, 11 Aug 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e70RdzFX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296D1A3BD7
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906028; cv=none; b=OW6crf1KM7Sl+2Qmvl6xUkFwJ/btAHYkAJYNwsEn5+Qzt85+/yMIu/WruhCfJtvl+a1IKpZgW7bvPo7ZQ8b1KgQmBs5/aBo76vSYqNyO1ROfs8ISyr667PdROildcg8vSbdnTvJJemxbItWL+5snclst5CuZUFZODYQziAFaQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906028; c=relaxed/simple;
	bh=X+/wETXg6+t+xV51UEQmour6oMA0R+27wdMYsGkvz+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChaZW+xxipgj7Z8t5cILGmgdrUZXjpFdaNADdBaQkkxHjpEBcDncrsH+2xjYwVs1IfKPQdmVsUZumWpIdDpQsKw0dnIJEQaEtM+/GaHsUpIKaWMtINb3906Rj06biPoBrazmXT/dAbUnq2yAN2DWfwKOUrSv1X+0aonRoCNVghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e70RdzFX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754906025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHJd90lJt7pKkV7L6fdhKaIxyXCO7FJPwtx28akpSm0=;
	b=e70RdzFXKzTZOfkPn172HQdxInLj+LSbF6NuLrYF7vq4yK7HyDOfQSfn5t2tVYUxCLoqyw
	Foyl2YoVn6smT5ZpriZ4HyWLTOy8/kCGP+wfdFf63Ojvsuu9v1zZrPnaoooIJq/CB6aiRJ
	O/CGlB/r/slIgrlFiYUbIT/j1MzZYw0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-h2_3JwXMN_istiiiwvXd2Q-1; Mon, 11 Aug 2025 05:53:43 -0400
X-MC-Unique: h2_3JwXMN_istiiiwvXd2Q-1
X-Mimecast-MFC-AGG-ID: h2_3JwXMN_istiiiwvXd2Q_1754906023
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707453b0307so95080336d6.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 02:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906023; x=1755510823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHJd90lJt7pKkV7L6fdhKaIxyXCO7FJPwtx28akpSm0=;
        b=lhkjt/O5nPUfh73mVwNBbeA63R9Ad5k7rjJrcV7Y0pzFLb5Mho0r+gNidCpXbwyEyU
         8KhCgqwa+QoJyv0TSfZEnq1wclndT7gO43HIDi83DoZZBTpJrFCKwkVE8nMpZKzNtCMr
         KKdDnh/SPNz1pLAGzfMfjrkd2Vm/zctf6ch5+z1j5UTb4Ye50bORjVfnLgnjXgCBuGYz
         R5R3h4PDIQmeeuZfYIuh3hNMWiwvFT5Jl8hp+YrjusjHYNEgnajdDQF3uA98Q71ua/TF
         3AAWg6yhydNPjaggMXIqtdtEw9/6qMHNxswBUHcDJSOimI9R/vpOlAMLDZUjook2d1AU
         CFyw==
X-Gm-Message-State: AOJu0Yz6PjzAI2mfznKjP0tdd3cp3UylZVCksrAPqzfdQ5Z11IvfGnOa
	tI25f/hDCopzd6PfoT87N6Et0NeVontHFB84AZBLg2uYzJJd/Q9cQwY0N60vktXaqwKPRo6x+5Y
	fi2zYcbtOYKkTepoO2jSoVvunYjUBq8pjpVIHakaccZpFr+LyuqW8q61RGDyyMxmuzQ==
X-Gm-Gg: ASbGncu9849d+4qmf7fakqGngL5Zfqz92FyHs9Ax5tfKQ2z0pWDvc8um2eW2H3eJwrD
	VTcwQC95GNEsv7y4YKfw2peB1qRhpadr4pz1U9p8rAeIpLXxKyJ3Fhi2PVYie5W6IYtDUhAETp0
	Nn64VtGdDrdc6Gb7GdlVB3HuEuYk2uZUjr3g07fq7ig9RBUAWpLiz1R72+4XZUj3uwv3zqDvtcW
	LTynjxvdJnydkJ9W3x365mPrxjhMEVpN99lCxHOpr7GOWtMF7YwGX7+Wt6nd7AJkg0GjgDAJ8us
	9Ogg0WkFS+PwcWj/gpeEB0dOG3tug+pFs0KxUgmYoU4=
X-Received: by 2002:a0c:da06:0:b0:709:9b8e:da0c with SMTP id 6a1803df08f44-7099b8edbe5mr112073406d6.44.1754906023060;
        Mon, 11 Aug 2025 02:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhDAMiPhkWP4y81WnT8aCqUZTFa3MossLf3cLQLsxAl0+cuexXhtMxG6I+EVpY/G1M9uEsNA==
X-Received: by 2002:a0c:da06:0:b0:709:9b8e:da0c with SMTP id 6a1803df08f44-7099b8edbe5mr112073306d6.44.1754906022634;
        Mon, 11 Aug 2025 02:53:42 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9dff72sm151703916d6.15.2025.08.11.02.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:53:42 -0700 (PDT)
Message-ID: <beada520-564a-481e-9f9d-91cd106aaee3@redhat.com>
Date: Mon, 11 Aug 2025 11:53:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250711183129.2cf66d32@canb.auug.org.au>
 <20250801144222.719c6568@canb.auug.org.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250801144222.719c6568@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/1/25 6:42 AM, Stephen Rothwell wrote:
> On Fri, 11 Jul 2025 18:31:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the net-next tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> include/linux/virtio.h:172: warning: Excess struct member 'features' description in 'virtio_device'
>> include/linux/virtio.h:172: warning: Excess struct member 'features_array' description in 'virtio_device'
>>
>> Introduced by commit
>>
>>   e7d4c1c5a546 ("virtio: introduce extended features")
> 
> I am still seeing those warnings.  That commit is now in Linus' tree.

I'm sorry for the latency, I was off-the-grid in the past weeks.

I observed that warnings in an earlier revision of the relevant patch,
but I thought the previous commit:

eade9f57ca72 ("scripts/kernel_doc.py: properly handle
VIRTIO_DECLARE_FEATURES")

addressed it. At least I can't see the warnings locally while running:

make V=1 C=1 htmldocs

Perhaps it's sphinx version dependent? I'm using sphinx-build 7.3.7
Could you please share the exact command line and tools version used?

Thanks,

Paolo


