Return-Path: <netdev+bounces-208903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D0B0D83B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9AA189BBD8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F92E424A;
	Tue, 22 Jul 2025 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfgIhHKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5622E3B1D;
	Tue, 22 Jul 2025 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183757; cv=none; b=NdSDD9fPGzixgrFXhDvih9ZuwwzBQ5Qx6HVz22M/rIN6FMaobFzQHZg9r7wqvrQcxdFgTeo7rXZR0hjmaDy0Dq2McDVIclGyMd7OsRAYzk/h8lVbx614Cu0iHw7Rnv1iEINe4fQ6GGCFHGLm3EFhMynWOFwdsyzkUEzWjqfTA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183757; c=relaxed/simple;
	bh=MnJhslS49tnWuQbbIYAtWlEf8qcibmuZw4zBE4RSBHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHJmobEbpWync+gdqrDElgZhZGaT+EDyvS7hSaRyXnpKG0KDOa44WJmytb1EbUyJCiNkst5Iup7uGSme9a8/BCG3XcYNWS0qThrrXjdSPJe6Fsr8KJEwIg4/IVZ3WCn+JNlbfEOeC5jGxGJiH1BCb8vJQGnlxuIBESPu2xGvwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfgIhHKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B71C4CEEB;
	Tue, 22 Jul 2025 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183755;
	bh=MnJhslS49tnWuQbbIYAtWlEf8qcibmuZw4zBE4RSBHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfgIhHKhqcS3U5brP2JdGm2gQTrQNJL6bCwSbh6djQamWyHxJpis8fFRKDSo0l0bv
	 8jI9dZ0/Ri/4sP3okA/f20452ETbFIR6KATlc1UVcnpMYrsIMOKkSObtWOl2BulXTd
	 KPPJLLA183PaG1v8lPwQvyAMzBWrR9iBb6iKwwGOI5I0RsmYmfc1CwKf1RLYvcz8Jt
	 ISQx7cUYnmNDjGXnFu0LydHR5DRhfjtjq4OTiDsa3Kt2r/hWwvKGFC9XHg7RCMxfRq
	 2GEHTb6xGvbuGBefVSOH2GBi3/Eln01WCcJCPZTjhGlsk3RV2GRc9fXTGNVQgiG9AK
	 5AhMYEm1jLKPg==
Date: Tue, 22 Jul 2025 12:29:09 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <20250722112909.GF2459@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-2-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:24PM +0800, Dong Yibo wrote:
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> new file mode 100644
> index 000000000000..13b49875006b
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +#include <linux/string.h>
> +#include <linux/etherdevice.h>
> +
> +#include "rnpgbe.h"
> +
> +char rnpgbe_driver_name[] = "rnpgbe";

At least with (only) this patch applied, rnpgbe_driver_name
appears to only be used in this file. So it should be static.

Flagged by Sparse.

Please make sure that when each patch in the series is applied in turn,
no new Sparse warnings are introduced. Likewise for build errors.
And ideally warnings for W=1 builds.

...

