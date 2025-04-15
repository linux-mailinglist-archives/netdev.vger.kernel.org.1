Return-Path: <netdev+bounces-183000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D09A8A8A4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1087A160E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28306252281;
	Tue, 15 Apr 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h09IQpYj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8025178B;
	Tue, 15 Apr 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747086; cv=none; b=hNTYD8kYyf3FDVLnZn6NQfs10aswKONWs0CNSyFOmdJCJxnLd3oRoUoLzPNsLD62zugFrLBPQ4oqOZ0RYyaeTN7XpyL21JSeG/tYzmFauoFmuoxvzGyeE+kWHDaP00pp9hEzPTN2ESfch5ItAVazV4pFEs4m7nE53uRh5iFvcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747086; c=relaxed/simple;
	bh=HMRkle/AiWybWCgX3nSxjTcfvrJVFoMThLVLvEnydHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYUoR5kdNf2PPLUb5T/v2Jj2Dx3Cg+Ya7J6Aj298blqQm15bnbX1+RpyF5MEj7sITuPVlzDxLN3fVVpblQTvFqe2pJni+MvFJzbYN2BicmJIosrmVj6Qg6Wyug+7sJ8cL3tzQipNMk4jTVKQp5AFRcPmM5TAnSYXuuX3XQleH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h09IQpYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A05CC4CEE7;
	Tue, 15 Apr 2025 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744747085;
	bh=HMRkle/AiWybWCgX3nSxjTcfvrJVFoMThLVLvEnydHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h09IQpYjSGa61AoVG6uQFOfNU25QiDXtTZT7efpfcpzGvO3nZJdjvoZBcBksTwxTs
	 E3zy0YGBDn2cDz5YfYBnlXe6HzQuAkIdKG0UgZo4oLD+/f5Ti1ONfspH307b65JVAo
	 /F570dLJ7/WjKGgg693TirWeliq+1WsRJgg9WY91ucOF8fGFpjVvc++TWGUU/jjKjS
	 lbLvUtBd8AMjlC8KZc9uv0d6AEebe/k65dci1J8XpQOd86uhlXAPJ0eUd8RUWlZwPf
	 FcUiDrWND4WreM58gGaD3UlSdHqwsIBEIOfwGuZnjeealU/sipyV7A3dWoWCGKPWUb
	 iTUfSVXexX3gg==
Date: Tue, 15 Apr 2025 20:57:56 +0100
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	tony@atomide.com, richardcochran@gmail.com, glaroque@baylibre.com,
	schnelle@linux.ibm.com, m-karicheri2@ti.com, s.hauer@pengutronix.de,
	rdunlap@infradead.org, diogo.ivo@siemens.com, basharath@couthit.com,
	jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 07/11] net: ti: prueth: Adds support for
 network filters for traffic control supported by PRU-ICSS
Message-ID: <20250415195756.GI395307@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com>
 <20250414130237.1915448-8-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414130237.1915448-8-parvathi@couthit.com>

On Mon, Apr 14, 2025 at 06:32:33PM +0530, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Driver updates to enable/disable network filters and traffic control
> features supported by the firmware running on PRU-ICSS.
> 
> Control of the following features are now supported:
> 1. Promiscuous mode
> 2. Network Storm prevention
> 3. Multicast filtering and
> 4. VLAN filtering
> 
> Firmware running on PRU-ICSS will go through all these filter checks
> prior to sending the rx packets to the host.
> 
> Ethtool or dev ioctl can be used to enable/disable these features from
> the user space.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>

...

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_dos.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_dos.c

...

> +static int icssm_emac_configure_clsflower(struct prueth_emac *emac,
> +					  struct flow_cls_offload *cls)
> +{
> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
> +	struct netlink_ext_ack *extack = cls->common.extack;
> +	const struct flow_action_entry *act;
> +	int i;
> +
> +	flow_action_for_each(i, act, &rule->action) {
> +		switch (act->id) {
> +		case FLOW_ACTION_POLICE:
> +			return icssm_emac_flower_parse_policer
> +				(emac, extack, cls,
> +				 act->police.rate_bytes_ps);
> +		default:
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Action not supported");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +	return -EOPNOTSUPP;

nit: This line cannot be reached.
     I think you can just remove it.

     Flagged by Smatch.

> +}

...

