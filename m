Return-Path: <netdev+bounces-187250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB83AA5F25
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5661BA565C
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01518FDDB;
	Thu,  1 May 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtCE/t5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46118AFC;
	Thu,  1 May 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105728; cv=none; b=PukkGTcPPKHKfR8VeBFq0B0KjXGWTF5R/8NpkesQUv0fj19bOqVSWza5mfmpbfDYYVJ1GCLdgTajIzt0R16ueIg/9GUrnQY8ofeN86GUAdEF9MZHtnCRrKveJjayQn5v7SZFlIOlDa3jsBf4MX81B/zsI7oFKnarupEu9OCKqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105728; c=relaxed/simple;
	bh=RazpV2UTWQfk3VYP9glaXZEVzsKBiFCCY67xrHhBCWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAyO6p1sO/PrE5QsZk8xn2cgFusy7GO1/cWT0mdfrDQ1vhibSQLwu5JPl/lMoBBU4XOXSPI55pLYryeVJmlptLQnG9KBhycETdsDqUcn51UIQ7E96/vpklfxwttyoCAVmanh0qmi/yL6Wp5cdwHKxtLflSnJlslulQ0kgX9H4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtCE/t5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F991C4CEE3;
	Thu,  1 May 2025 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746105727;
	bh=RazpV2UTWQfk3VYP9glaXZEVzsKBiFCCY67xrHhBCWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtCE/t5g1ns3W+DH6t8IwoHQuS9mCSPqHUmL2mntT/RKn9d3bLNusXPWFiIHH8f2r
	 seuwlymI2q4iQkX3PcG2RnmKYD3ggTflV7hSbvuQsRe8/xkvYwfl+XVLq1PS6HAXOq
	 cHmonrxt2/FAGK4xhi7+ensRNwI+H7+VlLXvOovn8nN81m2Of8QC7qToHcvuu4DmKm
	 r7Ttlkhk7o12SD1ggTCKf6CnZ88UVHbcMb7w2ylG6WsWsx1PsIGLR6ccZbvEWVRqnC
	 g3TMp1p8VWv79TJBj1AZfzKWbmFaOn7cz3GNbDQbQI6S9+ktBKIQ4OjDGEPq4Fo+xs
	 bllW64LnpUflw==
Date: Thu, 1 May 2025 14:22:01 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <20250501132201.GP1567507@google.com>
References: <20250430101126.83708-1-ivecera@redhat.com>
 <20250430101126.83708-9-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250430101126.83708-9-ivecera@redhat.com>

On Wed, 30 Apr 2025, Ivan Vecera wrote:

> Register DPLL sub-devices to expose the functionality provided
> by ZL3073x chip family. Each sub-device represents one of
> the available DPLL channels.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v4->v6:
> * no change
> v3->v4:
> * use static mfd cells
> ---
>  drivers/mfd/zl3073x-core.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> index 050dc57c90c3..3e665cdf228f 100644
> --- a/drivers/mfd/zl3073x-core.c
> +++ b/drivers/mfd/zl3073x-core.c
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/math64.h>
> +#include <linux/mfd/core.h>
>  #include <linux/mfd/zl3073x.h>
>  #include <linux/module.h>
>  #include <linux/netlink.h>
> @@ -755,6 +756,14 @@ static void zl3073x_devlink_unregister(void *ptr)
>  	devlink_unregister(ptr);
>  }
>  
> +static const struct mfd_cell zl3073x_dpll_cells[] = {
> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 0),
> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
> +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
> +};

What other devices / subsystems will be involved when this is finished?

-- 
Lee Jones [李琼斯]

