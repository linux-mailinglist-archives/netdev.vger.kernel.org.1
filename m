Return-Path: <netdev+bounces-29657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2874C7844AB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422A51C20A8D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5E1CA15;
	Tue, 22 Aug 2023 14:47:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9B1C2BE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:47:57 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D110B;
	Tue, 22 Aug 2023 07:47:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1E14E000D;
	Tue, 22 Aug 2023 14:47:51 +0000 (UTC)
Date: Tue, 22 Aug 2023 16:48:29 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove disable_irq() from
 ->ndo_poll_controller()
Message-ID: <ZOTKvRCeocjmPYFt@pilgrim>
References: <20230810083716.29653-1-repk@triplefau.lt>
 <20230811182025.7473bf63@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811182025.7473bf63@kernel.org>
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 06:20:25PM -0700, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 10:37:16 +0200 Remi Pommarel wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 4727f7be4f86..bbe509abc5dc 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5958,8 +5958,8 @@ static void stmmac_poll_controller(struct net_device *dev)
> >  		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
> >  			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
> >  	} else {
> > -		disable_irq(dev->irq);
> > -		stmmac_interrupt(dev->irq, dev);
> > +		if (disable_hardirq(dev->irq))
> > +			stmmac_interrupt(dev->irq, dev);
> >  		enable_irq(dev->irq);
> 
> Implementing .ndo_poll_controller is only needed if driver doesn't use
> NAPI. This driver seems to use NAPI on all paths, AFAICT you can simply
> delete this function completely.

Looks like since [0] you are right. Will send a new PATCH removing
stmmac_poll_controller.

Thanks.

[0]: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")

-- 
Remi

