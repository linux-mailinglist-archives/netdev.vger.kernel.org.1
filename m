Return-Path: <netdev+bounces-212399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35AB1FE53
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 06:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA11766AA
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 04:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE012580CA;
	Mon, 11 Aug 2025 04:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3356191493;
	Mon, 11 Aug 2025 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754886200; cv=none; b=JXIsNTz5n6hzYThrwYS2K3EPmTsrbhV8NqKBxbSM/3vsK3KAt+uaqreyNVeeyAgUxcm3ql/myAaxp+/HvQ1HGkLgBwP39ysHNcCknJ8ksC2As40JWEVNUiDAf7wAQgU+aRC/EiSERVOjy5o7igAaQNXK5M5D5nn5eoAgxb0KTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754886200; c=relaxed/simple;
	bh=ukfePcS8CsPfW2KwTndS9b9dUxE5DbymII3PotuGnpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjicCwepHn1FOBJgZQ85j4IeGN7AiMF53Yxq+jEOxv1IFdsr68+oIYSDVH+gTIUMLMOB8OWBFa3hrroeDCYysGWWHmcIWVKwcQ5E8MT5BEUMFAUTB0WlIre3q25yWjQ1SGwC/JkfGItQd2uAb6/n0jZI4GMIjxTK7SRozJLufVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1b-68997030635f
Date: Mon, 11 Aug 2025 13:23:06 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	almasrymina@google.com, hawk@kernel.org, toke@redhat.com
Subject: Re: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <20250811042306.GA41974@system.software.com>
References: <20250729104158.14975-1-byungchul@sk.com>
 <ef987e32-f7ce-4b5a-82c4-8d89d5034afd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef987e32-f7ce-4b5a-82c4-8d89d5034afd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnoa5BwcwMgx/tfBarf1RYzFm1jdFi
	zvkWFounxx6xW+xp385s8aj/BJvFhW19rBaXd81hszi2QMzi2+k3jBaXDj9iceD22LLyJpPH
	zll32T0WbCr12LSqk83j/b6rbB6fN8kFsEVx2aSk5mSWpRbp2yVwZfxq38pY0M9Z8bThK1MD
	4wz2LkZODgkBE4mlkz7B2bN3HwazWQRUJbb/f8sCYrMJqEvcuPGTGcQWEdCWeH39EFgNs8BH
	RokpN51AbGGBWIlXLVOBajg4eAUsJGZuFAEJCwlkSLxe/ACsnFdAUOLkzCcsEK1aEjf+vWQC
	KWcWkJZY/o8DJMwpYCux7/w6sE2iAsoSB7YdByrhArrsDJvE1g+LWCDOlJQ4uOIGywRGgVlI
	xs5CMnYWwtgFjMyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQKjYFntn+gdjJ8uBB9iFOBgVOLh
	fbB0RoYQa2JZcWXuIUYJDmYlEd5nGdMzhHhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJI
	TyxJzU5NLUgtgskycXBKNTAKHuEUs5pxxmG52bTHbtkCDWaLO55bz2PY3NawTSby0fSwu+8C
	WS/VLphwSkf78yIrv08Jt9ex6M2w23BV9fHctlUc7GFb3aYul5P/VaZyUf2ey7zc86yVjsGT
	/yzYuuKbV3z3c5bHV/ReTnhqtZTLs/vSaZ9fa6q4nmRVHFwlb6T0coGTBsc1JZbijERDLeai
	4kQABeSIBX4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC5WfdrGtQMDPD4PtjVovVPyos5qzaxmgx
	53wLi8XTY4/YLfa0b2e2eNR/gs3i8NyTrBYXtvWxWlzeNYfN4tgCMYtvp98wWlw6/IjFgcdj
	y8qbTB47Z91l91iwqdRj06pONo/3+66yeSx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6MX+1b
	GQv6OSueNnxlamCcwd7FyMkhIWAiMXv3YTCbRUBVYvv/tywgNpuAusSNGz+ZQWwRAW2J19cP
	gdUwC3xklJhy0wnEFhaIlXjVMhWohoODV8BCYuZGEZCwkECGxOvFD8DKeQUEJU7OfMIC0aol
	cePfSyaQcmYBaYnl/zhAwpwCthL7zq8D2yQqoCxxYNtxpgmMvLOQdM9C0j0LoXsBI/MqRpHM
	vLLcxMwcU73i7IzKvMwKveT83E2MwJBeVvtn4g7GL5fdDzEKcDAq8fA+WDojQ4g1say4MvcQ
	owQHs5II77OM6RlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwc
	nFINjBGqx+ZJv+iq9K1oZv/27cGRVstDva7GM1hvr9C6fnj1godxtneLgl68vsT8/eWWm7O3
	ejjceynAuMv0jsj6Es1P8rmGzBaLWR21znj0x09eoZ2gvd97hTtzutRW1ivz90cLMM2eZpB8
	0OnNqdTPK29VmnOuUilge+/91a3EpSelaV33pUVnXimxFGckGmoxFxUnAgCrWfZQZQIAAA==
X-CFilter-Loop: Reflected

On Sun, Aug 10, 2025 at 08:39:42PM +0100, Pavel Begunkov wrote:
> On 7/29/25 11:41, Byungchul Park wrote:
> > Changes from RFC:
> >       1. Optimize the implementation of netmem_to_nmdesc to use less
> >          instructions (feedbacked by Pavel)
> > 
> > ---8<---
> >  From 6a0dbaecbf9a2425afe73565914eaa762c5d15c8 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Tue, 29 Jul 2025 19:34:12 +0900
> > Subject: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
> > 
> > Now that we have struct netmem_desc, it'd better access the pp fields
> > via struct netmem_desc rather than struct net_iov.
> > 
> > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> > 
> > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > used instead.
> 
> I'll ultimately need this in another tree as indicated in the
> original diff, so I'll take it into a branch and send it out

Just curious.  What is the original diff?

	Byungchul

> with other patches.
> 
> --
> Pavel Begunkov

