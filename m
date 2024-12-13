Return-Path: <netdev+bounces-151732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3059F0BF5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF80D28278D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38EB1DF263;
	Fri, 13 Dec 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv4EpTPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E3364D6;
	Fri, 13 Dec 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091999; cv=none; b=Vv4wRW5cZQc9oGOfHf+hg1RI3thJaF0A5kYR97+7+pGT3MkImu5+elpBm4qK8s9Q9b5LiEsOO3emdcL1xAwShNltwUPV7dKbGVY3qmV14MrQ1EX7ZohCx1dFbvoU2aQq9bpZr6kIzWtLbfqBOEpatEalGYN11NOKQBxf1lr69pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091999; c=relaxed/simple;
	bh=QskZQvslLVj4HjbQl2uk8qRIKosHAzSG0q42ESxfpZs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I/qwzQDwlu7PCN6D0p8Ue8RWxKp5d4ATe5kbDgRvmY3Ki/mpOey6oliKEy/jMN/17NHQCjhNr43pHvniHXn1+qMfDPinhO2jT4xHR2r77uoK8QhB4kiBuzoU9z+JZAIrJcYNGZCBrr2kkkkij0HdluaDY7JgWhf1nhmKJbnIBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv4EpTPm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa69107179cso320757266b.0;
        Fri, 13 Dec 2024 04:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734091996; x=1734696796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHoWAaNUTau/ZJNAbGaTAOeFqOn+pvI6Wnww/slr7kA=;
        b=Yv4EpTPmFdnuulp5ByZ1D6ByB70sLqBFxvcWHsUnc7KdhzLIlN5syXyIkOXgfmjBZv
         EGr3CGftPF5aSda5ouW5CWFE0kgc7XfKx4gTnc2G5F2a5iXdZMEk5A7qOUiA/wKn+A4E
         aVN6qBAPluF9WUu1vR0q3mPdTdohJnmsVB4ZmeCApo/lqx1ANX+mGlZNQHvet5SCrjiV
         YIb7wfrZx6fkqDIas4jWBmjTR++25lqNaiiA0SBUjM9wWuhaR3dVvxH274Gh08F/C1SR
         dtUnBx4xPpCDbcxMZO3OPnKLFzbBg5LtDVu34DiWH8iU6TaJHrLpfGHrD1+xfbgg8IeR
         Hq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734091996; x=1734696796;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHoWAaNUTau/ZJNAbGaTAOeFqOn+pvI6Wnww/slr7kA=;
        b=AKjYduvpAYQXXJpEgczF1pDTaza7+5kg+B1e+vZt+IaX/SKUnTzyWt8FRh4jOjFVAO
         HTKNlLNcJxsJimBFJ2o7tdR7Wv6vytSQRectGWgcVvoXTGKKfOjVjrLshXg35v4TUJ/a
         F5hB5hRRgyZJi1IVlV73LeKu+LLUOknwSkq6kGlk4gPBAiwXtDAYVUyJ0ymxFFncX1RM
         0VzTBwovf5NhYhXPrd3ww8Jn/cx4JAZVlvbmJbFrN10pQHivQ/qWJLKWoNn5iX8hnvNr
         O9+lq/aPcbhrJ9QhHwE8UtU/NtOBZQjEG8xSDrx/B63JoA+rA9yjGiyMY7SfA0w18eo8
         MKpA==
X-Forwarded-Encrypted: i=1; AJvYcCVN1gW2N2gOs2rvz0jrtneUlpgaoNqeNAnA7rJ9KIM1ThoeWtzm/VxwiKCDRapYzrmNXnr8HS1a8pCvTkU=@vger.kernel.org, AJvYcCWcv8HTSvmibUP5Xm6V5wU7eTKEF28jD0ldQOAayC0+FUCKOW+7rhPdRZu9+bTx8C0dGtwY34HT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5nixJ8tkbP4M26+cGB0Y1MSh4LmZ3wmgKljy2m7YnwArFmvl
	LwyIw3K9/DW/+WnKRUJbeYf17pZ5G3d2QBwNXl637XtCLRS0z31I
X-Gm-Gg: ASbGncuCXZO9TvsJIQ8YVyqTMDZgRYLBoWCYbOoKTlsHpeOufOtonZrgAcMsl6jculH
	9pVGfy7fQ/b0cH46AawF8uNiGvc/maSTjpWWqBiCxyvQNxZ1xAIDmlrD1eBWMwCNtXjveT9Tc9N
	X9xsX609fsRDx8mD1GSv5oM6C10z577mBlD1aloj3nKhnDlyL92es0ZIK3pn9siVyCRNV10Pk8Q
	oKieVETaKILXauI8JYw4MlG50UJvd6yVm0Meh4PSWXq5R1UNoFgtCde4nlWhzf4lPoZF34uAvq/
	vhbUCdhND5YcLSXnvqh+IidLVac=
