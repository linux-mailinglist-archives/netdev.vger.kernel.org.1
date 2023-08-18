Return-Path: <netdev+bounces-28927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6437812F8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793B228249B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A819BB1;
	Fri, 18 Aug 2023 18:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2453D64
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1515EC433C8;
	Fri, 18 Aug 2023 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692384083;
	bh=gk2td4NaNrKmRmobq2nxLOS/6FPnVHrOmYQZy1m+sHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzaKsrPRW+2yhywGbcPwCH5CJ1mGs5o0dwqAM4ID1E/Jt8N7uFc6fGnAhqPHSsWsq
	 M3c683h8/ov/7KlSClM4AmjIkWqXPGleGxlxISQifP69FJ98ELAr4J21tuiWRvJAJV
	 4txbdcXs+SGjFvgfWcTqy5rPB30H/21Cdw+u7/EGEO8B3ll01Xj8ijuFlJAMKSg/gD
	 6nYMIuGKVPQjaPTqDHSB/WHtgXRYTzVC1K+o2Yd8G8Jz7mzKUXD4Ne48TjvFQNg4Sy
	 cFuSYs37URYe4l8LqelstANLbVFotYjUPtLY3dLaGcinQSr62iX9OCDJE+9fhnXyV+
	 Ue+VsXSZ9NJSg==
Date: Fri, 18 Aug 2023 21:41:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH -next] net: broadcom: Use helper function IS_ERR_OR_NULL()
Message-ID: <20230818184116.GB22185@unreal>
References: <20230816095357.2896080-1-ruanjinjie@huawei.com>
 <20230817071923.GB22185@unreal>
 <dd7e3f9a-1348-1d13-3b0b-5165070dd342@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7e3f9a-1348-1d13-3b0b-5165070dd342@huawei.com>

On Thu, Aug 17, 2023 at 05:01:51PM +0800, Ruan Jinjie wrote:
> 
> 
> On 2023/8/17 15:19, Leon Romanovsky wrote:
> > On Wed, Aug 16, 2023 at 05:53:56PM +0800, Ruan Jinjie wrote:
> >> Use IS_ERR_OR_NULL() instead of open-coding it
> >> to simplify the code.
> >>
> >> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> >> ---
> >>  drivers/net/ethernet/broadcom/bgmac.c        | 2 +-
> >>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> >> index 10c7c232cc4e..4cd7c6abb548 100644
> >> --- a/drivers/net/ethernet/broadcom/bgmac.c
> >> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> >> @@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
> >>  	int err;
> >>  
> >>  	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> > 
> > When can fixed_phy_register() return NULL?
> > It looks like it returns or valid phy_dev or ERR_PTR().
> 
> It seems the following code has a problem:
> 
> 226 static struct phy_device *__fixed_phy_register(unsigned int irq,
> 227                            struct fixed_phy_status *status,
> 228                            struct device_node *np,
> 229                            struct gpio_desc *gpiod)
> 230 {
> 231     struct fixed_mdio_bus *fmb = &platform_fmb;
> 232     struct phy_device *phy;
> 233     int phy_addr;
> 234     int ret;
> 235
> 236     if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
> 237         return ERR_PTR(-EPROBE_DEFER);
> 238
> 239     /* Check if we have a GPIO associated with this fixed phy */
> 240     if (!gpiod) {
> 241         gpiod = fixed_phy_get_gpiod(np);
> 242         if (IS_ERR(gpiod))
> 243             return ERR_CAST(gpiod);
> 244     }
> 
> fixed_phy_get_gpiod() return valid gpio_desc or NULL.If
> fixed_phy_get_gpiod(np) failed, the error can not be returned with
> IS_ERR(gpiod) is true, so the 243 line code is a dead code.

Not really, gpiod can be ERR_PTR(-EPROBE_DEFER) too.

Thanks

> 
> > 
> > Thanks
> > 
> > 
> >> -	if (!phy_dev || IS_ERR(phy_dev)) {
> >> +	if (IS_ERR_OR_NULL(phy_dev)) {
> >>  		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
> >>  		return -ENODEV;
> >>  	}
> >> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> >> index 0092e46c46f8..aa9a436fb3ce 100644
> >> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> >> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> >> @@ -617,7 +617,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
> >>  		};
> >>  
> >>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> >> -		if (!phydev || IS_ERR(phydev)) {
> >> +		if (IS_ERR_OR_NULL(phydev)) {
> >>  			dev_err(kdev, "failed to register fixed PHY device\n");
> >>  			return -ENODEV;
> >>  		}
> >> -- 
> >> 2.34.1
> >>
> >>
> 

