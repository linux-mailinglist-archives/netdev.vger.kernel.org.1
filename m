Return-Path: <netdev+bounces-249336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5AD16D97
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB27303C990
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189E4368283;
	Tue, 13 Jan 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9QjCqi6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC230DD25
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285924; cv=none; b=r0K3RUH0nhclqd5KYOpJ8m7Qq4N2v8cVsXW1beKxtT1kubBmWYu56N6Lrz42sxkoYyTWOVPctAZxRpL+H/abPMS9zW32qj/qB2eGdiRGdYont78tzGq2tvQNLFtVPKT3lnmi6KTa1+JbmvQ02YLbIJQ5CF51Y6YvmssXz7sIeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285924; c=relaxed/simple;
	bh=yX7DhlFraPUD//ZuqML4tqjQ5mKp1gfm8pBA5BRUq/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edqbQhkRiOv4FqgCiO3am7FPuWZsRNlqp/cak5ROBXsbNMeAWqIoICotCxJXoniBcRSoBg5ZTIoDlVefA7ro5tn59Nju9BLbSahj5Qa8PqmxfRF+j3TudHXgmE6BDiyo5C3IJJGLcu23XcZ9LkUi3QpvQoJe6NIVHPtvZkTwUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9QjCqi6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so49537865e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768285919; x=1768890719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQhbZxT1S/lDurK26TholDxT9dj20OVvsAU3YYjIzC4=;
        b=M9QjCqi6CQFL/lUsrNPux0k/Fxi0Ix/7huip3lofiin1oMdBv3NTzN6Sc0Aop2dym8
         6jSORaAoz1DS4w/HAHNxbPI0rFghqENG1bXatbX6wEzE6zgUijGKQCkRkCQj4WM+Ndv6
         M5eRg2UEH4dpG/hMLgfUTNv2mxcBbhnVS0gNt1B6s9qQmnrTWybN39hFJKuGDW4KZp7d
         FuDy4pBwgwM7hVTXshhnqTYemLnSRmuHw/87dDhqRFzR4l2cOChxiC/6lsblovClHP0M
         PK6VlBOpjcznGHaFRpvfCTB3ytXAW0CbXKTWkDoYlojbNTiigHRs5GaOnuUHgyRSYxiS
         Ebug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285919; x=1768890719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQhbZxT1S/lDurK26TholDxT9dj20OVvsAU3YYjIzC4=;
        b=mMcLiFrmBrr/uLZyC80gQYzPm1oaVFbinF31W7TEEYLc6oHi0L2iFqiStgSYeuILt9
         7Gc937Bc6li/O2lXVGp5BshkO6N41EHtScipYXvU2l4NnkJNvxD+TpbouU9KdZec/bu8
         Kj8VJDPLnB6g4r2w702uuA4zYfUp6iiub2Ag51+W/cHmxC4c8plm4RrONkHLsRvcdjdW
         tyOVxpjGcNX06XXS/x5y2Cb2bKL26YZJacX7DBD486aQVp+ZEDNE1vEDvjh4IQUDP7PD
         Pfg3A1fx4XzjRLbNHXQsxsaM0rg5xVhbUyc0UalMPcOrJ3IZ6QSnC3eoF9/dpI9/7wMo
         xZfA==
X-Gm-Message-State: AOJu0YztANqzrtu/tf9N/VXo8ygaW7SYvK79nG1RIr8KafAAPxIXbVMk
	C8FPA59gS4zYCKgxCp8V7wYLLzN3f5gWAhWZmInvTFiJns1AfC311tb7
X-Gm-Gg: AY/fxX6t/jz5MYGD3UV3ze5qr2OUyEDv5pD8Vi4OWjItNK6MJDCJPMOpuZ3s4m4ga1o
	UDHKSly47wwiVXPWN7RejYQj4u1T1n1IyqpTRU+Dmn6eDxEyoDa/2a+Vf25yNcx7LjoXgNS5wbj
	0xcWPd55NdNZeoV4RNboqniePg8+kYJ81CDmfi1ZlaTARjO8WHTv3ry2dlc2PBzQhYnWajAU6/f
	Dxziuy4UTVUOX+tO9Aytrn56H5eGyglE9G1mij66D9N7gPC4S9HWIgI78fD6uNz2t8Ff5ULgVR1
	INftD8nhVXyeGDHiKDur9songU/qwi6IGZ/AuLneRkWwV97kWx/f18/M5JyKRvZupZ6I/pyFglX
	0KF1Ye8jrG0FfBsAkDYzGavzhBGWJSRjXKd9wkPDECl2MzKXVdeARjfnfwR1HpTV2T/+tyBtJ8K
	htULMQIj5dvabtFqA+DnZx4ok4b7u9QMbaE4s=
X-Google-Smtp-Source: AGHT+IEUAFfAI80TkN+eVQsY3YtARbADJ3c4FvvQWuIZMALTzGmm7ksRXUr+QWT776d5USXcuu/wkw==
X-Received: by 2002:a05:600c:c4a3:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-47ed1422becmr69367275e9.12.1768285919415;
        Mon, 12 Jan 2026 22:31:59 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed9eb9319sm9021265e9.2.2026.01.12.22.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:31:58 -0800 (PST)
Message-ID: <0ac69f6a-d587-45a7-be30-6ad4429ef8d2@gmail.com>
Date: Tue, 13 Jan 2026 08:31:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mlx5-next 0/1] net/mlx5e: Expose physical received
 bits counters to ethtool
To: Kenta Akagi <k@mgml.me>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260112070324.38819-1-k@mgml.me>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260112070324.38819-1-k@mgml.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/01/2026 9:03, Kenta Akagi wrote:
> Hi,
> 
> I would like to measure the cable BER on ConnectX.
> 
> According to the documentation[1][2], there are counters that can be used
> for this purpose: rx_corrected_bits_phy, rx_pcs_symbol_err_phy and
> rx_bits_phy. However, rx_bits_phy does not show up in ethtool
> statistics.
> 
> This patch exposes the PPCNT phy_received_bits as rx_bits_phy.
> 
> 
> On a ConnectX-5 with 25Gbase connection, it works as expected.
> 
> On the other hand, although I have not verified it, in an 800Gbps
> environment rx_bits_phy would likely overflow after about 124 days.
> Since I cannot judge whether this is acceptable, I am posting this as an
> RFC first.
> 

Hi,

This is a 64-bits counter so no overflow is expected.

> 
> [1] commit 8ce3b586faa4 ("net/mlx5: Add counter information to mlx5
>      driver documentation")
> [2] https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/counters.html
> 
> Kenta Akagi (1):
>    net/mlx5e: Expose physical received bits counters to ethtool
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 1 +
>   1 file changed, 1 insertion(+)
> 


