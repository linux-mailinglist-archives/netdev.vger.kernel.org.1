Return-Path: <netdev+bounces-208629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C094B0C70D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42201883CAE
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9D2C327C;
	Mon, 21 Jul 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eZKEoqhd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7F289E07;
	Mon, 21 Jul 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109764; cv=none; b=TOhBY2Nbz7Ns8vN1idbCDji/Xv+7rbKH7ULSn06LP2Fvzin+r+3SlClDVmwkvzl3qtFzRMe2qbumB6RlApTii+JSdFf0rS01HsV9z/beOj9/UjWptPgo0RQKvhd2YyA2RYv7PIHWQp86vY7wp2D4UCNRJStuQCZL5ZNV+MhDVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109764; c=relaxed/simple;
	bh=yJf51IhMxFdJYipRkCqCtlpvgj3N9aiKszPM1IzUrow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjKGf4QeO6zQW6Ay9vYIVbK7SOIBRHtl8oCc5Bs5IpUbH0cfziM9gMhApgs+TGNlwNjh1NjpsRQC0V6jMe1ZGGTnBZURQt9ESn94dsWzryjeIYopBryKnOJ6wQDHC/w5VacDZFWUgKJY3pQuqR3tNj+x9Ru7WKt1y8capybPniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eZKEoqhd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+DyZkIYO1XqsrsbpchPc3O0d4QABkPVrst0a/+a1IUQ=; b=eZKEoqhdtAv5irywEXHEpgprx1
	2Qcs6sRhqltXnjBmz3sAPzMZxbNNwKJRUnS3KLHJccxPvONUFX/EHqhuq5Nw6KZPbK3SXODAsWjbL
	CSTDTeSgV3PHZGvaiy4TLG7gkWN0ozOKsgwU+XqtIp5UqQ78AOSOXJgak/BBgPL8mmm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udruw-002Mso-L2; Mon, 21 Jul 2025 16:55:02 +0200
Date: Mon, 21 Jul 2025 16:55:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <552cb3f0-bf17-449b-b113-02202127e650@lunn.ch>
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

> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -61,6 +61,7 @@ Contents:
>     wangxun/txgbevf
>     wangxun/ngbe
>     wangxun/ngbevf
> +   mucse/rnpgbe

This list is sorted. Please keep with the order.

Sorting happens all other the kernel. Please keep an eye out of it,
and ensure you insert into the correct location.

> +++ b/drivers/net/ethernet/Kconfig
> @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
>  source "drivers/net/ethernet/wiznet/Kconfig"
>  source "drivers/net/ethernet/xilinx/Kconfig"
>  source "drivers/net/ethernet/xircom/Kconfig"
> +source "drivers/net/ethernet/mucse/Kconfig"

Another sorted list.

> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +#include <linux/string.h>
> +#include <linux/etherdevice.h>

It is also reasonably normal to sort includes.

> +static int rnpgbe_add_adapter(struct pci_dev *pdev)
> +{
> +	struct mucse *mucse = NULL;
> +	struct net_device *netdev;
> +	static int bd_number;
> +
> +	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);

If you only have one queue, you might as well use alloc_etherdev().

> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	mucse = netdev_priv(netdev);
> +	mucse->netdev = netdev;
> +	mucse->pdev = pdev;
> +	mucse->bd_number = bd_number++;
> +	snprintf(mucse->name, sizeof(netdev->name), "%s%d",
> +		 rnpgbe_driver_name, mucse->bd_number);

That looks wrong. The point of the n in snprintf is to stop you
overwriting the end of the destination buffer. Hence you should be
passing the length of the destination buffer, not the source buffer.

I've not looked at how mucse->name is used, but why do you need yet
another name for the device? There is pdev->dev->name, and soon there
will be netdev->name. Having yet another name just makes it confusing.

	Andrew

