Return-Path: <netdev+bounces-247634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D139CFCA27
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3539303E416
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA967283FEA;
	Wed,  7 Jan 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tALTSywN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0F2848BB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774743; cv=none; b=eQuaQL1QM6zl3XaCzayuR4cA8VwXoK1JnSTxgigkiuXgC/bwQT0PWvEIicc+5egz3hrhKB7jdUmCZIx+22q/3AmMqlFLt9oBK5qqk8TeDeefYUbjxKtIlAiS+8TAMXGLwK9MlKLzAOSqr+1jPBs4OUaq9UGS22tHSngz0J9c03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774743; c=relaxed/simple;
	bh=sdsfakeORUxQ3dkInLA7NKVEjR9aCC1gm1SFLuR1MZY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uI06XQ2oE80lnDxZUS3BvHXVdNbhAsM8DgxqZnyljPuKqhHIyLf1y5usS+AFkAoyZV4Ov7egC+mJGaRs39KrsYV3uYkIPcBw/AiOYZziF9VCx65zizJh8BrRQqyu9OLIyYH5hq7fmRaLZ0+7fW6JoN9GN+7tJEamrqYmB1DAtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tALTSywN; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8bb6a7fea4dso446471885a.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 00:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767774741; x=1768379541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bu96+BxZQ+quZ91FxBNmeymKxVWWxBN9e2xLqgtObaQ=;
        b=tALTSywNUibc2zwfNzDjWE1yZrurM7rj2T5utb913zDNehCPF99dWoNG2MdRZz3VNh
         YT9LCtfpOkhslx65R03vJB8LpMjYDOr8Bpo1BMQ0zXrVMbcz0o/Ly9BEjKDckhHWcIoY
         yPbVJ2Sa7/Nl7567CwE1hX9b57NcTL529AqERwgiMJ6bihHp+ZE4aB/VyuXGHz7OujNs
         fO6wQ4KTJDhod3WyUIf5D20nQm0yu0wwy0Xn8qqWjOyB/Svy7sBYNoUmMgytxceRBYkB
         EVOhb6nwAYLz7oFY2X/qBNmti65fRYIaidiuyqoHVcMk5SGMrIAO+y1AA17lv96qGC+1
         LHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774741; x=1768379541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bu96+BxZQ+quZ91FxBNmeymKxVWWxBN9e2xLqgtObaQ=;
        b=muVkV+X4QcLVLzMKP2XHyq7vPeAnswBUSIdk6ToiRDGlL4ghGlTeUoLLl0DN/6EDAv
         r1X0QF6a+l/eN31i/+qr56Ei3f6ff9rFdaFywnPScWEQ8JG62svHLO5248LtB/kw5yct
         FC923ccCuqV59vx0gLrJBgKGuuNHD74ub26AyIakyB9kGfesln4Lu5mWnlHaELBCloKj
         vNeyvr9CHY1GggG5aUbGvZaAPl+69Er4yffR+Ku+VPA9a7Fm02EdIsL87zNVDe1F5OAz
         DlqHqu+O1KjNaXAYeOXyPrNwuq4gUW91yxbnwkf1NLOOST51KnZ9z7894iXrNyS7lRGu
         YySw==
X-Forwarded-Encrypted: i=1; AJvYcCXBv7bQjiuOjM7FenMFapZi4mhN1Fa0ayxPCYwmTl62EBftM40Nssp3OIm6l/lzITSwj69Mnzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygkdR1Ie24F5w05sBEVy0x7lSbG3bjSuq/BFTvBvjF8c9tyz3i
	4F0t1ka797GZ6Sxadq0eF1hH1CmzBB+wSDEA6/D7tOVHqt0GjQTe4XJTDVm1CMlEznG7zFoRQ1+
	QoFP3c3Wk4kwRJA==
X-Google-Smtp-Source: AGHT+IH2tfm5FqpgGpzwUP3M6VlD0laqC8I9J6JfvItsXeFNByZ1/xKQAji+ywGoCRLiMS9Rp+lfsKqk1uB+pQ==
X-Received: from qkat28.prod.google.com ([2002:a05:620a:ac1c:b0:8b2:ef50:fcca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a97:b0:8c3:598a:2956 with SMTP id af79cd13be357-8c389384108mr217652685a.33.1767774741252;
 Wed, 07 Jan 2026 00:32:21 -0800 (PST)
Date: Wed,  7 Jan 2026 08:32:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107083219.3219130-1-edumazet@google.com>
Subject: [PATCH v2 net] net: bridge: annotate data-races around fdb->{updated,used}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

fdb->updated and fdb->used are read and written locklessly.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: annotate all problematic fdb->updated and fdb->used reads/writes.
v1: https://lore.kernel.org/netdev/CANn89iL8-e_jphcg49eX=zdWrOeuA-AJDL0qhsTrApA4YnOFEg@mail.gmail.com/T/#mf99b76469697813939abe745f42ace3e201ef6f4

 net/bridge/br_fdb.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

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
-- 
2.52.0.351.gbe84eed79e-goog


