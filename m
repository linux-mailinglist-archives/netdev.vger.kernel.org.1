Return-Path: <netdev+bounces-213797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38423B26B8A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B43A04003
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDA23FC54;
	Thu, 14 Aug 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY7psMrf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256618DB02
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186405; cv=none; b=A3hxG0LQyv/eBV7XTrFaVOjPorGkPXrmBF0d5USGEOiPRxMibOSRjCfkuz+JroR/l0DEuRfl+m7mtKV9eH6aRXeTlhMjFM1jKp1MUe3bNxi9ghCZxrtNzCCTKGm8V/VzyiRC6Ckf3UhX0gNyYDait4H4HomcjYAnUvfvTg1PIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186405; c=relaxed/simple;
	bh=qRa8XAJKU5FYmi1jixh5NltX8DMoaSUCmH9olrhVtwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL9MWvMuVjZqCcUZZiJdIa+4D965cnQaY5m5UdXHmjZnqw2EWzlFjLCsC9HoqXJFqDlO5smPfKhjpoFdpbVRPkkvpDn3Y0sr1CRETs84n1MG3fWGB/sCur5adYjKWnIhFBiw0mpAXTq4FMLvI2e/iN7pCln90hHpUH/jPbE6l/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY7psMrf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755186403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKCZHNwgNBuA7ag94A2PyhNJk/C5zm3fMlOuqw9Vlfw=;
	b=SY7psMrfSQ9HqEydnLijICPQWHbjbjqUI/2y/4MSk+Y9MgRY9hc1dHZm5GWnVvOovwOlN0
	JubChw6cFFY+NY6MM+Wo+sfrVSyXZaLaIQngamDwTavmL6eqX2ta/BIYhGxdv9wPRmTTXf
	74ak0LaWJNMJRC6mfiUjPD82D8WnZ2o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-bGGuc7QuMVywv8eIecLUMA-1; Thu, 14 Aug 2025 11:46:41 -0400
X-MC-Unique: bGGuc7QuMVywv8eIecLUMA-1
X-Mimecast-MFC-AGG-ID: bGGuc7QuMVywv8eIecLUMA_1755186401
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41c245fso774121f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186400; x=1755791200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKCZHNwgNBuA7ag94A2PyhNJk/C5zm3fMlOuqw9Vlfw=;
        b=HZFXdncfnHLtsvwcIUcFeNTfjS9gyFz6m0touvhtQve9mvbnmd8BrDsfmmJni/aY2l
         9qNHfKXfGo01QTBXt9r+wTzm8gCDm7X8pC38PzVVdyYJaa+iMVBbFZjcH3sndOOKzz6I
         cgv83mbN30cPpDVqTz837Cf/DQotrb/mGK9iZlZoYqKtkUtc1C8y3BiwiGsLxgHQ4irl
         hgfu+dTUFhkifjvWKVfi8LCQhLq/UWWuVd8CeKyj63fgZaQn0lBUaSaiFhhalL4KOgyV
         7j2jLUaX2gZFg2M3ujOj+iQr4XYHp0Bh8emw5gYAdWSLgwrUbfWIpqh5CDPIP3UUwxJB
         xIjw==
X-Forwarded-Encrypted: i=1; AJvYcCXzaQTB6UhIOdc1Tcw+PTl8dVcSeTws5J4RcQCveHTBjySEw7SO3cgXlFXSq/1MwwmnBCx+onU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLU+qs0p+TJPv9N3LhFp1vUUIW5QxHgg3dvMh7pth2XzNh5ICr
	D/mrn7cAS1PEQL/fKSeZIFFw12SanDp3voa+z5c4WSG2p8+FAQrMqs1vSypfMcU837BRkdTh1Ix
	JrAfEEAvLrnChoON0uV4srNWTzGl5JcoYKlhrbO7jZf3uI+Zvwxg+gjVF5Q==
