Return-Path: <netdev+bounces-232148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF0DC01D08
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EAA6562477
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C132D0D6;
	Thu, 23 Oct 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxf/SOFG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFE3074B1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230060; cv=none; b=nQ+lnswyEcjiv4Qa82uQ2N5hgeOktOfHhvgK2dBWZ5ypZeoLii/4CkGhhz9JNjRVxVOTnq2Tz7qEaFzSoB2JKM9eGIO2ocOtRSRdE4X8tK0EWXh135rhg7qnzjSFfdwx1EAmap2F7+7K6lKjBRY1lIYY57rqw+wUdpfd9SndxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230060; c=relaxed/simple;
	bh=/QeC+4KBQYT3wohYuPFOfqIAJyHO1wZV9UiHSECbF+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1+StCFQqrmuz6AcQ2c8yKDgzMo4P39xBWbdUej4eWl0qq9j0NPubUv7hCyXcneEG6o0CVoeReXBq55bJGTbbytjCjiXZTJPDPhrqtkJagNtKhE1EyDcgGIINDuU5ZhTSAwZr4NKsYpBhxoDcVQEZJtPQgsXuSJFGLCQGVqbtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxf/SOFG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8907af237ceso84043485a.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230057; x=1761834857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ty8jqgEMWrkU/Nsac/whYt2eOAER5E6EFOQ1MIoYtJs=;
        b=Lxf/SOFGFAM7eVPDXAQhd1Enwft6Uq3rhsdzAfPR5okP8jkVsZfuBXe/cr2XbnZwI2
         0OIjUp+cHoHPceboKQtp3MgNMDgRa70y4km1HSv/HWELXd/yVrxVE7IxJMmc7zhhUmav
         FI7QjjX5odF40uyiNDRAmwSgAc3QQAt5A8io/k/X/UcfCGqtjH1xTu3W3JDeMoxsrhlV
         btWTclQZOrY64E6aC2jPzN8GE9QAsZdmcc3X0762pr1n3ohbAizhYbEcG2D6e+jX2YZ8
         a6yhxUJTzF/Wfsdr1DWU6HHf3VpVeXqQMnsOOqnILq1cL7o4eIF/WDhbAm49NCuQ7DiH
         6jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230057; x=1761834857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty8jqgEMWrkU/Nsac/whYt2eOAER5E6EFOQ1MIoYtJs=;
        b=ejlS9h9tFUW7mC7qEsWequp6UAFrvzkmfG7myG7Nxz70Ytsxztuml1bv2I9znJTYZq
         NaJ/1ukxJgH8livOQ8KwdJqJt9+l7ClVpnQX1LHHNsk8JnaHhkqtHj0xQ2YHEhqFWPzJ
         IXVQStWQ8mYuvFLXqtLWz4ud3sqa8xY2G9VVHblJiDqD3NuyDmkPigNaQM7azzmNJQYT
         SOJJ3Mf6hIk7wtbJ4rc7rKiSFtUAHMWMMVufhYRbqV4Ld5Vr42KmkAJ+Gdsi7y4+4Och
         6k0SMhyd8w6BNXaH1ON9Nc2OF+BD8HLtV62Z75Pgl1jCTacAA0LpL7k0C0qI9EpfuR3M
         JBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hFc4XVZImaYmJpvoK3GZ4rHxXnGYd7yWFXRMqQKr5jIE5UyWvwPOcmXZuCrZuOTT1HzaAIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFEieXskz6yOb6FeGlPYCHAPemheh2/jDYn56Ahwaa1xQmwio
	vhbqpKC0h/WW4KZyfoDjKd+dHYDF3NMW2pTctgDeeL0DNMdysL22p7DT
X-Gm-Gg: ASbGncveEZPofWcFa7IDzh/LUEyGJqecH4NMi1KxSohtPdeidUP9eM/TUHxI/S04vzB
	8PqslVlgm6/bqVXvpFjaoYOLZzutYJKr1i6+ppRRCHuGCN0PeRNoyZ2hB4updT0pUnIWUqG0tcS
	5qWgArPaOiBNXa1KUoO6ErWBTN4UgfE35s/uGwPZjmZWMWj2SgK7QgBFJn8+KB+QWEZi9Alq+nP
	lWSNaEV/8hpJ+lgVUiYodR2CUJb0pMhBxYq3TZDz1aWqP1XB9TMVfyNN2ZVOacpFAVYQoM3MdDj
	tktW8MT4llxNdkBXaKkPxbYG3k169VOiY45W4hQfyonVBPHpLvuYg1kGQRY9SwYn2CkRKaoy9/g
	7ZOWMsHrKJVw3IIG+O5ezS4EhNYyvdARNKJQvaksrFUaOKpcS1O/9XWa9Lhso8+RuErLDJZxc3J
	U+EYGDud++LWBE3wLSZKUTD7IlNwIal5DS9g5RQnPGCg==
X-Google-Smtp-Source: AGHT+IFk6zsFnw4L+tiI4iBc7mZ7I1pnhPccFZ233koLT7AqMhpvx2+P+Rp5WpaB7Fl/vtbeBra1Bg==
X-Received: by 2002:a05:620a:4512:b0:892:5412:b742 with SMTP id af79cd13be357-89c11e630d8mr327291585a.55.1761230056821;
        Thu, 23 Oct 2025 07:34:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:6893:5f51:a77:210a? ([2620:10d:c091:500::5:8f1b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11698b74sm171117185a.30.2025.10.23.07.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:34:16 -0700 (PDT)
Message-ID: <ae217501-b1e0-4f85-a965-a99d1c44a55b@gmail.com>
Date: Thu, 23 Oct 2025 10:34:15 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via devlink
 params
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/23/25 8:18 AM, Jiri Pirko wrote:
> Wed, Oct 22, 2025 at 09:09:31PM +0200, daniel.zahka@gmail.com wrote:
>> swp_l4_csum_mode controls how L4 transmit checksums are computed when
>> using Software Parser (SWP) hints for header locations.
>>
>> Supported values:
>>   1. device_default: use device default setting.
> Is this different between devices/fw_versions?

That is what I presume. I believe the current setting for 
swp_l4_csum_mode is ultimately encoded in the capabilities advertised to 
the driver during initialization. For example, I am mostly interested in 
mlx5e_psp_init(), which depends on:

     if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial)) {
         mlx5_core_dbg(mdev, "SWP L4 partial checksum not supported\n");
         return 0;
     }

My guess is that "device_default" means that this bit would depend on 
the device/fw_version.

