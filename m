Return-Path: <netdev+bounces-177753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86308A71943
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F517A2736
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C41EEA36;
	Wed, 26 Mar 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkytLo7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994111DEFD7;
	Wed, 26 Mar 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000456; cv=none; b=ra7MmSRgXtYyMK06pmAsKEznEeDrqVMD32RKbQQ1rB1hVTavMxICrTdsQU1Cgwdvmj7B6RScjJcK8AV7SXeF4q9QWo5iYNpI2fp6ZhMvy1rxTat13Je84lZX/20rqAvAmgCfGYOxrFPEQN+rMsaDqQEp2V5vmRnRtIRCtSwnKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000456; c=relaxed/simple;
	bh=nQHwaxjR8CO0tgJWL7PgM7ZESLA6hMbTYzDTbj02txM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRj9UzPmCOBFucOxdxuVtcUAO1vnw09UijUWVst+GeDnwyWiLOPPILEtLGbRu58QFH3PQUBkA9DdCeSX0jbDPREiB9EZGV12BroYWmXQF6NID3m3C81CTTL74SKotvwtjYyv1JnpLj8BuJ7JnWPvuh7W8QlTh4Q27AsEO3hXTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkytLo7f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso68331585e9.0;
        Wed, 26 Mar 2025 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743000453; x=1743605253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39ME7p5eLaR1hcfbNt4XmwgZF3ncfkWZ8Hrmuut2Ejo=;
        b=GkytLo7fVA19PPWH1XJcGJWaNmY0ENSwqSOlQYnJk+PFdfAlU0wqmzJVwNO/u5Exdm
         8IHWERYtnQqB6jM8gtv4EcaQz8aH7MuDeja7KlxuPCjCa2N8Ucu01vP7v8jhq9dmo92V
         wVhgwy667DWtx4z9zQN1Non1Uf4Hc3kIuwuVFPi82gsUuQwPxrodSXynZjnoPzBao1O5
         VZ4CImBRiUsYaIy3u2RbgtF6RbNHCQqSXbymBZQhj56+p//1qNpT/EfSGQwwok5gX3vT
         I3kGDk1ZelWVnuEjZwiDnaI3tYNpLwxa9UMFQyyo02EK4RzpaQU0EkOsUwE5oX2E0AmV
         P80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000453; x=1743605253;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39ME7p5eLaR1hcfbNt4XmwgZF3ncfkWZ8Hrmuut2Ejo=;
        b=TwsdB9BsJLM3H/4kbQaOr8Na1oBph2I7YWSPthU4thuLbi2FbXm6pKn3Y4A2L1wPtl
         ITxMK3YXqnSa0JdJ53rM9z7kbwF4bTRWKsh7cP1qBantGLnMDTW9Z/Kz88ZSqh7PclCr
         Mt2QaYfXLnrWsUH/NcozAN1+WoAHoAEzo3YVxix3bdaus3ZhvmuWgrqxaZ8rHdmKi5Oi
         /lZNJutiXNs8bKhHp/Z+PWG0pBZrh/6tMkaOh/+1qV/T7BZkhBqVFrjmO4fAtRxhmLt1
         cyGhqULPogFWDsZs5mlu2NyMRwC6rb9YF+G9pBnGz+k3NbgGVymgGq599OpOy1L++7cv
         XkAg==
X-Forwarded-Encrypted: i=1; AJvYcCU5VZD2+u1nKuBFJN5e93veSF3cT8HUE2YkGcTysWSHoPXZDBW1HnuojCfBqj1g38DdCrIytIIzp8A2@vger.kernel.org, AJvYcCUQp7I/vTuCJu6RBtkOz24j1OGuE8/9901GjaRdRE7XcBms/+MsRTcbAJ/Y6w64FVe57/21xmHBmKumFMdr@vger.kernel.org, AJvYcCUZQWWOLNHRf7SicsWNGZBFxqVQ57ggRZrsrAJVvqZbASjjui+GiYa4dN6a8pqQeU7o4cff16vS@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXqOEPE6sf3FubgfHIsQ5DtfHejhhnpP3lIqQP93vJ4NP1UyX
	jwxZPW7yXqstfKCPJ47ivonDxhrf5W2BDkBhBbU5YP5GJup20jbI
X-Gm-Gg: ASbGncu0KZaQvgYExGKrNnIawTm0P8pcqpspQSyqp3O02/ZxzCVqjPA43P9spH3SFeI
	HOgasQwJtqkbsz6t0JIy4WDNf+OyOL+F/jLtrK91c2KHXZl4VgPKMXzJumJ8zWqTetA5R5Ulwrb
	Vo41wPe/sgFBO671I6ddDWg3HYR4YacZP3HzzAhF1BCurqyC0g11rzIaXovyINWGcD8I5s0wBIv
	SQSrdiV9WyQRR5h5LN7h/T8mi29ffldls7snwW8zxQkUlfiedGOLnMCP4y1V3h+eApU5Kq/mzJA
	BODMHN//+oP66l9ZMwTRxxXj7DMnBcEugoPAqw2eHq/v+JY5AIsP+wcehQSMl8RYNTCjw4Ijhf9
	9
X-Google-Smtp-Source: AGHT+IEkprDARHohL99BkF+vUUKFTW3i4+MC+nQyhd1smUBMoa+9+btab3iJ8OvGIU508Uhu9eNAYg==
X-Received: by 2002:a05:600c:1d02:b0:43d:77c5:9c09 with SMTP id 5b1f17b1804b1-43d77c5a08bmr37312175e9.24.1743000452479;
        Wed, 26 Mar 2025 07:47:32 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b4ce9sm17218000f8f.53.2025.03.26.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:47:32 -0700 (PDT)
Message-ID: <67e41384.5d0a0220.e4975.e9c3@mx.google.com>
X-Google-Original-Message-ID: <Z-QTgbrYFES4bT6N@Ansuel-XPS.>
Date: Wed, 26 Mar 2025 15:47:29 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>
 <a3cddcf4-bdcc-49f4-9d72-309854895c7c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cddcf4-bdcc-49f4-9d72-309854895c7c@lunn.ch>

On Wed, Mar 26, 2025 at 02:57:09PM +0100, Andrew Lunn wrote:
> > In summary, I really don't like this approach - it feels too much of a
> > hack, _and_ introduces the potential for drivers that makes use of this
> > to get stuff really very wrong. In my opinion that's not a model that
> > we should add to the kernel.
> 
> I agree.
> 
> > 
> > I'll say again - why can't the PHY firmware be loaded by board firmware.
> > You've been silent on my feedback on this point. Given that you're
> > ignoring me... for this patch series...
> 
> And i still think using the match op is something that should be
> investigated, alongside the bootloader loading firmware.
>

The main problem (as said in the other answer) is that I feel match op
won't solve the problem and doesn't seems the good place to do complex
operation like OF and load firmware.

But now that I think about it your idea was to define a match_phy_device
for each PHY ID... The generic PHY ID is detected and firmware is loaded
and the PHY ID is checked again?

That way any other call of match_phy_device for other PHY of the same
family will found the FW loaded and check the ID?

That might work but sound more like a trick than a solid implementation.

-- 
	Ansuel

