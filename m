Return-Path: <netdev+bounces-210698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF733B145AF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 03:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8953A5F06
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D779F1B425C;
	Tue, 29 Jul 2025 01:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD42E36E2;
	Tue, 29 Jul 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751844; cv=none; b=cRcUKGbffugdZ4GbFGncpMIuviA3SDDUCHnlzYy8+0RGlHAjsuv72xAxcYh8D0sN9PWGIaqGnDP7uGdcnjc2wF97lZKHLZf94610X0jp8NclqgdHSnx0afOIbjDF5LPBygRlCNSGmZgnKsXNp5Gy78HJV2AvczNzol9zX/YuYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751844; c=relaxed/simple;
	bh=jc90gW/XuTCxbBVJ2qSJinzr5efKOvWwANS1C3Ke07I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af8RPR18pifM0hFORsObwsODHvicQvzHflY1V9iEU1g32L0+7Iyens5h9GB6AvNVNvIRlkHaDlfJq+8D9qEVq10wR7za2BOdK6zZnlyUo/DV8DljfbjtXxCmbRLKuJAHlB3C+eq7XsUw3c7TYNjzYsR4jzB87+8YA4uMVCDGPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5e-6888211def48
Date: Tue, 29 Jul 2025 10:17:11 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, hawk@kernel.org, toke@redhat.com,
	kernel_team@skhynix.com
