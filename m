Return-Path: <netdev+bounces-152828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D29F5DA3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BDA167C77
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A01494BB;
	Wed, 18 Dec 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="wuzTtuoT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE01369AA
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494053; cv=none; b=GcLYTrpP5ffqWmt5GArCOP7UC5BHv12PKhr7imzfzpTZmPD50pnx6q/S1awMZGwQAin6rZnGtETEcRmUcZGQcvnRSbTgO89sGmkUvAjS9RJktUZZS3quHq0AQDxupsJ8Hc/Lx6LnB79rvzEOCTe03kXRDNGgjs038GOkd63WkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494053; c=relaxed/simple;
	bh=vbq5pSaQYQAZoDbWUMtKbGXpx09XFyrjdoBIUarXF0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE/h4FQTKHUnqPE4XUXlk/mOsVfp+iParvs9hSlDE6R9cYGnzvaTWSOUfDzI5AQwUg4K/TF7iE38q11y6jgLIGuAand+520EDi3AZQo7x1LIGuHUB15vyL6HgOyCpAFlRDfbxwWUd0daSZH/FHOIjSvEw0Bb5m4ogW95gHTMt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=wuzTtuoT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728f1525565so7162089b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734494050; x=1735098850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7iUfh3k31vsLVZJj/3zur5Ue1fxSp8aa6PbNqmKiok=;
        b=wuzTtuoTT8577IgkN0SyiZTPBWXnu2x6RYJ4azUwLnzMrYiDxtUs9Biw8qOVrUtHaQ
         j7+RrWBh+U2GyKjgsmuJHe6GVjU7S3yND4vjJfZhGlIGHQqWJSqHsNNmXz3PDd2fsX1L
         CQkQgZ9MXoCESZeUIPnFp7P2t3Q2IHtQ7tPd/r/KwP747Uthu1i+tpkiKecmpZEGNuE1
         mgZnfFje4qD8yDsOmBotD5mtKYyJYcbZ9b0RsRap8GU5aUWMGlXvW9o4326xwRZ/YVmi
         BuXdP9645usbOC9AmWaFcdHIDRir3DbSd98h3K5JpBHo33+EfXSrNzw+kBmIork8z/oT
         UQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734494050; x=1735098850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7iUfh3k31vsLVZJj/3zur5Ue1fxSp8aa6PbNqmKiok=;
        b=nmxDW40XyfRMietFZLMRkQ3L32HmdhQbLvzmc2Et9yl4vOC/cvtPHTLhQASkkTe69D
         zeizjevrjF7qvutLBTRBruHLsS8uE0oIa6n10kbNJ5bJ6Cm43KgIeeYGdHTm28VXPptw
         7FWNdonTAc/SEUvTT3vP1CamImUBLViV5fgQThuxaFhEj3NBe2iayGzWpq/LDej+wG9G
         ZhtCQMfVCwIyul9oD9sUrHkhVktxqz6jDv/sS/AfqIZQ0JSqidCEfHNwWMkw8Suk4K8Y
         jKFnLlHoQJ8Vvq7xlGYbg5h0RFO0PKn0rY/BvXLThKgfeBGIXjp1AzzfgBCZvq1e8rDA
         Sx/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSHijULNvTh/GFtVxF6zZe70+THaqISXOZ8opg25gEp9ztEYwvvc8qdljiXZh2mFxtkYnV03s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iKxQPoOolMBPudBZYVfaP3vYds2dn5ro1TvBRhkryU9KqNgo
	KMUzehUyDWUXXsi73f9FQCBLH1JWQIiPgmL3pMm9APUsLRUdNiSegMIxBGYxg+o=
X-Gm-Gg: ASbGnct6zjEY9aGSScmFqDSVyVQ5QxO/BCNBeSVFXTI3go1XyU0pD7up9OjTTTcrEjv
	Q2OCCbEZ6Ccw6HceSdD9I3KuoYqTEdGF+Yg7LzAE92qbcutpGu/qoxH4XYEsURSTaHx0hSROgD6
	wF7MhfGCr9mEBQYhSerfVHyd0RkEhG0KZReRUH5IYt8b0jxtimSNakTpvBgsn8hgxK3OS6sDT3n
	9jWIgLzK7iSOKR3TRcAjskjijzDcVvo40n65flG1GA0JFq9KQsMHN0YuLT6OHFh3115Qtj+DvkQ
	R314zn7GMeXcPcwVykp/C0572EXqqAssug==
X-Google-Smtp-Source: AGHT+IF0Fz3irX7PoPBfqwyoZhrb0SZZKrovl8gcvdVc7/NEevlDy6djhfM+nkAHfB6ia/TMZorBvA==
X-Received: by 2002:aa7:9316:0:b0:725:df1a:275 with SMTP id d2e1a72fcca58-72a8d2c9c99mr2571206b3a.23.1734494050280;
        Tue, 17 Dec 2024 19:54:10 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b788d1sm7460361b3a.110.2024.12.17.19.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 19:54:09 -0800 (PST)
Message-ID: <06dcce52-5df2-4e78-9f7a-418c3e16e4db@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 18 Dec 2024 12:54:06 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: mdiobus: fix an OF node reference leak
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20241216014055.324461-1-joe@pf.is.s.u-tokyo.ac.jp>
 <c7b55b3d-c7a9-4d42-a6e4-64148816a80d@lunn.ch>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <c7b55b3d-c7a9-4d42-a6e4-64148816a80d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your review.

On 12/16/24 18:33, Andrew Lunn wrote:
> On Mon, Dec 16, 2024 at 10:40:55AM +0900, Joe Hattori wrote:
>> fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
>> but does not decrement the refcount of the obtained OF node. Add an
>> of_node_put() call before returning from the function.
>>
>> This bug was detected by an experimental static analysis tool that I am
>> developing.
> 
> Just out of curiosity, have you improved this tool so it now reports
> the missing put you handled in version 3? I expect there is more code
> with the same error which a static analyser should be able to find
> when examining the abstract syntax tree.

Yes, and I am experimenting with other driver codes as well.

> 
>> +++ b/drivers/net/mdio/fwnode_mdio.c
>> @@ -41,6 +41,7 @@ static struct mii_timestamper *
>>   fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>>   {
>>   	struct of_phandle_args arg;
>> +	struct mii_timestamper *mii_ts;
>>   	int err;
> 
> The netdev subsystem wants variables declared longest first, shortest
> last, also known as reverse Christmas tree. As you work in different
> parts of the tree, you will find each subsystem has its own set of
> rules you will need to learn.

TIL. Applied in the v4 patch.

>    
>>   	if (is_acpi_node(fwnode))
>> @@ -53,10 +54,14 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>>   	else if (err)
>>   		return ERR_PTR(err);
>>   
>> -	if (arg.args_count != 1)
>> +	if (arg.args_count != 1) {
>> +		of_node_put(arg.np);
>>   		return ERR_PTR(-EINVAL);
>> +	}
>>   
>> -	return register_mii_timestamper(arg.np, arg.args[0]);
>> +	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
>> +	of_node_put(arg.np);
>> +	return mii_ts;
>>   }
> 
> Although this is correct, a more normal practice is to put all the
> cleanup at the end of the function and use a goto:
> 
> 	if (arg.args_count != 1) {
> 		mii_ts = ERR_PTR(-EINVAL);
> 		goto put_node;
> 	}
> 
> 	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
> 
> put_node:
>          of_node_put(arg.np);
> 	return mii_ts;
> }
> 
> This tends to be more scalable, especially when more cleanup is
> required.

Makes sense. Applied in the v4 patch as well.

> 
> 	Andrew

Best,
Joe

