Return-Path: <netdev+bounces-301585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GSUyF7WgO2ohaggAu9opvQ
	(envelope-from <netdev+bounces-301585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:17:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE016BCDB7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:17:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="B/sjaLMB";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301585-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4874E3007B8C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830E39E194;
	Wed, 24 Jun 2026 09:17:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90195399000
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:17:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292659; cv=none; b=QXWxGwnprCf9y8IVx2PT4/tdATZPuszNQUYMCp5dfzfUwEJSOmFs5JhCmmc1OL3faDnndXVPWgC1sxbt+9o9txPYJe/Ooiobuchzo7CRFB0MT3Ca5gbS2CMBgIzVRYQ/znDO1u5J7xCDAgMIXL9a9RCM2p4o4iyMvp90FV34AlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292659; c=relaxed/simple;
	bh=Bejh2jagMXk07J4vN4q2aCTB4moMnQx6GKX/VG2wuG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4vAN5FW91PNCdfmizfgsliZWwiiHGB9uOnmhKKffv3HOAhAAHxNZVlymriTphlFRPbLpKjHuU71p5fyB+4x9lw7cdfZtRsc9zbo3K4ONHzR+PytVhWCVDM+JSD11q4I1QXXjG+e9uXZiuyLf3br65AtyDfB34uVz6fMUp0yVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/sjaLMB; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef29c5561so494662f8f.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782292657; x=1782897457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMXKleFLZJBIvs4jrEU9E5muXUV27zhjMd5mE+UdPj8=;
        b=B/sjaLMB6nAlbbf9q417kai5w3xaUy123LfVkb4zDrtpTh1pQZkktJkubd+iq5uf9K
         AhbIodh1aWeSKEFODQniM/Mqw6qympLXuS55iciEjhCkq6Axj6WFZV1SJQkvexAY/ga2
         1D/N61bsrywot1M+SeLwsHNanqyEQ9+bRxHOfB4JeVJ2FZqFm1Akmpo+uFzJGnfaoSkk
         ZxpHlvisuziaymWS2BAduhBjIbaBQOpk40DSMsvURErm78Se1YZLVkoERgtqi5pqAgm7
         f6FW5/YxcIc+rQC0qRsFQiwwFUfY1ioKgyavbTZz7aAgolNMcHKPrAGvHBVJYsOxxxaX
         3R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292657; x=1782897457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMXKleFLZJBIvs4jrEU9E5muXUV27zhjMd5mE+UdPj8=;
        b=iW2BswS7bWzxE28uVB7zHWRQWrAJW3faU4crpGJvMClQmmIZYmiBvFlW6O//cCPz9r
         0AezLBhzHvPEZPH0h/JH+D39h45Ylx9e4keEW27wtQAi5+aCJ/tWdAI3yxJY/qYTd5BI
         7h8MxgpZo4EHIriUSMbuNEdGYapiTwSqc28Q43fXwyWDOxbNGG5ig5peNFeX4prgJp/5
         bT6GfPj8rapeiWUpHGuHnxWAbRUiikwH9IRUzHdMDySI5qjaMpOcZ0UxdQ8+yd2XPGRa
         uzCWcv181oC/VXKbMPIo6wefwxkeEJIp2uXQDBibjh22XvzqtWadjNFjcEFuWR1p4pRk
         wr+w==
X-Forwarded-Encrypted: i=1; AFNElJ9fsI4B1124dBLX5aUHqECv3+UKvrpBO1pJHoEip5Ge7wioznVOeWIP5qcQlaXy9Aszc0E0R+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJpds0FSUHDjjSptjIbC0s9qdk/Ra/fvefmIPbUNqH7kxJToH
	LTCrgp2ldMdAvvAy9ARKPF0m6Xke9uc8WBrCxT067phuiYmIeXsA7F06kT1W63TlWF0=
X-Gm-Gg: AfdE7cnEO5J60pZMy4749fk0A/DFjSUaAOb5HcXaRRqpuI2GXbQ4dUO3wbCuGb6nRn6
	R3HPdAPSp/fdH2Sq8TNHAce/FPPMONi0L0oTPWBDV12DYFGiCTQFGG6JXDXRhMd1NK2AQVgKwDR
	roh01ol5L4JO+m3nqYFPsnBXyQd5RU9X2HlZ73atgV00ryYNfh7JilrTVNnWM5oTZPcqdp/xnCy
	5Dap28dtpodkyd7kROmyUgjftD0wZR/68H0cJYAj20q22WS7itKkb2ZBxljkaDAV0aM8YUM24ye
	b4jIk6l4zRCXrVxafIEZajFhVOaaQykLT3usiQOVfzqhF8RdMf85/bsROD6lYxz2BhUELpuAkeI
	teFrdUU7xAudj0Yiv8c4EnwWRasw0YQm4msylOYIvDA+iAWw+u6xp65JRjsZdZ66ZK8K6Ydbrbx
	Ee8HcPxmbj25ce/k8=
X-Received: by 2002:a05:600c:1d16:b0:492:5855:1548 with SMTP id 5b1f17b1804b1-4926087830amr31471525e9.27.1782292655197;
        Wed, 24 Jun 2026 02:17:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm412331495e9.4.2026.06.24.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:17:34 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:17:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <ajugq8VAciqtMx9F@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624062642.5DER6vrP@linutronix.de>
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
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301585-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:kprateek.nayak@amd.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sched-ext@lists.linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:arighi@nvidia.com,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:bsegall@google.com,m:leitao@debian.org,m:changwoo@igalia.com,m:void@manifault.com,m:dietmar.eggemann@arm.com,m:edumazet@google.com,m:mingo@redhat.com,m:kuba@kernel.org,m:john.ogness@linutronix.de,m:juri.lelli@redhat.com,m:pabeni@redhat.com,m:peterz@infradead.org,m:senozhatsky@chromium.org,m:horms@kernel.org,m:rostedt@goodmis.org,m:tj@kernel.org,m:vincent.guittot@linaro.org,m:vlad.wing@gmail.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,lists.linux.dev,davemloft.net,nvidia.com,linux-foundation.org,arndb.de,google.com,debian.org,igalia.com,manifault.com,arm.com,redhat.com,kernel.org,linutronix.de,infradead.org,chromium.org,goodmis.org,linaro.org,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE016BCDB7

On Wed 2026-06-24 08:26:42, Sebastian Andrzej Siewior wrote:
> On 2026-06-23 20:24:02 [+0530], K Prateek Nayak wrote:
> > Hello Sebastian,
> Hi Prateek,
> 
> > nit.
> > 
> > Instead of replicating these bits, can we replace that return with a
> > "goto out" ...
> 
> sure
> 
> …
> > ... and replace this return with a:
> > 
> >     return (warning) ? BUG_TRAP_TYPE_WARN : BUG_TRAP_TYPE_BUG;
> > 
> > Looks a tab bit cleaner to my eyes. Thoughts?
> 
> It sure does.
> I wait for PeterZ' executive order to either do this and sprinkle sched/
> _or_ make legacy consoles deferred as it is done on RT.
> 
> Petr, was there a big push back doing it unconditionally?

For Linus, it was a no-go, definitely.

The problem are situations where the system gets stuck and panic()
is not called. This is why nbcon consoles switch to the atomic
mode in some emergency situations, see nbcon_cpu_emergency_enter(),
for example, into __warn(), oops_enter(), rcu stall, and lockdep
calls.

Moving legacy consoles to a kthread would prevent stall in situations
where printk() is called from the scheduler code. But it would cause
that some other stalls become silent.

In my opinion, we should not move the legacy consoles to a kthread
by default. I believe that the rest of the kernel is a bigger
source of possible stalls than the scheduler. So, the overall
experience will be better if we keep the status quo.

I would vote for adding the WARN_*DEFERRED() into the scheduler code
at least until majority of console drivers are converted to nbcon API.

Best Regards,
Petr

