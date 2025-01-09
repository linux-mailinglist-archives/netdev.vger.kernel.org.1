Return-Path: <netdev+bounces-156710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E072A07914
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9103A17FD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107321A450;
	Thu,  9 Jan 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8q1KofA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEED219EB6
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432665; cv=none; b=A+iogVR+aHOVI4y2zF2Yg4HeynN2+af4Zs1nVVzvcf56hD4R+ZXGMVOSFt0BuPHLyYFgvDgZiylSq2RWRjN/FzWUpccz6nnn3LF6YR8R6kgXS/80p3OirLK1FIxR3+5lTYfLSHcz4tHul12/Pyi6hMlfHebR1cn/envyIy3lsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432665; c=relaxed/simple;
	bh=BsBmAgBcFrV1F7gJtGOm76TOesx/AwJFuyx0ecANoW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekkzxX5gwYTevlRup1zTLUiRWqZzNHvPJU+tjzTPYAeU7qW0ll7tEOWVYsh0AxDR5T2OBr3sKIQAgS52vENO5CfHXWU0L2z2g/mXGTlYnY7k29T1YZoxBMFeznv0EfNQwh+DVgQKaEUd5/x6Aq6ePzcCXAyRTNGvRJC8Gbj5E3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8q1KofA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736432662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPqqR/zrDDptX7kSZzx5HpX81ITM6fqj1FdNU937MfI=;
	b=I8q1KofAv3+ABh0zdbUE0K53CiBoRXS4F9xkEeTzIsHw3WZWyu3y3eD1HxVkVnh34bef1C
	CYmOUegw2B9il3J2iiBMeyn1du9TD4uXJwL3fhJE1K89UKvScC6M9OOgfipph0yrewQ2pD
	Jl0IUzqdZ0pfu5tT/2nPnoCmpXsWifo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-cEDQ9lYuNkSOLTy2hJffcA-1; Thu, 09 Jan 2025 09:24:20 -0500
X-MC-Unique: cEDQ9lYuNkSOLTy2hJffcA-1
X-Mimecast-MFC-AGG-ID: cEDQ9lYuNkSOLTy2hJffcA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43673af80a6so8576615e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 06:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432659; x=1737037459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPqqR/zrDDptX7kSZzx5HpX81ITM6fqj1FdNU937MfI=;
        b=uM75D5OrgxOIjF2iNYF9UUyMo+omIwthFVeDoN+E/on27e0zLjsB81U98E+0tTRC67
         4OYiJHkZJHM1YQGSRXH/EZtfiIuafoOpwgXhukQwhcEnq0xWzSzto6rI3dVPlpmX5enz
         gBW7j8sAFJk+uULlJYuUWOKqKkx0/Dhv2NT8Y6tVS/Una1MlYRJSCJXQRgC9EVkhtDeK
         RbMAJxGLTaw9U40xjzaI0NtPwrlD2PQK9hPYVFLpFoteA29c+ieDQw5TxnKUqlmjBSnI
         47F/h7q4PjrK/ELwpaOeSwLuHSDk5QqRG8aR2+Q/KIq2THl2sSzv8bjelE13pWGzB9Y9
         MJtA==
X-Forwarded-Encrypted: i=1; AJvYcCX6zTbKgRMtbYyHOTVR5H4VhFmtKqHcA/qatieCR+KFB/FlPwm3yHRLyxeZZhOWBRsC4U6i0iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPc1KpHcJkULXvONLckTWMp4tytrsrlbiQWSi9S6UI4n+eNyE
	8IGtP8FN5AbQG+GjXrGg+7zhn+eE4Xc6b6W8Ha9TAovoMK5kvtrg09yrW8L16KBud4KlghKgJAh
	qskKSV20tb+mdBpL5Ia1/qBV/SNbvmtpRsO8gbVJF2iVwE5g0GkOEOg==
X-Gm-Gg: ASbGncsaebQZimXxPi8UG15tU19z5G4a+/pY6B7zBi7YWn3TsrCiaWVgWwQLbyfW5/N
	blXCzTGrNni/DTNsWMP6TIjoU76U72bxXCr/FxVol3puiXS5U2SMgIL/8y1lwszAE5e8RRGnT6D
	nUroeDXcN1K0d7fy80QMO3lMr4uZ77pDM5K2BqUc7+YSLBId0SIYYVi0pfvIVJ8meOU6TG9TaBc
	D+5JRBrk/tgk3kxWq/OYzd4Yd2FjLb+m/6JvfpCdQiSvkjf1z/IPt4pUrj4sefrkPdGA5TfUg/q
	LSQFMorS
X-Received: by 2002:a05:600c:5ca:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-436ed385da5mr12957935e9.12.1736432659225;
        Thu, 09 Jan 2025 06:24:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj2gONdsOaPhPeatt8x1sJkwEGpoKEyq3qgNjTYRdLaHAyc2JgMZwwYoSXDwup/atZgnClrw==
X-Received: by 2002:a05:600c:5ca:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-436ed385da5mr12957535e9.12.1736432658844;
        Thu, 09 Jan 2025 06:24:18 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc895esm22430345e9.13.2025.01.09.06.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 06:24:18 -0800 (PST)
Message-ID: <4669c0e0-9ba3-4215-a937-efaad3f71754@redhat.com>
Date: Thu, 9 Jan 2025 15:24:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <20250107152940.26530-2-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250107152940.26530-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 4:29 PM, Alexander Lobakin wrote:
> @@ -623,21 +622,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>  	return ret;
>  }
>  
> -gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
> +gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
>  {
>  	gro_result_t ret;
>  
> -	skb_mark_napi_id(skb, napi);
> +	__skb_mark_napi_id(skb, gro->napi_id);

Is this the only place where gro->napi_id is needed? If so, what about
moving skb_mark_napi_id() in napi_gro_receive() and remove such field?

/P


