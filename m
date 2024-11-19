Return-Path: <netdev+bounces-146198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4909D237F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6293EB24732
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB51C3026;
	Tue, 19 Nov 2024 10:22:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84171C4A21;
	Tue, 19 Nov 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011732; cv=none; b=eNPRHGJsEUXUN4RePYFCF2mfU4lb+Uw2weg3nXZp/sR12+F1X27Q7wtNcSLaU962jcRvXn5fgv1gLqOk4TTJ8oXYtavEnA2wKBC8xHRF2G3oVdTEUSr6LHsfEBBv0J0rwjvZlV3iquYP4CgadxxlcqFNcS3j8oOuVVOC2/NeP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011732; c=relaxed/simple;
	bh=eMFYT0DvD5hW53XVrWjcjNCUxhxj+YkMjcIsO2fyQ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bnbk5MoacwXOrd/VlANPWcG1Zk4HBFEfc6SH/ZF6ME0sCZ+H0sKmRtnYhqYnbsQ2SIisrtB7vxVC2UFrQSQUdKteXsSVI0tuftHemI70m25acFAHEvJ6P5lpBq+tngYKa5Q238mrVs2Az+RCYERz86VkpSGPPl5jE3Uzi8fL3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so4599517a12.3;
        Tue, 19 Nov 2024 02:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011729; x=1732616529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZf8sL5m8pBsaNnBre1f6OMvGKWTs60xv157tLlJOzQ=;
        b=o6BZ2Ug+/vuhOD4KpRt34PHHave3R7mDrUazCicR339L7jLkE7UiXbqDsiUD/w/YUE
         7uPtxKOKTVZoCZcmIu2fTQxNYc5o+8s2h23JUAFVJuiOTEYgtKKQixDrV7SrnfnoZNTc
         dBokJ/itXUNI16o1Xo4w14X4LLACwxHPdpEg8WBo1sWlFXG/uGC0mifQdbiD/eOGiSs6
         IIQoETe7zKVKCDzkGmDTtBP1oUzpP/uQx6FlZD2vFjWEu2edcwzatW0x4GC9mkKITgU0
         /r7bDwqUmeJsdfFXjFz7NYIAr62NrrbxAKPU/tMDpO4cG7V4Ed8JwSUSdainwf5LJPaL
         jEBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQMEz6Lwm27cva3yI3DCXPDHiujHapv45tOO3RmxAARXdV92ZmjRAW4QLHhADUOcu0wuZ13tmQEV9CJrM=@vger.kernel.org, AJvYcCXSIntzsA34woPYmtyH9B1Tblsbcol2/BZvbt1hzVbagBIVDnq/zpFCkxlHZ/ewFbTda7YnGWrA@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpuIGl9kKiV1idYcuW7ttRNcWxGZDOBzzSq+gjHIFsiCJf6jg
	oi6YqPVg4rjUEBCYvuN1YQm3NM5bbjv/lO2U4NBFaPE/Pd17WEbq
X-Google-Smtp-Source: AGHT+IGfBcbp65xMPoV3WbGSb2zZwpunwpIwPUNe43SmB0qPefKcsCA1K4A9VJT1Bq7xx/ww4GrpQA==
X-Received: by 2002:a17:907:2688:b0:aa1:e622:892 with SMTP id a640c23a62f3a-aa483478dacmr1438096266b.26.1732011728900;
        Tue, 19 Nov 2024 02:22:08 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043b76sm630581766b.147.2024.11.19.02.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:22:08 -0800 (PST)
Date: Tue, 19 Nov 2024 02:22:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 1/2] netpoll: Use rcu_access_pointer() in
 __netpoll_setup
Message-ID: <20241119-magnetic-striped-pig-bcffa9@leitao>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
 <ZzwF4QdNch_UzMlV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzwF4QdNch_UzMlV@gondor.apana.org.au>

Hello Herbet,

On Tue, Nov 19, 2024 at 11:28:33AM +0800, Herbert Xu wrote:
> On Mon, Nov 18, 2024 at 03:15:17AM -0800, Breno Leitao wrote:
> > The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
> > accessed directly for a NULL check. While no RCU read lock is held in this
> > context, we should still use proper RCU primitives for consistency and
> > correctness.
> > 
> > Replace the direct NULL check with rcu_access_pointer(), which is the
> > appropriate primitive when only checking for NULL without dereferencing
> > the pointer. This function provides the necessary ordering guarantees
> > without requiring RCU read-side protection.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 8fdd95ec162a ("netpoll: Allow netpoll_setup/cleanup recursion")
> > ---
> >  net/core/netpoll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> > index aa49b92e9194babab17b2e039daf092a524c5b88..45fb60bc4803958eb07d4038028269fc0c19622e 100644
> > --- a/net/core/netpoll.c
> > +++ b/net/core/netpoll.c
> > @@ -626,7 +626,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
> >  		goto out;
> >  	}
> >  
> > -	if (!ndev->npinfo) {
> > +	if (!rcu_access_pointer(ndev->npinfo)) {
> >  		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
> >  		if (!npinfo) {
> >  			err = -ENOMEM;
> 
> This is completely bogus.  Think about it, we are setting ndev->npinfo,
> meaning that we must have some form of synchronisation over this that
> guarantees us to be the only writer.

Correct. __netpoll_setup() should have the RTNL lock held. In the most
common case, it is done through:

	netpoll_setup() {
		rtnl_lock();
		...
		__netpoll_setup()
		...
		rtnl_unlock();
	}

> So why does it need RCU protection for reading?

Good question, I understand this bring explicit calls to RCU pointers. In
fact, the same function that this patch changes (__netpoll_setup), later
does use rtnl_dereference(), and it is inside the same RTNL lock.

More over, looking at the RCU documentation, there is an explicit example
about this, at Documentation/RCU/Design/Requirements/Requirements.rst in
the "Performance and Scalability" section. I says:

      spin_lock(&gp_lock);
      p = rcu_access_pointer(gp);
      if (!p) {
		spin_unlock(&gp_lock);
		return false;
      }

> Assuming that this code isn't completely bonkers, then the correct
> primitive to use should be rcu_dereference_protected.

I looked about rcu_dereference_protected() as well, and I though it is
used when you are de-referencing the pointer, which is a more expensive
approach.  In the code above, the code basically need to check if the
pointer is assigned or not. Looking at the code, it seems that having
rcu_access_pointer() inside the update lock seems a common pattern, than
that is what I chose.

On the other side, I understand we want to call an RCU primitive with
the _protected() context, so, I looked for a possible
`rcu_access_pointer_protected()`, but this best does not exist. Anyway,
I am happy to change it, if it is the correct API.

> Fixes header should be set to the commit that introduced the broken
> RCU marking:
> 
> commit 5fbee843c32e5de2d8af68ba0bdd113bb0af9d86
> Author: Cong Wang <amwang@redhat.com>
> Date:   Tue Jan 22 21:29:39 2013 +0000
> 
>     netpoll: add RCU annotation to npinfo field

When 8fdd95ec162a was created, npinfo was an RCU pointer, although
without the RCU annotation that came later (5fbee843c).  That is
reason I chose to fix 8fdd95ec162a.

For instance, checking out 8fdd95ec162a, at the end of
__netpoll_setup(), I see, the RCU annotation, indicating that
ndev->npinfo was a RCU protected pointer.

          /* last thing to do is link it to the net device structure */
          rcu_assign_pointer(ndev->npinfo, npinfo);

Thanks for feedback and the good pointers
--breno

