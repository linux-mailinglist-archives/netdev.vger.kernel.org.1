Return-Path: <netdev+bounces-290572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFjSBKVDD2r/IQYAu9opvQ
	(envelope-from <netdev+bounces-290572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DAE5AA67F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C99F30058CF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5243DC875;
	Thu, 21 May 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6nnyk/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA44431AF07
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385242; cv=none; b=DXDKgp/L0tiJxtrwEaZmLscO/sNLG47ZIKphUxK1nShenq4D5JmEiBfUVT6i8deM6vw+MIvh39Gxno98m/zP/Tc4GvYMzA55hh3S6S6bqU81H552981Xa1jUAxYsQ7NEChhHf3sWBgrcaoB6OfK1Tu1/m2Ri6XGHxVAWIb1nmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385242; c=relaxed/simple;
	bh=bnXAuVCevJzXO9kmWNuyie9RFzd0uCKv7el8LtWvceI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uLwbjLrAYV5gWa17iIuJ619Sdsc8wZFA/Emv1l6H0PnyzqvWXR6aaqv3GSH8dstEIXm/TsM0dCk6iQnenatH1+GmiFzNhbaN36ICv+c0+iat3nUZDwfTyR30d1ghnoU8D68XnlMJfYQzrF6v8eN0mxeGBmO2E5MIVo9wGnYUFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6nnyk/U; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-514d2b22e7fso93571011cf.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779385240; x=1779990040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QF4eC0OVhWabsFpFC1yoYB8wlDjhOnK/ut8v/uL2cUY=;
        b=W6nnyk/U130qCdkXkz1+FCNzxvojATWoYao6ymy+N+WrnsKFotoD7b0bsIepoQGRdN
         snti20V/lcQcUjZ7j+ZFZsBy9HiSoj9FFqgbhFPp440w1l9T3bv4U5gvwGYMI5duXW8m
         Gg7xuM73JECW+71KQYWVfDkp0hytyNwhqdObiOU4HPADhghqgCSZeZv+PvunnLUwGFxI
         anNDqEji+DsZLNqV4scJGcojbyJxy3wAADcxswRrCGNDGweg1FrKi8aLHQ6a3l8ft8Z1
         Hc2U9Q4t1J12b4mScE3Hn5IB7ckvGjAazonNS+w5bCCNh5M58FkO3euDzOUs4R2b/Mfn
         QExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385240; x=1779990040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QF4eC0OVhWabsFpFC1yoYB8wlDjhOnK/ut8v/uL2cUY=;
        b=H970eeD7MpncWEGDdATGj/69ut/faT5MO0xpvEwNde+mreojISosS5BMzsl06g4PDC
         ToTd/pw8/SzbSTsX6dfgbLx6aTf3c2ORnB59N/rGUwN9ZYO6plz4NMtBOW3qbm0st+po
         dLQyf/+GohqTihR2twHzLUV79FDPlBERdokxdtStIQNNXteJ4w/kpBBVYKLEVq83TubB
         doVGfvsmwE585iiS9rPy152nmSYuR/0w9GXm2CqbFtPDbIFoBByMs0VgmQ9Oii+aeqfB
         QYaDi/kHXXk4wz14sw2F+r+EjuQ16zN1i9GARHUX+T1cRd0h84MXLo1Ip8/jXcoXHHvM
         goKw==
X-Forwarded-Encrypted: i=1; AFNElJ8aZNvUwEfKCQAtMgSlMCHx9ls37kY4JVQc1RKSCyOKMjyQanDn9a/y8QzfxK51uTGTxYWt1vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXQKbjqZvobxBxbv2u8gmvSu/mNlvTyKtm4axe7O2PWbSJpnD
	Dyjy/z4HALFZ0IEnmhQAKi6HnNacBmCM/X47eZwuw2xymKp8ij6Ah5Lmw/UK0QSGqCF7mM9DPTt
	1VcuzHFesj27kVw==
X-Received: from qtlp22.prod.google.com ([2002:ac8:4096:0:b0:50f:23ec:d2dc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4207:b0:50f:bb77:a085 with SMTP id d75a77b69052e-516d4285c5dmr5900321cf.12.1779385239478;
 Thu, 21 May 2026 10:40:39 -0700 (PDT)
Date: Thu, 21 May 2026 17:40:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521174038.204481-1-edumazet@google.com>
Subject: [PATCH net-next] rtnetlink: do not use RTNL in rtnl_af_register() and rtnl_af_unregister()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 93DAE5AA67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_af_lookup() does not rely on RTNL anymoe, remove the stale
ASSERT_RTNL().

Add a private spinlock (rtnl_af_ops_lock) to protect rtnl_af_ops
list instead of using RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d64600aa8adfe9ce7a0c45677ae36db73ee3d886..d1edb1aeb0ce8d9c42c788f632cd2a654d7f9c7c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -750,13 +750,12 @@ static size_t rtnl_link_get_size(const struct net_device *dev)
 }
 
 static LIST_HEAD(rtnl_af_ops);
+static DEFINE_SPINLOCK(rtnl_af_ops_lock);
 
 static struct rtnl_af_ops *rtnl_af_lookup(const int family, int *srcu_index)
 {
 	struct rtnl_af_ops *ops;
 
-	ASSERT_RTNL();
-
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(ops, &rtnl_af_ops, list) {
@@ -791,9 +790,9 @@ int rtnl_af_register(struct rtnl_af_ops *ops)
 	if (err)
 		return err;
 
-	rtnl_lock();
+	spin_lock(&rtnl_af_ops_lock);
 	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
-	rtnl_unlock();
+	spin_unlock(&rtnl_af_ops_lock);
 
 	return 0;
 }
@@ -805,9 +804,9 @@ EXPORT_SYMBOL_GPL(rtnl_af_register);
  */
 void rtnl_af_unregister(struct rtnl_af_ops *ops)
 {
-	rtnl_lock();
+	spin_lock(&rtnl_af_ops_lock);
 	list_del_rcu(&ops->list);
-	rtnl_unlock();
+	spin_unlock(&rtnl_af_ops_lock);
 
 	synchronize_rcu();
 	synchronize_srcu(&ops->srcu);
-- 
2.54.0.746.g67dd491aae-goog


