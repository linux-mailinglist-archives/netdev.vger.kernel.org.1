Return-Path: <netdev+bounces-107354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89491AA23
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5B61C2411E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8724197A6A;
	Thu, 27 Jun 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJeVjGY0"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29413A245
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500509; cv=none; b=MzXtwCMUu3n03EDikoiHRnfvhbq0k3EUdTKZdbT7ODeS19Uxh1yUAo9inNWjhkjfjYeGS7A5U4AA3bHQQr5wrbz90X8DgwXKdMDLZaZBkIoJmfSLJTEuchPN34iHP9yUu+bOCjpHlCrxqhQS0kESZyQAw7eDYWPo2tWycybEAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500509; c=relaxed/simple;
	bh=NMb1Q8d2opHyMPJ0eiMCe+a+zTAj27uVi3FQJkaD+Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6CNV2Q95xsPNbIvakkZeYGwIGSc6hjld18iR/MOwtrB9BoxrYYbxHTUtoxHsCvWkJt6ojDTK3+69B2oPygGBfebmJFpl2zwnGyc7cMrV5iHiigKgNj74p/4eOBYZkkmw4g2d1Sdu1gpFw3ZBKcW50YCAuduyR0jAKP6M9ZD0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJeVjGY0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lXiFtwIEZAuwX/H3AIQ5EcrB0kJwiC/SFUb6ASWSZXY=; b=XJeVjGY0t6Nt145SFL8Fk/GceS
	DnmqTup4mdaFyZPtFf50Fox7zdErRlxQVwZyHyCSIIZBkEyg8BXZIQzAHZwIEA5ZwIaNz0ojUH0Ix
	/riElRl8k4GljeJikBn1LBN9g2uzZN/G57UIxBSp4TcNyfj4YIw6QG7PfK8I49X9lS5OYwIVf70j2
	JIrNYuLhwo68Abmza2U7G3eR/H7irV1pP6/nKMCUxN+/HsbEdJfWV+npe+1k7pGFA5ZwnlvVfEUf4
	YzRwqzUmOHPIyCGRJLtKWShjLNe0idzLSEdzUyeTbFbXQaCjdRjDrMWER6ld+sP776EROP9sguBxj
	rixFiqKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMqd7-0000000Deum-3Km5;
	Thu, 27 Jun 2024 15:01:45 +0000
Date: Thu, 27 Jun 2024 16:01:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH net v3] net: allow skb_datagram_iter to be called from
 any context
Message-ID: <Zn1-2QVyOJe_y6l1@casper.infradead.org>
References: <20240626070037.758538-1-sagi@grimberg.me>
 <CANn89iLA-0Vo=9b4SSJP=9BhnLOTKz2khdq6TG+tJpey8DpKCg@mail.gmail.com>
 <a1b5edbd-29a4-493d-9aed-4bddfbf95c66@grimberg.me>
 <CANn89iJ=Lvs3JR_nKhqD=-URfZBmLDchUysph6dAymb2+umoeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ=Lvs3JR_nKhqD=-URfZBmLDchUysph6dAymb2+umoeA@mail.gmail.com>

On Wed, Jun 26, 2024 at 10:43:38AM +0200, Eric Dumazet wrote:
> On Wed, Jun 26, 2024 at 10:23 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> >
> > On 26/06/2024 10:40, Eric Dumazet wrote:
> > > On Wed, Jun 26, 2024 at 9:00 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >> We only use the mapping in a single context, so kmap_local is sufficient
> > >> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> > >> contain highmem compound pages and we need to map page by page.
> > >>
> > >> Reported-by: kernel test robot <oliver.sang@intel.com>
> > >> Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
> > >> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > Thanks for working on this !
> > >
> > > A patch targeting net tree would need a Fixes: tag, so that stable
> > > teams do not have
> > > to do archeological digging to find which trees need this fix.
> >
> > The BUG complaint was exposed by the reverted patch in net-next.
> >
> > TBH, its hard to tell when this actually was introduced, could skb_frags
> > always
> > have contained high-order pages? or was this introduced with the
> > introduction
> > of skb_copy_datagram_iter? or did it originate in the base implementation it
> > was copied from skb_copy_datagram_const_iovec?
> 
> OK, I will therefore suggest something like this (even if the older
> bug might be exposed
> by a more recent patch), to cover all kernels after 5.0
> 
> This was the commit adding __skb_datagram_iter(), not the bug.
> 
> Fixes: 950fcaecd5cc ("datagram: consolidate datagram copy to iter helpers")
> 
> I suspect high-order highmem pages were not used in older kernels anyway.

This explanation is slightly garbled.

High-order lowmem pages _also_ get caught by this check.  See my earlier
email explaining this.


