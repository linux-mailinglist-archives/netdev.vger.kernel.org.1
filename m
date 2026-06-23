Return-Path: <netdev+bounces-301399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aTT4H+OjOmqyCQgAu9opvQ
	(envelope-from <netdev+bounces-301399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B44D6B841B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:18:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=erYQ52Vc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301399-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 574C630A6684
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89613D7A0C;
	Tue, 23 Jun 2026 15:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8633CAA50;
	Tue, 23 Jun 2026 15:13:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227581; cv=none; b=GZ1KLl233sjNsDH1ycIWO4pLSe/ofIy2zz1lUM/0054cAo0ojKbuj8YdgWypBUJIdq09xDYHgGzs+kiVWnsLONpJhIMbaBFE+OzNVQP1w8u06TMoMcMrtqgvWU0B8bgiPxADUmuaZ+cxqKUsqDa7hQZmEOcKGwSwZMQBJaQM5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227581; c=relaxed/simple;
	bh=UvRb/hJ75yqmD7KOHsYc8RNxW1ISLUNyRcOHSB+mnKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XiKofQJ5VqdGEtISxMYpNOCw1lhug6JEkI7G+KWKd2b04EWozOYSOnV7BcKuFhXtpav8niuz/3qXqA5iqRu/LpO6V/WTkispeM7QLNtEEywBoOxX3B6HhXJFysBYr+zD0ZE67yPvcWnH4GOns0PPTCZKV1UXAY9nSJ+ICs1XQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=erYQ52Vc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9731F000E9;
	Tue, 23 Jun 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782227579;
	bh=AtvjKrQjn0yaOECYG651fhjPbVJqsgT1jFVa8oh13/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=erYQ52Vc0wahfFEjC5jkxkoH7jgtKIkO3enH8kHCLnp8lS8V9OfV6cyOeFWe4dBhG
	 BLIDAtScWu3JcuLHnoltUE340UnQIkmw+LJEVKLoKL3xetwwmBLsozVNK0N+Ba4MhS
	 3exzCzkutIxDMbY4VA11dhwknIjPrSRAFHue0FSM=
Date: Tue, 23 Jun 2026 08:12:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Andrea Righi <arighi@nvidia.com>, Arnd Bergmann
 <arnd@arndb.de>, Ben Segall <bsegall@google.com>, Breno Leitao
 <leitao@debian.org>, Changwoo Min <changwoo@igalia.com>, David Vernet
 <void@manifault.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Eric
 Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, John Ogness <john.ogness@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Simon Horman <horms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-Id: <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>
In-Reply-To: <20260623142650.265721-2-bigeasy@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
	<20260623142650.265721-2-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:pmladek@suse.com,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301399-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,amd.com,infradead.org,suse.com,chromium.org,goodmis.org,linaro.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime,linutronix.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B44D6B841B

On Tue, 23 Jun 2026 16:26:49 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Provide a deferred version of the WARN_ON() macro. It will delay
> flushing the console until a later context. It is needed in a context
> where the caller holds locks which can lead to a deadlock content is
> flushed to the console driver.
> An example would from a warning from within the scheduler resulting in a
> wake-up of a task.
> 
> Deferring the output works by using printk_deferred_enter/ exit() around
> the printing output. This must be used in a context where the task can't
> migrate to another CPU. This should be the case usually, since the
> scheduler would acquire the rq lock whith disabled interrupts, but to be
> safe preemption is disabled to guarantee this.
> 
> In order not to bloat the code on architectures which provide an
> optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
> __report_bug() and does not increase the code size.
> 
> Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
> macros. Extend __report_bug() to handle the deferred case.
> 
> ...
>
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  		 */
>  		bug->flags |= BUGFLAG_DONE;
>  	}
> -
> +	if (deferred) {
> +		preempt_disable_notrace();
> +		printk_deferred_enter();
> +	}

For some reason the comment over printk_deferred_enter() says
"Interrupts must be disabled for the deferred duration".  Is that the
case for all the printk_deferred_enter() calls which this patch adds?



