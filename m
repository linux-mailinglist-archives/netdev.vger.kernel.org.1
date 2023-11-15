Return-Path: <netdev+bounces-48156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C714B7ECA69
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715A41F28267
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A1364A8;
	Wed, 15 Nov 2023 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7hagV6Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FC3DBBF;
	Wed, 15 Nov 2023 18:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8FAC433C8;
	Wed, 15 Nov 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700072344;
	bh=eU8VRI5fJn+sZhMvBxa7JGVZvziW9p/UioRXXO8E7O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7hagV6YqD6T5UB6NLTwzcYXzJgaClLID3j2jf6CM6YHdE1xA3rBpEQje3Vf6inB2
	 AMVQa7+fBTiFzyI0MxKW7yfuJ+oISjiDtnaeXMvEOX4oonXlqDdJHh09xarfWbYoPZ
	 5c924RBeBQT9tPEErHqSbL6a3qcDjhLu3U13uSm1Jg/88TdGsBTeVp1CDyVRRNTJuX
	 M0ypqhcAzRCDcvEyTVCt4kq9LcGUUOX7JtqdRXnrO299+cqu3EwBbxeH9UfRpMam2Q
	 PaK0+HWWxd5KTfGdkU3J7WpY4Xl6FH7T8LPkSMeJOhUFhs5Yj5FUD+9V1cmFLrqDue
	 pSDd+gFT7tvVQ==
Date: Wed, 15 Nov 2023 18:18:58 +0000
From: Simon Horman <horms@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 4/8] net: qualcomm: ipqess: Add Ethtool ops
 to IPQESS port netdevices
Message-ID: <20231115181858.GY74656@kernel.org>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-5-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-5-romain.gantois@bootlin.com>

On Tue, Nov 14, 2023 at 11:55:54AM +0100, Romain Gantois wrote:
> The IPQESS driver registers one netdevice for each front-facing switch
> port. Add support for several ethtool operations to these netdevices.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Hi Romain,

some more minor feedback from my side.

> ---
>  drivers/net/ethernet/qualcomm/ipqess/Makefile |   2 +-
>  .../ethernet/qualcomm/ipqess/ipqess_ethtool.c | 245 ++++++++++++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_port.c    |   1 +
>  .../ethernet/qualcomm/ipqess/ipqess_port.h    |   3 +
>  4 files changed, 250 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c

...

> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c

...

> +static int ipqess_port_set_eee(struct net_device *dev, struct ethtool_eee *eee)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	int ret;
> +	u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port->index);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 lpi_ctl1;

nit: Please consider using reverse xmas tree - longest line to shortest -
     for local variable declarations in networking code.

> +
> +	/* Port's PHY and MAC both need to be EEE capable */
> +	if (!dev->phydev || !port->pl)
> +		return -ENODEV;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	lpi_ctl1 = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &lpi_ctl1);
> +	if (lpi_ctl1 < 0) {

lpi_ctl1 is unsigned, it can never be less than zero.

As flagged by Smatch and Coccinelle.

I think this should probably be (completely untested!):

	ret = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &lpi_ctl1);
	if (ret < 0) {

Which would also resolve the issue immediately below too.

> +		mutex_unlock(&priv->reg_mutex);
> +		return ret;

It seems that ret is used uninitialised here.

Flagged by clang-16 W=1 builds.

> +	}

...