X-Gm-Gg: ASbGnctIKxZFMwRzOf3spdbs4qa+XDvrgC1vfZQFcOFVO+c0OF+x5ekhO3F/CyjGzS3
	aOSx6aGi9BBFYlThJqun0InkzL1b9tZiy2KR8JI7k4TnT39mdaccjT//TRftMO2nbtXjLdsPPuL
	q+D9DuFmFz7VMElJyLZxlY+MvFfuUDb8/j0ok0tN407RMusiBZwhOTAe9s+Ro3Bwb+l9R3eSc+9
	Y/Q9Ad8UalF9V+RcVN+jIHFwUiF7J4ypf+lljp7e3cLonqaGiC4LNWNu1DV53FPq2UOxppNuc5I
	HkJYRyPKVMUK0AWv/sd2sTkylIYoqcNSrRaebPEP6Ztab7fPy6VWvcM139qk6yYLJGVzyYPJCgs
	3jQaKIt+R+Xo=
X-Received: by 2002:a05:6000:4028:b0:3b7:8473:312c with SMTP id ffacd0b85a97d-3b9dc58a019mr3189816f8f.0.1755186400549;
        Thu, 14 Aug 2025 08:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTgS3iCxATXf0eWDaHUxfdx1nyeTrSdnFsBC5UDqA6VIz4UuEEQCuBfqZdNTyXng2CAl6UxQ==
X-Received: by 2002:a05:6000:4028:b0:3b7:8473:312c with SMTP id ffacd0b85a97d-3b9dc58a019mr3189775f8f.0.1755186400082;
        Thu, 14 Aug 2025 08:46:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91b05b28fsm5028965f8f.21.2025.08.14.08.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:46:39 -0700 (PDT)
Message-ID: <3c36afe7-de39-4fff-80ae-e615b5189f67@redhat.com>
Date: Thu, 14 Aug 2025 17:46:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/19] psp: base PSP device support
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-3-daniel.zahka@gmail.com>
 <67a52aff-6f78-48ce-b407-d293fdf86210@redhat.com>
 <08961621-6a13-49ee-9964-4fd13faf2e6e@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <08961621-6a13-49ee-9964-4fd13faf2e6e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 5:14 PM, Daniel Zahka wrote:
> On 8/14/25 10:21 AM, Paolo Abeni wrote:
>> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>>> +/**
>>> + * psp_dev_unregister() - unregister PSP device
>>> + * @psd:	PSP device structure
>>> + */
>>> +void psp_dev_unregister(struct psp_dev *psd)
>>> +{
>>> +	mutex_lock(&psp_devs_lock);
>>> +	mutex_lock(&psd->lock);
>>> +
>>> +	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
>>> +	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
>> It's not 110% obvious to me that the above is equivalent to xa_clear(),
>> given the XA_FLAGS_ALLOC1 init flag. If you have to re-submit, please
>> consider using xa_clear() instead.
> 
> This was actually a deliberate decision to use xa_store() with NULL in 
> psp_dev_unregister(), and then call xa_erase() after from 
> psp_dev_destroy(). psp_dev_unregister() is called synchronously by 
> drivers to uniniatialize psp, whereas psp_dev_destroy() is called once 
> the refcount of a psp_dev goes to 0. A system could have multiple psp 
> NICs, in which case policy checks at the socket layer need to compare 
> the pair of (spi, psp dev id), as opposed to just the spi.
> 
> What we were going for with this decision was to try and prevent an 
> attacker from trying to quickly trigger or wait for 
> psp_dev_unregister(), and then try to bring up a new psp device with the 
> same psp_dev id, while a socket may still be holding a reference to the 
> old psp device. So we delay calling xa_erase() until after all 
> references to the old psp_dev are gone to release the id (xa_array slot).
> 
> Perhaps I can add a comment, because I can see how that would trip up 
> readers.

Indeed the above was completely unobvious to me, and definitely a
comment could help long term maintenance.

Thanks,

Paolo



