Return-Path: <netdev+bounces-300182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4yEeEZqoMmpM3QUAu9opvQ
	(envelope-from <netdev+bounces-300182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845369A5D2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MVdMzwPS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300182-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC5D30D5216
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2C3F8715;
	Wed, 17 Jun 2026 13:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C93F8223
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 13:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704705; cv=none; b=QjofKkpZvNl44tTm8GxcHl4wL+QwSJqgIpsADtr1fmRXiPA8R0GioEyVToCHujuVemiMssx68f+JFzI7cSn/eEq8+D0qAJH6ZP6Y77ut6xlQIQUqf9Ds0tYC5+7/de/Qpd6OL/O42V8U9Kue9nkFioclDwHOh2ET5aqBXEhGTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704705; c=relaxed/simple;
	bh=tzsh1RcsgUOuMxb4pSht9EJ2hhcGpEY+HBY6b6wi0hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WExA9Z5ndT2s/pwBuBgN6M2YE6JKmV/37ZZ4ydHjaa+51Y3UmG8EKfQHDXcrcBoiOHz0edMID7ucqZxK+sJ+DJnlC9gnORycHB87phORxSAlcWZDrObOoDQAaGLEkwLRxKN2Yr1oDH0ue8VG+bbp5e2jLfY7DyeN0gr/S4KUIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVdMzwPS; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c88d1d4543fso63973a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781704703; x=1782309503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4czITKx5Iqwyu5hn8KJkSYmMYtgj6wnyBke0BqX7bA=;
        b=MVdMzwPSbahru/44iBqaRsmkheJ4knns5TopwKiN4K+J5qXV2Gqi82FDultXXZIaSH
         l4A8/zF0rrREHP+rPf8h78KDyiAF2tzPErVPXfn5+FTAV/e7f1D+ErgI+UmNZoqmuvKJ
         Z/1trUXrNWQTMvCbaYuvw3WYXvnQxIwcduAjYuWTZG/FJO2lSD49yQq2knul/NZf9QNz
         Sj5u7uaFzL2XcQ29VTiNyLSUQ9TVdPI0IEosgzW9Zgz0wnEjejEMVEeoRdj2Ij9DETnf
         y94hiVATIfcYX8PSKJyK4243BCl0o7D9aBRlRGCs4S0zvPg4ehZi2qUjYRu1sLgFN/86
         Emmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781704703; x=1782309503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4czITKx5Iqwyu5hn8KJkSYmMYtgj6wnyBke0BqX7bA=;
        b=Nle1RuJsQGKPkQ3wncF+tjkt2iW8YZJOi/icR8hz17QQWBtUM8CaLJ8N1gvWPMVuVX
         uSbl0tpwjvJWWHTi5j6Zg9vAD7IVwq1V51iAOQBfwVpXhdFlWMc9lK4LA8yjXzsXRsIz
         FWoe4oq/laCYnBnZqIjhIru0tedDkg+P9+e3fR5JM9P558vk1PLjZ//zxCez9izxHDGJ
         MyDESzPC+dD9GNCuiab//gOF8GZ0wNHI5YS1ApzDoN8mJSchvlnEvn/WjAA0avSWh7Nb
         tP4++I/ZSrBwmXUumC+oiy3BZHGUJd53k0Om6bUKBtq1TddtyrSgQvns/Z+c4YwQqTL5
         Zrrg==
X-Forwarded-Encrypted: i=1; AFNElJ/l8xak2v7bqAm5YYwmDuacD/hs0OGwHVzUVhFOyEw/oH0nMBH6BoDVoOjG6GWW6JdeMUbaVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzor0iFsdJcrsJIMVwu/lOifzpa3pIVnYFE2JvnFE/QyNswOvOV
	M7l4/tz8h9pAF+eucsHcstvEfTnpgPPhc7Vq4gY3QLTWQ8UFeElFs63/
X-Gm-Gg: AfdE7cmbgYKLfhsKpJHgXwlEk0m3NN/oIAXiu6e1scWAGgbN94jryyb4j0lKEN2I70+
	GyFcKfjKRQvDPVKkiasMeW6mz9d+cHDiQtEbbL7jmDAnzu2old2UzpZU67yfJhZiPTmmBLO47AD
	6YCaLtTycyHgSgCsPlzGA7cH1SPfHaQWI17+gydH2wxIYG8CBkt0t1hjofqVobp8Ow77/csi99h
	dDJNKL4liSStQDrTR0pL7C8i2HpkoNpqH3z3UVBJHF+pLbHu28Oyq42fZNa+GW67n9BctPnGD25
	2Rm8PvQaK3g9cMMTbe/t/cfdXLbwQv8CL/FJlWr5JEXhfy10LoIvO6oJ1WwM8LWWKh/1YNxb631
	brPyEkGq8NXwYTfHv28OKJOt41orcbjow4fLnicxUnifh05BLu6UFyK27dqW0B8VBGxfqS3nbBy
	rw+FZS+iKSsklGny2FLmOqr7A+wn7psUSuHDWU+GJESSeR+JFFTyvmb1uK7ecZCNcDlkYhsHuOE
	Q==
X-Received: by 2002:a17:902:c94c:b0:2c6:6425:b343 with SMTP id d9443c01a7336-2c6bcfaaacfmr28009245ad.6.1781704702999;
        Wed, 17 Jun 2026 06:58:22 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f0a36sm159725575ad.15.2026.06.17.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:58:22 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
Date: Wed, 17 Jun 2026 21:57:45 +0800
Message-ID: <20260617135744.3383175-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,windriver.com,vger.kernel.org,lists.sourceforge.net,asu.edu,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300182-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8845369A5D2

bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(),
but tipc_disc_rcv() still dereferences b->disc in RX softirq under
rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).

