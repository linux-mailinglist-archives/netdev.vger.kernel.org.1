Return-Path: <netdev+bounces-54398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81A806F72
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2374928195A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6A358AE;
	Wed,  6 Dec 2023 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yXwBRfcs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06805D3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gnpuVM+NQl0wBMZNSKRWmJUgaOxMtGOQ0+U+8CuUDRY=; b=yXwBRfcsDUQDyLZroO27ugs6f1
	4GXqvFADguAJkslFFeSPUCHQtKqFDJSzYsyE+5ngRE9JvpW4CR0wBnlqxSmpbrWCo5SfxUU7OnhPv
	5jRuC2PYnksZU3iq7z5bHBb14Q6AYSw5M1vmoXi2o7O5dpKOpkK3SnKF0TaTVkJZzikZdPASv5Zyj
	RidC92eyPUM17ufTOQGWU9mMo0jHWqXtcKC2D1JqKYL68iZYLzg27f6F2+Co5aU0GU5RxRXKWUkj9
	d9jDZP7Lk1qYyL3kEybWRXTzRrNi4MshKQTD0ftlvaSGPZA6oqjQtugDZlpfH48m4eTFFrJ1Msa/Z
	nBQgTDQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45950)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rAqfa-0008E5-0Q;
	Wed, 06 Dec 2023 12:06:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rAqfZ-0002hM-MS; Wed, 06 Dec 2023 12:06:25 +0000
Date: Wed, 6 Dec 2023 12:06:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 1/7] net: ngbe: implement phylink to handle
 PHY device
Message-ID: <ZXBjwWjd1Jv8916K@shell.armlinux.org.uk>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
 <20231206095355.1220086-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206095355.1220086-2-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 06, 2023 at 05:53:49PM +0800, Jiawen Wu wrote:
> Add phylink support for Wangxun 1Gb Ethernet controller.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   8 ++
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  20 ++-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 126 +++++++++++-------
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   2 +-
>  4 files changed, 93 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 165e82de772e..9225aaf029f8 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -8,6 +8,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/if_vlan.h>
>  #include <net/ip.h>
> +#include <linux/phylink.h>

Nit: would be better to keep linux/ includes together (and in
alphabetical order to prevent conflicts.)

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 8db804543e66..c61f4b9d79fa 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -9,6 +9,7 @@
>  #include <linux/etherdevice.h>
>  #include <net/ip.h>
>  #include <linux/phy.h>
> +#include <linux/phylink.h>
>  #include <linux/if_vlan.h>
>  
>  #include "../libwx/wx_type.h"

As wx_type.h includes linux/phylink.h, which is now fundamental for the
definition of one of the structures in wx_type.h, the include of
linux/phylink.h seems unnecessary here.

> @@ -336,7 +337,8 @@ static void ngbe_disable_device(struct wx *wx)
>  
>  static void ngbe_down(struct wx *wx)
>  {
> -	phy_stop(wx->phydev);
> +	phylink_stop(wx->phylink);
> +	phylink_disconnect_phy(wx->phylink);

I'm not sure why you're moving the PHY disconnection in this patch -
that seems like a separate change to the actual conversion to phylink.
For a pure conversion, you should be able to just replace the phylib
calls with their phylink equivalents.

It seems to me that there's two changes happening here: a conversion to
phylink and a re-ordering of the open/close methods particularly to do
with connecting and disconnecting the PHY. Either this needs to be
described in the commit message (the fact that it's happening and why)
or it should be two patches.

> -static void ngbe_phy_fixup(struct wx *wx)
> +void ngbe_phylink_start(struct wx *wx)
>  {
> -	struct phy_device *phydev = wx->phydev;
> -	struct ethtool_eee eee;
> -
> -	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> -	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> -	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> -
> -	phydev->mac_managed_pm = true;
> -	if (wx->mac_type != em_mac_type_mdi)
> -		return;
> -	/* disable EEE, internal phy does not support eee */
> -	memset(&eee, 0, sizeof(eee));
> -	phy_ethtool_set_eee(phydev, &eee);
> +	struct phylink *phylink = wx->phylink;
> +
> +	phylink_connect_phy(phylink, wx->phydev);

Note that phylink_connect_phy() can fail, so it's return value should
be checked.

Apart from the comments above, I think I'm fine with this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

