Return-Path: <netdev+bounces-304303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aUKJAvD9Rmo5gQsAu9opvQ
	(envelope-from <netdev+bounces-304303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D68636FD8D3
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XCMCWkQ2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304303-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304303-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D62B302C1F0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9007E105;
	Fri,  3 Jul 2026 00:10:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB711429D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037415; cv=none; b=dVySmMBFhI0Y5b3YVtrI5kPkyuCTSJJ4keLdRxL/84U28DNcdilUoFkUQEGHV0LlzJwWXlfLGIaAEs6S/aZzVs45CaY7HewBIFhtu+1XlA555m5nrBRtyhVF5MbrhmJDoO9WYzqWWtRHlJ8ovfuF0K/hwsj0Ir9sVl/HSocS5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037415; c=relaxed/simple;
	bh=rXdKas2qFAGabXxz+upauTJMdBqVTTCwB4bLVS7dhyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Egj0LkWdYA2VPxt7JmtApIR47Mot9U+ImxXJJPf4GDuGzGEipq3bIgziWCoXFXl5k8GNrHOwqxVsy555BZyBgl4k7Q9st6C9YbfADvwnJRUpGBlaqpOHULq0la8KkVFdBHFgh3HrPSqeWTT4yAp/5o2+O7Ls3V8U1y5+baYM1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCMCWkQ2; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca0331d0b1so41610025ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037413; x=1783642213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1D44iiuED1WFtnyZpajMPXSIx3JxJag8mmpE+v2bc=;
        b=XCMCWkQ2mmAp+obTQr+/aR5p4PvjYuWOUyLdr0kgsa/FOUQd++oJnsaZFCYuuCHU4G
         WLV0UYxl/X5xtEEC90uE51JEDVWHNdmH+Ny5PMMkKMZ5GW9ph+RXGFRwI2aMOnD+veEy
         ceOuhRuKCZ/ZkToNVXc+2eqbpkVetJP3kgzeJlV5LRAadSv0AuYAPeKV6jN+3LbRefzi
         0CkDAsyRJvrcaIVeMiPynA+F83SsBmqpHKXcxSsPhirSsG7/PYTnTFqPWe1W+hWTUwWY
         Gpkeq0fA6SSFYyUkQRiN8jDNOQ4HEX8VwJq08mSbTqw9Z4yLsQ7D5mG1JsfjFx7T4iys
         X88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037413; x=1783642213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD1D44iiuED1WFtnyZpajMPXSIx3JxJag8mmpE+v2bc=;
        b=c/qbLwroIdH664gm1jYRiGVOlqwKO8Sm748fHFMeBXUUHGFG1+EE6oYro8fetKxH1m
         Ux3qU8JoJvmj0VBGPQzvhhlGDFJPKmyAWqJjtxMW3zqB0mt9uPS32ym1n57jbS1cM6QW
         a8XovVfnLbQ11g7iKhmg7i62egSXktwL7MjgeiXWDCF6QgRGlDHC8yJx5mEwAUMyqYMM
         6erqesrkxsIoPrFEWkVrBW8MSknuwvg+DR8G/1jN934uZgkVqI5amAtozEgTfZar+AYX
         ebc6R1cvWZ8xOlkDkWSBmvRnwIVlgFR4vxoXAKZpVe+VL2MY25dGmfnGc1Iw52G670sz
         TZMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hr3rkeYB5h5xHuZ0q8cCPFhFIzh/XRVbkrlihkVhBM5zzMwT9dYZS72VX+f+1hNKNTVvs4jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Buqc2z184PhyUTC4F68yXg8OIA6nNCCzSRFxVuoWQKh7rtEN
	5hacealmLFQ/DYbEd2WBjo/17rArwuSSsNNz8+AtSmIw7aylNry5nYJvpdSBSjDpWXqhHmCM2G6
	ZgHHgvQ==
X-Received: from pgwa11.prod.google.com ([2002:a65:654b:0:b0:c99:d21a:f6cc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c08:b0:3b4:8f4a:3bc6
 with SMTP id adf61e73a8af0-3bfed3e9292mr9278411637.32.1783037412925; Thu, 02
 Jul 2026 17:10:12 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:13 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/14] rtnetlink: Call unregister_netdevice_many()
 only once in rtnl_link_unregister().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304303-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D68636FD8D3

When rtnl_link_unregister() is called during module unload, it
calls __rtnl_kill_links() for every netns.

__rtnl_kill_links() collects all devices of the unloaded module
and passes them to unregister_netdevice_many().

Let's move unregister_netdevice_many() to rtnl_link_unregister()
to unregister all devices across netns in a single batch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/rtnetlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f39c93e80e20..7207da002fb5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -637,16 +637,15 @@ int rtnl_link_register(struct rtnl_link_ops *ops)
 }
 EXPORT_SYMBOL_GPL(rtnl_link_register);
 
-static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
+static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops,
+			      struct list_head *dev_kill_list)
 {
 	struct net_device *dev;
-	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
 		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+			ops->dellink(dev, dev_kill_list);
 	}
-	unregister_netdevice_many(&list_kill);
 }
 
 /* Return with the rtnl_lock held when there are no network
@@ -677,6 +676,7 @@ static void rtnl_lock_unregistering_all(void)
  */
 void rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
+	LIST_HEAD(dev_kill_list);
 	struct net *net;
 
 	mutex_lock(&link_ops_mutex);
@@ -691,7 +691,9 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	rtnl_lock_unregistering_all();
 
 	for_each_net(net)
-		__rtnl_kill_links(net, ops);
+		__rtnl_kill_links(net, ops, &dev_kill_list);
+
+	unregister_netdevice_many(&dev_kill_list);
 
 	rtnl_unlock();
 	up_write(&pernet_ops_rwsem);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


