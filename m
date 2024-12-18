Return-Path: <netdev+bounces-152839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D4D9F5E89
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 07:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0161691D7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311361547FF;
	Wed, 18 Dec 2024 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhMa69F5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0D33F9
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734502851; cv=none; b=qytfHCTFqi5mklmq9XBKhoe372QAkyfqqkjhSfMDA6dvdAyOoTGKYKJJs1baEffeZoCrel/NkcQY5s48uumVhcAJ07IwfpFDSaxJclp1gL2h63ozCOa2Ru+KL+Q/+dnL+5k8YH0q/uPfQFYtkukcaSSsIslzbYOUJGT10a2+nsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734502851; c=relaxed/simple;
	bh=I9Rk5h1B0FAcwopevNcVzRHQHIru8hkg6HW/glIfkf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j38EtzHOmLSR6l4Bza1zIrEaehYzy3goy+XDmaDaACmqKDLL223en5pI+udTbzRsKJk4S6flOvu501w3wiw7CPJ64Qbdiy9+4uO5QUxa4JtaTT1TEM+2tgUSm/5SHd5DtZIRkHb74la0ZaC41A57MyQ/fqfXcs2xs+tnJCCjHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhMa69F5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso2198125e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734502848; x=1735107648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94hD/h/ovIW8DxhF0ufe87hExUwtkxdEAZ9G62vmkRQ=;
        b=PhMa69F5dMiVNfaqTihWtNHtCDWS0nihvJMcxtJHXGj9Ec3stgMmoTp4svJpcyVVvW
         GUlY/GmnfQeiRW6RZcYI23X9yw6YNNMI6dcCevEuQetzbankHSubJxaGOfkC4Ku/vH5U
         iN4UgoZc/S+6M0oHspEHu2PusFPx6Rt7LOVisSYRDDc+cX7h0oocIEQHJi5oNzkfbI4z
         lGlzeKLvEMWfIHXzExTWl06HWHVkRHdcgZixhdsJSZFTz41iqODkTX1KeOhSJrjKvMeW
         q6cPT/R9ptI16Y9BkVJ0ANz8z90v3qfFgA7bphYCPeLEeM8F769Q1S4Y8PIaEF5l4nTg
         13tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734502848; x=1735107648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94hD/h/ovIW8DxhF0ufe87hExUwtkxdEAZ9G62vmkRQ=;
        b=Zn9BhB8FzBgjPdafuR8MKecGBXPOpcUXLyTmP6NVFsGMQv66YTYPi6GqqJqmQbiEyW
         ygFt9sUj28XRmg919VzAO3NOZ3YjGBpI5pXyNFsHG5UU0OzFbSQQ6sjdSjmF8jF9ZVZ3
         uTvBgED4FrWr34+01wNAvGz+UXD8Ve1zyelFZcBv1nIeAkcGuK2SDAtdmClsIJUCeuCs
         ZTyC+h/p4eNqTnW5pHXq7pJsWvym2PBKo3kdaF8KfaVh8TEAuz/s5jBDNKuM7weYWawZ
         Tjp/5lHnhXpmTrGflRqhAaAUtBY799gDwoj+UWBhsAkGGuZ4iBMw5HEou/EXa1CCMyDE
         GfIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHz1wyUxkK4vhHOcuLfp4XsQLtmMWCntcwnsyAzyRXzwV73JXZqDtj2kLngOp5qBDPgtipQ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaO8TADqD5wCV3RL8Na2VP1EO8yrNAcZj/aHCYXFS8hzASdroR
	IkdCtwL82Zh6opcrXKj9DI1J73yIGcwU1vzRK5GU31uLshWr/8mU
X-Gm-Gg: ASbGnctYY89bzgGoj7tlVJVQkuHCcR2gzFSza7E77jnQ0b0sYo7N7Cv8JFDIRCU/rli
	L1uD+iWz/vC0+WuDcP16/VMBenNKuO3MNfPZpRnVS5w54Gwek+9iZ5GADxC9ItkqN6urN+R1ChU
	a5NTw9CS7MfQFhgPPDbTv6BDULl8L58bTrzhKunNOuQ9PkLT/sPW0zIRrBxN0+ml2KBhv8fCNmj
	9GeX+oDO4NF2eOa5/divyU6drD7+3TVQBrFQwwDpFRMzr1fKzNUyiPZpAi4M3j7VBVmOxQij3+d
X-Google-Smtp-Source: AGHT+IFJP6o81Y7nC0sSYpxgyzTEKdFps1mZqRfK18tMwDCTGYkX1oG2luJ/sA9CwXbKxWCTxH8FFQ==
X-Received: by 2002:a05:600c:4e93:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-43651ff27f9mr20015755e9.7.1734502847195;
        Tue, 17 Dec 2024 22:20:47 -0800 (PST)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b202ecsm9258655e9.38.2024.12.17.22.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 22:20:46 -0800 (PST)
Message-ID: <adb3770d-134d-47e4-8ccf-cd2bc99060d6@gmail.com>
Date: Wed, 18 Dec 2024 08:20:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next] net/mlx5e: Report rx_discards_phy via
 rx_dropped
To: Jakub Kicinski <kuba@kernel.org>, saeedm@nvidia.com, tariqt@nvidia.com,
 gal@nvidia.com
Cc: Yafang Shao <laoar.shao@gmail.com>, netdev@vger.kernel.org
References: <20241210022706.6665-1-laoar.shao@gmail.com>
 <20241217104556.18e4571c@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241217104556.18e4571c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/12/2024 20:45, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 10:27:06 +0800 Yafang Shao wrote:
>> We noticed a high number of rx_discards_phy events on certain servers while
>> running `ethtool -S`. However, this critical counter is not currently
>> included in the standard /proc/net/dev statistics file, making it difficult
>> to monitor effectively—especially given the diversity of vendors across a
>> large fleet of servers.
>>
>> Let's report it via the standard rx_dropped metric.
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

> nVidia folks, could you review? Or you're just taking it via your tree
> and it will reappear on the list soon?

Please take it.

We do not work anymore with our own netdev tree.
We still work with the mlx5-next tree for patches that should be 
"shared" with non-netdev trees, mainly IFC changes.

> I want to make sure there is no
> off-list discussion with the author that leads to the patch being
> "lost"...




