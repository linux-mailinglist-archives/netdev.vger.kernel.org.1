Return-Path: <netdev+bounces-30539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A1787C58
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 02:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9692816E6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603DC2E0;
	Fri, 25 Aug 2023 00:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6807E
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7744DC433C8;
	Fri, 25 Aug 2023 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692921623;
	bh=LdYemfq7o7miu5bzyF9l4C6SuqR6VYPZMdl9Gkr7R/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUr7QF7QDxEfomElu5O5oDXXyzYzEhQg1rk/fxN1kQIYrNHKzIEZfo58HiDaJdd15
	 SkTz00F+q2YgLEjwW9wCoXrRWBK6UgMLRDPenzpggqCpvfKJTJnbJdZvnbnTZZZ617
	 +4WelmYccYkR9FV6tAUKLTH5xsq9GwK5OaHMs9Mv8riCsfUriopbzfahmmOL/W6QMK
	 84zS8pDGj6rec8LSZbeJsHGOFw25+bGSsAhQtLqEk3u/IDyvB41T52q114d6rsz2Fx
	 tk++qaD1sL4amunQiReOY+iFTdCYaho43Am1tyWxU8e/rrcgVHu2DZZlGGiXmO4tFb
	 iu5yygt6dppUw==
Date: Thu, 24 Aug 2023 17:00:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
 "horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com"
 <bcreeley@amd.com>, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Message-ID: <20230824170022.5a055c55@kernel.org>
In-Reply-To: <SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 22:50:34 +0000 Zulkifli, Muhammad Husaini wrote:
> > Why was it returning an error previously? It's not clear from just this patch.  
> 
> In patch 1/2, the returned error was removed. The previous error will
> prevent the user from entering the tx-usecs value; instead, the user
> can only change the rx-usecs value.

I see. Maybe it's better to combine the patches, they are a bit hard 
to review in separation.

> > I'm not sure about this fix. Systems which try to converge configuration like
> > chef will keep issuing:
> > 
> > ethtool -C enp170s0 tx-usecs 20 rx-usecs 10
> > 
> > and AFAICT the values will flip back and froth between 10 and 20, and never
> > stabilize. Returning an error for unsupported config sounds right to me. This
> > function takes extack, you can tell the user what the problem is.  
> 
> Yeah. In my tests, I missed to set the tx-usecs and rx-usecs
> together. Thank you for spotting that. We can add the
> NL_SET_ERR_MSG_MOD(extack,...) and returning error for unsupported
> config. If I recall even if we only set one of the tx or rx usecs,
> this [.set_coalesce] callback will still provide the value of both
> tx-usecs and rx-usecs. Seems like more checking are needed here. Do
> you have any particular thoughts what should be the best case
> condition here?

I was just thinking of something along the lines of:

if (adapter->flags & IGC_FLAG_QUEUE_PAIRS &&
    adapter->tx_itr_setting != adapter->rx_itr_setting)
   ... error ...

would that work?

