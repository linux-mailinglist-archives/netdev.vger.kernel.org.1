Return-Path: <netdev+bounces-30695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE44788905
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE8A1C21015
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510FFBE4;
	Fri, 25 Aug 2023 13:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED424DF70
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:50:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2E213D;
	Fri, 25 Aug 2023 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a3FiZjh9L5KNDqjT1PJkkiHZWi2wdLHxr5sQceKIIH4=; b=4HjOt6YFmWXQk9uuj1BNfB4+hV
	8KxPDX2VPjSx23zqk30XyuJ7oN/X+NzQ3a9XvyxNxYJAuO5EY4Q3w700J1zdApbPTWYGQI9w8/yZj
	YPXcWRs8xwdB3ra9HVBaHICzU2fNqmVz9a8QeR9M4wUj48Y3bIU1l9BWD7xle0rvEO0w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qZXCQ-0055wu-Dn; Fri, 25 Aug 2023 15:50:06 +0200
Date: Fri, 25 Aug 2023 15:50:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <e2e26d30-86fb-4005-9a0e-ac9b793df86a@lunn.ch>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog>
 <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
 <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > > +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
> > > > +				struct macsec_rx_sc *rx_sc)
> > > > +{
> > > > +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
> > > 
> > > u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
> > 
> > why is the __force needed? What happens with a normal cast?
> > 
> 
> Sparse will print warnings if __force is missing.

What is the warning? I just want to make sure __force is the correct
solution, not that something has the wrong type and we should be
fixing a design issue.

       Andrew
 

