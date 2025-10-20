Return-Path: <netdev+bounces-230778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DEFBEF59C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF24E1DD0
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 05:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7317A2F6;
	Mon, 20 Oct 2025 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HatCoujX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D671C695
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760937863; cv=none; b=VwCnfPW0Ky/QswHhpRnF9elwidsob7Z5kenPW7t0VTNIQAFP9BWq1K9oJ1co0XKHquzOgOA8G4/NMWxNmUwjVDazAFuTEWiIEJ5oRTerhfoit2Koweoflqze5G8VjFboEFXSp8VNyLw+2N+9QCTK+8+dxKl1yA3wbxVyVQuEJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760937863; c=relaxed/simple;
	bh=nX8mi5Ma9y2HpsiQWQjrPfy1ttHomJpy197YCiz+NBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr3NQacR4ukAkvLFAbU2Zp7wuzC/rCGxje1tquxhV9sKuCVPWQQpfpkgF5u9MhTCiRa9V1tGa7kpP+Qj5X2JxkjJ8LUepLHEAJt7nmG+PFVydTBB+CzSZTH57VgRG/fRGz0XRxac8JMSquswrQZw4tORSFG157mDUg1DocjZhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HatCoujX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47106fc51faso46269925e9.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 22:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760937860; x=1761542660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvB82ytjgT5pgp6OZanBb6VXBXMIIhxN6AeB/yR3+AM=;
        b=HatCoujX6S5jdE9MdXvjcO8rbHVu27a377lr1H/T78HgpZexSAkXcYL38TE2wfY3BB
         TsW5AI6mxUc6WvBQ3aTeGmkydA+WBdSiVQYR4viEJ8234R0SM8QdGbmZ6PQTCnSrYN/0
         je4YGelixchtUBqXvexko46tmbnt3yEyQ5OBwuhe6+/7bD+eGDwbklEWQnEStXDKZjrb
         +6c0AxcCjqbbmtpFHiSLAGLpv9CP79b11w2r8pVxJ1o6CV+HYneys5qzELxSBpgpZF9y
         /+BYXQHCqiQWyTWYiMkeMSEAQBdkDLu6vgl4ze5jSP2UYPyd7gR/2ZRtoMArj+UWD1mS
         VU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760937860; x=1761542660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvB82ytjgT5pgp6OZanBb6VXBXMIIhxN6AeB/yR3+AM=;
        b=D4R8HTh7U4SQ2+IzfxPv32xvEl6yKu3QurFs2ZERbLgedpy9BEdxV4XZphkne9m9aN
         V0Z4doMaoUUh4aVaBnzwRPjglmf7t07TpSZEg5KgKWNnRrzL2Vwp5XavlmRrPgD6mpap
         vlhGRCkteSTKh9XeK7WNbXRei/JkId6EcH1tzi5DhZpRPrWO+ZutLfQZ6d/MGW5ha1uJ
         JPGch0+YohVvPvQ3YFWvahsY0jsEXIxndNrPW6izt3jbaBzozrsApKHOsyQv5jjdxO39
         ntG2zSp6MnIC2DH1wVWaJ1HWzTN79/MZedliEY95Mb4XpiDrY/3v2qlg3/RuCvd8LCey
         ArLw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Rkpx98diJfd9XtxGFsz73dFfcutSaNuEy+KNbDk/hNl3ZUEviNH32+FZIazzNBlzxCJRnxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYNFF4+4EazDtzehC0j0ycG+yxkt7BwQOryks1o3Z6Wlne40/
	NLSZDl4rF/BF08NmspYJX+vjVgOUS10mDMOjwqnGknBn2T9tdQcpeBDK
X-Gm-Gg: ASbGncvVq1UUkOXCiarU2zJHRLntQxTUrnjWZDlDxde7PAEodBXwrPh1XPL6RykgoTL
	prJ1wt8oePqGuuE4QARCNL/wUUnOm5FKqS7ObzCvGWigOFXRFLYkuXeyWMSxllbkzYa02gJiLbz
	jfJGQLO7abaNtiuB4IBXLyQeS+SWbvAb6diCDywksiCcUPHD2iirBf0PSme+KUErUWpQjXV/Q87
	62t2eofEkcE070OdEz8meycW+wg2aLrKVdQr0UdRwqVUf5VfgsgF/M6YIbD6lw3c8ydOo0ir6Dv
	EkqCk0J8PA5ugx2fUpW8Fd0N296R5Zqofcg7JpPN4wt3KpQSQFx3OBrRwA2jlFAugJhNYfTvYYS
	VUy0MlQKtKvQ3xICmogFZybUO/HUBflhFmqDBJtCDtMrA5tKQ86LqSHEvK1OO8G7v4Swqo1pCEG
	AKta3x72cX6V52Bj8uH92I0YBIp4g=
