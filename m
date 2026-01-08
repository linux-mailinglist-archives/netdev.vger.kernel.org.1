Return-Path: <netdev+bounces-248021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9883D02A68
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBEA431D4FFD
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047553B52F6;
	Thu,  8 Jan 2026 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zrc/Ddkf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219D451072
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865097; cv=none; b=r6qPTaGYwdafcqoX2+oV+kBZaFnMGIDTZ3qPFVAHh0DDSeUHX5RqYzp3IOorUieaXrGRfd1CDFICfkk5OatBas0ZD+tg4NKJY73urp1ed1HOsW+WiEyJbpuMgfrDQxzRoe3CpuAQ5A6vGNUNODKbWoHr0xmNHNFrfvalrmfoqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865097; c=relaxed/simple;
	bh=xYoAkbZ+fQsm7/D0zib+nPKAF9nQcA50254Lm+cn9eA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d5uzItpdT1ohyWqrGbmh8CjkBTFFfw6lVEsL98iK8N9gNMWa+t0WlSOxLimAEUnliwp+boFUaGHL7rxBejn31+WTiKe61r/9lL2X/IevGHW+SqcMdPZ7yE2ZEcAqbd4Bm+kzmx1QyYNMQ6isTrapiPIxgecgld3jCry49sPcVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zrc/Ddkf; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b51396f3efso571775185a.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 01:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767865088; x=1768469888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DP33MR8ykYImNY+QQTZqBr/areFVGQgn5Ta0nTtQjLI=;
        b=Zrc/Ddkfnile/V/KFpftfZ1/9YfmZby1keYevEAL1UfCibm3HfL1Heva/2hLfJZLUO
         hMNKJZr64h4r10XGpMQ7fCIHdaP2lERk/KIW/iWQTq4iT8xYbxK/E9jq8exn6VfVMy4E
         DUQ7hCTRivGfKc1kB5YeCWRYBcpgX+jCBIWKOpgF+DUuHzHH7i7o3mBdH4JpkfNLCmiv
         vu0pnrDF0ZcH0lMy4fjND7RobGZcUn6D97S7qU00cf3iVvTeig63R10QUR1nrNa68sYg
         BVukPVzPybNZPAPVmpTYo54K71DBFfgJyfMDyxAD/Dejp1sJ4lw2lzdxGYOZGDE5ysmT
         qHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865088; x=1768469888;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DP33MR8ykYImNY+QQTZqBr/areFVGQgn5Ta0nTtQjLI=;
        b=A1Kikm8UfqAyOcgdR4Q+wXlyijVKQaYgd3GdAhQSN2UP8jOVrclduEhMSAxARsahb+
         D7XcP6LWmeGTAHY/P/gTxv6HbN/HEXt9dQM6BLASeQU2ej1EO/v4cZpgGBehbYoISW+Y
         ssJyyBBiO7nti0OkB7Dwoz76NM6eQqhPf/rcYP07ziT2KRO+X2DNB4UgL/dmm7D1rnIi
         2c/k6hY/5JFiuFXRRyVi1kBckBuxNy4mUmtpMgoLavcR0C/JSUMxriqIxI32meF8VdeH
         mvkeMoE5m7HpnV/I8nkhMGsjk7+nnLuGEgTJ6tvO1glYc1npZfuADw1z0lgQv5pnK2fb
         vQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvbuu9tYIXzvgeJ6cmJMGOY1KWiMFBE61ZhzppyEQXWHW6fx0gMv4erSD93R93UYyiFQtvJTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KSQ0iYdCwEwVR89Qo/eyZ5DYUkVroMoNFGsKOJt1vOo9z1bV
	nm2toOfuoGX8obdskUuk8bSxDUBRCtHBwcSY45iaSQiWMowWN7xFGJ0ogMl/MpYYocrnYwu5vxn
	vYGrUzogrF8kxcQ==
X-Google-Smtp-Source: AGHT+IE6yqWp7GSyUajLZIN5gixNAv+Fje7d2eJSulPCqveMoS6vMQMHGvwtfp+VkuS17RuyzJRyj9VcQlgicg==
X-Received: from qkd26.prod.google.com ([2002:a05:620a:a01a:b0:8c3:8900:223])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4143:b0:8b5:8ba0:b312 with SMTP id af79cd13be357-8c3893dca40mr749343585a.48.1767865088162;
 Thu, 08 Jan 2026 01:38:08 -0800 (PST)
Date: Thu,  8 Jan 2026 09:38:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108093806.834459-1-edumazet@google.com>
Subject: [PATCH v3 net] net: bridge: annotate data-races around fdb->{updated,used}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

