Return-Path: <netdev+bounces-122535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CCA961998
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B927E28520B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2941D3652;
	Tue, 27 Aug 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b700Y3GG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439B1C8FC4;
	Tue, 27 Aug 2024 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795870; cv=none; b=Fw9ORS69vKLOI9EOgPzHmBl2ZcdmiuVfWTlUMZl+1N853HIdWV/e6hfsUGej8j6jVsO05XqsOCEQMzDVd28jg9DQjA0Wgay6PLuSurCLXAsiNBdMbsKS2ymWqIU4tmR6c3AcMLMFGP8WLRLLZ3PDnjszSuuh5LifLcAyTOsOTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795870; c=relaxed/simple;
	bh=FfRIwOus6MnmzuKy/FXlZuQ4jG+LgSupN3ucCrt/zlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVENwfNOGAEteSGrf63K0PSE4KFyUVG4wFmXOfaj2fXIF0OFo2Jj56HDPii8zd1cqv3dMvHAlTe79YjmjH0hP2PM+epm5OcGQ29Jfm4XJ9hbCVnVUT5da41WJBASg5mmInn+oGFJ0Q6UTe4RAs4eqoF9QfIBGAXVtllXe5W/n+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b700Y3GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5128DC32786;
	Tue, 27 Aug 2024 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724795869;
	bh=FfRIwOus6MnmzuKy/FXlZuQ4jG+LgSupN3ucCrt/zlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b700Y3GGcYwmqZSXGPYbcTUtgF8i+iNODALS5eoh4Be6FoFuRo9LM5b+T8X8E47CX
	 iFQ6Zr1ZT46OiIVSSKfeDMGgknlbr+nZVxDAl278Hvndph6gTav04as8BCOSnYRyta
	 DdGuOAaJ1fV3SfwnpYKp1VxKASmt3+s8x4FVg2MKygoZ2kXH/tyM1hnPxOaVNwnTrj
	 wT4GH5pfTwHDjCpQOevu1G04jMi8HZROn/1Mbt+SFnuDq9M5p8wCBwaddJtx95Dg5B
	 PRjRmvZH1Gd01F3HTdSVUTLQrQWs2KfWUv5A/7A/SoZb00qeG88+OzbAvEHx06teCj
	 FvmVOn9M13gmA==
Date: Tue, 27 Aug 2024 14:57:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wan Junjie <junjie.wan@inceptio.ai>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <20240827145748.1ddf0ff7@kernel.org>
In-Reply-To: <20240827110855.3186502-1-junjie.wan@inceptio.ai>
References: <20240827110855.3186502-1-junjie.wan@inceptio.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Lots of small coding issues here..

On Tue, 27 Aug 2024 19:08:55 +0800 Wan Junjie wrote:
> +	/* Default vlan, use port's fdb id directly*/

add space at the end of the comment

> @@ -126,16 +135,28 @@ static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
>  					   struct dpsw_egress_flood_cfg *cfg)
>  {
>  	int i = 0, j;

no need to init i any more

> +	u16 vid = 4096;

reorder the variable declarations, they should be sorted longest to
shortest

>  	memset(cfg, 0, sizeof(*cfg));
>  
> +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
> +		if (ethsw->fdbs[i].fdb_id == fdb_id) {
> +			vid = ethsw->fdbs[i].vid;
> +			break;
> +		}
> +	}

> @@ -155,7 +176,7 @@ static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
>  static int dpaa2_switch_fdb_set_egress_flood(struct ethsw_core *ethsw, u16 fdb_id)
>  {
>  	struct dpsw_egress_flood_cfg flood_cfg;
> -	int err;
> +	int err, i;

unused

>  	/* Setup broadcast flooding domain */
>  	dpaa2_switch_fdb_get_flood_cfg(ethsw, fdb_id, DPSW_BROADCAST, &flood_cfg);

> +	err = dpaa2_switch_fdb_set_egress_flood(ethsw, vcfg.fdb_id);
> +	if (err)
> +		return err;
> +
>  	return 0;

	return dpaa2_switch_fdb_set_egress_flood(ethsw, vcfg.fdb_id);


> +	/* mark fdb as unsued for this vlan */
> +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
> +		fdb = ethsw->fdbs;
> +		if (fdb[i].vid == vid) {
> +			fdb[i].in_use = false;
> +		}

no need for {} in case of the 'if'

>  static void dpaa2_switch_port_fast_age(struct ethsw_port_priv *port_priv)
>  {
> -	dpaa2_switch_fdb_iterate(port_priv,
> -				 dpaa2_switch_fdb_entry_fast_age, NULL);
> +	u16 vid;
> +
> +	for (vid = 0; vid <= VLAN_VID_MASK; vid++) {
> +		if (port_priv->vlans[vid] & ETHSW_VLAN_MEMBER) {
> +			dpaa2_switch_fdb_iterate(port_priv,
> +						 dpaa2_switch_fdb_entry_fast_age, NULL);
> +		}

same here

> +	}
>  }
>  
>  static int dpaa2_switch_port_vlan_add(struct net_device *netdev, __be16 proto,
> @@ -1670,10 +1752,24 @@ static int dpaa2_switch_port_attr_stp_state_set(struct net_device *netdev,
>  	return err;
>  }
>  
> +static int dpaa2_switch_port_flood_vlan(struct net_device *vdev, int vid, void *arg)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(arg);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +
> +	if (!vdev)
> +		return -ENODEV;
> +
> +	return dpaa2_switch_fdb_set_egress_flood(ethsw,
> +						  dpaa2_switch_port_get_fdb_id(port_priv, vid));

save the return value of dpaa2_switch_port_get_fdb_id(port_priv, vid)
to a temp variable, avoid long lines

> +}


> @@ -1681,6 +1777,12 @@ static int dpaa2_switch_port_flood(struct ethsw_port_priv *port_priv,
>  	if (flags.mask & BR_FLOOD)
>  		port_priv->ucast_flood = !!(flags.val & BR_FLOOD);
>  
> +	/* Recreate the egress flood domain of every vlan domain */
> +	err = vlan_for_each(netdev, dpaa2_switch_port_flood_vlan, netdev);
> +	if (err)
> +		netdev_err(netdev, "Unable to restore vlan flood err (%d)\n", err);
> +		return err;

and here you're missing brackets :S

>  	return dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
>  }
>  
-- 
pw-bot: cr

