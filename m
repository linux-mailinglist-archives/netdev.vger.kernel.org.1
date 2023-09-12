Return-Path: <netdev+bounces-33326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAC79D688
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D311281837
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754357F0;
	Tue, 12 Sep 2023 16:40:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954A621
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:40:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C3115
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=izkgj7DyBqmPtxp1h8cZ+QdYcmh/+5DF/POXzwEBmd0=; b=Hsei58Fo1pCVSzfuTtDcrrYE5O
	JNVjpwzDK57snq9eh1dRU2OSbEWDDTzfn1dI+4gXUqs+4xkeBDtuoHhQEYPNbj6aMIvq6Dc2APlrv
	S0SgVCtOwX+KBEpQR6ZxwK9Eq4h1ePvNu13Kg3C90WFHkQeb5XXq2DdE1zINWjTPsCE751T3euojW
	IzX5BbkHSKJnedzF5emIHjVZv1plso94JuX9PkdbKP0Pdan5p89M0dX/DoPIpK+rI4Hst3oIojYna
	2AWFVkoFiRJ9221GT4bMHEbCVTQ086enCDJZSAafPvtsT7rCwEvWGornWyeSDlVQE/kR0ASkXtfB1
	C8+HCusQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qg6R7-0001SW-0f;
	Tue, 12 Sep 2023 17:40:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qg6R7-0002rs-38; Tue, 12 Sep 2023 17:40:25 +0100
Date: Tue, 12 Sep 2023 17:40:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
Subject: Re: [RFC PATCH v3 net-next 6/7] net: ethtool: add a mutex protecting
 RSS contexts
Message-ID: <ZQCUeTrMpmxhlW9C@shell.armlinux.org.uk>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <b9bdb464a3fcfcfa7ab01b1cf5e0e312c04752f5.1694443665.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9bdb464a3fcfcfa7ab01b1cf5e0e312c04752f5.1694443665.git.ecree.xilinx@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 12, 2023 at 03:21:41PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> While this is not needed to serialise the ethtool entry points (which
>  are all under RTNL), drivers may have cause to asynchronously access
>  dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
>  do this safely without needing to take the RTNL.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 3 +++
>  net/core/dev.c          | 5 +++++
>  net/ethtool/ioctl.c     | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 8977aa8523e3..1f8293deebd5 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1026,11 +1026,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  /**
>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
>   * @rss_ctx:		IDR storing custom RSS context state
> + * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
> + *			within RTNL.
>   * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
>   * @wol_enabled:	Wake-on-LAN is enabled
>   */
>  struct ethtool_netdev_state {
>  	struct idr		rss_ctx;
> +	struct mutex		rss_lock;
>  	u32			rss_ctx_max_id;
>  	u32			wol_enabled:1;
>  };
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f12767466427..2acb4d8cd4c7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10054,6 +10054,7 @@ int register_netdevice(struct net_device *dev)
>  	idr_init_base(&dev->ethtool->rss_ctx, 1);
>  
>  	spin_lock_init(&dev->addr_list_lock);
> +	mutex_init(&dev->ethtool->rss_lock);

Is there a reason to split this from the idr (eventually xarray)
initialisation above? Surely initialisations for a feature (rss)
should all be grouped together?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