fdb->updated and fdb->used are read and written locklessly.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
Reported-by: syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/695e3d74.050a0220.1c677c.035f.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
---
v3: annotate br_handle_frame_finish() as well (Nikolay)
v2: annotate all problematic fdb->updated and fdb->used reads/writes.
    https://lore.kernel.org/netdev/CANn89iLaMpL1Kz=t13b0eGZ+m5dBxUpXx8oPKD1V-VwBAkzbJA@mail.gmail.com/T/#m19446ad4b132da817bda52a98a77a815034ed020
v1: https://lore.kernel.org/netdev/CANn89iL8-e_jphcg49eX=zdWrOeuA-AJDL0qhsTrApA4YnOFEg@mail.gmail.com/T/#mf99b76469697813939abe745f42ace3e201ef6f4

 net/bridge/br_fdb.c   | 28 ++++++++++++++++------------
 net/bridge/br_input.c |  4 ++--
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 58d22e2b85fc3551bd5aec9c20296ddfcecaa040..0501ffcb8a3ddb21a19254915564b4000b6b6911 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -70,7 +70,7 @@ static inline int has_expired(const struct net_bridge *br,
 {
 	return !test_bit(BR_FDB_STATIC, &fdb->flags) &&
 	       !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags) &&
-	       time_before_eq(fdb->updated + hold_time(br), jiffies);
+	       time_before_eq(READ_ONCE(fdb->updated) + hold_time(br), jiffies);
 }
 
 static int fdb_to_nud(const struct net_bridge *br,
@@ -126,9 +126,9 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 	if (nla_put_u32(skb, NDA_FLAGS_EXT, ext_flags))
 		goto nla_put_failure;
 
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
 	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_updated	 = jiffies_to_clock_t(now - READ_ONCE(fdb->updated));
 	ci.ndm_refcnt	 = 0;
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
 		goto nla_put_failure;
@@ -551,7 +551,7 @@ void br_fdb_cleanup(struct work_struct *work)
 	 */
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
-		unsigned long this_timer = f->updated + delay;
+		unsigned long this_timer = READ_ONCE(f->updated) + delay;
 
 		if (test_bit(BR_FDB_STATIC, &f->flags) ||
 		    test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags)) {
@@ -924,6 +924,7 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 {
 	struct net_bridge_fdb_entry *f;
 	struct __fdb_entry *fe = buf;
+	unsigned long delta;
 	int num = 0;
 
 	memset(buf, 0, maxnum*sizeof(struct __fdb_entry));
@@ -953,8 +954,11 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		fe->port_hi = f->dst->port_no >> 8;
 
 		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
-		if (!test_bit(BR_FDB_STATIC, &f->flags))
-			fe->ageing_timer_value = jiffies_delta_to_clock_t(jiffies - f->updated);
+		if (!test_bit(BR_FDB_STATIC, &f->flags)) {
+			delta = jiffies - READ_ONCE(f->updated);
+			fe->ageing_timer_value =
+				jiffies_delta_to_clock_t(delta);
+		}
 		++fe;
 		++num;
 	}
@@ -1002,8 +1006,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			unsigned long now = jiffies;
 			bool fdb_modified = false;
 
-			if (now != fdb->updated) {
-				fdb->updated = now;
+			if (now != READ_ONCE(fdb->updated)) {
+				WRITE_ONCE(fdb->updated, now);
 				fdb_modified = __fdb_mark_active(fdb);
 			}
 
@@ -1242,10 +1246,10 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 	if (fdb_handle_notify(fdb, notify))
 		modified = true;
 
-	fdb->used = jiffies;
+	WRITE_ONCE(fdb->used, jiffies);
 	if (modified) {
 		if (refresh)
-			fdb->updated = jiffies;
+			WRITE_ONCE(fdb->updated, jiffies);
 		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 	}
 
@@ -1556,7 +1560,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			goto err_unlock;
 		}
 
-		fdb->updated = jiffies;
+		WRITE_ONCE(fdb->updated, jiffies);
 
 		if (READ_ONCE(fdb->dst) != p) {
 			WRITE_ONCE(fdb->dst, p);
@@ -1565,7 +1569,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
-			fdb->used = jiffies;
+			WRITE_ONCE(fdb->used, jiffies);
 		} else {
 			modified = true;
 		}
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 777fa869c1a14453bd1827d545527607fbf95a60..e355a15bf5ab13e603ceed2b99e56ddeffdecbb2 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -221,8 +221,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		if (test_bit(BR_FDB_LOCAL, &dst->flags))
 			return br_pass_frame_up(skb, false);
 
-		if (now != dst->used)
-			dst->used = now;
+		if (now != READ_ONCE(dst->used))
+			WRITE_ONCE(dst->used, now);
 		br_forward(dst->dst, skb, local_rcv, false);
 	} else {
 		if (!mcast_hit)
-- 
2.52.0.351.gbe84eed79e-goog


