Return-Path: <netdev+bounces-200637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E2AE6638
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9253A72C7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4642BFC62;
	Tue, 24 Jun 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elPmPNa8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238E1F4C87
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771475; cv=none; b=n/Lrymlymqu8v3hwGdd78a39CTgg0SIeUujq+UFUoWIF85q/MVtCUr8B6LOlwQyqKwRhtZQOl+0hkds87vxIAErSt8ZB99NCvDOxL28cKymI6Cyj+seMXLmn7Nynxtr1iU/QbkilAlnqkF0oYb/vEgoPBRj41854m+d0wsa5Mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771475; c=relaxed/simple;
	bh=ayCU+nkPRr6n8YMzwOwtPyFONRi8G8Mx6ULPM9Iu10o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqt8FRe5VTDG4TFrUMfiSalbN2UyRoZNPJX/nnJkfWkyg/M9opTL/hIBfT+PpCqvZUEE7H3HjAZj8/nZlBpLI5dzDIS7r+Pv616lMA11QYKrtUj11z7ffTWpb3JvKA4YHekL5ReShyXSBj5xpXnIbgKbPUDrSsX8QcSkCA/ZbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elPmPNa8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750771473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aK5RkAHQrhrmbMgDmli1jYjYYGO7nTlMC7kAqH+maLI=;
	b=elPmPNa8qUY/rQWff6eQw9fVoW1T+iLrXbmOTFvu3Rt86pAylfJf/sYfMvG00ydpMJZsj+
	4eoMKtOF5QUQsMGiZJltqTKF4SN/FTashuBiLgrjFyqh/P/W6CUoD7ob1PRUzl2V+agnJC
	WApxmqKWOUFg9B7b+LYenbIPE2OHIJY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-FpXWRxamOfu6VbO3NEKVsQ-1; Tue, 24 Jun 2025 09:24:31 -0400
X-MC-Unique: FpXWRxamOfu6VbO3NEKVsQ-1
X-Mimecast-MFC-AGG-ID: FpXWRxamOfu6VbO3NEKVsQ_1750771471
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso250289f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750771470; x=1751376270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK5RkAHQrhrmbMgDmli1jYjYYGO7nTlMC7kAqH+maLI=;
        b=gzyutIV1JwPUPmLEszj5mKMVw4lthCOCD8AZj/grJEM24j9fiPMj4GhQGLUOUjLUsb
         Ksjbbcn1AyKkOs+cknLY7XRhRCA7K23POz+Ye9WBFFyuCBpHBXPVQPZ8cr+4aWBP27tv
         K4ejHXSou0WRV4X/PuMjVy4pmdt3/SEFwNswdV3xDfIgBsFGTaAe/O86rf2AxdKYbir/
         yl8jZRgFwyj4BS8glHSgJDjtIUsm4a4o2qiyGkhog31TkTw9AB4NNB9H9+PGL+Z41WQO
         tB8u///Ims+eGaIk8K/NJS7cOwAX8c0U5s55AJMNkA50wwGBc23ty4El4e0egcHFg8Q/
         oH6w==
X-Forwarded-Encrypted: i=1; AJvYcCV8zoj9fdzhnT/fYdhSzLzl0WtkGYRhYCRYSsPaAk/dCOVhkW5a61GJEAHSzJbUjRs/0BboFWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5u3LgJ55jv/lJaS7JhoflK0/5zF08HG4EID8iSYBXOxVBfchF
	jxJpYkBqS2HDJdqD2EU5EBZGfb/ME1AhUw7xdPM+3Mf1JGXx9mp9IcViMCyd/jRg4Q7O6Xn/JDO
	BTVWzwVZLxjAz6AwpeLT5F/RnU8T9OMRBzm4jJcSN2fFZbNcUTIjS8Vmglw==
X-Gm-Gg: ASbGncstQMivIqAkr/N4S1+PGJiPPEivrOJtdhnfIUFEYdQO3Wcpo0K5cIbexAjVuSh
	4jooh9wgAu+I4HFiFMBfcpbKxhwX9W/k10ay88/1pR8FmC3fghzDMKpLg2mIrdcWN7iWMknGb6t
	iH38ANxMVbR7PMiCVGnJYy0HwdiTqkOZaKhdiGj+caU7xt+eJpQV+1YnlzOxevnnC6drW3wmfAr
	w0Oc7m0deL6gXpB5vrgsFPjLMueuqdwY5Gl4bhNA7GBcEVdXuSSE1OdsZUzb31SR1/D4/EBR3Zq
	vPGWOveY4nYwjp3TLL3XzgBc9V1VtQ==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:d0dc:184d with SMTP id ffacd0b85a97d-3a6d12da029mr13966777f8f.27.1750771470455;
        Tue, 24 Jun 2025 06:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFZlAyuiksuIl1Yo2GNzHDQQeq8cn/28qYo/og94VXjH6d5Y5X9A9bCgyxSiJRdNpJZsF4Q==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:d0dc:184d with SMTP id ffacd0b85a97d-3a6d12da029mr13966735f8f.27.1750771469988;
        Tue, 24 Jun 2025 06:24:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2274sm1927739f8f.48.2025.06.24.06.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:24:29 -0700 (PDT)
Message-ID: <b31793de-e34f-438c-aa37-d68f3cb42b80@redhat.com>
Date: Tue, 24 Jun 2025 15:24:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v13 04/11] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250622093756.2895000-1-lukma@denx.de>
 <20250622093756.2895000-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250622093756.2895000-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 11:37 AM, Lukasz Majewski wrote:
> +static void mtip_aging_timer(struct timer_list *t)
> +{
> +	struct switch_enet_private *fep = timer_container_of(fep, t,
> +							     timer_aging);
> +
> +	fep->curr_time = mtip_timeincrement(fep->curr_time);
> +
> +	mod_timer(&fep->timer_aging,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
> +}

It's unclear to me why you decided to maintain this function and timer
while you could/should have used a macro around jiffies instead.

[...]
> +static int mtip_sw_learning(void *arg)
> +{
> +	struct switch_enet_private *fep = arg;
> +
> +	while (!kthread_should_stop()) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		/* check learning record valid */
> +		mtip_atable_dynamicms_learn_migration(fep, fep->curr_time,
> +						      NULL, NULL);
> +		schedule_timeout(HZ / 100);
> +	}
> +
> +	return 0;
> +}

Why are you using a full blown kernel thread here? Here a timer could
possibly make more sense. Why are checking the table every 10ms, while
the learning intervall is 100ms? I guess you could/should align the
frequency here with such interval.

Side note: I think you should move the buffer management to a later
patch: this one is still IMHO too big.

/P


