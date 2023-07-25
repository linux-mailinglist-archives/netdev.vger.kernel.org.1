Return-Path: <netdev+bounces-20677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C380E760920
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1EB28179E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D579FB;
	Tue, 25 Jul 2023 05:19:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91E15B6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F837C433C8;
	Tue, 25 Jul 2023 05:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690262361;
	bh=FTpOMJ1loIDWedIBp8bMdolnNSSRLdDcUGy5Kfd5820=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0BK/gW2XqdWD8kelMjt/3dU/vT03Tox7sWL1DG0QuSVnyLC5luP9yY8Tvc0HcYwg
	 lbNEgpBi9jJ8s6MZHiG3kQ/B3sU/Zof9ocJFDXYi/HQYbKI5aIrmjZRwf72xLeoC8R
	 tvO01Oz0P86XQ2JGksGRknEHWlQq9cHl9ners+mdv75CfNKPq4yFsn3Bfs7Gp8HaXY
	 7l5hqjnos93WxOMDq2cRj09dwgW0RI3bgXyrQkn/fM0T6kPi2qZQv0QuXWGj+HTGo4
	 Pur3MP/m/kCE5fSv/sj7DBmKjVgsUw1wiDm5G/hndw1DdrFttOj0I313NEJRkCTJc/
	 6eZbE2/xdKl2w==
Date: Tue, 25 Jul 2023 08:19:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230725051917.GH11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
 <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>

On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> Hi Leon,

You was already asked do not top-post.
https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
Please stop it.

> 
> This is exactly like I described:
> * xfrm.h is included from the net/core/sock.c unconditionally.
> * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> being compiled.
> * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm member.
> * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to compile.

I asked two questions. First one was "How did you set XFRM_OFFLOAD
without XFRM?".

Thanks


> 
> 
> Thanks,
> Ilia Lin
> 
> On Mon, Jul 24, 2023 at 9:11 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Jul 24, 2023 at 12:00:44PM +0300, Ilia Lin wrote:
> > > If XFRM_OFFLOAD is configured, but XFRM is not
> >
> > How did you do it?
> >
> > >, it will cause
> > > compilation error on include xfrm.h:
> > >  C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel/net/core/sock.c:127:
> > >  C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
> > >  C 05:56:39         struct xfrm_state *x = dst->xfrm;
> > >  C 05:56:39                                ~~~  ^
> > >
> > > Making the XFRM_OFFLOAD select the XFRM.
> > >
> > > Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
> > > Reported-by: Ilia Lin <ilia.lin@kernel.org>
> > > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > > ---
> > >  net/xfrm/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> > > index 3adf31a83a79a..3fc2c1bcb5bbe 100644
> > > --- a/net/xfrm/Kconfig
> > > +++ b/net/xfrm/Kconfig
> > > @@ -10,6 +10,7 @@ config XFRM
> > >
> > >  config XFRM_OFFLOAD
> > >       bool
> > > +     select XFRM
> >
> > struct dst_entry depends on CONFIG_XFRM and not on CONFIG_XFRM_OFFLOAD,
> > so it is unclear to me why do you need to add new "select XFRM" line.
> >
> >    26 struct dst_entry {
> >    27         struct net_device       *dev;
> >    28         struct  dst_ops         *ops;
> >    29         unsigned long           _metrics;
> >    30         unsigned long           expires;
> >    31 #ifdef CONFIG_XFRM
> >    32         struct xfrm_state       *xfrm;
> >    33 #else
> >    34         void                    *__pad1;
> >    35 #endif
> >    36         int
> >
> > Thanks

