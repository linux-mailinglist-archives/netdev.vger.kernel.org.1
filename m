Return-Path: <netdev+bounces-116094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A899491AE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B6AB20D13
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC11C2324;
	Tue,  6 Aug 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnMD4qTF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB371DDF5
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950901; cv=none; b=qa0tNCuoPgxAXxV7FQtllHPI3mnOLA792AgGvL2G1W75uyzwip8Q7F6bBtHakroVviR4mJ8a1f4vKwQEZomeqO/C6GjoKd38HLCsY6d+c22FzzIt2YwC5Mtt9azBkh5jiYcjRqO7CyRKjTEWQDDyoc3Xu89/OtGLh4mqAbK5fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950901; c=relaxed/simple;
	bh=fLvIWTlzRTsZs87wYNpxFa+mx78IMbmxxIGlBKyjUFw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gZsOrWFgUNNmYsRf/gcAns7Cw0t3QEEOTncd+aZHkVEMx/NlvQVyLewX4F8cKazKkUR6/79HTR9PwHGV947ayQMXBZOxXzYrL3nYF+7Dgix0QUEzv9RFvdYxcMPYjjEVLc6Q0kTUq9cxcqXMuhWcGjDzzSSDVGaTu1/3ZNahYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnMD4qTF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3687fb526b9so313276f8f.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950898; x=1723555698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOHryhkj8Fg/bdp09KCKi4YeVq6T/vjtDm8nZiRH5V8=;
        b=RnMD4qTFnd9TsBLPsjsA5VbALlHjHBq/G+r2F79CcgoOPrSZ+x+GzuVIlzN4Ju+oJ+
         O4/+SGRsRWHH6m+NBdJH9VKQrjGaUqGpBQ6YNtSOtqRj1Dasnxx8vVurZQjiVJ8YnIe7
         ysrzW1jNbPd6wRQUb9G/wkdl+22X4N7aAFJw1MSsuYeOrvrpBAoAcCKytUg/ogFPv9H9
         FwlWe9KaBH9gbVWY3ktCiimSX2jY72klVOrTwa0jKmRJ3Au0xiakwKIENbCgaIYLvKG5
         nSXu/hxzm3W9qorD2drp+wFM5tnnfefcLz67qJwYB+a5YrT4yCU0KI+tHi5ioUdJ+gTL
         ptjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950898; x=1723555698;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOHryhkj8Fg/bdp09KCKi4YeVq6T/vjtDm8nZiRH5V8=;
        b=WhcUe/BUFofwyiA5H+JLRD6Uda/pYzKpWvfcw8Lx5ppzI6rucsHN2QwFF51w3aaRaq
         NvlU6t+N4+0nhX3++ck+tobf4ha+A0KyoTqVvgF/DxGJolpZ4JoE+th4U29e/JVcfmul
         oZF+iBi4FtC71Vh64UA9Wj3MhEBnAEhEK/KOraGKSSYW/tfvFwG434KPLxVou3gW9+lt
         P8i1vtCGwj3CWbT8Ei4WW6PmuGp5FQsuHeb57UbCb+J/KmNlkL6DPluK5O/3aa/WkyqX
         tJ4ttJS9+8aBvuSKO4FvCgiselCrqrFeMvBwrc6eV+9gXpDcdyxk+2ZUQZzTloG7U/GD
         dojg==
X-Forwarded-Encrypted: i=1; AJvYcCXTLxcfEFxAmvS2/YBVHZv23E1klZ++uVd4WSKxoxzSUkFswvwcQdoJkwURAjrT/IjyidouH5IyTEzqT5PB943r5YjOZQ/B
X-Gm-Message-State: AOJu0Ywr4/Gb25BAjRsXJ3WlMZUWAQ8EeiycRJBBvvQtocK1PS+z4RQk
	Si10E+bg3QE8i5M9uungPeuG7y/Z3gZa45PCfaaAj2y2Ie09wfuW
X-Google-Smtp-Source: AGHT+IE5nYv48id5TGBtGOA9h9qMlBZ55kQ/PsVK4LcEj4SuuPNhLRNNI/HYbY1D2+g/1J/jLhzwTQ==
X-Received: by 2002:a5d:5f86:0:b0:368:445e:91cc with SMTP id ffacd0b85a97d-36bbc0e40bcmr11690685f8f.21.1722950898217;
        Tue, 06 Aug 2024 06:28:18 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06e0f5sm12985702f8f.104.2024.08.06.06.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:28:17 -0700 (PDT)
Subject: Re: [PATCH net-next v2 02/12] eth: mvpp2: implement new RSS context
 API
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-3-kuba@kernel.org>
 <1683568d-41b5-ffc8-2b08-ac734fe993a7@gmail.com>
 <20240805142930.45a80248@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <52cbca9f-503f-25b4-aabf-461d09f41e9f@gmail.com>
Date: Tue, 6 Aug 2024 14:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240805142930.45a80248@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/08/2024 22:29, Jakub Kicinski wrote:
> On Mon, 5 Aug 2024 12:25:28 +0100 Edward Cree wrote:
>>> mvpp2 doesn't have a key for the hash, it defaults to
>>> an empty/previous indir table.  
>>
>> Given that, should this be after patch #6?  So as to make it
>>  obviously correct not to populate ethtool_rxfh_context_key(ctx)
>>  with the default context's key.
> 
> It's a bit different. Patch 6 is about devices which have a key but 
> the same key is used for all contexts. mvpp2 has no key at all
> even for context 0 (get_rxfh_key_size is not defined).

Oh, I see.  Clarify that in the commit message, perhaps?

>>> @@ -5750,6 +5792,7 @@ static const struct net_device_ops mvpp2_netdev_ops = {
>>>  
>>>  static const struct ethtool_ops mvpp2_eth_tool_ops = {
>>>  	.cap_rss_ctx_supported	= true,
>>> +	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,  
>>
>> Max ID is inclusive, not exclusive, so I think this should be
>>  MVPP22_N_RSS_TABLES - 1?
> 
> I totally did check this before sending:
> 
>  * @rxfh_max_context_id: maximum (exclusive) supported RSS context ID.  If this
>  *	is zero then the core may choose any (nonzero) ID, otherwise the core
>  *	will only use IDs strictly less than this value, as the @rss_context
>  *	argument to @create_rxfh_context and friends.
> 
> But you're right, the code acts as if it was inclusive :S

Mea culpa, clearly when I was porting to XArray I must have
 confused myself over this.

> Coincidentally, the default also appears exclusive:
> 
> 	u32 limit = ops->rxfh_max_context_id ?: U32_MAX;
> 
> U32_MAX can't be used, it has special meaning:
> 
> #define ETH_RXFH_CONTEXT_ALLOC		0xffffffff

Given that both the default and drivers look more reasonable
 with an exclusive than an inclusive limit (I assume most
 drivers with a limit will have an N, like mvpp2 does, rather
 than a MAX), I guess we should change the code to match the
 doc rather than the other way around.

> These seem like net-worthy fixes, no?

Yep, agreed.  I'll send a patch.

