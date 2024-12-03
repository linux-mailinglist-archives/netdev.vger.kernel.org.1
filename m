Return-Path: <netdev+bounces-148403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40D9E15CD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EBC161307
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132C1D5AC0;
	Tue,  3 Dec 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ApT+Kb6p"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422043F8F7;
	Tue,  3 Dec 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214636; cv=none; b=X44rpxUqZtq4dkle7X4h3RJpav5bYKjlmYVtnLvCoahNuE1uqeWkjAl/+0hxDwSBe/YoS9ibpRPyWmsQVbSWrm/cLxKf/azLZ6yUsLM8ILPaiTj3eP72UPh1+xquGalTBDzTADaow3+Zi0FCc7j26BWjmX+hRU8/v14kbRsxEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214636; c=relaxed/simple;
	bh=lLJWoGA5mgYfeIf4wHZFTqCgIgZq+Y5pKhmZrIUvxi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4hGtjdQx8nrwGLWcMWh+0R2yW9qln6I3tAkz/nSvAJI6jVE27XwuQYUbRqdu/5LGtbXfpia3etompkLOpxt7Dbqr20iYwYSDT94dTk8IJmptkhkVnjb+QxiBu6G/ISXDBnSUoJeXplKqcmr9kdpe466tg6zSYNrWexQXV9Z54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ApT+Kb6p; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12D08FF805;
	Tue,  3 Dec 2024 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733214631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuM3/oVKujOATxnTbh+v+qkfvawpHs2T6Z0xs87aRjs=;
	b=ApT+Kb6pBSoGn6KFGsCfFuN1b/F+Nn3onYhsoClioTIM9NVAs/80dl5zTMYeuLWB1vaZyv
	hdUuwEyQ2Tfd3n1gaY0ixl/qSUSJM+eC7tgc+kc1Pd59Xqc5w+TsLGqkKdTvjjwgYURjAH
	okKd/TddEU2aHnubDBKtL8epjIZlqOrF4x/LSrS7DEIFQFSRqF1eHb9FIz2g+ap6RXMmO/
	vCC4JeGQwrMJuSrO/drXnvlqwS6OliPBrsEvv3TdQ16vt5AEZdoIR4FkOvVqEjfcDLF/AX
	cScS0y2kx9z3rqjq7H/0CVPsQ6kaTmwk6WmNy3tL9v6CMeqUCMlD6/5XSbEmpA==
Date: Tue, 3 Dec 2024 09:30:29 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20241203093029.60c8b94b@fedora.home>
In-Reply-To: <20241203075622.2452169-2-o.rempel@pengutronix.de>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
	<20241203075622.2452169-2-o.rempel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Oleksij,

On Tue,  3 Dec 2024 08:56:15 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> From: Jakub Kicinski <kuba@kernel.org>
> 
> Feed the existing IEEE PHY counter struct (which currently
> only has one entry) and link stats into the PHY driver.
> The MAC driver can override the value if it somehow has a better
> idea of PHY stats. Since the stats are "undefined" at input
> the drivers can't += the values, so we should be safe from
> double-counting.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

[...] 

> +static void
> +ethtool_get_phydev_stats(struct net_device *dev,
> +			 struct linkstate_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev)
> +		return;
> +
> +	if (dev->phydev)
> +		data->link_stats.link_down_events =
> +			READ_ONCE(dev->phydev->link_down_events);
> +
> +	if (!phydev->drv || !phydev->drv->get_link_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_link_stats(phydev, &data->link_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
>  static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>  				  struct ethnl_reply_data *reply_base,
>  				  const struct genl_info *info)
> @@ -127,9 +148,7 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
>  			   sizeof(data->link_stats) / 8);
>  
>  	if (req_base->flags & ETHTOOL_FLAG_STATS) {
> -		if (dev->phydev)
> -			data->link_stats.link_down_events =
> -				READ_ONCE(dev->phydev->link_down_events);
> +		ethtool_get_phydev_stats(dev, data);

I'm sorry to bother you with my multi-phy stuff, but I'd like to avoid
directly accessing netdev->phydev at least in the netlink code.

Could it be possible for you to pass a phydev directly to the
ethtool_get_phydev_stats() helper you're creating ? That way, you could
get the stats from other phydevs on the link if userspace passed a phy
index in the netlink header. You'd get the phydev that way :

phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_LINKSTATE_HEADER,], info->extack);

This is what's done in the pse-pd, plca and cabletest netlink code that
deals with phydevs.

Note that this helper will fallback to netdev->phydev if user didn't
pass any PHY index, which I expect to be what people do most of the
time. However should the netdev have more than 1 PHY, we would be able
to get the far-away PHY's stats :)

>  
>  		if (dev->ethtool_ops->get_link_ext_stats)
>  			dev->ethtool_ops->get_link_ext_stats(dev,
> diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
> index 912f0c4fff2f..cf802b1cda6f 100644
> --- a/net/ethtool/stats.c
> +++ b/net/ethtool/stats.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> +#include <linux/phy.h>
> +
>  #include "netlink.h"
>  #include "common.h"
>  #include "bitset.h"
> @@ -112,6 +114,19 @@ static int stats_parse_request(struct ethnl_req_info *req_base,
>  	return 0;
>  }
>  
> +static void
> +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> +{
> +	struct phy_device *phydev = dev->phydev;
> +
> +	if (!phydev || !phydev->drv || !phydev->drv->get_phy_stats)
> +		return;
> +
> +	mutex_lock(&phydev->lock);
> +	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
> +	mutex_unlock(&phydev->lock);
> +}
> +
>  static int stats_prepare_data(const struct ethnl_req_info *req_base,
>  			      struct ethnl_reply_data *reply_base,
>  			      const struct genl_info *info)
> @@ -145,6 +160,10 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
>  	data->ctrl_stats.src = src;
>  	data->rmon_stats.src = src;
>  
> +	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
> +	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		ethtool_get_phydev_stats(dev, data);

Same here :)

Thanks,

Maxime

