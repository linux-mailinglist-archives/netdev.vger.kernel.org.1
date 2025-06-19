Return-Path: <netdev+bounces-199598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A675AE0E7B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7D41897F42
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A32472AC;
	Thu, 19 Jun 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8w4AlcD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED62376E0
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363994; cv=none; b=bBknYHe7ViFpY915gycrxT4y29hQs/LlSIpP33NnrPWOQJa85l8PNgdC3ox3LMUytYpcj+Flb+9jhk3CR198+zfOdgixM2EShWR8qyt/5GNBloasGAuJhheYsRSrC8IZKos6j8zKIClNJArGqWml4Nn1WFvUECMk0iTQ4BQmDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363994; c=relaxed/simple;
	bh=R1Jth55okgsxQ0Jk3aJ4nlbCXSceUo1VzGYD/1Rj4yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnlhsppevdQdi7CaDxaeZzlJ3VS+CDmj8fMV2GHffaJKBSstxXoGgzGn3rLYOWnaFT2cV1r8ZYNrgLw/ltPCXALaf9F7Wh+gJ/gydOpMnmdwcFukgltZggIkd3p0pGx7D66cZ9lUQd6/KCUMFHkRC22qk6LRd9sx9UrbYYaa4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8w4AlcD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750363989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUyCPJPpMqR3gDqMInJSoS/7xTpHf9LiEmfvVCx5ENo=;
	b=Y8w4AlcDcX2vDunxMocAmnAdVUMEmDZcohi2V39VKUqJctkBOTgog3AZ4mrTqSTDIshdYr
	xiItYpnXpv9lY8i7ndEPOIUBxcjTj1PSHrmKTE++doHQDG5SsjBJAKLYm6tT2p14hzLgIi
	2ZUwspY7XLBpPZ8u6/gcxea0l/ZHHcI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-7j1WHe47Ppeo-TUjs8bhKA-1; Thu, 19 Jun 2025 16:13:07 -0400
X-MC-Unique: 7j1WHe47Ppeo-TUjs8bhKA-1
X-Mimecast-MFC-AGG-ID: 7j1WHe47Ppeo-TUjs8bhKA_1750363985
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so507273f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750363985; x=1750968785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUyCPJPpMqR3gDqMInJSoS/7xTpHf9LiEmfvVCx5ENo=;
        b=I5TDo3ucaoMrPkgTXM2wSBitCbQiWhyCOE3kbM4DhRVS1s6dwNkTiodrKKI0HgZ1zE
         UwVPVZPfF4KSL/uUBFBNRpOipb4nrttb42kyWMZ3LjQxYrKQ7OJ1kZ7FN9iQ6LjDSGoZ
         EMcx3kvhnUTuAcjB37NteJbsT/YMXpETkDp6agUosAF9sfFWBzELQ75NFMn/rZHwbyfc
         0g+2f0a/ya13VNUaUNwbicaU0gkO3RQMrhS1yNa82mErF91sY3dp2Mk7xwm2FNFDRNHy
         eZps05ca9pNC2Ie74ywaJQLUUyspbbMnp4YOZxIWGDfH5kBq9gj2ZwI2lap9njvklGbj
         AtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcziDfgM0vXD0X9Z5AdmYrqS96AGh/Wgunhr+t+nNylibmsRS0+cjCxlySrE8Z4vHv0D9ayAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6AaVV62tcVuXje+bgbyurSYCKbvH/Avqat00CLl85MEWB8er
	b519KVDMhHN/HK0nWTs/+G6l2NHe4kIH/h6bj7R4I93AO4R5cT+2LiP4DpCUp9+bRgqcMtS5Vpd
	ITvyrMK0YSyVtKSJz4C/MVMeeYObRUun2dGsnnZ/0lTXqdr/WCq8tpLLn8g==
X-Gm-Gg: ASbGncsQ4kH/ZrWIJjEKE7s58ixv4snhOmwhEhpxwJUFyRWO4XlBDOu5vGousdC1RRF
	+efYeLYjfK/RiziCqrcye4Pz5ID2WdrvMYkYU7AJIp7Vl04dDEwoovpfejLmWpmABch6WI5jQkW
	/G8zb05AncENtI1uHWuI35PZKGxFKVHL7f+BmY7mqcfW6MK1jReNDWyhtK6uKuQ82YhCS12Az3I
	Zx60rDUOKYZSbKMxxxa5GFGoVfGXS+oew5QZOLWg/Qgxetgm1xJT6LbT+IiDhh7oaahgXQhMX9n
	AAZs+fW4LdDgLpYGw0p+Bm3KbQ0U1i7V3AkUj19l90M=
X-Received: by 2002:a05:6000:3ca:b0:3a4:fa6a:9189 with SMTP id ffacd0b85a97d-3a6d1322bb1mr242393f8f.31.1750363985005;
        Thu, 19 Jun 2025 13:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsCPwzZnnZjhdWE3AMrcqQzbKjIvWxjvQ/0H67BeC+xcbY5FHAPTI/p3rPhLrvYbdXmd4Eig==
X-Received: by 2002:a05:6000:3ca:b0:3a4:fa6a:9189 with SMTP id ffacd0b85a97d-3a6d1322bb1mr242377f8f.31.1750363984647;
        Thu, 19 Jun 2025 13:13:04 -0700 (PDT)
Received: from [192.168.0.115] (146-241-9-4.dyn.eolo.it. [146.241.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c71esm236887f8f.61.2025.06.19.13.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 13:13:04 -0700 (PDT)
Message-ID: <52a8b6c1-1e3c-469e-8598-74f5b1cd417e@redhat.com>
Date: Thu, 19 Jun 2025 22:13:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/8] vhost-net: allow configuring extended
 features
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <c510db61e36ce3b26e3a1fb7716c17f6888da095.1750176076.git.pabeni@redhat.com>
 <e9ca64b4-3196-4b7b-822c-4bb0b40f8689@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e9ca64b4-3196-4b7b-822c-4bb0b40f8689@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 5:00 PM, Akihiko Odaki wrote:
> On 2025/06/18 1:12, Paolo Abeni wrote:
>> +
>> +		/* Any feature specified by user-space above VIRTIO_FEATURES_MAX is
>> +		 * not supported by definition.
>> +		 */
>> +		for (; i < count; ++i) {
>> +			if (copy_from_user(&features, argp, sizeof(u64)))
> 
> get_user() is a simpler alternative.

That would require an explicit cast of 'argp' to a suitable pointer
type, which is IMHO uglier. I prefer sticking with copy_from_user().

Side note: there is a bug in this loop, as it lacks the needed increment
of the src pointer at every iteration.

/P


