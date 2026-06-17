Return-Path: <netdev+bounces-300156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bpurHjaMMmp91wUAu9opvQ
	(envelope-from <netdev+bounces-300156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:59:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFA769965A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:59:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=M6qD7bvt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300156-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300156-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5591303126C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7D227B94;
	Wed, 17 Jun 2026 11:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595A39E19A
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:59:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697573; cv=none; b=lVRQWjWBfI4rCSo6otYWz6ECPJh10M+KdzOoefvnS5Hn5qxG044VcCMLuvntvLsc0abpaXbKK/NJl5PjHJbJGw0mfg2SlZlka0I9HEgEgr4oF3SLZ4SnBA99rtjZkUWzzyeVwH6B18DW2GhFTHUlUD//bEQdkneepoWZDr/zh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697573; c=relaxed/simple;
	bh=cvsxccTzFVOpMQezm4HlOWz2aB8KWwD6zxOBa9D3eA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj4cFemLqcy2NUNESfazY5BbcMMbThF/5+S4ZbwfUN5DTcQ/CpGxmjticveGn9dEWBBUtIQVBzcvbElAeoOpNpssxQOaVGB/giR+Zenf0cgrMjEB2oHC4TYydr/EEnkR7nYKeRQ8k+g1aAnLPpDbFgEjxJBYwbu6ewjSCsBqi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M6qD7bvt; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso8542395e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781697570; x=1782302370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFy1siI5GPA02P4SigwJOvEY2/GCKPj1mDQV6Az/rvE=;
        b=M6qD7bvtZL4WoGDeCzK3htwiEAuyM4CktDeM5fxxmuqw8gryeGiBqYiMqXeDX0TObt
         ZhwgjWODAUq1Wf3Ii+fDS6wIbRIKznp+VbtnNcMlXDPeRTSb35z7nADRBqaaQQJpu7c5
         E+wQDUsA8ekgkOZFpVB+TO4QInOdJdP0boeMLaa7Jm+N+CRknJN8WskaFdqdSBs19MsJ
         eGKWMVRPZzLWCQU6WqgGC1mSSdRD/AcSd5UzNGZKVBVNC6xyNW6sQLx4BqpiZ+xh4bnR
         kH561LSvnpzCGzIWt+h44lsPyKA5JUitnlXOYfdn+0QaRB9CPyOj+PXMEt90lJWu8pBR
         H3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697570; x=1782302370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFy1siI5GPA02P4SigwJOvEY2/GCKPj1mDQV6Az/rvE=;
        b=SDu06JaDcrpPS9kVyQ4Q5SvrdyTUbogETxjCiflrYKJ7TCO38pt0PFrTqm4tElfHRX
         AkncAAGimr+HfM3KLYnhS+/Fq0otKoxg/75uYhmlXxVqvrqnPwRvWvZLKJHOECBFvmeg
         gNzuyME2tP7AvXlBx3LCj3G1qmstzhwm5airuoQhwr9xBUnKxe0yW6pAt1yaNdmCWl9G
         IaBSveuR/5xCqGaFRmi5peJs80UZ/Zezm40Wzvln1zfqn+AzKu5PvLqnwMKtXEiY2wsb
         GXCg5ULgFDDkT2n0EZBOyN99r3NZAa8tO5mnS9FrfNPruEYEy0AXfC8iLKt9P3FbfZZL
         wufA==
X-Forwarded-Encrypted: i=1; AFNElJ9EPH67j/bDaFO1Nnx0jxpKoMpAb+PEc1/wPK4DyUxsymrdOB1jLuVf2UV4RBVVub2UP4sMbGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAreu58TTTAUSGMNPxPTt7unHHWbdKtCE6xuAY7WuZSIRu+gI
	lJLbC66VBPJ4/fNTuSJqaeItJJy9sBoIKs3o5aIq7aO7DB7HUIG3aO0knAOpNcDt4veh0J84OYv
	fXSBe
X-Gm-Gg: Acq92OFj7IwUIL8P+u3NCVBLl7xUO5M83m1Vw6rh0Gpoo9l1rVIageI7q3GkIqnn1z2
	xB0YTZBpum89Q8ko4PAF0XvNp2PR0JuUdxcYAfhWm1mTY3tHV3g1G7wzDnFKuuY3NhMTi3Ss5OM
	cFSoozbc4jfwShE5dh/FhkWpFN+VNQEzMzXUUpaTiKOxOyS5u7xswnhFgZu/sJKjL0uiQs5bsEX
	3pYTTDkYYNAIy6LCa6U7qlyDcdIW3Y6+hqK0OIRDtA9RX52S2+tNtK5Rmas0yz9FiXiXa3SqC20
	wcvUgEH49uZnkuH1TYLmz4P8r8bXTMfKb0k/Kf9ITVHrpvQVnu850Yemf0HpaSl/xU1to/gyabc
	oNluV5oLqXE9YDJT1MouwkGvwBNF/EiZhQasEL7E1e5Ee6+mn0xOItd7Xh2Yq3at3VhlNDkpTpn
	xkvX7PqDyYnEu2jCc=
X-Received: by 2002:a05:600d:8450:10b0:490:4035:323 with SMTP id 5b1f17b1804b1-492340e75cdmr33496715e9.9.1781697570289;
        Wed, 17 Jun 2026 04:59:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm48879291f8f.14.2026.06.17.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:59:29 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:59:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <ajKMH_LmiZhjNlOW@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
 <ajJy92ES-Q8ro97A@pathway.suse.cz>
 <20260617111504.GK49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617111504.GK49951@noisy.programming.kicks-ass.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300156-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:bigeasy@linutronix.de,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,chromium.org,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:from_mime,pathway.suse.cz:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AFA769965A

On Wed 2026-06-17 13:15:04, Peter Zijlstra wrote:
> On Wed, Jun 17, 2026 at 12:12:07PM +0200, Petr Mladek wrote:
> > On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> > > On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > > > 
> > > > > Adding sched and printk folks for opinions while eyeballing
> > > > > WARN_ON_DEFERRED().
> > > > 
> > > > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > > > WARN_DEFERRED would be just for stable? Or there's still some
> > > > sensitivity even with nbcon?
> > > 
> > > We already have printk_deferred(). WARN_DEFERRED() would be new. I
> > > *think* this is not limited netpoll/ netconsole but all console drivers
> > > not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> > > I don't remember all the details but printk_deferred() was introduced to
> > > circumvent this until printk is fixed.
> > 
> > Just to make it clear. The problem with the legacy consoles is that
> > they are called under console_lock() which is a semaphore. And it
> > calls wake_up_process() in console_unlock() when there is another
> > waiter on the lock.
> > 
> > > Once we get rid of those legacy drivers and NBCON is the default we can
> > > get rid of printk_deferred() :)
> > 
> > Yup.
> 
> Can't we push all the legacy consoles into a single legacy kthread? I
> mean, converting all consoles is of course awesome, but should we really
> wait for that?

I am afraid that converting the consoles one by one is the deal with
Linus. I could imagine to moving last few sinners into the kthread
when the majority is converted. But we are far from there :-/

Best Regards,
Petr

