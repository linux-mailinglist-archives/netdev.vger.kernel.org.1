Return-Path: <netdev+bounces-98344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845028D101B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396121F21EDA
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53E1667E0;
	Mon, 27 May 2024 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TG3kesYE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352052F6D;
	Mon, 27 May 2024 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848084; cv=none; b=TTlIupnyufbY18xKfTNLEYOoqq3qsjQ46LWVLiNNXz4OGriap31xGV3HGZLK+csaFkt3MEN3ntPjwY3/rtSti3CjQ8NKOYQEYe6spfTMxQdfxurB1TlS8tXT/K1i7zPC0H1bRzIzLmwqYkY9AFLYdz4NJB3OMqC+2d1nQkGBm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848084; c=relaxed/simple;
	bh=MNJ7EaOmKWZ5jc1RxL7pDjEITEQqmj2VizO//tduxEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c36RrasjkdRAkF1AMWfJYrDhLsIy080SmxxIi7uYk0GMaq5jnSbfiGcqHwog7zzDioWJ43xVlGZs8w7jNjyiT1Q2XTBekHTrx6YwIQe0EHdsrIh7Q1qvJG90TkRq9jLNMflTgg3sdIGMjJcoFoRee6YWAhTlzOionkslvbqnM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TG3kesYE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P3m1mGGdZuBlv9pNaAOCADsgv4akQAfs3EJqTNO+jgw=; b=TG3kesYEvm/+2MM7UvfaDRcasQ
	NTFdblKpqDjecRvPwAGqBOR9GwxO4LryY2Gru3qkY2ORNjvgXDlGF2Fi+S/bpcbqUqetdcrtF0xhc
	eou1LE0qZxiEwW6PpFFuPWplSOCjp9T6PAXowj55gsaphPh7qzv2Cr1Awvf3EpEBwAAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBibq-00G6o7-9u; Tue, 28 May 2024 00:14:26 +0200
Date: Tue, 28 May 2024 00:14:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
Message-ID: <4f5a6d1b-e209-45b1-acec-ce84ca1c856f@lunn.ch>
References: <20240527052738.152821-1-danishanwar@ti.com>
 <20240527052738.152821-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527052738.152821-4-danishanwar@ti.com>

On Mon, May 27, 2024 at 10:57:38AM +0530, MD Danish Anwar wrote:
> Add support for ICSSG switch firmware using existing Dual EMAC driver
> with switchdev.
> 
> Limitations:
> VLAN offloading is limited to 0-256 IDs.
> MDB/FDB static entries are limited to 511 entries and different FDBs can
> hash to same bucket and thus may not completely offloaded
> 
> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
> 
> Switch to ICSSG Switch mode:
>  ip link add name br0 type bridge
>  ip link set dev eth1 master br0
>  ip link set dev eth2 master br0
>  ip link set dev br0 up
>  bridge vlan add dev br0 vid 1 pvid untagged self
> 
> Going back to Dual EMAC mode:
> 
>  ip link set dev br0 down
>  ip link set dev eth1 nomaster
>  ip link set dev eth2 nomaster
>  ip link del name br0 type bridge
> 
> By default, Dual EMAC firmware is loaded, and can be changed to switch
> mode by above steps
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>  static int prueth_emac_buffer_setup(struct prueth_emac *emac)
>  {
>  	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
> @@ -321,25 +401,63 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>  	/* When the device is configured as a bridge and it is being brought
>  	 * back to the emac mode, the host mac address has to be set as 0.
>  	 */
> +	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
> +	int i;
>  	u8 mac[ETH_ALEN] = { 0 };

nitpick: Reverse Christmas tree

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

