Return-Path: <netdev+bounces-153118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF29F6D40
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47101888BE8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5391FA16E;
	Wed, 18 Dec 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4iekdKjJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F3597C
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546518; cv=none; b=N5QmcrZJTXCRQoMP9BI3wMZVpzt3C32s7DRIHnKCExKOvk1gqrTXO20CF2dqwmbO5/9H+jWRbBmwgii/O20i/tB8msXn6v9rXO9c/QXQl/Ks6m0XPfiQ4NKhcklGPJC8RY9p3Sdn3Jifyv7gu50mL56EbqDeypLc5W4SX/5G/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546518; c=relaxed/simple;
	bh=mIuF9d1f+HLJrPmi8y97Wjpyzy6lK6c4oDO5xRAtSiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE7su2GnG6GB0dBHqlLymKIGJt7tz48zT6Zhtc2rKgOdfVRylcFi866BQM0UM+it9hBVWk2i4m+4rXnbSlOVfN5RuHTJNh3HHdKHATlJbZu1SvD78K9M7vqKljVsXQCrRkXiH27ts+hEg3WgeqUs38fCsHsdE6duXMxhgudp6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4iekdKjJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4w2SmD30GoQa4S2X31V42N3+CjNHB5h064z4DqpDDyQ=; b=4iekdKjJmFeTbKwNPc0ZNRy9XO
	pxYjSG7C2ZQNo7NL57Mxh5bwibtkbFx89Zt0cOxrziz9gvPLXw99J79BwPMmUdQIUUq4HfBZJoHob
	gxn+x82OHeDPdAxG3uwacIVASkZ+Qtz3bHgxygRhF/yvl7BdVf2OYQH78m85CspXL4A4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNyme-001MWY-2x; Wed, 18 Dec 2024 19:28:32 +0100
Date: Wed, 18 Dec 2024 19:28:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com
Subject: Re: [PATCH v1 09/16] net-next/yunsilicon: Init net device
Message-ID: <51fa5341-4e7b-4c76-8fd5-9ca1f4b57de7@lunn.ch>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105041.2237645-10-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218105041.2237645-10-tianx@yunsilicon.com>

> +static int xsc_attach_netdev(struct xsc_adapter *adapter)
> +{
> +	int err = -1;
> +
> +	err = xsc_eth_nic_enable(adapter);
> +	if (err)
> +		return err;
> +
> +	xsc_core_info(adapter->xdev, "%s ok\n", __func__);

...

> +static int xsc_eth_attach(struct xsc_core_device *xdev, struct xsc_adapter *adapter)
> +{
> +	int err = -1;
> +
> +	if (netif_device_present(adapter->netdev))
> +		return 0;
> +
> +	err = xsc_attach_netdev(adapter);
> +	if (err)
> +		return err;
> +
> +	xsc_core_info(adapter->xdev, "%s ok\n", __func__);

Don't spam the log like this. _dbg() or nothing.

> +	err = xsc_eth_nic_init(adapter, rep_priv, num_chl, num_tc);
> +	if (err) {
> +		xsc_core_warn(xdev, "xsc_nic_init failed, num_ch=%d, num_tc=%d, err=%d\n",
> +			      num_chl, num_tc, err);
> +		goto err_free_netdev;
> +	}
> +
> +	err = xsc_eth_attach(xdev, adapter);
> +	if (err) {
> +		xsc_core_warn(xdev, "xsc_eth_attach failed, err=%d\n", err);
> +		goto err_cleanup_netdev;
> +	}
> +
>  	err = register_netdev(netdev);
>  	if (err) {
>  		xsc_core_warn(xdev, "register_netdev failed, err=%d\n", err);
> -		goto err_free_netdev;
> +		goto err_detach;
>  	}
>  
>  	xdev->netdev = (void *)netdev;

Before register_netdev() returns, the device is live and sending
packets, especially if you are using NFS root. What will happen if
xdev->netdev is NULL with those first few packets?

And why the void * cast? 

> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */

The /* SPDX-License-Identifier: line replaces all such license
boilerplate. Please delete this.

	Andrew

