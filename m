Return-Path: <netdev+bounces-167629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CFBA3B1A8
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B51704A3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB481BC094;
	Wed, 19 Feb 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biPcFKdN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54919D882;
	Wed, 19 Feb 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946596; cv=none; b=j/2QIRB0CYqettOsgGDrRcKlshGOZGmL8XbRM2ovOrKtQFJfhxSPs00A3XZ3oyq4IODLscLfqvRYPjkVbK7UuIJu7YYb4hwqcUWhik+g95ILQGqRQjeLkL0sbeOz+AgM2HLMn5W/GTzzyYQMpTJa2cp53G/4w/JciOHdEZM+fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946596; c=relaxed/simple;
	bh=ntuzchG/Hr2F2xWpq8JLrj2rfkLYJzfr6yeptdeGGaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCjqZrtYhyUYqdAeKum9UC2CCWruRCVMHoQTzjiw7pHvqKdT0dRbM9zhRTgsLJ1n7lVzo+5CO8EiAKtilVWSjoJhowFHs4TXLfPRK2qDPcScHFtlmv13+dqorF9QYZ0sZhMLF3V2WlaxPll3/YK/1R83EqGcaVvByxHj95jJbH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biPcFKdN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e07897bf66so2211815a12.1;
        Tue, 18 Feb 2025 22:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739946593; x=1740551393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsYOUZ7VYupgVMZLbTSsAmR2ItYD4Xskvl4pNm91OZw=;
        b=biPcFKdNhl6xzbJD7XDr1EWUOdzM3H0118HgGo3UU3pgmQKAzXGPKpjVKzAJYrzwvl
         GCvwsrZoDDpm4eVyE6ddPmHHiNTk0Cgy9SV2EavpR0I8NB1f3QsIH3CqDka22I2OGCiz
         ZON9f9kR9aTMAsNmjeklsr3W1ChxkKeTc1BpO1IXZ3/Lc9RfRePMUREOfKf/yRkFZo3Q
         f668wzMeTHhXZVFpQwqrpZH9KB8r0FCgbhsoNRZM6ex2QfHKb7PfJ/hfgNw0LtBgK0SQ
         muHwuf+niXOB12PdZpiErVC2kfAAVRx323p7ehubl6uHAVK5j7eTq8GMn1ZQRviSLfzG
         g5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739946593; x=1740551393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsYOUZ7VYupgVMZLbTSsAmR2ItYD4Xskvl4pNm91OZw=;
        b=is3GGGDvF0/ILTt0/9pnthdcVXheevc6U9ZQGpPlNyMozG/5YP+sOi+OdNQTtJNzw2
         DxWkv6rgQI4GeEwvrUhrQd4W1lIorZqdeAC5k/B6FupyGi1zayWoMGGzS/0FNGvn1Hyq
         NTCepyiLW6wBOltEsjjDgFB/WP8M+45qbVzs3sHcrAWzazxrh+YU9Vd4t6ajinXolG8u
         /neDwh3CFJjXxf2wlBo69osxta28UzdBojCNLOLt6A8IiKsCpi/MLNYxMiGOy6mD3vvD
         yuB5/glJTPwupCxEaij0SHv3lZLb7+WZI2r+kv9ZvPPn7u1dsSnMbmmo6SsmvvQVLTSg
         y11A==
X-Forwarded-Encrypted: i=1; AJvYcCVg/mOfGPs+7JwjYHEJsPalCuWCEQKe8QdDkZ71DAwwMUqnr4krTtAzDaNa/Z0Zo4NMK6noR6txAM90ik0=@vger.kernel.org, AJvYcCWFtZjHYBMaya9vaY9UoxPnM0+N5QpfAmDEr5m2tw5Z78ZxsrMehIWge7o4YscZ+tvceRToViUi@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUaJVbASwjwYRcuB8Mg+qvdxa58gOpZT8CRi17o9ZI+O9G55D
	gZk/RngW9FxXfF9sicUvGngTFMsKtH2+TEuVp6wIbys3wIdbmPHW
X-Gm-Gg: ASbGncv/ZMCRZoykf2SrlC2YVzbx0OMsWDSYbCBCdGSUAsOmtoMEuX1pRMfe3imiY9t
	UVqnP+KKRlusFCvpAmh+5l7IAwBVH/Ish4naqyrti1uQSJ5Zn7j5wtqD3v0VZm2px6MYMl7k+rS
	6zJq477N5pdcqdcoNkMZOAS8ZQu1PXm/HeaqaUWef4GW1w3sueGr/jh2JDSswmRmOBOzquvwDgB
	Ec+lJwcLBKdUy83au3AM/TS9G/r6Lrt8sRm9CIveAhmTPjq3+LaK/bviChKy3HCkpT4nEhlqNw9
	8sNO0cUlsdSPHusJbw==
X-Google-Smtp-Source: AGHT+IGOt3QdVNqmR43n5+SSYVvm+kyR/aEwq+963NHUY2Gh64BTHOatJCKH5JYo/7Ox1YQGL0wM1Q==
X-Received: by 2002:a05:6402:a00e:b0:5d0:e563:4475 with SMTP id 4fb4d7f45d1cf-5e089d1d1dfmr1877391a12.29.1739946592541;
        Tue, 18 Feb 2025 22:29:52 -0800 (PST)
Received: from eichest-laptop ([178.197.206.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c418bsm10169699a12.24.2025.02.18.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 22:29:52 -0800 (PST)
Date: Wed, 19 Feb 2025 07:29:49 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: marvell-88q2xxx: Prevent reading
 temperature with asserted reset
Message-ID: <Z7V6XZ7VRTkYNi2G@eichest-laptop>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-2-999a304c8a11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-2-999a304c8a11@gmail.com>

Hi Dimitri,

On Tue, Feb 18, 2025 at 07:33:10PM +0100, Dimitri Fedrau wrote:
> If the PHYs reset is asserted it returns 0xffff for any read operation.
> Prevent reading the temperature in this case and return with an I/O error.
> Write operations are ignored by the device.
> 
> Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 30d71bfc365597d77c34c48f05390db9d63c4af4..c1ae27057ee34feacb31c2e3c40b2b1769596408 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -647,6 +647,12 @@ static int mv88q2xxx_hwmon_read(struct device *dev,
>  	struct phy_device *phydev = dev_get_drvdata(dev);
>  	int ret;
>  
> +	/* If the PHYs reset is asserted it returns 0xffff for any read
> +	 * operation. Return with an I/O error in this case.
> +	 */
> +	if (phydev->mdio.reset_state == 1)
> +		return -EIO;
> +
>  	switch (attr) {
>  	case hwmon_temp_input:
>  		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> 

It makes sense to me. However, aren't most phys that allow reading
sensors over MDIO affected by this issue? I couldn't find anything
similar, are they ignoring that use-case?

Regards,
Stefan

