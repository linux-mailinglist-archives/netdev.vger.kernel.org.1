Return-Path: <netdev+bounces-14775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC830743C77
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E09281039
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74BD154A4;
	Fri, 30 Jun 2023 13:16:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962E10796
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 13:16:52 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11301997;
	Fri, 30 Jun 2023 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KWObxhlhiwyPBpeNhUx3gfwUnUTNDGSIphm93nsll0Q=; b=T5+/aB36Re7bQvZ7FQAYDVqW2M
	HvBEC5NOk2UtHC3zbdXmvKwFxDs10q7x3DwXqTF1OtgpthByDklBph7mdszJBsmDcJ7UNu2hbc/JU
	oQL1N24XMb+OxNeEigQBaZau9kK8JGdTFNiFyjAMCLVRMY7hJ89qmISO1ochdspPMbmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qFDzA-000J2R-M1; Fri, 30 Jun 2023 15:16:28 +0200
Date: Fri, 30 Jun 2023 15:16:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
Message-ID: <c2e8eeac-7e2b-48fa-bdf8-fa036e40a8a2@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-2-quic_luoj@quicinc.com>
 <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
 <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 02:39:06PM +0800, Jie Luo wrote:
> 
> 
> On 6/29/2023 9:14 PM, Andrew Lunn wrote:
> > On Thu, Jun 29, 2023 at 11:48:44AM +0800, Luo Jie wrote:
> > > The qca8081 1G chip version does not support 2.5 capability, which
> > > is distinguished from qca8081 2.5G chip according to the bit0 of
> > > register mmd7.0x901d.
> > > 
> > > The fast retrain and master slave seed configs are only needed when
> > > the 2.5G capability is supported.
> > 
> > Does genphy_c45_pma_read_abilities() work on these devices?
> > 
> >       Andrew
> 
> Hi Andrew,
> yes, genphy_c45_pma_read_abilities works on both normal qca8081 2.5G chip
> and qca8081 1G version chip, even the PHY ID is same, the only difference
> between qca8081 1G and 2.5G chip is the 2.5G capability removed on 1G
> version chip.

Great, then please use it to simply the driver.

       Andrew

