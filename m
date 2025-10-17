Return-Path: <netdev+bounces-230608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4861BEBDC1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908904E052D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8062566DD;
	Fri, 17 Oct 2025 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSDCAnIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0F24C68B
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738101; cv=none; b=eQx7DSii0JkTWvVMux2locn7XDmwTHVrl76pCQIzU1SqXvEFlJBwzooMkRVmYYWWsGC2VDvqO+bIINvINUMmpEIG3Me34mliyP4x8cNdwnYp1zwmmkqIAcHYxVLNq2WhR7SjPCYFf291i80T7Glsetr5RoHLajm/QiALoZmbd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738101; c=relaxed/simple;
	bh=OnHnf/SE03ZIAEuAcNsCOostR4f7d5g2jg8OSHPzjlk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fDXr5FqddDW/hEu0tRbv6+gLgRC9Ml+A7t4TagE7WhFfWxlzPP9TdCpQca2CK+eMvsL/PtSK18cDxPkK8TYebz2UUix9quwSY9hw/LSS48pXgU8BODlQc8e0sE34Wz/mJW31Us2mGCr9MfroiXY6nVInVmlXDhV34HrwajIipGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSDCAnIq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87c11268b97so38028216d6.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738098; x=1761342898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUPS8Z30XK0CCVS2tlyRS+oCft5fZ2cws6OiUH8Mxrc=;
        b=hSDCAnIqzClanNDOy/i8QHj1lep9vqqqe4GlvIWUU4eXUA6EIP+yrlGPMR3g4aaDMY
         bjTuJHJlNgbQzYB7f+aaI+FOyC5IUXGJLDsHhGRfRer3o6yHkrfJvvVLvtZH5r7mcQx9
         IdhQDP2Pv0tihNP2CyUOe9X3Oyo1ETuUmLBBM7PXgjrMUEjjOHXf2PWsysvSz4Xow1JQ
         iI3MoRLSDoit/Yo2Y44D0bVyKQyIeIFZ/nw3jtHrzeEEEctDVrrQG7lSdJeejPQUYcqC
         TRxO5ERv+8XvyYitUORvN9U4tqC930+G0K8ewSNqu2Hf6/pJlV945dcPSaZ63ucQU4T/
         S7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738098; x=1761342898;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUPS8Z30XK0CCVS2tlyRS+oCft5fZ2cws6OiUH8Mxrc=;
        b=jusN5gMQ5xni5B1qSk0cufsy1JnVQeGXd7ZbcGiqmNFtG1JnVV8tzH5TKU2NHmYhsa
         7ohDg+y2069ZZuZ9uG/UHmlO2+bmPpDLCfiB6hNUJsWwO00RgWRrFMPyPO9djsATrYa+
         UNLNlT/dBmw6diVOzu874VxNamqYppqDvuDVANmdBQzjSW1dnbfoCAt5O/0mbJoAb3Jl
         xuQ9z299o11oWYgYOIkyd0wNV2VKZH+4JP5Mpe4kuMw2RRZGgTag8W5FmL4QeJoNvRns
         pOdb9hOgWtxFR9xUhWk57rsNeLo+qAG//WVPMWDmqZgQkrSwbUKIjTzvRHbidPEN05xr
         Q+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSBb2uuRHA57nM2FWUIism7k2ioR2V4iJy0EWOV7kdP/OJutVUdaQCoNqCVcqh2zfuwjyt2nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FOR4+sQqrThcJRVA7iaivJM6HfeRen5JV8QUKPuQ5XH164LW
	espS10lPToI81dbG3Ij2/toFmWFkRDiSYb6ieLYd9wWxNXRJ6yfErkXR
X-Gm-Gg: ASbGnctpyfU3zwvXNpu685ngMVD/YqEoLp+lfaWs1AxgKfcB6dPwEAPFTn5rjkClebd
	u+v5POj9xlb+9YUY5gLvS3cg1cbHDRuVVP5ISpTTOm7ICx/BP+LwFoKLmIvWHS1+pGmXJdptQ5k
	XoNkDwfU9u2wKVskMwWYBLg6ieCMPq3ooo5DpdwISN/DboiufzV6jTZMXJQBKJmFbPJeSEkhnT7
	cd6i1vc2pB9anhXfIc1CBtvYvK0Sbx98bS0yRcUbWJfcooHsEDu/M2dxbAvU+jOfrJl69dyMrMp
	Ft0o67NPx+LnB+dGQcWJ+PjBucHddWk6EjbfGqIl7TF036toGbHPtx/YoGPL9/t12F5qD2XpYK8
	h0B6sKKNDa2+O1ZNCH70yAK3mJmHRE2HdE/IV7EW79CSdIEFJjqBS4Jn2bwrwkyJF6i340aMAoO
	9+TcW6hu8sp7Nab6gdwt26+RbZVQ==
