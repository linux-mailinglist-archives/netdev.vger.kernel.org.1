Return-Path: <netdev+bounces-179947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE81A7EF8C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556113ABDCB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC82222D4;
	Mon,  7 Apr 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K7ghY3cr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651F1EF0A1;
	Mon,  7 Apr 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060166; cv=none; b=G6TNGdVbeSU7uVDY6lM+PbwTaJHrBy67gj+YyYiRp0p/iQ563pLXCo2DJSFpqo2Bwu4Oe4J1Z7QxZzhvnwCNQfe/5PW824UmK/jfJYkh8sltYVRPxr9YAqXYS8iSyPpFKmvATed4Pw5la5uaqqROReObdV5oE8TCC0BngDs2CCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060166; c=relaxed/simple;
	bh=wUocLj4Fyt1h9daFXhG7uB7c0V0HiExXAxXLAZEYlB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucVTainy3/zeAj6eIqoP9MuDEGmRLkkebnrDyG5CzQ4ScK8lwVl3n+9akwjmpUithYYwbageHb+wX3+fzJwTTev+2OAZ1oZ6Ow0drHkx5WJvwKIOw0nLjiUBmC0LIK0vYhVOOWDiAENw8tqROxj5CO5mXbKTvwDFSRwoj+670qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K7ghY3cr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w/GtE5xw2y5Msi3kroTiKAeUWr169xRkWtJLd0TQeUk=; b=K7ghY3crjNSJIkM6o1sa3rxtGA
	nvKkNkAIVALxvgqfvDSfCRlp4PdgFRfnleQXWgGmGxk3V76MD8wKAowkP7XGN/4DoMNA/0Sz64RQJ
	b130NZlQpqQAgfuMbh/vQcY6LY/6qLcjKhZkOQpXVaek4GXkH4OqKNH2gXECbG7d5xy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1tiU-008J3u-0W; Mon, 07 Apr 2025 23:09:14 +0200
Date: Mon, 7 Apr 2025 23:09:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 05/28] mfd: zl3073x: Add components versions register defs
Message-ID: <a5d2e1eb-7b98-4909-9505-ec93fe0c3aac@lunn.ch>
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172836.1009461-6-ivecera@redhat.com>

On Mon, Apr 07, 2025 at 07:28:32PM +0200, Ivan Vecera wrote:
> Add register definitions for components versions and report them
> during probe.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> index 39d4c8608a740..b3091b00cffa8 100644
> --- a/drivers/mfd/zl3073x-core.c
> +++ b/drivers/mfd/zl3073x-core.c
> @@ -1,10 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/unaligned.h>
>  #include <net/devlink.h>
>  #include "zl3073x.h"
>  
> +/*
> + * Register Map Page 0, General
> + */
> +ZL3073X_REG16_DEF(id,			0x0001);
> +ZL3073X_REG16_DEF(revision,		0x0003);
> +ZL3073X_REG16_DEF(fw_ver,		0x0005);
> +ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
> +
>  /*
>   * Regmap ranges
>   */
> @@ -159,10 +168,36 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
>  
>  int zl3073x_dev_init(struct zl3073x_dev *zldev)
>  {
> +	u16 id, revision, fw_ver;
>  	struct devlink *devlink;
> +	u32 cfg_ver;
> +	int rc;
>  
>  	devm_mutex_init(zldev->dev, &zldev->lock);
>  
> +	scoped_guard(zl3073x, zldev) {

Why the scoped_guard? The locking scheme you have seems very opaque.

> +		rc = zl3073x_read_id(zldev, &id);
> +		if (rc)
> +			return rc;
> +		rc = zl3073x_read_revision(zldev, &revision);
> +		if (rc)
> +			return rc;
> +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
> +		if (rc)
> +			return rc;
> +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
> +		if (rc)
> +			return rc;

Could a parallel operation change the ID? Upgrade the firmware
version?

	Andrew

