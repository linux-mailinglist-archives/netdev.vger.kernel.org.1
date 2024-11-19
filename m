Return-Path: <netdev+bounces-146039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F09D1CB5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688BB280D0B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0EC11CA0;
	Tue, 19 Nov 2024 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCCgVTd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C788825
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976951; cv=none; b=OjL6SChYK6InZlhOQpl91TVLiMayUx5PXEvKDN97dFOGhDuAPt9ayQj4/rNbNNYRRBYigEHeEOEc+16pbuApKMo7Y+HiY1yWvOOqSo2cAKPT/zSqIVZHCXILYKyTdzK3dlWk5l69Ur8rXFFZsw/0+PwdYvA6PORhOneDqJVysGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976951; c=relaxed/simple;
	bh=4HP3ArdbDUUp3uCfdoRC8k3S3jJsykkqvcmZV8y+Wq4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pDeOpQPENMWyJ7MIcSjIxoNBCFeYt2BhdRkVRC/oar9XhuF65CSAMEQOo1cpZ1EiS578adiKvd8t7YMxdgnR9zy8Ptq1wdaPtT5xNSydUpw0Ji9ssJiO2jl49h6ySljqeIYV0RcOxiepRC/fV7gUPlT3HKNKo14RGUl9NYlx0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCCgVTd2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382442b7d9aso303733f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731976946; x=1732581746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+cFfxwLbCy69jsriXcVKjb7EvWRcojaMA9thGXMomU=;
        b=eCCgVTd2v1ad3cD6PkRti/i07ulBNgll5ihql7KMHKu8q5cWo08LrziAA9ajKBVd1r
         5StXuWgv7VtR6OOje9Y0Jv+GkFf8Iw3Sw7A6LbDrlCN0uOsJHk2/b+XJxyej2uBAkc+I
         jmG7S3xmkDj9QQGvhvNVX1DNSDjt89UtyheBwwNn9tVPhhfB0hBJqochFLkfZzxWfS75
         96qbK9Hbif/3x+5vG5HylFjob8KGRRcCucnv69KtdYUsPZXlYmw2AFESl2Ki44xwazpk
         I/EkfqYZcMmyIlAR7mtNLaQZggrBgpb+kSNC+lwvZnXMH7qs9ME0whqW/F/mfLwX9YJ+
         ihrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731976946; x=1732581746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+cFfxwLbCy69jsriXcVKjb7EvWRcojaMA9thGXMomU=;
        b=Cq6y9Tghhhm86gwL1ju98/sHhANut6bfz0CBBLLCjGatwL0Uzrcaak0GC4j7JliZSI
         UNZPCDR8eTyZlOOtFAca0FzG09AQCN1o+GIxKChbZ7JdZ/rUQBYcrcLYIHI5WhKHe1V/
         Nh5OVKaHvkrm0F/hgkfK6emC2lSo9UbDtOz7Jj5kaoB6pzduCtgRdpYF2k99TYDwHtAy
         rLO64P79PDFRN1W5dYJizPYKOLFAXnOF5Mr46ob5OjbM8O3FI8Gr32EevOXV0ueZac0k
         zbBK0om4FF/Jfk42jAQPRw3o1Sd8I9eYBTaUCn3spjHirUcy1SsJ1TtDkVILOpb8mVHL
         6E1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXRMUFRKs8ekevE5QPDdwvoEPOffvIeF+QAFVJX3+C659Lek6LhwyTvcn3VGJx4eFV7bfjsCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsEN1VVD+Nz+w7671a68ffUAut/HMF4lfBzg3EZGR/Ci011wr
	qOMqfXg9IYpwi/32sP7fYvOyU1LXMk6V8/MBtHdBE0aH6cCjJYjK
X-Google-Smtp-Source: AGHT+IFbm9isXcTv4+BFPK08vcciJrrKrtvYK6VfqESWfceo9arSvKoPM7xZcjuW5N3KjwtVQTjsTQ==
X-Received: by 2002:a05:6000:2c3:b0:382:356a:c927 with SMTP id ffacd0b85a97d-382356acb61mr7916569f8f.9.1731976945548;
        Mon, 18 Nov 2024 16:42:25 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38232ec369fsm9495444f8f.70.2024.11.18.16.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 16:42:24 -0800 (PST)
Message-ID: <2a0a2cc4-5eca-4fd3-bfe8-28e9026fec02@gmail.com>
Date: Tue, 19 Nov 2024 02:42:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: Add WWAN sahara port type
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: =?UTF-8?B?SmVycnkgTWVuZyjokpnmnbAp?= <jerry.meng@quectel.com>
Cc: "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <KL1PR06MB6133B5403AA55BC79C13FF3B935B2@KL1PR06MB6133.apcprd06.prod.outlook.com>
 <60875bc8-bc45-4168-8568-38ec73499d1b@gmail.com>
Content-Language: en-US
In-Reply-To: <60875bc8-bc45-4168-8568-38ec73499d1b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hell Jerry,

On 14.11.2024 22:16, Sergey Ryazanov wrote:
> On 14.11.2024 10:45, Jerry Meng(蒙杰) wrote:
>> Add a Sahara protocol-based interface for downloading ramdump
>> from Qualcomm modems in SBL ramdump mode.
>>
>> Signed-off-by: Jerry Meng <jerry.meng@quectel.com>
>> ---
>>   drivers/net/wwan/mhi_wwan_ctrl.c | 3 ++-
>>   drivers/net/wwan/wwan_core.c     | 4 ++++
>>   include/linux/wwan.h             | 2 ++
>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/ 
>> mhi_wwan_ctrl.c
>> index e9f979d2d..2c6a754af 100644
>> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
>> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
>> @@ -263,7 +263,8 @@ static const struct mhi_device_id 
>> mhi_wwan_ctrl_match_table[] = {
>>       { .chan = "QMI", .driver_data = WWAN_PORT_QMI },
>>       { .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
>>       { .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
>> -    {},
>> +        { .chan = "SAHARA", .driver_data = WWAN_PORT_SAHARA},
>                                                                ^
>           White space is missed between the port type and '}' -'
> 
> Please run the checkpatch.pl before submission, and use git-send- 
> email(1) when it is possible.
> 
> 
> $ ./scripts/checkpatch.pl net-wwan-Add-WWAN-sahara-port-type.patch
> ...
> total: 6 errors, 6 warnings, 33 lines check

One more thing regarding the patch formatting. Just noticed it. A 
network subsystem patch should indicate the target tree (repository) in 
the subject, either it should be 'net' or 'net-next'.

This patch introduces new functionality, so it should be targeted to 
'net-next'. The subject for V2 if you going to send it should be:

'[PATCH net-next v2] net: wwan: ...'

See the '--subject-prefix' option of git-format-patch(1).

--
Sergey

