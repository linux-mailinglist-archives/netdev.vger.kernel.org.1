Return-Path: <netdev+bounces-214545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF1B2A121
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7A77AB8FA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F53101CF;
	Mon, 18 Aug 2025 12:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45226F290;
	Mon, 18 Aug 2025 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519031; cv=none; b=bYPsmEs/eB6A16tNWb4td4m3F39wA6uadOVvMBx/X73KAwSl9ng7CWKRaVNRf0dl/keY5MP1ba1ybMwEJTREVXl2v7xb+9IOZxrkQlPNZfOC5oWHvms3Ey73H7+AF+1KjtG0Mrd07R6Xjhtff4bPi0IhHw/rZMdwg4t4hci7cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519031; c=relaxed/simple;
	bh=pbFQZ6F8H/+ENS2NlxGponIfCWcYPLd8TUnOyp7tAHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtFuXfo8HNymCKGwYapdP1Y1G6R28MDhAHSCpcTQsjQoiiWqLxIoL7p8YYdc4yGq8cOR5++cnQRISMtSmsU15qW1qb7DXM+WOmpBlT01PBb3uFOOaV6Jvcgjr1BBQB04z9mR7GnXd0trufhFlA9Q+KYig73oK3FRseollqYj09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso5760402a12.0;
        Mon, 18 Aug 2025 05:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519028; x=1756123828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfKJNISuryMHsuKOipur4LoH3AcpITjIZh4IQNVTv60=;
        b=IzOVxh3vKoXZfWr3URF+nXmfj5lP+uJNh+aRqNNug0PvzSUqCOBDutpmOwZj+rVqQe
         1o8oaIMc3n/VKgnfZaqg2y5cqOBPYUlLlNcvqpEu2oSAtR2woWU3CYKpYT3I3DsV+AUH
         vdBkbo1YZ5qcFrDP0HDZoTD5oWXWxacYEwBYKbALKi1nw7JutYD/SdIcRkbrL+uV74NB
         NrKVZ7gzOtUHeLgq3frjpBs8uo+1nw/yrA8RNp2ZvVi1/w95qhaM5rYd0uzdwnbrPNgt
         iH97Hn/DLMRURaadZr63xM02uuYemI3OQtPihhlZFyIM8xWHmxZZCOxHALOkR7hxY9eL
         iedw==
X-Forwarded-Encrypted: i=1; AJvYcCU27WlNcl7gjEqAuKI4NtXB6//B7sH38rFIsq0fZOX3TF3/Gf6xh5Ij3ZBJ27w9npR9oRQBlJgnWijh2Lg=@vger.kernel.org, AJvYcCXX3qFnKbBmM0b9XL9iEdcWmkoctuMF3RohCpUcfbEA8g6JZvSju5HhMiorNGvPqeSlKXGzXdBR@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNSRAkBOL5PGueYXr17xAA96VO/Qfc2cjTykZtLXSl3U/MeiE
	Z2Xc11h2sfqq+vQ/qusT0qhfUY8vAEERnju1K3x3E522+/nKfVoF2Bl7
X-Gm-Gg: ASbGncvYNDFy+/eYEM9XyWQHZL4/+Av5FxbzUlI/60oY2TmWANcHpRSsEcl52p33Ks1
	MYmrmDlUliJGKMPhYRN+yw8AT457J1ljQm8IM9pe3DfKCC3fh3bEF+hrEuYm6Bset8PwPk+Zqlq
	YA4LPwekrsfIp/fUQni5XVfGFmsM6MCOZQZJKTKIBAlmh9nv6r6jkAwYdMpGZ4QE4KDv4BSQflA
	W/wBVV1lykyae385ir8bRvI32BycmE18U08diMJSAQ744b3O42F7NWC4g6pjyZZ0qCWAY2T/5TX
	d+XNWUeI79skg9lkTuKK7IxXJFn7t4R24m/Dhd6pykiDMjc1f/sV5BYmsIKB3KM0cdGao7lziYD
	4C/PrXTSAjRE9i0qPQ8yY6T8i
X-Google-Smtp-Source: AGHT+IEXDazwxgbe1DUH1OV6NThaTWuVSI4WSiRMEI/RXhYH6UQdZyqt2d0zN/4UpH8T3+iqef3u8w==
X-Received: by 2002:a05:6402:35d0:b0:615:c767:5ba1 with SMTP id 4fb4d7f45d1cf-618b0523173mr10035748a12.3.1755519027500;
        Mon, 18 Aug 2025 05:10:27 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b02b11bbsm7034549a12.53.2025.08.18.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:10:27 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:10:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Mike Galbraith <efault@gmx.de>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>

