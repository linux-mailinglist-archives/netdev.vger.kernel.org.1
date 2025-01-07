Return-Path: <netdev+bounces-155988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1071A0486B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A76166F7A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57201F37DA;
	Tue,  7 Jan 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/VdiG90"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355B1E47DB
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271528; cv=none; b=q0S+DdypQoJvC3eyYSunOgUopyg4jY7DFprkQ7IiUt/WTRAOMSwGA22M479aKzxrsSfFdFUjWdh1KyWjz6vZl8AYCaxzAzIvxCTVSqFGo2K4icti/E/QdmQ6SDnEICf6CgS6HPNSuWiTlmvs2oK5kmNIgz6VjerIXRC5LBeiZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271528; c=relaxed/simple;
	bh=G+jmvAfKpB8Ie4RA8MBpaCEM29TIaye/RR8nb8RsKu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+wBFalYwpSqRwngpNM2nEERVA2nYf5X3H9e1mlcBASG4HlS6ch5rohdabEta/iCtOhCPPXxmfXFj5ZErK8YqnTZ3E3DaK4ECyLluN/DRKBWc5M5YDwtwgycjqm9JFlEwJIEfBCoh89rf8TM32x6tWb/BVJAB+KAz6pu24p7Mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/VdiG90; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8f0b1023bso177251296d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736271526; x=1736876326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFBuXtAygN/R9fNwpJcUlBWbvTZ+VC1nOIUEZqN6qNI=;
        b=R/VdiG90I8pITV+xEVhxqpRis43kpX281UFKAal5JufzlgA7rQySShfjbWpa0rmCXr
         G/hoOWHc+8MW4ltWgJkV3+vDEnGcy/m7o91kEKjQRKkfLvqYbnD9xpOF7RgFxq6Ga/fX
         9Pj97DlPki9h964WRwBiAnBKdlmBUELOMv8mEZjiRVUqVFZEXDwmKwwmh3moUpT6Seo/
         3z0fThcPLX+aceVm2qe4/9IYkeLc86rBwcf9YeBWFIx8uzOVteEgh3EID4TFXmX2JMzv
         C8rSFcPN7x8bQnnM8RFocDw+Ee1C3sxVtB3zopl2zUJy8DZdlC57/1DooUzTWUGZrDs9
         x3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271526; x=1736876326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFBuXtAygN/R9fNwpJcUlBWbvTZ+VC1nOIUEZqN6qNI=;
        b=InJAnaOwcbIvL/2GyMATHUPnpKjW/JyMavWcbtxsU2CelaV0Irq/JvVi9iJc6ZTp7g
         FmPf8wz5672LjIj2j+MOZ7+QJllUb7FBOoYUVWRRnEWSrLXghWHqSBm+PuhDTkSNNhbM
         ngLIKUTLc6YFAUKz0/U2EsC8I60ASIb0QVHvCS2LundMBwQgcgcFoaPLfe2vvAPJMEsL
         9/9XpTEJOtsmnAwWbWb9cqwwm90pQspdGFhSu+/gcrrBaQJwb7WWCxTTyoZO8mp7biVW
         TK95eLGkiJpxdsh0WdxpC+iV3eK1/QMO0oAzbwII8B0/rw1MMuIpDUU9tMpc7KGmDV/d
         MNgA==
X-Gm-Message-State: AOJu0Yw13HKQyVCJeDdlxNk5ziu87GYZzXYVsh83jGIxzTckEoM8/Fmq
	RCTFV7D6Bx8LCsHlZeMVOfH/BlSFkeuJp8yEqP7MWW3Pp3J40Z3qBm5479wQQE4iYNX0jlTA3jU
	sZX1u3ngj5Q==
X-Google-Smtp-Source: AGHT+IEAfy8i/NJk3i4lUpt/yLMtGzjXcNQ8iQW5av3lKm9/MdrOsDS8wmyYd/mBlpatUBhTAxkvDa0TKBtk2Q==
X-Received: from qvad5.prod.google.com ([2002:a0c:f105:0:b0:6d9:2e33:ce28])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:401c:b0:6d8:a188:369f with SMTP id 6a1803df08f44-6dd2332bf80mr843328396d6.14.1736271525966;
 Tue, 07 Jan 2025 09:38:45 -0800 (PST)
Date: Tue,  7 Jan 2025 17:38:37 +0000
In-Reply-To: <20250107173838.1130187-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107173838.1130187-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107173838.1130187-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net: expedite synchronize_net() for cleanup_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cleanup_net() is the single thread responsible
for netns dismantles, and a potential bottleneck.

Before we can get per-netns RTNL, make sure
all synchronize_net() called from this thread
are using rcu_synchronize_expedited().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/net_namespace.h | 2 ++
 net/core/dev.c              | 2 +-
 net/core/net_namespace.c    | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 5a2a0df8ad91b677b515b392869c6c755be5c868..a3009bdd7efec0a3b665cbf51c159c323458410a 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -565,4 +565,6 @@ void net_ns_init(void);
 static inline void net_ns_init(void) {}
 #endif
 
+extern struct task_struct *cleanup_net_task;
+
 #endif /* __NET_NET_NAMESPACE_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index ef6426aad84dc00740a1716c8fd4cfd48ee17cf3..342ab7d6001da8983db450f50327fc7915b0a8ba 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11423,7 +11423,7 @@ EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (current == cleanup_net_task || rtnl_is_locked())
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b5cd3ae4f04cf28d43f8401a3dafebac4a297123..cb39a12b2f8295c605f08b5589932932150a1644 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -588,6 +588,8 @@ static void unhash_nsid(struct net *net, struct net *last)
 
 static LLIST_HEAD(cleanup_list);
 
+struct task_struct *cleanup_net_task;
+
 static void cleanup_net(struct work_struct *work)
 {
 	const struct pernet_operations *ops;
@@ -596,6 +598,8 @@ static void cleanup_net(struct work_struct *work)
 	LIST_HEAD(net_exit_list);
 	LIST_HEAD(dev_kill_list);
 
+	cleanup_net_task = current;
+
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
 
@@ -670,6 +674,7 @@ static void cleanup_net(struct work_struct *work)
 		put_user_ns(net->user_ns);
 		net_free(net);
 	}
+	cleanup_net_task = NULL;
 }
 
 /**
-- 
2.47.1.613.gc27f4b7a9f-goog


