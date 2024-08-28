Return-Path: <netdev+bounces-122731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E096254C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860B31C21253
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553F16B3BA;
	Wed, 28 Aug 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH/9R99k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DA166F20
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842538; cv=none; b=uPmZS5ApUmbPCHNo45uIWLip4XDXUwNe0cShMILIuSLJDVzqUkUA1jX6tfODLw8aXYHXcBhfDlY1BimV+WDe74DAOucxBVe1E4mbUIvcDzCziPWCKDOsLPaLS6VnGR0E8lKntmCIe4pJVXtwDxVfvekLyWW9HofavJJCYuO8sgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842538; c=relaxed/simple;
	bh=5kX3CalZ6MG8bS2dwPy1eLkMgEzUwIPSYc5v+VMDmXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5XKSV3nrrHtWJLMv3hTGeFXguWIryCNdrfEJozSKIMF/EWLB2GtYb0WfhojuUl4CGWsxOJ2mcZ/9aw8K5u4BB5S0a4fHKiKCqRMbwDtf/SynB4nbozRKDa7vGB9BKK3yVAPSd4moIhMlyrZ0kSlsd8BO6SHGFZDDjh18kfFvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DH/9R99k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724842536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1PPnod1b8VOMywxjRGmIDavvbk1SqdC9+jSBOChNt4=;
	b=DH/9R99khCO3LuyDlXQfBaQLdtKSBUOFpokvcayUfc/smdnDi5rhHqMdhclC7l/n0aaRS4
	RzOiWXwG4U/VjWQ18OP8emkwkQaoPKGxtPo12eXc+rBPI89C1EsIXvCXI313/eLrb0+DtK
	QVuv5gcadm31ZpimfqwncWTfbJwKOx0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-o9V2EA7PPqWilN-UswumiQ-1; Wed, 28 Aug 2024 06:55:35 -0400
X-MC-Unique: o9V2EA7PPqWilN-UswumiQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-429e937ed39so61312555e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724842534; x=1725447334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1PPnod1b8VOMywxjRGmIDavvbk1SqdC9+jSBOChNt4=;
        b=ljPjfJmrNBE2b9LxxKQLk3cU6WMNv3pr9GJnayK4XVd31KmV+9Az6Y6bQSmySUSvAq
         uNyIhFt4zlquPZsfswMD0bcJmQ54CfSxAp8Ga9LgCZ4OpwwUzzS0bXEh+rk3Og36SvdN
         qOnIKUAUXjfbMza3OE8J5ptjObmLSm+PelvvK1JJVkfX4jaEUSQCzPbEfVZMpxT7DcRz
         r8NAPbgdZxQsg3SloJKIrWdinNSkJbU8mIhodEGl3THPhyvUh9MrJSq1R6RsXPhbKu8b
         DqjLLE/PXJ3JDaQPPOYMST9IAq2wi3Z7zAvn6eZYlQ784qRhuiOXqJTveuuFQxMNEWqd
         YE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLw3hgYl50ZyT9ikPBWHpRSSvKApprdeQlcJX96V6c9hO4nyCgPJ0XskeIhL/TMen3F08PvQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Inu2D9b4USdvGw4S++8AqhGPFO8CrUOKhocKy3MKRHpX9hUt
	B484kDXC56L2G6Sy9rfMP3Ct7Je0YG1+3PFmTpfj5mRu1ZEK+emPNeq7oJe+eUteFMWr0CDiDoi
	Jhw2pnSAvKCLcWmSS1arMN+d9L9ml2kOPt5l81OZOJFCbf80dO3AWSQ==
X-Received: by 2002:a05:600c:5110:b0:426:68f2:4d7b with SMTP id 5b1f17b1804b1-42ba6692a82mr11623445e9.3.1724842533831;
        Wed, 28 Aug 2024 03:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS9PFPaRaR5tOQKG5PHb9QCxnFp3z9go/hA7XB1mHmRHSGpdVeWQQpxxA39JCiAuI/ijPjiw==
X-Received: by 2002:a05:600c:5110:b0:426:68f2:4d7b with SMTP id 5b1f17b1804b1-42ba6692a82mr11623245e9.3.1724842533220;
        Wed, 28 Aug 2024 03:55:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396700sm18475915e9.10.2024.08.28.03.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 03:55:32 -0700 (PDT)
Message-ID: <061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>
Date: Wed, 28 Aug 2024 12:55:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zs7GTlTWDPYWts64@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/24 08:40, Jiri Pirko wrote:
> Makes sense?

Almost! Tacking aside the (very significant) differences between your 
proposition and Jakub’s, we can't use devlink port here, just devlink, 
or we will have to drop the cache too[1]. Specific devlink port shapers 
will be reached via different handles (scope/id).

Additionally, I think we don't need strictly the ‘binding’ nested 
attribute to extend the NL API with different binding objects (devlink), 
we could append the new attributes needed to support (identify) devlink 
at the end of the net shaper attributes list. I agree that would be 
likely less ‘nice’.

What about:
- Refactor the core and the driver api to support the ‘binding’ thing
- Update the NL definition to nest the ‘ifindex’ attribute under the 
‘binding’ one. No mention/reference to devlink yet, so most of the 
documentation will be unchanged.
- devlink support will not be included, but there should be enough 
ground paved for it.

?

Thanks,

Paolo

[1] the cache container belongs to the ‘entry point’ inside the shaper 
hierarchy - i.e. currently, the struct net_device. If we add a 
devlink_port ‘entry point’, the cache there will have to manage even the 
shaper for devlink ports group. When accessing a group containing 
multiple ports, we will get multiple inconsistent cache values.	


