Return-Path: <netdev+bounces-189477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9AAB240B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52221A04F79
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A922370C;
	Sat, 10 May 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iIkt02M5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1E2248BD
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746885254; cv=none; b=PmgJaYEbiBGk3xIXZ3peiHn62nuEPy11HL1Spzss5sxYcO28cwMFjbDuQSUpyPSlfvrBzHINHaN3DQxgZinxrd4KFJ5hdzz9ws0IRoQh/BSlXGOInV+HztJrpTVuQWR2GK4cmK0Rb5n4QnvyscrSwugwb+aMDx1967K2Y1yPS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746885254; c=relaxed/simple;
	bh=tgbWkXD0FplISxS0bbXgowm+lxHQUuR/4EOQcj4/61g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbIeqejJqSp7a/zE27q07jaPRMnoo06KbdZCf1U5ZXqBV1hvvLsGXtYLWro6G2SHwQze4eSZhYmus7xcY1GTlCkoSkpSGZ59aS1yNe0Q7E7ZguLOcmA0FmxY9xBkeUTXIlxYPxWYSXdEbz4GBToAg19z5tGB9l9JJt4QJv6jzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iIkt02M5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dtRDHNl1QQitr4q+i5hUW5O0MdMUzBgVfAExs97IeoM=; b=iIkt02M57ElAL5cAVaE4YeV5J3
	V2O5Xt85Wm5+0KCrWnkYQ/a+t/lAgVBSb9al2wyNWRRJY2rTvqFlXYoRnnhp8vPbgwe49wvK4z00T
	d5L4rKj6wdcygP5s47oLvSa5WJSXVCvMg+s0XpCR553JiMilnqgf8vLbqWPZ1QMJblis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDkeB-00CCwT-KX; Sat, 10 May 2025 15:53:47 +0200
Date: Sat, 10 May 2025 15:53:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Byungchul Park <byungchul@sk.com>,
	willy@infradead.org, almasrymina@google.com,
	kernel_team@skhynix.com, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	hawk@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] shrinking struct page (part of page pool)
Message-ID: <c744c40b-2b38-4911-977d-61786de73791@lunn.ch>
References: <20250414013627.GA9161@system.software.com>
 <20250414015207.GA50437@system.software.com>
 <20250414163002.166d1a36@kernel.org>
 <CAC_iWjKr-Jd7DsAameimUYPUPgu8vBrsFb0cDJiNSBLEwqKF1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKr-Jd7DsAameimUYPUPgu8vBrsFb0cDJiNSBLEwqKF1A@mail.gmail.com>

On Sat, May 10, 2025 at 10:02:59AM +0300, Ilias Apalodimas wrote:
> Hi Jakub
> 
> [...]
> 
> > > >
> > > >    struct bump {
> > > >     unsigned long _page_flags;
> > > >     unsigned long bump_magic;
> > > >     struct page_pool *bump_pp;
> > > >     unsigned long _pp_mapping_pad;
> > > >     unsigned long dma_addr;
> > > >     atomic_long_t bump_ref_count;
> > > >     unsigned int _page_type;
> > > >     atomic_t _refcount;
> > > >    };
> > > >
> > > > To netwrok guys, any thoughts on it?
> > > > To Willy, do I understand correctly your direction?
> > > >
> > > > Plus, it's a quite another issue but I'm curious, that is, what do you
> > > > guys think about moving the bump allocator(= page pool) code from
> > > > network to mm?  I'd like to start on the work once gathering opinion
> > > > from both Willy and network guys.
> >
> > I don't see any benefit from moving page pool to MM. It is quite
> > networking specific. But we can discuss this later. Moving code
> > is trivial, it should not be the initial focus.
> 
> Random thoughts here until I look at the patches.
> The concept of devices doing DMA + recycling the used buffer
> transcends networking.

Do you know of any other subsystem which takes a page, splits it into
two, and then uses each half independently for DMA and recycling. A
typical packet is 1514 octets, so you can get two in a page.

	Andrew

