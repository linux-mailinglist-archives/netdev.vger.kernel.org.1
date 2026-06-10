Return-Path: <netdev+bounces-297754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7y/RM9aOKWr7ZQMAu9opvQ
	(envelope-from <netdev+bounces-297754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 702E766B594
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PnpaPzgr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297754-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297754-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0615C309FC32
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAC42B74B;
	Wed, 10 Jun 2026 16:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F211428463
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107727; cv=none; b=W8xM3ya1exFAISPRWFxuSOutXAm2jui3seCLOV/crwk/MT9mcV1r8kQa743d01AkClC1jqP9Yw0bbb3Qy9veNHmFTrDIwnEns4f9fq56cZngTZS7Gw5dqEhuCai9PmDJ5slrw9Oo/ckrdvi9ceLGSvcegAVdrIetHHwDUc/L/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107727; c=relaxed/simple;
	bh=T8iqph9GHQBI61A8YzT1Kso8HRhlpEbAPfMd2qtm8LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tORcwpTuemf8AgtrCBXVgEZXwm40fFstOcVK5IXou5a8dFViO/rEzSCj16jKWXDm+LszEvbOG5P8HPD42d3PHbouOf4zRmgVqVdsH3xhfqmpq1uXOm2MzqtzoXhcgMH+nnJ2QF5qXMVTMYCpf3CBUn7NEk5lJ0H+N+WAEZSljX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnpaPzgr; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf114b0cf9so64675725ad.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107725; x=1781712525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFIEiprovOp703K0D/rIvyeptamFy22pkJ/EjlDN9sY=;
        b=PnpaPzgrefpD0jRhnIGxrwSOhb5Wy8rsXQS1o2uAK6AG9cpMpk2IKW7FnO5TvTTE+k
         AdW2/0RMD2B2S6kAlxMsa04Q5ai3VLGWudN1YPF6hnt8S2JPhfIcP2Y8oc6IImd6ubwn
         as7dE8LGHQV9nXhXaVitSA386Zm1vlUYlCUkFl5+V6/GS3Rszgm7QyX8Z8/liO09Q8v7
         WYzvhURnwIQFkshiXmEXp/r50AvSMt6fvMuyvMWOUVgxaPIdDaocEfKpAZInUat222+7
         oMk0p6WjlwvO7tVSa9luxy3iiE9pNXbcNVslY6URtGSip8dnVQBdSQeS7gShRximp/Y2
         x1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107725; x=1781712525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFIEiprovOp703K0D/rIvyeptamFy22pkJ/EjlDN9sY=;
        b=EhHdIoySHBh+h91jaDiSVX77gXWufacG3TBuobGnsxvVGdtxYbH4zi+Ez/LZSHCIak
         yOTbOyGs/cfa8FNQAIFQKOGiBqK7KUPEeB5mutOK+G/QFNqxzIdyJhLQzyvYRexLLSd7
         dZzsplc/GLKlHVr7Q2R1tStUX2nfVzQvPQh7WwZke1aeuaTKV4/8LhGnc6X7/VxI28P+
         7KxKUWXAkPIfCUvGTX1rvEmkE5PbpzuvflvzkgIP8dx0Ksm0yK6SOufRn3olJvpMM9KQ
         ifzZny5tFXMtQI9ohsuilAgV/vtHJx3JVJuNZw7x27SOXMv9g4464gZB5zsuS0eHt08h
         UJGw==
X-Forwarded-Encrypted: i=1; AFNElJ/ExMiAb+ocIoL7krB+nWoM6ajnreFM9vvDyjxOcAVCrhuVK4ubMlolgk/IhxuYzto9CLphJSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYKeInlYsWW3OwQ4yRWVqmusR9BwhDJHIG3fQExyzYiDl3xGr
	DI61zZAJVGYBk6pqPD8WwAbi+SDK4VMzT47wsRJtwxqfKbkM9ZbcivFM
X-Gm-Gg: Acq92OHcn+QQkpYOEAW3k8OnYjsXrECoD74TCnao/fgnit9JCRlpwtu55mJjxTDgVzS
	m/mRjL6SKFO8IG8TKjZaDpYeJLkdyVecsYhq7dGVue4NrBrbTrMhEJntWLCmqmS9kQSRqE+iOh/
	pvFBTFN1C6Za0GMn3qjaifWFojVDOstg9GQbiwcNVKBUMZgmQNvG9JIqYpasA/IB5XyZCVBfGNC
	n1qIrROiRB3koUmoBrZVxJcxbatvAGqSmizKUEiQaMVJmJoI6UhPfh/WvKCCvaOtu7/zUk7d1gD
	7P93rD2X0lu1Lih9Pht6ZlW0/dBz1pnJfgBehxdFMhUeODNZYShKOodG457xHFE97qghomUWLr6
	F7HLY752XgGm2Kdx4jsp27OViAjkgWeVq1GRa9saxmgMNWNy19XlRwIRC1XoAxzTbDiZeMeqXQ/
	NZ/4wDMwcRvPy3ESyUH6OXvJaGmH+Co+XDwq+P3sSFgHUAyCXW5TGPxYZ0cOA9Pk/Ib/RSyImmj
	zZhMjD0H0Nl8gwLczw6Qcg=
X-Received: by 2002:a17:902:da88:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2c1e8213a72mr322078915ad.9.1781107725451;
        Wed, 10 Jun 2026 09:08:45 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm252863845ad.22.2026.06.10.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:08:44 -0700 (PDT)
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
Subject: [PATCH net] tipc: fix use-after-free of discoverer in tipc_disc_rcv()
Date: Wed, 10 Jun 2026 23:33:50 +0800
Message-ID: <20260610153349.2546041-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,windriver.com,vger.kernel.org,lists.sourceforge.net,asu.edu,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297754-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 702E766B594

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

Reachable from an unprivileged user namespace: the TIPCv2 genl family is
netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs CONFIG_TIPC
and CONFIG_TIPC_MEDIA_UDP.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/discover.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 3e54d2df5683a..34dbe5ad10e09 100644
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
@@ -382,6 +384,14 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 	return 0;
 }
 
+static void tipc_disc_free_rcu(struct rcu_head *rp)
+{
+	struct tipc_discoverer *d = container_of(rp, struct tipc_discoverer, rcu);
+
+	kfree_skb(d->skb);
+	kfree(d);
+}
+
 /**
  * tipc_disc_delete - destroy object sending periodic link setup requests
  * @d: ptr to link dest structure
@@ -389,8 +399,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
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


