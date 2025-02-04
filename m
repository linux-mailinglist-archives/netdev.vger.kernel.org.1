Return-Path: <netdev+bounces-162804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE9A27F8E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EA31661AB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFB2163BA;
	Tue,  4 Feb 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N05CaSok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851E207DED;
	Tue,  4 Feb 2025 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738711518; cv=none; b=hB7U2yDwNeyFnaMfBabK750PtmpK4wM4yU7z0fEQbLUqtA3rco5y43rQfFe4E42hlkC2wLkSil8tnCEbtMMBis3lrwouPc/AsOWPfG2dg5e79W4NJzUZ+s60lGUSSUFIQ0t2CJNSHm4k5HR4GiTnUHu9E3OhLgJUDLLHXD5G4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738711518; c=relaxed/simple;
	bh=SYn9QTxw4vAqiSN7u2YiwRtdvovqaEiCf8EY7REoNKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gobJNd9gs+zPQ2qYCk3C9akBidUMjwQZ8HunaGhKqsE4qR+P9IecqzJSWRL07zzk615d5dSDM1tWdtePZ3DcbOCTbUj5g5pvY/neDcqbFFMs8FI5IBOqHpK8utpIBSQlIvdfhs16E0lULxpqEsTxfCp3VLxSbRMSCZ3RvcFnY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N05CaSok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E12C4CEDF;
	Tue,  4 Feb 2025 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738711515;
	bh=SYn9QTxw4vAqiSN7u2YiwRtdvovqaEiCf8EY7REoNKw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=N05CaSokfnWauihUSqmNHHca4KEFMc6GcJ7hju6WpGduFJMv8MjxTwp+nnQ5cqQx2
	 Naf7K3bfVOxlarsXnh72oNKzYDhrTruTAX5FmCgaqqZl9oc80T0udvkgmIEP9sHZBv
	 zswmjTEHTwno7IihnEGAb9sqRf306CHDS1MIMdL+VpOENed4Fc8++JO2nyAbhfNilk
	 PlVoSncKnLYewuMGDFefSRaokgXg7dF5wM+SbGlUHWU1qob4bjpBWWfxKiezp/7D6k
	 HOuFYQC7BAjmC6uIBEZrlnNKezzzeFv1xIT0y7xQzxkRvYV7r7aqNTemyt3rdW25UV
	 JuoSjejsy52vg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51D35CE028A; Tue,  4 Feb 2025 15:25:15 -0800 (PST)
Date: Tue, 4 Feb 2025 15:25:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
Message-ID: <85496569-9ecc-447d-8b76-659c68aee3ea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250204132357.102354-1-edumazet@google.com>
 <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org>
 <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org>
 <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
 <39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop>
 <20250204133025.78c466ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133025.78c466ec@kernel.org>

On Tue, Feb 04, 2025 at 01:30:25PM -0800, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 13:17:08 -0800 Paul E. McKenney wrote:
> > > > TBH I'm slightly confused by this, and the previous warnings.
> > > >
> > > > The previous one was from a timer callback.
> > > >
> > > > This one is with BH disabled.
> > > >
> > > > I thought BH implies RCU protection. We certainly depend on that
> > > > in NAPI for XDP. And threaded NAPI does the exact same thing as
> > > > xfrm_trans_reinject(), a bare local_bh_disable().
> > > >
> > > > RCU folks, did something change or is just holes in my brain again?  
> > > 
> > > Nope, BH does not imply rcu_read_lock()  
> > 
> > You are both right?  ;-)
> > 
> > The synchronize_rcu() function will wait for all types of RCU readers,
> > including BH-disabled regions of code.  However, lockdep can distinguish
> > between the various sorts of readers.  So for example
> > 
> > 	lockdep_assert_in_rcu_read_lock_bh();
> > 
> > will complain unless you did rcu_read_lock_bh(), even if you did something
> > like disable_bh().  If you don't want to distinguish and are happy with
> > any type of RCU reader, you can use
> > 
> > 	lockdep_assert_in_rcu_reader();
> > 
> > I have been expecting that CONFIG_PREEMPT_RT=y kernels will break this
> > any day now, but so far so good.  ;-)
> 
> Thanks Paul! So IIUC in this case we could:
> 
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 0f5eb9db0c62..58ec1eb9ae6a 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -401,7 +401,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
>  static inline struct net *read_pnet_rcu(possible_net_t *pnet)
>  {
>  #ifdef CONFIG_NET_NS
> -	return rcu_dereference(pnet->net);
> +	return rcu_dereference_check(pnet->net, rcu_read_lock_bh_held());

That should do it!

							Thanx, Paul

>  #else
>  	return &init_net;
>  #endif
> 
> Sorry for the sideline, Eric, up to you how to proceed..
> I'll try to remember the details better next time :)

