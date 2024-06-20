Return-Path: <netdev+bounces-105373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C9910DF3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF452840C6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EDD1B29C3;
	Thu, 20 Jun 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6qp7Koe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA451AF6A1;
	Thu, 20 Jun 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902961; cv=none; b=M0AGgOwqA/Jh/y2dQybtNUM8MtJSYIWllQLTWx2U4uzBJ96FOgNPyJ7qfaGsNK3YsEh3Cr7El+rO9EI9Ed2QDtO4n2P7ZOjPxa4952/pwexSQvAxwLqsGNeTifa7zobSQDsEB8r+s8teC6SZCGInwM3DnFMPATTxLsvmjyVgAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902961; c=relaxed/simple;
	bh=bwJ1YENtAarquyAe2FkBNTz+MTY6Iif2pm1iV8RXTZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3C/f9iWK5qCUefnW5grCKpwz26BWKT3GPrW4kQ+tR8QImZjxGZJCvaKu0EE4FMg/hn6zF7qHYA2QoqHfdkyuUVuXXfFHIZIvckvtPBy6x72G7pDMjHs9IXMl7AOCVcow/WMccMqxM1Qh0HVEV+XQRCrIFdjzkZB5dshiE7p27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6qp7Koe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A171DC2BD10;
	Thu, 20 Jun 2024 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718902960;
	bh=bwJ1YENtAarquyAe2FkBNTz+MTY6Iif2pm1iV8RXTZ4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T6qp7KoeqbY2YVHJUtcAyUAsnIE632b7bsoNqFMWmw/WlKKvfuJ05dNYpXICtz20S
	 V3LsDtC587hP0tbGKb6sVkXIPM+yhjxOLapXZUV7QQONpOgisD+99KRUbKVLbgmi4E
	 pVYfZdYPLoAMLLGiFiXPLvMPlftiMRRwtLTj7PtB8SoRdt98t0EbWGLY5vq3uVHZXa
	 RCZzVqHam4NR2GlqWRK+vYotqTbOrnRBZP7Csx99dZf7+hvfsgeLXepWA+cEhW9fLs
	 TiWrioscjup9g3ZHu4JZyu94R7Ic9bltPPilzERF9EISYN51283oeEyyiCaq8m3JxX
	 TDRBVjfiNqPpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AAC7CE0B67; Thu, 20 Jun 2024 10:02:40 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:02:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <37d3ca22-2dac-4088-94f5-54a07403dd27@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617072451.1403e1d2@kernel.org>
 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org>
 <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
 <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
 <20240618100210.16c028e1@kernel.org>
 <53632733-ef55-496b-8980-27213da1ac05@paulmck-laptop>
 <CAJwJo6bnh_2=Bg7jajQ3qJAErMegDjp0F-aQP7yCENf_zBiTaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6bnh_2=Bg7jajQ3qJAErMegDjp0F-aQP7yCENf_zBiTaw@mail.gmail.com>

On Wed, Jun 19, 2024 at 01:33:36AM +0100, Dmitry Safonov wrote:
> On Tue, 18 Jun 2024 at 18:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jun 18, 2024 at 10:02:10AM -0700, Jakub Kicinski wrote:
> > > On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
> [..]
> > >
> > > Dmitry mentioned this commit, too, but we use the same config for MPTCP
> > > tests, and while we repro TCP AO failures quite frequently, mptcp
> > > doesn't seem to have failed once.
> [..]
> > >
> > > To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
> > > call_rcu() as something he was expecting to have a similar issue but
> > > it in fact appeared immune.
> >
> > Whew!!!  ;-)
> 
> I'm sorry guys, that was me being inadequate.

I know that feeling!

> That's a real issue, rather than a false-positive:
> https://lore.kernel.org/netdev/20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com/

So we need call_rcu() to mark memory flowing through it?  If so, we
need help from callers of call_rcu() in the case where more than one
object is being freed.

							Thanx, Paul

