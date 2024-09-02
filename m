Return-Path: <netdev+bounces-124161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4B96857E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC506288059
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90C1D2F60;
	Mon,  2 Sep 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frZjQsXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E521D2F4A;
	Mon,  2 Sep 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274639; cv=none; b=PTjr3otHdZhxlI8ESOFPraAVTqxRg2C/ctIR0h4KpDsc6CHEOO9L9r//onCQV8dgOiAMXdCdLF1Vy542ptYncbCYy3/FuR8RG4B/gGlijdpz+Ugmk+zBq/JzLkgGukk+xkm1XQd9ALpK2yaaBONzyp/e/rEsWw4EHVkE7yYP+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274639; c=relaxed/simple;
	bh=pe2+YVpcPCEGBw7dXpbzrFvyMUWq05N49C+gayZKyDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcTjtetuGBFV55+SMrJXuzbdUyR2GUqy5VfmOPPuf4Uzea+Q0FoHqHvoQZGYny2leT9NEWfB4fwBrGyJf2oJD0q/NrC5Amn4PADgeyX6E+x6atZ8+3TzDQ3COEkk6svHb+1LdLOdDbpMXoqr0dei1fkN8TSP+SiroOO/kZQ3/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frZjQsXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE23C4CEC2;
	Mon,  2 Sep 2024 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725274638;
	bh=pe2+YVpcPCEGBw7dXpbzrFvyMUWq05N49C+gayZKyDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frZjQsXHnAbljS1NUeUtoOLs3pmN28Zy3MCS+V7FV7p5qtWD2ksJZ5iL7E+UQfsC2
	 +G51RPigBC5OEA/dZxSgwA3AirzCaxHomUswkyvOwcoRQp8w4PhxxZqntWY/RR6KZb
	 PRV0pX7qxv9OLFH1poEflJmLfcynGAnSIYVmC78s+Q7YyD5wsMSY0jjDcyBhKp+tgg
	 lSX/Kb9TT005DrypYF0bQRWgEbfvynixCfZrYskWfBpzRQmH2sCHor/deel0360NLw
	 LzJBd9b/9zr7fY6+c4zOxK6OugG+i76S9w5dkVbIgl5bBjNhJMqFNGrTWseTc0Qywc
	 uowsrnk8WOz9w==
Date: Mon, 2 Sep 2024 11:57:14 +0100
From: Simon Horman <horms@kernel.org>
To: Wan Junjie <junjie.wan@inceptio.ai>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <20240902105714.GH23170@kernel.org>
References: <20240902015051.11159-1-junjie.wan@inceptio.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902015051.11159-1-junjie.wan@inceptio.ai>

On Mon, Sep 02, 2024 at 09:50:51AM +0800, Wan Junjie wrote:
> Currently, dpaa2 switch only cares dst mac and egress interface
> in FDB. And all ports with different vlans share the same FDB.
> 
> This will make things messed up when one device connected to
> dpaa2 switch via two interfaces. Ports get two different vlans
> assigned. These two ports will race for a same dst mac entry
> since multiple vlans share one FDB.
> 
> FDB below may not show up at the same time.
> 02:00:77:88:99:aa dev swp0 self
> 02:00:77:88:99:aa dev swp1 self
> But in fact, for rules on the bridge, they should be:
> 02:00:77:88:99:aa dev swp0 vlan 10 master br0
> 02:00:77:88:99:aa dev swp1 vlan 20 master br0
> 
> This patch address this by borrowing unused form ports' FDB
> when ports join bridge. And append offload flag to hardware
> offloaded rules so we can tell them from those on bridges.
> 
> Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>

Hi Wan Junjie,

Some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index a293b08f36d4..217c68bb0faa 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -25,8 +25,17 @@
>  
>  #define DEFAULT_VLAN_ID			1
>  
> -static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
> +static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)

This, and several other lines in this patch, could be trivially
line wrapped in order for them to be <= 80 columns wide, as is
still preferred in Networking code.

This and a number of other minor problems are flagged by:
./scripts/checkpatch.pl --strict --codespell --max-line-length=80

>  {
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	int i;
> +
> +	if (port_priv->fdb->bridge_dev) {
> +		for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
> +			if (ethsw->fdbs[i].vid == vid)
> +				return ethsw->fdbs[i].fdb_id;
> +	}
> +	/* Default vlan, use port's fdb id directly */
>  	return port_priv->fdb->fdb_id;
>  }
>  

...

> @@ -191,10 +212,38 @@ static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
>  static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
>  {
>  	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct net_device *netdev = port_priv->netdev;
> +	struct dpsw_fdb_cfg fdb_cfg = {0};
>  	struct dpsw_vlan_cfg vcfg = {0};
> +	struct dpaa2_switch_fdb *fdb;
> +	u16 fdb_id;
>  	int err;
>  
> -	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	/* If ports are under a bridge, then
> +	 * every VLAN domain should use a different fdb.
> +	 * If ports are standalone, and
> +	 * vid is 1 this should reuse the allocated port fdb.
> +	 */
> +	if (port_priv->fdb->bridge_dev) {
> +		fdb = dpaa2_switch_fdb_get_unused(ethsw);
> +		if (!fdb) {
> +			/* if not available, create a new fdb */
> +			err = dpsw_fdb_add(ethsw->mc_io, 0, ethsw->dpsw_handle,
> +					   &fdb_id, &fdb_cfg);
> +			if (err) {
> +				netdev_err(netdev, "dpsw_fdb_add err %d\n", err);
> +				return err;
> +			}

fdb is still NULL here. Based on my reading of dpaa2_switch_port_init()
I think you need the following. Possibly also with an error check.

			fdb = dpaa2_switch_fdb_get_unused(ethsw);

Flagged by Smatch.

> +			fdb->fdb_id = fdb_id;
> +		}
> +		fdb->vid = vid;
> +		fdb->in_use = true;
> +		fdb->bridge_dev = NULL;
> +		vcfg.fdb_id = fdb->fdb_id;
> +	} else {
> +		/* Standalone, port's private fdb shared */
> +		vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> +	}
>  	err = dpsw_vlan_add(ethsw->mc_io, 0,
>  			    ethsw->dpsw_handle, vid, &vcfg);
>  	if (err) {

...

-- 
pw-bot: cr

