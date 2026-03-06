Return-Path: <netdev+bounces-264703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHnbI+OFqmkhTAEAu9opvQ
	(envelope-from <netdev+bounces-264703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 08:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBB21C97F
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 08:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C7C8300B9D7
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D6328DF07;
	Fri,  6 Mar 2026 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zb/pnIop"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C463C0C
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783070; cv=none; b=s3koFYf9FOXsh0nJopVH+vyiXWtE6XUcleV9KdMVnKqpIX130DIu/DogeKpKcsYzMUq83LARPwK8oDNhpg22wTV+tuncLB9u7Mpdg263VkRTgRWyrSCm28a0UO1X68ZNaVxlsPdCyXP15eSq4t2SM7Mdw++SIAgPOOm8IZu4L1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783070; c=relaxed/simple;
	bh=RpAsoaKS+lvK2gvKhsYcWR9GwcFYvAJk6MTknMf7328=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HrvCaJZtU9yKdOUBmfY1iULoMno6aKwdVzcUT6nf0VYTlyvV8kFMkzHCgaymdD32ichXLyRmt2e/VqUWz2HqsOF77Plk/cYVw4ZqZpiEq//Yz07vWnuVpHT6gAUNwCV34wM7aDSJ7jW0LrOUMkgRJHDgU4jaYdudCd2+DCOHdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zb/pnIop; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772783066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTWOQUPKXLjYlOXIhKY8QbXRtmKHGOhET4nh/51FTjw=;
	b=Zb/pnIopvb1vXLOXKuCGUlr9UqlK+AT2SeKw43ftR6I5ZJ60WDhyZvW5y97cK5ohNCL60G
	RQwe2mPdAQ7iEGlPyvUE0kJxByXcfTV6kU5jj6Yfb8KVLCnfQhPkxaot7NXWCOyb05Vz4g
	ZcYMawBVgX0qMohKutBfRbnJTGKU0OQ=
Date: Fri, 06 Mar 2026 07:44:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <a61769c3eb9255309548c2624f054b67f2995ab1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for
 UDP.
To: "Kuniyuki Iwashima" <kuniyu@google.com>, jakub@cloudflare.com
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Kuniyuki Iwashima"
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
In-Reply-To: <CAAVpQUD+GiToMjWU387zgMT17emmXH_guWuebbvjPuppF5pbKw@mail.gmail.com>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
 <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com>
 <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev>
 <CAAVpQUBrVzwDN2xc68owHJZP7VoAZQWhwo_xdo5noGZ27qmjpA@mail.gmail.com>
 <3e278eea8830a7b68054ae0b5a99e1bc7ae5fbf3@linux.dev>
 <2006d401a04274b735dc15b86e58b497fd524540@linux.dev>
 <CAAVpQUD+GiToMjWU387zgMT17emmXH_guWuebbvjPuppF5pbKw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8AEBB21C97F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-264703-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

March 6, 2026 at 01:42, "Kuniyuki Iwashima" <kuniyu@google.com mailto:kun=
iyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com%3E=
 > wrote:


>=20
>=20On Thu, Mar 5, 2026 at 3:04 AM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
>=20
>=20>=20
>=20> March 5, 2026 at 18:45, "Jiayuan Chen" <jiayuan.chen@linux.dev mail=
to:jiayuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40l=
inux.dev%3E > wrote:
> >=20
>=20>  March 5, 2026 at 17:27, "Kuniyuki Iwashima" <kuniyu@google.com mai=
lto:kuniyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google=
.com%3E > wrote:
> >=20
>=20>  >
> >  > On Thu, Mar 5, 2026 at 12:30 AM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >  >
> >  >
> >  > March 5, 2026 at 15:48, "Kuniyuki Iwashima" <kuniyu@google.com mai=
lto:kuniyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google=
.com%3E > wrote:
> >  >
> >  > On Wed, Mar 4, 2026 at 10:37 PM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >  >
> >  > >
> >  > > On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrot=
e:
> >  > > [...]
> >  > > </TASK>
> >  > >
> >  > > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> >  > > Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.c=
om
> >  > > Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.=
00cb.GAE@google.com/
> >  > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >  > > ---
> >  > > v4: Fix deadlock when requeued
> >  > > v2: Fix build failure when CONFIG_INET=3Dn
> >  > > ---
> >  > > include/net/udp.h | 9 +++++++++
> >  > > net/core/skmsg.c | 29 +++++++++++++++++++++++++----
> >  > > net/ipv4/udp.c | 9 +++++++++
> >  > > 3 files changed, 43 insertions(+), 4 deletions(-)
> >  > >
> >  > > diff --git a/include/net/udp.h b/include/net/udp.h
> >  > > index 700dbedcb15f..ae38a4da9388 100644
> >  > > --- a/include/net/udp.h
> >  > > +++ b/include/net/udp.h
> >  > > @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct=
 net *net,
> >  > > struct sk_buff *skb);
> >  > > struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> >  > > __be16 sport, __be16 dport);
> >  > > +
> >  > > +#ifdef CONFIG_INET
> >  > > +void udp_sock_rfree(struct sk_buff *skb);
> >  > > +#else
> >  > > +static inline void udp_sock_rfree(struct sk_buff *skb)
> >  > > +{
> >  > > +}
> >  > > +#endif
> >  > > +
> >  > > int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> >  > >
> >  > > /* UDP uses skb->dev_scratch to cache as much information as pos=
sible and avoid
> >  > > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >  > > index 96f43e0dbb17..dd9134a45663 100644
> >  > > --- a/net/core/skmsg.c
> >  > > +++ b/net/core/skmsg.c
> >  > > @@ -7,6 +7,7 @@
> >  > >
> >  > > #include <net/sock.h>
> >  > > #include <net/tcp.h>
> >  > > +#include <net/udp.h>
> >  > > #include <net/tls.h>
> >  > > #include <trace/events/sock.h>
> >  > >
> >  > > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_ps=
ock *psock, struct sk_buff *skb,
> >  > > u32 off, u32 len, bool take_ref)
> >  > > {
> >  > > struct sock *sk =3D psock->sk;
> >  > > + bool is_udp =3D sk_is_udp(sk);
> >  > > struct sk_msg *msg;
> >  > > int err =3D -EAGAIN;
> >  > >
> >  > > @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_=
psock *psock, struct sk_buff *skb,
> >  > > if (!msg)
> >  > > goto out;
> >  > >
> >  > > - if (skb->sk !=3D sk && take_ref) {
> >  > > + if (is_udp) {
> >  > > + if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> >  > > + goto enqueue;
> >  > > +
> >  > > + spin_lock_bh(&sk->sk_receive_queue.lock);
> >  > > + }
> >  > > +
> >  > > + if (is_udp || (skb->sk !=3D sk && take_ref)) {
> >  > > if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> >  > > - goto free;
> >  > > + goto unlock;
> >  > >
> >  > > if (!sk_rmem_schedule(sk, skb, skb->truesize))
> >  > > - goto free;
> >  > > - } else {
> >  > > + goto unlock;
> >  > > + } else if (skb->sk =3D=3D sk || !take_ref) {
> >  > > /* This is used in tcp_bpf_recvmsg_parser() to determine whether=
 the
> >  > > * data originates from the socket's own protocol stack. No need =
to
> >  > > * refcount sk because msg's lifetime is bound to sk via the ingr=
ess_msg.
> >  > > @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_=
psock *psock, struct sk_buff *skb,
> >  > > * into user buffers.
> >  > > */
> >  > > skb_set_owner_r(skb, sk);
> >  > > +
> >  > > + if (is_udp) {
> >  > > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  > > +
> >  > > + skb->destructor =3D udp_sock_rfree;
> >  > > + }
> >  > > +
> >  > > +enqueue:
> >  > > err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, m=
sg, take_ref);
> >  > > if (err < 0)
> >  > > goto free;
> >  > > out:
> >  > > return err;
> >  > > +
> >  > > +unlock:
> >  > > + if (is_udp)
> >  > > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  > > free:
> >  > > kfree(msg);
> >  > > goto out;
> >  > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> >  > > index 422c96fea249..831d26748a90 100644
> >  > > --- a/net/ipv4/udp.c
> >  > > +++ b/net/ipv4/udp.c
> >  > > @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct soc=
k *sk, unsigned int flags,
> >  > > }
> >  > > EXPORT_SYMBOL(__skb_recv_udp);
> >  > >
> >  > > +void udp_sock_rfree(struct sk_buff *skb)
> >  > > +{
> >  > > + struct sock *sk =3D skb->sk;
> >  > > +
> >  > > + spin_lock_bh(&sk->sk_receive_queue.lock);
> >  > > + sock_rfree(skb);
> >  > > + spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  > > +}
> >  > > +
> >  > > int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> >  > > {
> >  > > struct sk_buff *skb;
> >  > > --
> >  > > 2.53.0.371.g1d285c8824-goog
> >  > >
> >  > > There are too many protocol-specific checks in the generic skmsg=
 code
> >  > > here. This should be abstracted out.
> >  > >
> >  > > Also TCP also has a similar issue with sk_forward_alloc concurre=
ncy
> >  > > between the backlog charge and recvmsg uncharge paths so the abs=
traction
> >  > > is necessary.
> >  > >
> >  > > I've put together a simple diff based on your patch for referenc=
e.
> >  > > I haven't tested it thoroughly, but it at least handles TCP and =
UDP
> >  > > separately through a callback, keeping the generic code clean.
> >  > >
> >  > I can follow up on TCP, but TCP needs another fix, which
> >  > cannot be factored out.
> >  >
> >  > Some wrong assumptions in your patch:
> >  >
> >  > 1) tcp_psock_ingress_charge() uses psock->ingress_lock,
> >  > but it does not protect any tcp_sock fields, especially
> >  > sk->sk_forwad_alloc.
> >  >
> >  > 2) TCP memory accounting happens under bh_lock_sock()
> >  > _or_ lock_sock(). sendmsg()/recvmsg() works under
> >  > lock_sock() and TCP fast path puts skb to backlog if
> >  > lock_sock() is held by userspace. This means even
> >  > a simple bh_lock_sock() in tcp_psock_ingress_charge()
> >  > race with memory accounting happening under lock_sock().
> >  >
> >  > Since sk_psock_skb_ingress() is called from both GFP_KERNEL
> >  > and GFP_ATOMIC context, the simplest fix would be to put
> >  > lock_sock() in sk_psock_backlog() for TCP, which is ugly though.
> >  >
> >  > OK, thanks.
> >  >
> >  > Now my only concern is keeping UDP-specific logic
> >  > out of skmsg.c.
> >  >
> >  > We already have TCP-only msg->sk logic there that
> >  > you added. It just does not look like TCP code.
> >  >
> >  The msg->sk field marks ingress-self vs ingress-other, which is
> >  protocol-agnostic metadata. TCP happens to consume it for seq
> >  tracking, but the assignment itself has no TCP-specific check
> >  (no is_tcp_sk() or similar).
> >=20
>=20>  >
> >  > If really needed, we can do such cleanup in bpf-next
> >  > for TCP and UDP altogether (probably after another
> >  > TCP fix ?).
> >  >
> >  >
> >  > We could use a function pointer so that UDP
> >  > implements its own ingress charge in udp_bpf.c, while other
> >  > protocols just use a default no-op or even NULL.
> >  >
> >  > If TCP requires locking outside of the scope, there's
> >  > no point adding one more extra layer/complexity just
> >  > for UDP.
> >  >
> >  > Even if we go that way, most likely we cannot get rid
> >  > of protocol-specific code (UDP/TCP-only hook) and
> >  > end up with the indirect call helpers, which will be
> >  > expensive than simple if logic.
> >  >
> >  An alternative would be to add such sk_psock_udp_skb_ingress() in
> >  udp_bpf.c, without adding any indirection layer.
> >=20
>=20>  This way we don't need to design a new abstraction before the
> >  approach is settled. Just a UDP-specific ingress helper, which
> >  keeps things clean enough for now, and avoid scattering is_udp
> >  checks all over sk_psock_skb_ingress, just need one if (is_udp).
> >=20
>=20>  Thanks.
> >=20
>=20>  After thinking a while, since the UDP-specific behaviour only appe=
ars
> >  in the redirect-to-self path,
> >=20
>=20Are you saying psock->sk =3D=3D skb->sk is always true and
> skb_set_owner_r() in the else case is not called for UDP ?
>


