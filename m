Return-Path: <netdev+bounces-122942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0129633A6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D636B1F218A5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D3187862;
	Wed, 28 Aug 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRJldksO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FD45C1C
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879592; cv=none; b=ux4UyqWd2xZwtr0UZpBWbWEQINMUFmzaTqb+n2JHA5P5d+fY6n+V+V+Z9SRBsbNsl3/DrYi/DtOyfL/3iFrbsS05MAbk/T3cdGmTvvE0aysWcH7vg7VvZv4ViyeUgISah9Du3oK+TDCbafKTlXgQiRaYOpU4OmxmtzlfuUpJ7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879592; c=relaxed/simple;
	bh=kOMoRggHG6e1Yptmnt8TjPnr/TGtpIrli4PudpesVWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIOioGokvs4/CLoMqVCOn8TdREh1+NT+NFdFt62l9gY9k102tgT9Q44d5NKo36GK8BjdHV4L68kETKiUdpeFhJ+tbHiUYTPurq/w3xdEe9UWSr/fXdupp2lTjilvr9dMCwnC6LaeEvnsu/0k1aa/55sn8VATuISN+OtCYJJpZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRJldksO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724879590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pp8NTASnQBu4zNe+37uUe6R0UYN9YHQCxcsRW9hG7zg=;
	b=ZRJldksOqpmD2mr7FPXxGDM7KMwqbMidaBImGI3KtfIOuaz3UaHZYDjxDzKHDLlO64R0ye
	fKkBwQD2UjbVZf2oQZ8TouLdaMkbzE87d8qtAIkiqdVE2x0xJ7H6XfOTW/0ZaIfJuPEOp3
	b2Q+eeTU3paSAGBRLTDKzJGySwscsxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-rqzUFLsgNUeUMD9YG-k12Q-1; Wed, 28 Aug 2024 17:13:08 -0400
X-MC-Unique: rqzUFLsgNUeUMD9YG-k12Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371b187634fso485017f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879587; x=1725484387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pp8NTASnQBu4zNe+37uUe6R0UYN9YHQCxcsRW9hG7zg=;
        b=ArXHP/eOByOHaUW6wCVwdT19MXIp8KyYWrTYI9Dm+QLw1+cX18K7qqpVlbGDquoxIB
         egoQtUotu+TuFEpNxid5HqYqsXpjmCc4Ik1r7GuZwowF6hlq5VgeWv0UWJAHZbj7Ql4l
         j8vfHqhrnSKmO/4nzbpAbXqQ1H4T3aM8ZoGlpI/7DlyIGEvKyYULZjh2NIllAGrzOSMh
         y7YSleXsY/nJ+0fVCB3Ilx/sJw0rH6/wtOMLqIYiqIAcMxStzMsnKg+Zgd7apWCmH+31
         nhDLdDieOqh4YPzQgZgwkV+y6FtAjRG5biRWpHhxp7bhK5jpVSfyljZtnMD1n5wOuqgi
         FPww==
X-Forwarded-Encrypted: i=1; AJvYcCVIIgr7vLzIk0lNM/LVBdBKpNELO6MVooHlvI9G79GeVKCM5ZuYphyxlZPxxL475cs1mJ7dpI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXm9R860cuooQuP+npnu5Wbvk/sVqhWF2Vr3n8d13GejvdP6G3
	Duf2OClwFkn4YVn6O7CQB1yvNfEaK65+/IbTa3tlnxPIzp5k7LiNJTeDzj8+Y/MthnFocGFzl3w
	wnRHnMjJjw+6snW8NF8ntxkv9BqtDTlLQwgmkvG2CiW+KktjY6qnaYg==
X-Received: by 2002:adf:f24a:0:b0:371:6fb8:8fe3 with SMTP id ffacd0b85a97d-3749c1c800bmr218425f8f.12.1724879587583;
        Wed, 28 Aug 2024 14:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL49kruF4k7efTApEDE/UqMFPARkWpQbE768rMltIe+nkDxD0bHrPTPNAnrbgh81CY1wzbDA==
X-Received: by 2002:adf:f24a:0:b0:371:6fb8:8fe3 with SMTP id ffacd0b85a97d-3749c1c800bmr218412f8f.12.1724879587053;
        Wed, 28 Aug 2024 14:13:07 -0700 (PDT)
Received: from [192.168.0.114] (146-241-11-249.dyn.eolo.it. [146.241.11.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6397ec1sm31300005e9.4.2024.08.28.14.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 14:13:06 -0700 (PDT)
Message-ID: <4dbb3aba-1bc8-4c16-b1fb-e379c6f4ac85@redhat.com>
Date: Wed, 28 Aug 2024 23:13:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <Zsh3ecwUICabLyHV@nanopsycho.orion>
 <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion>
 <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
 <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
 <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
 <20240827075406.34050de2@kernel.org>
 <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
 <20240827140351.4e0c5445@kernel.org>
 <CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>
 <Zs7GTlTWDPYWts64@nanopsycho.orion>
 <061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>
 <20240828133048.35768be6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240828133048.35768be6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/28/24 22:30, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 12:55:31 +0200 Paolo Abeni wrote:
>> - Update the NL definition to nest the ‘ifindex’ attribute under the
>> ‘binding’ one. No mention/reference to devlink yet, so most of the
>> documentation will be unchanged.
> 
> Sorry but I think that's a bad idea. Nesting attributes in netlink
> with no semantic implications, just to "organize" attributes which
> are somehow related just complicates the code and wastes space.
> Netlink is not JSON.
> 
> Especially in this case, where we would do it for future uAPI extension
> which I really hope we won't need, since (1) devlink already has one,
> (2) the point of this API is to reduce the uAPI surface, not extend it,
> (3) user requirements for devlink and netdev config are different.

FTR I was no more than 60" from posting the new revision including that 
when I read that. I hope Jiri would agree...

Well, I guess I have to roll-back a lot of changes... Not sure if I'll 
be able to post tomorrow evening my time...

/P



