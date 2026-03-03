Return-Path: <netdev+bounces-263075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF1TAwadpmlqRwAAu9opvQ
	(envelope-from <netdev+bounces-263075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:34:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B11EAD92
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB30C3033232
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC2386C04;
	Tue,  3 Mar 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEb2vOrq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A838552F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526829; cv=none; b=ky0rsW4hm1reWB3IWD8pXWh6skPd20i+Ydh4DK9aHxshA59hbxHpLKU3giTiC9On8vqCVUB+Psf53tcaTH/SBl1aLj3YSkfFP39WX/Ewc9heEjOVyUypDUL+CF4F0MJdoKr3GBMRTSJbI7L9g4tLcyT5LsN3KFhOMBKR6IQg80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526829; c=relaxed/simple;
	bh=7QntyN5kOXIJGpyZyT1tgNWgl6fmIxFLNL1UJzyR4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8e3V6KUDXXtE3uK6HzHewKkfDgaTWAcZQ7SJru40+YfBpFkfm9xEtLP1ORwKhc1eMvSZqnrss/Bqka4o58wp1PwTBJ5fELD1yW3+Ph/wivpb7BeMWb/TDgty1hMUcIsA+4Gk/CyKI/f593AsB1O1vXFmnyDe20Qr8YxpDOwx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEb2vOrq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772526826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiV9Fl8WMW9sULzquq+EHX8jujpodN2k8hPeB80HJdY=;
	b=ZEb2vOrqf9+ny0y+pcIFGswI6LWEEqkBoQy4/nFiU4UsOiIYp1sD2TMdn4iAJwnkWrLAWN
	W0R/A8uI5kcnMYLeySUzujdLJ1glvbN9C7sFLWD/6HEFu6xlaZtFz1dL7kTYnCEwy7ZdQT
	z7XhULtdg3KidMcyIoFOWb2ioXuy87Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-2B1GEzxwOJykol7IX0f9Ag-1; Tue,
 03 Mar 2026 03:33:42 -0500
X-MC-Unique: 2B1GEzxwOJykol7IX0f9Ag-1
X-Mimecast-MFC-AGG-ID: 2B1GEzxwOJykol7IX0f9Ag_1772526819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74C1C18004BB;
	Tue,  3 Mar 2026 08:33:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D2319560A2;
	Tue,  3 Mar 2026 08:33:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lucien.xin@gmail.com
Cc: hepengtao@xiaomi.com,
	kuba@kernel.org,
	jlayton@kernel.org,
	metze@samba.org,
	davem@davemloft.net,
	kernel-tls-handshake@lists.linux.dev,
	horms@kernel.org,
	hare@suse.de,
	aahringo@redhat.com,
	tfanelli@redhat.com,
	mail@johnericson.me,
	andrew.gospodarek@broadcom.com,
	linkinjeon@kernel.org,
	dhowells@redhat.com,
	matttbe@kernel.org,
	xiyou.wangcong@gmail.com,
	dreibh@simula.no,
	jbaron@akamai.com,
	quic@lists.linux.dev,
	pc@manguebit.com,
	marc@fiuczynski.com,
	edumazet@google.com,
	pabeni@redhat.com,
	alibuda@linux.alibaba.com,
	steved@redhat.com,
	illiliti@protonmail.com,
	tom@talpey.com,
	marcelo.leitner@gmail.com,
	sd@queasysnail.net,
	linux-cifs@vger.kernel.org,
	netdev@vger.kernel.org,
	mbuhl@openbsd.org,
	smfrench@gmail.com,
	chuck.lever@oracle.com,
	daniel@haxx.se
Subject: Re: [net-next,v10,13/15] quic: add timer management
Date: Tue,  3 Mar 2026 09:33:24 +0100
Message-ID: <20260303083324.35531-1-pabeni@redhat.com>
In-Reply-To: <bffaab8d4727991c8dd46c8b57a08507545a25a4.1771986861.git.lucien.xin@gmail.com>
References: <bffaab8d4727991c8dd46c8b57a08507545a25a4.1771986861.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 7B8B11EAD92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263075-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
quic: add timer management

This patch introduces 'quic_timer' to unify and manage the five main
timers used in QUIC: loss detection, delayed ACK, path validation,
PMTU probing, and pacing. These timers are critical for driving
retransmissions, connection liveness, and flow control.

> diff --git a/net/quic/Makefile b/net/quic/Makefile
> index 58bb18f7926d..2ccf01ad9e22 100644
> --- a/net/quic/Makefile
> +++ b/net/quic/Makefile

[ ... ]

> diff --git a/net/quic/socket.c b/net/quic/socket.c
> index 74e3e3939c61..93a7abefc226 100644
> --- a/net/quic/socket.c
> +++ b/net/quic/socket.c

[ ... ]

> diff --git a/net/quic/socket.h b/net/quic/socket.h
> index d7811391cc8b..c5654fdc06b5 100644
> --- a/net/quic/socket.h
> +++ b/net/quic/socket.h

[ ... ]

> diff --git a/net/quic/timer.c b/net/quic/timer.c
> new file mode 100644
> index 000000000000..6f957385a341
> --- /dev/null
> +++ b/net/quic/timer.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* QUIC kernel implementation
> + * (C) Copyright Red Hat Corp. 2023
> + *
> + * This file is part of the QUIC kernel implementation
> + *
> + * Initialization/cleanup for QUIC protocol support.
> + *
> + * Written or modified by:
> + *    Xin Long <lucien.xin@gmail.com>
> + */
> +
> +#include "socket.h"

[ ... ]

> +static void quic_timer_sack_timeout(struct timer_list *t)
> +{
> +	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_SACK].t);
> +	struct sock *sk = &qs->inet.sk;
> +
> +	bh_lock_sock(sk);
> +	if (sock_owned_by_user(sk)) {
> +		if (!test_and_set_bit(QUIC_SACK_DEFERRED, &sk->sk_tsq_flags))
> +			sock_hold(sk);
> +		goto out;
> +	}
> +
> +	quic_timer_sack_handler(sk);
> +out:
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
> +}

