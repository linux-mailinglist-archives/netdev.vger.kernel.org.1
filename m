Return-Path: <netdev+bounces-162529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24780A27329
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1217A4BBB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA02153E4;
	Tue,  4 Feb 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFAYmfCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F22211A32
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675448; cv=none; b=OAugoFOkIAc815iyg6r/sap+rPxDGbFbXDFazBJsG5q15OT+zh32mtHahDEyLNraYIJdIoWu3xVTIQLgdoKGYna3XAgb8kwx7rxHFmZgoM4WvCzaiBUOH1rE5+NT/aoX1iqT2702WjCqczaa08sKbpa6YKvbZz9s1ZVU7HuxRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675448; c=relaxed/simple;
	bh=7jVWSrjoPsJTlYuJUx7Ve86JID2VuVx3RWFZAEwPwns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SoTA+yw5uv0MyOSqelJITIpWaxQkTYBIMlEVTrVB9QYY02PXI1K8OeGnLVc3Ch7bEdbjRYryrnbFqFPStea3a6+bgUc4I8yOlLdbayuz94IH6R3KDV5cWvZR+GEKNhJUf+Ea5puvlDzgxzR4EUBBjbnER3gEl4UuI3sObyPEPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFAYmfCj; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e429a54eb4so10862326d6.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675446; x=1739280246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YltdPh2DTLHaaVWal9d771nvesQr3cOmFN62LjAnwTE=;
        b=FFAYmfCj+OLQyr2cWcL3Cl69eANTW8OE8lvVlWT96nq880/RY+kNYVYYC4Zaf+/f8h
         eSpKQG3EliIFkrPGx3ax3gMmswbw76E5XNW0kUgVacWWoLQU43jVb5bMLlO9TG0fj8aY
         L7iAFqQO+rdeZBTlcqve92nbzVrBm26xLHn883BuC78DHazK+vGWmoikZ7BgwW1oBOXI
         E/XiTqT8XXBIkzD1S3iBOg4AeKjhv/MPUz/6eV4T7XwGHFpvZByg58iehizxpKDXJhc8
         tY8Dq9qCkuVzWRhNx4+LGwuj3S1tLEnIF0fM3nQhur+xvD5GrEJf7Sew5UDU1zkPyh3L
         VsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675446; x=1739280246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YltdPh2DTLHaaVWal9d771nvesQr3cOmFN62LjAnwTE=;
        b=AmI5xbBIi56LsrOUpXyBbixKo3/Tv+dVLwYeE4kBN8X2f64K6od8QV6AfDwOqjOERW
         3BB4BcW/IlF72WcXvTITVTModQsuNsdkjgHSKJtWG+dXYaaXq/ynLHs5wR0VL8Jnv5cr
         bzDDsmlKItBtukIjZmChJD1/Ei+cjydz44MEhcFffOzwqnqnhNLgTUsWnQWHV4V4MHrP
         hTfTaltM15WRf+xrhE3uysTgXeLLqbbGWuGgRKr6zyG/oW/SYDFhd1O0JqPJvV+Y63w4
         bdoV3u5mLigGpzUJGdORaNUIxZ1lCnbxIzUmx1OqUo4QuHU2S/XHUjJE6W7+ZlcQl9eQ
         T9BQ==
X-Gm-Message-State: AOJu0YzHqxYjFhYoITUxLFvxw6NqyZ5RZtD+0r837fAYsZR13PGCLO1r
	yLfjTWL373PU89CAZAcmV+g2pzY6W/XXG4XgGYQglqKLQgLAO/bG2wRhZRqfbAxB5yfF4SkZeC5
	YLk/OhyHvkQ==
X-Google-Smtp-Source: AGHT+IGLTFI7lDJpMbmYLQgBsbKDXujQpWgfNYMlO1xLetVSi90cBsUcmI4G6tUgvq8CSlAXQ38puls7777/1w==
X-Received: from qvbmv2.prod.google.com ([2002:a05:6214:3382:b0:6dd:3c5b:62ca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:487:b0:6d4:25c4:e772 with SMTP id 6a1803df08f44-6e243ca765amr475668886d6.36.1738675445663;
 Tue, 04 Feb 2025 05:24:05 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:42 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-2-edumazet@google.com>
Subject: [PATCH v3 net 01/16] net: add dev_net_rcu() helper
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
index 03bb584c62cf8a920b12c673dcc438eb1cc41499..c0a86afb85daa2b50e26a1ca238707a24a1842ad 100644
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


