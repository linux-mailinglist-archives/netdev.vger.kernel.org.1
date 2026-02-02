Return-Path: <netdev+bounces-255689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN1WLyr4f2lI0wIAu9opvQ
	(envelope-from <netdev+bounces-255689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 02:04:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E8C7B62
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 02:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E3AD30045A9
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8421D7995;
	Mon,  2 Feb 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wNciDa/e"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78E7261C;
	Mon,  2 Feb 2026 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769994277; cv=none; b=M4I5k5AtgR8l39JYomkUake57KCzT8Fokx7eJzZFVGnOTRsvB274tyDOcSLagb//UD7m1ofS1ctMnFwIL0ZhU4UhFJcd5nzlT154sosRO+gjVAjCbxs4XA8Y7XLqo1GGRUrMohP8M5rwn4DhxmjQWK9v+jdp+25/bQ7IEfiXs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769994277; c=relaxed/simple;
	bh=blI/6XpMSkoEaRMkQuPiDixpueNYq7eGa0AcyZVyJqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxPHp1+HmQLQeWTGdqb1ZBUWbNA9l4ML1lV+pctznat2XR2+rOnI7R+akhL/0PMPsGEDOa+uAAM0Mvondi0H19L3T3jX6ObyOFDHIby1luaVU0/rKCtU7qELFS+URQxaf2d7p+SaEm9l36MfMSEtoi3rWf9mEbeF+KX/3Pz1Fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wNciDa/e; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769994265; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=vb9KDZXE/qIcMRo4ShNs+GEB6mHfS4AKggCAVsbMUjk=;
	b=wNciDa/eUzq4D4B4yS3T2d5YkWHabd5U7jjdgy2QodtJR5rRwBtphAoX30WVFT+TKmK0tND+1vCSr+JpfZ2v/5nHNH71FMUzdSDQMfgfFp7mdtNw3KOdVePs7vv7SDJENBzwGkudzpEcmHHM9PVNaPdLaZpps2R50LwnY0GfzG0=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WyHXJWN_1769994263 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 09:04:24 +0800
Date: Mon, 2 Feb 2026 09:04:23 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: procfs: Fix RCU stall and soft lockup in
 ptype_seq_next()
Message-ID: <ylx2hagagfnvdkk6oyom55peoufxumumw4kph3dwozp5z2zkmi@gkcl7cw7vpz6>
References: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
 <20260130191845.404c5e64@kernel.org>
 <willemdebruijn.kernel.39472926ed88e@gmail.com>
 <CANn89i+pv6ECtn5zrPYgUfcKkoEMF1BABfxQb13yTP41QhcGvg@mail.gmail.com>
 <CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengwei_yin@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 334E8C7B62
X-Rspamd-Action: no action


Hi Eric,
> On Sat, Jan 31, 2026 at 6:50 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Sat, Jan 31, 2026 at 6:41 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jakub Kicinski wrote:
> > > > On Wed, 28 Jan 2026 15:03:59 +0800 fengwei_yin@linux.alibaba.com wrote:
> > > > > The root cause is in ptype_seq_next(): when iterating over packet
> > > > > types, it's possible that a packet type entry (pt) has been removed,
> > > > > its dev set to NULL, and pt->af_packet_net is not initialized.
> > > > > In that case, the function may return the same 'nxt' pointer indefinitely.
> > > > > This results in an infinite loop under RCU read-side critical section,
> > > > > causing an RCU stall and eventually a soft lockup.
> > > > >
> > > > > Fix the issue by properly handling the case where 'nxt' points to
> > > > > an empty list, ensuring forward progress in the iterator.
> > > >
> > > > > @@ -247,7 +247,7 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > > > >
> > > > >     if (pt->af_packet_net) {
> > > > >  net_ptype_all:
> > > > > -           if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
> > > > > +           if (!list_empty(nxt) && nxt != &net->ptype_all && nxt != &net->ptype_specific)
> > > > >                     goto found;
> > > > >
> > > > >             if (nxt == &net->ptype_all) {
> > > > > @@ -267,6 +267,9 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > > > >                     return NULL;
> > > > >             nxt = ptype_base[hash].next;
> > > > >     }
> > > > > +
> > > > > +   if (list_empty(nxt))
> > > > > +           return NULL;
> > > > >  found:
> > > > >     return list_entry(nxt, struct packet_type, list);
> > > > >  }
> > > >
> > > > I'm not sure this fix works, TBH, we're dealing with an RCU list here.
> > > > The elements are not deleted with list_del_init(), so they won't
> > > > look "empty".
> > > >
> > > > If the pt entries are under RCU protection I think the issue is that
> > > > af_packet is clearing pt->dev before waiting for the grace period to
> > > > expire.
> > > >
> > > > Willem, is there a reason for that or just convenience?
> > >
> > > That would be wrong. Do we see it doing that somewhere?
> > >
> > > These handlers should get removed with dev_remove_pack. Or
> > > __dev_remove_pack and observe the RCU grace period some other way.
> > > I can review these, but was not aware of any abuses.
> > >
> >
> > packet_notifier()
> >
> > case NETDEV_DOWN:
> > if (dev->ifindex == po->ifindex) {
> > spin_lock(&po->bind_lock);
> > if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
> > __unregister_prot_hook(sk, false);
> > /* removed without a synchronize_rcu() */
> > sk->sk_err = ENETDOWN;
> > if (!sock_flag(sk, SOCK_DEAD))
> > sk_error_report(sk);
> > }
> > if (msg == NETDEV_UNREGISTER) {
> > packet_cached_dev_reset(po);
> > WRITE_ONCE(po->ifindex, -1);
> > netdev_put(po->prot_hook.dev,
> >    &po->prot_hook.dev_tracker);
> > po->prot_hook.dev = NULL;                       // pointer set to NULL
Yes. This line is the main problem which trigger the rcu stall.

> > }
> > spin_unlock(&po->bind_lock);
> > }
> > break;
> 
> And other places as well...
> 
> I would suggest adding proper RCU protection to prot_hook.dev

Agree. Using RCU to protect prot_hook.dev is the best fix. I saw
you sent the fixing patch already. Will give it a try and report
back. Thanks.


Regards
Yin, Fengwei