[ ... ]

> +static void quic_timer_loss_timeout(struct timer_list *t)
> +{
> +	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_LOSS].t);
> +	struct sock *sk = &qs->inet.sk;
> +
> +	bh_lock_sock(sk);
> +	if (sock_owned_by_user(sk)) {
> +		if (!test_and_set_bit(QUIC_LOSS_DEFERRED, &sk->sk_tsq_flags))
> +			sock_hold(sk);
> +		goto out;
> +	}
> +
> +	quic_timer_loss_handler(sk);
> +out:
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
> +}

[ ... ]

> +static void quic_timer_path_timeout(struct timer_list *t)
> +{
> +	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_PATH].t);
> +	struct sock *sk = &qs->inet.sk;
> +
> +	bh_lock_sock(sk);
> +	if (sock_owned_by_user(sk)) {
> +		if (!test_and_set_bit(QUIC_PATH_DEFERRED, &sk->sk_tsq_flags))
> +			sock_hold(sk);
> +		goto out;
> +	}
> +
> +	quic_timer_path_handler(sk);
> +out:
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
> +}

[ ... ]

> +static void quic_timer_pmtu_timeout(struct timer_list *t)
> +{
> +	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_PMTU].t);
> +	struct sock *sk = &qs->inet.sk;
> +
> +	bh_lock_sock(sk);
> +	if (sock_owned_by_user(sk)) {
> +		if (!test_and_set_bit(QUIC_PMTU_DEFERRED, &sk->sk_tsq_flags))
> +			sock_hold(sk);
> +		goto out;
> +	}
> +
> +	quic_timer_pmtu_handler(sk);
> +out:
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
> +}

