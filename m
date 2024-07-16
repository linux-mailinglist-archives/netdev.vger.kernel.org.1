Return-Path: <netdev+bounces-111744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3179326EE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646D61F23AFA
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879D19AA5B;
	Tue, 16 Jul 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQBXxVr2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BF17CA00
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134395; cv=none; b=kX7gQc0hwSWt+ctQ7cpzGBI/I9eUFrDPrPjAdzSCCgsh//44w+yVElmY990jMGidHhEUs+pWLkDrMWoYnvq+LIFGcdAsxBHaJprfHibhusgS/QvYl4cnfJKr5yx4YpsqLux3bxpjrl7e6xMuNl+RLuMbbYkcyZNySeanVgC/xvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134395; c=relaxed/simple;
	bh=QG0HFwP9URALtDTNOUyZ0yHqi5VjkYCDEPcEwkiap80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7vq4Tjcrs1hDeP+CdAnhHVWv0Ro3R4AQZESR8+8AFUjALQWiIbSToblKGeqRumukuKbBtA71//waVD+tFx5jfoAoJSwpqV53s36i3LVbDi+jNIs9Sqq5qKGMmnnvPHHz0AP/8YHJpIVJInvrcYWvBvOkaA0uljw7FQTcv4LpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQBXxVr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651DC116B1;
	Tue, 16 Jul 2024 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721134395;
	bh=QG0HFwP9URALtDTNOUyZ0yHqi5VjkYCDEPcEwkiap80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQBXxVr2eJ4LMuNStIB2Cudfsiayba3QCP/wTeXWsI8hAseYQaGuoV/TKOPbtr7so
	 uMPwuvruwaAqz43ThXIW50THvPFdE/1biFmQDM7k+9o7tpG67oVLWdkGq0kyltoXv9
	 WD1sARCijybCrP5ja3ZgBu9wj+DLmjw+E6TElNbk=
Date: Tue, 16 Jul 2024 14:53:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, edumazet@google.com,
	davem@davemloft.net, eric.dumazet@gmail.com, jmaxwell37@gmail.com,
	kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
Message-ID: <2024071651-resonate-decompose-b1ab@gregkh>
References: <20240716015401.2365503-5-edumazet@google.com>
 <20240716111012.143748-1-ojeda@kernel.org>
 <CAL+tcoDVJK_J+ZGs=b94=A+3ci0uD4foZ4JQRmVa8+44udeUxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDVJK_J+ZGs=b94=A+3ci0uD4foZ4JQRmVa8+44udeUxA@mail.gmail.com>

On Tue, Jul 16, 2024 at 08:40:40PM +0800, Jason Xing wrote:
> On Tue, Jul 16, 2024 at 7:10 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > Hi Greg, Eric, all,
> >
> > I noticed this in stable-rc/queue and stable-rc/linux- for 6.1 and 6.6:
> >
> >     net/ipv4/tcp_timer.c:472:7: error: variable 'rtx_delta' is uninitialized when used here [-Werror,-Wuninitialized]
> >                     if (rtx_delta > user_timeout)
> >                         ^~~~~~~~~
> >     net/ipv4/tcp_timer.c:464:15: note: initialize the variable 'rtx_delta' to silence this warning
> >             u32 rtx_delta;
> >                         ^
> >                         = 0
> >
> > I hope that helps!
> 
> Thanks for the report!
> 
> I think it missed one small snippet of code from [1] compared to the
> latest kernel. We can init this part before using it, something like
> this:
> 
> +       rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
> +                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
> 
> Note: fully untested.
> 
> Since Eric is very busy, I decided to check and provide some useful
> information here.

Thanks all, this was probably due to my manual backporting here, let me
go check what went wrong...


