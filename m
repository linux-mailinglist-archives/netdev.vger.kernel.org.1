Return-Path: <netdev+bounces-157757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED0DA0B940
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E1A167481
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B52327AE;
	Mon, 13 Jan 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEuBWui8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974761CAA6A;
	Mon, 13 Jan 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777915; cv=none; b=AoABY95a7u4M5UdgsIKTXo6OHZeL3M1RfKR1zDScvMRYNNKEn4q9fcI+Hs/wEHBjPRO6O+9/nLyiKM+pVaRzBYaocQfL3cYox20KlNF3zMIGYEtU+sr5zsGRK85/P5VdrPm+dSfkKuZyieyH00vwJU+/jvfcya4TuQJ4uW3guG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777915; c=relaxed/simple;
	bh=7YimBG3LQ3J6ndU/hvJ1ZvNEDHgvt22mDIjip1m80mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxcmOe7zjItsbxrrWzCrAhgkkuWGV+tocTvlh2s0dSoS6/JQq23zsMJpwpbRPe7NGOO0dmi4kZq+bZdywsmuxs/mAZRkkxdxSWZi81yRYdYhq+a8rQ8Ln4SAAieFNgmX9vvZJ7Zs7MhrsI3zEhjShUOh9BhzWgyNXNW8liC0Mzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEuBWui8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso31144865e9.2;
        Mon, 13 Jan 2025 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736777912; x=1737382712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2es6yriLWnAabX2QUZDG1SzGg71ZT0n2Mtutr6FZ6g=;
        b=UEuBWui8GTlEkaUHq+vd64sFZtIPNvwwSorOGuHejuZACqYfbQ2eXa6cad9YpBHnzX
         ZMFHLzRbLt0lrYKiappEdEYb/djVC5vGULhHIXhCzaRLzLtSYep6qTdXHBB/c20gKLi+
         srw/2t3ylm+w5KjCGQ5ECuLZdyoNvaeNyhMmO547cYvZCZvXxoWd60140QvTIjwZevs5
         U0aoC1AK9m+hdBmWqr3MgtShDr5o/K3c7wVuimEsYNKKreNiFRbf03l3kyox7Ux2I9zz
         hJqQAqXesXPFxyK6ridKa0ldtJxOzoxxbYt4KlT7FtssZN+YBeuRsInPrt+8qJAKuv8p
         vHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777912; x=1737382712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2es6yriLWnAabX2QUZDG1SzGg71ZT0n2Mtutr6FZ6g=;
        b=ZGSavs+aVY2YG0e8F7f7szNCjEIuA1aC+Jth7J4vEvdHVJefCPIo/VwWDsFD365JPm
         7mCeV/sz55s9+tp772mJjeLD91uzNvSfT/PuXPqzQB5iLhbGag6r1i7Sf/hL3oZtlShK
         q5nXhnwF854J36PZXmpV32RtcvUxvwpd0N+bT4fV7KvPwjXbmNLrBl/d3n4H10aFHJ4l
         E0rzzwtE7FxNpTAFLGzuKIsRxjq2dY/176whTYL7w5KcvoiOsvH8i38BoaCTx96fYcs2
         YHU5Ah05nBh0k6k4pHAsZzQNEhqQ2s4pBS7sACUUV22PO8KTePbWO7Rn5pAp5EqG4vlo
         2yaw==
X-Forwarded-Encrypted: i=1; AJvYcCUdZrC/o5CkFltz1pvty6boYj9bahMbIMg/UrSw4Bcg9Mxyxm6WRl4kCppJQYWryNDjq8SLzxzTOFvf@vger.kernel.org, AJvYcCWxlyOxUiccL/kwn6FBRGXpKwSOpVwIVurShJ+jZDvlIP0xQqR2HwLsUSO2ezxozeQ44cLlBBWhX667VXOk@vger.kernel.org, AJvYcCX5ow73aWgFEnBFCJbK1LgbXxkUoRnD4dQNhyRf13jIbWpI8TatZ6t1nY+vP8v25H72e30CR5GZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tXpTmJaDP9Sqb8QsLb7fDrV56UdJMLGJSWVuh6tqE8g+S6Z3
	7uM5YmcaeHHUXUvhVlkCHi6u3k+5xUhYn0B2e1ItzRvqqV/5o5gM
X-Gm-Gg: ASbGncshbQQamNjj+T6RhEPJkTgmS+yNiWKmrsD3WUBd3G/8nV3yAc6DePjSaSjrMi4
	GVthSOLUDP1DtxwroXtSdsYP+6GufYErqJc3G7RRep/il7067UfzTu84woobddu8MHFuTQS9vdQ
	HucUuofQdXtoT3miT/xYBDdEyV1bLo9sOy7dncW4mFgv6wj5oSjcUOrJldREdrOzTO/UQn2dNCd
	iAeMKFFmHs41dV6PrNep17ohA4Wu3/GaggBJekibhvc2YOcS6Gd
X-Google-Smtp-Source: AGHT+IG04VKJi+ixrAU4Wm0abXxVfnfxurgCJ8NE/rCLyxx5AgLs1/IbR4L9IAmuCdNEQSKmle4V1g==
X-Received: by 2002:a05:600c:5486:b0:434:f131:1e64 with SMTP id 5b1f17b1804b1-436e2696d1fmr188716265e9.9.1736777911548;
        Mon, 13 Jan 2025 06:18:31 -0800 (PST)
Received: from debian ([2a00:79c0:620:b000:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da7768sm182271275e9.5.2025.01.13.06.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:18:31 -0800 (PST)
Date: Mon, 13 Jan 2025 15:18:28 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <20250113141828.GA4250@debian>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
 <fcffef06-c8d1-4398-bc20-30d252cd2fd2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcffef06-c8d1-4398-bc20-30d252cd2fd2@lunn.ch>

Hi Andrew,

Am Mon, Jan 13, 2025 at 02:54:28PM +0100 schrieb Andrew Lunn:
> On Mon, Jan 13, 2025 at 06:40:11AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> > Add support for configuration via DT.
> 
> The commit message is supposed to answer the question "Why?". Isn't
> reducing the voltage going to make the device non conforming? Why
> would i want to break it? I could understand setting it a bit higher
> than required to handle losses on the PCB and connector, so the
> voltages measured on the RJ45 pins are conforming.
>
- Will add the "Why?" to the commit description. You already answered it.
- Yes you are right.
- I don't want to break it, the PHY just provides these settings. And I
  just wanted to reflect this in the code, although it probably doesn't
  make sense.
- In my case I want to set it a bit higher to be conforming.

> Also, what makes the dp8382 special? I know other PHYs can actually do
> this. So why are we adding some vendor specific property just for
> 100base-tx?
>
I don't think that the dp83822 is special in this case. I just didn't
know better. Would be removing the vendor specific property enough ?
Or is there already a defined property describing this. Didn't found
anything.

Best regards,
Dimitri

