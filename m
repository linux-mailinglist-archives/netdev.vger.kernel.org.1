Return-Path: <netdev+bounces-223418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A33B59136
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3681BC397E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715228850F;
	Tue, 16 Sep 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVW19nBe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56A283FD8
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012412; cv=none; b=FwNOTeB5gnVg7Tb1zg1NmE9l28hwrUj0IzGmJlnySD1yJoBb31GgVCsYk+pT9Yghb5JbgEPziKtdZT4GQohX9+s/IWQt6kCUK+f9QwYvQxOEFIsUIuc7mvOtf9ZBbu3NW2LpUV8nvQM5PFvlFyZ1hdeGuKyopyArLIE312DnBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012412; c=relaxed/simple;
	bh=QcMaj/WzStjNB51s0k9tl5i0oL4EotZ8wG3RmlhEFoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE0UxxMXZlpDw1Q/wupE041Evxac/VhdkOoF1iNdnO1OxlXT8ecr62g6yowBZzY+1GumfpN/3+/zdHacAPEhQ5yrBXmcKcPWy5st0PBD15VD1JDvpxcjSeDQ5ml4PYK0VZZHt3zPWnpL56TXI4pUKoAwV+aObIz4/hfzxKZyeIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVW19nBe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45de1532995so3402975e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758012408; x=1758617208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puPEj8h0FBCwOAJYXSMVEVIVot+zm3VeYtFHsNBlwoo=;
        b=WVW19nBeQH2PZ3ewxiKaIRwml5B0ZygMnr6Bi1jdwCuel1QwoXENA/0JUIa6Bbxb9b
         7TpU7PjtOiKsb8rKQixb4vwZ+2jKtv3eCapq6itRSMR6iOP1M2elCzVS8gdkMDBIQ8wY
         T9K32r8mI3GYhTBPHoQdjCMmyMbNjPB+lGNaaXRtvxQcrmvbhU8Om97ikeKOC/RfUzTa
         Abu+DaFK5mIuW9z7d8J24JHTDg/3m/hePxOFbLYgZyROZ4v0uc+VZFEFVVpaLPmtGGEY
         /vK+Qj2VFZfURWtVJjRFofqU/ypThMLwWJ3MqgZjh09qICn8kMdPYTlZbjphJTfnlpRv
         itDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012408; x=1758617208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puPEj8h0FBCwOAJYXSMVEVIVot+zm3VeYtFHsNBlwoo=;
        b=m4IOhgbdUg8g/kfTJaC6/drGZvyNvNekOnECwM3jcpCxQLpAC9TEb6LXB+5wxVv4sr
         ZnRs0w60EafzebxLvKkl/7DPCCYamHILOjy1k+ECxtCI0zbejjsnsC3it1V7vTEmf0wq
         SasjFZAi61c2kPG8OW+lJ0sw68XsCwpexi6VT8pgCH6nVHB7lyqiJ/Q1VYgO9upYl3gc
         8qD54PLsmzicK7K9lreFFRJybdpYqI/ty1mBkzBiHscQm/czUaIDEYWRfPlmRRZmHfqO
         /SRQOijf0ZGu+I0f4i05NJ9jcNfoYmXJ0Vt3yDTVQTpTu6Vf050uhmKei65vcozEf0qC
         OaeA==
X-Forwarded-Encrypted: i=1; AJvYcCWzDvT4zGICcsNj1doG45eDtJjQwFiuI4IevIRE0oPhwwAKSOwRtf4bPSpXqN8EztS7Bu2/W9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6D3foV0eonCwm6zXS7UtvxtPI/eWUMnpEsDnSpIheuJgUvUZ
	nIk09GYfQo9fyA/AJSj9LOTu2kIxRNkqyakArOIMr8K9a0bRC214jJo9dkr6Ze+/
X-Gm-Gg: ASbGnctHSXgVKegm7769se0fsMaPTwnA8Z3cxYUK7MusvyDfSKXGcCIyzLAYinoXmbm
	hZ4FEnoMkWfKbUokghLAJHJOp7UgddnzByFgxPArP7BZ4A2ruSjeV2QFMdAx1yPEw0nGUzDsx2W
	CMNKWQ4t9WL5JI+FKcjArVecW03VX6GZCymsap/QqhA31OPyRESwAue8FB7Xtl+dyvAPV2UySer
	tXnzLNzYTjkMGIDcyAJJ/bg3X/GD99bSI4t+bDEdqr1OyYYm44pm7kQub/zzzcp8FihCviQCoop
	jAr3yZEQPpfJplFf3on/VZbncr6CbB2gGVf6N10EGPEtqmDfE7AQ8HVEbzTzLM2+HSrM3wxNDoc
	fB0S0bzmvFQg5G1w=
X-Google-Smtp-Source: AGHT+IEaoyVceExJXOjzuC2BHoX56vBvj7QbEYJ6lQIdW8qF0L6JyTq0Ur0U/RFXs+o5EenRjsxzIg==
X-Received: by 2002:a05:600c:c1c8:10b0:45f:2e3e:a12a with SMTP id 5b1f17b1804b1-45f2e3ea28amr20859655e9.6.1758012408295;
        Tue, 16 Sep 2025 01:46:48 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f28c193f9sm132278015e9.2.2025.09.16.01.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:46:47 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:46:45 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: dsa: mv88e6xxx: rename TAI definitions
 according to core
Message-ID: <20250916084645.gy3zdejdsl54xoet@skbuf>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uN-00000005cF5-24Vd@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uy8uN-00000005cF5-24Vd@rmk-PC.armlinux.org.uk>

