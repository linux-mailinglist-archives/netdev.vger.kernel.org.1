Return-Path: <netdev+bounces-18769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA50E7589E0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7892817A0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3D180;
	Wed, 19 Jul 2023 00:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D17179
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:04:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E01BE2;
	Tue, 18 Jul 2023 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qKSs/GhjDKvKDvpu4wuEhgU/FW9hGWlYn3svaB7ZpIE=; b=1RWmYl7YH83beIFBTnXhfUo3Tc
	cUMePwzNLiMq0qMU1AngQfw6UIrbPwYnKVwGd+KVVZeGBRSEjsBIpKp5CopzpOaV+UocUNipUkZ/V
	6Oe0VU3pMnWPyUPKur2DXnLmKrxrE36KpwjZXyZQBi7TLWE43/EnihU8ujGDWugX+vo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLufK-001fwb-PP; Wed, 19 Jul 2023 02:03:38 +0200
Date: Wed, 19 Jul 2023 02:03:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 10/11] net: mdio: add C45-over-C22 fallback
 to fwnode_mdiobus_register_phy()
Message-ID: <4b31b4d0-e327-4ee5-a887-a5c35d51b2af@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-10-9eb37edf7be0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-10-9eb37edf7be0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Please note, that both with the old and the new code compatible =
> "ethernet-phy-idNNNN.NNNN" only works for the C22 case. I'm wondering if
> compatible = "ethernet-phy-idNNNN.NNNN", "ethernet-phy-ieee802.3-c45
> even makes sense because there might be multiple C45 ids. At least it is
> an allowed pattern according to the device tree bindings. But with the
> current code, the ethernet-phy-idNNNN.NNNN is ignored in the c45 case.

I think these two should be orthogonal.

ethernet-phy-idNNNN.NNNN should be used to load the driver. The driver
has a list of IDs it can drive, and we want the module loading
machinery to load a module which can driver this ID.

"ethernet-phy-ieee802.3-c45" should be about how to read the ID
registers, if ethernet-phy-idNNNN.NNNN is not present.

	Andrew


