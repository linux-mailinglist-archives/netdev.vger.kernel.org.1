Return-Path: <netdev+bounces-223548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C46B597B5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D31188CD5D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C62E11BC;
	Tue, 16 Sep 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr+ImlSK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90752D949A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029564; cv=none; b=G78wAN8yxJlye4zyCOIw6ZKLTJDzHUHjtRzWCb+pOkuiZMUE0lMbsvEvQyFp/wD1O5FVzbiQGPRaAJ7V0J4qqDqxdzRq8yaIEfKoIcHB6lq8xm+ZCib2x2Ytv3emKFuwSAkXlsjF4dpBF1R8MNgjCdljh2VRmo4UzMcA9wN42EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029564; c=relaxed/simple;
	bh=CX021c9/rKCMHX8AKyztYOJLxciwY9Y8N/sJjPa12qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFiSutBFQ6em/8yo0tzwj77WZGCW0arYjbwLgmWFdUw+dG7e1sQQOA1eQCtTSXG0uwYBUEeIy5lOkvzcSP0aeZZ6ajKjke470HQ3yNO7rRslylzyH5Tpbb1oqpoGDbT/w1E9ZpW9jQ2XFsGuZI/s76QeJrCzHOUzHAYl+DW3yb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr+ImlSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758029561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2H4EDcUVkF17k/vdLszvwCOsmnxB4WVC8IE9QIOrYc=;
	b=Xr+ImlSKkoSHol0SHpDr0MZT0yGD6a72c3wS2RzY5y0xy4wBv+tVHHcMnq9U8dAhkqDaPN
	D92ND5mpRI3e+ji1VAEQs8md29q0wDI8l/LOwpdFN44nURpyu4PItzvpQVTlwe0Co4iDLL
	XNsiAtolXcebexL1s/mwtIiZmUQ88Hk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-4uB5mF0fNoSPp4P2DBpCPw-1; Tue, 16 Sep 2025 09:32:40 -0400
X-MC-Unique: 4uB5mF0fNoSPp4P2DBpCPw-1
X-Mimecast-MFC-AGG-ID: 4uB5mF0fNoSPp4P2DBpCPw_1758029559
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45df609b181so46039735e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029559; x=1758634359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2H4EDcUVkF17k/vdLszvwCOsmnxB4WVC8IE9QIOrYc=;
        b=XoQ7mO02cHWFHJqvx1IC7PTpRmHc+JiOme3sL6XCKtA8uIsZjs4CZLK7dGwgVaQTfx
         a5DXkaXR58EElw9fUv8PNRCWAU8283qbrGo7ZdC8NYMRtgNKDPoHUW1zLJop/SqasWyD
         woEr0VnDo5pW0J5yEN4ycjDmlEJbUiNXhLv7aMfrCbiJWTIJucmtZqxQE/2yY75jOXG3
         y2RpCnjyA8xRBt0zKSvF4Vt253azZ/HB5kM+VXD7XpJkBGCW07JKBkKx+83r7VxBC5LY
         KFrW1o70/lk5NGVgmlMfKU2ByCE0mGQfsPjb2l6E8GCdS8e6EWIaQI4a7hcOB6DpbQsR
         junw==
X-Gm-Message-State: AOJu0YxPbz9SLoNL82GRRxcdJUzPrfotRY6Kti7kg2r/Mp2M1iEkzA3R
	RTQOdtA+ZRI5paL5a7vY/k5X8vfgxi0NM89zcGEVQ8OYHQ+u+z6OdHxmkpWcFOR0WmFknxD/MN1
	Yd16T425oLoHaYxm5nXcKGUJKbP1JTkzK0DRxRwdFWGNSAXgFZ6D0wYWZ6A==
X-Gm-Gg: ASbGncs3rv3/gjV/BR7QF00soPf1d0cXOOjQg01GROFAEWnEFWbNSAFG0QfF3Oa32lu
	Oz7lEZJSU1Hkm75pcE8baaoIsv2cIm1Kciv/vlHb/Zw1r81qJDSLlSJAMshzYIB645w450hLS4U
	Ctrt9PqmSKX/VuVxn/TzpNfVfL0gZeFjY1SVuEhY2uviJbTlxNUHH/qVTmIOxULYoOBHNbT+Jvl
	LyBS3zurHSxAXNZ06XBu0D1n3sjyKThfvHgGtHG3Co+yfmnaCDCYRpAqvfpCwEFnzOE9T52tV8C
	c7HR7s14UUR/lFlCnq+XDYxR/cAo/agRxEiq8wczqtH7nDpqVVMMVHj3vt5yGVqwlpFkxuWULo9
	RMjEl3m14syh1
X-Received: by 2002:a05:600c:190c:b0:45d:d5cb:8dee with SMTP id 5b1f17b1804b1-45f29261e30mr112033025e9.33.1758029559173;
        Tue, 16 Sep 2025 06:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzTxl253dNkLkka+f2ooOsbl0VNJgaq4utm5LVxBMy7i49xYcMwKe5bQMDEMEUAfRBx18+hA==
X-Received: by 2002:a05:600c:190c:b0:45d:d5cb:8dee with SMTP id 5b1f17b1804b1-45f29261e30mr112032495e9.33.1758029558697;
        Tue, 16 Sep 2025 06:32:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm218745635e9.24.2025.09.16.06.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:32:38 -0700 (PDT)
Message-ID: <64e2cf5f-b2e5-43b9-aea9-a937f6ec1508@redhat.com>
Date: Tue, 16 Sep 2025 15:32:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] phy: mscc: Fix PTP for vsc8574 and VSC8572
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
 vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, rosenp@gmail.com,
 rmk+kernel@armlinux.org.uk, christophe.jaillet@wanadoo.fr,
 steen.hegelund@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915080112.3531170-1-horatiu.vultur@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250915080112.3531170-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 10:01 AM, Horatiu Vultur wrote:
> When trying to enable PTP on vsc8574 and vsc8572 it is not working even
> if the function vsc8584_ptp_init it says that it has support for PHY
> timestamping. It is not working because there is no PTP device.
> So, to fix this make sure to create a PTP device also for this PHYs as
> they have the same PTP IP as the other vsc PHYs.

[...]

> diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> index ef0ef1570d392..89b5cd96e8720 100644
> --- a/drivers/net/phy/mscc/mscc_main.c
> +++ b/drivers/net/phy/mscc/mscc_main.c
> @@ -2259,6 +2259,7 @@ static int vsc8574_probe(struct phy_device *phydev)
>  	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
>  	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
>  	   VSC8531_DUPLEX_COLLISION};
> +	int ret;
>  
>  	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
>  	if (!vsc8531)

vsc8574_probe() is also used by 8504 and 8552, is the side effect intended?

/P


