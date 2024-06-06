Return-Path: <netdev+bounces-101503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E938FF14B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A43287E47
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDED197525;
	Thu,  6 Jun 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r4JT3BXO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074721E861;
	Thu,  6 Jun 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689271; cv=none; b=rJDjco6BzP96ylOyUS9QAalRLksJCMZO5yINaz953S++apZDKyhLsn+ymMj31ElLP4fldBMxdOi8HCGQPzsE5sGvaBuhbSg4LHBnACHOO2qBYCnt1RHg5IoJZPa5vneL0lCLPp1iUJSOPR5/n0W73NvERryG/vAC/uH5QBRBTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689271; c=relaxed/simple;
	bh=WMCbaZ/iG/bN4t908itTVnQjhv0cLsXkeR7bXwdNDpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C++HP4tQcYHpL3dRgH6eZk9GG7ppZ1Texz1ec8ipDWeLHj3aHHhSWrQwYgMnT3UnSabY8trRnPyog6RKqf0g+yYhC9pagTSWsRsRmjiXdS3FtaaMIKfuzO0rv9ZxLsM0n2tGLfCFXMK72jrWRLAC0+fA4G2cq6oPOiCt5rw6J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r4JT3BXO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LvAs18YF+K8bFHmRIIjb3MjNk3UpOvobmOf2MZtyB1c=; b=r4JT3BXOmuxBVyuhOtL6Okus4r
	kUEOpgyjNgd5F7MA+SpV26GDPXQN6y+Pmdl/eHDa9JNO0a0ay70BlMyWjlceC/XeaSaB1nfJjyNO4
	A4Vb9zmRQBnTek5fIPHxjWqWK1Hw+KQdIJKz99H+iSiLiNXOk5fHG4m6f0aeVRu0Qtj0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFFRS-00H282-PO; Thu, 06 Jun 2024 17:54:18 +0200
Date: Thu, 6 Jun 2024 17:54:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	kernel test robot <lkp@intel.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Split out common
 object into module
Message-ID: <66b917d6-3b72-41c5-9e30-e87cf5505729@lunn.ch>
References: <20240606073639.3299252-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606073639.3299252-1-danishanwar@ti.com>

> +EXPORT_SYMBOL_GPL(icssg_class_set_mac_addr);
> +EXPORT_SYMBOL_GPL(icssg_class_disable);
> +EXPORT_SYMBOL_GPL(icssg_class_default);
> +EXPORT_SYMBOL_GPL(icssg_class_promiscuous_sr1);
> +EXPORT_SYMBOL_GPL(icssg_class_add_mcast_sr1);
> +EXPORT_SYMBOL_GPL(icssg_ft1_set_mac_addr);
> +EXPORT_SYMBOL_GPL(prueth_cleanup_rx_chns);
> +EXPORT_SYMBOL_GPL(prueth_cleanup_tx_chns);
> +EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
> +EXPORT_SYMBOL_GPL(prueth_xmit_free);
> +EXPORT_SYMBOL_GPL(prueth_ndev_add_tx_napi);
> +EXPORT_SYMBOL_GPL(prueth_init_tx_chns);
> +EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
> +EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
> +EXPORT_SYMBOL_GPL(icssg_ts_to_ns);
> +EXPORT_SYMBOL_GPL(emac_ndo_start_xmit);
> +EXPORT_SYMBOL_GPL(prueth_rx_irq);
> +EXPORT_SYMBOL_GPL(prueth_emac_stop);
> +EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
> +EXPORT_SYMBOL_GPL(emac_napi_rx_poll);
> +EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
> +EXPORT_SYMBOL_GPL(prueth_reset_tx_chan);
> +EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
> +EXPORT_SYMBOL_GPL(emac_ndo_tx_timeout);
> +EXPORT_SYMBOL_GPL(emac_ndo_ioctl);
> +EXPORT_SYMBOL_GPL(emac_ndo_get_stats64);
> +EXPORT_SYMBOL_GPL(emac_ndo_get_phys_port_name);
> +EXPORT_SYMBOL_GPL(prueth_node_port);
> +EXPORT_SYMBOL_GPL(prueth_node_mac);
> +EXPORT_SYMBOL_GPL(prueth_netdev_exit);
> +EXPORT_SYMBOL_GPL(prueth_get_cores);
> +EXPORT_SYMBOL_GPL(prueth_put_cores);
> +EXPORT_SYMBOL_GPL(prueth_dev_pm_ops);
> +EXPORT_SYMBOL_GPL(icssg_config_ipg);
> +EXPORT_SYMBOL_GPL(icssg_config);
> +EXPORT_SYMBOL_GPL(emac_set_port_state);
> +EXPORT_SYMBOL_GPL(icssg_config_half_duplex);
> +EXPORT_SYMBOL_GPL(icssg_config_set_speed);
> +EXPORT_SYMBOL_GPL(icssg_send_fdb_msg);
> +EXPORT_SYMBOL_GPL(icssg_fdb_add_del);
> +EXPORT_SYMBOL_GPL(icssg_fdb_lookup);
> +EXPORT_SYMBOL_GPL(icssg_vtbl_modify);
> +EXPORT_SYMBOL_GPL(icssg_get_pvid);
> +EXPORT_SYMBOL_GPL(icssg_set_pvid);
> +EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
> +EXPORT_SYMBOL_GPL(icssg_mii_update_mtu);
> +EXPORT_SYMBOL_GPL(icssg_update_rgmii_cfg);
> +EXPORT_SYMBOL_GPL(icssg_rgmii_get_speed);
> +EXPORT_SYMBOL_GPL(icssg_rgmii_get_fullduplex);
> +EXPORT_SYMBOL_GPL(icssg_queue_pop);
> +EXPORT_SYMBOL_GPL(icssg_queue_push);
> +EXPORT_SYMBOL_GPL(emac_stats_work_handler);

Please could you clean up the namespace a little. icssg_ and prueth_
are O.K, but we also have arc/emac_rockchip.c, allwinner/sun4i-emac.c,
ibm/emac/, and qualcomm/emac/ using the emac_ prefix.

Thanks
    Andrew

---
pw-bot: cr

