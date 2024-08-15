Return-Path: <netdev+bounces-118964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33418953B02
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951701F26355
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143A74059;
	Thu, 15 Aug 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIobDVLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83344C6F
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750969; cv=none; b=g7R37XLv4A5GfJeD3KLwPn+qL3NwCoK6Hyv545LciJ5FWadEnuRKDEQlZfNxTkHiE4KB1gn2zT5nopwkYoDPTdgQ+i4vHuXx5xl7Wt7evp5X0p1AyHCfWTiJZTQBEiu3+sxKGLqgFHfSGi0KAGyKGjkSOIaP3Ynmo3PNSG59eEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750969; c=relaxed/simple;
	bh=u/IqK+S/r7ib9JEr5SAFjFtWYeq+ChUgz11sl8tJUbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSQnGtyRIBj9gqjjFIkuy9uimENasJNit2wVyHS/VzO9z2uM04Wne/kMeR8xcsZS1grcXMgcyvrgNCRBrvBYFF5alqle9mQVlaFBDWMXvphNcZeQ8VuUVScl1dAVEA4fVDn+oUUS7mBjkW2dmT/oOPH4R7ZsWGRGUr1gvidHkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIobDVLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB0C32786;
	Thu, 15 Aug 2024 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723750968;
	bh=u/IqK+S/r7ib9JEr5SAFjFtWYeq+ChUgz11sl8tJUbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIobDVLkLqYiArLl3q2uPF+iIMEcgYvbnDI4QMLTuLzmXgTHMQfAJSzD3yZmC/wv+
	 3ek0RcF91udrLySebtgSJmHbvaIRbyO/xWso4Pu3fMn/Ruqdk8trTS1QwaHJhxMH6L
	 55V13aB3h+P4l5TEZvw/QNVQSmDVCW9p3Fc95SCLCJ5ee4xmVi9qYK2htOPhFlAugK
	 5VTbNIwACOysQrUembVgzpmN5YXizswHd6OMpMADkYAT2FmhlaxIvH+tOYdoNX9r1M
	 kCP3iUsBQfoTD7CXyPwsqKaHg5Ok8S4Zl2xtMCtCKA6nsWXCD271G2zWnWYriLXcPx
	 LZzTleVO2JbqA==
Date: Thu, 15 Aug 2024 12:42:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>
Subject: Re: Per-queue stats question
Message-ID: <20240815124247.65183cbf@kernel.org>
In-Reply-To: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>
References: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 18:11:42 +0100 Edward Cree wrote:
> I'm working on adding netdev_stat_ops support to sfc, and finding that
>  the expectations of the selftest around the relation between qstats
>  and rtnl stats are difficult for us to meet.  I'm not sure whether it
>  is our existing rtnl stats or the qstats I'm adding that have the
>  wrong semantics.
> 
> sfc fills in rtnl_link_stats64 with MAC stats from the firmware (or
>  'vadaptor stats' if using SR-IOV).  These count packets (or bytes)
>  since last FW boot/reset (for instance, "ethtool --reset $dev all"
>  clears them).  (Also, for reasons I'm still investigating, while the
>  interface is administratively down they read as zero, then jump back
>  to what they were on "ip link set up".)  Moreover, the counts are
>  updated by periodic DMA, so can be up to 1 second stale.
> The queue stats, meanwhile, are maintained in software, and count
>  since ifup (efx_start_channels()), so that they can be reset on
>  reconfiguration; the base_stats count since driver probe
>  (efx_alloc_channels()).
> 
> Thus, as it stands, it is possible for qstats and rtstats to disagree,
>  in both directions.  For example:

[reordering for grouped answer]

> * Driver is unloaded and then loaded again.  base_stats will reset,
>   but MAC stats won't.
> * ethtool reset.  MAC stats will reset, but base_stats won't.
> * RX filter drops (e.g. unwanted destination MAC address).  These are
>   counted in MAC stats but since they never reach the driver they're
>   not counted in qstats/base_stats (and by my reading of netdev.yaml
>   they shouldn't be, even if we could).

rstats have no clear semantics on modern devices, some drivers count
at the MAC (potentially including VF traffic), some drivers count after
XDP (i.e. don't count XDP_DROP!?!)

We should maintain the qstat semantics as packets intended for a given
netdev, with rx-packets being packets which got delivered to the host
and picked up by the driver.

> * Traffic is passing during the test.  qstats will be up to date,
>   whereas MAC stats, being up to 1s stale, could be far behind.

That's a bug, we should pop a env.wait_hw_stats_settle() in the right
spots in the test.

> Any of these will cause the stats.pkt_byte_sum selftest to fail.
> Which side do I need to change, qstats or rtstats?  Or is the test
>  being too strict?

Test is too strict, I'm not sure what to do about it. It has proven useful
in the past, mlx5 has "misc queues" for PTP, for example, and it caught
that they are added to rstats but weren't added to the base. IDK what
to do about drivers which use MAC stats for rstat :( The fact that the
test fails doesn't mean they misuse qstat.

> On a related note, I notice that the stat_cmp() function within that
>  selftest returns the first nonzero delta it finds in the stats, so
>  that if (say) tx-packets goes forwards but rx-packets goes backwards,
>  it will return >0 causing the rx-packets delta to be ignored.  Is
>  this intended behaviour, or should I submit a patch?

Looks like a bug.

