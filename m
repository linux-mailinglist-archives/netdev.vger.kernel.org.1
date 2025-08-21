Return-Path: <netdev+bounces-215483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF238B2EC32
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08FE5A8238
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C2296BB0;
	Thu, 21 Aug 2025 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="gDzFCBQe"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B2214204;
	Thu, 21 Aug 2025 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747493; cv=none; b=qPKgAcP2baNHxc/IGvhPzZJQ5TmBt7iIEcKuEyfGEybRVg6/Cj4huBxbi6jo8JyVHLO9lU3Np2DBSB/BqBWpPtuqGiVUXL+Froz/uOaF3S4xkIdclvzKdlh+1rebPT7FzKTGYISRSr3JheU9Jv0ZTtezuobG0OO4iouhkk2p1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747493; c=relaxed/simple;
	bh=dLg8FEgYND+TqFZezoppYVGFxxcB0B8lPw/eaB01FW0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzuZ07E7ll8fADGXArD3UsQU9zNYZK0ddVZWwe5QYFcL8fTQMNfwboaj1jdVrCT3+0hPbm/zqYmy+Cn2kyfpCmpXPL8tckmYUXaRPGhcGWVMx49dN0AYzBQ3rp+iZrlhdZMlCs0GzmKzeLm4rbKDoqTC/xcd6TnjYgl8VrMrwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=gDzFCBQe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755747477; x=1756352277; i=efault@gmx.de;
	bh=Zcu/oR/SexQraUr9wM1WdAnFJb8DGTeKtA8eTEi8fio=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gDzFCBQe13/zgSoqS47uN5+g5QG96kfCrIgaA7RZViemCxeJTWlqGw3bIxOe37TQ
	 Yx4dfE6u0FOIS4gvDk360z/yInSJL5MQTpFqVXKoJZey5v4gcGwfJf5hvbOC/d15k
	 ozaR546Qz3dyoHpGt8GFMTk/1le3roQOfQUluHsDVxsQGsZJa40Nc9ngrxouuvxw7
	 CKYzlmXCPU5JQqFeJaV5R8uBsBAj6FBOKC03iuMff/zpe8wRadBF8zJdbZIAx+FR4
	 pVttM1VjQofzkebcDKGdISvtv4hdJ0v+UXeGKEl1hJKRu8JqPIAhnHNpi8VQI3b6B
	 mF6u6RJDJ1pSJ9Omuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.96]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1uq2aO3bIq-00G0ty; Thu, 21
 Aug 2025 05:37:56 +0200
Message-ID: <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Thu, 21 Aug 2025 05:37:56 +0200
In-Reply-To: <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	 <20250814172326.18cf2d72@kernel.org>
	 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
	 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:K3ro/IQ7njsR9haz2LYg3dMWET9zIIFQUCgBr8UGW75RQhNRw9v
 t5KJymV3pO9PsONDsP1W0ekV+vqLBjQX0LYGu5LxbB5v0l/JB5MmPuGGbFmvL/CO7oBrkJW
 F69rgxBjoLnKC0HyJyanfRC6CGhjtxnFO7q/m3XKWMAn0bTyPzp0PXyh0aoX2dfuQneq7SU
 +5BWyHzN/FqXmOTcSDdjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WRQa1JTL3KM=;QivxnY28wXbs4Cjwk5ea/vEE9vL
 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
 OgmrsPg=

On Wed, 2025-08-20 at 10:36 -0700, Breno Leitao wrote:
> On Wed, Aug 20, 2025 at 02:31:02PM +0200, Mike Galbraith wrote:
> > On Tue, 2025-08-19 at 10:27 -0700, Breno Leitao wrote:
> > >=20
> > > I=E2=80=99ve continued investigating possible solutions, and it looks=
 like
> > > moving netconsole over to the non=E2=80=91blocking console (nbcon) fr=
amework
> > > might be the right approach. Unlike the classic console path, nbcon
> > > doesn=E2=80=99t rely on the global console lock, which was one of the=
 main
