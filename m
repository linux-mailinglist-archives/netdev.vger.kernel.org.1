Return-Path: <netdev+bounces-215485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C37B2EC6E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1431CC48F4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415332E7F07;
	Thu, 21 Aug 2025 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="LBtsbJLq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD562E7F0E;
	Thu, 21 Aug 2025 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748325; cv=none; b=Ie1cjwR0uZAElxIRePL0B+VoQAu6Vo5wVbFxFN27d7bF1CCJerXnKSEM5J71gILGx8aMi9IQ6zD02te+8TB7ZQxdTaMVfHq2nEQV3HR+r3cS6ndBXQoyXPIlhDUk4C8ehvqxH9sYvt3DQFQ4mPLSaAcdKfsNZ0moktASWYuobIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748325; c=relaxed/simple;
	bh=D6XroiM0gJV0WhKzOpzC3jsrMzOwR9rtyTbykVkhfjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kyYc7GALnz2ioWcx76vAeZtmH+0wqWAMTDMiN+Af6APMjIELMGfH3cRFU686+EkHXuwexhC6V4SVWsf20ghllR5pabG6KPtecwLaw3MrHYYNbRGY/pdvnvJH7G9WVMndYr+Azm2wLc6rpSLs8WsJ9Q/CUOnER0ypCTKNs7bnBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=LBtsbJLq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755748320; x=1756353120; i=efault@gmx.de;
	bh=lT2XgMK46M0i4BHPZ8NixOE47L4gXl3+5/G/rpH8SY8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LBtsbJLqLk0q61dWZBn7La2YUHAfzBZnD8t5NoXbSP6ZrskjFLrYCD0U7WVG08xE
	 CdFGbp7qun8JoQr1zsuryqELx40pF5Ta6XzjEfvJuQICS8fdqYfuOmBmIumJNeENl
	 B4KoD14DrKZ1xpNZVmlt6NFMXsRiYLQRNtJmM9QGqk6uDTLLisjDEHqeFHBbxpHCD
	 YtWzlUI20elhegdsezeE4pXPcfqG+C9z+sMCe8RVHxLz3GZCTdVxSWBOun6cR68wP
	 ZpH65I/+23OG/Yu4HpdkhWJ/YhaoivhwwctFGO63nvULYAmTpQKiFflg8pxXptyeX
	 t1iq2VPSmH6R/s3KkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.96]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1u60bV1F5x-00ea5j; Thu, 21
 Aug 2025 05:52:00 +0200
Message-ID: <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Thu, 21 Aug 2025 05:51:59 +0200
In-Reply-To: <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
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
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
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
X-Provags-ID: V03:K1:vcgNMC2xXPgdCBT4V4iOq35JcGjWlCy56Qjuxei0qICvuJYTm44
 tUSyo8xdNqac7Ksg6CnkJ8EwYMRrIakomtJ62PUws/Gg2CKE/Zc1iaiDb8+xii1U5etCRN0
 ruuLqR/EDgdK/l4kYD5wPirgwsk0g+tJEyauNv8FRZ4df5RVnIhbNCA2gzYcsP9n092+xFl
 Pe66oWDSiWxHRWUbCjy/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QNvlsP2c/5s=;ZgeJYT40KvNiGiUwN/bO5069G31
 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
 wgGCqeDHPYOg7YfP55ktcB8HV59v

On Thu, 2025-08-21 at 05:37 +0200, Mike Galbraith wrote:
>=20
> > What is this patch you have?
>=20
> Make boxen stop bitching at NETCONSOLE_NBCON version below.

Grr, whitespace damaged. Doesn't really matter given it's not a
submission, but it annoys me when I meet it on lkml, so take2.

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

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/net/netconsole.c |    4 ++--
 include/linux/netpoll.h  |    4 +++-
 net/core/netpoll.c       |   47 ++++++++++++++++++++++++++++++++++++------=
-----
 3 files changed, 41 insertions(+), 14 deletions(-)

--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
 static void netconsole_device_lock(struct console *con, unsigned long *fla=
gs)
 {
 	/* protects all the targets at the same time */
-	spin_lock_irqsave(&target_list_lock, *flags);
+	spin_lock(&target_list_lock);
 }
=20
 static void netconsole_device_unlock(struct console *con, unsigned long fl=
ags)
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
+#define netpoll_tx_begin(flags)					\
+	do {							\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) ||		\
+		    IS_ENABLED(CONFIG_NETCONSOLE_NBCON))	\
+			local_bh_disable();			\
+		else						\
+			local_irq_save(flags);			\
+		this_cpu_write(_netpoll_tx_running, 1);		\
+	} while (0)
+
+#define netpoll_tx_end(flags)					\
+	do {							\
+		this_cpu_write(_netpoll_tx_running, 0);		\
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
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			skb_queue_head(&npinfo->txq, skb);
 			HARD_TX_UNLOCK(dev, txq);
-			local_irq_restore(flags);
+			netpoll_tx_end(flags);
=20
 			schedule_delayed_work(&npinfo->tx_work, HZ/10);
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
 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
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
 			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pS)\n",
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
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !IS_ENABLED(CONFIG_NETCONSOLE_NBCON=
))
 		WARN_ON_ONCE(!irqs_disabled());
=20
 	udp_len =3D len + sizeof(struct udphdr);


