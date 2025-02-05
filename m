Return-Path: <netdev+bounces-162869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A456A2839B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A14165BDD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 05:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21547215072;
	Wed,  5 Feb 2025 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLjtJx3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12B2770B;
	Wed,  5 Feb 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732945; cv=none; b=qnls9MsvsP1sLX6BLmfVJl38DOwy81OvTm3nF0gGAXoG299TyfRqPaiV/3RjdmBSGbP6gy/5Kq1PhuxcNcXvA6Wj4Uj1qRyOj05eg+WgfhX0UN1st7mFqbn8PYoRbeaUY6MUJ3r6Y/5uk9QtqHSgtGHs6gzRyLmlCRtbzbjmHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732945; c=relaxed/simple;
	bh=teAmRA/glxpd4DiIqY2xWP0ql5pxdUqg7CzHOFSUFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPK9oIQNCkcJO5TuVcYIWjqIpRLJzZ0NiDy1MYb9N0U7YxAo5WnaTzn/VTr2xMmrPsJZ4RlYvWnPfpKKWuYjSQOC6zXfeNu+Ovq6kzXhPOoxUQd+9cfJHH8HJrNFjoZlbuOCLOOzWuLekHrUYmviHUrOJMO5v+/B90oi176jLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLjtJx3c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so72889315e9.0;
        Tue, 04 Feb 2025 21:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738732941; x=1739337741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21hP7bpdvokUxQxofV+KNEVpID3xm7+fvYQNUaPIP6I=;
        b=eLjtJx3c1JM9P3wPGj7x78Afnegjr4uQm6gJEPoG4pP8NyqkAeyAjbsizpmVfnyElJ
         kupFLvAM42HGkIb49+P+GEKvM/ktAC+FJ2G8qw0vnTP5r1joq356aPL9Eq1plOGeoKYx
         3WYEajYJei/cXMSF7xt/qI5gTUk3hoQl0jkbe95lQlq2KTHq47bB43U0m9v7rQ3rnxl6
         lFbTE8irU7f7P03gJHawbqsoO5xocqciHYjqTE1yvATcLaba/qIS0hHDyEBhHz380/QR
         UCOMFYbci8zWPRMU90tGL7ft11K+SeNn6M5jrTrSH4WwDpsuTIUI+fHbvGsMuB6JIkVF
         SK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738732941; x=1739337741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21hP7bpdvokUxQxofV+KNEVpID3xm7+fvYQNUaPIP6I=;
        b=sX36P8DhivzqxaocU7Wtx6gw//w2tA6BX5rMPK6bHC/8XGKGBHciSxj841KOrHfdTu
         xUPAthTT7KCj55nfESTSj9nraNzX7ydPm0vqzwmc4cktZ5o20b7jsmH+lOySxz2/RK4d
         jXv9byes2MGbh3jk3mItmEK8wQhhcvZHn3oDfqKxUSZjXRhYbjH8qJzkprDQUH1FvBWR
         zpTy9FHDrLG4N8m1r8X/G/o1hSoiZRI/nZR07f66VoFjoM4nKNG0O3dSsS3SY32lA0Wl
         InG86An7BRO7SnJsXiTTbMwQVKmtwjs1xDvWUCvLi+uZAD6FJc6bVMhf5wTskG/nik4u
         7gWA==
X-Forwarded-Encrypted: i=1; AJvYcCWagE/VGv3FNmmn0QikqdmaTNTKQKQT47OAfcOfqZYNeBqpLzWjj7cLw3/go2luLeEzzP0nvqDnp/Hb@vger.kernel.org, AJvYcCXcoMVg/tnkab3logrMExDhyyfh54pumRZcqKoyZNnJnua5s6r8l27Oh6bQeXZDlpEQbk4GHsJE4AMsDGqh@vger.kernel.org, AJvYcCXlAJ8yMa6e6Sk2zWh2g4KEHLHXoiImfIo8ymEMP4AHiT8JgCI3ne1GXxKEhOsS1htZd84O7fIK@vger.kernel.org
X-Gm-Message-State: AOJu0YyPX6n3ohohgp0ZwitDvW2+4EnnlHp5oowFnfXcxo9ZQFnVO9H3
	DRxmNF7RM5LkhQ8qCL/Ks3QFw9gUCl0LhDLGhHwlOyExWCqKN9Ov
X-Gm-Gg: ASbGncupk/UXcf8W+9n2nSRFyH2dNGSzoXQ+RO08oW2WJfdXU8+tPH6tO55FCzNvJVi
	/pHwgIM2eiWrdOHZ/MR6bxB39SVlH69kTa1OQJmYWf/H3n2/h6ZJwMI3oa2/j6HjtDMpPTLUtSg
	x9bUogYRWHQCJSi0M9ql9Z2PvIQ3Qdj5l7KWzIk0dvVfzUaWsAjL6xrL+EcpWlE8amzc+I9vc2R
	vhm6LI+Umm3XpupcTFz8fLun2PQjpEVeURfCB5XrhODJIVg5Cm2pC679/UEwOfPGS0y50OdaA4l
	eNUx1V+rDiUV
X-Google-Smtp-Source: AGHT+IHj+FMgfhyJJ0oFoOUI5MqNe+dA1CICeYNUtW99AhsoLmOYnMg9M/knYT0ZemyuxGW8Rnlntw==
X-Received: by 2002:a05:600c:3b98:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-4390d574e18mr8415565e9.30.1738732941277;
        Tue, 04 Feb 2025 21:22:21 -0800 (PST)
Received: from debian ([2a00:79c0:661:ad00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d965438sm9366515e9.22.2025.02.04.21.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:22:20 -0800 (PST)
Date: Wed, 5 Feb 2025 06:22:18 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <20250205052218.GC3831@debian>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-2-9798e96500d9@liebherr.com>
 <Z6JUbW72_CqCY9Zq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6JUbW72_CqCY9Zq@shell.armlinux.org.uk>

Am Tue, Feb 04, 2025 at 05:54:53PM +0000 schrieb Russell King (Oracle):
> On Tue, Feb 04, 2025 at 02:09:16PM +0100, Dimitri Fedrau via B4 Relay wrote:
> >  #if IS_ENABLED(CONFIG_OF_MDIO)
> > -static int phy_get_int_delay_property(struct device *dev, const char *name)
> > +static int phy_get_u32_property(struct device *dev, const char *name)
> >  {
> >  	s32 int_delay;
> >  	int ret;
> > @@ -3108,7 +3108,7 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
> >  	return int_delay;
> 
> Hmm. You're changing the name of this function from "int" to "u32", yet
> it still returns "int".
>

I just wanted to reuse code for retrieving the u32, I found
phy_get_int_delay_property and renamed it. But the renaming from "int"
to "u32" is wrong as you outlined.

> What range of values are you expecting to be returned by this function?
> If it's the full range of u32 values, then that overlaps with the error
> range returned by device_property_read_u32().
>

Values are in percent, u8 would already be enough, so it wouldn't
overlap with the error range.

> I'm wondering whether it would be better to follow the example set by
> these device_* functions, and pass a pointer for the value to them, and
> just have the return value indicating success/failure.
>

I would prefer this, but this would mean changes in phy_get_internal_delay
if we don't want to duplicate code, as phy_get_internal_delay relies on
phy_get_int_delay_property and we change function parameters of
phy_get_int_delay_property as you described. I would switch from
static int phy_get_int_delay_property(struct device *dev, const char *name)
to
static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)

Do you agree ?

Best regards,
Dimitri Fedrau

