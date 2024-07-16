Return-Path: <netdev+bounces-111747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A811193270B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D41F23ACD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD919A87E;
	Tue, 16 Jul 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zAQl4x4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817117B431
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134996; cv=none; b=FRDAjD/Lxk8dUOVUAMDOzJfI0aPOiKV3bnL1ceL45BdE4E55/Up6AWIZSGsO1ZDNrjtgN7fp+jK9n8B3GX0dSvphedXL4sKGYzg4UyfH37aEus3FFdi2dlyZxLtmc9okCSuDdu34nxit8jLckfm7CkKq3IZOn4uSxoHRho1Fpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134996; c=relaxed/simple;
	bh=lffPy0EuV24kpqgneedJQQ+LARo2oO0DUsRJq7Uigyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2nLm+fcEmFZC5p1r4jepd49ySkOxcbsiZkxbiDgf5mGOJWUT4k2vbyjNNXZ7Wfmu/e4pNwZs6hu6ZYqWEeNtj32QomMeMjBTrqm660sQnItNqm0ZBYutomTsRUGOZorR53/BiWx62mxTYJFxLGuRIXl+OISuU3lN+6LswGdIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zAQl4x4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F7C116B1;
	Tue, 16 Jul 2024 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721134995;
	bh=lffPy0EuV24kpqgneedJQQ+LARo2oO0DUsRJq7Uigyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zAQl4x4E/KM/Az0xIXcpADfSvxKnR8317D2AqMbdSkrAM85hn36FE3UU5HE2FKy2x
	 lG4a9g5CbZXgE8oIPEPL8kmT6gyiqj2KaxZBKvaA/F4hcnbWJMBIWpycRPOSPB6BCc
	 r9piqOMnQbDD2lfXacv7pen+AgmKEEPEtbfWK1t8=
Date: Tue, 16 Jul 2024 15:03:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, edumazet@google.com,
	davem@davemloft.net, eric.dumazet@gmail.com, jmaxwell37@gmail.com,
	kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
Message-ID: <2024071610-cascade-recall-ef1f@gregkh>
References: <20240716015401.2365503-5-edumazet@google.com>
 <20240716111012.143748-1-ojeda@kernel.org>
 <CAL+tcoDVJK_J+ZGs=b94=A+3ci0uD4foZ4JQRmVa8+44udeUxA@mail.gmail.com>
 <2024071651-resonate-decompose-b1ab@gregkh>
 <2024071610-rebalance-deserve-ca41@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024071610-rebalance-deserve-ca41@gregkh>

On Tue, Jul 16, 2024 at 02:56:28PM +0200, Greg KH wrote:
> On Tue, Jul 16, 2024 at 02:53:12PM +0200, Greg KH wrote:
> > On Tue, Jul 16, 2024 at 08:40:40PM +0800, Jason Xing wrote:
> > > On Tue, Jul 16, 2024 at 7:10 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> > > >
> > > > Hi Greg, Eric, all,
> > > >
> > > > I noticed this in stable-rc/queue and stable-rc/linux- for 6.1 and 6.6:
> > > >
> > > >     net/ipv4/tcp_timer.c:472:7: error: variable 'rtx_delta' is uninitialized when used here [-Werror,-Wuninitialized]
> > > >                     if (rtx_delta > user_timeout)
> > > >                         ^~~~~~~~~
> > > >     net/ipv4/tcp_timer.c:464:15: note: initialize the variable 'rtx_delta' to silence this warning
> > > >             u32 rtx_delta;
> > > >                         ^
> > > >                         = 0
> > > >
> > > > I hope that helps!
> > > 
> > > Thanks for the report!
> > > 
> > > I think it missed one small snippet of code from [1] compared to the
> > > latest kernel. We can init this part before using it, something like
> > > this:
> > > 
> > > +       rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
> > > +                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
> > > 
> > > Note: fully untested.
> > > 
> > > Since Eric is very busy, I decided to check and provide some useful
> > > information here.
> > 
> > Thanks all, this was probably due to my manual backporting here, let me
> > go check what went wrong...
> 
> Yeah, this is my fault, due to 614e8316aa4c ("tcp: add support for usec
> resolution in TCP TS values") not being in the tree, let me go rework
> things...

Ok, backporting that commit is not going to happen, that's crazy...

Anyway, the diff below is what I made on top of the existing one, which
should be doing the right thing.  But ideally someone can test this,
somehow...  I'll push out -rc releases later today so that people can
pound on it easier.

thanks for the review!

greg k-h


--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -464,6 +464,9 @@ static bool tcp_rtx_probe0_timed_out(con
 	u32 rtx_delta;
 	s32 rcv_delta;
 
+	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
+
 	if (user_timeout) {
 		/* If user application specified a TCP_USER_TIMEOUT,
 		 * it does not want win 0 packets to 'reset the timer'
@@ -482,9 +485,6 @@ static bool tcp_rtx_probe0_timed_out(con
 	if (rcv_delta <= timeout)
 		return false;
 
-	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
-			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
-
 	return rtx_delta > timeout;
 }
 

