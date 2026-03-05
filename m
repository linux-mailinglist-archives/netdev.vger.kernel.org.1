Return-Path: <netdev+bounces-264576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDcgO0IPqmngKQEAu9opvQ
	(envelope-from <netdev+bounces-264576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:18:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C22193AE
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235B9302B205
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51236654B;
	Thu,  5 Mar 2026 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l33iWp/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15815366043
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752702; cv=none; b=k4f49446lx/rQm366ayk8honZ8P1VrS76Lod/o7AP/2Q5XcEtOmzCPE0AG5Ze7aAKsBZEwCTj4uGN9fRkSjDbEc123kYMOu6S09ITIQQV596k+ilE4ZeZfmHEnb4oDi+6fTP+lZ+1ABY5U5JrrsoZebJ3c0RtX/DHfbxGLBmfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752702; c=relaxed/simple;
	bh=Fqf2vnzhjskGiqh/nmMd1dXkW60vrL4+QtjH4ybHDY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pub0ujua5dbleGYV8I4Qksp2eyREndejEPW5ijEtFURp37ZBx0uVY+qP4PiSEbkFa/tj9rYv8n44OT/p0i3dAbcoAfKcqvYAP2q6AgqG0Zz5ItU7fOCst7wDdIig4cOoB9DkgCkuPkhQZPTYX6/bTWc/E1M1jMGQptGJ/EfGtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l33iWp/M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so29135ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 15:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772752699; x=1773357499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OT+M4OLV2jPlgPxLe+Zv0BlzVS5I6l8bWz+4E140bhA=;
        b=l33iWp/MmEIiQ8eNhzGvOGVYLPlrNQwulyxQGUTk5v47QhYESx338kwB0jyXtfm6LB
         +tTpFwzVhEHk1MLv4sWQhsd6nnWCUsBsILA5qMhH8Duo14vOW2EZlyo90uOeHzCUTlxO
         1xwNBFTwZrU3iJTCGnBHZTm8RQKD+wg6XP7hEtfQ9b/HLsB9+jqr2i2GuvSP0n3lW7y3
         t3j9paXzWSVa+E2B63ppOWxaHAsnrkBbd8FpKH2B/XRxo4x/DawS35OJhysY5Ha1+SL+
         tCJCfe7BdV8Ka6VFSTXaee6S/YdP0n8n2lR5wHIn5KSN/9Qbqw1wdbWHtUNdvduxc4xj
         RNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772752699; x=1773357499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT+M4OLV2jPlgPxLe+Zv0BlzVS5I6l8bWz+4E140bhA=;
        b=lvk75+bKUSYcpOxwJgqPdFxXEDIU/7OTWjxzLXEyBZubi0rcLgqdQ4zhrbcdSplCFM
         0BobbyZLTEEXxqwO+iarCeKlBUOvuMXJXfADet8/ZxUNRswBvjdrhTGZcSTbEYBFD/AX
         78OGECJ4BDFXmMwRTRTZBygZWQ0DBcNGGOEXrJmSydsNiESBydcyDw0zoHZ0fJDvkXS/
         YhDbqtzyVi8hdi7DaQ5aTSMVYPrXz1iZZ0Hh9bGeSOLio5Mp6uuaz2TDPlj5ROHnufBW
         eDpvjrpAVu6ezmr/7teVmrSjb1je342FqvWSP/YRQ2qmJsCDVvg/o7WOL1zgRfCMhSpt
         1ySA==
X-Forwarded-Encrypted: i=1; AJvYcCWhRdsYAnLLBs3NdUSAeZ9ieRbkFopplWIqt2F20ZPpGyCsBLvz7zaQJnmPP+minyUy89cg7Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/l5jPTYi7HpntJaHRzdyUD8suCRzfpVLMkOkYsqxPx3ibkoq3
	FvZocJVUTU2DM78g+IIQn8F5XhmfJNEmZcwPZ7tkD88v1JDnaj24jsczu7Ta9ahYWg==
X-Gm-Gg: ATEYQzz8vPftmTU5UzRMev19MqoolnkK9xzkbccVkG2dxHgFKr0dZcb3DSIGCrPb/d0
	1i95LHrkSSTCs8OmrYAR+j00/gn4vkt/NCewq5mK/kxa+FtuySW4Ux+0S/m363eH+2Ih7IehSkU
	hSlzgmSO2yhN99W9WvKcpvsYRZUA8hG27pWOSuBxn+vx7+ZrnOfFxX317Tf5Xk1od6uAZymx8Lu
	w9rFi0m/cwK9KD+/rkBNef+s9abkGeP6F8GDe22Z36OdsW7rzX1/PTTqCjuN7WPSZgq95nTzpba
	9wKvdtDJRDA09vjcO5GgTk84PYIRCecSuFfn6hkVrvVwoj0/GWTx4NwyAHGU9KXi8lLV+AeKqOV
	WP4zFxGse6HGpgBycZSJaKg+TN5exQoxfXG+afvyin/rJZGYxSofBTBvD44tC9PM/NBSs5cA8kU
	jSBaY/EBabpGpjGYzQoRDcVNeIa+GknbpEPJnGuNRvatNJ+G4qOkCUvre8EA==
X-Received: by 2002:a17:902:f710:b0:2a0:89b0:71d7 with SMTP id d9443c01a7336-2ae81e54cf1mr501075ad.13.1772752698768;
        Thu, 05 Mar 2026 15:18:18 -0800 (PST)
Received: from google.com (127.200.82.34.bc.googleusercontent.com. [34.82.200.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4f945985sm185696495ad.71.2026.03.05.15.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 15:18:18 -0800 (PST)
Date: Thu, 5 Mar 2026 23:18:14 +0000
From: Jordan Rife <jrife@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	edumazet@google.com, kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, willemdebruijn.kernel@gmail.com, yusuke.suzuki@isovalent.com
Subject: Re: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on
 abort
Message-ID: <sypbfotquozxxj2oe2xspfepfjrxdp2xkijhsccdzzxoza2mcr@vk6wnpajjn4e>
References: <md5mulclwk56nxxdqn4zwgiouwfdi7ydfn3g5hka434ov3ygax@qrw2b3h7ho4f>
 <20260305193157.2889096-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305193157.2889096-1-kuniyu@google.com>
X-Rspamd-Queue-Id: 676C22193AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,google.com,linux.dev,fomichev.me,gmail.com,isovalent.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264576-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 07:31:45PM +0000, Kuniyuki Iwashima wrote:
> From: Jordan Rife <jrife@google.com>
> Date: Thu, 5 Mar 2026 18:03:09 +0000
> > On Thu, Mar 05, 2026 at 03:25:21AM +0000, Kuniyuki Iwashima wrote:
> > > From: Jordan Rife <jrife@google.com>
> > > Date: Wed, 4 Mar 2026 23:52:22 +0000
> > > > On Wed, Mar 04, 2026 at 09:21:03PM +0000, Kuniyuki Iwashima wrote:
> > > > > From: Jordan Rife <jrife@google.com>
> > > > > Date: Tue,  3 Mar 2026 17:01:02 +0000
> > > > > > Currently, udp_abort() invokes __udp_disconnect() which clears out
> > > > > > socket fields like inet_daddr and inet_dport. This makes fields like
> > > > > > dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
> > > > > > hooks following an abort on a connected UDP socket, since they'll always
> > > > > > equal zero. This differs from the behavior for TCP sockets where a
> > > > > > cgroup/sock_release hook will see the address and port that the socket
> > > > > > was connected to at the time it was aborted. This causes issues in
> > > > > > Cilium where a sock_release hook is used to perform map maintenance when
> > > > > > sockets are released, since Cilium actively destroys connected UDP
> > > > > > sockets in some cases.
> > > > > 
> > > > > Just curious why Cilium does not unregister the socket just
> > > > > after aborting it ?
> > > > > 
> > > > > At least Cilium should know the key at that moment.
> > > > 
> > > > Originally, socket aborts in Cilium were handled with sock_diag (and
> > > > still are on older kernels), so you'd need to do some map maintenance in
> > > > userspace directly before or after aborting the socket. I suppose it was
> > > > just cleaner to put common cleanup code in a sock_release hook.
> > > > 
> > > > > > 
> > > > > > Make the behavior consistent between TCP and UDP sockets by not clearing
> > > > > 
> > > > > This patch makes another inconsistency with TCP.
> > > > > 
> > > > > As you mentioned in the cover letter, before the patch, even if
> > > > > aborted, a bound socket still reserves a port, but it does not now.
> > > > > 
> > > > > This might be surprising for non-reuseaddr/port sockets.
> > > > 
> > > > Yeah, true. I'm curious if this behavior is something that is useful at
> > > > all or simply an accident of the current implementation? If I'm
> > > > aborting/destroying a socket, why should it hold onto bound ports until
> > > > the socket is closed? I wasn't quite sure about this.
> > > 
> > > Digging into the first (long) thread of SOCK_DESTROY (TCP),
> > > the motivation was to kill sockets bound to an IP address
> > > that Android/laptop removes when it switches networks.
> > > https://lore.kernel.org/netdev/1447811024-8553-1-git-send-email-lorenzo@google.com/
> > > 
> > > In that sense, holding a port seems unnecessary.
> > > 
> > > But there are a few concerns like
> > > 
> > >   * someone could use the feature for server and reuse port
> > >     too quickly.
> > >     https://lore.kernel.org/netdev/1447879416.562854.443622857.62708268@webmail.messagingengine.com/
> > > 
> > >   * it's a bit worrisome if this feature is viewed as a way for
> > >     resouce management.
> > >     https://lore.kernel.org/netdev/CALx6S35Q_pc-vBNpA0hipn5K-vSmPDsV-V=D13sODESNO7Htdw@mail.gmail.com/
> > > 
> > > Considering these, it seems fair to only notify an error
> > > via epoll or blocked syscall and let the application to
> > > close() sockets.
> > > 
> > > In a thread, the author mentioned this :
> > > 
> > > ---8<---
> > > Its purpose is to interrupt
> > > blocked userspace socket calls, not to release resources.
> > > ---8<---
> > > https://lore.kernel.org/netdev/CAKD1Yr0Gpr6Ex2i1TXEWyETn48P4g5vBvFZ9=_g+Lz_7-PqBDQ@mail.gmail.com/
> > > 
> > > Also, there was an assumption that a sane application will
> > > close() sockets after receiving errors.
> > > https://lore.kernel.org/netdev/1447972381.22599.278.camel@edumazet-glaptop2.roam.corp.google.com/
> > > 
> > > And yes, this does not apply to UDP, and sadly UDP patch's
> > > thread has no such context nor discussion.
> > > https://lore.kernel.org/netdev/?q=udp_abort&o=-1
> > > 
> > 
> > Interesting, thanks for taking the time to dig into this.
> > 
> > > But anyway, now I think we can solve your problem more
> > > easily, see below.
> > > 
> > > 
> > > > 
> > > > > > out these fields in udp_abort(). Instead, just unhash the socket, mark
> > > > > > its state as TCP_CLOSE, and preserve the state of the other fields.
> > > > > > 
> > > > > > Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
> > > > > > Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
> > > > > > Signed-off-by: Jordan Rife <jrife@google.com>
> > > > > > ---
> > > > > >  net/ipv4/udp.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > > index b96e47f1c8a2..01a0a0fbcd56 100644
> > > > > > --- a/net/ipv4/udp.c
> > > > > > +++ b/net/ipv4/udp.c
> > > > > > @@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
> > > > > >  
> > > > > >  	sk->sk_err = err;
> > > > > >  	sk_error_report(sk);
> > > > > > -	__udp_disconnect(sk, 0);
> > > > > 
> > > > > How about passing another flag and avoid unwanted init only for
> > > > > bpf iterator ?  This will need another layer of __udp_disconnect()
> > > > > like ____udp_disconnect() (I'm not good at naming), or must make
> > > > > sure the flag is never used in uAPI.
> > > > 
> > > > To make sure we're on the same page about what you're describing, I'm
> > > > imagining:
> > > > 
> > > > static int ___udp_disconnect(struct sock *sk, int flags, bool reinit)
> > > > {                                                 
> > > > 	same as before, but if reinit == false then avoid reinitializing
> > > > 	fields like daddr/dport while holding onto reserved ports
> > > > }
> > > > 
> > > > int __udp_disconnect(struct sock *sk, int flags)
> > > > {
> > > > 	___udp_disconnect(sk, flags, true);
> > > > }
> > > > 
> > > > ...
> > > > 
> > > > int udp_abort(struct sock *sk, int err)
> > > > {
> > > > 	...
> > > > 	___udp_disconnect(sk, flags, false); <--- set reinit arg to false
> > > > 	...
> > > > }
> > > > 
> > > > This would have the same behavior with regards to reserved ports
> > > > following udp_abort() while preserving fields like daddr. I was
> > > > considering something like this initially, but it wasn't clear to me why
> > > > you'd want to hold onto reserved ports if the socket was destroyed as I
> > > > mentioned above. If it's important to maintain that aspect of the
> > > > behavior, then I'm OK with this approach.
> > > 
> > > This was what's in my mind, but probably we could just avoid
> > > the initialisation:
> > > 
> > > ---8<---
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index ce49ed2bd36f..d44be0020446 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -2213,21 +2213,21 @@ int __udp_disconnect(struct sock *sk, int flags)
> > >  	 */
> > >  
> > >  	sk->sk_state = TCP_CLOSE;
> > > -	inet->inet_daddr = 0;
> > > -	inet->inet_dport = 0;
> > >  	sock_rps_reset_rxhash(sk);
> > >  	sk->sk_bound_dev_if = 0;
> > > -	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
> > > -		inet_reset_saddr(sk);
> > > -		if (sk->sk_prot->rehash &&
> > > -		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
> > > -			sk->sk_prot->rehash(sk);
> > > -	}
> > >  
> > >  	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
> > >  		sk->sk_prot->unhash(sk);
> > > -		inet->inet_sport = 0;
> > > +	} else if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
> > > +		if (sk->sk_prot->rehash &&
> > > +		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
> > > +			inet_reset_saddr(sk);
> > > +			inet->inet_daddr = 0;
> > > +			inet->inet_dport = 0;
> > > +			sk->sk_prot->rehash(sk);
> > > +		}
> > >  	}
> > > +
> > >  	sk_dst_reset(sk);
> > >  	return 0;
> > >  }
> > > ---8<---
> > > 
> > > When we need to rehash(), of course we have to clear
> > > saddr/daddr/dport, but otherwise, we don't, even sport.
> > 
> > What about the case where you bind to a port and use connect?
> > 
> > 1. socket bind() to 0.0.0.0:10000
> > 2. socket connect() to 1.2.3.4:20000
> > 3. diag_destroy -> udp_abort()
> > 4. socket close()
> > 5. sock_release hook runs and daddr/dport have been cleared
> > 
> > compared to just connect:
> > 
> > 1. socket connect() to 1.2.3.4:20000
> > 2. diag_destroy -> udp_abort()
> > 3. socket close()
> > 4. sock_release hook runs and daddr/dport remain intact
> > 
> > It seems confusing that these two sequences would behave differently.
> 
> I assumed from "a connected UDP socket" that your use case
> is a client without explicit bind(), but if it's not, yes,
> this will not work.
> 
> 
> >  
> > > When ->unhash()ed, only thing we need to do is to clear
> > > inet_sk(sk)->inet_num.
> > > 
> > > Then, even if bind() and connect() are called later, it
> > > works because each syscall does not care about the old
> > > saddr/sport/daddr/dport and just assign a new value if
> > > inet->inet_num == 0.
> > > 
> > > This seems a bit fragile, but TCP already relies on it and
> > > it's unlikely that we change the behaviour in __inet_bind(),
> > > inet_autobind(), and inet_dgram_connect().
> > > 
> > > And all the other users of __udp_disconnect() are also
> > > AF_INET or AF_INET6, l2tp, ping, raw.
> > 
> > Taking another look at tcp_abort() to compare how it behaves, I saw the
> > following:
> > 
> > tcp_abort(sk, err)
> >   maybe send active rst
> >   tcp_done_with_error(sk, err)
> >     tcp_done(sk)
> >       tcp_set_state(sk, TCP_CLOSE)
> >         sk->sk_prot->unhash(sk) if state == TCP_CLOSE
> > 	  inet_unhash(sk)
> > 	    removes sk from lhash/ehash
> > 
> > I don't see a scenario where diag_destroy (tcp_abort) doesn't lead to
> > the socket getting immediately unhashed, even if bound to a specific
> > port (SOCK_BINDPORT_LOCK).
> 
> TCP has 3 hash tables, lhash for TCP_LISTEN, ehash for other
> states except for TCP_CLOSE, and bhash is for all sockets bound
> to a port regardless of explicit/implicit bind().
> 
> If the socket is explicitly bind()ed and has SOCK_BINDPORT_LOCK,
> inet_put_port() is not called, which does not unhash it from bhash,
> meaning the socket still reserves a port.

Ah, I see now. Thanks for the explanation and sorry for the
misunderstanding.

> 
> 
> > This seems consistent with my observations
> > in [1] where I used diag_destroy to immediately remove TCP sockets from
> > the ehash while testing socket iterators.
> 
> BPF iter only iterates over ehash and lhash that have sockets
> with real work.  This behaviour derives from /proc/net/tcp, which
> cannot catch TCP_CLOSE sockets.
> 
> Recently INET_DIAG dump (not destroy) started to support
> bhash though, see 91051f0039484.
> 
> 
> > In contrast, I remember in [2]
> > encountering this rehash behavior with UDP sockets leading to seeing the
> > same socket twice during iteration if you bpf_sock_destroy()ed the
> > socket. This wasn't inherently a problem at the time, but it was a bit
> > surprising.
> 
> Right, this happens because UDP combines bhash/ehash/lhash
> into a single hash table (technically it has 1-tuple/2-tuple/4-tuple
> hash tables but they are not separated in terms of resource
> management).
> 
> 
> > 
> > > This patch makes another inconsistency with TCP.
> > 
> > All this is to say, I'm still not sure why preserving how rehash works
> > in the case of udp_abort() is necessary, and doing so can result in some
> > unexpected behavior both in the case of socket iteration and
> > sock_release as in the example above. To keep things consistent with
> > TCP, doesn't it make more sense to just unhash instead of sometimes
> > keeping the socket in the UDP hash under certain conditions? Am I just
> > not seeing the place where a TCP socket would hold onto a port after you
> > destroy it?
> 
> As mentioned, that's bhash, and you can see TCP does
> not do "just unhash" behaviour even with tcp_abort().

Yeah, I see now what you meant by "this patch makes another
inconsistency with TCP". With that in mind, your previous suggestion
indeed seems like the best option. It would at least avoid clearing
daddr/dport with connect()ed UDP, and I don't see a way around it where
SOCK_BINDPORT_LOCK is concerned.
 
> ---8<---
> # python3
> >>> from socket import *
> >>> 
> >>> s1 = socket()
> >>> s1.bind(('', 80))
> >>> s1.listen()
> >>> 
> >>> import subprocess
> >>> subprocess.run("ss -K -t state listening sport :80".split(' '))
> Recv-Q                Send-Q                                Local Address:Port                                 Peer Address:Port
> 0                     128                                         0.0.0.0:http                                      0.0.0.0:*
> CompletedProcess(args=['ss', '-K', '-t', 'state', 'listening', 'sport', ':80'], returncode=0)
> >>> subprocess.run("ss -tB".split(' '))
> Recv-Q                Send-Q                                Local Address:Port                                 Peer Address:Port
> 0                     0                                           0.0.0.0:http                                      0.0.0.0:*
> CompletedProcess(args=['ss', '-tB'], returncode=0)
> >>> 
> >>> s2 = socket()
> >>> s2.bind(s1.getsockname())
> Traceback (most recent call last):
>   File "<python-input-12>", line 1, in <module>
>     s2.bind(s1.getsockname())
>     ~~~~~~~^^^^^^^^^^^^^^^^^^
> OSError: [Errno 98] Address already in use
> ---8<---
> 
> 
> 
> > 
> > [1]: https://lore.kernel.org/netdev/20250714180919.127192-13-jordan@jrife.io/
> > [2]: https://lore.kernel.org/bpf/CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com/
> > 

Jordan