This isn't a bug, but the four timer_list-based timeout callbacks
(quic_timer_sack_timeout, quic_timer_loss_timeout, quic_timer_path_timeout,
quic_timer_pmtu_timeout) are structurally identical.

Each extracts the sock via container_of, takes bh_lock_sock, checks
sock_owned_by_user to conditionally defer via test_and_set_bit/sock_hold,
otherwise calls the handler directly, then bh_unlock_sock/sock_put. They
differ only in the timer index constant, the deferred bit name, and the
handler function.

This pattern could be consolidated into a single parameterized timeout
callback using a data table that maps timer type to deferred bit and handler
function pointer, reducing around 60 lines of near-duplicate code to
roughly 15 lines. The TCP subsystem uses a similar approach for some of its
timer infrastructure.

That said, this follows the existing per-timer-callback pattern used
elsewhere in the kernel networking stack (for example, tcp_write_timer,
tcp_delack_timer are also separate functions), so this is a minor style
observation rather than a defect.

> +void quic_timer_reset(struct sock *sk, u8 type, u64 timeout)
> +{
> +	struct timer_list *t = quic_timer(sk, type);
> +
> +	if (timeout && !mod_timer(t, jiffies + usecs_to_jiffies(timeout)))
> +		sock_hold(sk);
> +}

Can this function handle QUIC_TIMER_PACE safely? It unconditionally casts
the result of quic_timer() to 'struct timer_list *' and calls mod_timer().

Looking at the timer API in this patch:

Both quic_timer_start() and quic_timer_stop() have explicit QUIC_TIMER_PACE
guards that dispatch to hrtimer APIs:

quic_timer_start():
	if (type == QUIC_TIMER_PACE) {
		hr = quic_timer(sk, type);
		if (!hrtimer_is_queued(hr)) {
			hrtimer_start(hr, ns_to_ktime(timeout), ...);
			sock_hold(sk);
		}
		return;
	}

quic_timer_stop():
	if (type == QUIC_TIMER_PACE) {
		if (hrtimer_try_to_cancel(quic_timer(sk, type)) == 1)
			sock_put(sk);
		return;
	}

However, quic_timer_reset() does not have a similar guard. If a future
caller invokes quic_timer_reset(sk, QUIC_TIMER_PACE, timeout), mod_timer()
will operate on memory that is actually a 'struct hrtimer', potentially
causing memory corruption.

Should quic_timer_reset() either add a QUIC_TIMER_PACE guard consistent with
quic_timer_start()/quic_timer_stop(), or document that this function must
only be used with timer_list-based timers?

> +void quic_timer_start(struct sock *sk, u8 type, u64 timeout)
> +{
> +	struct timer_list *t;
> +	struct hrtimer *hr;
> +
> +	if (type == QUIC_TIMER_PACE) {
> +		hr = quic_timer(sk, type);
> +
> +		if (!hrtimer_is_queued(hr)) {
> +			hrtimer_start(hr, ns_to_ktime(timeout), HRTIMER_MODE_ABS_PINNED_SOFT);
> +			sock_hold(sk);
> +		}
> +		return;
> +	}
> +
> +	t = quic_timer(sk, type);
> +	if (timeout && !timer_pending(t)) {
> +		if (!mod_timer(t, jiffies + usecs_to_jiffies(timeout)))
> +			sock_hold(sk);
> +	}
> +}
> +
> +void quic_timer_stop(struct sock *sk, u8 type)
> +{
> +	if (type == QUIC_TIMER_PACE) {
> +		if (hrtimer_try_to_cancel(quic_timer(sk, type)) == 1)
> +			sock_put(sk);
> +		return;
> +	}
> +	if (timer_delete(quic_timer(sk, type)))
> +		sock_put(sk);
> +}

[ ... ]

> diff --git a/net/quic/timer.h b/net/quic/timer.h
> new file mode 100644
> index 000000000000..61b094325334
> --- /dev/null
> +++ b/net/quic/timer.h

[ ... ]


