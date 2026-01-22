Return-Path: <netdev+bounces-252566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPwyIxCzcmn5ogAAu9opvQ
	(envelope-from <netdev+bounces-252566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 00:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC856E814
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 00:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9693C300D34D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27982346A1E;
	Thu, 22 Jan 2026 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GcOPTcHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545D3DBC11;
	Thu, 22 Jan 2026 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124618; cv=none; b=Zm2ouLjNgD2nlPHd1s24UhwP/dkmOLZA4DEhmIkP8JvpZUonAHeNQNSIXndopNkfbBqqIeE2E/MWldZMp0UrFEq16dy3x5o06QGoY49KQAgOX8vqFpLfKdl5hxMqoraZG8qtM5yftpo8gODN+4SXk0WfrHoH7Qf9OUKWqqZag/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124618; c=relaxed/simple;
	bh=MvPCfKICldnJEFneyBMDiDGNDZMRALwYAPI6b4cm890=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3P3p1wvyrhEzGmmIMN5swiWkYNX1Nx5q4Q0aX9isHk0PsA3nfroJMkTL/ETQmJsCL35q5td4o9fXRzCNl5YbEH0lGegAFtOUIiOz3l3+FMjlthXdFVXV6aWTd6h40eUr04rxINrI/zyJ6I7d4qZ+OTb0mJ5rLSV/2ICXxib1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=GcOPTcHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79416C116C6;
	Thu, 22 Jan 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GcOPTcHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1769124615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjDgZhcWG4pBk+7Hv/iXiqAAKJEqRhMyQlU63yMOd3k=;
	b=GcOPTcHV6HlkSwIZl57vz0/K9oCDAdd+dCXRK0o/cAc3+ob01Z89V4cqEm8yVUMyttIMC3
	/X8RnhMuOYK4LtK9yksBnYHZpmoUq9hr+9nkkn+2kyfik1J51kpqbCdAuBqChYUziTRO1l
	9+yURla09qJuw7DmhG1dcJfLSe//kaI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb8bc564 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 23:30:14 +0000 (UTC)
Date: Fri, 23 Jan 2026 00:30:11 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, vadim.fedorenko@linux.dev, wangfushuai@baidu.com,
	wireguard@lists.zx2c4.com
Subject: Re: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu()
 instead of call_rcu()
Message-ID: <aXKzA7C39tJLJWzh@zx2c4.com>
References: <20260115033237.1545400-1-kuba@kernel.org>
 <20260115051221.68054-1-fushuai.wang@linux.dev>
 <CANn89iKfuXjqKsn+xB6bpGOaqM7pN4ZcRJ=2KJg4WY76ArYXhQ@mail.gmail.com>
 <CAHmME9quqMVzD5zSEKvOFOYj3QLANAo2iYeqWQ1toV0C7gJXTg@mail.gmail.com>
 <CANn89iKmNSPjsTBwN3166cKyipJbH64ZPE0O6i2AMh7vyKXS=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKmNSPjsTBwN3166cKyipJbH64ZPE0O6i2AMh7vyKXS=w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252566-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zx2c4.com:email,zx2c4.com:dkim,zx2c4.com:mid]
X-Rspamd-Queue-Id: 3CC856E814
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 03:40:17PM +0100, Eric Dumazet wrote:
> On Thu, Jan 15, 2026 at 3:33 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Eric,
> >
> > On Thu, Jan 15, 2026 at 10:15 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > > The existing cleanup path is:
> > > > >   wg_allowedips_slab_uninit() -> rcu_barrier() -> kmem_cache_destroy()
> > > > >
> > > > > With kfree_rcu(), this sequence could destroy the slab cache while
> > > > > kfree_rcu_work() still has pending frees queued. The proper barrier for
> > > > > kfree_rcu() is kvfree_rcu_barrier() which also calls flush_rcu_work()
> > > > > on all pending batches.
> > > >
> > > > We do not need to add an explict kvfree_rcu_barrier(), becasue the commit
> > > > 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()")
> > > > already does it.
> > >
> > > It was doing it, but got replaced recently with a plain rcu_barrier()
> > >
> > > commit 0f35040de59371ad542b915d7b91176c9910dadc
> > > Author: Harry Yoo <harry.yoo@oracle.com>
> > > Date:   Mon Dec 8 00:41:47 2025 +0900
> > >
> > >     mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction
> > >
> > > We would like explicit +2 from mm _and_ rcu experts on this wireguard patch.
> >
> > I'll take this through the wireguard tree.
> >
> > But just a question on your comment, "It was doing it, but got
> > replaced recently with a plain rcu_barrier()". Are you suggesting I
> > need a kvfree_rcu_barrier() instead? The latest net-next has a
> > kvfree_rcu_barrier_on_cache() called from kmem_cache_destroy()
> > still... But are you suggesting I add this anyway?
> >
> > diff --git a/drivers/net/wireguard/allowedips.c
> > b/drivers/net/wireguard/allowedips.c
> > index 5ece9acad64d..aee39a0303b0 100644
> > --- a/drivers/net/wireguard/allowedips.c
> > +++ b/drivers/net/wireguard/allowedips.c
> > @@ -417,7 +417,7 @@ int __init wg_allowedips_slab_init(void)
> >
> >  void wg_allowedips_slab_uninit(void)
> >  {
> > - rcu_barrier();
> > + kvfree_rcu_barrier();
> 
> It seems kmem_cache_destroy() should take care of needed barriers,
> at least this is what is claimed. An rcu_barrier() or kvfree_rcu_barrier()
> should not be needed in wg_allowedips_slab_uninit() ?
> 
> Probably boring/distracting, I do not expect anyone needing to unload
> this module in a loop and expect this to be ultra fast ?

Okay so I'll take this patch, and perhaps amend to it the _removal_ of
that rcu_barrier()?

Jason

