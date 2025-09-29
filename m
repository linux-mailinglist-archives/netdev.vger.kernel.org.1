Return-Path: <netdev+bounces-227101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A754BA8504
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7FC189CD3D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC925B1E0;
	Mon, 29 Sep 2025 07:48:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBACB2248B9;
	Mon, 29 Sep 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132134; cv=none; b=eTjYKx5gsC9ROoO8ZwO1MT/HGwO/Ez806ogbuEA5w8G6+k6EHRkyPy4JBc32AHQWsDfM7pObaTvE9pr0mb6zXF5o9AktfQr6SCAAr8VjU8XnqAIPXuQz9fl1NQhG9zShypkuVxOZViAIa8BjYlyPOWX77VjRxDB3FYmuXFUq3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132134; c=relaxed/simple;
	bh=0Y6gG69mX438DbkyUV1S5oLqHKgCc2R3/5usi/QhoHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK5Qj22ZITE2w3ycfldY+wRK4F8r7I7M9FwuXLFWOZLcznFSLL10KIFLEbrQhiIH56+M3EX+HwlMHAcMK6DB+aJATtaYqPDMFS2HnkcKNunwIM5ogAmQx5MaYTnsEchWoAc5Bv2kTza4enf0KWKifGF4MN+fIvmWYvj126WVmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-64-68da39dd678a
Date: Mon, 29 Sep 2025 16:48:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	hawk@kernel.org, toke@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <20250929074840.GA19203@system.software.com>
References: <20250926035423.51210-1-byungchul@sk.com>
 <aNau1UuLdO296pJf@horms.kernel.org>
 <20250929014619.GA20562@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929014619.GA20562@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXC9ZZnke49y1sZBpevs1qs/lFhMWfVNkaL
	OedbWCyeHnvEbrGnfTuzxaP+E2wWF7b1sVpc3jWHzeLYAjGLb6ffMFpcOvyIxYHbY8vKm0we
	O2fdZfdYsKnUY9OqTjaP9/uusnl83iQXwBbFZZOSmpNZllqkb5fAlbHi3Du2grPCFS3z7rM2
	MP7h62Lk4JAQMJG41Z/XxcgJZj662sUCYrMIqEr8PHeEEcRmE1CXuHHjJzOILSKgLHF2bgtT
	FyMXB7PAd0aJq3v/sIEkhAXiJTauessEYvMKWEjM3tMDViQk0MUoseX8ThaIhKDEyZlPwGxm
	AS2JG/9eMoEcwSwgLbH8HwdImFPAUuJwyzKwOaJAyw5sOw42R0LgMpvEru9tzBCXSkocXHGD
	ZQKjwCwkY2chGTsLYewCRuZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIGRsKz2T/QOxk8Xgg8x
	CnAwKvHwJtjfzBBiTSwrrsw9xCjBwawkwlu3+UaGEG9KYmVValF+fFFpTmrxIUZpDhYlcV6j
	b+UpQgLpiSWp2ampBalFMFkmDk6pBsakJYGiwpM/p65Ytuz6wrdbSlxNZJISbBhy1gV5HTq2
	retEpQ6jfunBVyzXPsp4uoZ+2nvg9kuh3c0WLYsmrjZf+2jnpu/POVemSmu+V7deF3r6lcXE
	L+8ehsyVFmRgEF73KeAB66wJB3ZnC/aVt9Tk9HP9TbRL0iuz74zik25TcLu3s6FI4poSS3FG
	oqEWc1FxIgCDB3zVgAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC5WfdrHvX8laGwYrTlharf1RYzFm1jdFi
	zvkWFounxx6xW+xp385s8aj/BJvF4bknWS0ubOtjtbi8aw6bxbEFYhbfTr9htLh0+BGLA4/H
	lpU3mTx2zrrL7rFgU6nHplWdbB7v911l81j84gOTx+dNcgHsUVw2Kak5mWWpRfp2CVwZK869
	Yys4K1zRMu8+awPjH74uRk4OCQETiUdXu1hAbBYBVYmf544wgthsAuoSN278ZAaxRQSUJc7O
	bWHqYuTiYBb4zihxde8fNpCEsEC8xMZVb5lAbF4BC4nZe3rAioQEuhgltpzfyQKREJQ4OfMJ
	mM0soCVx499LoCIOIFtaYvk/DpAwp4ClxOGWZWBzRIGWHdh2nGkCI+8sJN2zkHTPQuhewMi8
	ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzCwl9X+mbiD8ctl90OMAhyMSjy8CfY3M4RYE8uK
	K3MPMUpwMCuJ8NZtvpEhxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUI
	JsvEwSnVwKi3+5qw1kttp/dhL/g3ff9wWkj79L7r7tyl2sv+NRzaekyj+0F4TobR/MjEt9cO
	/J9oUZGzkeuE+o0FFT2bdmsqTtm3yOQXm5t+2fzfzz/nh+ezWesycST/L2Uye1XqqCfa8pYh
	Rnf+hr9ONhzqxw8GdAay5Gvc/2Is16mqctt53cub+kG3jymxFGckGmoxFxUnAgATHIaVaAIA
	AA==
X-CFilter-Loop: Reflected

On Mon, Sep 29, 2025 at 10:46:19AM +0900, Byungchul Park wrote:
> On Fri, Sep 26, 2025 at 04:18:45PM +0100, Simon Horman wrote:
> > On Fri, Sep 26, 2025 at 12:54:23PM +0900, Byungchul Park wrote:
> > > Changes from RFC v2:
> > >       1. Add a Reviewed-by tag (Thanks to Mina)
> > >       2. Rebase on main branch as of Sep 22
> > >
> > > Changes from RFC:
> > >       1. Optimize the implementation of netmem_to_nmdesc to use less
> > >          instructions (feedbacked by Pavel)
> > >
> > > --->8---
> > > >From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Tue, 29 Jul 2025 19:34:12 +0900
> > > Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
> > >
> > > Now that we have struct netmem_desc, it'd better access the pp fields
> > > via struct netmem_desc rather than struct net_iov.
> > >
> > > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > > netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> > >
> > > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > > used instead.
> > >
> > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > 
> > Hi Byungchul,
> > 
> > Some process issues from my side.
> > 
> > 1. The revision information, up to including the '--->8---' line above
> >    should be below the scissors ('---') below.
> > 
> >    This is so that it is available to reviewers, appears in mailing
> >    list archives, and so on. But is not included in git history.
> 
> Ah yes.  Thank you.  Lemme check.
> 
> > 2. Starting the patch description with a 'From: ' line is fine.
> >    But 'Date:" and 'Subject:' lines don't belong there.
> > 
> >    Perhaps 1 and 2 are some sort of tooling error?
> > 
> > 3. Unfortunately while this patch is targeted at net-next,
> >    it doesn't apply cleanly there.
> 
> I don't understand why.  Now I just rebased on the latest 'main' and it
> works well.  What should I check else?

I think 1 and 2 ends in 3.  I will fix it and resend it after the merge
window.

	Byungchul

> > When you repost, be sure to observe the 24h rule.
> 
> Thanks!
> 
> 	Byungchul
> 
> > Link: https://docs.kernel.org/process/maintainer-netdev.html
> > 
> > --
> > pw-bot: changes-requested
> > 
> > ...

