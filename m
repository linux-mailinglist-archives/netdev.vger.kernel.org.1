Return-Path: <netdev+bounces-48978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355047F0411
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E411C208DB
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541064B;
	Sun, 19 Nov 2023 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEg8ibbj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172615A8;
	Sun, 19 Nov 2023 02:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A473C433C7;
	Sun, 19 Nov 2023 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700361275;
	bh=FAVgax6ky7lNhr5MHl33fP4AwGQUXVpEfHK1wlpTUv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEg8ibbjBFn2NnXoJ9zd8AE9hC41myx+Lc5TVW79GVE8GWEoDk+Mkh2tKgqBV/9of
	 DxFA87szlMVAGuvc5SuDhmmPiHlpHJUI8z/Hhak2LCzJYdTWf7ViLEJv2ffiszJEN+
	 tOqWDPWXqLVDYAd8i11Ui0fGthRbr5VUVSHCNzyxgmx+cbpmlJKhEQQ8SnAUP+PWGt
	 da1O3tVnKH5Uh7H+bDhYhkNHRkUXu0WC4zrjg790wt1Wf7nnllmOWXXiwLfiu/j0Mu
	 +KanU8++AcTWORufVzxrbj9gy2jH3MuxTi2D6cHGJSNrdAXMPiu56NDRC994JRI8mC
	 bkvbjqP+SSuDw==
Date: Sat, 18 Nov 2023 18:34:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231118183433.30ca1d1a@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 12:28:43 +0100 Kory Maincent wrote:
> +	if (!tb[ETHTOOL_A_TS_LAYER])
> +		return 0;

GENL_REQ_ATTR_CHECK(), not sure why anyone would issue this command
without any useful attr.

> +	/* Disable time stamping in the current layer. */
> +	if (netif_device_present(dev) &&
> +	    (dev->ts_layer == PHY_TIMESTAMPING ||
> +	    dev->ts_layer == MAC_TIMESTAMPING)) {
> +		ret = dev_set_hwtstamp_phylib(dev, &config, info->extack);
> +		if (ret < 0)
> +			return ret;

So you only support PHYLIB?

The semantics need to be better documented :(

