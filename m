Return-Path: <netdev+bounces-264292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFXZJJFfqWlc6QAAu9opvQ
	(envelope-from <netdev+bounces-264292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:48:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D155220FF4E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 818023063419
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848436F40E;
	Thu,  5 Mar 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BFdAckwH"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971B36A037
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707526; cv=none; b=k467VoqvPEqKNHo/YfAwAxwFXwpKpad0sj0mDPmvPpPzJ5/k78FYm8zza/v0J9YdwOGRSxc9q1w7cCxN/DXDK65uNwUTFhJ8rzMA54Iap+c/Tg1o6lvteFeHWNdIY5cUnJGg5BDN1FAzaj/k9NPt4g+1/Wl2JwuJHmCYlHHPMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707526; c=relaxed/simple;
	bh=MWXQMNHLXheg6b1ecpYR5u9lCHHSHQ5SumWq+XoNQRs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=YsYC4DLTVLqqLHkVtdD/OKhD1xE2r/qZtw7pGQkUPC++8+zmq/s93T7bhEDhtv5NxsqanuH+elHavHevKxOKUrLHRtt7icjvDF8c4dybJ3lHQKLGd7VMorAyRXfGi0p1RlcbKIEJWqS7VGTRwcLEIua5Nk5cY+yVCpOyU/1HUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFdAckwH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772707522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG2k32I5T/ZI60fX7fYmCOJJFrc1oI3Ta8ocIQhK/Ys=;
	b=BFdAckwHOxsu1bXgxLGdO9cVViNJuJCWaKEwP0QorP/tdtP18u/D/cAV9R8OwrYmEoQo+s
	T/EF57B2vyNisyxocfWkuHPjJYxzR3ZHFvVhftng0jixDqQXvoaA7s9R43cdhDUyYxkhQ3
	0nH9lA9WlvenyVL5jgpY7NttnuSiFTE=
Date: Thu, 05 Mar 2026 10:45:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <3e278eea8830a7b68054ae0b5a99e1bc7ae5fbf3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for
 UDP.
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Kuniyuki Iwashima"
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
In-Reply-To: <CAAVpQUBrVzwDN2xc68owHJZP7VoAZQWhwo_xdo5noGZ27qmjpA@mail.gmail.com>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
 <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com>
 <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev>
 <CAAVpQUBrVzwDN2xc68owHJZP7VoAZQWhwo_xdo5noGZ27qmjpA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D155220FF4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-264292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

March 5, 2026 at 17:27, "Kuniyuki Iwashima" <kuniyu@google.com mailto:kun=
iyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com%3E=
 > wrote:


>=20
>=20On Thu, Mar 5, 2026 at 12:30 AM Jiayuan Chen <jiayuan.chen@linux.dev>=
 wrote:
>=20
>=20>=20
>=20> March 5, 2026 at 15:48, "Kuniyuki Iwashima" <kuniyu@google.com mail=
to:kuniyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.=
com%3E > wrote:
> >=20
>=20>  On Wed, Mar 4, 2026 at 10:37 PM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >=20
>=20>  >
> >  > On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
> >  > [...]
> >  > </TASK>
> >  >
> >  > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> >  > Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> >  > Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00=
cb.GAE@google.com/
> >  > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >  > ---
> >  > v4: Fix deadlock when requeued
> >  > v2: Fix build failure when CONFIG_INET=3Dn
> >  > ---
> >  > include/net/udp.h | 9 +++++++++
> >  > net/core/skmsg.c | 29 +++++++++++++++++++++++++----
> >  > net/ipv4/udp.c | 9 +++++++++
> >  > 3 files changed, 43 insertions(+), 4 deletions(-)
> >  >
> >  > diff --git a/include/net/udp.h b/include/net/udp.h
> >  > index 700dbedcb15f..ae38a4da9388 100644
> >  > --- a/include/net/udp.h
> >  > +++ b/include/net/udp.h
> >  > @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct n=
et *net,
> >  > struct sk_buff *skb);
> >  > struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> >  > __be16 sport, __be16 dport);
> >  > +
> >  > +#ifdef CONFIG_INET
> >  > +void udp_sock_rfree(struct sk_buff *skb);
> >  > +#else
> >  > +static inline void udp_sock_rfree(struct sk_buff *skb)
> >  > +{
> >  > +}
> >  > +#endif
> >  > +
> >  > int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> >  >
> >  > /* UDP uses skb->dev_scratch to cache as much information as possi=
ble and avoid
> >  > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >  > index 96f43e0dbb17..dd9134a45663 100644
> >  > --- a/net/core/skmsg.c
> >  > +++ b/net/core/skmsg.c
> >  > @@ -7,6 +7,7 @@
> >  >
> >  > #include <net/sock.h>
> >  > #include <net/tcp.h>
> >  > +#include <net/udp.h>
> >  > #include <net/tls.h>
> >  > #include <trace/events/sock.h>
> >  >
> >  > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psoc=
k *psock, struct sk_buff *skb,
> >  > u32 off, u32 len, bool take_ref)
> >  > {
> >  > struct sock *sk =3D psock->sk;
> >  > + bool is_udp =3D sk_is_udp(sk);
> >  > struct sk_msg *msg;
> >  > int err =3D -EAGAIN;
> >  >
> >  > @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_ps=
ock *psock, struct sk_buff *skb,
> >  > if (!msg)
> >  > goto out;
> >  >
> >  > - if (skb->sk !=3D sk && take_ref) {
> >  > + if (is_udp) {
> >  > + if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> >  > + goto enqueue;
> >  > +
> >  > + spin_lock_bh(&sk->sk_receive_queue.lock);
> >  > + }
> >  > +
> >  > + if (is_udp || (skb->sk !=3D sk && take_ref)) {
> >  > if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> >  > - goto free;
> >  > + goto unlock;
> >  >
> >  > if (!sk_rmem_schedule(sk, skb, skb->truesize))
> >  > - goto free;
> >  > - } else {
> >  > + goto unlock;
> >  > + } else if (skb->sk =3D=3D sk || !take_ref) {
> >  > /* This is used in tcp_bpf_recvmsg_parser() to determine whether t=
he
> >  > * data originates from the socket's own protocol stack. No need to
> >  > * refcount sk because msg's lifetime is bound to sk via the ingres=
s_msg.
> >  > @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_ps=
ock *psock, struct sk_buff *skb,
> >  > * into user buffers.
> >  > */
> >  > skb_set_owner_r(skb, sk);
> >  > +
> >  > + if (is_udp) {
> >  > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  > +
> >  > + skb->destructor =3D udp_sock_rfree;
> >  > + }
> >  > +
> >  > +enqueue:
> >  > err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg=
, take_ref);
> >  > if (err < 0)
> >  > goto free;
> >  > out:
> >  > return err;
> >  > +
> >  > +unlock:
> >  > + if (is_udp)
> >  > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  > free:
> >  > kfree(msg);
> >  > goto out;
> >  > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> >  > index 422c96fea249..831d26748a90 100644
> >  > --- a/net/ipv4/udp.c
> >  > +++ b/net/ipv4/udp.c
> >  > @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock =
*sk, unsigned int flags,
> >  > }
> >  > EXPORT_SYMBOL(__skb_recv_udp);
> >  >
> >  > +void udp_sock_rfree(struct sk_buff *skb)
> >  > +{
> >  > + struct sock *sk =3D skb->sk;
> >  > +
> >  > + spin_lock_bh(&sk->sk_receive_queue.lock);
> >  > + sock_rfree(skb);
> >  > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  > +}
> >  > +
> >  > int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> >  > {
> >  > struct sk_buff *skb;
> >  > --
> >  > 2.53.0.371.g1d285c8824-goog
> >  >
> >  > There are too many protocol-specific checks in the generic skmsg c=
ode
> >  > here. This should be abstracted out.
> >  >
> >  > Also TCP also has a similar issue with sk_forward_alloc concurrenc=
y
> >  > between the backlog charge and recvmsg uncharge paths so the abstr=
action
> >  > is necessary.
> >  >
> >  > I've put together a simple diff based on your patch for reference.
> >  > I haven't tested it thoroughly, but it at least handles TCP and UD=
P
> >  > separately through a callback, keeping the generic code clean.
> >  >
> >  I can follow up on TCP, but TCP needs another fix, which
> >  cannot be factored out.
> >=20
>=20>  Some wrong assumptions in your patch:
> >=20
>=20>  1) tcp_psock_ingress_charge() uses psock->ingress_lock,
> >  but it does not protect any tcp_sock fields, especially
> >  sk->sk_forwad_alloc.
> >=20
>=20>  2) TCP memory accounting happens under bh_lock_sock()
> >  _or_ lock_sock(). sendmsg()/recvmsg() works under
> >  lock_sock() and TCP fast path puts skb to backlog if
> >  lock_sock() is held by userspace. This means even
> >  a simple bh_lock_sock() in tcp_psock_ingress_charge()
> >  race with memory accounting happening under lock_sock().
> >=20
>=20>  Since sk_psock_skb_ingress() is called from both GFP_KERNEL
> >  and GFP_ATOMIC context, the simplest fix would be to put
> >  lock_sock() in sk_psock_backlog() for TCP, which is ugly though.
> >=20
>=20>  OK, thanks.
> >=20
>=20>  Now my only concern is keeping UDP-specific logic
> >  out of skmsg.c.
> >=20
>=20We already have TCP-only msg->sk logic there that
> you added. It just does not look like TCP code.

The msg->sk field marks ingress-self vs ingress-other, which is
protocol-agnostic metadata. TCP happens to consume it for seq
tracking, but the assignment itself has no TCP-specific check
(no is_tcp_sk() or similar).

> If really needed, we can do such cleanup in bpf-next
> for TCP and UDP altogether (probably after another
> TCP fix ?).
>=20
>=20>=20
>=20> We could use a function pointer so that UDP
> >  implements its own ingress charge in udp_bpf.c, while other
> >  protocols just use a default no-op or even NULL.
> >=20
>=20If TCP requires locking outside of the scope, there's
> no point adding one more extra layer/complexity just
> for UDP.
>=20
>=20Even if we go that way, most likely we cannot get rid
> of protocol-specific code (UDP/TCP-only hook) and
> end up with the indirect call helpers, which will be
> expensive than simple if logic.
>


An alternative would be to add such sk_psock_udp_skb_ingress() in
udp_bpf.c, without adding any indirection layer.

This way we don't need to design a new abstraction before the
approach is settled. Just a UDP-specific ingress helper, which
keeps things clean enough for now, and avoid scattering is_udp
checks all over sk_psock_skb_ingress, just need one if (is_udp).

Thanks.

