Return-Path: <netdev+bounces-89884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6888AC0EF
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3624D1F210EE
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 19:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EB3FE2E;
	Sun, 21 Apr 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJYXt8o3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAB17BA9
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727420; cv=none; b=mhVYfY+23Fi2bizxCOxVOwuY7qz/BubPNgrQpHuwx0xATJt/DXsN+Nactkdbtsw6fwEAtJWWTDTBudTLro80QacdBcGOUujpS/V6kxn6RWDCjdGbOgg0Za+wFhFzIK/aE2MOlhTeEFNDtc2CJGTjculUVSRGUDrMJD62hyH9ABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727420; c=relaxed/simple;
	bh=ko3baWa0bXarvAUBkLoisnJ87lFgJ97JsurMB9rDxfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeKTz+y9qsgAYMO8oOZ7EdvlPUvxbSje375mRrRlYu0tLUGfrbHk+zBHhujOxcuCGIxok9/2q6aIcG43/uOurgEdeD7fDbNV0BjGYoTrP+nRF3KbmjGqfa1bmhiOxUoaIdgJj/OFh2onW7RjfntXsflO9Qn9BySGTgqtmF9Gy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJYXt8o3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-437b3f256easo18510351cf.0
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713727416; x=1714332216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqhW4D4jLVsKH1utbHDn/iKJztmh2klhA7VKP20qINw=;
        b=YJYXt8o3ISIOOewEaP0VkMBiYskRWkaijkP77qqV275dtOHf4fGO3AYekbZ2+NH9qu
         ir2kRyADd48L3HOnKxn+logXIIFNoHhp1A10YbKNGrhXANPjHvI37n/YZ6uL7tx76YzQ
         WE29s1Gxv8rnVw6yiiTbzOvewZ5JlqCetlyt8Pdj0UBLSq5CsNzNVcU3l/mEuGsgw1Kh
         r3gp6K+bMoP9z4olFRBNCbmCAS7DtMS9meakHSUgVF/KOerCio3PRsCsrh1E61jGW/Z+
         84t3TT6pTCgmCEDE3g4Bmbfj9fSQD2Vd5/5ReVYDzbolFDzDcMP/5miHVOUasFA5f+6N
         gJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713727416; x=1714332216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqhW4D4jLVsKH1utbHDn/iKJztmh2klhA7VKP20qINw=;
        b=MlHRMRY6rFLH+NqQiDF7DTBRdQJrbusc7T5L184Jv0QPrZVsesrt0wDe1JGAtF1SK3
         pV65bwXt9NIAzsBVMSSEliY2tdyZHLQjGPKTt1qpw6YMaa2M2qely5y5EZwg4MhA8WBE
         4fjlAWvttZ24Fu4UATILWl36pbcDO28p9g7xUcbiVc6E4MBQ+D+beXb8F0tqwa7cYMYn
         YgzRt+8uIQnMLz9yfHnAF8kuhjSgZz3wEvJBiwJE+tmEpS3QtnH3Tc4QjYaDbcCQXxiH
         T4/D71P8kI5Gs4aNceXMhoaLldW0K7C+UfYQ3+iVgrm8KgrUsY6EMTq+icSCmW9XQFRT
         561g==
X-Forwarded-Encrypted: i=1; AJvYcCUofNpEIAeto06WqhGEQzTGiQ5ec8mqPKa1bKzt80ytCV8eF924ge4zyjoOWw3609J54plRrWJTMYPDH5djRvTnQuywYoxd
X-Gm-Message-State: AOJu0YxDs8s1zNSm95bF5RGDiiiqeOfddfnDKmltlm31DtPSaLwADqmF
	KMKXBGxX1cm0B0O2CLSKgDozmIMmxuVdVybrt794iUfEIH8gYHanRvyWMcN6xTE=
X-Google-Smtp-Source: AGHT+IFG+MgI9P5zvYhi3oK9zNce0+Wm/zV3xYro6FQoOvWRlykWswFzedE1EssCx/FegZrr7XDg8Q==
X-Received: by 2002:a05:622a:1a02:b0:437:9f6e:81be with SMTP id f2-20020a05622a1a0200b004379f6e81bemr11102550qtb.25.1713727416517;
        Sun, 21 Apr 2024 12:23:36 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id w2-20020ac84d02000000b00435163abba5sm3604873qtv.94.2024.04.21.12.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 12:23:35 -0700 (PDT)
Message-ID: <5d580dd8-8510-4754-982a-131ea994923e@linaro.org>
Date: Sun, 21 Apr 2024 14:23:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mailmap: add entries for Alex Elder
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, quic_cpratapa@quicinc.com,
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com, elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240421151732.2203345-1-elder@linaro.org>
 <kabhsybtcfg6ky46rwry462dpql2k6mcrnb7w7xtb5d2httg7r@lg6rbbmaiggp>
From: Alex Elder <alex.elder@linaro.org>
In-Reply-To: <kabhsybtcfg6ky46rwry462dpql2k6mcrnb7w7xtb5d2httg7r@lg6rbbmaiggp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/24 11:16 AM, Bjorn Andersson wrote:
> On Sun, Apr 21, 2024 at 10:17:32AM -0500, Alex Elder wrote:
>> Define my kernel.org address to be the canonical one, and add mailmap
>> entries for the various addresses (including typos) that have been
>> used over the years.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   .mailmap | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 8284692f96107..a78cd3d300eb1 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -38,6 +38,18 @@ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
>>   Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
>>   Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
>>   Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
>> +Alex Elder <elder@kernel.org>
>> +Alex Elder <elder@kernel.org> <aelder@sgi.com>
>> +Alex Elder <elder@kernel.org> <alex.elder@linaro.org>
>> +Alex Elder <elder@kernel.org> <alex.elder@linary.org>
>> +Alex Elder <elder@kernel.org> <elder@dreamhost.com>
>> +Alex Elder <elder@kernel.org> <elder@dreawmhost.com>
>> +Alex Elder <elder@kernel.org> <elder@ieee.org>
>> +Alex Elder <elder@kernel.org> <elder@inktank.com>
>> +Alex Elder <elder@kernel.org> <elder@kernel.org>
>> +Alex Elder <elder@kernel.org> <elder@linaro.org>
>> +Alex Elder <elder@kernel.org> <elder@newdream.net>
>> +Alex Elder <elder@kernel.org> Alex Elder (Linaro) <elder@linaro.org>
> 
> Isn't this form (with the name in the middle) when you want to be able
> to map one email with two different names, to two different addresses?
> 
> As described in last example in the "gitmailmap" man page?
> 
> I think thereby this would be a duplicate with the entry two lines
> above?

I interpreted this form as meaning "change both the
name and the e-mail" but I tried deleting that last
one and it still mapped properly.  I also just noticed
that I mapped @kernel.org to @kernel.org, which is
dumb.

I'll send v2.  Thank you.

					-Alex

> 
> Regards,
> Bjorn
> 
>>   Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
>>   Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
>>   Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
>> -- 
>> 2.40.1
>>


