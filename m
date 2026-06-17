Return-Path: <netdev+bounces-300123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a4DcH0d6Mmoz0gUAu9opvQ
	(envelope-from <netdev+bounces-300123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06F6989C0
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:43:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=FOOi9K+l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300123-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 011B3309B065
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10608404BFA;
	Wed, 17 Jun 2026 10:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C2478E53
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692659; cv=none; b=B1chQzTfXFbZh10T6wDTe2QBjK0D5azQTgtqSAXj8NLe1iZCkrsmlrcBbeRCe5w3lhVWgX+96yWjXNz0OzfkS5NX84VE0Ye8dRyK1p5VCRiiU2NNOS0DKtBWWrWZp2PRW1TNQKyKiG/xjUPtinViA2XU1GzuU6Xng1fnWg+rXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692659; c=relaxed/simple;
	bh=7KGOXjbFus1OIBdwidGkbmaAhe5QXQQ88pd8jQjhpr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzsDhpUl88AkBxcOeXbz6caM7DGkRXNcpP+609EVKEpKZ4hMC+WrJin5ggcXv7EDOT70QJtObGxMk029rUxyjGEawBSyfPIeaqZnLlw4912b3ZbdqwO/B+rFDyueuF8ZZKqnkl+ckVftaPk+ElgAi/WtKV7FhVAEau3NZl9+Hco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FOOi9K+l; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4631679f204so149285f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781692653; x=1782297453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDhvQwG1QwT5cvmH6BZBllkhAVPQhK/Hew5ZXNgViMA=;
        b=FOOi9K+lPc3v+6COO0rMCTOQ3AM873AfxCLoKarEiH1Ej1VUNSWBjEAAiyw3tUPkkD
         c9I0dzihqELjE6ZHumASv3Nf4iZQkeTGWj4F0qowRseXhSHpydhKKRqgZps5BLVv9ihZ
         Pga7G4IDRuigevfhv0Enzm43Yx9q+Quy14IPb9fGjn7yEWZH1jOsoGn/KAIsjTfBZn5C
         T07hWdfivi8vVrYBA4g9wBHZ9YBEjby8LU10yzg700/mOTl919lw4dg1V8oSuqRqZyAe
         AS9PRFOShvz91InygEc88rzu99wiCc2FOvowixLqlIu/vaGdeXQ4VzU+X6g4NBuBPr3R
         D5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692653; x=1782297453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDhvQwG1QwT5cvmH6BZBllkhAVPQhK/Hew5ZXNgViMA=;
        b=DC02J9ci6jTffWJWCO+kowCqIlMpepSIxuxMHZjPehtf/ChRoIRGVTgMcznhnkTxzi
         tMLZajndmq+5IfYpYhFQ0+Ml/NpwbVxhVUvziD3qVIXpQJkxk+kT86Rg84obeTGCprnv
         Ys92w1b+lCgPIh0PBFVxuUP7JORTns/KUNqLutBnpMfkGEuZ9x+KKXdtdRIdGrd+tTGV
         p/oi/vEm5YqUjBQHF3QpOOqrNy+U1yU8ltiA0v62AiptGJ8rlshTG1s5JmgJ+UN8yIl2
         vWcIsZqOiCOnl8EfeZEUf01nSkaA6mUbhxidbZk5akTqbvvxZSe8aw7pOm+b/gOHkkZ8
         M0hQ==
X-Forwarded-Encrypted: i=1; AFNElJ81l8Cp5e3phn2G5Qo2jOaMiTaaWEvdcbRD48HCIyzjd4Z1NeqzKfPmbpBZIFPjIT0cr5DCK08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8eAWsmX6FcqNx7qIEBYmlFJXaSDc4iM92u+DH+XTGsyw09Ed
	3tzVzZumav+IHubSrBgHvKhbbigVpZq2KQbvoxfaiFGZPOBn2mFOu61FrfNau1ib55c=
X-Gm-Gg: AfdE7ckk8uVZJu9kDMMuiXLsKnOTIv0hXM4cO/Ndi0OKSjnnEP82vTzR7yMJatUU6ax
	vYEQOPOGoon2aUG/OtnzITrcVhiKK4H+ZjfDEhAf9nmmY1L3MxQhN0+ecDypwUfxOsmi26xpzd6
	aIgpuwTUqNezC1hN0ApKsqe/X/lXyduJvDWx8NKEIhvrpHSs/zj6eDvDw7V2Qm7Ylg/kcgV5lvT
	mLtTPlFlfskjq2Rnf1Krg+aDnZUVEU1QT0ivP8WwkyvmqqX9KfNuj+RGW5W6zNskIVqznr0CuP0
	RE9LZEMSNxPDWYTQZQa551ij9UW2vpacf2dzOfiHVxvQvF2J6L3HqFtCYCDLkg64su7L+viYwo8
	NShGAz/qcJKAwUhV33VGhvc22HVz6/1qlPCZ5HJVnwdNl1XaKFLDNkAn1pMTRSmDzjCQh/WE33M
	uyfUtpbfZErcKCl/s=
X-Received: by 2002:a5d:5f53:0:b0:460:6b12:1783 with SMTP id ffacd0b85a97d-46268e1fcc3mr4236952f8f.4.1781692653017;
        Wed, 17 Jun 2026 03:37:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm57111382f8f.24.2026.06.17.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:37:32 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:37:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <ajJ46o4fomfxY5CX@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616170257.GH49951@noisy.programming.kicks-ass.net>
 <20260616141719.67684bf0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616141719.67684bf0@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-300123-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:peterz@infradead.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,linutronix.de,chromium.org,gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,pathway.suse.cz:mid,suse.com:dkim,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D06F6989C0

On Tue 2026-06-16 14:17:19, Jakub Kicinski wrote:
> On Tue, 16 Jun 2026 19:02:57 +0200 Peter Zijlstra wrote:
> > > So this is not an issue since commit 7eab73b18630e ("netconsole: convert
> > > to NBCON console infrastructure"). Because from here now on writes are
> > > deferred to the nbcon thread. So this purely about -stable in this case.  
> > 
> > Hmm, I thought netconsole had some reserved skbs and could to writes
> > 'atomic' like? That said, it was 2.6 era the last time I looked at
> > netconsole.
> 
> Yes, that part is fine. The problem is that netconsole tries
> to reap Tx completions if the Tx queue is full. We can't call
> skb destructor in irq context so we put the completed skbs on
> a queue and try to arm softirq to get to them later.
> Arming softirq causes a ksoftirq wake up.
> 
> We already skip the completion polling if we detect getting called
> from the same networking driver. It's best effort, anyway.
> Networking-side fix would be to toss another OR condition into
> the skip. But we don't have one that'd work cleanly :S

Alternative solution might be to offload the ksoftirq wake up
to an irq_work. It might make this part safe for the
console->write_atomic() call.

Well, my understanding is that there are more problems.
AFAIK, some drivers do not use an IRQ safe locking, see
https://lore.kernel.org/all/oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh/

Best Regards,
Petr

