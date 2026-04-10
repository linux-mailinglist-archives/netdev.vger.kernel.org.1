Return-Path: <netdev+bounces-277313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QqfWLxnH2GmGiAgAu9opvQ
	(envelope-from <netdev+bounces-277313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:47:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15E3D529F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E20DC3050C1F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC336EAAA;
	Fri, 10 Apr 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CVlOo5SW"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243334D3B0
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813971; cv=none; b=NGL9TS3kdwXCbWjRcfGG0qNamsuEo7QMHTqcrnqT7fCEdQeZ2v3FRlybSg5Pi6AnGpklWld/6BapVzugt8No5wgtVqcVq+u8rxBF75Qm74fBzEKedDTquDbrN5awdcQBfahmok56Wfyx3PV9fJQuWKZZzVKAk/ARL2mBuIHJKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813971; c=relaxed/simple;
	bh=RIn5QS+/wQzlvfqGGsGZEx3uU16qwFy1NVNMP3oy5CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QT7yF8t++j+Hs8ZpjPiCS8Wd7PJk/hlJBP7/CWenfPZUexcCM/gW3KiRNREvcvkYBAZTF+68noC+Vw1qrSQPA7JjW31sknFXN76s9LawE2meRT9VyTETAssDHCYPnYhfW6fZVDKIVwSYmONKTS/k2v4K6vAzjziF0CNN2LITlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CVlOo5SW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775813958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KbAA0jl9JOczfY3YunY2afV3MXW4kTf45LXLhHaMhow=;
	b=CVlOo5SWqqQx7F2ZN43SJCcEADQBbMBgQHw26nF2uyWU6VxP4NPGDgicWOVQhv2MiEde3P
	+46PUZYEAxnijpTgN8n6L6uFOvPtetciQEe0ho7G2SpyVqMKa6enBOz93g1SpLJa/xTUhV
	A3QkgtD7NbOyPbNglrKZFpW8G5Y1sxA=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Yue Haibing <yuehaibing@huawei.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tom Parkin <tparkin@katalix.com>,
	James Chapman <jchapman@katalix.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next] ppp: tear down bridge before clearing pch->chan
Date: Fri, 10 Apr 2026 17:38:56 +0800
Message-ID: <20260410093859.69237-1-qingfang.deng@linux.dev>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-277313-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E15E3D529F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As we previously did to ppp_disconnect_channel(), also move
ppp_unbridge_channels() before pch->chan is set to NULL in
ppp_unregister_channel().

ppp_unbridge_channels() calls synchronize_rcu(), so no concurrent RCU
readers in ppp_channel_bridge_input() can observe the channel after its
chan pointer is cleared.

This makes the !pchb->chan check in ppp_channel_bridge_input()
redundant and can be safely removed.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index b097d1b38ac9..3a609d48a424 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2285,17 +2285,11 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 		goto out_rcu;
 
 	spin_lock_bh(&pchb->downl);
-	if (!pchb->chan) {
-		/* channel got unregistered */
-		kfree_skb(skb);
-		goto outl;
-	}
 
 	skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
 	if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
 		kfree_skb(skb);
 
-outl:
 	spin_unlock_bh(&pchb->downl);
 out_rcu:
 	rcu_read_unlock();
@@ -2997,6 +2991,8 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	 * the channel's start_xmit or ioctl routine before we proceed.
 	 */
 	ppp_disconnect_channel(pch);
+	ppp_unbridge_channels(pch);
+
 	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
 	pch->chan = NULL;
@@ -3008,8 +3004,6 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	list_del(&pch->list);
 	spin_unlock_bh(&pn->all_channels_lock);
 
-	ppp_unbridge_channels(pch);
-
 	pch->file.dead = 1;
 	wake_up_interruptible(&pch->file.rwait);
 
-- 
2.43.0


