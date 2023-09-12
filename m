Return-Path: <netdev+bounces-33320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF51B79D64E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8928C2816CD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84D19BBF;
	Tue, 12 Sep 2023 16:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CD18C3F
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:29:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC33137;
	Tue, 12 Sep 2023 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mtkXtIv3OUtKqJKyazqR9g5lFZj/7Eeun1nxUSl1J7Y=; b=iCv/aWLXL5VPfYV2B2qrnGPIYU
	zYLjJvgBWf+losG8UneSRGCfycDkV6omw+JbZCsxZMhnIWVl7euKI6oKyZQb0hhAOmnYxk4TDDpvV
	QpFasjd1rhRueVvv/EOwSVJOuAdDFqsuPyiininZK9zKDMyd2DAB92KbmPadKRI1N1sU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qg6Gi-006FSj-N1; Tue, 12 Sep 2023 18:29:40 +0200
Date: Tue, 12 Sep 2023 18:29:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 4/7] net: ethtool: add a netlink command to
 list PHYs
Message-ID: <df90eb1f-fab1-408d-af8d-fc620f505522@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-5-maxime.chevallier@bootlin.com>

> +static int phy_list_fill_reply(struct sk_buff *skb,
> +			       const struct ethnl_req_info *req_base,
> +			       const struct ethnl_reply_data *reply_base)
> +{
> +	const struct phy_list_reply_data *data = PHY_LIST_REPDATA(reply_base);
> +
> +	if (nla_put_u8(skb, ETHTOOL_A_PHY_LIST_COUNT, data->n_phys))
> +		return -EMSGSIZE;
> +
> +	if (!data->n_phys)
> +		return 0;
> +
> +	if (nla_put(skb, ETHTOOL_A_PHY_LIST_INDEX, sizeof(u32) * data->n_phys,
> +		    data->phy_indices))
> +		return -EMSGSIZE;
> +

Can we add additional information here to allow mapping to what is
under /sys ? A PHY has an struct device, so has a name. So maybe that
can be included?

	Andrew

