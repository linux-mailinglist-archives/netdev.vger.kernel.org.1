Return-Path: <netdev+bounces-185664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E8A9B463
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DD54A200E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D128B4E0;
	Thu, 24 Apr 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FnWs9dTi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D8289364;
	Thu, 24 Apr 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513024; cv=none; b=aEFTeht/4YikhZ9k+7eU16gvf4gkkYEnWWG614QmfkC5FqMIg0xSLt4BWDwlPtf6hSfzrvGRtPWCj6h5kc5c+GZ2+hbk7nZJmUSfiuCDnwvAZN6NJTKz68MWK6SxvhesRqZyk81HwagOdmNvCwaVhFZk2MuXcM0QeingVpURqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513024; c=relaxed/simple;
	bh=1RBK2Q9ahQnBbtJntTBQY0ipwwDqIjPeeAtr2SSUqLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw/gM2gBAkw6ezks544bA7Gg1IXPa+cTkFRjH1ruN++sqkfje/9FsgELqo5dDH5Ngzk5C+5T5dovggtozLmekN07ICgZNVl8PabZg3BNHdXGosjmDG7TvXIU/mbz0lVZW//VCgrsAdPgCU/UPDeMppOcM9DbF76nCldFUUWhO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FnWs9dTi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W+/9EqQuci/NV2Gog2+DdNgVaNDmWVcoA608wVF69qQ=; b=FnWs9dTiWm5SFw+TgxoQ2BJgNC
	mJVB5L/5aMJXm38UOdGlDkOvk6h0G9arIm3fTnkBqMVibTCFeQuZR+bephsOecZb4zpvrZE0fwbbr
	89a7fUIRkbU2MCy9jRFZlZpJvmSZNZ0GYxFqGiK9x0tcSF2ypr+KdhERg9igTdiqOIbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7zfg-00AUV9-Vk; Thu, 24 Apr 2025 18:43:32 +0200
Date: Thu, 24 Apr 2025 18:43:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424154722.534284-6-ivecera@redhat.com>

> +static int
> +zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg, const void *val)
> +{
> +	unsigned int len;
> +	u8 buf[6];
> +	int rc;
> +
> +	/* Offset of the last item in the indexed register or offset of
> +	 * the non-indexed register itself.
> +	 */
> +	if (ZL_REG_OFFSET(reg) > ZL_REG_MAX_OFFSET(reg)) {
> +		dev_err(zldev->dev, "Index of out range for reg 0x%04lx\n",
> +			ZL_REG_ADDR(reg));
> +		return -EINVAL;
> +	}
> +
> +	len = ZL_REG_SIZE(reg);

I suggested you add helpers for zl3073x_write_reg_u8(),
zl3073x_write_reg_u16(), zl3073x_write_reg_32(), and
zl3073x_write_reg_48(). The compiler will then do type checking for
val, ensure what you pass is actually big enough.

Here you have a void *val. You have no idea how big a value that
pointer points to, and the compiler is not helping you.

I suggest you add the individual helpers. If you decided to keep the
register meta data, you can validate the correct helper has been
called.

	Andrew

