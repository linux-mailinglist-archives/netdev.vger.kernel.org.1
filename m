Return-Path: <netdev+bounces-301694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id db8MEMn3O2p1gwgAu9opvQ
	(envelope-from <netdev+bounces-301694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A26BFA6A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=ahUQRXee;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=9tMnLg60;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301694-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F5C430BAC1A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9E3DA5B8;
	Wed, 24 Jun 2026 15:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F33DA5CF;
	Wed, 24 Jun 2026 15:24:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314676; cv=none; b=bAkvl/FlaVbX+ZfViYwtV3Ovou/kVXx7MkTqUi1By1ZGMXfXIT97s8Wyuamk/gl2aR/8YuwGwsYwgHHaSWMnqdbavfH4uz1v39kTQf0wRlr2C70qaVq1f5duZga/N7tnSucT464NSfE/pOBebnunRg5crEwcdE53ekd8e32Ob2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314676; c=relaxed/simple;
	bh=fsiytajv6eNJbyCkiukybDge6rLIme/uqRKFEf3Y1c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OblWcm9Ur9PYw6soIzKE7VdRSJGd3XxpUlnAZKoceBjiLIBQnQEJpLaB2sLhen4JmohOcx50A/jR7qZxCheJ9hxu6FdW7XufKApxGkbmVYTcD1DV7DZF3VbQEQeraCSAQLRGu4N5/SjK5A93y3PwCxZ+lSkYDbjsDCZLt5SYOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahUQRXee; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9tMnLg60; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 24 Jun 2026 17:24:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782314673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsiytajv6eNJbyCkiukybDge6rLIme/uqRKFEf3Y1c4=;
	b=ahUQRXeeeV84Rz5Yg77XzGuHhYAaoBCRdm1McRqx7y+mWDGflHSNa7lt6Q9OXNzXexrExU
	VdqrrgO/NyD4r6i2cals3J9t5QjZ3pLntOHSyn7S2mctc0HPlvZfKhVLt/VHjcMinP616T
	OHuE/0vVzLrKPVPjMTcPcNCOiZFeZ5KtRboW3TfX5LYotq6vNmzVOrLqNwy9m1tRX7OCB2
	du9oyIgY5AZjLZb5jvgtUzXlN/YEZ037dyAIssm/TsQXToDDfEbwZMdbua32cpkBL1Ilfk
	A4aByCqaqBPYgV7yDUzAgiNt1cStfQRsjFJFN8E3nYuK6i7/qoi+0ATslguL1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782314673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsiytajv6eNJbyCkiukybDge6rLIme/uqRKFEf3Y1c4=;
	b=9tMnLg60JUqdRsMpQfN6XFvVhk1aA3iUFCE1d6X8zsBbvcQQgvkRHjg1RrF5Nkd+0UyHSB
	TDhCtq5F0ld7g9AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <20260624152431.Ufq0jT8r@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
 <ajugq8VAciqtMx9F@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ajugq8VAciqtMx9F@pathway.suse.cz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301694-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:kprateek.nayak@amd.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,infradead.org,chromium.org,goodmis.org,linaro.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B8A26BFA6A

On 2026-06-24 11:17:31 [+0200], Petr Mladek wrote:
> For Linus, it was a no-go, definitely.
=E2=80=A6
> I would vote for adding the WARN_*DEFERRED() into the scheduler code
> at least until majority of console drivers are converted to nbcon API.

I see four nbcon serial console drivers (+netconsole, + drm_log). We
have at least four times that many console drivers. What is the
majority from your point of view? The 8250 should cover all of x86.

> Best Regards,
> Petr

Sebastian

