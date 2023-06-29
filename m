Return-Path: <netdev+bounces-14573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E512C74274C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A180F1C209A1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D87107A6;
	Thu, 29 Jun 2023 13:23:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAFC2F1
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:23:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C362D4A;
	Thu, 29 Jun 2023 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AZtS5X9BKaHL97b40HBwXNlyolqkhlUBrklOIKnvU6U=; b=sX4yjEO/PAps8WzH/CszrUMrzZ
	2V1d/zUJumY/hQLYkAUAt1LhgmxcjB5FeZ5A5MgLQj7MPs/pqHte9+blIn29PhZxmPYS699TsvVV3
	8Egv77NN/BG89UZuujij3If9z0XhEe0mJJol3u1etKhh3hxc2sBW3+jDjnU/EwQPda6M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qErci-000EDO-PF; Thu, 29 Jun 2023 15:23:48 +0200
Date: Thu, 29 Jun 2023 15:23:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_sricharan@quicinc.com
Subject: Re: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link
 down
Message-ID: <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-4-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629034846.30600-4-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int qca808x_fifo_reset(struct phy_device *phydev)
> +{
> +	/* Reset serdes fifo on link down, Release serdes fifo on link up,
> +	 * the serdes address is phy address added by 1.
> +	 */
> +	return mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
> +			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
> +			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);

In polling mode, this is going to be called once per second. Do you
really want to be setting that register all the time? Consider using
the link_change_notify callback.

Also, can you tell us more about this SERDES device on the bus. I just
want to make sure this is not a PCS and should have its own driver.

     Andrew

