Return-Path: <netdev+bounces-173082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E1A571CC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784253B30BD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6218256C61;
	Fri,  7 Mar 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnylKXKj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295F254B10;
	Fri,  7 Mar 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375819; cv=none; b=hJNPlvIQoL33G/ODHuIhLVFn6tv0dF7Pnft7atzTUxL9ph223GirpslFWsvN0n9kRTj5Q9I3Hswpq8nLeH+xsCoG3wd0TjKPXGnXiLgkmLCx62TCtWoxT7CdNhN3VetM4kTy1UVLB5f2UpYMDrY1CsJ51Jmzv5yC5IvoL8l/eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375819; c=relaxed/simple;
	bh=04n9oBxfPsUqYSa6QFDIBEGm+otW7kfvxJfVzcboPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwVkTalikcMgi6bGbyKxCC9wrSat1zzWxUZrQ9kSSbcCCOfmZTgvUXOYX/ubwVmUe5PFomyhRkgE9iJZUL5OAKeBms1LEuv4xzxOdj8C+oGFb3yEV1NY/O5PTBJSIxNXxUT1INLW7GaY2m5ezT9ISyQ8nvTQyp0UJ6OiP5phLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnylKXKj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8ff08e7b5so11539206d6.2;
        Fri, 07 Mar 2025 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741375817; x=1741980617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwBY192WecoMYMCvREaGXqpLz0NKvlNE/vveIlks+F8=;
        b=hnylKXKjMGMwSrmaaK6Y9Zi8TuJ98KHo5/rmze35k/H2Xs2b/xFKLw6RWHCy3jqgzh
         5mSEDc0zJA3cJ0n0JLeFGG7A/dxGhtJFqC8jOC/b1H1hg23oB6E8FuBu/Uyz7Y6MNOe4
         wXbf6qCLLYqRSqRlLzaZFZUX0oLqBirbMzxhmuAVu1lR1kv7VEv6gqU2R37J/MkmoxNy
         3czNMUczOXtdeMb8QfZelXPOfqgExvNlaZV3RfaYJOhDD+tDhwTuyJ7P7zJ1h700/qwb
         1n9U3JLLNRkgaz7okvU9bZJkLXO1JuqOsWLgwr6hKoXPojmH9eLZQuMvMBLQM9QdKc9h
         ZmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375817; x=1741980617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwBY192WecoMYMCvREaGXqpLz0NKvlNE/vveIlks+F8=;
        b=egewKNsWXgoKtp4Y5yI6YoASNZggGp17jTItO1QlvGa4WJCX8SKh3Q4Q7BkS/CRFdK
         Vza/W2kePM8UcGDD0JVntXlwDLEGGDxI+yfT/qKk8oK/2lgOUhyULQpCHz/Duk09r0Ij
         gkHnw82Y2lGyunGf5OaH2bx5xut1XooYv/UZbKWM+ueTKwCL3iCOJe5wuZjO0xxKwFX4
         gRt4PyThur+2eF7rHploMk1VLqfid3jQ8R1V7E3b95aWqXFOgwAm7QHh9AHUVPs2oO9t
         LX9ii43oWjmgP9wl/ZeDpuChSPLOGjNt0ohAzD1ZB6zNXQy4YhKQT6zZ3preM5UGaIt2
         weOw==
X-Forwarded-Encrypted: i=1; AJvYcCUBMAcZ4L2KgZDMduj66Ml5dLnNUOS9NlGzKi8Ov0vSHTU8Vm6/LqAdt97eWGrTHeEnTRQfrkZi@vger.kernel.org, AJvYcCVMPNwFzDOergqk9LrFysquSrI8+8t8pHWlU4iALqYn/FvaDIyG7Bdvl7n0Iwx2wcT/XlFFW6OrshBj4Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAH3dXjnvK6UOKBMzJ/+1m2EUtxRNqY2jmm4llcpxqOFcKWhmb
	HP/5JmNKzrXXw2sMZ/OShiD5JFY/ij30eocuPYXvb2HK4NRGWaaj
X-Gm-Gg: ASbGncu0ZPD9ISaY416ztiCsKiY2Q2i4uEyVNjOzJ84Ueb1FGj3cDIwxAIx4kHmgFMm
	s/B0zYyIDCc81Xm0HIbgJQuoyxWLZtzXKiRq5VXyTy8E8bBg8+33ji8olGLGDfRe/mCopXjNK6y
	Pwp1NGCrrToglaMnxUEMGDXMTTF1npOMV4lMrAS9uh9Ui3wglByrEQnx3Rcokn8n1FnfjUlocX1
	hwCnKh7ywp9/VukJtteGElG3Tc1wCqSJCYvWoy+Y7PF2sXM1QhwfrMv1ncdy7J42LnY4Fo+xIZF
	Mf/izJ+U3MLKlbrjU4wqw1J3FKY3wEUzaQExZNta+Vd6OAElg7+nuM8AKpidfN5J4HR8a6OGqW4
	K2e+wsRSOx88BHF9WM93KIUbUZcEvzEgoASg=
X-Google-Smtp-Source: AGHT+IH7MmF6wu7gSD+5uKFYHIrP1q83KFl/e6z4DVkbdOAkVSUMApRZCdolNO478ub527wq/EP2CQ==
X-Received: by 2002:a05:6214:2684:b0:6e8:fe60:fded with SMTP id 6a1803df08f44-6e90067a71bmr49103296d6.30.1741375816962;
        Fri, 07 Mar 2025 11:30:16 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7182eb6sm22535216d6.122.2025.03.07.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:30:16 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D2372120006B;
	Fri,  7 Mar 2025 14:30:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 07 Mar 2025 14:30:15 -0500
