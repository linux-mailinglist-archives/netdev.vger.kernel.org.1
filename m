Return-Path: <netdev+bounces-260783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC5fJmWnnmmrWgQAu9opvQ
	(envelope-from <netdev+bounces-260783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:40:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B21939B5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53293093469
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FD2D5940;
	Wed, 25 Feb 2026 07:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BD2DEA8F;
	Wed, 25 Feb 2026 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004840; cv=none; b=h+zGxWmG0z2aSxPTE83mggXGLiyu6cJCQbWjhjnmWXLCXGcnWeyMpSARrJcv+JAHpqqOnPC5CM+BFuontTZCdJFVUXWfM1ucUXyjQTGgRTrVTN9WMqlC7DpX4qXOm3mY772MgQ4fM8thTfAK5RIUBI6oWRG4WpUUKikEkp24k8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004840; c=relaxed/simple;
	bh=BZgi6m4klAPhvNz8rJqyfMvnYe23JRF86/BfIlYfRX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgQwbUbcuYQj4u0FqS1h78B9m5uaqg/ed0FvjTVtCw8t5bfSY0auxmTqFysdZ6ww6qTwByq1IVwpGNurta35A0ZYwS9Zz/f/SLh7uRfqM/pQSEVZ+PEITKpDzX8tGiIiqxDVhXNSrVX/N0hPx5oklVKiAzL3fmMjCV+V9UfjN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 53E7014005A; Wed, 25 Feb 2026 08:33:50 +0100 (CET)
Date: Wed, 25 Feb 2026 08:33:50 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net] dst: fix races in rt6_uncached_list_del() and
 rt_del_uncached_list()
Message-ID: <aZ6l3vTgXLsqaJHc@cae.in-ulm.de>
References: <20260224114113.344-1-hdanton@sina.com>
 <CANn89i+HrHVrV6S1fmGn62-8odQOuzyC1pnzOo+SBfN6xRZE=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+HrHVrV6S1fmGn62-8odQOuzyC1pnzOo+SBfN6xRZE=g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c--e.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sina.com,vger.kernel.org,syzkaller.appspotmail.com,kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lk@c--e.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[netdev,179fc225724092b8b2b2];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9A0B21939B5
X-Rspamd-Action: no action


Hi,

On Tue, Feb 24, 2026 at 12:58:25PM +0100, Eric Dumazet wrote:
> On Tue, Feb 24, 2026 at 12:41 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Mon, 12 Jan 2026 10:38:25 +0000 Eric Dumazet wrote:
> > > syzbot was able to crash the kernel in rt6_uncached_list_flush_dev()
> > > in an interesting way [1]
> > >
> > > Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
> > > list->prev, while the prior write on list->next went well.
> > >
> > > static inline void INIT_LIST_HEAD(struct list_head *list)
> > > {
> > >       WRITE_ONCE(list->next, list); // This went well
> > >       WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
> > > }
> > >
> > > Issue here is that rt6_uncached_list_del() did not attempt to lock
> > > ul->lock, as list_empty(&rt->dst.rt_uncached) returned
> > > true because the WRITE_ONCE(list->next, list) happened on the other CPU.
> > >
> > > We might use list_del_init_careful() and list_empty_careful(),
> > > or make sure rt6_uncached_list_del() always grabs the spinlock
> > > whenever rt->dst.rt_uncached_list has been set.
> > >
> > > A similar fix is neeed for IPv4.
> > >
> > FYI list corruption in dst_destroy() [1] happened after this fix.
> >
> >
> > [1] Subject: Re: [syzbot] [kernel?] INFO: task hung in restrict_one_thread_callback
> > https://lore.kernel.org/lkml/699d155f.050a0220.247d23.0377.GAE@google.com/
> 
> Seems unrelated.
> 
> Are you seeing anything wrong with my patch ?

I'm certainly not an expert on this code and I might well be wrong
but it seems that with your patch your are racing against a list
delete in rt6_uncached_list_flush_dev which removes the item from
the list but does not reset dst.rt_uncached_list.

So I think you want to keep the list_empty() check but do it
under the lock?

Best regards,
Christian


