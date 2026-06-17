Return-Path: <netdev+bounces-300116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E1q8IkJ0Mmr20AUAu9opvQ
	(envelope-from <netdev+bounces-300116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:17:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F185669867F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:17:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=aVNC3uOY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300116-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300116-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AEAA3143EAA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD93DE431;
	Wed, 17 Jun 2026 10:12:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950603DD513
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:12:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691135; cv=none; b=rYK8P48rfBC6WQ7wYp5BLUmFwOd8YUXfU06FQyETCfedVzcIbar5y2y8IEIfmxUmFgLa6URkFzGGw4X13s5HjSAnVa5SpzHpbHuCQ7G8hR/umRTlz14T7NasXkaydpFBLFM/7vhTwf3XgFmJD/gRD2xnRGogjlFK7YZFEXfUAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691135; c=relaxed/simple;
	bh=zqiyKisxnhy0xgzQCFdf1v6HFhpfFmktZ4vRlTJ1+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+jMwu5kQfAcmd0XYhTNIsnrI7h/0qdMs1ZBQjfTg9fmEydl6HJaGmnGw2Ok/BmrAaBOFL0f9Y8Cxn53qM03xcf594ukAqAWf9SmI2Nchlp5RJWcYajNBT4uKK3Q83+6eyN6LPW2c5ZZmslcnfL+/ACQR8i33ZSSYopnuRspqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVNC3uOY; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4908b92904fso69236355e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781691130; x=1782295930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9e/QpG56/O5B7hSvy+0kATSJ4lRQbuxYrUIyg9GDMZQ=;
        b=aVNC3uOYxjkigJdmFFgZzwQIAsMOd7t2U9Y9CxIRKBiJHROx6zN1bkNFmyKZq7D6bE
         rhA3HFT6VVTz/Of1zcXQ/O9To9BVF7w5nu/rETdfvabpgspwdHah6IoUcLXSZReKMNik
         0nRNo02h9ofSWFLhFY+fJGkQEOgPhlld1fpfcYRnZAZ2R+xXdc1YQtgMczTO+kUtctqJ
         Ig6gpYl+468auogQ+z5vmsQoXeTQj41CPzvLrKeM632JVK7AUk0OFU8TRm8lpm/eAwxQ
         pcuobJZWHmNLtS2TkJKJzy3vRAXv4tDIcmooP0up4aWeHLAUlaHJn2nagqPE6pKMEtS8
         iuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691130; x=1782295930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e/QpG56/O5B7hSvy+0kATSJ4lRQbuxYrUIyg9GDMZQ=;
        b=Nrz8DBwcXxzeHK0FdknEPUYlLnv2MSOsL/CTz48cZwI3Cp7RlFIy9mJpg8H58Z25qa
         uwjgNt9ywjBhfzvfv8jnI+xlXX1Sql65yBZ8nqUiECVEAL0Ogu6guLb2pn7a/srZvzaM
         xrxSAnn2EISotHbMOFQH1tfbarydm3T5rsGGlrM1zX1oNZ1uMksqkreDfJQSS4RAC/On
         0/ODnYfhWe7BAxITZoKOKqfoK2HoKWuVVWR9q0Zh0B3n/NnhuzavVm1S33wOAblhSYKk
         Lh6fG4MoHXeGicbwIo2KgZA/y2IEcQ1ZeCNRSB3bGxnD7F2zm3VO53Ae9Hi2tvico+n1
         /DUg==
X-Forwarded-Encrypted: i=1; AFNElJ/Lb83sUgFMGK1AkXaDl1xNTZGWEOhR+13tplHOISC6/JKBezZKrvgSbPy9zJJ+i7nzXl44YeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5suxf+ds7Q6Q5+Z7Etop7Eqb8ZLR+Dfum6XPUqV+UL6d8xI4
	5WdRkwzoDkgXMEJNi6KNwaN557W4ZyCpO53/xdrNjEZZk0MPoHGm4juZCdQJssx9okw=
X-Gm-Gg: Acq92OHrvqVSocWOkCE0V6aYMZhfEm8R3RBvsp6403kVQvZs04DxsnEeDu5Ov5hZgXD
	LBotIzsYCzyWga4QRICXB0mVMDm06Mtdn7GMfPIgfKMG8AESRCEgjvlU5nrVqxlfVcKD+rFXUVB
	89eoqyY4pIWHB7ZaL4sMCxbdBsP3G+eCyG49qsqr+Pjd36YVilSbKRIAtZ0fCaE/ilPRyspOdCO
	J4Ob6qxwx5tk4lwaZSNGRo4Sfj0DH28LL+jE5W83fDVHoaW1SFUwriO4JtUlrxRjoNpOuSt7vGK
	WOha3rLS8ce4l/5lGhV45Pbk12aRrP9R/SSthTXqb7w2Vb6a4uJy5pG7lvcbbjLGbd73c+F4gLE
	Xv5IJ9vHwJ/Z9LhRxcrhbpVek0OQXJnpKd7M+hkKN+2r5SphkhuPGcYYcW+NafZSlk4eeY4kRzn
	lMePlihySBtpmz75k=
X-Received: by 2002:a05:600c:470d:b0:492:25a1:e2f9 with SMTP id 5b1f17b1804b1-49234131e65mr39184075e9.26.1781691129811;
        Wed, 17 Jun 2026 03:12:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923686fffcsm1799745e9.0.2026.06.17.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:12:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:12:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ajJy92ES-Q8ro97A@pathway.suse.cz>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
 <20260616103529.Yh9Dxsjp@linutronix.de>
 <20260616081128.04e2c8dd@kernel.org>
 <20260616153122.keHMKvVT@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616153122.keHMKvVT@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300116-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:senozhatsky@chromium.org,m:peterz@infradead.org,m:vlad.wing@gmail.com,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:mingo@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:kprateek.nayak@amd.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,chromium.org,infradead.org,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,debian.org,goodmis.org,lists.linux.dev,linaro.org,arm.com,amd.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:from_mime,pathway.suse.cz:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F185669867F

On Tue 2026-06-16 17:31:22, Sebastian Andrzej Siewior wrote:
> On 2026-06-16 08:11:28 [-0700], Jakub Kicinski wrote:
> > > 
> > > Adding sched and printk folks for opinions while eyeballing
> > > WARN_ON_DEFERRED().
> > 
> > Thanks a lot for looking into this! To be clear - the printk_deferred /
> > WARN_DEFERRED would be just for stable? Or there's still some
> > sensitivity even with nbcon?
> 
> We already have printk_deferred(). WARN_DEFERRED() would be new. I
> *think* this is not limited netpoll/ netconsole but all console drivers
> not using CON_NBCON if the printk (via WARN) occurs with the rq held.
> I don't remember all the details but printk_deferred() was introduced to
> circumvent this until printk is fixed.

Just to make it clear. The problem with the legacy consoles is that
they are called under console_lock() which is a semaphore. And it
calls wake_up_process() in console_unlock() when there is another
waiter on the lock.

> Once we get rid of those legacy drivers and NBCON is the default we can
> get rid of printk_deferred() :)

Yup.

Best Regards,
Petr

