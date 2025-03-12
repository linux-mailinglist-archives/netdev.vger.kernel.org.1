Return-Path: <netdev+bounces-174127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085BA5D929
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AF3B3DE4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D8C23A986;
	Wed, 12 Mar 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="VLTqhP22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBF238D2E
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771233; cv=none; b=MF4VAHwN5ScDLkqAtn/FIEeLYmQscz+AgWKNGNae7tFtKtslsM+SvrSdwk0z9aTU199PLYTaSYGN4U8PB2Kechj7czWcr654Iqm3+U4W21PKiiFUZrqvKCTwSMmhZtJiAzIVMR++UU1LnW9a9Jgg+QRafNsQjJOu5AJGQ1af3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771233; c=relaxed/simple;
	bh=UNQEpZ5sfTtfwFATwN/PYbpDuFHkRLdvDD98hKB2V+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFo/awZuNzPSO2n8U1EnMCzIJA+6JbhRMWYc7HjcNg26i4CTq2izgRYW2pOZqgOYWI7OanL1vuPeiUsK30wmU6UiWHibhvPyCnMOWNIYJuiUjLrDJRLqdwczpMQo+CfDkcdSnh6nthO5VJyyQfFsC1W/ywCkDWJY6naCPVhjKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=VLTqhP22; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd049b5428so64520026d6.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741771230; x=1742376030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VpzqpioYCZTPrjL9rfNW08yUfn+3oM/qaVfIP1D1uQ=;
        b=VLTqhP22gjl9u5N40vMpPE/Y+JT4fIOpCwhazjZQH9I3VAc0RhIYRrqYW3gDf3NsnX
         uDunBtg7Rk6H8lGi35/GVE5lqD0YnZVzGBMHCz9GkBSVfsUzivzfE+awGf/mJiugkqxh
         NMGdPyYqVVvkfXOjZH0zARExocPyNTuLxYjTS0PDsBD3aB+DSoUf2/Uw+eu67IlOaRR3
         dc3AG6MjA+iDSAHdKPr8BEW9P0muqknJzyWxfpjUxyi534u3YWnVOvW4bcH89biLtO5g
         KSoGsAb4KWPOtnuw87DlT9mS2XnZ1FORDFSFrT9D4y6ISAoWPDMgEW8JUcE+hJn02cdO
         aVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741771230; x=1742376030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VpzqpioYCZTPrjL9rfNW08yUfn+3oM/qaVfIP1D1uQ=;
        b=dE/pAvIjven68cGHVsO+O5n2aqN8mnTnIl5BLAdxFhAMJSb3fSyLgGu+eFtcw4wMz2
         Dt0Anb2nebqQosB9p0jYKRWhZUmMExEwKkRj9NOyYtjHkxsBEkhSgyACHjpS61oVI/bB
         0Xvqjkz3HSJOUV/bdadkTDuSfxHV3LDVQJzuqmVWa2ypn8o0BxUbg+04YSAaBn45U0z2
         NX3E0OD5kMXDEFoM+F66OC88wrUVL07J1xwFH29QJs6puW5hVX8FYzjWYFy7uMDaZst6
         nWS9ENg1tvzmmGH3/ZFEmbNIdZjPBwQCkQcYWFVBFyaFHC4o/6By1NOAlPkrDb0Bp6wk
         SDzg==
X-Gm-Message-State: AOJu0YyQ2Zccc8Twy+j6oDn2khvPA45v4pcFT2FN6B8sx+lu2ghxVxSZ
	Uuw6ARsoV0MzjBMn1Y8lsmCnVrJm1DgFyCE/flFBPQK1HOh0i8yE7pIXUih95f0=
X-Gm-Gg: ASbGnctcaffN1ha+MB8hegXWzocs/Au50+GZLECSJTcPImE0arTwX1ADF9heJ4XgCfr
	Q6dhhc/ueHiwW5RZGBpnQzn3r++DuJ2uGVLKpfgymmTlav333qay7Vxm9mohdJcey54OFAiKgEt
	mMKO9eJ3AzBx7cv9PLbFVCeBHdTemki68nmWA0pPlS0gAjE96uDUytF4UmjgKz0M0EUnOsAfKfl
	L4jfOlgQu8ImiVRrsgn3128VGADOtYg/wfRen78gTgIQzpvw+nk2uuyRfvzottUZvuFdQ/BHexW
	FLBqC+43xSpQGcfmDrxL9wEF5GdtV1Ml5hoEPz6dG9GbMbOB4FrA
