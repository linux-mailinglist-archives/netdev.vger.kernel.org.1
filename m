Return-Path: <netdev+bounces-243291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F25C9C96E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 601E6346F61
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7A92D0611;
	Tue,  2 Dec 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU/W9I2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EC2BDC27
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699525; cv=none; b=pMS5D6lyAImHRMN38zZ6a5XASHfls96F+fX78OpL7MzA798vi3W0V2GW5U+CzcryvppdETzhg01hIzdVKLmuDE+q2dNrh/mLJiUfaCMxfX5ksZw9uCY8BNYATbXFFwuF9Uc1RTP7cNSyYM4IYPsG9J4Y69gutQt2+MQhnow827o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699525; c=relaxed/simple;
	bh=tzmtCptD7yAtacgQMx8Kaqwh1eETLR40s0EYMNAoub8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWtyh6MQimRaBrRrAS1fYEyDhlM28Csqkt2Wi2cMwLe6f2868AtcpFksoEd5C38KFiuL14fBTY/cm/8LvxLULnoJXRMokXlrHyN4tr2J5DF/7maZ9fPQpoM5uqylvLex2r3eip6t9cCruzWsbf7MPWbkaQKHzW33rfrQ48VtoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU/W9I2C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso702515e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764699521; x=1765304321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMaGaxh0YRUd9QK48pCWqjlS6PxlgAD8GrQ1+JyqkxA=;
        b=QU/W9I2Czbb7kqUEJ5YG0CXEMRA8Xx1l9cECbQDVB2htLmhpEKCg5YlJ4w0KA2yCDc
         k+MOxFX2AO3qglnLmxyykFvtgKkXiXB718eVlf89bLNuA02NDsJ6db5pr5tC/20Y+Vt9
         945QrCtDcejweCtMLra9oG1Kb89N1y2+6AFBh8Y85OZlBrteK/rD2A+YBc+Kr4i3jZll
         kNFeOpjbSG7bq72ELcDBf4xkv3UOw05nmh3zTCdfMHNxL/au5vx9XGRe44xksZftQbx1
         B5bKFHIbR7gYZZfy1aY6C3e1yvtNJ0PQ7edD6DjDGe+Cxd9ss4oWTwJYoRgxZl+ljMFj
         2+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764699521; x=1765304321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMaGaxh0YRUd9QK48pCWqjlS6PxlgAD8GrQ1+JyqkxA=;
        b=BxyyjmNTAd7P6nKO0nvLvcuW6HQJv0nrnmAvYs01WFXFwWeSTbKuJbJ2/G5XLfw3f5
         jjw+NTFuhaZy8leNaCCe+/XcCAP9wCDGMaid2WAKtpko072+25RrTUWqUHegCBNjTo6z
         jClC52DVfwqSMkYSbWbkxYMFdAAAQnRrWNyCnZwCJqvnkxGQpKsz6aoUCIaXLxAnmnbW
         RRuR9PwgOIIqptJmzeb++Vf0kecRvMz8XgvXwAs/HXCYbXJruNpaZu31zkJSEOwCNtzE
         Wi3AItGJntUhPV60E7NJgxzJoQhpnxsexZ2WWlCbCjlmvAEEAADHK8fEDGp39sTKAPlZ
         FY3A==
X-Forwarded-Encrypted: i=1; AJvYcCWb5NYWaT1u4j9k3HziEwDWSEda/PmkVSZJ1FxHKEBLd9nS4NcZ8h1quCXJk3Bx6BEOWUKJqQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/iKlrGGNp5fW4vFp40k3hBAi3XEj6AHBrNShvse/3h13VSgd
	4saNEzVE4mrYj8BKYZKBgtJ+HOvMeP0YbDKAhcA0r4fYV8662h0GiXnd
X-Gm-Gg: ASbGncvcN45PTlwWsVQX/9rZ6USC0HK8sWxCRv0s6EDdkpazSMJ5QYPc1DewRvfhp6S
	2ozt0QE6eiE+juPxbH+SZqd4fKDQZlBFE6DvB0/ZuI+caWjmro+1wT/j1RigMuK9ze8WuhLyRjD
	F8/EBwu3fmBONma2bTpeCQtf5+hT2l0fkgv2valaKAQva1uq/FQpVEU5W1SwsfJePfwhr/91rjn
	G+RBqOfrKlQWKhHSpUoKKwWsoi14QYmhIni2coCavk6qd08tAz0X2LDwHczWva5gmTYQb/wshN4
	kPXjWJp9xubR9pMcQXcS7pRXRzeOcRYBLoI2ShpFnY6LpnCf47F+3VG21fZ3iWNYgaRfRjTjvkC
	c/ENnoBSmYUzjdowvBgwY7TZfUICQIVZx9nOeB9MLQGNwWzn189iEDc/vxrEi1+9ROWq3cfTurj
	symmu6ZWT+
X-Google-Smtp-Source: AGHT+IFpqsraLWCCHwhEXFKi4e3WsR3FPFZwmAKdbIMf3+2pgCt4nyGOLKosPrFEDzC4HROyjCVXIA==
X-Received: by 2002:a05:600c:5614:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-47926fdf387mr26345085e9.17.1764699520620;
        Tue, 02 Dec 2025 10:18:40 -0800 (PST)
Received: from legfed1 ([2a00:79c0:6fc:d500:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a79ec06sm3224615e9.5.2025.12.02.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 10:18:40 -0800 (PST)
Date: Tue, 2 Dec 2025 19:18:38 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell-88q2xxx: Fix clamped value in
 mv88q2xxx_hwmon_write
Message-ID: <20251202181838.GA3355779@legfed1>
References: <20251202172743.453055-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202172743.453055-3-thorsten.blum@linux.dev>

Hi Thorsten,

thanks for the fix.

Reviewed-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Am Tue, Dec 02, 2025 at 06:27:44PM +0100 schrieb Thorsten Blum:
> The local variable 'val' was never clamped to -75000 or 180000 because
> the return value of clamp_val() was not used. Fix this by assigning the
> clamped value back to 'val', and use clamp() instead of clamp_val().
> 
> Cc: stable@vger.kernel.org
> Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index f3d83b04c953..201dee1a1698 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -698,7 +698,7 @@ static int mv88q2xxx_hwmon_write(struct device *dev,
>  
>  	switch (attr) {
>  	case hwmon_temp_max:
> -		clamp_val(val, -75000, 180000);
> +		val = clamp(val, -75000, 180000);
>  		val = (val / 1000) + 75;
>  		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
>  				 val);
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
> 

