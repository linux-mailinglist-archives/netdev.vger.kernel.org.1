Return-Path: <netdev+bounces-48975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4337F0404
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 03:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615EEB2097D
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 02:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E3ED5;
	Sun, 19 Nov 2023 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+vryw99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9BED1;
	Sun, 19 Nov 2023 02:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F09C433C7;
	Sun, 19 Nov 2023 02:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700360667;
	bh=A2sG4uv4+t+pd/QTCq6/w/UMh/HCjsCsXOA1t1utJSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+vryw9990zzwBqHZgv79fhAJVTNX1wE0d3+ewk51TTAkW8JAw74nhzfFPp1cY/tW
	 YI4qGgTOYknTa3PShs1j1tsOgYHi7zsOJTdOzTM8twiyPVITMDj8sc4MVb2z5nJAPW
	 gm5NlwZjk7mqdE9kRxgNgomJLbu6LENSeYOgycntSLuaPCQTcMB1FWZ2tVnkSAC6Ye
	 8Urz1CWf+XbcRMa6zuGCwBMaaXP0GiKXPIT/1+aIFm8GPTJACR4IRbnO5uDndSX+8+
	 BtjAFDs7ab6mtw/g/w0O+rg86Jw8oqpj489Nbg+YldE/k06vRuxAhBekuACzrvPb1p
	 yrZJ4cVrOPhCg==
Date: Sat, 18 Nov 2023 18:24:24 -0800
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
Subject: Re: [PATCH net-next v7 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231118182424.2d569940@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-8-472e77951e40@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 12:28:36 +0100 Kory Maincent wrote:
> +		ops->get_ts_info(dev, &ts_info);
> +		if (ts_info.so_timestamping &
> +		    SOF_TIMESTAMPING_HARDWARE_MASK)
> +			data->ts_layer = MAC_TIMESTAMPING;
> +
> +		if (ts_info.so_timestamping &
> +		    SOF_TIMESTAMPING_SOFTWARE_MASK)
> +			data->ts_layer = SOFTWARE_TIMESTAMPING;

How does this work? so_timestamping is capabilities, not what's
enabled now. So if driver supports SW stamping we always return
SOFTWARE?

