Return-Path: <netdev+bounces-292869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF4nF9nFGGo5nQgAu9opvQ
	(envelope-from <netdev+bounces-292869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:46:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E75FB17B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFDA33008758
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF13672A5;
	Thu, 28 May 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMZPgwxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236836D9F6
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008055; cv=none; b=k6VOP8ADewIuKYAs0S1cLI/6u3ViMpPHos2t6AqSVhvjf+Wg+sS7pksEu+ZDmdDvPZJONGPKjJ6czYrlijPH9wFrku1b1qJM23YbRyclX9aMDuNTre6UPCLReMvfFo9tZfjA6W15qltIQiY2mGBoSLwr7PAjw/Z8cs+RYvkEIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008055; c=relaxed/simple;
	bh=6TBxcT3rXL3rmUxs9dupW13j1+OxzR8YP9/qw/niEwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Od6reMV8QYaSyFmW3/HpHgKVQLknWhILsTJrfKthZlk5Ox69qOR5M+pYy2gyTvwpL3VqPg/DdXcGbwfl6usjMufE/NRrDgLXh5k2RBNgwWVYYQtU6/1xqL2Qf5N5BivGJx8i8VPOEjkqVOpb/qm5rggUfGxTcNEjBTqliQw2IlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMZPgwxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780008052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1KtjqbZ1swA9x3w676twoyRtYQLwds5/WiKJAslGSU=;
	b=VMZPgwxVC5UDcRlZTYXAiil/IzJZhrBfxWciaOVCH387htNdtE9njWuLJ5Jc9gilV7Yof9
	WI7O4bX8IOSuFEgOJcgeoDSxzmXN+3rOq9UhzYbx45dwkMv4gI0Af3etDjuSt9+3r2pTL7
	a7QwN+kA+uLSwjqdkBDFwN3ITrnb5FQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-rLRL0CEONtC1BaI3CmqLhA-1; Thu,
 28 May 2026 18:40:48 -0400
X-MC-Unique: rLRL0CEONtC1BaI3CmqLhA-1
X-Mimecast-MFC-AGG-ID: rLRL0CEONtC1BaI3CmqLhA_1780008047
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 340721956046;
	Thu, 28 May 2026 22:40:47 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.65.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A7A319560AB;
	Thu, 28 May 2026 22:40:45 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink,
 audit: prevent false ENOBUFS on timeout expiry
Date: Thu, 28 May 2026 18:40:44 -0400
Message-ID: <2143396.Jadu78ljVU@x2>
Organization: Red Hat
In-Reply-To: <20260527152936.001d5d28@kernel.org>
References:
 <20260513172443.1128496-1-rrobaina@redhat.com>
 <CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
 <20260527152936.001d5d28@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgrubb@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D88E75FB17B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wednesday, May 27, 2026 6:29:36=E2=80=AFPM Eastern Daylight Time Jakub K=
icinski=20
wrote:
> On Wed, 27 May 2026 16:29:37 -0300 Ricardo Robaina wrote:
> > On Mon, May 18, 2026 at 9:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Wed, 13 May 2026 14:24:43 -0300 Ricardo Robaina wrote:
> > > > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks
> > > > on
> > > > the netlink socket.
> > >=20
> > > Holding socket lock during slow IO sounds very wrong. One could say -
> > > that's abuse of the socket lock?
> > >=20
> > > > If the wait timeout fully expires (timeo =3D=3D 0),
> > > > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > > > request. It then triggers netlink_overrun that drops the event,
> > > > completely bypassing the audit subsystem's internal retry queue, and
> > > >=20
> > > > falsely returns ENOBUFS to user-space, resulting in the following=20
error:
> > > >  auditd[]: Error receiving audit netlink packet (No buffer space
> > > >  available)
> > > >=20
> > > > Fix this by detecting when a blocking sender's timeout has expired
> > > > (timeo =3D=3D 0 && !nonblock) in netlink_unicast(). In this case, i=
nstead
> > > > of retrying with timeo=3D0 (which would incorrectly trigger
> > > > netlink_overrun
> > > > on the next iteration), safely free the skb and return -EAGAIN,
> > > > allowing
> > > > the audit subsystem to gracefully enqueue the pending event into its
> > > > internal backlog.
> > >=20
> > > The socket _is_ the queue, normally.
> > >=20
> > > Please explore fixing this in audit?
> > > --
> > > pw-bot: cr
> >=20
> > Hi Jakub,
> >=20
> > Thanks for reviewing this patch as well.
> >=20
> > First, regarding the lock: kauditd does not hold the socket lock during
> > slow I/O. The sleep in netlink_attachskb() uses schedule_timeout() on
> > nlk->wait (a wait queue). No socket lock or mutex is held during the
> > sleep.
>
> So you're saying the queue _is_ actually congested?

Yes. the socket buffer is genuinely full because auditd can't drain fast=20
enough.

> netlink_attachskb() sleeps because there's no space left in the socket's
> rcvbuf? So the skbs are moved to audit_retry_queue "temporarily" until
> user space drains its socket and kernel can succeed sending?
>=20
> Could you confirm this understanding is correct?

Yes. kauditd sleeps in netlink_attachskb, the HZ/10 timeout expires, and th=
e=20
skb is moved to audit_retry_queue until auditd drains enough for delivery t=
o=20
succeed. The record is not lost.

> > Second, regarding an audit-only fix: the symptom manifests as sk->sk_err
> > =3D ENOBUFS set inside netlink_overrun() (called from netlink_attachskb
> > when timeo =3D=3D 0). Audit has no mechanism to prevent or clear this s=
ocket
> > state from the outside. Potential workarounds all fail:
> >=20
> > (1) Clearing sk_err after the fact is racy and affects other socket ops
>=20
> Why would you clear the sk_err, it's the reader's responsibility to
> clear the congestion and the reader is AFAIU a user space process.

The reader is in a fight to clear the congestion. But 1 reader thread vs 32=
=20
cores, the reader can get backlogged. It doesn't happen very often, but it=
=20
does once in a great while. The reader doesn't want an ENOBUFS and logs tha=
t=20
as an exceptional condition when that happens. It wants to rely on the=20
kernel's backlog mechanism.

> > (2) Avoiding timeouts entirely defeats the anti-deadlock mechanism
>=20
> What's the anti-deadlock mechanism?

sk_sndtimeo =3D HZ/10, set in audit_net_init(). Without it, kauditd would s=
leep=20
indefinitely in netlink_attachskb if auditd is stalled or dead. The timeout=
=20
lets kauditd escape and route the skb to its retry queue.

> > (3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in stable
> > kernels where this bug is actively impacting users
>=20
> Which commit are you referring to? Isn't that flag itself ancient?

You're right, it is. I see how this flag would fix the pathological behavio=
r=20
that was reported. But as I have looked at this suggestion, there seems to =
be=20
one wrinkle. User space should not need to know that the audit code in the=
=20
kernel has this retry mechanism. It seems like the audit subsystem should s=
et=20
the flag on auditd's socket at registration time in auditd_set(). The kerne=
l=20
is the right place for this because it's the kernel that manages the retry/
hold queues and sets the sk_sndtimeo that triggers the overrun path - audit=
d=20
has no knowledge of these internals.

NETLINK_F_RECV_NO_ENOBUFS and nlk_sk are private to net/netlink/af_netlink.=
h,=20
so audit.c can't set the flag directly. Should we propose a small exported=
=20
helper, netlink_sock_set_no_enobufs(), that mirrors the existing=20
setsockopt(NETLINK_NO_ENOBUFS) handler? Then the rest of the fix itself liv=
es=20
entirely in kernel/audit.c as you suggested.

Something like:
void netlink_sock_set_no_enobufs(struct sock *sk)
{
	struct netlink_sock *nlk =3D nlk_sk(sk);

	nlk->flags |=3D NETLINK_F_RECV_NO_ENOBUFS;
	clear_bit(NETLINK_S_CONGESTED, &nlk->state);
	wake_up_interruptible(&nlk->wait);
}

and then in audit_set() it calls this as it sets up the connection. Is this=
=20
the way you wanted to handle this?

=2DSteve



