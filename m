Return-Path: <netdev+bounces-180943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD5A83359
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E4A1891C2E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0821481D;
	Wed,  9 Apr 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WK7GO7rw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978B1E0DFE;
	Wed,  9 Apr 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233979; cv=none; b=piz2Bx7T9QNqND4Sx3eiQm/Wt7iEbxSQEbEfnQ2o1xSkj4a+h7bbk00zDlfLQcEPJaO2rRA0hVlqiouxM7xvu54FSZ8uiMdM19ckOWkQnc8XBLdutKKzTVuBUUbgorAUE5OrDSOYZ/lHvUYpli9toAu/gz5BNgJkyisv3ceZV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233979; c=relaxed/simple;
	bh=HCT2J58XuVwyOeRbcEAzik/3vDnC8KMZUY5rshQ3O04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5c7c1Om/LKvE5e1U1wFkBGrQ0mU42H7RoI6pSp98cP8XsDVExijalxBzFfU+ZSeuc2JK0p7qRRBizezNTaZnDiflfsU03cqUz75myroj5SleqDQTiRL8q1utWvFBNW4tUTXztZguUALCo3UOTgo1otL4vudmk/rcMYsm8bi7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WK7GO7rw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E/MX9avaogn96WadiZO2Oqso/YPMCh/5um7QBJv0kHw=; b=WK7GO7rwpGDxsAOictNGBcT49S
	QMp9vX/ibb/xLjVw8hKqAmC0QTtJRz1I0s9PS0DteFgDvqAT+KUunoRP1mJWNUa+wqyPL7QRVyad1
	YMwdGitlQgnq1kL+JdmSTav2OmngAkPzVPqagj83eIpJJA9OJeCh6NF5CtaGbyNcof+w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2cvw-008b6l-9k; Wed, 09 Apr 2025 23:26:08 +0200
Date: Wed, 9 Apr 2025 23:26:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [net-next v4 4/5] net: mtip: The L2 switch driver for imx287
Message-ID: <cab89673-6126-43ff-b7eb-1f311fa4498b@lunn.ch>
References: <20250407145157.3626463-1-lukma@denx.de>
 <20250407145157.3626463-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407145157.3626463-5-lukma@denx.de>

> +static int mtip_ndev_port_link(struct net_device *ndev,
> +			       struct net_device *br_ndev,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
> +	struct switch_enet_private *fep = priv->fep;
> +	struct net_device *other_ndev;
> +
> +	/* Check if one port of MTIP switch is already bridged */
> +	if (fep->br_members && !fep->br_offload) {
> +		/* Get the second bridge ndev */
> +		other_ndev = fep->ndev[fep->br_members - 1];
> +		other_priv = netdev_priv(other_ndev);
> +		if (other_priv->master_dev != br_ndev) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "L2 offloading only possible for the same bridge!");
> +			return notifier_from_errno(-EOPNOTSUPP);

This is not an error condition as such. The switch cannot do it, so
-EOPNOTSUPP is correct, but the Linux software bridge can, and it
will. So there is no need to use NL_SET_ERR_MSG_MOD().


> +		}
> +
> +		fep->br_offload = 1;
> +		mtip_switch_dis_port_separation(fep);
> +		mtip_clear_atable(fep);
> +	}
> +
> +	if (!priv->master_dev)
> +		priv->master_dev = br_ndev;
> +
> +	fep->br_members |= BIT(priv->portnum - 1);
> +
> +	dev_dbg(&ndev->dev,
> +		"%s: ndev: %s br: %s fep: 0x%x members: 0x%x offload: %d\n",
> +		__func__, ndev->name,  br_ndev->name, (unsigned int)fep,
> +		fep->br_members, fep->br_offload);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void mtip_netdevice_port_unlink(struct net_device *ndev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(ndev);
> +	struct switch_enet_private *fep = priv->fep;
> +
> +	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n", __func__,
> +		ndev->name, fep->br_members);
> +
> +	fep->br_members &= ~BIT(priv->portnum - 1);
> +	priv->master_dev = NULL;
> +
> +	if (!fep->br_members) {
> +		fep->br_offload = 0;
> +		mtip_switch_en_port_separation(fep);
> +		mtip_clear_atable(fep);
> +	}

This does not look quite correct. So you disable port separation once
both ports are a member of the same bridge. So you should enable port
separation as soon as one leaves. So if fep->br_members has 0 or 1
bits set, you need to enable port separation.

	Andrew

