Return-Path: <netdev+bounces-245313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23941CCB5D9
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED083304EFC8
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35433DED2;
	Thu, 18 Dec 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N6jvHV9F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281B3370ED;
	Thu, 18 Dec 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053044; cv=none; b=NVPSxxk/caXOYpapKG0v9ACrZlWJTSD124Hq49dh+7Y8K2H7FThzX866sxLoszOeLmbZ9J67HNOcMHlzQkP/ytWxlNSw96aplooN1SRM2cw3mq9Ej3MdHoVBA3j74BE7ZwhFxS06b0M3vaST8iuQIyXWFyW489rK1B0nuBKyq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053044; c=relaxed/simple;
	bh=mrGiYt9Sq/LQ+C97kUq4PDjkqIr7ezDlN1ID5y/Eu0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmBErUWCpDjuNmYA7z/0yldjMJwn6PF47U0+cU8i4ZbE+MpKOqwRQbpuS8lIJu+Bhbspay4PQjzYBqVGf8s/vvTzMUHOMa6kKXlLc6finlCZIDtAyrbZf76+v/RMcqlDHO6ZrT7JZq7pXrltj9hev1epmvbFk75pYm/7K5nlAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N6jvHV9F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rw5eXUZtktG70+hHKZyjbROxfGA55SsqKjTjPyMJkzw=; b=N6jvHV9F+cXY3pYLorRCXEeL07
	f4xsIxrT0hCT17sxFhk7EhfC5RiuDb+S+Q/ILwjRaXrzxQdnG3SMrldSd1iusxEJn2RgyDxVr6a0J
	nbejeDlbMnvjogYuyvst2MmEK4mahJJX1nCZu8C9yYXWxlf9DGNPfieOe/m1xYFl0hT4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vWB4G-00HK9L-Ur; Thu, 18 Dec 2025 11:17:08 +0100
Date: Thu, 18 Dec 2025 11:17:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, khalasa@piap.pl,
	andriy.shevchenko@linux.intel.com, o.rempel@pengutronix.de,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] net: usb: asix: validate PHY address before use
Message-ID: <d49a5ec7-219b-4991-a5d3-b8705f6d2ec4@lunn.ch>
References: <20251218011156.276824-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218011156.276824-1-kartikey406@gmail.com>

On Thu, Dec 18, 2025 at 06:41:56AM +0530, Deepanshu Kartikey wrote:
> The ASIX driver reads the PHY address from the USB device via
> asix_read_phy_addr(). A malicious or faulty device can return an
> invalid address (>= PHY_MAX_ADDR), which causes a warning in
> mdiobus_get_phy():
> 
>   addr 207 out of range
>   WARNING: drivers/net/phy/mdio_bus.c:76
> 
> Validate the PHY address in asix_read_phy_addr() and remove the
> now-redundant check in ax88172a.c.
> 
> Reported-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3d43c9066a5b54902232
> Tested-by: syzbot+3d43c9066a5b54902232@syzkaller.appspotmail.com
> Fixes: 7e88b11a862a ("net: usb: asix: refactor asix_read_phy_addr() and handle errors on return")
> Link: https://lore.kernel.org/all/20251217085057.270704-1-kartikey406@gmail.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