Subject: Re: [RFC net-next] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <20250729011711.GE56089@system.software.com>
References: <20250728042050.24228-1-byungchul@sk.com>
 <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
 <b239b40b-0abe-43a5-af41-346283a634f6@gmail.com>
 <087ca43a-49b7-40c9-915d-558075181fd1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <087ca43a-49b7-40c9-915d-558075181fd1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LhesuzSFdWsSPD4HE3r8XqHxUWc1ZtY7SY
	c76FxeLpsUfsFnvatzNbPOo/wWZxYVsfq8XlXXPYLI4tELP4dvoNo8Wlw49YHLg9tqy8yeSx
	c9Zddo8Fm0o9Nq3qZPN4v+8qm8fnTXIBbFFcNimpOZllqUX6dglcGaenexX8Ea348vwLUwNj
	i0AXIweHhICJxLxW9y5GTjBzcuMrdhCbRUBVYnf3WRYQm01AXeLGjZ/MILaIgLbE6+uHwGqY
	BZqYJM62JYCMERaIkthyhAkkzCtgIbFh5jsgm4tDSOARo8SZ/a9YIRKCEidnPmGB6FWX+DPv
	EjNIL7OAtMTyfxwQYXmJ5q2zwVZxCthKXNn5mRHEFhVQljiw7TjYTAmB22wS/1pbGSFulpQ4
	uOIGywRGwVlIVsxCsmIWwopZSFYsYGRZxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYM8tq/0Tv
	YPx0IfgQowAHoxIPb0Zne4YQa2JZcWXuIUYJDmYlEd6CpW0ZQrwpiZVVqUX58UWlOanFhxil
	OViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhiNSh4vYF14brFWkjtL+nSvzrznr9rKbZv/
	+3K2btjgPVH8eP72Qx/Ovmrbt/uZesmlQ1USXx+pGxUa73xo8Hu/EWOy1KqfV87sfPrIgLOt
	qPvZ+thXRzat21/z8lzl5ozox6pTF/AfKTnkpjAv/vODIuM3h83SL1z9d+avhVeCoH/x8Sil
	lxwCSizFGYmGWsxFxYkAwgqUK5UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC5WfdrCuj2JFhML/V0mL1jwqLOau2MVrM
	Od/CYvH02CN2iz3t25ktHvWfYLM4PPckq8WFbX2sFpd3zWGzOLZAzOLb6TeMFpcOP2Jx4PHY
	svImk8fOWXfZPRZsKvXYtKqTzeP9vqtsHotffGDy+LxJLoA9issmJTUnsyy1SN8ugSvj9HSv
	gj+iFV+ef2FqYGwR6GLk5JAQMJGY3PiKHcRmEVCV2N19lgXEZhNQl7hx4ycziC0ioC3x+voh
	sBpmgSYmibNtCV2MHBzCAlESW44wgYR5BSwkNsx8B2RzcQgJPGKUOLP/FStEQlDi5MwnLBC9
	6hJ/5l1iBullFpCWWP6PAyIsL9G8dTbYKk4BW4krOz8zgtiiAsoSB7YdZ5rAyDcLyaRZSCbN
	Qpg0C8mkBYwsqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQJjYFntn4k7GL9cdj/EKMDBqMTD
	m9HZniHEmlhWXJl7iFGCg1lJhLdgaVuGEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0
	xJLU7NTUgtQimCwTB6dUA6OSe/AVzkyfd+3yJ6/Ufo/O7DafIaVr9b5iTcv+hluvl5ntFOLJ
	/BQxcUXzvEmcZvPNC42iV65XdC19JedqJWjEa+OWWz9d1Pr7/Upp032iFhqqDyR7mK5uvzxj
	UVm9Z23cZlOFugOOhxpFWR4yx5w9ZOpi/EK85f5jqXmdave5liecXl99QYmlOCPRUIu5qDgR
	APUwEBN9AgAA
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 07:58:13PM +0100, Pavel Begunkov wrote:
> On 7/28/25 19:46, Pavel Begunkov wrote:
> > On 7/28/25 18:44, Mina Almasry wrote:
> > > On Sun, Jul 27, 2025 at 9:21 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > 
> > ...>> - * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
> > > > + * Return: the pointer to struct netmem_desc * regardless of its
> > > > + * underlying type.
> > > >    */
> > > > -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> > > > +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
> > > >   {
> > > > -       return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> > > > +       if (netmem_is_net_iov(netmem))
> > > > +               return &((struct net_iov *)((__force unsigned long)netmem &
> > > > +                                           ~NET_IOV))->desc;
> > > > +
> > > > +       return __netmem_to_nmdesc(netmem);
> > > 
> > > The if statement generates overhead. I'd rather avoid it. We can
> > > implement netmem_to_nmdesc like this, no?
> > > 
> > > netmem_to_nmdesc(netmem_ref netmem)
> > > {
> > >    return (struct netmem_desc)((__force unsigned long)netmem & ~NET_IOV);
> > > }
> > > 
> > > Because netmem_desc is the first element in both net_iov and page for
> > > the moment. (yes I know that will change eventually, but we don't have
> > > to incur overhead of an extra if statement until netmem_desc is
> > > removed from page, right?)
> > 
> > Same concern, but I think the goal here should be to make enough
> 
> s/make/give/
> 
> 
> > info to the compiler to optimise it out without assumptions on
> > the layouts nor NET_IOV_ASSERT_OFFSET. Currently it's not so bad,
> > but we should be able to remove this test+cmove.
> > 
> >      movq    %rdi, %rax    # netmem, tmp105
> >      andq    $-2, %rax    #, tmp105
> >      testb    $1, %dil    #, netmem
> >      cmove    %rdi, %rax    # tmp105,, netmem, <retval>
> >      jmp    __x86_return_thunk
> 
> struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
> {
>        void *p = (void *)((__force unsigned long)netmem & ~NET_IOV);
> 
>        if (netmem_is_net_iov(netmem))
>                return &((struct net_iov *)p)->desc;
>        return __pp_page_to_nmdesc((struct page *)p);
> }

I wanted to remove constraints that can be removed, but Mina want not to
add additional overhead more.  So I'm thinking to keep the constraint,
'netmem_desc is the first member of net_iov'.

Thoughts?

	Byungchul

> movq    %rdi, %rax      # netmem, netmem
> andq    $-2, %rax       #, netmem
> jmp     __x86_return_thunk
> 
> 
> This should do it, and if the layouts change, it'd still
> remain correct.
> 
> --
> Pavel Begunkov

