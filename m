Return-Path: <netdev+bounces-37328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724287B4D7D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EEF3028184D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B831C2D;
	Mon,  2 Oct 2023 08:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467F17F4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98574C433C7;
	Mon,  2 Oct 2023 08:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696236367;
	bh=SFYczP14+YPquywIz+kLBBQBFxbQSUtX9DllX2+43Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnAklcyfyFtMFaYI1giLt0UCh8h+FrWL8byoDNMu37IUBE9p1mlCYiZ/lcjBMHG+v
	 IgL+RUFTzDEtSOiK8ciqQu3ur11ICwdlZc/pLilHmXsWFcl4LwHF5IdyyKHFaquAq3
	 rsiddk+eVqb55CzS6iD1w/Mz2O/djrOr10+kJ520=
Date: Mon, 2 Oct 2023 10:46:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Chris Leech <cleech@redhat.com>, Rasesh Mody <rmody@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023100233-salsa-joyous-6d8c@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
 <2023100114-flatware-mourner-3fed@gregkh>
 <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
 <20231002060424.GA781@lst.de>
 <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>

On Mon, Oct 02, 2023 at 12:50:21AM -0700, Jerry Snitselaar wrote:
> On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
> > On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> > > Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
> > > in particular these two (from the e529d3507a93 dma-mapping pull for
> > > 6.2):
> > 
> > That's complete BS.  The driver was broken since day 1 and always
> > ignored the DMA API requirement to never try to grab the page from the
> > dma coherent allocation because you generally speaking can't.  It just
> > happened to accidentally work the trivial dma coherent allocator that
> > is used on x86.
> > 
> 
> re-sending since gmail decided to not send plain text:
> 
> Yes, I agree that it has been broken and misusing the API. Greg's
> question was what changed though, and it was the clean up of
> __GFP_COMP in dma-mapping that brought the problem in the driver to
> light.
> 
> I already said the other day that cnic has been doing this for 14
> years. I'm not blaming you or your __GFP_COMP cleanup commits, they
> just uncovered that cnic was doing something wrong. My apologies if
> you took it that way.

As these devices aren't being made anymore, and this api is really not a
good idea in the first place, why don't we just leave it broken and see
if anyone notices?

thanks,

greg k-h

