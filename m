Return-Path: <netdev+bounces-251135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28DD3AC4C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614E63118774
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8174337A4BD;
	Mon, 19 Jan 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="B9lrKQn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FC38B7DC
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832708; cv=none; b=VhVBQ1i8k0KQCXoF57amIZR5tW6h1gjhbLPfgd/qj8vcsP6Ald6vAS7i8xh68F9I7SekWt0SWl6crZS9wXeORZcNPfv96NwSuchCg5xunvDOHqT11n2sUo1NWxRiJ5+5tpu6k8NunZPjG3YGxskDgXtGvwoDdy9EVpyH8tKoXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832708; c=relaxed/simple;
	bh=zwn3NR3J76TNO7a5x3I5mEraNJ6xIEdCoJx1uNDC8OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Adnz8A+9WAxutEqW8r+2QF/JVg9zzr7lVs/HR+dKTNmS5jvjbWTmUFrX66W66HO5DSLeXkWjYUM16Gd2DgWSoSQMvG12u1IlKjXwk893V0O2+kSWDi1om8F3WCD795SzvRJuR2LtWVfljfhZpXVM0PtkAkS3wEOphjGDFFcjO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=B9lrKQn9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee0291921so28749675e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832705; x=1769437505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfcTc9w2PtOaWI0cIvYy3fPlc4TK1Uxl3CmpJHp7XX0=;
        b=B9lrKQn9IdAzZq9UITfqjDk2rBdzmLM7EEvRHZoPzTZ8k2Bd2tCqeRmJwPaNZLBxKt
         OvZH/Zp5v/h7yhdXn8uO6ISIihAmvgBbOMzdjxmVZe6oZGVIGt+Bcn9cHfMXLbSupIX5
         ZKCq4LNFFTjP17xf3IoV3Ggehnt3YRJ6adxm9B+VisbWI2tj5kpQMj/9gK/jrXS+XoL9
         3ZYtb4A2okdpgxX76mSxAa2msaPp6+5sNBUodG53QKOmQKsAYYZHBD/MNpLraHa6QAfM
         RgP5uJ16iM5H95gofugRxj/PhPPPZ2ykbJIsPwksWKfDM9VN8d12VJibWk5+RH5MBil+
         L7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832705; x=1769437505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfcTc9w2PtOaWI0cIvYy3fPlc4TK1Uxl3CmpJHp7XX0=;
        b=HNh7CIZio4N706An+GRPrnnBob4JFgnGMpc7ynIhkLeVk5ZDlROfnY0D87jfzj43qO
         ciV06xuM4mmLPl9r8zm9hPllAaYAIs2ydG+kQYKQxj5EzEHXFtgsBmsFP+R7R+qT3E9f
         f7rblQcnJOmocEpvKPxPIKlbap/0HPDY6eVvO6j3PlKSKX2d0Avt8INbLdAY0J3A6rjD
         vIfp6JR8qOTEdpXFN90qnw/Az9Wn/CHBltztmQaf9MYVa+9HhwfoihDH3M2Q+smYPX1d
         qFRZCbLP6P9KOqrwIk662elR9W6kcNdcTgo3zSG3Z190w/RXZeRoqW4jHrXys+7Oy+/d
         nr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0V0l45/H2VSoapbV8NdSVMP5Cn7AaGzqw+N4Ic1F6SwgqEgU9+vOn+mA0eXXDu9Ss+fb+M98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cOQJrimCcZYT1DKhaA5AHG0xcpBujNdJ8WAzLxqGFnfUlv78
	hiRffmbiBUsbk3FVZPQUCrLpWT3FmUU+Xsv7kTd+rATNJaGtLH3WIjl41/8bn8NAOe0=
X-Gm-Gg: AY/fxX5ZQMpNrAiXRk/tV7G6iJikoS7Ql8f9PB18IRDRgqU6nrkF3onSqfFtyU5RRyU
	BkCyOgjGtd/rDOo0gY1ru7h2zgs4R4FPoc3NRVS3GxjRuFPXV88TGw+jGgc50ICcQJuj8oFd4xN
	bvpH0/1UKhc9dN58v13VKZ+Jm2kokH6km1DF/DYIIJAQxcIQvPo/UeqA/EyPy+T7xtzsVOFkRND
	/N6jWYG1NfexcP2YQOtB4PP8zHckr6FFoa9a1UkbJ5JAE3qqoptHyQn3PtWtr6X+IAkYHlEdqXd
	WBbxRWrzop5Ejji3fbKamMctErCmQnV8UJHXKoDetoDEkblJ2eQ5zp++RzHpvJe1Fj9y6LxAQIo
	7Mv7SQ4KsP0uBMwK2iFnXQhw5sg1i1jqG/nrevzs3+hvoJAhIh47El8OBGX7Ogk3aX+BT+BvA1x
	hHjP9TS0om1lgc3CzfT/xS9oT6bbr9ybLOgmAW9ngTHwB9423KLs+IhYQGwG6B8M7J2b/jXw==
X-Received: by 2002:a05:600c:37cf:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4801eb041f7mr130381575e9.20.1768832705467;
        Mon, 19 Jan 2026 06:25:05 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm197649245e9.1.2026.01.19.06.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:25:04 -0800 (PST)
Message-ID: <eb4dc1e9-fdf6-4f33-b183-c02d77edeb2b@blackwall.org>
Date: Mon, 19 Jan 2026 16:25:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 16/16] selftests/net: Add netkit container
 tests
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-17-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-17-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../testing/selftests/drivers/net/hw/Makefile |  2 +
>   .../selftests/drivers/net/hw/nk_netns.py      | 23 ++++++++
>   .../selftests/drivers/net/hw/nk_qlease.py     | 55 +++++++++++++++++++
>   3 files changed, 80 insertions(+)
>   create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
>   create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


