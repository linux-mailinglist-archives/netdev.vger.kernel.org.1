Return-Path: <netdev+bounces-245700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245BCD5E3D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8021F300E806
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201EF314B62;
	Mon, 22 Dec 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYaLTHIV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf6lSbHc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADB310629
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404690; cv=none; b=C6ZUhes8MTIgS4A4bAHQhN9nQxMttDM17Zjd8ZpP5QNuJH4CbQsWkaMBmT6MPL+7A/n6BUvk+Cr2y3+dnOOouXKzVv0eEa99jvSHWZ+3FLHMu+0uo404xV4Mwvg3RIDuY1KGMzPlHR/s4cfsZCLrMKxCEYopOWEmST+pzkT9vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404690; c=relaxed/simple;
	bh=Y6ymdBuHFXIFtcbNCFI8HRsRKRMfhKrlCr8RRBNi/EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htgSDNLXqxh4tadeB20suc/p/BKdcf8sLYcufnLPkG83VKRl9nuL1mNBv6iopWpJ3WiU/bJKOyXu8MjFxEPWKc/JWVFNAy0pPBSn4/VmsmgHEbv4IHNYLgyjBhl7WO2jrjV/5oO+eFvIjsdXLB3bzKYu7Ns3pxgRiUalBWfkHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYaLTHIV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xf6lSbHc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766404686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
	b=CYaLTHIV8LQfge9t21aIxBhEAN3yW1WAZHiiVHy6suK1KQR6qNnthKj6Vv5zCDqS3QPbHy
	dX4RzWFwdA4YKCNcrOBhAX39ogm9B09RtBTDxXaxzQnr4IVzfH674NOOylH3BpmnvRz2ox
	h9OEvbtT5Yw/NKHBppWmAKtIOO7a78w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-27hXbenAPF66u4fsTYTKKg-1; Mon, 22 Dec 2025 06:58:05 -0500
X-MC-Unique: 27hXbenAPF66u4fsTYTKKg-1
X-Mimecast-MFC-AGG-ID: 27hXbenAPF66u4fsTYTKKg_1766404684
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so29677185e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766404684; x=1767009484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
        b=Xf6lSbHcqs8PwhcR1lyLwqwMf/d6Z07bHbnL9X2uvUwxbRHYueNypM97DgKrUnv7j8
         PDSohSNnP4IuUcel5KtSPUfR/38vgqKHmI4vml5s3lLOU2qlD7J7yCApm21ucwXtzXFd
         ehY1NCJt12R9Ns3HnLHWqNjsOpxQvsG8UNCTfs44zcMAIJf8JmpxW/LoMs4AZGEe1LP4
         W0w/4xjM3HqQ28sASnhXzc1XUEtaWlwqnFA50Tz7Bb4pA3VifgJGSRI2WOU3tMu6I4ol
         Y+DDudotp+7LXM1Oz5sfEkD9dEp1q1q4XZjWXovZF18l185Aea5mhiQilqVKE2u6uUyx
         uY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404684; x=1767009484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
        b=N5oZEICbgN9EZaNHUMrGADYOPg8s6DJ5ESIgK3cDT/u/pph+saqpUESfVHiSKXV0Ri
         GL+cnt1CEVBwTgaJahgA9k+FytgUe7y/SE9rkGqa4Bau6X4IAXXGw22p35QCFnvNGG7J
         jblggqNbkoKsFaAxGO/TBl3GA8fpKlwNiTXR5Pm59yF9YhMw9IKUlxGvxB/xzR3gTBPc
         aKTo79N/Ljk6aVTwXIRunj8i8DFW5iMbZs+DMx10TBpdKIakN4mDzXbaxso4qxeslOjN
         UxfUcXFEoxGGjOLlylaLUtSONq0GgHm7+cL5ZOnARer6t3FX5QotApTSRS6XXpRslaPT
         doMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGV3NIv3aaZUFwEzBol0yQ24Fjw5bYGRimeDz4vRfZf0YOQhLLTbHcrmEv0gdZKh+3L6YkSvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVcMWmwBFJOe9H1eu9isafNms4XzLH425NbAMvOBb23oOlcNo
	hUt7tLteb2152EbwK+XGXefaUOrKORAcfkAo3q3RoxHisOIxdynIlpbrqr3MaNcZUtasWORpLGX
	fBX3KCaYBuRaEAQJmES6+XR0Z+e7db1uFoq6DjU2kftuW1ToV53SvoF9aaw==
X-Gm-Gg: AY/fxX6g5lVKe+7EPI2zmmKBU6N0ZFlYFuKXVRp3B5WcdTE247oVTHb3Pqte0A2LV08
	76sjeC6KQNuZ2UQqpeTd1SehM5Vt9AOb60X9sHVDor3KUWLLQbrS3HWlBZX2wPQ3p5rU0XUqGKD
	qwvBfBjg6fmy1aZUgQxo7Ya/oRyNwMSvNjW6uL0kM5KwCmIQgw2+dLLUjCm3KyJ8H4PWF8IO+xW
	O0aXpCuNDeF11AE5nxYlYG9KfKwqRjqiE7bs5VXd4s5WbCgjuqUnxjeUc9Ii27RL+jOHhoOSInQ
	dZ09fHBPagEmWLh+dCKx2/vBZP46Jj0s1gHWafN4Tp9tnmxwfLN87/VYn3PEOX3FZWyRq6wT4h3
	VIe2G6PZEFgp4
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr103621365e9.13.1766404684294;
        Mon, 22 Dec 2025 03:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeV6Qm1+Tt8w1qhLiA6tTt299NR05W/UxteZMkGMX6sQ+7Yl9QWOwxUWib7gajoXvCn4TXoQ==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr103621055e9.13.1766404683858;
        Mon, 22 Dec 2025 03:58:03 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm21593237f8f.39.2025.12.22.03.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:58:03 -0800 (PST)
Message-ID: <8e69a404-18bf-4c91-a6c7-59d5ae831591@redhat.com>
Date: Mon, 22 Dec 2025 12:58:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
 <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
 <20251221084218-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251221084218-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/21/25 2:42 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 19, 2025 at 12:03:29PM +0700, Bui Quang Minh wrote:
>> On 12/17/25 09:58, Jason Wang wrote:
>>> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> I think we can unconditionally schedule the delayed refill after
>>>> enabling all the RX NAPIs (don't check the boolean schedule_refill
>>>> anymore) to ensure that we will have refill work. We can still keep the
>>>> try_fill_recv here to fill the receive buffer earlier in normal case.
>>>> What do you think?
>>> Or we can have a reill_pending
>>
>> Okay, let me implement this in the next version.
>>
>>> but basically I think we need something
>>> that is much more simple. That is, using a per rq work instead of a
>>> global one?
>>
>> I think we can leave this in a net-next patch later.
>>
>> Thanks,
>> Quang Minh
> 
> i am not sure per rq is not simpler than this pile of tricks.
FWIW, I agree with Michael: the diffstat of the current patch is quite
scaring, I don't think a per RQ work would be significantly larger, but
should be significantly simpler to review and maintain.

I suggest doing directly the per RQ work implementation.

Thanks!

Paolo


