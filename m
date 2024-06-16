Return-Path: <netdev+bounces-103893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321690A009
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3291F219E4
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BEB6A33F;
	Sun, 16 Jun 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQibg6oh"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272A2B2CF;
	Sun, 16 Jun 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574813; cv=none; b=H8ZzKwbRkhK47+o47PIvPigGgYqVa11/GAKlhGT3gdrL0BoVE43GPmWPcxMUk0qUaWbJwYlkULmlxDmc0/m+Zd3FD4PLq2RXF0ku/N4Zx29CgrfAQfVeMl4SUrePhYZP8ggjhrPcSvAkjk8A56ismtdBwU/Y4AScmle9yZfkRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574813; c=relaxed/simple;
	bh=ANevp3J6itMEKMzRHvOiIxR3wfs2r6Kv1C5d1BF4QFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX+hFlBGD2J6a8CsCLUZO4hzEZVzipal/Dneb5uOOKR3KPeySDAddiT8AtQ3ddaTf5qn0CCv3DM0IiWeTbHO/VC65OM7QmCj5jfvqewPuJ240fmM1dbSBv+ZhwnFqvPbeVg1RZjxfYrpGNyOoXNeVP7+U/gpbSNPJPndR3pRMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IQibg6oh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a9wblOxsMO7GfPhaiHgIqea1S0c8DWX+aoF5hDQ4B40=; b=IQibg6ohidMQBvMxttCzVTpkD1
	ZDxqLrsho3LQ3CtDZy0JbZdTXw+zJUU/3bCTqK7hrHaI1sLpQW6H6GNAXs54V6Iha7ZKuTx4VLSAs
	NWXimpgZ4KzYRwxmFfjFI5CVtvJyAXB4C/2q07uUvGllbwMaARn9V9/bTCWXv9wib4/X7USnUaqVJ
	ijuob+R8MqOK2lsP6qNDsROynhLqnKaUXr7ZBIhFdgzIqkGg8bP5aEETRW6Kyr6NLgTmC44X5DtCM
	GeFYqWQhP9Mu1P3+r4eTahhtqa4CIOpxnGZTPINZyapTqCLolZDS3xtL2YA3NvI2YMiVFRJIRsphE
	q8Ao/u5w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIxoP-00000001UpH-0STC;
	Sun, 16 Jun 2024 21:53:21 +0000
Date: Sun, 16 Jun 2024 22:53:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Sagi Grimberg' <sagi@grimberg.me>,
	kernel test robot <oliver.sang@intel.com>,
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
	"lkp@intel.com" <lkp@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
Message-ID: <Zm9e0OpCaucP4836@casper.infradead.org>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
 <e2bce6704b20491e8eb2edd822ae6404@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2bce6704b20491e8eb2edd822ae6404@AcuMS.aculab.com>

On Sun, Jun 16, 2024 at 09:51:05PM +0000, David Laight wrote:
> From: Sagi Grimberg
> > Sent: 16 June 2024 10:24
> ...
> > > [ 13.498663][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> > > [   13.499424][  T194] usercopy: Kernel memory exposure attempt detected from kmap (offset 0, size
> > 8192)!
> > 
> > Hmm, not sure I understand exactly why changing kmap() to
> > kmap_local_page() expose this,
> > but it looks like mm/usercopy does not like size=8192 when copying for
> > the skb frag.
> 
> Can't a usercopy fault and have to read the page from swap?
> So the process can sleep and then be rescheduled on a different cpu?
> So you can't use kmap_local_page() here at all.

I don't think you understand how kmap_local_page() works.

