Return-Path: <netdev+bounces-89458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948D8AA4E7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97EF281E24
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8017B4F8;
	Thu, 18 Apr 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UiHfUv63"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345913F443;
	Thu, 18 Apr 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477384; cv=none; b=FyGJRtaBYTBoK/7vbPeya6YHc6dD8L/wMgrv0qvs+jtnK3L8G3u7pAOMu6OPXP/E+SQBn8c+E+pOWUBSwKIsr8c2+T3cOVbJ7iBqshm8VZxHhyV+lwEVAcwDWkT84rwWkYoGLtFL5RHxUvsEQZj4hy4RGwwlE6lFQL8uhD+geko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477384; c=relaxed/simple;
	bh=Fw2HMz0+gzVeOybszCdMjJTYGixVTYGrYstdX7dn5hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmKK0u5n7o28DVmH+mHZW+MIl20gKYEQXe/51GwR750xfJJSYjeLmxnXgBGd4vJi5eQb9+yCWpcVug6PfHBe6MaANiJX+/8qhGepY2stdaR7RmlwhVpQU+IKLZveFxmVMtTGLcC6HaooJVTWCeE7FkCh0Za25+ivCJxcol/Kj/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UiHfUv63; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NKHq3RRb9DZOry1fX1WTmEfYYxoxdlJDDrBtepAjKaI=; b=UiHfUv63WoWeuvhfBqP8BLCR42
	r9wM/6ZfekDEB49NOf2VW/S5/UTloS37YkTi0QiFpimPwcr6e7ktBu2FBt4LC8UINt4aTJ8rqEryn
	vsXSz/9x0iH7gawFtz/CrLMGRoHe24MrVnJQBdW/axtDisDqmbQhucPdx8q5E//lovEn32Y9XCm6m
	OFmlpeXfbaCVfFyzSj9T8DmLYSWkAkmEr+jA5K2EoNmWMLVCLeXlkDdMBXd9pcPD1B5qUY8zDx6Ei
	6lRRqTV/45CusrP8/BY+eSqv46KoE2x0yxD/SR1iM1ZNdUkzSrKNIQayWghtMMDRDWkwA+lT2WgS0
	yLm79o0g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxZjt-00000006FH2-0nmU;
	Thu, 18 Apr 2024 21:56:17 +0000
Date: Thu, 18 Apr 2024 22:56:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct
 inside page
Message-ID: <ZiGXAWl1MR1rgQ5_@casper.infradead.org>
References: <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
 <1713170201.06163-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvsXN+7HpeirxzR2qek_znHp8GtjiT+8hmt3tHHM9Zbgg@mail.gmail.com>
 <1713171554.2423792-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuK0VkqtNfZ1BUw+SW=gdasEegTMfufS-47NV4bCh3Seg@mail.gmail.com>
 <1713317444.7698638-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
 <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
 <ad98cb14-cc1b-4a01-aacc-8fb53445049e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad98cb14-cc1b-4a01-aacc-8fb53445049e@kernel.org>

On Thu, Apr 18, 2024 at 10:19:33PM +0200, Jesper Dangaard Brouer wrote:
> I'm not sure it is "fine" to, explicitly choosing not to use page pool,
> and then (ab)use `struct page` member (pp) that intended for page_pool
> for other stuff. (In this case create a linked list of pages).
> 
>  +#define page_chain_next(p)	((struct page *)((p)->pp))
>  +#define page_chain_add(p, n)	((p)->pp = (void *)n)
> 
> I'm not sure that I (as PP maintainer) can make this call actually, as I
> think this area belong with the MM "page" maintainers (Cc MM-list +
> people) to judge.
> 
> Just invention new ways to use struct page fields without adding your
> use-case to struct page, will make it harder for MM people to maintain
> (e.g. make future change).

I can't really follow what's being proposed; the quoting is quite deep.

Here's the current plan for struct page:

 - The individual users are being split off.  This has already happened
   for struct folio, struct slab and struct pgdesc.  Others are hopefully
   coming.
 - At some point, struct page will become:

   struct page {
     unsigned long flags;
     unsigned long data[5];
     unsigned int data2[2];
     ... some other bits and pieces ...
   };

 - After that, we will turn struct page into:

  struct page {
    unsigned long memdesc;
  };

Users like pagepool will allocate a struct ppdesc that will be
referred to by the memdesc.  The bottom 4 bits will identify it as a
ppdesc.  You can put anything you like in a struct ppdesc, it just has
to be allocated from a slab with a 16 byte alignment.

More details here:
https://kernelnewbies.org/MatthewWilcox/Memdescs

This is all likely to land in 2025.  The goal for 2024 is to remove
mapping & index from 'struct page'.  This has been in progress since
2019 so I'm really excited that we're so close!  If you want to
turn struct ppdesc into its own struct like folio, slab & ptdesc,
I'm happy to help.  I once had a patchset for that:

https://lore.kernel.org/netdev/20221130220803.3657490-1-willy@infradead.org/

but I'm sure it's truly bitrotted.

