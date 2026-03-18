Return-Path: <netdev+bounces-268965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I4IIdZ+ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B62B9E22
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BEB730166E4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292A364E8A;
	Wed, 18 Mar 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JzCuH92V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JzCuH92V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93D1B808
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829815; cv=none; b=ViVJAdSBElbSbWPcIb/dKLlRuLalsMcLTBlQNtMgjNytMcG9YM+RsRezLIXtjw5NPsZYWzrnjh7QzRrJP18DZiAKvGNllQ1VTy7lDxKEUKPgmUc6gmb8yq5e/Q2VGIqLHas0gng8UeqL3hLBaSiidNeSLq9SiV4+GZnU+nVg3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829815; c=relaxed/simple;
	bh=HlYOtkRM6S0RDzB3U/RuoTywJmdIR0g5p0+0sm6ZfZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN5TY0uaWyS1b3PZiCMu26kKXvPHLALI6wTQWo2sEzk3+16Xz6Wt59Xn6j7izTVeAS9VvOP3H35z6SdYE8kO+Ir5zmqVwRYNL7N3dk1OtRGONWt7Q9IanlOUi9K9/0tVNjz4Tve1COsdj1dP6FZrXhu2dnRHWODQZgrYJOXVImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JzCuH92V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JzCuH92V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 512464D3EC;
	Wed, 18 Mar 2026 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773829812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4EyO3CTNtpqaOEyW4jXhojMcvOo8/C40lCsFukCfIY=;
	b=JzCuH92Vfh9mFSRw7A3/r7qmxxb4kjpzWL4gAcB5tJX2aQQ+vjzY5aJt1056J+1Ci+o0xm
	Hqjn9rBUmbkTKVN+fTdnu2lmutmqh/wc0EeUlliiQwKVzqTTj/Ee2bSlrX1RGM4dzkWy1n
	M57gf9KEJXNTtzmQcsRy+gAkH1SuEIY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773829812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4EyO3CTNtpqaOEyW4jXhojMcvOo8/C40lCsFukCfIY=;
	b=JzCuH92Vfh9mFSRw7A3/r7qmxxb4kjpzWL4gAcB5tJX2aQQ+vjzY5aJt1056J+1Ci+o0xm
	Hqjn9rBUmbkTKVN+fTdnu2lmutmqh/wc0EeUlliiQwKVzqTTj/Ee2bSlrX1RGM4dzkWy1n
	M57gf9KEJXNTtzmQcsRy+gAkH1SuEIY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 323CD4273B;
	Wed, 18 Mar 2026 10:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ID+vC7R+umkaawAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 18 Mar 2026 10:30:12 +0000
From: Daniel Vacek <neelx@suse.com>
To: bigeasy@linutronix.de
Cc: edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	spasswolf@web.de,
	tglx@linutronix.de,
	Daniel Vacek <neelx@suse.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
Date: Wed, 18 Mar 2026 11:30:09 +0100
Message-ID: <20260318103009.2120920-1-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226172927.2Ck9wZMw@linutronix.de>
References: <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de> <20260217071952.WCXLGs5-@linutronix.de> <80114792206dc00d0099f00999a209e717debb12.camel@web.de> <20260217095700.SjYjM8RO@linutronix.de> <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de> <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de> <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de> <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de> <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268965-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de,suse.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: E50B62B9E22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Feb 2026 18:29:27 +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-18 13:50:14 [+0100], Bert Karwatzki wrote:
> > Am Mittwoch, dem 18.02.2026 um 08:30 +0100 schrieb Sebastian Andrzej Siewior:
> > > On 2026-02-17 20:10:09 [+0100], Bert Karwatzki wrote:
> > > > 
> > > > I tried to research the original commit which introduced the xmit_lock_owner check, but
> > > > it is present since linux 2.3.6 (released 19990610) (when __dev_queue_xmit() was still called dev_queue_xmit()),
> > > > so I can't tell the original idea behind that check (perhaps recuesion detection ...), so I'm
> > > > not completely sure if it can be omitted (and just let dev_xmit_recursion() do the recursion checking).
> > > 
> > > Okay. Thank you. I add it to my list.
> > > 
> > I've thought about it again and I now think the xmit_lock_owner check IS necessary to
> > avoid deadlocks on recursion in the non-RT case.
> > 
> > My idea to use get_current()->tgid as lock owner also does not work as interrupts are still enabled
> > and __dev_queue_xmit() can be called from interrupt context. So in a situation where an interrupt occurs
> > after the lock has been taken and the interrupt handler calls __dev_queue_xmit() on the same CPU a deadlock
> > would occur.
> 
> The warning happens because taskA on cpuX goes through
> HARD_TX_LOCK(), gets preempted and then taskB on cpuX wants also to send
> send a packet. The second one throws the warning.
> 
> We could ignore this check because a deadlock will throw a warning and
> "halt" the task that runs into the deadlock.
> But then we could be smart about this in the same way !RT is and
> pro-active check for the simple deadlock. The lock owner of
> netdev_queue::_xmit_lock is recorded can be checked vs current.
> 
> The snippet below should work. I need to see if tomorrow this is still a
> good idea.
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ff4256700e60..de342ceb17201 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  		/* Other cpus might concurrently change txq->xmit_lock_owner
>  		 * to -1 or to their cpu id, but not to our id.
>  		 */
> -		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> +		if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {

Ain't this changing the behavior for !RT case? Previously, if it was the same thread
which has already locked the queue (and hence the same CPU) evaluating this condition,
the condition was skipped, which is no longer the case with this change.

How about something like this instead?:

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942..27d090b03493 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -705,7 +705,7 @@ struct netdev_queue {
 	struct dql		dql;
 #endif
 	spinlock_t		_xmit_lock ____cacheline_aligned_in_smp;
-	int			xmit_lock_owner;
+	struct task_struct	*xmit_lock_owner;
 	/*
 	 * Time (in jiffies) of last Tx
 	 */
@@ -4709,7 +4709,7 @@ static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, cpu);
+	WRITE_ONCE(txq->xmit_lock_owner, current);
 }
 
 static inline bool __netif_tx_acquire(struct netdev_queue *txq)
@@ -4727,7 +4727,7 @@ static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
+	WRITE_ONCE(txq->xmit_lock_owner, current);
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
@@ -4736,7 +4736,7 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 
 	if (likely(ok)) {
 		/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-		WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
+		WRITE_ONCE(txq->xmit_lock_owner, current);
 	}
 	return ok;
 }
@@ -4744,14 +4744,14 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, -1);
+	WRITE_ONCE(txq->xmit_lock_owner, NULL);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, -1);
+	WRITE_ONCE(txq->xmit_lock_owner, NULL);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index ccef685023c2..f62bffb8edf6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4817,7 +4817,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 		/* Other cpus might concurrently change txq->xmit_lock_owner
 		 * to -1 or to their cpu id, but not to our id.
 		 */
-		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
+		if (READ_ONCE(txq->xmit_lock_owner) != current) {
 			if (dev_xmit_recursion())
 				goto recursion_alert;
 
@@ -11178,7 +11178,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 	/* Initialize queue lock */
 	spin_lock_init(&queue->_xmit_lock);
 	netdev_set_xmit_lockdep_class(&queue->_xmit_lock, dev->type);
-	queue->xmit_lock_owner = -1;
+	queue->xmit_lock_owner = NULL;
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
 #ifdef CONFIG_BQL

Daniel

>  			if (dev_xmit_recursion())
>  				goto recursion_alert;
>  
> 
> > Bert Karwatzki
> 
> Sebastian