X-Google-Smtp-Source: AGHT+IEFMSLSDcXAG2GKQPZLpXc13Jiy3xTPiyofgE8mYwnQfvLXap68aWpy5stghROdtue8SdPdpw==
X-Received: by 2002:a05:6214:1c48:b0:72a:2cf6:76df with SMTP id 6a1803df08f44-87c207f22f4mr76744336d6.45.1760738098489;
        Fri, 17 Oct 2025 14:54:58 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c9::10a9? ([2620:10d:c091:400::5:6f38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf5235863sm5793816d6.29.2025.10.17.14.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 14:54:58 -0700 (PDT)
Message-ID: <d4ee68d6-7f57-4b24-970f-41a944a22481@gmail.com>
Date: Fri, 17 Oct 2025 17:54:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 net-next 02/11] net/mlx5: Implement cqe_compress_type
 via devlink params
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
 <20250907012953.301746-3-saeed@kernel.org>
 <ec51df17-260e-4ec9-a44a-9f0c3d3a2766@gmail.com>
Content-Language: en-US
In-Reply-To: <ec51df17-260e-4ec9-a44a-9f0c3d3a2766@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/17/25 5:51 PM, Daniel Zahka wrote:
>
>
> On 9/6/25 9:29 PM, Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> Selects which algorithm should be used by the NIC in order to decide 
>> rate of
>> CQE compression dependeng on PCIe bus conditions.
>>
>> Supported values:
>>
>> 1) balanced, merges fewer CQEs, resulting in a moderate compression 
>> ratio
>>     but maintaining a balance between bandwidth savings and performance
>> 2) aggressive, merges more CQEs into a single entry, achieving a higher
>>     compression rate and maximizing performance, particularly under high
>>     traffic loads.
>>
>
> Hello,
>
> I'm facing some issues when trying to use the devlink param introduced 
> in this patch. I have a multihost system with two hosts per CX7.
>
> My NIC is:
> $ lshw -C net
>   *-network
>        description: Ethernet interface
>        product: MT2910 Family [ConnectX-7]
>        vendor: Mellanox Technologies
>
> My fw version is: 28.43.1014
>
> To reproduce the problem I simply read the current cqe_compress_type 
> setting and then change it:
>
> $ devlink dev param show pci/0000:56:00.0 name cqe_compress_type
> pci/0000:56:00.0:
>   name cqe_compress_type type driver-specific
>     values:
>       cmode permanent value balanced
>
> $ devlink dev param set pci/0000:56:00.0 name cqe_compress_type value 
> "aggressive" cmode permanent
> kernel answers: Connection timed out
>
> from dmesg:
> [  257.111349] mlx5_core 0000:56:00.0: 
> wait_func_handle_exec_timeout:1159:(pid 72061): cmd[0]: 
> ACCESS_REG(0x805) No done completion
> [  257.137072] mlx5_core 0000:56:00.0: wait_func:1189:(pid 72061): 
> ACCESS_REG(0x805) timeout. Will cause a leak of a command resource
> [  270.871521] mlx5_core 0000:56:00.0: mlx5_cmd_comp_handler:1709:(pid 
> 0): Command completion arrived after timeout (entry idx = 0).
>
>
> subsequent attempts to use mstfwreset hang:
>
> $ ./mstfwreset -y -d 56:00.0 reset
> -E- Failed to send Register MFRL: Timed out trying to take the ICMD 
> semaphore (520).
>
> I can toggle the parameter ok using the mstconfig binary built from 
> the mstflint github repo.
>
> Let me know if I can provide any more information.
>
> Daniel

Sorry, I should have mentioned my kernel version. It is a vanilla 
net-next kernel from:
1c51450f1aff ("tcp: better handle TCP_TX_DELAY on established flows")


