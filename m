Return-Path: <netdev+bounces-268901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM78JZNTumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:26:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5D2B6E86
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C23E030B3D99
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A10F36AB43;
	Wed, 18 Mar 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R27jZegg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55536A03A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818525; cv=none; b=cIOW3vdkxyC9ysWS4fn2C+MEo5vwDN5YBr7n94JnJJJHnnBF+5J+PqVI/YG0EnsT9cG2SbIT6awhGT8yvldZt3+2jGbvXbm112mkiZ3ZJrIsR74xcbTODFapjdtt0XQwNadeC/QEHhR5VlmJ/pD5rC9dFIRDVDIYcO4Li1EpC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818525; c=relaxed/simple;
	bh=I/28d6NbRXZmaGc0xAD4eOQA8WIVGrTLkFM64hLuhN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6cjF0skTtAl5vs0dd2ltm+N/JFcCJoZMCu7C4KOR9B/0CaqjBMiUjtUU2xS+BOxr5gtQF9YOe6cv5gCKTUTiPZ5a7n7exrk7UV45nvQf11vGswkkaKAWK/9z5MpuvXZWqL3vj19xsWSGGj8eWeMA35CB+HV0MK3QyNHsnLGfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R27jZegg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+zmCTZUwpZ4/ZNgjMzB5/qxqIRUINqnvxwVvsq3nz8=;
	b=R27jZeggMmsWJAs5z4aWRy19kcgVw5JzgTmbcbU8/DI8uKt+biSV6IAg8TrpP6Yo6KTk+d
	6LIZXLmONw6bFEvUYsWgLqhE3msPF/26bQV/o1r//HucL/50G/xJJXYNgCyDJtnbwnEDJn
	hABILu2QBjBz2dbBUrUxxdRZvMeOnYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-p0HvhSszO6aLw4MB5nA5Mg-1; Wed,
 18 Mar 2026 03:21:54 -0400
X-MC-Unique: p0HvhSszO6aLw4MB5nA5Mg-1
X-Mimecast-MFC-AGG-ID: p0HvhSszO6aLw4MB5nA5Mg_1773818513
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 895401800626;
	Wed, 18 Mar 2026 07:21:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4113E1800351;
	Wed, 18 Mar 2026 07:21:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,13/14] net: homa: create homa_plumbing.c
Date: Wed, 18 Mar 2026 08:21:49 +0100
Message-ID: <20260318072149.269101-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-14-ouster@cs.stanford.edu>
References: <20260316223228.2611-14-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268901-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: F1E5D2B6E86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

> diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
> --- /dev/null
> +++ b/net/homa/homa_plumbing.c

[ ... ]

> +/**
> + * homa_ioc_info() - The top-level function that implements the
> + * HOMAIOCINFO ioctl for Homa sockets.
> + * @sock:  Socket for this request
> + * @arg:   The address in user space of the argument to ioctl, which
> + *          is a homa_info struct.
> + *
> + * Return:  0 on success, otherwise a negative errno. Sets hsk->error_msg
> + *          on errors.
> + */
> +int homa_ioc_info(struct socket *sock, unsigned long arg)
> +{
> +	struct homa_sock *hsk = homa_sk(sock->sk);
> +	struct homa_rpc_info rinfo;
> +	struct homa_info hinfo;
> +	struct homa_rpc *rpc;
> +	int bytes_avl;
> +	char *dst;
> +
> +	if (unlikely(copy_from_user(&hinfo, (void __user *)arg,
> +				    sizeof(hinfo)))) {
> +		hsk->error_msg = "invalid address for homa_info";
> +		return -EFAULT;
> +	}
> +
> +	if (!homa_protect_rpcs(hsk)) {
> +		hsk->error_msg = "socket has been shut down";
> +		return -ESHUTDOWN;
> +	}
> +	hinfo.bpool_avail_bytes = homa_pool_avail_bytes(hsk->buffer_pool);
> +	hinfo.port = hsk->port;
> +	dst = (char *)hinfo.rpc_info;
> +	bytes_avl = hinfo.rpc_info_length;
> +	hinfo.num_rpcs = 0;
> +	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
                                ^^^^

Is rcu_read_lock() needed around this list_for_each_entry_rcu() loop?

All three other functions that use the same homa_protect_rpcs() +
list_for_each_entry_rcu pattern (homa_abort_rpcs in homa_rpc.c,
homa_timer in homa_timer.c, and homa_abort_sock_rpcs in homa_rpc.c)
bracket the traversal with rcu_read_lock()/rcu_read_unlock().

The homa_protect_rpcs() mechanism prevents RPC reaping via an atomic
counter, but doesn't provide RCU read-side protection.

Without rcu_read_lock(), list_for_each_entry_rcu() triggers a lockdep
RCU warning, and on PREEMPT_RCU configurations the reader can be
preempted during traversal without the RCU subsystem knowing a reader
is active, breaking the RCU contract.

> +		homa_rpc_lock(rpc);
> +		if (rpc->state == RPC_DEAD) {
> +			homa_rpc_unlock(rpc);
> +			continue;
> +		}
> +		homa_rpc_get_info(rpc, &rinfo);
> +		homa_rpc_unlock(rpc);
> +		if (dst && bytes_avl >= sizeof(rinfo)) {
> +			if (copy_to_user((void __user *)dst, &rinfo,
> +					 sizeof(rinfo))) {
> +				homa_unprotect_rpcs(hsk);
> +				hsk->error_msg = "couldn't copy homa_rpc_info to user space: invalid or read-only address?";
> +				return -EFAULT;
> +			}
> +			dst += sizeof(rinfo);
> +			bytes_avl -= sizeof(rinfo);
> +		}
> +		hinfo.num_rpcs++;
> +	}
> +	homa_unprotect_rpcs(hsk);