L2 bearers are safe thanks to the synchronize_net() in
tipc_disable_l2_media(), but the UDP bearer defers that call to the
cleanup_bearer() workqueue, so the discoverer is freed with no grace
period:

 BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:149)
 Read of size 8 at addr ffff88802348b728 by task poc_tipc/184
 <IRQ>
  tipc_disc_rcv (net/tipc/discover.c:149)
  tipc_rcv (net/tipc/node.c:2126)
  tipc_udp_recv (net/tipc/udp_media.c:391)
  udp_rcv (net/ipv4/udp.c:2643)
  ip_local_deliver_finish (net/ipv4/ip_input.c:241)
 </IRQ>
 Freed by task 181:
  kfree (mm/slub.c:6565)
  bearer_disable (net/tipc/bearer.c:418)
  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)

The bearer is freed with kfree_rcu(); free the discoverer the same way.
Add an rcu_head to struct tipc_discoverer and free it and its skb from an
RCU callback.

Because the RCU callback (tipc_disc_free_rcu) lives in module text, a
call_rcu() that is still pending when the tipc module is unloaded would
invoke a freed function. Add an rcu_barrier() to tipc_exit() after the
bearer subsystem has been torn down, so all pending discoverer callbacks
have run before the module text goes away.

Reachable from an unprivileged user namespace: the TIPCv2 genl family is
netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs CONFIG_TIPC
and CONFIG_TIPC_MEDIA_UDP.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
 - Reword the rcu_barrier() comment as a TODO (Tung Quang Nguyen).
v2:
 - split the over-80-column container_of() line (Tung Quang Nguyen)
 - add rcu_barrier() to tipc_exit() so a pending call_rcu() cannot fire
   into freed module text after rmmod (Eric Dumazet)

 net/tipc/core.c     |  5 +++++
 net/tipc/discover.c | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 434e70eabe08..1ddecea1df6e 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -218,6 +218,11 @@ static void __exit tipc_exit(void)
 	unregister_pernet_device(&tipc_net_ops);
 	tipc_unregister_sysctl();
 
+	/* TODO: Wait for all timers that called call_rcu() to finish before
+	 * calling rcu_barrier().
+	 */
+	rcu_barrier();
+
 	pr_info("Deactivated\n");
 }
 
diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 3e54d2df5683..b9d06595b067 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -58,6 +58,7 @@
  * @skb: request message to be (repeatedly) sent
  * @timer: timer governing period between requests
  * @timer_intv: current interval between requests (in ms)
+ * @rcu: RCU head for deferred freeing
  */
 struct tipc_discoverer {
 	u32 bearer_id;
@@ -69,6 +70,7 @@ struct tipc_discoverer {
 	struct sk_buff *skb;
 	struct timer_list timer;
 	unsigned long timer_intv;
+	struct rcu_head rcu;
 };
 
 /**
@@ -382,6 +384,15 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 	return 0;
 }
 
+static void tipc_disc_free_rcu(struct rcu_head *rp)
+{
+	struct tipc_discoverer *d = container_of(rp, struct tipc_discoverer,
+						 rcu);
+
+	kfree_skb(d->skb);
+	kfree(d);
+}
+
 /**
  * tipc_disc_delete - destroy object sending periodic link setup requests
  * @d: ptr to link dest structure
@@ -389,8 +400,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 void tipc_disc_delete(struct tipc_discoverer *d)
 {
 	timer_shutdown_sync(&d->timer);
-	kfree_skb(d->skb);
-	kfree(d);
+	call_rcu(&d->rcu, tipc_disc_free_rcu);
 }
 
 /**
-- 
2.43.0


