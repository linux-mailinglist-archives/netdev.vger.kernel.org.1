Return-Path: <netdev+bounces-166881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BCA37BB1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F3916CFF4
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8518FDA9;
	Mon, 17 Feb 2025 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLIyZ4ku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8218DB1F
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775449; cv=none; b=cAuNCLUOX8ZukklQspLj0M7nAe4F5wUY3Gmq504greZNYftgwQHxIrSnzMELxWBaz0PcjAdgAaQ+ZSwBe7PAu5HClCOOjmlK1YZtKIJwmKljfpbZCi+OvTMLJ43bPfl8mvbM8fCngo8G0f9+ssWivQ5Yr9OoVBQmoJ8GnhIAcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775449; c=relaxed/simple;
	bh=fIDKHUBuqNQIcsfh74WwNDzJmSsMJZ3311IIVHmijwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxsd591uRvGN9zSELUJt150UugKgfFj3madj+gmtdFNBIrcesBg0BTXs1GjdyBqKDHC1oa4VLcc3IMoN7cPD1YVAj6Xr+ttrEZB/eNB17YdKMic6KVdAKCQK3YnNeAroRt48hg3qhoedaQDJJNsZ83cu1G3RShr0/VCcGY4UTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLIyZ4ku; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab744d5e567so747423866b.1
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739775446; x=1740380246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWaCogYs/KhJPjsvCGHqur4uBo9p0cCXXx7YAfBkX3c=;
        b=JLIyZ4kucJA7rKOVS/tZpDvzIPdawj3RwvcVp48WKwwB0gvuMXJAhmlnV6t0CS5FcT
         zv26OnIKKrT2sUHoBQk8aeGAuynblaYYSkHnN4l4iNj6UVi7Q9TQQ79/w7a0DB5zDllN
         ugCgz8lmEoRp1eOvjAxB8v/VXSqzbpwusTZTHSlEaXHL1npS2e2AdEymY77RpAkgDm4r
         InDCxPQJ3649Eh03LgNz7ImYPpbbSw+kzjEgZk34WT+ZCb3LgPQxTAQe2XXrWH3p9iT/
         hrctS8pjPnP350NBnQ/u7B9WSBOivQr4bFgEAADdH8/x+AFC4b+Igxgl8x7DsiYVFeTq
         GJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739775446; x=1740380246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWaCogYs/KhJPjsvCGHqur4uBo9p0cCXXx7YAfBkX3c=;
        b=cXBRVA9pPVtS2+2J+PNXu9/BT7CAcU2MxwRA69QkXI+WXVoCx+RQgnfTVG/ITA9ofu
         IzZj6EgdtK9N4SCDIfkm8msCmBgPHM5fG4paDfkIZjpVmi6OcIgbFSlT9LVk27ntLJYX
         k0mLEQ67gL9CcP2vBcDrV4vayJYuOn6AtXp2RPwYK3blQi4uuWuItasoG/nhpPHgcJEa
         Ga23yrkaNLgojM2mX5NfY6ERDmiIVBx3OJ9vXOyIfXnQF1lTt+oPt19jRS9SL9La3Rn1
         pamAu4U/KGizSQNhV8TsaUFnN7S5f7w2/f/y5K1uWH9NLgZeR2ZIneh3MapKq8msoZ1H
         gDBw==
X-Forwarded-Encrypted: i=1; AJvYcCUcLq+mYCAFe3n+3yHo1dB62chpp9qAhObaI8jC1PB9tG3fZ1TAs1+DUPCtloRmIwAXJdGwMDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfcVuJHM5wj/busjUXwzKdjbc+4AsZiPwWRQ8291sN2jWpso6
	AlRCS97QsM8DX99PtbFPmn+fOgwsTipf8gRhx20pQxc7vNjqzbX7+cRZtCo3mk4=
X-Gm-Gg: ASbGncuzmDHFCzO9PhtAL0AU/vCUrtTjhzNobAEeb1y3Sn0J/YQjBlbL+LXYdfRGbGF
	cBCj/H4ni2se/r2/lg4clbPKk9yMnUb5cQGesV71rE6vf6wrPOSQ+iz7tIPw7ZdWHGAFBN1mPlg
	N01p8VQxxXRr9T0P8dc/TpHMBasmOi2L+5Axqhx5mcF4woLgN2WUxQBf4lfwiI/utqRdJ9HVG0q
	hSkOY8hZOxx6kH6AYZdco7j3IAV6t6glYZ3JBa/4Gkegq0c8bxNBgOD3a2I/2zvoMT0J7Sj1pCQ
	Rhtp0vtf/L7o7PmDz4H1