[ ... ]

> +/**
> + * homa_socket() - Implements the socket(2) system call for sockets.
> + * @sk:    Socket on which the system call was invoked. The non-Homa
> + *         parts have already been initialized.
> + *
> + * Return: always 0 (success).
> + */
> +int homa_socket(struct sock *sk)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +	int result;
> +
> +	result = homa_sock_init(hsk);
> +	if (result != 0) {
> +		homa_sock_shutdown(hsk);
                ^^^^^^^^^^^^^^^^^^^

Can this trigger a spinlock bug?

When homa_sock_init() fails because homa_pool_alloc() returns
ERR_PTR(-ENOMEM), it returns before spin_lock_init(&hsk->lock) is
called in homa_sock_init().

The error path then calls homa_sock_shutdown(hsk), whose first action
is homa_sock_lock(hsk) = spin_lock_bh(&hsk->lock) on the
never-initialized spinlock.

With CONFIG_DEBUG_SPINLOCK, the lock's magic field (zero from slab
allocation) doesn't match SPINLOCK_MAGIC (0xdead4ead), causing
spin_bug() to call BUG().

While homa_sock_shutdown() would immediately return after checking
!hsk->homa (NULL), the BUG() fires inside spin_lock_bh() before that
check is reached.

This is reachable under memory pressure.

> +		homa_sock_destroy(&hsk->sock);
> +	}
> +	return result;
> +}

[ ... ]

> +/**
> + * homa_getsockopt() - Implements the getsockopt system call for Homa sockets.
> + * @sk:      Socket on which the system call was invoked.
> + * @level:   Selects level in the network stack to handle the request;
> + *           must be IPPROTO_HOMA.
> + * @optname: Identifies a particular setsockopt operation.
> + * @optval:  Address in user space where the option's value should be stored.
> + * @optlen:  Number of bytes available at optval; will be overwritten with
> + *           actual number of bytes stored.
> + * Return:   0 on success, otherwise a negative errno. Sets hsk->error_msg
> + *           on errors.
> + */
> +int homa_getsockopt(struct sock *sk, int level, int optname,
> +		    char __user *optval, int __user *optlen)
> +{
> +	struct homa_sock *hsk = homa_sk(sk);
> +	struct homa_rcvbuf_args rcvbuf_args;
> +	int is_server;
> +	void *result;
> +	int len;
> +
> +	if (copy_from_sockptr(&len, USER_SOCKPTR(optlen), sizeof(int))) {
> +		hsk->error_msg = "invalid address for optlen argument to getsockopt";
> +		return -EFAULT;
> +	}
> +
> +	if (level != IPPROTO_HOMA) {
> +		hsk->error_msg = "homa_setsockopt invoked with level not IPPROTO_HOMA";
                                 ^^^^^^^^^^^^^^

This isn't a bug, but the error message says 'homa_setsockopt' instead
of 'homa_getsockopt'. This is a copy-paste error from homa_setsockopt().

The error_msg field is returned to applications via the HOMAIOCINFO
ioctl, so users debugging socket option failures would see a misleading
message pointing to the wrong function.

> +		return -ENOPROTOOPT;
> +	}
> +	if (optname == SO_HOMA_RCVBUF) {

[ ... ]

> +/**
> + * homa_recvmsg() - Receive a message from a Homa socket.
> + * @sk:          Socket on which the system call was invoked.
> + * @msg:         Controlling information for the receive.
> + * @len:         Total bytes of space available in msg->msg_iov; not used.
> + * @flags:       Flags from system call; only MSG_DONTWAIT is used.
> + * @addr_len:    Store the length of the sender address here
> + * Return:       The length of the message on success, otherwise a negative
> + *               errno. Sets hsk->error_msg on errors.
> + */
> +int homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
> +		 int *addr_len)
> +{

[ ... ]

> +	if (rpc->error) {
> +		hsk->error_msg = "RPC failed";
> +		result = rpc->error;
> +	} else {
> +		result = rpc->msgin.length;
> +	}
> +	result = rpc->error ? rpc->error : rpc->msgin.length;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This isn't a bug, but there's redundant dead-store code here.

The if/else block assigns 'result' to either 'rpc->error' or
'rpc->msgin.length', but the next line immediately overwrites 'result'
with the identical ternary expression.

The two 'result = ...' assignments inside the if/else are dead stores
that are always overwritten. The if/else block's only surviving side
effect is setting 'hsk->error_msg = "RPC failed"' when rpc->error is
nonzero.

This appears to be an editing mistake where either the if/else should
be the authoritative result assignment (and the ternary deleted), or
the ternary should remain and the if/else should be simplified to only
set error_msg (removing its result assignments).

> +
> +	/* Collect result information. */
> +	control.id = rpc->id;

[ ... ]

> +/**
> + * homa_hrtimer() - This function is invoked by the hrtimer mechanism to
> + * wake up the timer thread. Runs at IRQ level.
> + * @timer:   The timer that triggered; not used.
> + *
> + * Return:   Always HRTIMER_RESTART.
> + */
> +enum hrtimer_restart homa_hrtimer(struct hrtimer *timer)
> +{
> +	wake_up_process(timer_kthread);
> +	return HRTIMER_NORESTART;
        ^^^^^^^^^^^^^^^^^^^^^^

The kernel-doc comment states 'Return: Always HRTIMER_RESTART' but the
function returns HRTIMER_NORESTART.

The runtime behavior is correct (homa_timer_main re-arms the hrtimer
explicitly via hrtimer_start on each loop iteration, so HRTIMER_NORESTART
is the intended return value), but the comment contradicts the code.

This misleads readers into believing the timer auto-restarts, when it
does not.

> +}