X-Google-Smtp-Source: AGHT+IGvPzzDF+G+t4jAqh608nve568kH0JOAxRS+fBQPXr981QPc9PI2lfxrg7M/7BJCTmB5bW2cg==
X-Received: by 2002:a05:6214:d6d:b0:6e8:9dd7:dfd0 with SMTP id 6a1803df08f44-6e90069c697mr313043876d6.44.1741771230136;
        Wed, 12 Mar 2025 02:20:30 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7212ad9sm9516969a12.0.2025.03.12.02.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 02:20:29 -0700 (PDT)
Message-ID: <3840993e-5e20-4657-8d5e-e0e44c613a40@enfabrica.net>
Date: Wed, 12 Mar 2025 11:20:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Sean Hefty <shefty@nvidia.com>, Bernard Metzler <BMT@zurich.ibm.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
 "alex.badea@keysight.com" <alex.badea@keysight.com>,
 "eric.davis@broadcom.com" <eric.davis@broadcom.com>,
 "rip.sohan@amd.com" <rip.sohan@amd.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "roland@enfabrica.net" <roland@enfabrica.net>,
 "winston.liu@keysight.com" <winston.liu@keysight.com>,
 "dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
 Kamal Heib <kheib@redhat.com>,
 "parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
 Dave Miller <davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
 "andrew.tauferner@cornelisnetworks.com"
 <andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
 "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
 "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <CY8PR12MB7195F4D67BE6D9A970044572DCD72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <BN8PR15MB25136EC9F3DE1FBEF9B2429199D12@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB43133BD3605D9C95498A9604BDD12@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <DM6PR12MB43133BD3605D9C95498A9604BDD12@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 7:11 PM, Sean Hefty wrote:
>> I am not sure if a new subsystem is what this RFC calls for, but rather a
>> discussion about the proper integration of a new RDMA transport into the
>> Linux kernel.
>>
>> Ultra Ethernet Transport is probably not just another transport up for easy
>> integration into the current RDMA subsystem.
>> First of all, its design does not follow the well-known RDMA verbs model
>> inherited from InfiniBand, which has largely shaped the current structure of
>> the RDMA subsystem. While having send, receive and completion queues (and
>> completion counters) to steer message exchange, there is no concept of a
>> queue pair. Endpoints can span multiple queues, can have multiple peer
>> addresses.
>> Communication resources sharing is controlled in a different way than within
>> protection domains. Connections are ephemeral, created and released by the
>> provider as needed. There are more differences. In a nutshell, the UET
>> communication model is trimmed for extreme scalability. Its API semantics
>> follow libfabrics, not RDMA verbs.
>>
>> I think Nik gave us a first still incomplete look at the UET protocol engine to
>> help us understand some of the specifics.
>> It's just the lower part (packet delivery). The implementation of the upper part
>> (resource management, communication semantics, job management) may
>> largely depend on the environment we all choose.
>>
>> IMO, integrating UET with the current RDMA subsystem would ask for its
>> extension to allow exposing all of UETs intended functionality, probably
>> starting with a more generic RDMA device model than current ib_device.
>>
>> The different API semantics of UET may further call for either extending verbs
>> to cover it as well, or exposing a new non-verbs API (libfabrics), or both.
> 
> Reading through the submissions, what I found lacking is a description of some higher-level plan.  I don't easily see how to relate this series to NICs that may implement UET in HW.
> 
> Should the PDS be viewed as a partial implementation of a SW UET 'device', similar to soft RoCE or iWarp?  If so, having a description of a proposed device model seems like a necessary first step.
> 

Hi Sean,
To quote the cover letter:
"...As there
isn't any UET hardware available yet, we introduce a software
device model which implements the lowest sublayer of the spec - PDS..."

and

"The plan is to have that split into core Ultra Ethernet module
(ultraeth.ko) which is responsible for managing the UET contexts, jobs
and all other common/generic UET configuration, and the software UET
device model (uecon.ko) which implements the UET protocols for
communication in software (e.g. the PDS will be a part of uecon) and is
represented by a UDP tunnel network device."

So as I said, it is in very early stage, but we plan to split this into
core UET code and uecon software device model that implements the UEC
specs.

> If, instead, the PDS should be viewed more along the lines of a partial RDS-like path, then that changes the uapi.
> 
> Or, am I not viewing this series as intended at all?
> 
> It is almost guaranteed that there will be NICs which will support both RoCE and UET, and it's not farfetched to think that an app may use both simultaneously.   IMO, a common device model is ideal, assuming exposing a device model is the intent.
> 

That is the goal and we're working on UET kernel device API as I've
noted in the cover letter.

> I agree that different transport models should not be forced together unnaturally, but I think that's solvable.  In the end, the application developer is exposed to libfabric naming anyway.  Besides, even a repurposed RDMA name is still better than the naming used within OpenMPI.  :)
> 
> - Sean

Cheers,
 Nik



