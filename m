Return-Path: <netdev+bounces-283137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMqnDDdZ9GkvAwIAu9opvQ
	(envelope-from <netdev+bounces-283137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:41:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B864AB012
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E9E030080A5
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020036897B;
	Fri,  1 May 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee4Wweie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043636213E
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621298; cv=none; b=j1ZYBOP/ZftWn5agP7oBZXpb6ZnxvH7R5FaINwvd7rBImDL/Vwt1tcUdzvCyVA9+B9qjuTqgbQ2s7GiJxi/F1GE105AJm2dmsmUx0KNcavYGFT5MCZTzzJcoQMOwDAatAAJGgN2L1ChCFWoRtV+xmLU0+hf6jeSXynGwnT3Nh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621298; c=relaxed/simple;
	bh=vYAz+GFVJG00m+N0rNeEFR8ISwPXEVv1wwb2oqmGd0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hETUwgGMxdzSHbf+/416nWzq9RILB/itP1L0h/7XmkJUW0NEsOCY3YvWk/14rvaFi3q2X4mu94Thg8yMRXLr+sYAyVzRKq+B4tapRkcKi7GW6jlrKNZeu1qzUEn7JhXexUh7P0KY4OMpx5jsrhbeSBqoeamlsXf3KupKtq+a4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee4Wweie; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1415514a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777621296; x=1778226096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Y3sVzofFaYqh9OvqIh9FB2/uppgN0RArsWV/LlugY=;
        b=ee4WweieDAwtdiHg6xEhQOrzbzVn7W6kdBZV60PjuecJyDErAjjrqgxFWttFuzPOYh
         JxsmTCfGpGM209sZbRMjVHewUX8F9NTXIy6XWF+gPcwPx9jaM5YD24dz6HTbIPxCOtTx
         gPHJOBRTjnNn9uJhONFsLh2f9B6WB29TPXawKP7LFCenWvRoxlzKRvEZU4L7+JKwlavq
         bRgSKbhCpFR7xy5mlMH/9KVzRpQuEO/ue7r+/QWAiPVxAQNfvo8c2xwg7u3vn1Akd5sH
         I7Vh6kKDJQFJTFZ5+Sjg68qWZ+5EMcjp7P6NvFJOx0Tf/S3rXksq3il9+PG88803Pp8F
         nkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621296; x=1778226096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6Y3sVzofFaYqh9OvqIh9FB2/uppgN0RArsWV/LlugY=;
        b=PxH8sV0uvxOHLHyj2mS9Whz1ycEHMRW8pOEpe1bsXsaU5+BIKRz5RUaV7WKDkbv0//
         42shg95DeG/LQpbTECPo/h5TMD8JT1raqgdGHu9RZE+9WzTwgWs6EgMRW0jUmDSygn0Q
         R7p5OsnEVJUbQIYrCDWySkkvD19WMdcjQepLqllOBraT4GZEJd/oTTNFJMQK3B4gP7OB
         FM9m2NcgiYugnjqKMV5oagQwOc0YL/4IlOA1PAkI+ItCY9VlNvvgTe3lkkkcQRUi2/1O
         NXZAQv5Se3mpNWbrTGfD6GBt3M2Bwck163UAbsFY+PxtzFSdkDpH8Xy6AKq/K7kN6kf0
         ErTQ==
X-Gm-Message-State: AOJu0Yx+z74Rzw8LXgrWZxiwfBb+7SrXNWzPXValLFKVxvq2HuMHs/qr
	gImA5xkg3mnq/gNgiWvSzgjriy8OfLYkMayQHwqhRTteTCzLkSu5A5rk5a7mFw==
X-Gm-Gg: AeBDieub3EzFLkDzK1y1sM5M86sKifODg1PTol5IKq9EDgkXpT02qEDbK091P0fcpj+
	U9T3rMkW4x9c0kJ0TWBIpoYOUGe2uCpSmYmWV+8o/IZ5L99SCR4xYJNOpg+4trdPrwyWr4z5hFz
	7Im6dfOmCvbNXX/yRxy3W7c9MLbOrOwj3HC5TiPx5Kn4IP8viq7kvU3YXEbLJGwzHi2MOiYTcCE
	pONv2w6DXC4oCWIwlMu8OdNAW15ghveEeeUy5TCWJmu82upJhqeThP6ZrCmMnq+aGJl+CBIWrpf
	HRYlCL5XYOfI2vCYH4O7TdfAziseo3la3bQ2+K2IVKFpq3meXZ3jHhi33W4wzOSF+29xhQha7j2
	k75N2IIQM4gYRImfA9WzWkWleWqtt4MKZkppWCpl1uXNeHRpO5k3yvqpbCCjNVIVdAZj3cUUh3C
	4OrUiCZ+uF9nU/avTkgF5FEdd/uDhyhuwzXVfIwrRh5d1+ZILKEbWEj8l/
X-Received: by 2002:a17:90a:fc4f:b0:35e:58d3:3284 with SMTP id 98e67ed59e1d1-364c2fec747mr6090438a91.9.1777621295742;
        Fri, 01 May 2026 00:41:35 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebf12bcesm1502347a91.7.2026.05.01.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:41:35 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Fri,  1 May 2026 15:41:30 +0800
Message-Id: <20260501074130.3532402-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98B864AB012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-283137-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,davemloft.net,ms2.inr.ac.ru,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:mid,ntu.edu.sg:email]

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
scope and shared across netns. mem_check() reads fl_size to decide
whether to deny non-CAP_NET_ADMIN callers; capable() runs against
init_user_ns, so an unprivileged user in any non-init userns can
push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented next
to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
is placed in the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

mem_check() folds an extra FL_MAX_SIZE/8 ceiling into the existing
non-CAP_NET_ADMIN conditional.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
was added; machines and connection counts have grown. The new
per-netns ceiling is then 1024 flowlabels, half of FL_MAX_SIZE/4.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v4 (this submission, addressing v3 review by Willem):
    - rephrased the flowlabel_count placement note: dropped the
      flowlabel_has_excl cacheline argument; replaced with the
      simpler "fills the existing 4-byte hole after ipmr_seq" fact.
    - reordered atomic_dec(&...flowlabel_count) to sit immediately
      after atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge so
      the pairing is visually obvious. Both decs now happen before
      fl_free(fl) since fl_free invalidates fl->fl_net. fl_intern
      was already in this order.
v3: addressed Willem's review on the private security@ thread;
    merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in ip6_fl_gc.
v2: per-netns counter + cap, sent to security@ as a 2-patch series.
v1: fix-shape sketch in original disclosure.

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308..329482373 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	atomic_t		flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..360109cad 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
-					fl_free(fl);
 					atomic_dec(&fl_size);
+					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -195,8 +196,9 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			if (net_eq(fl->fl_net, net) &&
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
-				fl_free(fl);
 				atomic_dec(&fl_size);
+				atomic_dec(&net->ipv6.flowlabel_count);
+				fl_free(fl);
 				continue;
 			}
 			flp = &fl->next;
@@ -245,6 +247,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	atomic_inc(&fl_size);
+	atomic_inc(&net->ipv6.flowlabel_count);
 	spin_unlock_bh(&ip6_fl_lock);
 	rcu_read_unlock();
 	return NULL;
@@ -464,6 +467,7 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	struct net *net = sock_net(sk);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +482,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE/2) ||
+	      room < FL_MAX_SIZE/4 ||
+	      atomic_read(&net->ipv6.flowlabel_count) >= FL_MAX_SIZE/8) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


