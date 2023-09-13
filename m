Return-Path: <netdev+bounces-33595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF479EC36
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9331C20AB2
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756661F190;
	Wed, 13 Sep 2023 15:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B94639
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 15:11:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA6B7
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NMDSx8uwFvlmMY5L0U6ZEaRTCFeE2CIiPzpzNKPRxtE=; b=mNxEX3b0AKONjf2p5Jo3vuItkZ
	eYqVwdcValoxuwp/vw01Mczx+8zHmpPU+JDFVHbCgmRDv+Pmq43wylAtzmZrITuAWg3BfA3whihI/
	jaEWokcgbYj9IuAMya2gIP6cX6fXV8HvPC2dnWclNQG7TVoKaUwuHoxAkoF5I6vc5X/0M8VnV8Wp2
	c8HQKq39+Xe4qh/4g8b1M/RIAAyx8Pp4VCRvVzgPWisQb2pizj2U1LpeReAmuIXzfO0rBOtTDQub4
	zeriT4rm63u0y8VYhIcOzOCl9gc7C9RiB7G+EY8kbrJD3cJL7U8v4E646iEFhPdNNs4eSOEbmVpW9
	sQTW8ppQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qgRVu-00EXrU-3z; Wed, 13 Sep 2023 15:10:46 +0000
Date: Wed, 13 Sep 2023 16:10:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, edward.cree@amd.com,
	linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
Subject: Re: [RFC PATCH v3 net-next 2/7] net: ethtool: attach an IDR of
 custom RSS contexts to a netdevice
Message-ID: <ZQHQ9hLeb0qvhxzS@casper.infradead.org>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <9c71d5168e1ee22b40625eec53a8bb00456d60ed.1694443665.git.ecree.xilinx@gmail.com>
 <ZQCThixvWBoCeT4r@shell.armlinux.org.uk>
 <b2da6ed4-9475-6e49-709f-db87dcf8c810@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2da6ed4-9475-6e49-709f-db87dcf8c810@gmail.com>

On Wed, Sep 13, 2023 at 12:22:03PM +0100, Edward Cree wrote:
> On 12/09/2023 17:36, Russell King (Oracle) wrote:
> > On Tue, Sep 12, 2023 at 03:21:37PM +0100, edward.cree@amd.com wrote:
> >> +	struct idr		rss_ctx;
> > 
> > https://docs.kernel.org/core-api/idr.html
> > 
> > "The IDR interface is deprecated; please use the XArray instead."
> 
> IDR is a wrapper around XArray these days, right?

Yes, but a bad one.

> When I looked into the equivalent to use XArray directly it looked much
>  more complicated for flexibility that really isn't needed here.

No, it's no more complex to use.  There are a lot of _other_ things
you can do with it, but every IDR call has an equivalent XArray call.
And as a bonus you get a spinlock protecting you!

> Is there an explanation you can point me at of why this extremely
>  convenient wrapper is deprecated?

Because why have two APIs for the same thing?  One day, I will be finished
with important projects and then I'll go back to eradicating the users
of the IDR.