On Mon, Sep 15, 2025 at 02:06:15PM +0100, Russell King (Oracle) wrote:
> The TAI_EVENT_STATUS and TAI_CFG definitions are only used for the
> 88E6352-family of TAI implementations. Rename them as such, and
> remove the TAI_EVENT_TIME_* definitions that are unused (although
> we read them as a block.)
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
> index b3fd177d67e3..67deb2f0fddb 100644
> --- a/drivers/net/dsa/mv88e6xxx/ptp.h
> +++ b/drivers/net/dsa/mv88e6xxx/ptp.h
> @@ -16,19 +16,19 @@
>  #include "chip.h"
>  
>  /* Offset 0x00: TAI Global Config */
> -#define MV88E6XXX_TAI_CFG			0x00
> -#define MV88E6XXX_TAI_CFG_CAP_OVERWRITE		0x8000
> -#define MV88E6XXX_TAI_CFG_CAP_CTR_START		0x4000
> -#define MV88E6XXX_TAI_CFG_EVREQ_FALLING		0x2000
> -#define MV88E6XXX_TAI_CFG_TRIG_ACTIVE_LO	0x1000
> -#define MV88E6XXX_TAI_CFG_IRL_ENABLE		0x0400
> -#define MV88E6XXX_TAI_CFG_TRIG_IRQ_EN		0x0200
> -#define MV88E6XXX_TAI_CFG_EVREQ_IRQ_EN		0x0100
> -#define MV88E6XXX_TAI_CFG_TRIG_LOCK		0x0080
> -#define MV88E6XXX_TAI_CFG_BLOCK_UPDATE		0x0008
> -#define MV88E6XXX_TAI_CFG_MULTI_PTP		0x0004
> -#define MV88E6XXX_TAI_CFG_TRIG_MODE_ONESHOT	0x0002
> -#define MV88E6XXX_TAI_CFG_TRIG_ENABLE		0x0001
> +#define MV88E6352_TAI_CFG			0x00
> +#define MV88E6352_TAI_CFG_CAP_OVERWRITE		0x8000
> +#define MV88E6352_TAI_CFG_CAP_CTR_START		0x4000
> +#define MV88E6352_TAI_CFG_EVREQ_FALLING		0x2000
> +#define MV88E6352_TAI_CFG_TRIG_ACTIVE_LO	0x1000
> +#define MV88E6352_TAI_CFG_IRL_ENABLE		0x0400
> +#define MV88E6352_TAI_CFG_TRIG_IRQ_EN		0x0200
> +#define MV88E6352_TAI_CFG_EVREQ_IRQ_EN		0x0100
> +#define MV88E6352_TAI_CFG_TRIG_LOCK		0x0080
> +#define MV88E6352_TAI_CFG_BLOCK_UPDATE		0x0008
> +#define MV88E6352_TAI_CFG_MULTI_PTP		0x0004
> +#define MV88E6352_TAI_CFG_TRIG_MODE_ONESHOT	0x0002
> +#define MV88E6352_TAI_CFG_TRIG_ENABLE		0x0001
>  
>  /* Offset 0x01: Timestamp Clock Period (ps) */
>  #define MV88E6XXX_TAI_CLOCK_PERIOD		0x01
> @@ -53,18 +53,16 @@
>  #define MV88E6XXX_TAI_IRL_COMP_PS		0x08
>  
>  /* Offset 0x09: Event Status */
> -#define MV88E6XXX_TAI_EVENT_STATUS		0x09
> -#define MV88E6XXX_TAI_EVENT_STATUS_ERROR	0x0200
> -#define MV88E6XXX_TAI_EVENT_STATUS_VALID	0x0100
> -#define MV88E6XXX_TAI_EVENT_STATUS_CTR_MASK	0x00ff
> -
>  /* Offset 0x0A/0x0B: Event Time */

Was it intentional to keep the comment for a register with removed
definitions, and this placement for it? It looks like this (confusing
to me):

/* Offset 0x09: Event Status */
/* Offset 0x0A/0x0B: Event Time */
#define MV88E6352_TAI_EVENT_STATUS		0x09

> -#define MV88E6XXX_TAI_EVENT_TIME_LO		0x0a
> -#define MV88E6XXX_TAI_EVENT_TYPE_HI		0x0b
> +#define MV88E6352_TAI_EVENT_STATUS		0x09
> +#define MV88E6352_TAI_EVENT_STATUS_CAP_TRIG	0x4000
> +#define MV88E6352_TAI_EVENT_STATUS_ERROR	0x0200
> +#define MV88E6352_TAI_EVENT_STATUS_VALID	0x0100
> +#define MV88E6352_TAI_EVENT_STATUS_CTR_MASK	0x00ff
>  
>  /* Offset 0x0E/0x0F: PTP Global Time */
> -#define MV88E6XXX_TAI_TIME_LO			0x0e
> -#define MV88E6XXX_TAI_TIME_HI			0x0f
> +#define MV88E6352_TAI_TIME_LO			0x0e
> +#define MV88E6352_TAI_TIME_HI			0x0f
>  
>  /* Offset 0x10/0x11: Trig Generation Time */
>  #define MV88E6XXX_TAI_TRIG_TIME_LO		0x10
> @@ -101,8 +99,8 @@
>  #define MV88E6XXX_PTP_GC_INT_STATUS		0x08
>  
>  /* Offset 0x9/0xa: Global Time */
> -#define MV88E6XXX_PTP_GC_TIME_LO		0x09
> -#define MV88E6XXX_PTP_GC_TIME_HI		0x0A
> +#define MV88E6165_PTP_GC_TIME_LO		0x09
> +#define MV88E6165_PTP_GC_TIME_HI		0x0A
>  
>  /* 6165 Per Port Registers */
>  /* Offset 0: Arrival Time 0 Status */
> -- 
> 2.47.3
> 