X-Google-Smtp-Source: AGHT+IHMPiPrLhYf2nQuKpjwBNAfFzeLWk8/FSZzrwQyeD2rQ7yFW/E5p9iKyF96R8UCv0mBEC4Lrg==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr104835275e9.32.1760937860191;
        Sun, 19 Oct 2025 22:24:20 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm208498495e9.18.2025.10.19.22.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 22:24:19 -0700 (PDT)
Message-ID: <4dde7c9e-92ac-43b4-b5c8-a60c92849878@gmail.com>
Date: Mon, 20 Oct 2025 08:24:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 net-next 02/11] net/mlx5: Implement cqe_compress_type
 via devlink params
To: Daniel Zahka <daniel.zahka@gmail.com>, Saeed Mahameed <saeed@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
 <20250907012953.301746-3-saeed@kernel.org>
 <ec51df17-260e-4ec9-a44a-9f0c3d3a2766@gmail.com>
 <d4ee68d6-7f57-4b24-970f-41a944a22481@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <d4ee68d6-7f57-4b24-970f-41a944a22481@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/10/2025 0:54, Daniel Zahka wrote:
> 
> 
> On 10/17/25 5:51 PM, Daniel Zahka wrote:
>>
>>
>> On 9/6/25 9:29 PM, Saeed Mahameed wrote:
>>> From: Saeed Mahameed <saeedm@nvidia.com>
>>>
>>> Selects which algorithm should be used by the NIC in order to decide 
>>> rate of
>>> CQE compression dependeng on PCIe bus conditions.
>>>
>>> Supported values:
>>>
>>> 1) balanced, merges fewer CQEs, resulting in a moderate compression 
>>> ratio
>>>     but maintaining a balance between bandwidth savings and performance
>>> 2) aggressive, merges more CQEs into a single entry, achieving a higher
>>>     compression rate and maximizing performance, particularly under high
>>>     traffic loads.
>>>
>>
>> Hello,
>>
>> I'm facing some issues when trying to use the devlink param introduced 
>> in this patch. I have a multihost system with two hosts per CX7.
>>
>> My NIC is:
>> $ lshw -C net
>>   *-network
>>        description: Ethernet interface
>>        product: MT2910 Family [ConnectX-7]
>>        vendor: Mellanox Technologies
>>
>> My fw version is: 28.43.1014
>>
>> To reproduce the problem I simply read the current cqe_compress_type 
>> setting and then change it:
>>
>> $ devlink dev param show pci/0000:56:00.0 name cqe_compress_type
>> pci/0000:56:00.0:
>>   name cqe_compress_type type driver-specific
>>     values:
>>       cmode permanent value balanced
>>
>> $ devlink dev param set pci/0000:56:00.0 name cqe_compress_type value 
>> "aggressive" cmode permanent
>> kernel answers: Connection timed out
>>
>> from dmesg:
>> [  257.111349] mlx5_core 0000:56:00.0: 
>> wait_func_handle_exec_timeout:1159:(pid 72061): cmd[0]: 
>> ACCESS_REG(0x805) No done completion
>> [  257.137072] mlx5_core 0000:56:00.0: wait_func:1189:(pid 72061): 
>> ACCESS_REG(0x805) timeout. Will cause a leak of a command resource
>> [  270.871521] mlx5_core 0000:56:00.0: mlx5_cmd_comp_handler:1709:(pid 
>> 0): Command completion arrived after timeout (entry idx = 0).
>>
>>
>> subsequent attempts to use mstfwreset hang:
>>
>> $ ./mstfwreset -y -d 56:00.0 reset
>> -E- Failed to send Register MFRL: Timed out trying to take the ICMD 
>> semaphore (520).
>>
>> I can toggle the parameter ok using the mstconfig binary built from 
>> the mstflint github repo.
>>
>> Let me know if I can provide any more information.
>>
>> Daniel
> 
> Sorry, I should have mentioned my kernel version. It is a vanilla net- 
> next kernel from:
> 1c51450f1aff ("tcp: better handle TCP_TX_DELAY on established flows")
> 
> 

Hi Daniel,

Thanks for your report.
We'll look into it and reply shortly.

Regards,
Tariq


