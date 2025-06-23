Return-Path: <netdev+bounces-200246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C3AE3D88
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DF2163C0B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E21EFFBB;
	Mon, 23 Jun 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgkiEuOu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CC13B58B
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676324; cv=none; b=emqFaAIrRhA/RQWDiALpVJQ4pE5VHgLu+uuPkDnbZ1IGlM2+LNb2XEPTCavkeUgdYDGhUCQVYx4KXJ3PbEntMuk+o5FtaYttyTETwkxe4PdXhJm7WiwZO7l5vV1FOHtdGM/bLUDKPptKSQB9hFmKmMDcPDkUaDtdoMGWt4yyTM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676324; c=relaxed/simple;
	bh=7z/LoiUZ4ckAuHWelqzbV13t1/gO/DQPymPaZ9atChc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jno6XWnBWrM65Hi06ylmw/81ncZvZa7tRM/RcB0++gTiXV/R8naIZtzbHz+E7cSFd9NTMTGTUYXZS/J5yAhQCyR8mERjnRzBKVj/32PkC12XCPli4o3RcJUV3pW5bkf5J3v7SlAxphC31NfiXyiPFDnnzHyq+RwgajKojwnXfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgkiEuOu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750676322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcWuVqlYqc8Fv7LscejW/AotfZkWXZJQvOx/NWErPRU=;
	b=RgkiEuOufHyxnyEAjj4zHA0RkJbD935Wd0e7LLDvEtYmyXcAJyHfyRoYG+c4J2Be2vWqDV
	HpMpH/KsPDSRnfB0CUTKMNo07ymRLUjNu9ZirCg/LrrPx45p1yqLyjCbLQca/03zXOuP/c
	MgpXHulzOSnLU0kJDs9xPh9cI5pEvKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-XUSymYAZMfK-m9GOmOHaZw-1; Mon, 23 Jun 2025 06:58:40 -0400
X-MC-Unique: XUSymYAZMfK-m9GOmOHaZw-1
X-Mimecast-MFC-AGG-ID: XUSymYAZMfK-m9GOmOHaZw_1750676320
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so2007108f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 03:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750676320; x=1751281120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcWuVqlYqc8Fv7LscejW/AotfZkWXZJQvOx/NWErPRU=;
        b=NRA9+kXFvkGhBTwfjxxJYj2g6K3msXlyjr32RqRWZQXyDdU4DC19N3z4NwcuxqOXuU
         IUlA020+h1ERMrSPChEuW6rb9V5LdF9975jhUXIIi9b5HLBsEg3GYNIAtNzRa306Dl3x
         QCdf0gi8HWidBeMVFysl2Q+RPMLUltjK3AI15fQKW8alYgWRgWK71N4C78QglyBmvAM4
         VgboAsvu+y9yzNqjAsYhMsZIMH6DFY9UTI4mrpgIHvzxxZasDYWtRuMiKa3MZqbT+JKA
         bMA2RHEiZi718/W8uWiFWKtobDwkBFrolPJlV4n1/irAEKemT072I1DDqVsZ4dDD6/Eq
         cs8A==
X-Gm-Message-State: AOJu0YwFOKfLZhnkzT2W8ddFyBcADTtQ4Oiv6Oe9cu13wFWyQmMjQP1p
	ox/aQxbhuVixX5kCecH4epqo1ci97PhJ34y4BuWyZCjH/H5VgH2c/CUH4Dm6RXxVx6jcNC1CT7x
	RYiQkCeKwM049zXbjTdD9yTFUqC/jBOytEyKvdg+9prtHFOHvZLe/3Wn5zA==
X-Gm-Gg: ASbGncvJkFdGWiFDpbnt0Oen+EVF9ck2gdzbWAf0NyqMk9kwfVMfwx/NOpc4ca8lnLf
	RiKGcUoZKVfhXCsUwTZCZ+Nh74/lYxMf+N9w/jdXP/9w+oIaTepQZRAbrdxg+/PFV3fNSfI920H
	RyBGtNr5vzWnZuiQ8vu05v2ju+LFDYEoYXfLY1MHFbwSmmhzaIqzUPBWTZm82IxTqjIzTNHFbZS
	8cl4DWWnLe7R8eIC/9+ovVFYz6gt5yOXTmLR2dkXvyjLJUkj8znteNOWGYcEPTPFtAM2xMRg+6Q
	RGlyKhaF8xudwnSIxqJrmy4t2Pnb4N115atDo1ZDfCReAUnsN6Q=
X-Received: by 2002:a05:6000:18ae:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3a6d27866c8mr8793332f8f.5.1750676319665;
        Mon, 23 Jun 2025 03:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuACVKe9HFC6qufVqz8o3XpVCa/QxvhucENHMrVNmqYzlGVMUG4A86okn7ed0TQ1m9XLYpDg==
X-Received: by 2002:a05:6000:18ae:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3a6d27866c8mr8793314f8f.5.1750676319238;
        Mon, 23 Jun 2025 03:58:39 -0700 (PDT)
Received: from [192.168.0.115] (146-241-49-103.dyn.eolo.it. [146.241.49.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45366181aebsm58339325e9.3.2025.06.23.03.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:58:38 -0700 (PDT)
Message-ID: <61d10c9b-4f1b-46f6-9a52-1de9aa193a7b@redhat.com>
Date: Mon, 23 Jun 2025 12:58:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 4/9] vhost-net: allow configuring extended
 features
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org
References: <cover.1750436464.git.pabeni@redhat.com>
 <e195567cf1f705143477f6eee7b528ee15918873.1750436464.git.pabeni@redhat.com>
 <20250622160221.GH71935@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250622160221.GH71935@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/25 6:02 PM, Simon Horman wrote:
> On Fri, Jun 20, 2025 at 07:39:48PM +0200, Paolo Abeni wrote:
>> Use the extended feature type for 'acked_features' and implement
>> two new ioctls operation allowing the user-space to set/query an
>> unbounded amount of features.
>>
>> The actual number of processed features is limited by VIRTIO_FEATURES_MAX
>> and attempts to set features above such limit fail with
>> EOPNOTSUPP.
>>
>> Note that: the legacy ioctls implicitly truncate the negotiated
>> features to the lower 64 bits range and the 'acked_backend_features'
>> field don't need conversion, as the only negotiated feature there
>> is in the low 64 bit range.
>>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> ...
> 
>> +	case VHOST_GET_FEATURES_ARRAY:
>> +		if (get_user(count, featurep))
>> +			return -EFAULT;
>> +
>> +		/* Copy the net features, up to the user-provided buffer size */
>> +		argp += sizeof(u64);
>> +		copied = min(count, VIRTIO_FEATURES_DWORDS);
>> +		if (copy_to_user(argp, vhost_net_features,
>> +				 copied * sizeof(u64)))
>> +			return -EFAULT;
>> +
>> +		/* Zero the trailing space provided by user-space, if any */
>> +		if (clear_user(argp, (count - copied) * sizeof(u64)))
> 
> Hi Paolo,
> 
> Smatch warns to "check for integer overflow 'count'" on the line above.
> 
> Perhaps it is wrong. Or my analyais is. But it seems to me that an overflow
> could occur if count is very large, say such that (count - copied) is more
> than 2^64 / 8.  As then (count - copied) * sizeof(u64) would overflow 64
> bits.
> 
> By the same reasoning this could overflow 32 bits on systems where an
> unsigned long, type type of the 2nd parameter of clear_user, is 32 bits.

I think you and smatch are right. I'll use size_mul() in the next
iteration. I'll wait a little more before posting it to possibly allow
for more reviews.

Thanks,

Paolo