> > > concerns regarding the possible deadlock.
> >=20
> > ATM at least, classic can remotely log a crash whereas nbcon can't per
> > test drive, so it would be nice for classic to stick around until nbcon
> > learns some atomic packet blasting.
>=20
> Oh, does it mean that during crash nbcon invokes `write_atomic` call
> back, and because this patch doesn't implement it, it will not send
> those pkts? Am I reading it correct?

No, I'm just saying that the kernel's last gasp doesn't make it out of
the box with CONFIG_NETCONSOLE_NBCON=3Dy as your patch sits.

It doesn't with my wireless or RT lockdep et al appeasement hackery
either, but I don't care deeply, as long as I can capture kernel spew
inspired by LTP and whatnot, I'm happy.. kdump logs most death rattles.

> > > The new path is protected by NETCONSOLE_NBCON, which is disabled by
> > > default. This allows us to experiment and test both approaches.
> >=20
> > As patch sits, interrupts being disabled is still a problem, gripes
> > below.
>=20
> You mean that the IRQs are disabled at the acquire of target_list_lock?
> If so, an option is to turn that list an RCU list ?!

Yeah. I switched to local_bh_disable(), but was originally using
rcu_read_lock_bh() for RT.

> > Not disabling IRQs makes nbcon gripe free, but creates the
> > issue of netpoll_tx_running() lying to the rest of NETPOLL consumers.
> >=20
> > RT and the wireless stack have in common that IRQs being disabled in
> > netpoll.c sucks rocks for them.=C2=A0 I've been carrying a hack to allo=
w RT
> > to use netconsole since 5.15

(hm, grepping my modest forest I see it's actually 4.10.. hohum)

> What is this patch you have?

Make boxen stop bitching at NETCONSOLE_NBCON version below.

netpoll: Make it RT friendly

PREEMPT_RT cannot alloc/free memory when not preemptible, making
disabling of IRQs across transmission an issue for RT.

Use local_bh_disable() to provide local exclusion for RT (via
softirq_ctrl.lock) for normal and fallback transmission paths
instead of disabling IRQs. Since zap_completion_queue() callers
ensure pointer stability, replace get_cpu_var() therein with
this_cpu_ptr() to keep it preemptible across kfree().

Disable a couple warnings for RT, and we're done.

v0.kinda-works -> v1:
    remove get_cpu_var() from zap_completion_queue().
    fix/test netpoll_tx_running() to work for RT/!RT.
    fix/test xmit fallback path for RT.

(blessed by nobody, plz keep all shrapnel etc etc:)

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/net/netconsole.c |    4 ++--
 include/linux/netpoll.h  |    4 +++-
 net/core/netpoll.c       |   47 ++++++++++++++++++++++++++++++++++++--
---------
 3 files changed, 41 insertions(+), 14 deletions(-)

--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
 static void netconsole_device_lock(struct console *con, unsigned long
*flags)
 {
 	/* protects all the targets at the same time */
-	spin_lock_irqsave(&target_list_lock, *flags);
+	spin_lock(&target_list_lock);
 }
=20
 static void netconsole_device_unlock(struct console *con, unsigned
long flags)
 {
-	spin_unlock_irqrestore(&target_list_lock, flags);
+	spin_unlock(&target_list_lock);
 }
 #endif
=20
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -100,9 +100,11 @@ static inline void netpoll_poll_unlock(v
 		smp_store_release(&napi->poll_owner, -1);
 }
=20
+DECLARE_PER_CPU(int, _netpoll_tx_running);
+
 static inline bool netpoll_tx_running(struct net_device *dev)
 {
-	return irqs_disabled();
+	return this_cpu_read(_netpoll_tx_running);
 }
=20
 #else
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -58,6 +58,29 @@ static void zap_completion_queue(void);
 static unsigned int carrier_timeout =3D 4;
 module_param(carrier_timeout, uint, 0644);
=20
+DEFINE_PER_CPU(int, _netpoll_tx_running);
+EXPORT_PER_CPU_SYMBOL(_netpoll_tx_running);
+
+#define
netpoll_tx_begin(flags)					\
+	do {							\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) ||		\
+		    IS_ENABLED(CONFIG_NETCONSOLE_NBCON))	\
+			local_bh_disable();			\
+		else						\
+			local_irq_save(flags);			\
+		this_cpu_write(_netpoll_tx_running,
1);		\
+	} while (0)
+
+#define netpoll_tx_end(flags)					\
+	do {							\
+		this_cpu_write(_netpoll_tx_running,
0);		\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) ||		\
+		    IS_ENABLED(CONFIG_NETCONSOLE_NBCON))	\
+			local_bh_enable();			\
+		else						\
+			local_irq_restore(flags);		\
+	} while (0)
+
 static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev,
 				      struct netdev_queue *txq)
