Return-Path: <netdev+bounces-106408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDA9161C9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9EEB264F8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDB148FEB;
	Tue, 25 Jun 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFX8jyWQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69A13A252
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305901; cv=none; b=VbvBywK4BmaayTnVRVbRGmc0f5NlST4Gb8/S38TMxNLSMb558LaK3QZiizaJsHZ6wFgUnWZqHtuX7olcTqeOK2NkKc1Ac8Wxu/OuaXrZ7bodL4rncBe6WJzjG+PM1kWaM1P1kRaoT7bB4EX7lFp6G7uuXqej2wE+v33JNh/EfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305901; c=relaxed/simple;
	bh=uTVX8GdxWykfycgqxYUlzBto+PCQMsdvfsHvOGeShsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNrQXhNFzUlVLwq5JYalFp5tReb2lGJejnnEI5YpJwCStudS2L/ixRZTsXVfPTHJyX069Q4NA7MPVa2DYQAGDXxh0LPJ6W7Bs5RNJeKehthG1i0vKinpLI0aiEOVvkpxnB3nczZis15kcRp3qIEbCGTaY/MJSwJn4YMmK5kGZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFX8jyWQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719305899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2DQgsiVYpvT7nraIJ2Iv95FUT/kwO4t7HI5ICfquezo=;
	b=iFX8jyWQ2HsWzJ1g2WteZKEZDEusoFHUgJW57WgmGuu4vdkamzCOs5Ft3JrW5fAhCmGj5Q
	WaUWFo5Hna7rVtK7Cpkqt9XB3Y9Sgb+AA00lSqdENihfEUIc6euOg5LcHkkb3CrZRQ9huj
	k9ZvmSXhD6SYQJo7lYuyCH+wDQgFAm4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-GRnNxgHMMSS6k8onJafZSQ-1; Tue, 25 Jun 2024 04:58:17 -0400
X-MC-Unique: GRnNxgHMMSS6k8onJafZSQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1ccdbf82so231495f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305896; x=1719910696;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DQgsiVYpvT7nraIJ2Iv95FUT/kwO4t7HI5ICfquezo=;
        b=AKF4IvwiwGbGbqTGy9AnyVKH+Yui7Kd1g4CG2o+lwVcPvPxvlwbh3xXLwCswM4JDRR
         SrPwWOXovD/1nR6GaoNnEQ9qqXtXgbvSxCv+dlKd8664njbBlvszNGBu/7p8x/g7tFkb
         3WW089o8PXDHiX0+FQexFi5ud15vQofnTooRrSt3wVPum5wEIl/QmswTZxDxV3npfmag
         2+gGhkEeQfXmNmiy5akKwxHPb3XkZ+zN0mKkRkJBxvm/bKJ/apPJPw9UJkVwZTja5zXe
         b0rJ+EiDP8QHEf0g8KNA/CFlw7pizTp8449D3NszviznPcsIFJS08H6/rWWkNkngGbfi
         E4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUujHV6QpIxG1Faoj1+BbMqVVsixH/FfG950TK9NmKWRvCVOYBEh3OVXBxVCtJw45LwK/OByKk0nTeP4LP9MaBm7KJBei9K
X-Gm-Message-State: AOJu0YxF7okJg0EhrAlHzqlRkDN+juHnM9+iyu2hFB6FVAxjZrhSoxgs
	tFU9wtaMU/io57JOYSMnKpem7NlWDSr3kb+Nb8xWjIXhuQ4EoO2BubBaHhY95ANwh+neAavpdFc
	npDLYPN3+nAHJXG2Zre/L/vcxBKjBI7yIuhohm2eb95k/I1VbnXdczg==
X-Received: by 2002:a05:600c:4749:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-42487eeae0fmr65085855e9.2.1719305896597;
        Tue, 25 Jun 2024 01:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGajrCaPQzvzZef5/bQdgE8vdBabMFabTf09Z4D2aEzX0WMA2D1XZuJciOxjvQf9jKMBOPP+A==
X-Received: by 2002:a05:600c:4749:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-42487eeae0fmr65085665e9.2.1719305896192;
        Tue, 25 Jun 2024 01:58:16 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8451sm12352589f8f.101.2024.06.25.01.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:58:15 -0700 (PDT)
Message-ID: <94929c563aae0f84c4a75d214f329db048ee4763.camel@redhat.com>
Subject: Re: [PATCH net 1/2] ibmvnic: Add tx check to prevent skb leak
From: Paolo Abeni <pabeni@redhat.com>
To: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org
Cc: nick.child@ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com
Date: Tue, 25 Jun 2024 10:58:14 +0200
In-Reply-To: <20240620152312.1032323-2-nnac123@linux.ibm.com>
References: <20240620152312.1032323-1-nnac123@linux.ibm.com>
	 <20240620152312.1032323-2-nnac123@linux.ibm.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 10:23 -0500, Nick Child wrote:
> Below is a summary of how the driver stores a reference to an skb during
> transmit:
>     tx_buff[free_map[consumer_index]]->skb =3D new_skb;
>     free_map[consumer_index] =3D IBMVNIC_INVALID_MAP;
>     consumer_index ++;
> Where variable data looks like this:
>     free_map =3D=3D [4, IBMVNIC_INVALID_MAP, IBMVNIC_INVALID_MAP, 0, 3]
>                                                	consumer_index^
>     tx_buff =3D=3D [skb=3Dnull, skb=3D<ptr>, skb=3D<ptr>, skb=3Dnull, skb=
=3Dnull]
>=20
> The driver has checks to ensure that free_map[consumer_index] pointed to
> a valid index but there was no check to ensure that this index pointed
> to an unused/null skb address. So, if, by some chance, our free_map and
> tx_buff lists become out of sync then we were previously risking an
> skb memory leak. This could then cause tcp congestion control to stop
> sending packets, eventually leading to ETIMEDOUT.
>=20
> Therefore, add a conditional to ensure that the skb address is null. If
> not then warn the user (because this is still a bug that should be
> patched) and free the old pointer to prevent memleak/tcp problems.
>=20
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ib=
m/ibmvnic.c
> index 5e9a93bdb518..887d92a88403 100644

For some reasons, this one was not applied together with patch 2/2.

I'm applying it now.

Cheers,

Paolo


