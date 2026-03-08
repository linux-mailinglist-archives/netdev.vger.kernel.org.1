Return-Path: <netdev+bounces-265252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAk5F98+rWmN0AEAu9opvQ
	(envelope-from <netdev+bounces-265252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:18:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1A22F233
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F92E300CFDF
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D23537DA;
	Sun,  8 Mar 2026 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="11j/Qpgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2B25771;
	Sun,  8 Mar 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772961498; cv=none; b=Hz9jO0CLQxNcaPCWXjM6UyqA7WWbUb1uaNPt5b67rslrY48JhXgKsBgpSYdo8DrXpmCSholm3qLCTiTt66jQbPIwy1ZMnhymXutb8XXcZsRloF+KRFw0tGSf+pvYzfnhD09R3x4WVq6QQyV1iKfVJ6YFT02sCKTVj+F05ntlPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772961498; c=relaxed/simple;
	bh=kVITkmu73zuBt8lAq/wExXmZyk2stvr6lP384AKd/38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPk9acYGfW8nkHZaWm1DoUNQPc0qu05RLq9uFgQ89xUO6kPmqdoLlt96xMd13aR4kHDNj5STr3oQSm4sCrnN2gcWRkLw7Ntj0oY3qhMqo/fFrO5a2kewla9pcpxuWKL5Kp4/GUW7HAVKFB2kFv0plvXBiizurhr3niMjfpJyOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=11j/Qpgu; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fTF1D4h5CzDW6;
	Sun,  8 Mar 2026 10:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772961488;
	bh=m3bY+fg21cYB5Zj66R09EdmA2pmMqEpsA8Gd0HDjBns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=11j/Qpgu6MBFqiKMqGao0sejf2iX/yzq7R8Rcznz1IOLLIGZ4cNtrxIF3GC5gsBrK
	 X2JzyzMd7F09ifZbffDYJ9mt7I0aIi0ZsEX6Uj1Va5+sCrxjmgI9sITYZyE2nCRMmf
	 A6LnZGX+os+XX7dxLKInRXCgn3BTwOdcF5mQ6Uss=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fTF1C3bH0zBdD;
	Sun,  8 Mar 2026 10:18:07 +0100 (CET)
Date: Sun, 8 Mar 2026 10:18:04 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jason Xing <kerneljasonxing@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260308.AiYoh5KooBei@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net>
 <20260220.82a8adda6f95@gnoack.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220.82a8adda6f95@gnoack.org>
X-Infomaniak-Routing: alpha
X-Rspamd-Queue-Id: CAF1A22F233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.07 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,redhat.com,linutronix.de];
	FREEMAIL_CC(0.00)[canonical.com,maowtm.org,gmail.com,google.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,digikod.net:dkim,digikod.net:mid]
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 03:33:28PM +0100, Günther Noack wrote:
> +netdev, we could use some advice on the locking approach in af_unix (see below)
> 
> On Wed, Feb 18, 2026 at 10:37:14AM +0100, Mickaël Salaün wrote:
> > On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > index f88fa1f68b77..3a8fc3af0d64 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -248,6 +248,15 @@ struct landlock_net_port_attr {
> > >   *
> > >   *   This access right is available since the fifth version of the Landlock
> > >   *   ABI.
> > > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sockets
> > > + *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both calls to
> > > + *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
> > > + *   explicit recipient address.
> > > + *
> > > + *   This access right only applies to connections to UNIX server sockets which
> > > + *   were created outside of the newly created Landlock domain (e.g. from within
> > > + *   a parent domain or from an unrestricted process).  Newly created UNIX
> > > + *   servers within the same Landlock domain continue to be accessible.
> > 
> > It might help to add a reference to the explicit scope mechanism.
> > 
> > Please squash patch 9/9 into this one and also add a reference here to
> > the rationale described in security/landlock.rst
> 
> Sounds good, will do.
> 
> 
> > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > +				 const struct landlock_ruleset *const server,
> > > +				 struct layer_access_masks *const masks,
> > > +				 const access_mask_t access)
> > 
> > This helper should be moved to task.c and factored out with
> > domain_is_scoped().  This should be a dedicated patch.
> 
> (already discussed in another follow-up mail)
> 
> 
> > > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > > +			  int flags)
> > > +{
> > > +	const struct landlock_ruleset *dom_other;
> > > +	const struct landlock_cred_security *subject;
> > > +	struct layer_access_masks layer_masks;
> > > +	struct landlock_request request = {};
> > > +	static const struct access_masks fs_resolve_unix = {
> > > +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > > +	};
> > > +
> > > +	/* Lookup for the purpose of saving coredumps is OK. */
> > > +	if (unlikely(flags & SOCK_COREDUMP))
> > > +		return 0;
> > > +
> > > +	/* Access to the same (or a lower) domain is always allowed. */
> > > +	subject = landlock_get_applicable_subject(current_cred(),
> > > +						  fs_resolve_unix, NULL);
> > > +
> > > +	if (!subject)
> > > +		return 0;
> > > +
> > > +	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> > > +				       &layer_masks, LANDLOCK_KEY_INODE))
> > > +		return 0;
> > > +
> > > +	/* Checks the layers in which we are connecting within the same domain. */
> > > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > 
> > We need to call unix_state_lock(other) before reading it, and check for
> > SOCK_DEAD, and check sk_socket before dereferencing it.  Indeed,
> > the socket can be make orphan (see unix_dgram_sendmsg and
> > unix_stream_connect).  I *think* a socket cannot be "resurrected" or
> > recycled once dead, so we may assume there is no race condition wrt
> > dom_other, but please double check.  This lockless call should be made
> > clear in the LSM hook.  It's OK to not lock the socket before
> > security_unix_find() (1) because no LSM might implement and (2) they
> > might not need to lock the socket (e.g. if the caller is not sandboxed).
> > 
> > The updated code should look something like this:
> > 
> > unix_state_unlock(other);

