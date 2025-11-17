Return-Path: <netdev+bounces-239070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2CEC63803
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75DB3381DDA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA14258EE9;
	Mon, 17 Nov 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgBjRhiv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKDL81uZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A22773E5
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374349; cv=none; b=s9WYfC5DQfmuWoqAM25nVx4Pl44YX+Gp8sGNtHqbdF5K56kfNfp10GvKWZeF9SUf94TKfGuMwUqNPSMrhNJpRZcabjt3rqMuQpb2DiP524DSbj8dT37FODfO3o6iSAj9mQP2vtdHBKQMkzwNOMlfxsCdXLxZ01MgpptSledIgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374349; c=relaxed/simple;
	bh=CbXx2MwDmeepoNsVAnv/ib6Yv8SpxnAp2vU/CztUC0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6SDlinP7jYFRr1pBifqsBNTxcr+td/MMHSEXEzmP54LQyJITUESxavNdxSbjbkhmEiXH+fjwAXH83eg7Q++3/897EtsA6jBYrRjNBsLWJHIn7ZR9VwvwT6EHkcqcA/3UHyvP6L6Cg2/l+kI+ixNojOnH+tmTI4NPWw+klUeTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgBjRhiv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKDL81uZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763374346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zncjTQqPZzk4cXbDtL+l/by7XSRLqUhrGuMEs2VfYmc=;
	b=AgBjRhiv9cjnX++cLpewVJ5slou3Qv0YaVfWhn8w4wST2fCljo5YecUTxd2CYlMZBbe2i7
	Xf0wkqqJuzDyk+/xxdKj0u7jVp3pSEFtOLXDTP+VPua60x15z12MMVCVC4tQUGh/58a49D
	bG3jNxFAqfVhLkMgXfvKOXSuwil+fYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-neahLrFnNiyAq3HEAgekjA-1; Mon, 17 Nov 2025 05:12:25 -0500
X-MC-Unique: neahLrFnNiyAq3HEAgekjA-1
X-Mimecast-MFC-AGG-ID: neahLrFnNiyAq3HEAgekjA_1763374344
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c95fdba8so2145813f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763374344; x=1763979144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zncjTQqPZzk4cXbDtL+l/by7XSRLqUhrGuMEs2VfYmc=;
        b=ZKDL81uZLmoakBmVPrhO0lE6nX0qjV2w9Ss3kFFwGfO0DKgf7h6v1pbkJtN0PqaeEK
         434FhEM10PNo5ZmS99M+6nOnt6LsFOF6vxo3mzRDk84HAtzkOAtYGOrQ//rTrCC8jexx
         h7YYuRGPx/SCP5zbMeLKxaPWuTv+At1HlIalJu0Ca2Rg9aDYyJRGwgzPrJZzM1cxRtpW
         +GT/y2y1+j57d+LdOGLBitisOFX3KMiRlDLQssiSvytjd68Jrrph0ALBTM6KcRT6BBkt
         npJ3crnnj2m+CRriSVjZPBwN/1aXKk0TASxRAFsJFd1ymy/w74T1oIsrKW8c0dv5l7Tu
         x7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374344; x=1763979144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zncjTQqPZzk4cXbDtL+l/by7XSRLqUhrGuMEs2VfYmc=;
        b=RZybbraF9NToMxsjE7NgfctEiaKiL2P7jr3ZBi+c8gmcKosmhjpxx07GO+J21Ug+vj
         PddELxmVeuf8Qx/mAAQovOejj6HlZXKeJq0+X6lIGtbRin6P4f8IAMsJ4zQEEcTcDy74
         7qi678QVRk9Zwji7tILPpF9Qskr4Mn5SmFr39Mvqmd0VOz72Mk3lfKWohrZQVcusx1Ql
         ZQAD3C17XXK31XqeqkDjZSD0spKlXwB7sAZe14odcceo9aHtF0gbGN/iT33KWq5iKyKi
         XOmq33JEHGIYI4x6PapoICNBlIcT47mPr7G7SDiqRzqFMmpb4F93qXTMKHvON9LdPTxU
         Q4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUoWeqMGkPnBV/AhPi2anWXOfCDUXmKti/1Ke5GcbS5ifItELwjNxhMhokIWYT74lWlMfFcc3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCklDHYWHlgUM7XuPYduq8HTYTFOG+cniI62qTJY8UkLiRYcA1
	cnD5Z51HrixjxX03rD77uKo2/YFVpwQo/fabRNJwLO+79c+ZSkhxzyzKG38kHvzOHq0pfjwuBHQ
	Zl3Cffh+Rl+KhV4YbOeLiAnd7n9uva0VE5PQSdVI6HtjNWDb/pTt/y4BK6A==
X-Gm-Gg: ASbGnctOnMYuuAiPgCH+huFB29V33L9Agq6Ldm3SFuVgiFZsRRZkdnQ3Dx6UbPbUOZ+
	Uxqj5AQjQlsEA69nlUvbkuPnuf5Q75cBEziSOJNLp7wXcb63uzaZ4ckSkaeuk1DWPcLM13xUqLQ
	bvXj5z4P3eVnlw6NcUIrRGzGrQo4egN+9osgFWElwSQVU0bRvYrOeRw2f7XMotdV/dQ752vd4IJ
	l2iIBabcuhxHFjwlFcuW7ri2WEM+am4lmMvgKMKy4RUCUfmPKvRzPiidKVuZcoOZYKqysdPMJ5l
	Du4aDD8exp4jXDvtYcAt2Y6FSLkahVYCpoVrwUJ47rMAhrA+mKftWeTDer0GaqGXJQ4U1MGfTGc
	rHXzGhbitBLn5
X-Received: by 2002:a05:6000:2509:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42b5936c71cmr9947370f8f.30.1763374343653;
        Mon, 17 Nov 2025 02:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4u81kWSQMevYnWrt/EGAk8IS9/Yiw+ZaDletTZC7VriVAPpg2eZbzSNPe7qG5leF2xm4aBQ==
X-Received: by 2002:a05:6000:2509:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42b5936c71cmr9947331f8f.30.1763374343261;
        Mon, 17 Nov 2025 02:12:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae47sm24872955f8f.4.2025.11.17.02.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 02:12:22 -0800 (PST)
Message-ID: <74e58481-91fc-470e-9e5d-959289c8ab2c@redhat.com>
Date: Mon, 17 Nov 2025 11:12:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] net: use napi_skb_cache even in process
 context
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251114121243.3519133-1-edumazet@google.com>
 <20251114121243.3519133-4-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114121243.3519133-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 1:12 PM, Eric Dumazet wrote:
> This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
> with alien skbs").
> 
> Now the per-cpu napi_skb_cache is populated from TX completion path,
> we can make use of this cache, especially for cpus not used
> from a driver NAPI poll (primary user of napi_cache).
> 
> We can use the napi_skb_cache only if current context is not from hard irq.
> 
> With this patch, I consistently reach 130 Mpps on my UDP tx stress test
> and reduce SLUB spinlock contention to smaller values.
> 
> Note there is still some SLUB contention for skb->head allocations.
> 
> I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> and /sys/kernel/slab/skbuff_small_head/min_partial depending
> on the platform taxonomy.

Double checking I read the above correctly: you did the tune to reduce
the SLUB contention on skb->head and reach the 130Mpps target, am I correct?

If so, could you please share the used values for future memory?

Thanks!

Paolo


