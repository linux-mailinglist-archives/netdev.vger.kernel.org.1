Return-Path: <netdev+bounces-189741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4EAB36F6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562B73BC8C0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9CB13635E;
	Mon, 12 May 2025 12:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527F610D;
	Mon, 12 May 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053065; cv=none; b=RO/1QMK2wkCNm3SukiYTZ92EygvsG4Q+KzHDAiZbFbFQRNUBGp2D4d6v+VDCvjTX7JtlogU9F76u8iYp5XSW9jNTK0G7n4gHg3i7wEZknuEv9w6DXbHhrTd705P9EqaZVQwMTanwCM1YIS1lfFXmMm8uSjCKEaitBI37Jv1nXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053065; c=relaxed/simple;
	bh=aoRENC4dK7uCxpaq2XpT/11akqxPjKkP6HAKL43p3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXKNtR1DvOnmNSgWu4DGKon1Cc0ywJvyg8wtoztQ7GNAEfY4BDu7XvWQPo148kbLH9ltCkbyoWZSO8VvviG1otRMJh33fohiMBT15WOred3uM9IgvWxPIfdGCJBKm7VGoKHSXgGhA9VDZf8leDUluNgNYmiA20N7UGCI+ELVvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-70-6821ea0019eb
Date: Mon, 12 May 2025 21:30:51 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: Re: [RFC 02/19] netmem: introduce netmem alloc/put API to wrap page
 alloc/put API
Message-ID: <20250512123051.GA45370@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-3-byungchul@sk.com>
 <CAHS8izOVynwxo4ZVG8pxqocThRYYL4EqRHpEtPPFQpLViTUKLA@mail.gmail.com>
 <CAHS8izP3knY42632AcfTHcpgpSz49gP0j6CnyswUoHW6JtC3=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP3knY42632AcfTHcpgpSz49gP0j6CnyswUoHW6JtC3=w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsXC9ZZnkS7DK8UMg+mnTS3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyNj38wFjwX6TiYsMfpgbGLoEuRk4OCQETiZ33X7HB2LsbutlBbBYBVYkDd08xgdhs
	AuoSN278ZAaxRQQ0JZbsm8jaxcjFwSywhFli3aINLCAJYYEYiS33NoHZvAIWElvnLGAHKRIS
	eM8o8WTTdmaIhKDEyZlPwIqYgab+mXcJKM4BZEtLLP/HARGWl2jeOhusnFMgUKLj9hdGEFtU
	QFniwLbjTBCHHmKXeN3sD2FLShxccYNlAqPgLCQbZiHZMAthwywkGxYwsqxiFMrMK8tNzMwx
	0cuozMus0EvOz93ECIzhZbV/oncwfroQfIhRgINRiYf3xEvFDCHWxLLiytxDjBIczEoivI3b
	gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYdS/k2V/5
	dOHCZh3rZ/kXGaSNHV/e3PatXeRvoTmf97x2r3S+0DjG96yF6VkhX6Lq2DPy92w1OvulaeG1
	Pf9+KfRr9TZ3zFd01g0TXHTf/YDPs5wnkss4Q/avMN56/urN31KbOVStLr5ec5t/4spIBsM9
	e38ELN2lNEf09p4+fcEl64Meh8suUWIpzkg01GIuKk4EAOZuEgLdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC5WfdrMvwSjHD4PNJNYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2PTww+MBf9FKi42/GFqYOwS6GLk5JAQMJHY3dDNDmKzCKhKHLh7
	ignEZhNQl7hx4ycziC0ioCmxZN9E1i5GLg5mgSXMEusWbWABSQgLxEhsubcJzOYVsJDYOmcB
	O0iRkMB7Roknm7YzQyQEJU7OfAJWxAw09c+8S0BxDiBbWmL5Pw6IsLxE89bZYOWcAoESHbe/
	MILYogLKEge2HWeawMg3C8mkWUgmzUKYNAvJpAWMLKsYRTLzynITM3NM9YqzMyrzMiv0kvNz
	NzECY3JZ7Z+JOxi/XHY/xCjAwajEw3vipWKGEGtiWXFl7iFGCQ5mJRHexu1AId6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkaDzzG72GuPs+U9nMhr72Br
	r/K2bsfNzHnhizM8BOwK9PmmLf7V/uHaq1fq3avy3NJl10yILnQqfSWaVf3nTDJHVGNAN4uI
	3RMbrifaBSoLDep1YlXLHPSZNoUlO3auMvutr3Cth4VzncieyepL/5ptORQ+V/uI38qly4+d
	7knPeWattHzGUyWW4oxEQy3mouJEAPlTfUrFAgAA
X-CFilter-Loop: Reflected

On Fri, May 09, 2025 at 07:08:23AM -0700, Mina Almasry wrote:
> j
> 
> On Fri, May 9, 2025 at 6:39 AM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Fri, May 9, 2025 at 4:51 AM Byungchul Park <byungchul@sk.com> wrote:
> > >
> > > To eliminate the use of struct page in page pool, the page pool code
> > > should use netmem descriptor and API instead.
> > >
> > > As part of the work, introduce netmem alloc/put API allowing the code to
> > > use them rather than struct page things.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  include/net/netmem.h | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index 45c209d6cc689..c87a604e980b9 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -138,6 +138,24 @@ static inline netmem_ref page_to_netmem(struct page *page)
> > >         return (__force netmem_ref)page;
> > >  }
> > >
> > > +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> > > +               unsigned int order)
> > > +{
> > > +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> > > +}
> > > +
> > > +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> > > +               unsigned long nr_netmems, netmem_ref *netmem_array)
> > > +{
> > > +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> > > +                       (struct page **)netmem_array);
> > > +}
> > > +
> > > +static inline void put_netmem(netmem_ref netmem)
> > > +{
> > > +       put_page(netmem_to_page(netmem));
> > > +}
> >
> > We can't really do this. netmem_ref is an abstraction that can be a
> > struct page or struct net_iov underneath. We can't be sure when
> > put_netmem is called that it is safe to convert to a page via
> > netmem_to_page(). This will crash if put_netmem is called on a
> > netmem_ref that is a net_iov underneath.
> >
> 
> On a closer look, it looks like this put_netmem is only called from
> code paths where you are sure the netmem_ref is a page underneath, so
> this is likely fine for now. There is a net_next series that is adding
> proper put_netmem support [1]. It's probably best to rebase your work
> on top of that, but this should be fine in the meantime.

Indeed.  Hm..  It'd be the best to work on the top of yours.

If it takes too long, I keep working on as it is for now and will adjust
this patch later once your work gets merged.

	Byungchul

> [1] https://lore.kernel.org/netdev/20250508004830.4100853-1-almasrymina@google.com/
> 
> --
> Thanks,
> Mina

