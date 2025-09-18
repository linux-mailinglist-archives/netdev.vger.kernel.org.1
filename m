Return-Path: <netdev+bounces-224254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE86B8308E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AE84A383E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858D2D6407;
	Thu, 18 Sep 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwfhVndy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DB246335
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174223; cv=none; b=gaI4DNK24UEoKMjIXDEN+oubRjbDuUrABg33BoQqiasiAA6LhjbKhpv+wXk1rPFsUPFs4lwXj2lvgR8x+patJNHpN07bBMhBXsxpqbzIpVXcRUJGn1ko2qpDUbxikyZi0cJ2JGgyPhnCJE1BROqHZoTmnD0xOD9hhe5SWDzhd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174223; c=relaxed/simple;
	bh=WiVw2hdPhptPEpvb6eK0gcQZypwFWp7SJ5iaQE0tmIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo92XVYJSrZyO9dhJTKJoAMZEnHaIizDVscF5oL+72k6NzcKmLBecnimILAQW/Qs/mg4sVVMOlG1A7ZXjvlyYihw9B9tbOMVEO2UBu8cmCUdobx7rfVDkMosw5ExMeKP4DYzN/IJ88STIQjPWsp+MjC0GvOy9byrqqTU81HMPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwfhVndy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so5007505e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174220; x=1758779020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wb3SYSttKmaL3SKxkyO9xRj5BE7MTsi15qxMBdyPQIU=;
        b=UwfhVndyu/4h1v7aYnFbckjaw2HbjwMPCHZ7i42ZishkMrVGVzTLtzn+lAQtHZsMzP
         22mvN461ewnQjFGWTdMrLgUBuwgMZIeJ1u9LRRGuVaRoEJOBSgLOqcwA5YaIQL0tKVtV
         RfXTBOPogiSdAmgzwxLuUNSYC9IKMuKWsm/Vvm3i9mrdSlitjwWNQnKXLynXiV8xoKag
         /JmNssYhV0T4hSi2LdESu+/be8+t1EgObS4CKirljmi6/QF75edWIUPTFqkcxfmXQ36W
         t1w7CodOIEjpWVDchn5rBX6x9O3Q1sWbU3z9Ju5GcO2f8QJXS0hUKni07i+NllzzJN6Q
         jexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174220; x=1758779020;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb3SYSttKmaL3SKxkyO9xRj5BE7MTsi15qxMBdyPQIU=;
        b=J9Htue8GRsv4p8IUFmXv6QIibUTD4zJPYDOxsLJua5fNABjg/FNmDyHYhQmAIfx7mk
         FLuubO9u4CJRHKzBMB6VPsmZ6glXUiqPFhzU21Sv9Myr+lKvPOcAc2Cz8l9kSByn1GBw
         64qTbTdAewQKlyMv7hyYQIk/mbt3GdPGX9OLoXmzc0uzlfiUc35CX9mijWvMF8Olu1dn
         pd0KMhDHaMnsyXAQvkYk4DJTaEL5n4e9WiReg0xNaC47yEQlphzJqp2Q4blr+6RNOe0O
         G/Zatzexv2jp05twsZWoEjS/JggRpRA72u+zHNMFs+ccSBNO+WHEOawY4XgyNt3+1jfS
         ruVA==
X-Gm-Message-State: AOJu0YzEgflD0pK7YaSRfuHSwYbP/9RBzOtHr/F+Xe4WeMQNf1eCMSZB
	7tubTU+yMyJktgVHurd5uJMIvpZxPIqZvk7tTITFFKd9oaG5gjXySMm0
X-Gm-Gg: ASbGnctZmN80pG5MEXXkCbXMo1lxFncLGgjjTXL30sdkl73wpQHW9/pCw9kVSf0R5Af
	SNUghRYQPwVAnj0VjYqbjxlZ2xeeAsVHA1Jx/latHbxfPq2WR9RtoIplsTX+Iez2mwc0yiuG5Gy
	8h4ORIE9QXgZMzm1S9iBKXUGyLG6CtkHxpJXlKibEAXoe8zDkwWn7VQClFgHw5F2K9yRjm/t2hY
	PDCqZHlPNljMrzH9pllYCXQE5bOyOZubH+oe/TGZYg1Dlbxh5CmTd3CDKBBUUEHpqGhqEwBUtVo
	IG2R3FnkzwbZMeP4fhTojfCXhspGw/T+pemm4gurYGg854DF5xRRkN+oX/1aaphyhiCn2lzu8lO
	otw2KfZcyhQZKuV2hmXryTRt+U+UTHkMN3f1ccp0ak6PCAUUT3Y3Cy4XBTPez/fucjGqwHiGALE
	jxD8z/ML5zRfjjII++NQEJnarPVE1LPfVk5mZmlE6r+RPAAcBRs4nptp/Iy+NpfFYiA1NRBRWfq
	zsoe7ei
X-Google-Smtp-Source: AGHT+IGIe7pHRUjgRkjpNVpi9bZcuJa0OW8ml9h4OElu398A4FpTzNT/yHh5BNXklfxTQeezZQ17Sg==
X-Received: by 2002:a05:600c:42c1:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-462d4ca0573mr26840965e9.18.1758174220339;
        Wed, 17 Sep 2025 22:43:40 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f01:5e00:64ab:23eb:a9ce:c1d2? (p200300ea8f015e0064ab23eba9cec1d2.dip0.t-ipconnect.de. [2003:ea:8f01:5e00:64ab:23eb:a9ce:c1d2])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd5d65sm2031907f8f.46.2025.09.17.22.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:43:39 -0700 (PDT)
Message-ID: <014711f8-2d63-4ba7-9c95-89b171476172@gmail.com>
Date: Thu, 18 Sep 2025 07:43:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: set EEE speed down ratio to 1
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918023425.3463-1-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250918023425.3463-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2025 4:34 AM, ChunHao Lin wrote:
> EEE speed down means speed down MAC MCU clock. It is not from spec.
> It is kind of Realtek specific power saving feature. But enable it
> may cause some issues, like packet drop or interrupt loss. Different
> hardware may have different issues.
> 
> EEE speed down ratio (mac ocp 0xe056[7:4]) is used to set EEE speed
> down rate. The larger this value is, the more power can save. But it
> actually save less power then we expected. And, as mentioned above,
> will impact compatibility. So set it to 1 (mac ocp 0xe056[7:4] = 0)
> , which means not to speed down, to improve compatibility.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
> v1 -> v2: update commit message
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

