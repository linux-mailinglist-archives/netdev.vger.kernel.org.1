Return-Path: <netdev+bounces-101242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDF8FDD11
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ADD1C2210B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4E24B2F;
	Thu,  6 Jun 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWXqoDYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6417BD8;
	Thu,  6 Jun 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642804; cv=none; b=YRl0u0jLh198jJuujjeITdusRsTA8pgMwBw9oL/QY1NVN7lkpB4Co18ZWPWUgmVp7R8/eLAYuKr5m/ZT9R4U3HM8LtJcdjp/XB2b9Da5CknxUB0L2YVw0uKcpmUjXd/fzGW0q94l/8xsaV4BsJhVw4bPfw1yvZio9SZTo82mhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642804; c=relaxed/simple;
	bh=1k0vmlN5n/kux90nXyjEzbw+QNgng6TYrod+njG2UsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpQyX0L+HOA2epZ/XnXDztX8y1QHr5cHR/C8ZMD51FZCJ8pcz6iWw9SCFvBntTIVjsMr+xlFTZ9HX/mz1OFKojh9y1nUMcUA5MORFk2FQcHa38u8UDyEStjoWiIURqUFqqzIK+rID7dQMo9jRrYyqW+SJyxFCq1d2S4/eONjxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWXqoDYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7425DC4AF16;
	Thu,  6 Jun 2024 03:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717642803;
	bh=1k0vmlN5n/kux90nXyjEzbw+QNgng6TYrod+njG2UsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWXqoDYURT10XZqAX+dQkQRcM4PA4VO2uRDW49mqGc2E9PsgWIFYFW0b01KJNpjSV
	 Kl1/yrj4VwS2NILpQkbqmAK1C78OAYjWWjo8adtGntftTxeS4EALNHD/59Ok7Ljjmg
	 Zgo8vVRcgtts15Z12WdN3dlSltCwGOFpyPsaiq9a4f3b7Pl3MkTD9OlhROx2Qh0/U1
	 XaUJ+OccXAl87VBqKoyNyPIt0HZLvHEXiPzXHZWSESj9d61CdmwcYzCxcpYJp0yf1G
	 a/lJdNkBQ1RQD/PvYzdbig30hv1dIZgA6dLiz15Omhn/KhraBFm+P/kcwWaT6UqEK/
	 axahNBtQJAdcg==
Date: Wed, 5 Jun 2024 20:00:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net dsa: qca8k: fix usages of
 device_get_named_child_node()
Message-ID: <20240605200002.2b046013@kernel.org>
In-Reply-To: <20240604161551.2409910-1-andriy.shevchenko@linux.intel.com>
References: <20240604161551.2409910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 19:15:51 +0300 Andy Shevchenko wrote:
> @@ -431,8 +431,10 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
>  		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
>  						 priv->internal_mdio_bus->id,
>  						 port_num);
> -		if (!init_data.devicename)
> +		if (!init_data.devicename) {
> +			fwnode_handle_put(leds);
>  			return -ENOMEM;
> +		}
>  
>  		ret = devm_led_classdev_register_ext(priv->dev, &port_led->cdev, &init_data);
>  		if (ret)

I think there's more bugs in this here loop, if we break or return
during fwnode_for_each_child_node() - we need to put the iterator (led).

