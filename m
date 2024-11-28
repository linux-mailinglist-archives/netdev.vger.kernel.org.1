Return-Path: <netdev+bounces-147767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B09DBAD4
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E89281F54
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D91BD007;
	Thu, 28 Nov 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIto+a1r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE011A9B28
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808808; cv=none; b=fNbYgdCfYvmbEAO4TRZBP2wDMmquynlpXInD1mMVmKuSPzjJ3LUBTFJ8AaEvbHyWqJTgDy8yaBkn/Rx7mDe8R6uiNlA3iBEdlcJnqmfLvZInqw991OGjvzTyV4qj81CfKm8Y8bKc58cSjj3EyPxfKXZqeFkwOO1hS7cFhIwnQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808808; c=relaxed/simple;
	bh=IgAPP2T4v/x2x7+u4RSaF3joaKBQGqbNvqAmRmHHEpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0jkpqoiuobubdxjnHK4cRoyxjN2ycje7VGOceqHxb3KOkfJXe2nvnia2mI6Si+kyMIeaQDRrFLChjZBmCDbtD9o0uGir3FKZ1FHVF/On5F8LuG6mFcd8d3U+D3FSNzSHpg7UlbP/J7HSdl1Qds0XalV+XLa4/bLjMHECQThj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIto+a1r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732808805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+66w8TngamzWwV7unzOZ9JBxy+mM6EsP9BBjxdAg1E=;
	b=dIto+a1r3Xe9kql9yP1zh11IdYIqXZWsGYsHYbKWBJLWy9S23U8VozuQKtQZHkMwJ4QhM/
	aXSB2CzfE7qNMgmUVgX3dUa1hxdK1GMohxLm/G1gSvtpoVt2TdIuy/gtbwUIGKFAI3cm2s
	KDo44hf3zBY59Tzk8UIHVmArubRbErQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-WjPi9Ah4NFyo4Lb0_-foZg-1; Thu, 28 Nov 2024 10:46:44 -0500
X-MC-Unique: WjPi9Ah4NFyo4Lb0_-foZg-1
X-Mimecast-MFC-AGG-ID: WjPi9Ah4NFyo4Lb0_-foZg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43498af79a6so5890315e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 07:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732808803; x=1733413603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+66w8TngamzWwV7unzOZ9JBxy+mM6EsP9BBjxdAg1E=;
        b=jMz48fhpmzBwlC5DO2iEoa2RabVLA8BZdYjdfe/uraocYngZ2zKI+IpVcLZFNlhaSu
         jtCCjohU14ZE+765yAs0pyvbE1YG7qKbwIrkqDQE7RuAILCt/pDwaj/GQHNAiY5Sak6N
         SxE0XNFRcRd2E1GUIIKaD2lXZSvfDtpfHoxs7PBZjFWgc8WI3Di7Q85QK0UUK/fI4LYC
         e3PTFk3M3l1KwLP6+VlfWBhZB0fFXmP2htvwHupSKMLn0iYv3l9n265AWpaVQFmcophE
         3a/C70itPRF+Qc1uNKS19T0yNh7U6QqyXqCz7KoucUCYR8xvuKR4N12nhPsquR1/7mVL
         yFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUI1yKPYNQRrthaB8ULnn7sU6LZmrYWAXX4SjsIKgIosB9+HeNnWTYFoJzlwaiik9Z1TGHLvY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ81CCNQ1mnAdimeYd3NAPXIIGTzqnWD/krXi6TcqPP0a0hGa5
	QCPqQKJzVkruQQfGHv4SH0qqRkuyYqIGWlFdNiZ2fknWS2+J/qp2UHLTorM9MH88u/aibWxYZPb
	UuCzh83AXBtPLcCCVrf5s5mWy74DEbewy05soP1FnF9sOi+wqWxh+8A==
X-Gm-Gg: ASbGncsqKSTMHS/noSjmVCgzCy/Ut2l/Iah1wwPtCJyKdh6CxXCS5sjxWdmMN5YxXgF
	CfqjR2nBdfw/pfBP2TOdfkHGXVaX1mJr+yckiq+mOOixNpTSk4cEgXEKPj80Zf5tQ43DYcCODh5
	RO7j66diOS78JK1XY3VOwTYCmZByioJc5lVMpCXK5nxjkZGB51+P6S2O7DAgdJpyJZucsFlRxqi
	ncY9Xbu62nCf09YOYi4bRjQOU+c535Y30RqqGw4m4Ocpg8uMRPrU9m+wAj0e7QBxSsvsMZVc7J7
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr34497245e9.8.1732808803143;
        Thu, 28 Nov 2024 07:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsilRFv+hxO4Ile5ODeGANDmrF5PppVSkRD8XXRTbWBS5JxSKJdizZVWtAE5+xV9oUs75rew==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr34497055e9.8.1732808802852;
        Thu, 28 Nov 2024 07:46:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa781200sm56915735e9.25.2024.11.28.07.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:46:42 -0800 (PST)
Message-ID: <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>
Date: Thu, 28 Nov 2024 16:46:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.13-rc1
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128142738.132961-1-pabeni@redhat.com>
 <Z0iC2DuUf9boiq_L@sashalap>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z0iC2DuUf9boiq_L@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 15:48, Sasha Levin wrote:
> On Thu, Nov 28, 2024 at 03:27:38PM +0100, Paolo Abeni wrote:
>>      ipmr: add debug check for mr table cleanup
> 
> When merging this PR into linus-next, I've noticed it introduced build
> errors:
> 
> /builds/linux/net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>    320 | static bool ipmr_can_free_table(struct net *net)
>        |             ^~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> The commit in question isn't in linux-next and seems to be broken.

My fault, I'm sorry.

I can't reproduce the issue here. Could you please share your kconfig
and the compiler version? I'll try to address the issue and re-send the
PR ASAP.

Thanks,

Paolo


