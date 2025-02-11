Return-Path: <netdev+bounces-165239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1668BA313A8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9481686EF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DE1E47AE;
	Tue, 11 Feb 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2xRRxRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D81E3DDB
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296875; cv=none; b=Q5tAW2QKAU0IcaxVWRu/qSXjRLBeD3S/kWb4DIXgt1BjnFUkF+iV4zCfj4C1gUuagJyQdp05s9ZVnB1MaDvPnbGgKpDsa2AIrXCXXKloev99F4OxIUjgD3GCPNcrFxBRvm7FKQmzJBzPVE5ZNsiQdJzH5syygLWjCox+ObsJ8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296875; c=relaxed/simple;
	bh=SIiwHZQlgP8AFuGx594GiHgOWcpn2MOI+IdeTuHdFow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTjfbK2oQ2v/x0WhNK3dQpchXPxn45C0G7+lIuEOsMzaFApYa6T4+qdTDzb5uN40t8FWXUvybTneeqbM9JJLkFQjYpxNKV2O3R3eeCww1XtLnplGyduW9Gyh1ykH+PxZ48yVNL0zUM2FvBQ5ynaZPgjAwG6miB87CCuFV+qdh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2xRRxRD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dd006a4e1so3123002f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739296872; x=1739901672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwImO1XUzWGswwYExnOAqPsmIAJIDS/VX6q8rFFvDH8=;
        b=i2xRRxRD5vKrMthgqR7tW+w0P7/MQFf1TgaTeJr6MFtbrhd0E9TBsHj4cOHd/cYYkX
         Qj9UTB+VxPYV3gwN8OdTyDPa5Y3eYdYvCgv/iLi1TwLJQVFg00ifWYz7ArzKO1acfryl
         g9VSPFV1ef3do3mTDxRYBuknbG/kvIms21N8hEre5llF/hFq1WbYEwL7k1Vrrt/ikap/
         z2+OgH+RH9NgbCW0AtvVWyEmF8jszTadt1Be7KhraP82L1NeKABQ710lOTd60OigBvG6
         wIaV8EfWcF1yzOLCoJrQ3v4Wa14QnrpdWQJGbNCLXxA15dbPxDR062mMpMrxOym0iAhc
         pPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739296872; x=1739901672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwImO1XUzWGswwYExnOAqPsmIAJIDS/VX6q8rFFvDH8=;
        b=TzZ5y9Mf8gEl/k7Wdp/UAL9Ix9/XUh9nFOMKTu848QUrfm4Pot+lQ6u0ol5OWKCNFE
         +ka5ozJzJqK+mXRtVehhznUvHL8hJBukwg8i+tvwEu4drO4cti42N6aaBop0sKzBgsgI
         gva67sRsEZU6jCLCEC07yPh368/ZHHAkBFJd56qGVcuqvayZl1AkWrsP6XNpekmFspwA
         UuGyqx7vPSrndL1ZYVJ+ArnBtAiR/uFBMaISup6KzDd7+ePC6LzX+WAXAlJL1WsLbLU9
         dYGzOi6XW1cBbVol/UVfnxnxAhJUY7qFeY+eSmGh8+bIWjTsBHAAYyDrxrlSGSG0xZXJ
         47ug==
X-Forwarded-Encrypted: i=1; AJvYcCVArZ8FdqWwJurFSUTSc0crzCThSjtdufvWvAKyr8a9Pgl6q0jwLOFQIVlAZI/L4G2gLqyJKJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40K0ZDt5H7R8Tc64wp6O6xAAG4KFajWA7ibIieH3xOUrQFCmH
	4UUSmoQ82Q1d3EFn+cnCMKPpe5CH/mOZdmOwscHCEupzCbo8hY0P5ebsBg==
X-Gm-Gg: ASbGncspp5d0Unc4oLwsUjeuB3exGeZZ2gTgNqcyrZ8qxv2FOHQvGBKWYpnSZZjONik
	kZvxqgeT3cn7qrBII3HXe4V/+MK0D959Lx5IGfE9QVT/ZcczMDjWbOXHCuVx97iKV7IjR8eWFd7
	MEo6UEAMJ2mxiXls1QDlyMdQ1jdhf4GQMi/lJGoopMPPZ9e1V+Iz3SoNGyUBhAoMtIeNPI2/2/X
	vS1atOiY+JTL5MeWSzOeFdz+wZJ6qKESj9hUjKMyPabakOIKOeIE32tiHnaQ82j+spGr4qJvWOV
	gKtX+ywbXHz6vD2dcO68F4rkf3xSnDaPgllt
X-Google-Smtp-Source: AGHT+IGxUoxSFxC2sHh2GHCTtcU3evUXqNSgVJFDGyymTujfoy5EkSsrFhfQcQ1GHCMtFRTOldNMsQ==
X-Received: by 2002:a5d:6d8d:0:b0:38d:dac3:482f with SMTP id ffacd0b85a97d-38ddac34a13mr9653457f8f.20.1739296871509;
        Tue, 11 Feb 2025 10:01:11 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da96502sm188231645e9.1.2025.02.11.10.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 10:01:11 -0800 (PST)
Message-ID: <18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
Date: Tue, 11 Feb 2025 20:01:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-2-kuba@kernel.org>
 <76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
 <20250206150434.4aff906b@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250206150434.4aff906b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/02/2025 1:04, Jakub Kicinski wrote:
> On Thu, 6 Feb 2025 21:44:38 +0200 Tariq Toukan wrote:
>>> -	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
>>> +	pp.flags = PP_FLAG_DMA_MAP;
>>> +	pp.pool_size = MLX4_EN_MAX_RX_SIZE;
>>
>> Pool size is not accurate.
>>   From one side, MLX4_EN_MAX_RX_SIZE might be too big compared to the
>> actual size.
>>
>> However, more importantly, it can be too small when working with large
>> MTU. This is mutually exclusive with XDP in mlx4.
>>
>> Rx ring entries consist of 'frags', each entry needs between 1 to 4
>> (MLX4_EN_MAX_RX_FRAGS) frags. In default MTU, each page shared between
>> two entries.
> 
> The pool_size is just the size of the cache, how many unallocated
> DMA mapped pages we can keep around before freeing them to system
> memory. It has no implications for correctness.

Right, it doesn't hurt correctness.
But, we better have the cache size derived from the overall ring buffer 
size, so that the memory consumption/footprint reflects the user 
configuration.

Something like:

ring->size * (priv->frag_info[i].frag_stride for i < num_frags).

or roughly ring->size * MLX4_EN_EFF_MTU(dev->mtu).