unix_state_lock(other) of course...

> > if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket)) {
> > 	unix_state_unlock(other);
> > 	return 0;
> > }
> > 
> > dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > unix_state_unlock(other);
> 
> Thank you for spotting the locking concern!
> 
> @anyone from netdev, could you please advise on the correct locking
> approach here?
> 
> * Do we need ot check SOCK_DEAD?
> 
>   You are saying that we need to do that, but it's not clear to me
>   why.
> 
>   If you look at the places where unix_find_other() is called in
>   af_unix.c, then you'll find that all of them check for SOCK_DEAD and
>   then restart from unix_find_other() if they do actually discover
>   that the socket is dead.  I think that this is catching this race
>   condition scenario:
> 
>   * a server socket exists and is alive
>   * A client connects: af_unix.c's unix_stream_connect() calls
>     unix_find_other() and finds the server socket...
>   * (Concurrently): The server closes the socket and enters
>     unix_release_sock().  This function:
>     1. disassociates the server sock from the named socket inode
>        number in the hash table (=> future unix_find_other() calls
>        will fail).
>     2. calls sock_orphan(), which sets SOCK_DEAD.
>   * ...(client connection resuming): unix_stream_connect() continues,
>     grabs the unix_state_lock(), which apparently protects everything
>     here, checks that the socket is not dead - and discovers that it
>     IS suddenly dead.  This was not supposed to happen.  The code
>     recovers from that by retrying everything starting with the
>     unix_find_other() call.  From unix_release_sock(), we know that
>     the inode is not associated with the sock any more -- so the
>     unix_find_socket_by_inode() call should be failing on the next
>     attempt.
> 
>   (This works with unix_dgram_connect() and unix_dgram_sendmsg() as
>   well.)
> 
>   The comments next to the SOCK_DEAD checks are also suggesting this.
> 
> * What lock to use
> 
>   I am having trouble reasoning about what lock is used for what in
>   this code.

It's not clear to me neither, and it looks like it's not consistent
across protocols.

>   
>   Is it possible that the lock protecting ->sk_socket is the
>   ->sk_callback_lock, not the unix_state_lock()?  The only callers to
>   sk_set_socket are either sock_orphan/sock_graft (both grabbing
>   sk_callback_lock), or they are creating new struct sock objects that
>   they own exclusively, and don't need locks yet.
> 
>   Admittedly, in af_unix.c, sock_orphan() and sock_graft() only get
>   called in contexts where the unix_state_lock() is held, so it would
>   probably work as well to lock that, but it is maybe a more
>   fine-grained approach to use sk_callback_lock?
> 
> 
> So... how about a scheme where we only check for ->sk_socket not being
> NULL:
> 
> read_lock_bh(&other->sk_callback_lock);
> struct sock *other_sk = other->sk_socket;
> if (!other_sk) {
> 	read_unlock_bh(&other->sk_callback_lock);
> 	return 0;
> }
> /* XXX double check whether we need a lock here too */
> struct file *file = other_sk->file;
> if (!other_file) {
> 	read_unlock_bh(&other->sk_callback_lock);
> 	return 0;
> }
> read_unlock_bh(&other->sk_callback_lock);
> 
> If this fails, that would in my understanding also be because the
> socket has died after the path lookup.  We'd then return 0 (success),
> because we know that the surrounding SOCK_DEAD logic will repeat
> everything starting from the path lookup operation (this time likely
> failing with ECONNREFUSED, but maybe also with a success, if another
> server process was quick enough).
> 
> Does this sound reasonable?

Actually, since commit 983512f3a87f ("net: Drop the lock in
skb_may_tx_timestamp()"), we can just use RCU + READ_ONCE(sk_socket) +
READ_ONCE(file).  The socket and file should only be freed after the RCU
grace periode.  As a safeguard, this commit should be a Depends-on.

However, it is safer to return -ECONNREFULED when sk_socket or file are
NULL.

I would be good to hear from netdev folks though.

TIL, there is an LSM hook for sock_graft().

> –Günther
> 