X-ME-Sender: <xms:R0nLZzdQ3wCVvKAMNgFVgw1I_lG_dWkBLJzHjl1LaMEppwQKddqOXA>
    <xme:R0nLZ5Ot0O0yae8M_pTO_zm-RiqKMUDzQvdJEMRT7xmQz_oOxcG7NCaQxL6kY69FZ
    zoqJ4en2TluuTrZfA>
X-ME-Received: <xmr:R0nLZ8hRsDLO8eBwUaUumuqh4e-UjLXQqLABjufslnCcnYVmh9wV4U-W3_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcu
    oegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephe
    dugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeeh
    heehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmh
    gvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rhihohhtkhhkrhelkeesghhmrghilhdrtghomhdprhgtphhtthhopegsphesrghlihgvnh
    ekrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R0nLZ0_uzxdbkxPAfVysDre3cgc3pZlQBE7lGIsqS5RHCaHpxo3dYA>
    <xmx:R0nLZ_s1u2LOquN5rZVaaEMfnRPH2Cy3pXTrmZ9QY58f65TxlQM4pw>
    <xmx:R0nLZzEagCrgRlQxCktdRw-XM4NNdFUk9cr6mfzV4gruL8Rn380jOA>
    <xmx:R0nLZ2O-3EWJMFmhYBOMAu6AnXQNggwLoVY-negHU7sXpER9ma4SxQ>
    <xmx:R0nLZwPP_neewr2fF0-syIk2Ao5eCNO3FvgiJDmUV4dc1GUkJz7s2gjT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 14:30:15 -0500 (EST)
Date: Fri, 7 Mar 2025 11:29:04 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bp@alien8.de, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, peterz@infradead.org, x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Message-ID: <Z8tJAJKQP3gtF7EY@boqun-archlinux>
References: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
 <20250307133946.64685-1-ryotkkr98@gmail.com>
 <Z8sXdDFJTjYbpAcq@tardis>
 <Z8s8AG3oIxerZHjG@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8s8AG3oIxerZHjG@boqun-archlinux>

On Fri, Mar 07, 2025 at 10:33:36AM -0800, Boqun Feng wrote:
> On Fri, Mar 07, 2025 at 07:57:40AM -0800, Boqun Feng wrote:
> > On Fri, Mar 07, 2025 at 10:39:46PM +0900, Ryo Takakura wrote:
> > > Hi Boris,
> > > 
> > > On Fri, 7 Mar 2025 14:13:19 +0100, Borislav Petkov wrote:
> > > >On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
> > > >> I'm so sorry that the commit caused this problem...
> > > >> Please let me know if there is anything that I should do.
> > > >
> > > >It is gone from the tip tree so you can take your time and try to do it right.
> > > >
> > > >Peter and/or I could help you reproduce the issue and try to figure out what
> > > >needs to change there.
> > > >
> > > >HTH.
> > > 
> > > Thank you so much for this. I really appreciate it.
> > > I'll once again take a look and try to fix the problem.
> > > 
> > 
> > Looks like we missed cases where
> > 
> > acquire the lock:
> > 
> > 	netif_addr_lock_bh():
> > 	  local_bh_disable();
> > 	  spin_lock_nested();
> > 
> > release the lock:
> > 
> > 	netif_addr_unlock_bh():
> > 	  spin_unlock_bh(); // <- calling __local_bh_disable_ip() directly
> > 
> > means we should do the following on top of your changes.
> > 
> > Regards,
> > Boqun
> > 
> > ------------------->8
> > diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> > index 0640a147becd..7553309cbed4 100644
> > --- a/include/linux/bottom_half.h
> > +++ b/include/linux/bottom_half.h
> > @@ -22,7 +22,6 @@ extern struct lockdep_map bh_lock_map;
> >  
> >  static inline void local_bh_disable(void)
> >  {
> > -	lock_map_acquire_read(&bh_lock_map);
> >  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> >  }
> >  
> > @@ -31,13 +30,11 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> >  
> >  static inline void local_bh_enable_ip(unsigned long ip)
> >  {
> > -	lock_map_release(&bh_lock_map);
> >  	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> >  }
> >  
> >  static inline void local_bh_enable(void)
> >  {
> > -	lock_map_release(&bh_lock_map);
> >  	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> >  }
> >  
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index e864f9ce1dfe..782d5e9753f6 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -175,6 +175,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> >  		lockdep_softirqs_off(ip);
> >  		raw_local_irq_restore(flags);
> >  	}
> > +
> > +	lock_map_acquire_read(&bh_lock_map);
> >  }
> >  EXPORT_SYMBOL(__local_bh_disable_ip);
> >  
> > @@ -183,6 +185,8 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
> >  	unsigned long flags;
> >  	int newcnt;
> >  
> > +	lock_map_release(&bh_lock_map);
> > +
> >  	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
> >  			    this_cpu_read(softirq_ctrl.cnt));
> >  
> > @@ -208,6 +212,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> >  	u32 pending;
> >  	int curcnt;
> >  
> > +	lock_map_release(&bh_lock_map);
> > +
> 
> Ok, this is not needed because __local_bh_enable() will be called by
> __local_bh_enable_ip().
> 

Hmm.. it's a bit complicated than that because __local_bh_enable() is
called twice. We need to remain the lock_map_release() in
__local_bh_enable_ip(), remove the lock_map_release() and add another
one in ksoftirq_run_end().

Let me think and test more on this.

Regards,
Boqun

> Regards,
> Boqun
> 
> >  	WARN_ON_ONCE(in_hardirq());
> >  	lockdep_assert_irqs_enabled();
> >  

