Return-Path: <netdev+bounces-162108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC1A25CD6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881B61887464
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170920E01C;
	Mon,  3 Feb 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3y7GGH63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52920A5DE
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593055; cv=none; b=D44RqUpzHfs0y9lcMgeyU2/cHtk/Rj96KtMbdEFOn2TE/kOmOHtXt41G1w83Hy+JoizF0kPRNNQ/nkDT0woa2va5Wv/FjEo6YrTTjdw2L8cDJc1/0UYp95ZOGganzI5cYiU5LMXf7bndVTIAnG8OtPILlJEsIIeCGeRmL3l+XqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593055; c=relaxed/simple;
	bh=R4Et5ZGNv0Tby5ViLhNa7xiDNoTmcHwKTWxjkKH6iqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CvYZsXGXRc0LyHJxYt5GjU1cc5f+5g9KSPbRlg8PRnhoZwZijZ6LdR6ie91pfCqB6Dg+6WEn0Oo3GozUy065IdiD9Kk2H7g1oTIhVPVEG+siZAFvLmygy8ls7c3OQ26XQQkXGn9Ab46rb994UE3wH3gKw+BxLY5ZRcIcuVlON/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3y7GGH63; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4b63e7ac660so4260196137.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593053; x=1739197853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=avlxdsW5BiWcLQRJNiGfBt63W2Zm8o/S9CZldBDJxA4=;
        b=3y7GGH63ROg1CrOC0r3hju68xMbzv6yfTnrvQnrTqxQlaIT5OVAZh5Bacu6LBmqFJZ
         Rwtmjz/sj9mFvLTwYjlc0OGTiOIXrWAjpAB89ukdXWJBCSxqVebkKc1v+aJTLhQbPbT1
         zhLqDMyl27tVYc93VqjG4rCpPQu+FnAR7AhRgVWTTtIN0VYaU+IcmzUjoeGSD+MXSSWQ
         KjMXsI/rOQzq+rfSgJoiwGcaxz+DZPD6/panrOt1CzI/mecMDRAlq8nhT+cI+S633Ekn
         0TE+vYjKu8h3xJb3oObU4+s81jyhDLgAg+TXtL4r2fr0WyK3cvPByDNoBYg6EkYRKtWU
         6Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593053; x=1739197853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avlxdsW5BiWcLQRJNiGfBt63W2Zm8o/S9CZldBDJxA4=;
        b=USpUW9vq+J/0pJh19+tLfzSjvOtfCsL9Jn4vrcxVVKeYamgwS99rYFrGJdnD+wqHF6
         xLRRCpMq3ShxW+wDHe+VB1sPfUQ1PWdUmlNNuawzU6IkFY+UYDGPs/C1JTtpemsQeNa/
         USP3N9WPsfW0H9a05z9hmpVkJiybpcCSoSj2fCaDOJSz9QjyiuxlwfixFNb3BjdtIzIw
         KxCmD/a/Qq6DHNdr3XxNLgfiMIm/+pZIZTYOP1uOaw7Ows1RKbGUKdu5lZR3uJ9Kd80G
         OISPMe10dYLp2qxHlTZKx4N7hVGNUiUGShA5kRy5k79G02W7RSn1svu3cyDNrkKxcF+i
         7ZGw==
X-Gm-Message-State: AOJu0YxsGmpg/d1Su8xfO81nLlCFOcMYuF1U11aIpZnKB23J1iFj4W/t
	BZCSVbe0LEyWpRvA0OjY2Sp4E/mvpO5+04T0xzP7tPhX+HRi2Q3Ned/HQJ1oKezDyGVs2xd0OPr
	RlBlAOzzeMg==
X-Google-Smtp-Source: AGHT+IH7cTT8tbC11ISbYR1/Wwrx02lrcAzD/GhY68YPCDckxHkAzoab3oJncXRhTo7bQ6+mKZoAfpLiV5Tcpg==
X-Received: from vsbib5.prod.google.com ([2002:a05:6102:2b85:b0:4b2:cc7a:f725])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3f03:b0:4b5:aa91:f29f with SMTP id ada2fe7eead31-4b9b71b00b1mr12246940137.8.1738593049566;
 Mon, 03 Feb 2025 06:30:49 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:31 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-2-edumazet@google.com>
Subject: [PATCH v2 net 01/16] net: add dev_net_rcu() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->nd_net can change, readers should either
use rcu_read_lock() or RTNL.

We currently use a generic helper, dev_net() with
no debugging support. We probably have many hidden bugs.

Add dev_net_rcu() helper for callers using rcu_read_lock()
protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netdevice.h   | 6 ++++++
 include/net/net_namespace.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2a59034a5fa2fb53300657968c2053ab354bb746..046015adf2856f859b9a671e2be4ef674125ef96 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2663,6 +2663,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0f5eb9db0c6264efc1ac83ab577511fd6823f4fe..7ba1402ca7796663bed3373b1a0c6a0249cd1599 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -398,7 +398,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #endif
 }
 
-static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
 	return rcu_dereference(pnet->net);
-- 
2.48.1.362.g079036d154-goog


