Return-Path: <netdev+bounces-120315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D0958E8B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AE1C21727
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADF156228;
	Tue, 20 Aug 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGV+OM1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41667149C4F;
	Tue, 20 Aug 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181721; cv=none; b=VOCC93McheAxZYA8RwGq0gzmMvbgo4qcCcX5VNOW3zbhXYpoImHt7+TNEV0e7g7mqtL6K3PLnfdHdeH6sP84wwOPq//DFukTi8c05fQC+QBAI5NNVHHkuG7u/PeiNKho2nYSS3ZDYqrPhIhbGs6+t2WxtSnxFcZrk0S4H+kh6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181721; c=relaxed/simple;
	bh=HDmjUSPeQ052zs214EJwkKI/aCj9sfJ3LSxztQ1ThtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtvfbIQ7n/s4pLxxIoldbhnNgTyTTwJjJOoWG5VNdggnA6ew+xgngUo7M/+cCT1xevMV9U6X3PuMa/4npdYG2/9WYodRRIdhnAZ+a4b4W6mqKIme/Hb7qGIEIeT+4FQ/MKj8myzWUbq/gw8TptWlafzTddbrwczVK1O8xCUKp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGV+OM1j; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e026a2238d8so6019001276.0;
        Tue, 20 Aug 2024 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724181719; x=1724786519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCul4K8TK7hOnoga2HB22Aaiz/M42naHXOD36F/mvuI=;
        b=ZGV+OM1jj3t1SGGav5eZ6gvXWFxH16efkowBnVMkjOwuRtAWeX/NxTNlYCo3H2RkWU
         YP3fBvJHzbSBWKnzefB3uALwzuIrpouLEtQHHVBhBJ0AvHHcbHPuD92i4fqWr29HIYEb
         /pf/p0/pksz3pHZMppTBJrbG96YWaui++VJ+yPva3riRVwL1ORxAmIMsWDBo4S0LPiWJ
         mc7P+ujOpj83VGEkuur+rup35esTipuKM/3Ei8b9+wO/SQvkUH94JlmEPZH5xpX4+alt
         GOohCXByQV3PrQonC8mquxxWcEn5GoWnCZVgM3qWF2rNnADBCjrPEhB0byK8jxRO6ZK1
         E55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724181719; x=1724786519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCul4K8TK7hOnoga2HB22Aaiz/M42naHXOD36F/mvuI=;
        b=Xoxdm82CciJdHVFD7Jork/RRA4yENu+mCiD6UWsXPZtwTdCJ5yZzRXcVz99zEMuFbA
         L1it+3IHA4UfYcy4TSINvLka+ajZWZK6D0v6kcELFIQxfWUxPQzhHvgnO6NuOaagBAvB
         zLNpfegHMwm6uKrc82jfawOJx5xe8Epb23q0ieOXtrjrvXjnd5kWHvXU4XW0pLo6xQd3
         ErOekmZINUhVa5C+qF7c+6NvOmmis4q4TckYFw2u7QCYDcnkn4ZV0jL3XdR9MusujtFI
         rEH58rKz2r37rAIfEZQuLFOqN3ExRd0R3oS2b2Xz7FcNX5f3id+64FLgPkMkwZe/80wI
         OkKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2aBaznrXyk5O3KhCwS7fH1st7t+9vvRHV2EANfBah5veXfuoszxF3Kcp4seCkAgdgUcqTRkKW@vger.kernel.org, AJvYcCU5WWypVSvJ/rk4SX7fNyfFMh/16zgCZ8lnEJljwLmhbt993jRd+mjv82z4VKCwSMDG6hNiHmYYpco/wqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxQHlnyLdDxrwiHXdfayZzUuRQH2hjdjGae7FNrMFt9Fu07kz
	aNKy6BHJ+UVm+9VyeagXGnVpqzcLSuu94642Pf6nQBMFN7UPvxfm
X-Google-Smtp-Source: AGHT+IEN7cfA8HiV+XJ3Q8Kc62chmHznInuvA/GTxOfNCnzP3xP108YdXw1/joPMkH8sxpftaLdPeg==
X-Received: by 2002:a05:690c:6591:b0:6ad:ba92:1731 with SMTP id 00721157ae682-6c0a0ae8507mr3422167b3.41.1724181719104;
        Tue, 20 Aug 2024 12:21:59 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99410fcfsm20057547b3.3.2024.08.20.12.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 12:21:58 -0700 (PDT)
Message-ID: <5da4cc4d-2e68-424c-8d91-299d3ccb6dc8@gmail.com>
Date: Tue, 20 Aug 2024 15:21:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
To: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20240819222641.1292308-1-Joseph.Huang@garmin.com>
 <72e02a72-ab98-4a64-99ac-769d28cfd758@lunn.ch>
 <20240820183202.GA2898@kernel.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240820183202.GA2898@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/2024 2:32 PM, Simon Horman wrote:
> On Tue, Aug 20, 2024 at 12:58:05AM +0200, Andrew Lunn wrote:
>> On Mon, Aug 19, 2024 at 06:26:40PM -0400, Joseph Huang wrote:
>> > If an ATU violation was caused by a CPU Load operation, the SPID is 0xf,
>> > which is larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[]
>> > array).
>> 
>> The 6390X datasheet says "IF SPID = 0x1f the source of the violation
>> was the CPU's registers interface."
>> 
>> > +#define MV88E6XXX_G1_ATU_DATA_SPID_CPU				0x000f
>> 
>> So it seems to depend on the family.
>> 
>> >  
>> >  /* Offset 0x0D: ATU MAC Address Register Bytes 0 & 1
>> >   * Offset 0x0E: ATU MAC Address Register Bytes 2 & 3
>> > diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
>> > index ce3b3690c3c0..b6f15ae22c20 100644
>> > --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
>> > +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
>> > @@ -457,7 +457,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>> >  		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
>> >  						   entry.portvec, entry.mac,
>> >  						   fid);
>> > -		chip->ports[spid].atu_full_violation++;
>> > +		if (spid != MV88E6XXX_G1_ATU_DATA_SPID_CPU)
>> > +			chip->ports[spid].atu_full_violation++;
>> 
>> So i think it would be better to do something like:
>> 
>> 		if (spid < ARRAY_SIZE(chip->ports))
>> 			chip->ports[spid].atu_full_violation++;
> 
> Hi Joseph,
> 
> I am curious to know if bounds checking should also
> be added to other accesses to chip->ports[spid] within this function.
> 

Hi Simon,

 From the spec it is unclear to me whether the Load operation could 
actually cause other exceptions. I was only able to reproduce and verify 
the full violation, and that's why I only included that one in the patch.

I guess we could proactively include the fix for other exceptions as 
well, but without a way to verify them, they could be just dead code and 
never be exercised. Perhaps people who are more familiar with the chip 
than me could chime in. I'm fine either way.

Thanks,
Joseph