On Fri, Aug 15, 2025 at 09:02:27PM +0100, Pavel Begunkov wrote:
> On 8/15/25 18:29, Breno Leitao wrote:
> > On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
> > > On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> > > > On 8/15/25 01:23, Jakub Kicinski wrote:
> > > 
> > > I suspect disabling netconsole over WiFi may be the most sensible way out.
> > 
> > I believe we might be facing a similar issue with virtio-net.
> > Specifically, any network adapter where TX is not safe to use in IRQ
> > context encounters this problem.
> > 
> > If we want to keep netconsole enabled on all TX paths, a possible
> > solution is to defer the transmission work when netconsole is called
> > inside an IRQ.
> > 
> > The idea is that netconsole first checks if it is running in an IRQ
> > context using in_irq(). If so, it queues the skb without transmitting it
> > immediately and schedules deferred work to handle the transmission
> > later.
> > 
> > A rough implementation could be:
> > 
> > static void send_udp(struct netconsole_target *nt, const char *msg, int len) {
> > 
> > 	/* get the SKB that is already populated, with all the headers
> > 	 * and ready to be sent
> > 	 */
> > 	struct sk_buff = netpoll_get_skb(&nt->np, msg, len);
> > 
> > 	if (in_irq()) {
> 
> It's not just irq handlers but any context that has irqs disabled, and
> since it's nested under irq-safe console_owner it'd need to always be
> deferred or somehow moved out of the console_owner critical section.

Agree. An IRQ-unsafe lock (fq lock) should not be reachable from an IRQ
disabled code path. So, one solution might be to always send TX packets
from a workqueue (unless it is on panic, as suggested by Calvin).

I've created a quick PoC to see how it looks like to always transmit
from a a work queue:

commit 02d0f38c3e435e4349de2fa3ce50fa8841aa0df9
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Aug 18 04:09:44 2025 -0700

    netpoll: move packet transmission to workqueue for non-blocking output
    
    This patch modifies the netpoll subsystem to perform packet transmission
    asynchronously via a dedicated workqueue, always sending the packet from
    a workqueue. This fix potential deadlock when the network locks are not
    HARDIRQ safe.
    
    Packets generated for transmission are queued on tx_queue and the workqueue
    is scheduled to send them in process context, avoiding sending packets
    directly from atomic context except during oops handling.
    
    This affect only netconsole, given that no other netpoll user uses
    netpoll_send_udp().
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b5ea9882eda8b..bac9dec8bd3bc 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -35,8 +35,8 @@ struct netpoll {
 	bool ipv6;
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
-	struct sk_buff_head skb_pool;
-	struct work_struct refill_wq;
+	struct sk_buff_head skb_pool, tx_queue;
+	struct work_struct refill_wq, tx_wq;
 };
 
 #define np_info(np, fmt, ...)				\
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..92a4186cebb83 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -496,6 +496,16 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 		eth->h_proto = htons(ETH_P_IP);
 }
 
+static int netpoll_queue_skb(struct netpoll *np, struct sk_buff *skb)
+{
+	/* Queue at the tail and TX from the head */
+	skb_queue_tail(&np->tx_queue, skb);
+	schedule_work(&np->tx_wq);
+
+	/* TODO: this will need some refactor to update netconsole stats properly */
+	return NET_XMIT_SUCCESS;
+}
+
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
@@ -528,7 +538,10 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	push_eth(np, skb);
 	skb->dev = np->dev;
 
-	return (int)netpoll_send_skb(np, skb);
+	if (oops_in_progress)
+		return (int)netpoll_send_skb(np, skb);
+
+	return netpoll_queue_skb(np, skb);
 }
 EXPORT_SYMBOL(netpoll_send_udp);
 
@@ -540,6 +553,23 @@ static void skb_pool_flush(struct netpoll *np)
 	cancel_work_sync(&np->refill_wq);
 	skb_pool = &np->skb_pool;
 	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
+
+	/* tx_queue must be empty here, given we the pkts were flushed
+	 * after users got disabled.
+	 */
+	if (WARN_ON_ONCE(skb_queue_len(&np->tx_queue)))
+		skb_queue_purge(&np->tx_queue);
+}
+
+static void netpoll_flush_tx_poll(struct work_struct *work)
+{
+	struct sk_buff *skb;
+	struct netpoll *np;
+
+	np = container_of(work, struct netpoll, tx_wq);
+
+	while ((skb = skb_dequeue(&np->tx_queue)))
+		netpoll_send_skb(np, skb);
 }
 
 static void refill_skbs_work_handler(struct work_struct *work)
@@ -557,6 +587,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	int err;
 
 	skb_queue_head_init(&np->skb_pool);
+	skb_queue_head_init(&np->tx_queue);
 
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
@@ -596,6 +627,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	/* fill up the skb queue */
 	refill_skbs(np);
 	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
+	INIT_WORK(&np->tx_wq, netpoll_flush_tx_poll);
 
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
@@ -815,6 +847,8 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	cancel_work_sync(&np->tx_wq);
+
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 