X-Google-Smtp-Source: AGHT+IGBBvwkxE5NmXU5QgAu7OuBzh2HW9LMP3QsXo4HrCgIjBobtQKUTzQc5xVS25c2bA7mVA4Q4w==
X-Received: by 2002:a17:907:1ca3:b0:aab:7588:f411 with SMTP id a640c23a62f3a-aab779c8bcamr239272066b.25.1734091995997;
        Fri, 13 Dec 2024 04:13:15 -0800 (PST)
Received: from ?IPV6:2a01:e11:5400:7400:9783:96e5:406:9a59? ([2a01:e11:5400:7400:9783:96e5:406:9a59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab8dd35b19sm12355366b.33.2024.12.13.04.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:13:15 -0800 (PST)
Message-ID: <cdbe92eb-0d35-457b-b661-d7aaf4026984@gmail.com>
Date: Fri, 13 Dec 2024 13:13:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gianfranco Trad <gianf.trad@gmail.com>
Subject: Re: [PATCH] qed: fix uninit pointer read in
 qed_mcp_nvm_info_populate()
To: Simon Horman <horms@kernel.org>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20241211134041.65860-2-gianf.trad@gmail.com>
 <20241212170400.GC73795@kernel.org>
Content-Language: en-US, it
In-Reply-To: <20241212170400.GC73795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 18:04, Simon Horman wrote:
> On Wed, Dec 11, 2024 at 02:40:42PM +0100, Gianfranco Trad wrote:
>> Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
>> If qed_mcp_bist_nvm_get_num_images() returns -EOPNOTSUPP, this leads to
>> jump to label out with nvm_info.image_att being uninit while assigning it
>> to p_hwfn->nvm_info.image_att.
>> Add check on rc against -EOPNOTSUPP to avoid such uninit pointer read.
>>
>> Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
>> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
>> ---
>> Note:
>> - Fixes: tag should be "7a0ea70da56e net/qed: allow old cards not supporting "num_images" to work" ?
>>    
>>   drivers/net/ethernet/qlogic/qed/qed_mcp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>> index b45efc272fdb..127943b39f61 100644
>> --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>> +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
>> @@ -3387,7 +3387,7 @@ int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn)
>>   	}
>>   out:
>>   	/* Update hwfn's nvm_info */
>> -	if (nvm_info.num_images) {
>> +	if (nvm_info.num_images && rc != -EOPNOTSUPP) {
>>   		p_hwfn->nvm_info.num_images = nvm_info.num_images;
>>   		kfree(p_hwfn->nvm_info.image_att);
>>   		p_hwfn->nvm_info.image_att = nvm_info.image_att;
> 

Hi Simon,

> Are you sure that nvm_info.num_images can be non-zero if rc == -EOPNOTSUPP?
>

In the coverity report, the static analyzer is able to take the true 
branch on nvm_info.num_images. I didn't physically reproduce this 
logical state as I don't possess the matching hardware.

> The cited commit state:
> 
>      Commit 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
>      added support for populating flash image attributes, notably
>      "num_images". However, some cards were not able to return this
>      information. In such cases, the driver would return EINVAL, causing the
>      driver to exit.
> 
>      Add check to return EOPNOTSUPP instead of EINVAL when the card is not
>      able to return these information. The caller function already handles
>      EOPNOTSUPP without error.
> 
> So I would expect that nvm_info.num_images is 0.
> 
> If not, perhaps an alternate fix is to make that so, either by setting
> it in qed_mcp_bist_nvm_get_num_images, or where the return value of
> qed_mcp_bist_nvm_get_num_images is checked (just before the goto out).
>

Makes sense, so something like this I suppose:

--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3301,8 +3301,10 @@ int qed_mcp_bist_nvm_get_num_images(struct 
qed_hwfn *p_hwfn,
   	if (rc)
   		return rc;

-	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED))
+	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED)) {
+		*num_images = 0;
   		rc = -EOPNOTSUPP;
+	}

Or the second option you stated.

> And, in any case I think some testing is in order.

I strongly agree. Let me know if I can help more with this.

Thanks for your time,
--Gian


