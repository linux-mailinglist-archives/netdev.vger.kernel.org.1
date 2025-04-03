Return-Path: <netdev+bounces-179031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39323A7A1CB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6BD175621
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130624BD04;
	Thu,  3 Apr 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLXKiPXV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56494746E
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679542; cv=none; b=t9G2xJTexYkb8LBIM2BZxld1Q6BLsinX58piV1gJ3T2QXGEwPkhSRQH+fra1opmeU8zwr/6eAsDMapvq6E3HjzaiQ3bKZWnHmLKjdsuszkgHMRGiNsW5EofnRVJ5P3lSJofzilEa2rP+Uq5bBy1c5h7UcIaelbkcdu6/qbWv2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679542; c=relaxed/simple;
	bh=uJzeXkywSQw59n4/+BNNQlcbbq6h3WRlXGrN3bCMe1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4UlV0qw6hYfhIJYir2DOCCXyF4zfTPiA4PCRJ6pPdRBOBOU7GIIkNd7WmPD2i4nAuEW66K3tjCHjsbHyXhkLORmDIGxKpnrTKTL9mpP7oRa7edTVf7U4lyd4JaOrXqUPH9j74boMUmFngpl984QeLjD7pbDeLy5zjcK5UC32g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLXKiPXV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743679539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV+9b+/x+gelznBEtZ/wkU6VCh9E1FOzg+skZ59VIBg=;
	b=CLXKiPXV6+NvKiTPH/bGnGmJiaqgHU6rHHvgqpvJo/QIEhGowqgE1YY2sAVSuHAfwml/7O
	8lRDheiNqBKeF6esAij8wGi3rYaWcdhJh/VsuoseYcn4fkfFa5M9TVoYGKvecqCh0jbS7/
	rGhye27SF3mRiDm9sLuz42tEDMmRQJA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-1K2fp0wbNjWor8BfQrX9fg-1; Thu, 03 Apr 2025 07:25:38 -0400
X-MC-Unique: 1K2fp0wbNjWor8BfQrX9fg-1
X-Mimecast-MFC-AGG-ID: 1K2fp0wbNjWor8BfQrX9fg_1743679537
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39123912ff0so362191f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 04:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743679537; x=1744284337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV+9b+/x+gelznBEtZ/wkU6VCh9E1FOzg+skZ59VIBg=;
        b=cB+4UOaijBj96jW6RlyFN3kDsU4OSIDF2KtnvE5YwGlczL03CCUBtcKNLhyUW/9NQ9
         nDPiKzusGHP+z440S5w+8S+AoBdVOZVZ+RuR8ilbQawozYmI5O9aUXnWnP88uBeuLrld
         RjutwWMrAT+b5wnIyBCjRxXxb3ag/w3XqUvivbrCFKy4lKKNdyYNuiEs1YlZljyRAjRX
         P+466Y3nRYZUztkc/+E5vW1OrU/BDWUAEQCcp8pRxhaacKWLApLwMtVCu6Bq8J5vMiNn
         d4TSLaw6om9SU42sU0OzSY3Kmd8TP53FhpLOgvuJ3M8tP2XwCEAht0nol+NWaBSFyHVE
         AbNw==
X-Forwarded-Encrypted: i=1; AJvYcCVotWdHbcA5CIK3uQ023xuVIRGaivH97K3yZkjk1k/i7dSeZ2wOfLmZq7wyIgFdFQRxVW1k+Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhrzO9eVrPVW+c6FTQvlU4J/kSAHZ28R5RDLpELJQeMDNi11qv
	+7bFkZ7LoL9FetzWnRL1iolIFKWjEGRAaZt8jbvx1JPkDCqV+cng4/IsKpbhpEQQ1QMAEF2uWo3
	z2aKPMgqrjmsogGatEAGoWHeOxf2OBKOlFRLEXj8HO/6osYGgCw2S1g==
