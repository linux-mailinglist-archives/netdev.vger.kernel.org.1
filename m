Return-Path: <netdev+bounces-207092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D6B05AA6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DC4175806
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1C2DC338;
	Tue, 15 Jul 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjxNKPKo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999F1991D2
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583958; cv=none; b=anVQ5NlfDOcEjBTaZd7T7s7kKLWLewFVfwTuKm1G/e7Xoixq1a6DiuvOlv78Xt1ZfRvR/AUovuKuoEe0ZpHPUkR4x8EV4gN9lfYWG4i7YeQPKH3k1f7XDK/+XPVHiI0o1nWsaJtfAsghbkNLXY5CBrlR2tmEImorTU7hXE5LeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583958; c=relaxed/simple;
	bh=gMxgD/jHc+2AzQTHOAn1r0+giU8hs/bMkfpWkvgOXSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bclG35cOvKD2IsAfqYLJKvc4sbrhRXOKnfzDIejCrfMcuIdo6LXlQ4qc0kxDyCQEeWe2kcVsr70oVQtyp3f/LxHXkOh/gRSh7qoHYflUxHVMMbpQCLc3bZl8phpCDh7je1f2yDu+Wh7hxW6+u3PdO6PugE4HUVgAmEALmykATeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjxNKPKo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752583954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvVpSdzv3YtcSg+X5H46oFJ95u5NW48R7mGmsXuYiS8=;
	b=TjxNKPKo0HIqwg0t74f25nJQjbHMEvJ9235UeHUuPcoLjqHvFXNym9xlWt9P0mIJBh9VbX
	reeecpjYCwsed9uEqkwF/gu4BZvFHWcQYMufaSyCK8EiOk4EHcmGU3xmGPxWZB+dIrF3JD
	WlX6r5yIlEqADKzWGee89V22aL87zbs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-yPFTh1uuOdehuBd7gLqqjg-1; Tue, 15 Jul 2025 08:52:33 -0400
X-MC-Unique: yPFTh1uuOdehuBd7gLqqjg-1
X-Mimecast-MFC-AGG-ID: yPFTh1uuOdehuBd7gLqqjg_1752583952
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2819079f8f.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752583952; x=1753188752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvVpSdzv3YtcSg+X5H46oFJ95u5NW48R7mGmsXuYiS8=;
        b=NdMI7xuMb9pjJE16IGGkaCytgZBucTbbLzZwf0oQQiVKVB98+GP+43KaQUUkmNcc2J
         mGD0l99JwRvBoZlTemt3cw2Zvs5bTIAIGR7vgKP/SvJUiQ4bV/6M9YSvrtL2Dlvi4Qb0
         OYmDXXD0R+BquWtLVhkYPjnged8aUrXTIuy+xwajtHaqYVBUol09mhPAV0oCLTtcMsuB
         PDUuS5YesHfU/UoERr7U9vuyMXRoWYnJBVIp28R9noe3GZjCvfII41Jvx6zG+TaU185p
         oy9uRnoztK3DSMs8zRJ8731/yPXHlwkjVcDp6PqJB9+NsGKAWIjG0jfQEfoaFZMIB+Cj
         TRMA==
X-Forwarded-Encrypted: i=1; AJvYcCXhfx02h0nwcHC9hk8Y8J8hSj5yDrc7LPzwPJnJl4n1Zn1bTud/3CeaCxUmFKQWUUJn0qq6vII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIv4pkcBff3wk2geGJHVz1YjhFMg/deGuUXRmSv2Bp8aWEpSiG
	azJiWX2l2/1dWgYhHb8p80qrFkODxnKrH2YmIYy7EzfqT+uBAoTNI7Lv3ZKjY0+ZDTWrbWMmkKe
	0FeWEPQIkAn78jv0+90vhf3PN3fU/MkBkP7hPj0hmOfnYHB30heGCdYR2jg==