Before we figure out how to properly handle TCP, I'm wondering if we can =
take a
simpler approach for UDP like this (diff below).
This keeps the original code cleaner =E2=80=94 two sk_is_udp()
dispatch points in sk_psock_skb_ingress() and sk_psock_verdict_apply(),
both routing to a dedicated sk_psock_skb_ingress_udp() that handles
all UDP-specific locking and accounting in one place.

As for whether sk_psock_skb_ingress_udp() should live in udp_bpf.c
instead of skmsg.c, I'm open to either way.


diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ddde93dd8bc6..70876ed51b91 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -8,6 +8,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/udp.h>
 #include <trace/events/sock.h>

 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_co=
alesce)
@@ -587,6 +588,48 @@ static int sk_psock_skb_ingress_enqueue(struct sk_bu=
ff *skb,
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_b=
uff *skb,
 				     u32 off, u32 len, bool take_ref);

+/* UDP needs sk_receive_queue.lock to protect sk_forward_alloc from conc=
urrent
+ * modification by udp_rmem_release(). This handles both self-redirect a=
nd
+ * cross-socket redirect for UDP.
+ */
+static int sk_psock_skb_ingress_udp(struct sk_psock *psock, struct sk_bu=
ff *skb,
+				    u32 off, u32 len, bool take_ref)
+{
+	struct sock *sk =3D psock->sk;
+	struct sk_msg *msg;
+	int err;
+
+	if (skb->destructor =3D=3D udp_sock_rfree) {
+		msg =3D alloc_sk_msg(GFP_ATOMIC);
+		if (unlikely(!msg))
+			return -EAGAIN;
+		goto enqueue;
+	}
+
+	msg =3D alloc_sk_msg(take_ref ? GFP_KERNEL : GFP_ATOMIC);
+	if (unlikely(!msg))
+		return -EAGAIN;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
+	    !sk_rmem_schedule(sk, skb, skb->truesize)) {
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+		kfree(msg);
+		return -EAGAIN;
+	}
+	skb_set_owner_r(skb, sk);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+
+	skb->destructor =3D udp_sock_rfree;
+
+enqueue:
+	err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg,
+					   take_ref);
+	if (err < 0)
+		kfree(msg);
+	return err;
+}
+
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *=
skb,
 				u32 off, u32 len)
 {
@@ -594,6 +637,9 @@ static int sk_psock_skb_ingress(struct sk_psock *psoc=
k, struct sk_buff *skb,
 	struct sk_msg *msg;
 	int err;

+	if (sk_is_udp(sk))
+		return sk_psock_skb_ingress_udp(psock, skb, off, len, true);
+
 	/* If we are receiving on the same sock skb->sk is already assigned,
 	 * skip memory accounting and owner transition seeing it already set
 	 * correctly.
@@ -1059,7 +1105,12 @@ static int sk_psock_verdict_apply(struct sk_psock =
*psock, struct sk_buff *skb,
 				off =3D stm->offset;
 				len =3D stm->full_len;
 			}
-			err =3D sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			if (sk_is_udp(sk_other))
+				err =3D sk_psock_skb_ingress_udp(psock, skb,
+							       off, len, false);
+			else
+				err =3D sk_psock_skb_ingress_self(psock, skb,
+								off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);

