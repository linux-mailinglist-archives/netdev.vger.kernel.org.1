Return-Path: <netdev+bounces-77177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD08706C8
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4501F2110B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767634CB36;
	Mon,  4 Mar 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MoTW53kM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE64CB2E
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569016; cv=none; b=VwGllxVG4bmXojF6h80kyrGg66CPRl73AGG+N1+sDMaWgxj7L/f/QSBYf2TYbnbwwC12PW/yItmX4DIxs+FNw2cM+znfX2zUfyZJu+/OzvdxM2iC7CHqEYa0mUVu1nCvEyAu/fl/YiVnjHxIh5qlkzhJ0HKlvpml4ErTny3MNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569016; c=relaxed/simple;
	bh=4qX90gAaeAFrZRINJudmZ0QqdDhJAmm6o0qc1B/GWAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=takYY2XUKsFJHgbXnra7csOTQhFeSwIJP8/kyDYoGrG3efGijjJOxS4bi1AVaifCDuQTcuz5I4kxAgQkrvUsHcJnZs1d1dRSJhamGq+IewcSIfBHVu7CG/5E/p/IBw3dabHMHjnEhR1Cyw/eUYQUSmDzqoxO80L7n6Psh1zyKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MoTW53kM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so53965541fa.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709569012; x=1710173812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdaQvHwf+ypTWs9CggIGE65EMaPW1/VFzdPOqyKDsys=;
        b=MoTW53kMZVcrVCLu/YQstYE4WEbBX3gmujRjc8U3j437q9pstrWz8W/TjdzN4qtLsm
         sc7RUTWf+NWTZR+QZfrL7wWAqhXgR/TBQJ9gmJyZ/dn0rPImZ6YOETetzviUh+pdQqxd
         fvN5Cpv6JbD8wFM3yS8bBqCygF0daj5nMvvhuVdDSq8nmqlTgF97fgFO2xB8MAx92bBy
         IAn/RIAJrPDRfkato24SdHlnGBdG61+fIcxwGbcbGSZMTeZ40SWTp6p2LhlRlzbP0KQZ
         G7ADPSkf8BEJVy30z+TpxSWf/GGfWaksNY3kNWyzGJlm2tOgeRWDau9WoRm9k3YZ/dg5
         Kqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569012; x=1710173812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdaQvHwf+ypTWs9CggIGE65EMaPW1/VFzdPOqyKDsys=;
        b=XUjSNqGhECMzqoVRyrgQyH7xpy2nVGKRYGQkOePho6uBZcO9u0/1iMA29z3Av9noF0
         vidP0ns95lcbxC8ipV6ll6Il53BXfzNJJ91nCdhJ6gbLqIExdiTiKZYYIWWLmFB8U3Wq
         cX5PekcJ1Xt/a1E56MJfQEaILvmGQEMY4lYYIilWBbnQeJvh4FmbSoiVjIiHCOgTzDPF
         5T8oTcV2vkCVwXrS7YOOMII2mbJ6VQ8L/CnmK2m31ItDlDM4q0ogEtselAbU/g4rHdYB
         8izx0BfiaOFtJboVVyYzEvMzRgFOgidM4mZ+TCZVlIxhAxP6MkjgTopRRJgaIhv3D+yq
         txNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXWdy6DLV6KsZQOA7/R1feY1jByGhQbCvoMHbT6tc99xBsGYW+Y3gmGwnuhl2j/OoGNef2Fug2JdZkif8OJXOZlLxclJYA
X-Gm-Message-State: AOJu0YwsK8MZ2JXQOKVx1PLJreGFohBNG/dXfrwjupH3Xr1HI/ao/gpJ
	wVgE1Axh4w3PKZIQIZhQf+Trb+omr38mu8w50bPIZo2VZJAskBRmaF2IVLGJ0cg=
X-Google-Smtp-Source: AGHT+IHyM3uVBBXYWUwq/rKQH24A4FuocxVtTgvm3M0iSLCuJw6g5bXx5w3HG6HcSOEzQFYA4xHIZQ==
X-Received: by 2002:a05:6512:251:b0:512:d877:df6f with SMTP id b17-20020a056512025100b00512d877df6fmr5958110lfo.2.1709569011686;
        Mon, 04 Mar 2024 08:16:51 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906265b00b00a441c8c56d0sm5000056ejc.218.2024.03.04.08.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:16:51 -0800 (PST)
Message-ID: <52952362-dea8-40ec-a0f3-2bdbe26cb83f@baylibre.com>
Date: Mon, 4 Mar 2024 17:16:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: ethernet: ti: am65-cpsw: Add minimal XDP
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
 <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 17:38, Andrew Lunn wrote:
> On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> The page pool memory model is used to get better performance.
> Do you have any benchmark numbers? It should help with none XDP
> traffic as well. So maybe iperf numbers before and after?
>
> 	Andrew

OK, I will add benchmark numbers in the next version.

I will also fix a potential issue with TX buffer type, which is not properly
handled in this v2. It should be set for each buffer, I think (instead of just
being set for the tx channel before initiating xmit).

Julien