X-Gm-Gg: ASbGncsNQQ1AivQQt+Yxr5k1Xae2xdun542XnG4aKpON3oD3/V+EA/HVL3JdRVK43Ub
	F/Km51wyM5FvIUSKyrEBtadYPJmlZWWjbcUvnOy7IOhh7AOgha5EErW6nkXKqCQTWkr7wRehuXB
	6TnGqq0h3CH1efgp9pDkm0SgMAkaxZaWyqCtJ+LcPiMn8LI3PRJxMHRkmIUvfHV1N8jgyuCQOKE
	R3r2779eLxO9MAxdjUPS44Ai6caPhM0LVvHYBtIt+WEqaVyfQfmzrvY1TWGGFKka1E0Uz7QKY4k
	XkqfzsXyNEbH0zBaI2nbqcSv6r/GN0cYnEgO85OhKB49Sl6Y6W1fckopDTzVy3b9TvsZ92Fe7li
	+/Ro9o0fIh4U=
X-Received: by 2002:a05:6000:240e:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b5f187a4a8mr15981417f8f.5.1752583951881;
        Tue, 15 Jul 2025 05:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk6whxkpD+ZnJi+AFXFzXHj/JdmcZrj1AhXbJefofS2lzfgO3cwST9mnMPBPIRYX60i37o9g==
X-Received: by 2002:a05:6000:240e:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b5f187a4a8mr15981397f8f.5.1752583951458;
        Tue, 15 Jul 2025 05:52:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c8bsm14898388f8f.88.2025.07.15.05.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 05:52:30 -0700 (PDT)
Message-ID: <c954b60d-130e-4acb-9390-3e632803413d@redhat.com>
Date: Tue, 15 Jul 2025 14:52:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] dpll: zl3073x: Add support to get/set esync
 on pins
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-2-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710153848.928531-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 5:38 PM, Ivan Vecera wrote:
> +static int
> +zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
> +				  void *pin_priv,
> +				  const struct dpll_device *dpll,
> +				  void *dpll_priv, u64 freq,
> +				  struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	struct zl3073x_dpll_pin *pin = pin_priv;
> +	u32 esync_period, esync_width, output_div;
> +	u8 clock_type, out, output_mode, synth;
> +	u32 synth_freq;
> +	int rc;

Minor nit: please respect the reverse christmas tree order above.

> +
> +	out = zl3073x_output_pin_out_get(pin->id);
> +
> +	/* If N-division is enabled, esync is not supported. The register used
> +	 * for N-division is also used for the esync divider so both cannot
> +	 * be used.
> +	 */
> +	switch (zl3073x_out_signal_format_get(zldev, out)) {
> +	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
> +	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
> +		return -EOPNOTSUPP;
> +	default:
> +		break;
> +	}
> +
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	/* Read output configuration into mailbox */
> +	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
> +			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
> +	if (rc)
> +		return rc;
> +
> +	/* Read output mode */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
> +	if (rc)
> +		return rc;
> +
> +	/* Select clock type */
> +	if (freq)
> +		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
> +	else
> +		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
> +
> +	/* Update clock type in output mode */
> +	output_mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
> +	output_mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
> +	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_MODE, output_mode);
> +	if (rc)
> +		return rc;
> +
> +	/* If esync is being disabled just write mailbox and finish */
> +	if (!freq)
> +		goto write_mailbox;
> +
> +	/* Get synth attached to output pin */
> +	synth = zl3073x_out_synth_get(zldev, out);
> +
> +	/* Get synth frequency */
> +	synth_freq = zl3073x_synth_freq_get(zldev, synth);
> +
> +	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
> +	if (rc)
> +		return rc;
> +
> +	/* Compute and update esync period */
> +	esync_period = synth_freq / (u32)freq / output_div;

Here there is no check for output_div != 0, while such check is present
into zl3073x_dpll_output_pin_esync_get(). Either is needed here, too, or
should be dropped from the 'getter'.

/P


