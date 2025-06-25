Return-Path: <netdev+bounces-201216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F893AE87F5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5899B7A9F79
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712E2DA747;
	Wed, 25 Jun 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phZvauNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB92BFC95
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865001; cv=none; b=KeGW62iwmClynpc4sIqoN4A3kvzmKP2EFeiW/r9uYQZFz+h59nbuuY/8rp5k7TUUrFE2wNl9msoVzRPwKGdSAQ+mmvZ/BL/ES9RNxy7nDAzj9/eL9xeerP4+JHWNivW2U8ERlIpeHWfBjUod8uCUmgB6ARG5EaKdcqSlUCYpeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865001; c=relaxed/simple;
	bh=DSRzUzp8qhgPH7MUNQzrHQgTuHndXvmTYHuEsVzN9Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whg1jc48HlXPev9vTOgFnVXsHk2HRgQcZtGfhVFWVUxLdd/XbjROysOp2hSVD0B45mgb0wgbBjRSAWrnDh5RB2HGyHSQoh97ZEO+qdYZuxsOrIH58V1Ag5kk341sR4bBdBlbdOskzEX+9ykWT21JLkwXnQwCtRGmmyxFqij851Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=phZvauNO; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ea35edc691so13739fac.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864999; x=1751469799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=huCCanBI7ZmsvlcriW/Fn5rLfvXVJGJaQC4tWaH7ZMA=;
        b=phZvauNO04MTMUO79RbNX8RIrWBFjpZ503FF2GUhSXDukALlOWz72v3o+rlBwGIs32
         JpR6cpOjNbRtvg5g7BhmgAKL3uAY+/+Of5xUcAeTZ9NP504F6gspiBt8YREjZCj9jUlv
         8QMaY+Hw/54weqpqVsMIoSP2WgyJGisOfKr6hY4a7zx9IQDjSkp94FzwpDe9OWW0/XI0
         TI4dVP8VPrux9Bqngd58w4YEuysaLlZOO8EOCZ6xR81hNjUsEsJ8RtQwXi+QzXIb8yzv
         N5p4reWV5mSZKOQfQNAnDIDl0DVjy0/wA4SHKTJf7ImIy5GPIRNdXbrk4qe13MVxm7uf
         8s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864999; x=1751469799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huCCanBI7ZmsvlcriW/Fn5rLfvXVJGJaQC4tWaH7ZMA=;
        b=aT9pw0zwzb14Ly1C28PZEBz3G0N7zQJRGAoytFERLVH7uJsZFThPQOGbDIEQnUMaNK
         YGO6fy+vtB5TApZ0HToXsfI3tprrvaACAQK4miFos18NgHgpcy8GQWOrq1cDux1QIHvu
         T4chUAZ2IlOhWJgAB7E4u5oaZ0ydCgi+Ozx7zeZxTT1bRJKSr7sSJ/08SdVXo4BBPYJ/
         Hs356KZ0TRhBdMGPIFXSAZfGMuUDSX+25WMM7SarUPTG5sYSzA1vFbqAD9Q1RenSv+uw
         IXhQ7KGd0WtvZOH029VM6yRZfCAxlkTO5buE5QYwywSKhEPJexQXa2VpMOf6Y6tnkgGv
         0FIw==
X-Forwarded-Encrypted: i=1; AJvYcCUZPSwDVh9SWT2EcudXu13wXFX/+a7qn0Kxqun1Lgd7UGcCxd5d1o+aglQ0imX+1y6CpatYmlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTD5AeJ/6AUMpjtnqtINz4eF0hIrYw96W9aI0x9ZCPaUp+8OcH
	ZyQvN8PU51Iv49fFXkLrthGJJYDvYE+AX4lKGRzzFff4vU/e/TG8aYQ7Chw8ue/8azA=
X-Gm-Gg: ASbGnctS4Y/9HLuVb0ibGnYup5NddTAW61wnQhmMsM3XwEbkgCWSBhKybP2g3kR16Xc
	w/mOye+RGnA4GvtOiYEY37nsNQRcbUn+u0qJOQtVN3T8afnxYTjZkOVxh+aptHReFZ9NZwSl7Vi
	Nm6F867qRjRGsiOteTV+tkR9LcV+VLuj7lHNUALGD2tDF+VzvByNKYFyealIx9qh2MbKtWiDP3L
	87CHoq9gJRotFrn3G0u3OXIYZl+tV8QBhYYigpCeDIE20f8eAsToGSqH4C90c8xkYECl/LRb8Bm
	uIEHA3gSVplcqKpQvljqrjFBf/BC+lkAcsWYIiUyY1DJgiouGDNoRK4OdDzcr4jdhERn9Q==
X-Google-Smtp-Source: AGHT+IGILtvj16sw+aAYNksoR2yGqMyl8eD11THJCF6/JdepHQm3lPKaEGaP1tZ9ZYLwsjt9w0zCSg==
X-Received: by 2002:a05:6870:80c6:b0:2db:a997:7a62 with SMTP id 586e51a60fabf-2efb21f4a35mr2283021fac.17.1750864999185;
        Wed, 25 Jun 2025 08:23:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90cc695asm2271674a34.68.2025.06.25.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:23:18 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:23:17 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
	netdev@vger.kernel.org, Wenjing Shan <wenjing.shan@samsung.com>
Subject: Re: [PATCH 1/2] net/mdiobus: Fix potential out-of-bounds read/write
 access
Message-ID: <0d51f36d-eee3-4455-a886-d6a979e8e891@sabinyo.mountain>
References: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
 <CGME20250609153151eucas1p12def205b1e442c456d043ab444418a56@eucas1p1.samsung.com>
 <20250609153147.1435432-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609153147.1435432-1-j.raczynski@samsung.com>

On Mon, Jun 09, 2025 at 05:31:46PM +0200, Jakub Raczynski wrote:
> When using publicly available tools like 'mdio-tools' to read/write data
> from/to network interface and its PHY via mdiobus, there is no verification of
> parameters passed to the ioctl and it accepts any mdio address.
> Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
> but it is possible to pass higher value than that via ioctl.
> While read/write operation should generally fail in this case,
> mdiobus provides stats array, where wrong address may allow out-of-bounds
> read/write.
> 
> Fix that by adding address verification before read/write operation.
> While this excludes this access from any statistics, it improves security of
> read/write operation.
> 
> Fixes: 080bb352fad00 ("net: phy: Maintain MDIO device and bus statistics")
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
> ---
>  drivers/net/phy/mdio_bus.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index a6bcb0fee863..60fd0cd7cb9c 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -445,6 +445,9 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
>  
>  	lockdep_assert_held_once(&bus->mdio_lock);
>  
> +	if (addr >= PHY_MAX_ADDR)
> +		return -ENXIO;

addr is an int so Smatch wants this to be:

	if (addr < 0 || addr >= PHY_MAX_ADDR)
		return return -ENXIO;

I think that although addr is an int, the actual values are limited to
0-U16_MAX?

regards,
dan carpener


