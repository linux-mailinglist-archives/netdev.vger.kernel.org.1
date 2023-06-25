Return-Path: <netdev+bounces-13785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC073CEEB
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 09:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EFF1C208D2
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA2808;
	Sun, 25 Jun 2023 07:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089D7C
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A140C433C8;
	Sun, 25 Jun 2023 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687678074;
	bh=oeanCofYQYFVZkfR9uusD2YPvVhT36c5HNNsdvTz8QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5trcWXtWNgHN5EWXbnW1Idrq2UNKNthrd+l3sdQKCUsEF6IU6ucWwup5y65fy4UQ
	 IbvjspgSDvV/iVKpVsde84MsKmomt3RKq7b+v3fwbrNAANEcpTYPgIsiPXHo2Xtw5u
	 cbaJm8gHOh7MOBq8beLN1qIFKpgyooNbIt/Egi+DPI8/FQMiriHmtzovrdDzSVDepi
	 k6crMSn/jsQ/n8WEwtBOzzlz2+/kn6907pGHc/9f+A42zDI4qXcp0bUUNuMnSw94QU
	 JaEZag6kKl3sYnoFcYVuwmv0A4kAm8HmUCcjbR0dAC3NHNpa+SlZzwfWai39HXmqrA
	 /QxUzH8b0jcSw==
Date: Sun, 25 Jun 2023 10:27:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXT] Re: Setting security path with IPsec packet offload mode
Message-ID: <20230625072750.GA23952@unreal>
References: <DM5PR1801MB18831A63ED0689236ED2506FE322A@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <20230622083500.GA234767@unreal>
 <DM5PR1801MB1883FCE87F49E7A2651B2A70E323A@DM5PR1801MB1883.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB1883FCE87F49E7A2651B2A70E323A@DM5PR1801MB1883.namprd18.prod.outlook.com>

On Fri, Jun 23, 2023 at 06:48:21AM +0000, Bharat Bhushan wrote:
> Hi Leon,
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, June 22, 2023 2:05 PM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>;
> > herbert@gondor.apana.org.au; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; netdev@vger.kernel.org
> > Subject: [EXT] Re: Setting security path with IPsec packet offload mode
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Thu, Jun 22, 2023 at 06:58:06AM +0000, Bharat Bhushan wrote:
> > > Hi All,
> > >
> > > Have a query related to security patch (secpath_set()) with packet offload
> > mode on egress side. Working to enable ipsec packet offload while Crypto
> > offload is working.
> > > For packet offload xfrm_offload(*skb) returns false in driver. While looking in
> > xfrm framework, cannot find where security patch (secpath_set()) is set with
> > packet offload mode on egress side.
> > 
> > The idea of packet offload is to take plain text packets and perform all needed
> > magic in HW without need from driver and stack to make anything.
> 
> So driver does not know whether it normal packet and will be transmitted normally or this will undergo inline ipsec in hardware.

Yes, this is whole idea of packet offload. Such design allows natively
support tunnel and eswitch modes.

> 
> In our case packet transmit requires a different code flow in driver, to pass some extra details in transmit descriptor like state and policy pointers. 

It sounds like existing IPsec crypto mode to me, which does exactly that
- lookup in SW, while crypto in HW.

> So is there some way driver can find same and extra state and policy details from skb? 

I'm not aware, maybe Steffen can answer.

> 
> Thanks
> -Bharat

Thanks

