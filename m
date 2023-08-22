Return-Path: <netdev+bounces-29793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90275784AF7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779A11C20AF8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360F20198;
	Tue, 22 Aug 2023 20:05:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622420182
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74655C433C7;
	Tue, 22 Aug 2023 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692734747;
	bh=CD1KmySIxZZR1tfayqqTmXWyATHSKxdxwQsQPpiG098=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Co7fYn/R4HTkNJwo6bVOpUMwcT4d/cBtRjGgqJuMG0jH0rwPlhzWGHz0+BKz/BujJ
	 s91p6FAp/BrB/nzhjWyPUwtXkBSuwhRHALZGOlaDyRGetRSh+mISrqD97GJH2Le04K
	 qsVbuFdsBBjqRhlwYg5PLalr/SUm32C0/4r4+uDvZt4TiMAWBSNTGQsjKwDtRSqScx
	 LAD69Iyc6Iar8B32sfHyo5TRQ149QRGwneEL8oSPLdDrptvH4tg/6E9SIy+WlRypfP
	 LxP9aSb2OQ94ViM8kuSeyYILp3QTX22o8rmL69mmXN7M9ZvO+iX8tR3CVY6Gf90Xbi
	 PuUqUbKipGWPA==
Date: Tue, 22 Aug 2023 22:05:42 +0200
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, jerinj@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 1/3] octeontx2-pf: Fix PFC TX scheduler free
Message-ID: <20230822200542.GA3523530@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-2-sumang@marvell.com>
 <20230822071101.GI2711035@kernel.org>
 <d3073c7b5d54e1ad4790b16c419e862fee952350.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3073c7b5d54e1ad4790b16c419e862fee952350.camel@redhat.com>

On Tue, Aug 22, 2023 at 12:58:04PM +0200, Paolo Abeni wrote:
> On Tue, 2023-08-22 at 09:11 +0200, Simon Horman wrote:
> > On Mon, Aug 21, 2023 at 10:55:14AM +0530, Suman Ghosh wrote:
> > > During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
> > > which caused free up all schedulers other than the PFC schedulers.
> > > This patch fixes that to free only the PFC Tx schedulers.
> > > 
> > > Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> > > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > > ---
> > >  .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
> > >  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
> > >  2 files changed, 5 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > index 77c8f650f7ac..289371b8ce4f 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > @@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
> > >  
> > >  	mutex_unlock(&pfvf->mbox.lock);
> > >  }
> > > +EXPORT_SYMBOL(otx2_txschq_free_one);
> > 
> > Hi Suman,
> > 
> > Given that the licence of both this file and otx2_dcbnl.c is GPLv2,
> > I wonder if EXPORT_SYMBOL_GPL would be more appropriate here.
> 
> AFAICS all the symbols exported by otx2_common use plain
> EXPORT_SYMBOL(). I think we can keep that for consistency in a -net
> patch.

Sure, no objection.

> In the long run it would be nice to move all of them to
> EXPORT_SYMBOL_GPL :)
> 
> Cheers,
> 
> Paolo
> 