@@ -90,7 +113,7 @@ static void queue_process(struct work_st
 	struct netpoll_info *npinfo =3D
 		container_of(work, struct netpoll_info, tx_work.work);
 	struct sk_buff *skb;
-	unsigned long flags;
+	unsigned long __maybe_unused flags;
=20
 	while ((skb =3D skb_dequeue(&npinfo->txq))) {
 		struct net_device *dev =3D skb->dev;
@@ -102,7 +125,7 @@ static void queue_process(struct work_st
 			continue;
 		}
=20
-		local_irq_save(flags);
+		netpoll_tx_begin(flags);
 		/* check if skb->queue_mapping is still valid */
 		q_index =3D skb_get_queue_mapping(skb);
 		if (unlikely(q_index >=3D dev->real_num_tx_queues)) {
@@ -115,13 +138,13 @@ static void queue_process(struct work_st
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev,
txq))) {
 			skb_queue_head(&npinfo->txq, skb);
 			HARD_TX_UNLOCK(dev, txq);
-			local_irq_restore(flags);
+			netpoll_tx_end(flags);
=20
 			schedule_delayed_work(&npinfo->tx_work,
HZ/10);
 			return;
 		}
 		HARD_TX_UNLOCK(dev, txq);
-		local_irq_restore(flags);
+		netpoll_tx_end(flags);
 	}
 }
=20
@@ -246,7 +269,7 @@ static void refill_skbs(struct netpoll *
 static void zap_completion_queue(void)
 {
 	unsigned long flags;
-	struct softnet_data *sd =3D &get_cpu_var(softnet_data);
+	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
=20
 	if (sd->completion_queue) {
 		struct sk_buff *clist;
@@ -267,8 +290,6 @@ static void zap_completion_queue(void)
 			}
 		}
 	}
-
-	put_cpu_var(softnet_data);
 }
=20
 static struct sk_buff *find_skb(struct netpoll *np, int len, int
reserve)
@@ -319,7 +340,9 @@ static netdev_tx_t __netpoll_send_skb(st
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;
=20
+#if (!defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_NETCONSOLE_NBCON))
 	lockdep_assert_irqs_disabled();
+#endif
=20
 	dev =3D np->dev;
 	rcu_read_lock();
@@ -356,9 +379,11 @@ static netdev_tx_t __netpoll_send_skb(st
 			udelay(USEC_PER_POLL);
 		}
=20
+#if (!defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_NETCONSOLE_NBCON))
 		WARN_ONCE(!irqs_disabled(),
 			"netpoll_send_skb_on_dev(): %s enabled
interrupts in poll (%pS)\n",
 			dev->name, dev->netdev_ops->ndo_start_xmit);
+#endif
=20
 	}
=20
@@ -399,16 +424,16 @@ static void netpoll_udp_checksum(struct
=20
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	unsigned long flags;
+	unsigned long __maybe_unused flags;
 	netdev_tx_t ret;
=20
 	if (unlikely(!np)) {
 		dev_kfree_skb_irq(skb);
 		ret =3D NET_XMIT_DROP;
 	} else {
-		local_irq_save(flags);
+		netpoll_tx_begin(flags);
 		ret =3D __netpoll_send_skb(np, skb);
-		local_irq_restore(flags);
+		netpoll_tx_end(flags);
 	}
 	return ret;
 }
@@ -501,7 +526,7 @@ int netpoll_send_udp(struct netpoll *np,
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
=20
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
!IS_ENABLED(CONFIG_NETCONSOLE_NBCON))
 		WARN_ON_ONCE(!irqs_disabled());
=20
 	udp_len =3D len + sizeof(struct udphdr);