X-Google-Smtp-Source: AGHT+IGIuaVlGpB6VdQAkuJ8DUCk9lW3FI/5v0aSAYWX8XO1pohyiVDoKQvMA3rT2tbS8GCpM3WpMg==
X-Received: by 2002:a17:907:d0f:b0:ab6:c726:2843 with SMTP id a640c23a62f3a-aba510aece5mr1557229566b.22.1739775446050;
        Sun, 16 Feb 2025 22:57:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb9553fbd0sm205055966b.84.2025.02.16.22.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:57:25 -0800 (PST)
Date: Mon, 17 Feb 2025 09:57:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <52a19d60-009d-4564-bedc-56c6425c5275@stanley.mountain>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <64053332-cee0-49d8-a3ae-9ec0809882c0@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64053332-cee0-49d8-a3ae-9ec0809882c0@stanley.mountain>

Both versions find 97 warning but they're slightly different so I should
create some kind of combined check.

drivers/input/touchscreen/cyttsp_core.c:658 cyttsp_probe() warn: passing non-max range 's32min-(-1),1' to 'ERR_PTR'
drivers/gpu/drm/mediatek/mtk_dp.c:2736 mtk_dp_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/clk/clk-gpio.c:371 clk_gated_fixed_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/ethernet/socionext/netsec.c:1902 netsec_acpi_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/ethernet/socionext/netsec.c:1909 netsec_acpi_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2050 mcp251xfd_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/can/spi/hi311x.c:857 hi3110_can_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/can/dev/dev.c:496 can_get_termination() warn: passing non-max range 's32min-(-1),1' to 'ERR_PTR'
drivers/pwm/pwm-sl28cpld.c:228 sl28cpld_pwm_probe() warn: passing non-max range 's32min-(-1),1' to 'ERR_PTR'
drivers/leds/leds-is31fl319x.c:423 is31fl319x_parse_fw() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/leds/rgb/leds-mt6370-rgb.c:738 mt6370_assign_multicolor_info() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/leds/rgb/leds-mt6370-rgb.c:945 mt6370_leds_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/leds/rgb/leds-mt6370-rgb.c:952 mt6370_leds_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'

The first return from acpi_data_prop_read() could be 1.  I'll report
this.

drivers/gpu/drm/msm/msm_gem_submit.c:537 msm_parse_deps() warn: passing non-max range '(-4095)-(-1),22' to 'ERR_PTR'

Clear bug.  Double negative -(-EINVAL).  I'll send a patch.

drivers/gpu/drm/xe/xe_guc.c:1241 xe_guc_suspend() warn: passing non-max range '(-110),(-71),(-6),1-268435455' to 'ERR_PTR'
drivers/gpu/drm/i915/gt/uc/intel_guc.c:698 intel_guc_suspend() warn: passing non-max range '1-268435455' to 'ERR_PTR'

Smatch gets confused by the return FIELD_GET(GUC_HXG_RESPONSE_MSG_0_DATA0, header);
in xe_guc_mmio_send_recv().

drivers/spi/spi-pxa2xx-platform.c:101 pxa2xx_spi_init_pdata() warn: passing non-max range 's32min-(-1),1' to 'ERR_PTR'
drivers/spi/spi-cs42l43.c:396 cs42l43_spi_probe() warn: passing non-max range 's32min-(-23),(-21)-(-1),1' to 'dev_err_probe'
drivers/spi/spi-rockchip-sfc.c:654 rockchip_sfc_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/dsa/mv88e6xxx/pcs-6352.c:250 marvell_c22_pcs_link_up() warn: passing non-max range '(-110),(-95),(-16),1' to 'ERR_PTR'

False positive.  marvell_c22_pcs_restore_page() is complicated.

drivers/net/phy/phy_device.c:1150 phy_connect() warn: passing non-max range 's32min-(-1),1' to 'ERR_PTR'
drivers/net/phy/phy_device.c:1651 phy_attach() warn: passing non-max range 's32min-(-1),1' to 'ERR_PTR'
drivers/net/ethernet/ethoc.c:719 ethoc_mdio_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'
drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c:178 hbg_phy_connect() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'

xa_alloc_cyclic() returns 1 if the allocation succeeded after wrapping.
I'll report this.

drivers/net/ethernet/aquantia/atlantic/aq_ring.c:481 aq_xdp_run_prog() warn: passing non-max range '(-16),0,5-6' to 'ERR_PTR'

Bug.  Mixing error codes from aq_hw_err_from_flags() and NETDEV_TX_BUSY.

drivers/media/i2c/ds90ub913.c:856 ub913_probe() warn: passing non-max range 's32min-(-1),1' to 'dev_err_probe'

This is a transient bug that went away after a database rebuild.  I'll
debug the rest over time.

regards,
dan carpenter


