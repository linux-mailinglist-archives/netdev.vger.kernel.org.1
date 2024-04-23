Return-Path: <netdev+bounces-90518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718388AE56E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A69F287E29
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79EF13E038;
	Tue, 23 Apr 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZhaw+Nw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3D12F38F;
	Tue, 23 Apr 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873451; cv=none; b=M+CrE+2P/VfuemK+1oAwplvFnUBlqMqZQwARtx3joc8UdHwRJvBMeO8lRO0OCocC2JgpD9HyGT0H/r5l3BuHGs/J7w9aH6mrwaPDOc1ITRfXum84vQfvEas9QfkSX4u18My2Bmte02QOrqTkO0PSxcOCjZfnkVLIQCFEXi/iBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873451; c=relaxed/simple;
	bh=R1rVaUUTarF0gWYf02kaCTKg05MUw0q8nGpCdy3cisA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu8f3AtEjgXMa0wpPVzRMlHm1UZC8Al9Wn8NehjGMW3FtUAr/cfZYsICr/E8ssfMu2+vVjQIfIueUfLEZsErdPgkFHUiWe3tYmIbo6hen40A7/TFK6d2iPAvKqlKnGOFr9FzWjkllGZgn8ttQGIMZemnK2FEX895UYEd+KJQrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZhaw+Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A00C116B1;
	Tue, 23 Apr 2024 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713873451;
	bh=R1rVaUUTarF0gWYf02kaCTKg05MUw0q8nGpCdy3cisA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZhaw+NwhGtLV/WZ35LYF/sHt/jvHOWiboPiynZmwMXNjkCR8uu2JxMX5wdgnO8da
	 2WgtyTMm+iPXSzqx6nPI3vVuu9++DSqLEaRPUJCxtD0YysigJRcuXiop9nAzQF0V2A
	 tI2kKHObOwbFBviKlXbEatdLojbsps2t+ha9vlnZZQZ7wapF9MT12VN9bnW0LJcV18
	 1vFp7DF4yYUC+YR0I+szgC+IRAhkcMb7yN8RS3V22z11YhZqNEa8sptL7pVyvoG1x2
	 rgPFvhAo88cuDhjIdaOHgnSaffa4b9rFZztBs5peZJzNzLn/py5FutcSF947M9kXe1
	 Bba4Qn+AkS6+Q==
Date: Tue, 23 Apr 2024 12:57:25 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org,
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
Message-ID: <20240423115725.GR42092@kernel.org>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com>
 <20240422182755.GD42092@kernel.org>
 <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
 <CAL+tcoDoZ5CYn-fdK5AWaMe36O10ihe2Rd89dDmjBxiBDQ37sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDoZ5CYn-fdK5AWaMe36O10ihe2Rd89dDmjBxiBDQ37sA@mail.gmail.com>

On Tue, Apr 23, 2024 at 10:17:31AM +0800, Jason Xing wrote:
> On Tue, Apr 23, 2024 at 10:14 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Tue, Apr 23, 2024 at 2:28 AM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
> > >
> > > ...
> > >
> > > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > >
> > > ...
> > >
> > > > +/**
> > > > + * There are three parts in order:
> > > > + * 1) reset reason in MPTCP: only for MPTCP use
> > > > + * 2) skb drop reason: relying on drop reasons for such as passive reset
> > > > + * 3) independent reset reason: such as active reset reasons
> > > > + */
> > >
> > > Hi Jason,
> > >
> > > A minor nit from my side.
> > >
> > > '/**' denotes the beginning of a Kernel doc,
> > > but other than that, this comment is not a Kernel doc.
> > >
> > > FWIIW, I would suggest providing a proper Kernel doc for enum sk_rst_reason.
> > > But another option would be to simply make this a normal comment,
> > > starting with "/* There are"
> >
> > Thanks Simon. I'm trying to use the kdoc way to make it right :)
> >
> > How about this one:
> > /**
> >  * enum sk_rst_reason - the reasons of socket reset
> >  *
> >  * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.
> 
> s/skb drop/sk reset/
> 
> Sorry, I cannot withdraw my previous email in time.
> 
> >  *
> >  * There are three parts in order:
> >  * 1) skb drop reasons: relying on drop reasons for such as passive
> > reset
> >  * 2) independent reset reasons: such as active reset reasons
> >  * 3) reset reasons in MPTCP: only for MPTCP use
> >  */
> > ?
> >
> > I chose to mimic what enum skb_drop_reason does in the
> > include/net/dropreason-core.h file.
> >
> > > +enum sk_rst_reason {
> > > +       /**
> > > +        * Copy from include/uapi/linux/mptcp.h.
> > > +        * These reset fields will not be changed since they adhere to
> > > +        * RFC 8684. So do not touch them. I'm going to list each definition
> > > +        * of them respectively.
> > > +        */
> >
> > Thanks to you, I found another similar point where I smell something
> > wrong as in the above code. I'm going to replace '/**' with '/*' since
> > it's only a comment, not a kdoc.

Likewise, thanks Jason.

I haven't had time to look at v8 properly,
but I see that kernel-doc is happy with the changed
you have made there as discussed above.


