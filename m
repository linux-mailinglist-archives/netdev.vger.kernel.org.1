Return-Path: <netdev+bounces-31849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB951790D3A
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE91C20443
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422C5666;
	Sun,  3 Sep 2023 17:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF33FE6
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 17:22:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984FCDD;
	Sun,  3 Sep 2023 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sCdnjBI3k+22FfyYfXDpxGdCt/Np2mtFytRDIWk5a8w=; b=11aZom3PL9OR2u8QcLytZPUFcV
	aYULIjfqpcb/bCg/DS+DcXCobP2maQVbut6lOumuOgSLizL4Hqbd3tUBDb1exU1mJqE9zIVK8maFj
	D4EC4Kz5r+0jBW3KfgRpfUjVGO5rFVMv7ANAuYv5af1xg3fLQQOSPbv9AUuDgQbMHDvs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qcqnh-005gxi-Km; Sun, 03 Sep 2023 19:22:17 +0200
Date: Sun, 3 Sep 2023 19:22:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <08dd3467-7720-46e1-8c72-1d46d951f90d@lunn.ch>
References: <20230831111827.548118-1-lukma@denx.de>
 <20230831111827.548118-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111827.548118-5-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
> +{
> +	struct dsa_port *partner = NULL, *dp;
> +	struct ksz_device *dev = ds->priv;
> +	enum hsr_version ver;
> +	int ret;
> +
> +	ret = hsr_get_version(hsr, &ver);
> +	if (ret)
> +		return ret;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		if (ver == PRP_V1)
> +			return -EOPNOTSUPP;

This should probably check for versions which are support, and not
assume PRP_V42 is not added some time in the future, which would be
accepted here.

	 Andrew