X-Gm-Gg: ASbGncvm1E/KnEdUIiQ6wTzE+d5FVnm7UWH/bdjjTXp/lzuOXoVzWtQ1brp7r7i/iwa
	c8ZwSllgwKng9/5jPFIz9BE9N8mx4n3jC3LWVTS+w9xv4kxIXyUwF0ijHNLEgwh6Jc1eFqe70S9
	mGGxzscGSkIZXIeoxcwKLFoSelBtSoomWKteAciJGj5P9lwXHzmUHPRw6aJWzS4cWvNGv2uf4sR
	uC1w1RKjK9yCoas7+7B/jpYXUZLvmpqBmwVnUKxR7I/IeSxDEkt6WlxyoiUQj5eQ7LOEZlNbHUj
	5aIvhzYIleIDZ+eNK/HNSZKKBgvM9WQE9yJSpqoKERHMUg==
X-Received: by 2002:a5d:598d:0:b0:391:3b70:2dab with SMTP id ffacd0b85a97d-39c120dc668mr18372142f8f.17.1743679536893;
        Thu, 03 Apr 2025 04:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgUyiwXd0iBaKJMkSQX6B1609ESCGRfex5vbqPGGdlcsOk42Ie119Ej9VIa8cCmWscFQJXiA==
X-Received: by 2002:a5d:598d:0:b0:391:3b70:2dab with SMTP id ffacd0b85a97d-39c120dc668mr18372105f8f.17.1743679536479;
        Thu, 03 Apr 2025 04:25:36 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b3572sm18994295e9.39.2025.04.03.04.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 04:25:35 -0700 (PDT)
Message-ID: <469fd8d0-c72e-4ca6-87a9-2f42b180276b@redhat.com>
Date: Thu, 3 Apr 2025 13:25:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
To: "Malladi, Meghana" <m-malladi@ti.com>, Roger Quadros <rogerq@kernel.org>,
 dan.carpenter@linaro.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 namcao@linutronix.de, javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 horms@kernel.org, jacob.e.keller@intel.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
References: <20250328102403.2626974-1-m-malladi@ti.com>
 <20250328102403.2626974-4-m-malladi@ti.com>
 <0fb67fc2-4915-49af-aa20-8bdc9bed4226@kernel.org>
 <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 2:37 PM, Malladi, Meghana wrote:
> On 4/2/2025 5:58 PM, Roger Quadros wrote:
>> On 28/03/2025 12:24, Meghana Malladi wrote:
>>> ICSS IEP driver has flags to check if perout or pps has been enabled
>>> at any given point of time. Whenever there is request to enable or
>>> disable the signal, the driver first checks its enabled or disabled
>>> and acts accordingly.
>>>
>>> After bringing the interface down and up, calling PPS/perout enable
>>> doesn't work as the driver believes PPS is already enabled,
>>
>> How? aren't we calling icss_iep_pps_enable(iep, false)?
>> wouldn't this disable the IEP and clear the iep->pps_enabled flag?
>>
> 
> The whole purpose of calling icss_iep_pps_enable(iep, false) is to clear 
> iep->pps_enabled flag, because if this flag is not cleared it hinders 
> generating new pps signal (with the newly loaded firmware) once any of 
> the interfaces are up (check icss_iep_perout_enable()), so instead of 
> calling icss_iep_pps_enable(iep, false) I am just clearing the 
> iep->pps_enabled flag.

IDK what Roger thinks, but the above is not clear to me. I read it as
you are stating that icss_iep_pps_enable() indeed clears the flag, so i
don't see/follow the reasoning behind this change.

Skimmir over the code, icss_iep_pps_enable() could indeed avoid clearing
the flag under some circumstances is that the reason?

Possibly a more describing commit message would help.

>> And, what if you brought 2 interfaces of the same ICSS instances up
>> but put only 1 interface down and up?
>>
> 
> Then the flag need not be disabled if only one interface is brought down 
> because the IEP is still alive and all the IEP configuration (including 
> pps/perout) is still valid.

I read the above as stating this fix is not correct in such scenario,
leading to the wrong final state.

I think it would be better to either give a better reasoning about this
change in the commit message or refactor it to handle even such scenario,

Thanks,

Paolo


