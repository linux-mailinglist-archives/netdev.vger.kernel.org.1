Return-Path: <netdev+bounces-170313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE30A481C6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C34C3A7D1C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70923ED62;
	Thu, 27 Feb 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gub0imO6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818C23ED52
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667199; cv=none; b=jT2VEaGmppK92H4x5P+a2HqCl49ZRZ+nQtUUygZ1476TnvfrZhEXBT5E/XFXTo4enOVRqgsaf3R5lEcC5GI9+z5xPpsBfc/jNwapP5d5EfLFu9c+bsWA5j+qDK1/OWhX0+1tGhFo/Kpj5YQmvIaAb2lmrl/gov3gwlT82G/5yK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667199; c=relaxed/simple;
	bh=3HNj2lcv7MZvcwGA/FLxym27Q2rgYaCGFXQoXk1HxUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyxQ1CMNIYnjz5Vu0mFi3beN7PGp8lYRpg0yEK4z+ZRYw0WsPhg9//+J9zNt8kvxxZlb99EIy/x8/sXSXYuhgQtIsbfVLcUBTs+Zz0KkCpOl5nBNOn4box85kQwsBM9gCPtpyQD5l0AHGFjKdPRFzYwDOT/tgUy+cowGTVU1UuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gub0imO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740667196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyqUBZB6nKc/r+VKm621tlxSSaBd845l3542H86vZ7E=;
	b=Gub0imO62sKApQPz95TJ3kTbQ0dSmzRU4Z7O55DkqttAadBBV4dVPD+vUipEXIf6nPtdhJ
	+ykzrRXb+GyK2b8VJdjRd1v64AA2LUpSQtCp+t3GDakYwsGzrdN15WrIiqhuoOZL1evs2x
	zuBOPtoAvhiZ27DrRVbxwm512oyTScc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-5kQOaFKQPSONonXQRmbggg-1; Thu, 27 Feb 2025 09:39:55 -0500
X-MC-Unique: 5kQOaFKQPSONonXQRmbggg-1
X-Mimecast-MFC-AGG-ID: 5kQOaFKQPSONonXQRmbggg_1740667194
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e89e910so5744695e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667194; x=1741271994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyqUBZB6nKc/r+VKm621tlxSSaBd845l3542H86vZ7E=;
        b=nLTw6kdGMPMw/ykIiEiX2Jz7toDBsotX9jAYrf0S/8oNiRz79ijKpfAoRqxZFxb42L
         K0kahD9cP9gRRZ3mdeziwKGlj2dhIJA8S8qnhF534gFr08oUhLgHwlM+i3ZFKC0Yk3BN
         4x4HA/Kt/odr027Nhqk8Lm4bFoZj8P1ONsPF0eSmKKR5vpB6io7I5u5Rn3gl61CtliHF
         7IACvkWz6AcJiueb0+QFMdP44Wom/WpgbFqWVibXa/c/RK8ufXTmGzyuzXfDicKvBQqh
         PBLDaY+sXGmjStfp5uTDxzK6lKs0WoopdVEZ0WyeNToKTGzIsu+mwkbWrtgo1OyTcv0d
         7Big==
X-Forwarded-Encrypted: i=1; AJvYcCUPizAzgQJOc0OIuL2RuGaf1m28WVnMe5pO0ADwMZNu0L0V3Yxoyk0C6PmEjLWc8upsSu/GiQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMZcqXfRHoYMPBk0yMY5mXWc7KZPni4ZS8nxFLcW9pIW8TYqV
	m1ybL3ZhWshL71PSIyyfXrMp7pHhkiTkbngBs6kTz37740vE7GR79slpkByEDF9iceIk3/qFRaX
	j6mQhLwIWlbQ2VDoPxMJ+gLpwrPcd4eOm3UdqgKddyfqCwMR+DrEwkQ==
X-Gm-Gg: ASbGncu9NM/1vz7EtYb+7j22Zzwk7Yyzmlym/JdimtQIsE2BW5W1LTfm28Ej1Jsd/li
	ROGTTCTa1rLLSf7yLJwVo68iaDKRGXdtD/tjNiYUkL5FcAKKs5RIM8AUIKRvRb3U/q5tlmEthSv
	t6RCTq4QByhpHD+3TB4UPE8Qc/r96LAtGqRczesJjNEn18vGisq21E/QiIaku7KA3uw/98w/Rql
	vXr/e/wdthv25MT7l8FIneaQStrpqFuZevq0t0CZBlJQuuvVahVSfjeJBcAcbkt108o+gsaI1UU
	Ywqy/P7TMnr+GOaqRw5km0CUqdRtAufTdxFhjcDUIxsS9w==
X-Received: by 2002:a5d:5886:0:b0:390:d6b2:c74d with SMTP id ffacd0b85a97d-390d6b2c8e2mr5688437f8f.35.1740667194114;
        Thu, 27 Feb 2025 06:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcWa/eBKcaZPmm9VXX7NkW/71dFoXSJxP3YfdCAmJI+JSIQx4UhJs1j3Idz3PrIeHcoy0Y2g==
X-Received: by 2002:a5d:5886:0:b0:390:d6b2:c74d with SMTP id ffacd0b85a97d-390d6b2c8e2mr5688418f8f.35.1740667193800;
        Thu, 27 Feb 2025 06:39:53 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7b6asm2336666f8f.51.2025.02.27.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:39:53 -0800 (PST)
Message-ID: <5913bf70-de74-4915-9ba1-9cd92dde6945@redhat.com>
Date: Thu, 27 Feb 2025 15:39:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pktgen: avoid unused-const-variable warning
To: Peter Seiderer <ps.report@gmx.net>
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225085722.469868-1-arnd@kernel.org>
 <20250226191723.7891b393@gmx.net>
 <4c260b13-3b08-409d-a88a-e5bbb3c18e03@redhat.com>
 <20250227152154.4da61f2f@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227152154.4da61f2f@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 3:21 PM, Peter Seiderer wrote:
> On Thu, 27 Feb 2025 12:35:45 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> I think the unused define is preferable; I think pre-processor defines
>> are cheaper than static const.
> 
> In which regards cheaper (out of interest)?
> 
> Both (with and without static) produce the same code see e.g.
> 
> 	https://godbolt.org/z/Tsr1jM45r
> 	https://godbolt.org/z/6sr1o8da3

I must admit I was unsure the compiler would always optimize out the
constant.

I guess the macro could still produce shorter build time (by a few clock
cycles, nothing measurable ;), so in the end it boils down again to a
personal preference.

Cheers,

Paolo



