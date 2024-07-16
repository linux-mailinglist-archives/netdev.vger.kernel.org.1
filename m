Return-Path: <netdev+bounces-111745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F342A9326FA
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C50EB21406
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0B19AA74;
	Tue, 16 Jul 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lN+fBl6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA9145345
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134591; cv=none; b=XTe6Y5c/WeQNKoYdfDlD+bpQrjyxbIki2XwzraDWrHf27y/0HIBq8rK1RaPFeSX7TORdTwIh6EvVv29q5MgIooUVIBX+7Ai2vfQHMMXJxate8D/0bkWcGd/oEA0GY8O2tscXS15M0NDba4YF9NBG07V9vb5NEgPUHfgQQmwknUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134591; c=relaxed/simple;
	bh=nHktMIxdgWNr8Pf1mbX/KbgGE2oVFb4MmvfTJPjlKDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay+ehvKdw5vqSta74UHBJ3ukOQzzbrSwRoC8kCTX8cdXaoV/n1KLt34sTM8ynajBLDFRworYloOftSrcmGq66rig6zN87nZj+R2dVrJOL14aPk8B9dQX1AaAFNhTWzr9TgTEICi6zeW1cZ6dmFz/5L80KnlxzYDjZEyTaG89BRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lN+fBl6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FD9C116B1;
	Tue, 16 Jul 2024 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721134591;
	bh=nHktMIxdgWNr8Pf1mbX/KbgGE2oVFb4MmvfTJPjlKDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN+fBl6nxmFBH30YmAF5nZCNd+tt88Pvv2/viAduV7zwSH26EcBCSjF+CYT7J6nvf
	 sHZ9atl47mCDQy5P63VyQT2Wy23/2gEwYijKENhDrEagwsxYktzj9RIZmknO6q+MTj
	 upGx6qjkGw7F3haUSYkkXcDmUm674NcUrj1WozIs=
Date: Tue, 16 Jul 2024 14:56:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, edumazet@google.com,
	davem@davemloft.net, eric.dumazet@gmail.com, jmaxwell37@gmail.com,
	kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
Message-ID: <2024071610-rebalance-deserve-ca41@gregkh>
References: <20240716015401.2365503-5-edumazet@google.com>
 <20240716111012.143748-1-ojeda@kernel.org>
 <CAL+tcoDVJK_J+ZGs=b94=A+3ci0uD4foZ4JQRmVa8+44udeUxA@mail.gmail.com>
 <2024071651-resonate-decompose-b1ab@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024071651-resonate-decompose-b1ab@gregkh>

On Tue, Jul 16, 2024 at 02:53:12PM +0200, Greg KH wrote:
> On Tue, Jul 16, 2024 at 08:40:40PM +0800, Jason Xing wrote:
> > On Tue, Jul 16, 2024 at 7:10 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> > >
> > > Hi Greg, Eric, all,
> > >
> > > I noticed this in stable-rc/queue and stable-rc/linux- for 6.1 and 6.6:
> > >
> > >     net/ipv4/tcp_timer.c:472:7: error: variable 'rtx_delta' is uninitialized when used here [-Werror,-Wuninitialized]
> > >                     if (rtx_delta > user_timeout)
> > >                         ^~~~~~~~~
> > >     net/ipv4/tcp_timer.c:464:15: note: initialize the variable 'rtx_delta' to silence this warning
> > >             u32 rtx_delta;
> > >                         ^
> > >                         = 0
> > >
> > > I hope that helps!
> > 
> > Thanks for the report!
> > 
> > I think it missed one small snippet of code from [1] compared to the
> > latest kernel. We can init this part before using it, something like
> > this:
> > 
> > +       rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
> > +                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
> > 
> > Note: fully untested.
> > 
> > Since Eric is very busy, I decided to check and provide some useful
> > information here.
> 
> Thanks all, this was probably due to my manual backporting here, let me
> go check what went wrong...

Yeah, this is my fault, due to 614e8316aa4c ("tcp: add support for usec
resolution in TCP TS values") not being in the tree, let me go rework
things...

thanks,

greg k-h

