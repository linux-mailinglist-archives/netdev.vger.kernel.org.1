Return-Path: <netdev+bounces-196856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CDEAD6B66
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BB92C0356
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7105D1DF75A;
	Thu, 12 Jun 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4mhZEa/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350618DB2A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718269; cv=none; b=VrsMk5XjckSaQhCwWQbPKV7BBHwCkP9OPSHi2yppo8D6oxn97ITk9HetsevdYC1MKdPh9imSgTToy6BAg7hizReLLyR1EPhaxeSApK/+kgYM+XLnEo9BDoY/mhC84lJ85Zv5lLoaTcr0y4roiXOB45RvglrroogTDNxyKUYihzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718269; c=relaxed/simple;
	bh=z7uHiy1Rq90Nez0WhXV+HQSfeNcTTB4KHXAByMMmVoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwuAa0izSi3wRX03zBL0U7imXG/7+V4kXzrRDo4OVO8GsyV+yZo0+EZAZhLt3fUE4b5XZ21U6yBxzsxJvGoYeQVByabqUPAsHbZ3LJ/Kl+qfnlAiBI4ShIv9JawILwqDxItgo0fBuvcUO+c8ywUoUhzVWCUrEaYqGP8gVpSOAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4mhZEa/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749718266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn17RBFbf1B4M1PRLjNuAqSRGnb6I9Bg9LVV+EI8N/s=;
	b=i4mhZEa/u1ZFeFt6UuuIrCsK/2YtYlb/buOgSoeiuXTsOgq9amdB6pPbm0jZzUChdcC+yo
	qsaRn5B86QfL6/tAFiDlhcRrLO2ZrREc3os2veOx/L26o/Rztihr5N5/3LgmxAeXW3Epd3
	7sF51MZlDrMRqp0XDoYvIsP/r8Avs3M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-odHCGteyPXuaN15a1ZfiuA-1; Thu, 12 Jun 2025 04:51:04 -0400
X-MC-Unique: odHCGteyPXuaN15a1ZfiuA-1
X-Mimecast-MFC-AGG-ID: odHCGteyPXuaN15a1ZfiuA_1749718264
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-606f504f228so594012a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 01:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718263; x=1750323063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn17RBFbf1B4M1PRLjNuAqSRGnb6I9Bg9LVV+EI8N/s=;
        b=w6ODmGNltnGCGc5/JjbBg44V4HN61WwC8GAutYVs64mfITzr+fwx/rOHrRqkl50GDD
         DvfRtzxUOyHreyBromL+ed2kwTIqKGWPDzEqTb7YPd4c2/59HXvYI+JLaWTmx7qbv3m8
         MpFnTzgUmOZq4A71sm+vpsRgcC26GPRicvj4mlxnk7I75gs1zPgQzBqFf8z/PnAaJe2d
         MqrkBZILaHj+qe2umE0zWS0yRN6i8orZBQXuA5AYsWzGMz8MAdiiJdMwSlf6YAqQn6c2
         LKuBtNbrd32WkWhfy5GqGLxGzz8HSyfXOebSlOzlKW91DiizM267Eylqiv80BM9w1TJn
         Sa2w==
X-Forwarded-Encrypted: i=1; AJvYcCVz8CNMJ0I26XCg9L96g1PUnan+00DDajx1R4gKKDXltTZFGWnLdoj5+m+LfmpzB9QMQKq4F0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJjYygO345Bg2hBoL+VoSRkNZrm5cLYaneFVg9ZSVvzOe1EoD
	Imveoi8eLMtFTBmGjKU8Ptxa+ratqK+RbIbFmEebiM4sQsK/C49IZBbgaMHh8Ji6Q/hZChQxdNE
	oRGKONImn3mnSgRWNAu8e6t71iKM3cTsW2+Ugj0MOSFQw4NYB+vKnFVOK+6xR/5BnEZbfi6YwyQ
	==
X-Gm-Gg: ASbGncuswO4yZ8NHx15knei+c1L7rawFTtQ3M80bWqmzPmuUU1KT7exkAzY1VIGXY5Y
	98Tqi19BgSVIsae3zCDJzeWXiywz8baT98oax8+2gwVM1YOagBlmwJ544QBV5jo8eLPjPKgPkyG
	47laauzRJHcr1cofU1LXx4RytwIHnn9GVkWxXol/UsXJ7Ji5gv0H+qIXXcWRHqdTp54pYPWZEPQ
	1whPWWWZg7dbK/NbZJCFuzp5pfADoNPK1DWzCyyVZqBuLQfV0V4gLb5Aq0ww8nKxBiudnlHY2UF
	Fyd1DbDFNoDQB9r8uqGOTtAs
X-Received: by 2002:a05:6402:90a:b0:607:ec35:eb8e with SMTP id 4fb4d7f45d1cf-6086b2aa77emr1917810a12.20.1749718263296;
        Thu, 12 Jun 2025 01:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA+rjWOzGuAdSOSb8aWDqvCsRkz8aqFSD7TC9m1huqXBj1NGw7uETDpFeqY9+y8Sb5U3ivag==
X-Received: by 2002:a05:6402:90a:b0:607:ec35:eb8e with SMTP id 4fb4d7f45d1cf-6086b2aa77emr1917781a12.20.1749718262761;
        Thu, 12 Jun 2025 01:51:02 -0700 (PDT)
Received: from [100.69.167.148] ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086a584729sm835789a12.18.2025.06.12.01.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 01:51:02 -0700 (PDT)
Message-ID: <9a96c6cb-ed15-4598-8914-2123a8784f36@redhat.com>
Date: Thu, 12 Jun 2025 10:50:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/8] virtio: introduce extended features
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
 <165572ca-edc0-4b31-be53-065e257701df@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <165572ca-edc0-4b31-be53-065e257701df@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/25 7:49 AM, Akihiko Odaki wrote:
> On 2025/06/06 20:45, Paolo Abeni wrote:
>>   	int (*set_vq_affinity)(struct virtqueue *vq,
>> @@ -149,11 +154,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
>>   {
>>   	/* Did you forget to fix assumptions on max features? */
>>   	if (__builtin_constant_p(fbit))
>> -		BUILD_BUG_ON(fbit >= 64);
>> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>   	else
>> -		BUG_ON(fbit >= 64);
>> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
> 
> This check is better to be moved into virtio_features_test_bit().

I leaved the check here mostly unmodified to try to keep the diffstat as
low as possible. I see there is consensus to clean this up, I'll do in
the next revision.

[BTW, I'm sorry for the latency: I'm traveling for the whole week, my
replies will be sparse]

/P


