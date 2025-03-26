Return-Path: <netdev+bounces-177692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46980A71490
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861467A2FB5
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623A187FFA;
	Wed, 26 Mar 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhHTWwc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013868C1F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984253; cv=none; b=lu4QbkSUfn4XVnC8IpBfrMTiPxLYXqyOXyuxxO7YrbJ+RTZQ/ppAPCQV6VEuEL0DnSaHL4xn3wVPc3hNSYDyHezn7Y70OsuRuZBcZPOAwhMeKXUoENFVHxcjPA5wpg0lYLb0bsOJvkHzqoAe3uqd9MXF8TUj1IXSaWNC/Ujo2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984253; c=relaxed/simple;
	bh=miO0qlOr+Pt3ECWN8lz3YNCOyw/gDLSf0zkw/En1YK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKNhGTJuno8oJCjmxnhxaRWub5YabGDHnzhcKLjvHyI/OZWgZ6aivE1VzmThoL5AwItUuO3bUbsdEXyjWG5LeUXw575R5uFhbOzBsk+kd1lipHUipL2hBbYa9/9b9mefsJ5vUhMK21Q30LWIcxNnWN8koJ3PPzVDSCJmBt1T01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhHTWwc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2496FC4CEE2;
	Wed, 26 Mar 2025 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742984252;
	bh=miO0qlOr+Pt3ECWN8lz3YNCOyw/gDLSf0zkw/En1YK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhHTWwc9y7KT+J94hHoMVi6oJRc7MXgPqPBzxYlhg26Hp+TEeADLmIlOjLeT87FL5
	 D8e14OkxsjUfvNKn1NgPiaDZOnDtd8viHDGkKHfVCwMFhRIx94dJGedf6pK9XK5eXp
	 094kNE0si7kVgj9vbjxhhJY63Y/gKQ+lE8dl2pwPb7yK6ruKrPvs97zTFORQzolQ14
	 FB3/DM8+ld8NFqm4Hi9uu6WY89RTgh2h8kM5xHVCTT7kdx6/L4EFawOBKff8Dg6UzF
	 CTDrssvmFIPkUL2Iqe9+e+k5KTJRDxhpRvIVht8J6v7WyrF07t7jGzecH3YsdX1dsw
	 v2OQap+MBmY9A==
Date: Wed, 26 Mar 2025 10:17:27 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be,
	geert@linux-m68k.org
Subject: Re: [PATCH net-next v9 12/14] xsc: Add ndo_start_xmit
Message-ID: <20250326101727.GA892515@horms.kernel.org>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
 <20250318151517.1376756-13-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318151517.1376756-13-tianx@yunsilicon.com>

On Tue, Mar 18, 2025 at 11:15:19PM +0800, Xin Tian wrote:

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c

...

> +netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct xsc_adapter *adapter = netdev_priv(netdev);
> +	int ds_num = adapter->xdev->caps.send_ds_num;

Hi Xin Tian,

adapter and adapter->xdev are dereferenced here...

> +	struct xsc_tx_wqe *wqe;
> +	struct xsc_sq *sq;
> +	u16 pi;
> +
> +	if (!adapter ||
> +	    !adapter->xdev ||

... but it is assumed here that both adapter and adapter->xdev may be NULL.

This seems inconsistent.

I haven't looked but I do wonder if adapter or adapter-xdev can be NULL in
practice?. If not, the checks above can be dropped. If so, then ds_num
should be assigned after these checks.

Flagged by Smatch.

> +	    adapter->status != XSCALE_ETH_DRIVER_OK)
> +		return NETDEV_TX_BUSY;
> +
> +	sq = adapter->txq2sq[skb_get_queue_mapping(skb)];
> +	if (unlikely(!sq))
> +		return NETDEV_TX_BUSY;
> +
> +	wqe = xsc_sq_fetch_wqe(sq, ds_num * XSC_SEND_WQE_DS, &pi);
> +
> +	return xsc_eth_xmit_frame(skb, sq, wqe, pi);
> +}

...

