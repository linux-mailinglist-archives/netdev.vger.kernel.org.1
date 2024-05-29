Return-Path: <netdev+bounces-98888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A058D2EF4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57617B21502
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD41667C1;
	Wed, 29 May 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h2dap/eV"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA11167D80
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969382; cv=none; b=EgLl/7DyugYj9V27e3gLHxppREMxL7O7MoHPUMBZ4oc4W7GU25vbusz5lUFYY9ArRlRR4ZTiGdVyi0Vx/OW5lICtVHpIXend9Gu+0FgHM6wLPT8QwKsGxrrwWq0GTcm1IDYcxBJthZRrexxpS9Rw9O8SJjg04PaPVKr7eofU1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969382; c=relaxed/simple;
	bh=3tIN3IW27wnKXrnEiPiaPMCMWqpvfID4cd7qOMCqn/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdUBEbUDN+rOsBtIsk1c2vBmoFCXClTA62wtDEVWcNuD4+pY3dPddUyBL6P5yXPPKpNFH2b4xJ0bYHT6B1KpWazzaEsiUKGxog4frh+Z9+RCxp0RJ8+ubcLDNWr8t0nczsR7uZHmAq87CTzkwf4chG7IKwzlYyaUntKFsmUouJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h2dap/eV; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716969371; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2PYb9pB+7U+P7EtpBENK4iIFVLPhWz3/O4ZdjUNs/vg=;
	b=h2dap/eVXTJ8O4IUfEM6bPYxr9IMmffOl1hG7zbbhNjcH8Ogv6nB+KvDTcY1PRZeFIYV+BCTmbC09RvbLMfk0c++OkBiWftytWJe7dsdZP0ETF3/2S/9ZrebgvbNEkuKJHJ30I2CVNFtKR4YUmdSmDHCwokcuiwkwnca7+VE6kw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7S3tLI_1716969370;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W7S3tLI_1716969370)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 15:56:10 +0800
Date: Wed, 29 May 2024 15:56:08 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Kevin Yang <yyd@google.com>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
Message-ID: <ZlbfmAy5_mh9QxIS@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20240528171320.1332292-1-yyd@google.com>
 <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
 <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com>
 <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com>

On Wed, May 29, 2024 at 09:39:02AM +0200, Eric Dumazet wrote:
> On Wed, May 29, 2024 at 9:00 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Wed, May 29, 2024 at 2:43 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > Hello Kevin,
> > >
> > > On Wed, May 29, 2024 at 1:13 AM Kevin Yang <yyd@google.com> wrote:
> > > >
> > > > Adding a sysctl knob to allow user to specify a default
> > > > rto_min at socket init time.
> > >
> > > I wonder what the advantage of this new sysctl knob is since we have
> > > had BPF or something like that to tweak the rto min already?
> > >
> > > There are so many places/parameters of the TCP stack that can be
> > > exposed to the user side and adjusted by new sysctls...
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > After this patch series, the rto_min will has multiple sources:
> > > > route option has the highest precedence, followed by the
> > > > TCP_BPF_RTO_MIN socket option, followed by this new
> > > > tcp_rto_min_us sysctl.
> > > >
> > > > Kevin Yang (2):
> > > >   tcp: derive delack_max with tcp_rto_min helper
> > > >   tcp: add sysctl_tcp_rto_min_us
> > > >
> > > >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> > > >  include/net/netns/ipv4.h               |  1 +
> > > >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> > > >  net/ipv4/tcp.c                         |  3 ++-
> > > >  net/ipv4/tcp_ipv4.c                    |  1 +
> > > >  net/ipv4/tcp_output.c                  | 11 ++---------
> > > >  6 files changed, 27 insertions(+), 10 deletions(-)
> > > >
> > > > --
> > > > 2.45.1.288.g0e0cd299f1-goog
> > > >
> > > >
> >
> > Oh, I think you should have added Paolo as well.
> >
> > +Paolo Abeni
> 
> Many cloud customers do not have any BPF expertise.
> If they use existing BPF programs (added by a product), they might not
> have the ability to change it.

+1, eBPF actually is not easy to write, debug and manage for now.
Sysctls are easy to use, just put it into /etc/sysctl.conf and save it
into users' customized images or templates. AFAIK, there is no standard
system kit to handle eBPF in most OS distros.

> 
> We tried advising them to use route attributes, after
> commit bbf80d713fe75cfbecda26e7c03a9a8d22af2f4f ("tcp: derive
> delack_max from rto_min")
> 
> Alas, dhcpd was adding its own routes, without the "rto_min 5"
> attribute, then systemd came...
> Lots of frustration, lots of wasted time, for something that has been
> used for more than a decade
> in Google DC.
> 
> With a sysctl, we could have saved months of SWE, and helped our
> customers sooner.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

