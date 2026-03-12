Return-Path: <netdev+bounces-267023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJLoKnyesmkOOQAAu9opvQ
	(envelope-from <netdev+bounces-267023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:07:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DB4270A3B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450D6307E86E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30C39BFF3;
	Thu, 12 Mar 2026 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lo1fbn9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D339B971
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313585; cv=none; b=Za+yeLagmpqQsUV6YsSQScKsJ5dtQb0CZObd375mRDqHzrlWbQz5qZKp1TrTAXQh9+dOs6MxtI8ZQahekbDITuQrk9GQPpHzMQyCrRMGM0hO5Y6aDrOiengLSbkCjB2rjzRLJ/UATeXqqfqHmr08eBEEzVCDGGm1WbstNxf9UAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313585; c=relaxed/simple;
	bh=/9J3tVGfkbfc2ZVBxryfqsIyn/sMRAL1gB1bZI9O198=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otUfTzMOsH4wvVw5bDkc3bUVQK8fOlujzgpAQm8eSRFwSd3qKUkbtOChOMbGJSitlnd4M1Uv/KK3rX4DI8/Kj+5SsyfPZlwtDq0VHPlDXcrID7Yv3fnApHuAt+aYD3G8OipUEVTLldkT4g4dxd5Y8BcuUI9YpmQ9lqDVkEzOuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lo1fbn9I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so7853295e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1773313582; x=1773918382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xi90ehS/6At/d9Hc+H9BmnTyiPTBQruO8CzKtDXyqkU=;
        b=lo1fbn9IUDe5MIIH1gniUfknj20+xbZ8vY5+XQiNnxehi4LaS6doKTkpmlD7GG92oE
         ne8w9eOgJWzf9yXUKxgVbHk7dfp18IxPzx+fqsVOQWdNh/W3qIMW2Tt+mWW/QhzBvO+F
         hKjv59akDwk7lecfhignf3LR+JJEjNWZ0s+snVtIPWetzHU4RaWAIlPPDA5DGlz4rfaY
         SK5ECTrPjRv4dLQwWc1VlRGe/NvEkCLouTmZpaLGq40unimcx1te45kmCcUaZraVyYqa
         TRQApYBMjSZKLhjItpWk+wISDadaC9ZyCSg7NRrPftjWXUeD7fpT7lFJah2rA+q/LEpa
         StLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773313582; x=1773918382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi90ehS/6At/d9Hc+H9BmnTyiPTBQruO8CzKtDXyqkU=;
        b=jau8NH8FqecHJwEBHANgR4iW11qyZtaJ1TlK4C+nu/iKw4ZORvkLI9zN/ZHq9gq0fQ
         R72meKtaURqicGf10ELBKkYPbmlwCGH4RpXP/Xm7u/DGGoq3XOu7tyvB5WopDBL7p/EH
         9kU1pwNPl8lU8l2Sjonl1iJcRR7rpVuqAy2nfR7YAHgXiMMLGyAvmF62okTuuS5PdcSQ
         J8oaxlIKmlN5+M8byzrPeNryB85PeaIsIXX5icynx11+lF8O2RXAp5Yf1DnDnuZgIJa3
         KlccTvmgLPc1jrB4/Q/SjSSXT2D3wbsyOEc5MNaFLitxfiL9m6LiXX0yTtAj7AXBQAsM
         IuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK9+UJSWCMO6SxFsmGnMQ4ly32kqrpDDNFXwfbezYzMHT7Y2xMb1Wh18ya/6+XcyC8qiXHfyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnslwtalWUPu2mwSWG7OZIZEvKtWM8SGxoQcWYcJEGXUnSszR+
	I5lsGs3ZHvqLZjY6bwcTDvgLtDsJMKKcc4paswJRLcxyn0JJejkZ7acSkWcb5pzXOpU=
X-Gm-Gg: ATEYQzyJ4AOy5IZvuVt7fwapiObfyOsP0p4LrP0vM4nUeoPsqWEXTR5IeNVFbMIUqUu
	JYenHlrx1f53UKOYke+ra7FDXja5maa0oOjXn8+iTabX0Y7p/0hYV1zkSYhh0eVm7RPNmSNERyv
	wf6nDITENkn/orG5XBcY84LldPjplYwoRVAjd24psnYUpqh1CLl4VLPo58hH9KCK+QWq0MLzVKH
	JV7tmsISuKiN2+kR9t8xK+SGS4uiiu3n+RAPIbjg5GnB756Eau+u64RurUXIKk8WD4uqp8Z8Hr5
	Zu0+GmRc+hyQzTMvVW1KtCeMnr38xszEdcO2D/76IRacJNWCiLJo2KTxggxz5LeLtPxhrML0ikR
	A2dZlqTcOtm89o0Od2dTbcWx/A7yCTfkSU7G5rJwz20PeATOGpNFkm/kiXM94uSZC1tFsWCQ8k1
	nZRZ2spczsX/YlZI5OW1ePLHvfniplNCDOn13ME46z8pJkLU+Wx9q+ztgDLNT9ATJk+SAb
X-Received: by 2002:a05:600c:4752:b0:485:3692:e906 with SMTP id 5b1f17b1804b1-4854b0c77f4mr96011415e9.13.1773313581497;
        Thu, 12 Mar 2026 04:06:21 -0700 (PDT)
Received: from localhost (176.111.184.239.kyiv.nat.volia.net. [176.111.184.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18ddedsm108978795e9.0.2026.03.12.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:06:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:06:19 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <abKeK-w7K7xLuWAH@penguin>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev>
 <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin>
 <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267023-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,linutronix.de,linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,shopee.com:email,blackwall.org:dkim,blackwall.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8DB4270A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:36:20AM +0100, Paolo Abeni wrote:
> On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
> > On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
> >> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
> >>>
> >>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
> >>> <razor@blackwall.org> wrote:
> >>>>
> >>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> >>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>>>>
> >>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> >>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> >>>>> when the bond mode is round-robin. If the bond device was never brought
> >>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >>>>>
> >>>>> The XDP redirect path can reach this code even when the bond is not up:
> >>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
> >>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> >>>>> interception is enabled for all bond slaves system-wide. This allows the
> >>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> >>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> >>>>> reached on a bond that was never opened.
> >>>>>
> >>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
> >>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
> >>>>> never opened), fall back to get_random_u32() for slave selection. The
> >>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> >>>>> publish the pointer to the XDP read side. A plain read suffices for the
> >>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> >>>>> under RTNL lock and is the only writer of rr_tx_counter.
> >>>>>
> >>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> >>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> >>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> >>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>>>> ---
> >>>>>  drivers/net/bonding/bond_main.c | 9 +++++++--
> >>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>>
> >>>>
> >>>> This is Jay's patch + the unlikely change, looks good to me.
> >>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> >>>
> >>> Orthogonal to this patch  :
> >>>
> >>>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> >>> if this makes sense
> >>> for the packets_per_slave == 0 or 1 case to haves this kind of
> >>> randomness in the first place.
> >>>
> >>> Perhaps we could use a
> >>>
> >>> static DEFINE_PER_CPU(u32, rr_tx_counter)
> >>>
> >>> And :
> >>>  slave_id = this_cpu_inc_return(rr_tx_counter);
> >>
> >> I also have mixed feelings about this patch.
> >>
> >> We probably should detect that the device is not ready before hitting
> >> something deeper in the stack.
> >>
> >> Sure, a NULL deref is avoided, bu what happens next ?
> >>
> >> We send a packet while the device is not UP, I am pretty sure this
> >> violates at least some RCU rules in device dismantling.
> > 
> > IIRC when the redirect continues, the packet should get dropped if the device is
> > not up (checks at a few places), but that's outside of bond's jurisdiction and
> > after the slave id is needed in xdp master redirect's path unfortunately.
> > I'm not sure it can reach much further, it just has the master dev's slave id
> > generation in its path.
> > 
> > In any case we shouldn't crash in the slave id generation in the bonding,
> > that ndo's only job is to return a slave id.
> 
> I'm sorry for the back and forth, but I share Eric's concern. I think
> the approach suggested by Daniel:
> 
> https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/
> 

That will work, I like Daniel's patch as well. It will add a test for all redirects
for master devices, but I guess that is ok. For bonding it will work because the bond
has the problem only while it was never opened (before first up).

IMO this patch still has value, because currently the code implicitly relies on
a specific sequence of events, who knows tomorrow someone may find another way
and again call that ndo while the bond is down.

> or the initial patch form:
> 
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7
> 
> would be better. To respond to old concerns raised there: the check is
> IMHO bond-specific, as control moves from the lower interface to the
> upper bonding device, and the code is under an RCU critical section, the
> device can't go away before the xmit is completed.

This one I don't like, it is not about going away, it is more about adding 2 new
tests for everyone and potentially 1 more cache line.

> 
> /P
> 

Cheers,
 Nik


