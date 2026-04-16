Return-Path: <netdev+bounces-278968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBHjEgOf4GlukQAAu9opvQ
	(envelope-from <netdev+bounces-278968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:34:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB340B9AD
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7A630B5F60
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517143876C3;
	Thu, 16 Apr 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QjhW5LGs"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AA146588
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328044; cv=none; b=p5Pu2OzNBoulfDIi3146pBTZaIUeOl/tPgXw2He+HHiRZiXaTd3eeqY+IUyjmrGmAE3ISYG1N9+J+EPmMxERn+75G+89smf55lnoXieizkAA0BXhxwYPO3KHefpR3nWnu2/Yy88u1Gv1OF4z+NS0DCtgpL11sdm7/ULVFdB65GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328044; c=relaxed/simple;
	bh=HPHejJ+LnGwfAfrdx1fL/Y8Ru64+bxJnCtt0nJva9ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h30GAh+7V78N9WpsOcoKn4FMjLC6MDQFoVIxLhn4A2nYRRyfxoY8UtVKNfyNvRnYzBeK2fZTqbUzAF9SYy7geFL2dBRO38hQfKaRxRQ4BeoI7SHslhQA61kFGwIWg21hX6bXolgwFsTU1u+1jrlsP18IYlkz7DvKfzPyIJS1SVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QjhW5LGs; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776328030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eyo6E9moK+UoY1nhPnWmvg7SM04PixojRAeBdTB1HB8=;
	b=QjhW5LGsHEKlbRp2/QnwP3tUv8ZMmwMlp2epSZp+vJ8bFwAHASaQS7lG9yp6/0HMpsX72D
	EY1L5kdIXh7eiaVgib3wswPM+xjT9X2mji9HlXj/UvwblVATZDrhcO1TNH8H1M/ofu1Dhg
	7FOA8k38sciUOlzvO3B1vqGAMRKhtRA=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
	Jaco Kroon <jaco@uls.co.za>,
	James Carlson <carlsonj@workingcode.com>
Subject: [RFC net-next 1/3] ppp: use file.dead to check channel unregistration
Date: Thu, 16 Apr 2026 16:26:44 +0800
Message-ID: <20260416082656.86963-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278968-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCEB340B9AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, ppp_generic checks if pch->chan is NULL to determine if a
channel is being unregistered. However, struct ppp_file already has a
'dead' flag for this purpose, which is used by ppp units and other
parts of the driver.

Switch all pch->chan NULL checks to pch->file.dead checks. In
ppp_unregister_channel, move the setting of pch->file.dead inside the
locked section to ensure atomicity and remove the now redundant
pch->chan = NULL assignment.

This is a preparation to eventually unify 'struct ppp_channel' and
'struct channel' into a single struct.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index b0d3bc49c685..fd2889e374c9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -790,7 +790,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			down_read(&pch->chan_sem);
 			chan = pch->chan;
 			err = -ENOTTY;
-			if (chan && chan->ops->ioctl)
+			if (!pch->file.dead && chan->ops->ioctl)
 				err = chan->ops->ioctl(chan, cmd, arg);
 			up_read(&pch->chan_sem);
 		}
@@ -2167,7 +2167,7 @@ static void __ppp_channel_push(struct channel *pch, struct ppp *ppp)
 	struct sk_buff *skb;
 
 	spin_lock(&pch->downl);
-	if (pch->chan) {
+	if (!pch->file.dead) {
 		while (!skb_queue_empty(&pch->file.xq)) {
 			skb = skb_dequeue(&pch->file.xq);
 			if (!pch->chan->ops->start_xmit(pch->chan, skb)) {
@@ -2288,7 +2288,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 		goto out_rcu;
 
 	spin_lock_bh(&pchb->downl);
-	if (!pchb->chan) {
+	if (pchb->file.dead) {
 		/* channel got unregistered */
 		kfree_skb(skb);
 		goto outl;
@@ -3002,7 +3002,7 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	ppp_disconnect_channel(pch);
 	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
-	pch->chan = NULL;
+	pch->file.dead = 1;
 	spin_unlock_bh(&pch->downl);
 	up_write(&pch->chan_sem);
 
@@ -3013,7 +3013,6 @@ ppp_unregister_channel(struct ppp_channel *chan)
 
 	ppp_unbridge_channels(pch);
 
-	pch->file.dead = 1;
 	wake_up_interruptible(&pch->file.rwait);
 
 	ppp_release_channel(pch);
@@ -3505,7 +3504,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 
 	ppp_lock(ppp);
 	spin_lock_bh(&pch->downl);
-	if (!pch->chan) {
+	if (pch->file.dead) {
 		/* Don't connect unregistered channels */
 		spin_unlock_bh(&pch->downl);
 		ppp_unlock(ppp);
-- 
2.43.0


