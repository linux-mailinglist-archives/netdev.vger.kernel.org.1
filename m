Return-Path: <netdev+bounces-217910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4602FB3A649
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106897C2EE5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD183277A4;
	Thu, 28 Aug 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkbRGnh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822E326D53
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398604; cv=none; b=K2pnBbF75d7CHJEa1AdN3hIDVvvC+ugLe+nXQyWHqt6TqXnSn+AUjPeR242eNFD6l2W8nLxSU1O2+JPe/aKg3IgqyrvujZQ/RlBWQtIzeKRbEBQriyzR+fjS2iXOLPZ1aWKtr3v46eo5BeQKe/Nxsuw5NLCPKglkQPvEoCd75+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398604; c=relaxed/simple;
	bh=fOvW8Yhl4JsQGFBhxelOSEU6scVi5xsSts1Qy2zSt9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYbE+WqAzysfqQSkAIrmIorU6Vh3OdXNzm3YKkIcKQXuuX7OfhpTXbRhboZ7sOtq9NjrB0WbkzKDNIgfOPOqP0xHZwZ5zTTp6zxAU32fpNW/Qh7dxt+fm/feX7ayJ9MAm69iE8PsdfzwMilAeuENencEPdnlE1q0pcnSF/Ar7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkbRGnh9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e970a7f0e54so673617276.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398601; x=1757003401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu32BKsdKD23jkURPGug4ZrIqoQt1zIEfj96v9JhaFE=;
        b=LkbRGnh9GzOHSBonhHKA4w9W3quMFGveNyKvTlvz40E4ejlFUQ1ysPVWFFrz9jFhT4
         PGQK+q4Jb/SpG3bPsXAce70MCZrU3XcEwcNfjcZuARFpU6DJhnO2tIWLtD9/L+drBCQQ
         xpwkvqytc12/S5/vZmbDrMYmkxerA0af2AqgtsM4PpFRWDuJJZDEdqaohaVtmuUx5MAO
         +ONMt07qhMMVYNigEHU7ovjUACsSW1DXKSTEKhB880iQjKpN+cBW1e/ASdN3odk1U9pL
         Gj/QPWbATnNMRaiGepVDzw8uKUysLay/+B5quMwoo1Vz1OiwkhfFTJ5hEM/jhwydixdo
         z6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398601; x=1757003401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu32BKsdKD23jkURPGug4ZrIqoQt1zIEfj96v9JhaFE=;
        b=HRmip9SfncFUYj1LMHy+ki3dfpBY2EX9wkOVXOXxVxgt0z0HExYeG7fedT4JCmI31J
         FrhEyWrTXfRhPsy4GJIBySz8sTfiTfRPB5rnD06J5xYuoA7nR+NZR020m+XRtcdv03/h
         Smhu01oC4NwtyA3H0Jn9XBN0Pt+veWS4v9KapPYn7ZH0vOfCpUF+94A/2EnGihTNNxcO
         nbe566QGwT4oh46+y5q9wWPHRABvex9/5ygAff1Qc6yUmtwyu/VNNZ/ThKd0StKywrXQ
         YfmeIoS+DpTzcP9HYibCzPRtAOZeoeufygMuqV/xDidmwopkMgkAN8FzaDmQf8RlNB8V
         tnYw==
X-Forwarded-Encrypted: i=1; AJvYcCUhkxkJdiLObJi0Te3JTGROwO7hV+eHZB1CIQlgmd6uypWSVYs9HlgQyWabWoJWHoqh5Iowl2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSf5ad9afYk7fLtwc04uGrr64gw0lzz8O4JX8EZaHGHzwyqUA
	fQvDsVFtmHp4N2ldWuIv/X4s0m+tGO4ukRbeGY/LMsdvqYue2LUMdBem
X-Gm-Gg: ASbGnctGmF0ZWedN0VaECc6+PbrHxfNY3KEvjkRmC5E1NFxDkmKnBW0GTbvNoAMnhHK
	hZJqADTlQKmND6iGW+phlJq3pQAHuCT9MnZEayPOlN7MdQhcX6MVzkDAr4YM+6GubX5Qjv5yCaN
	UBoHg1T8IvSnsWFbARhGA6+o3VeKaYkOkcrv32bPu9WeSlQM2DtNC0pPkUr9ZFDrphaUo8FQIJ4
	pRdLjARyqK1lruor3op/JGzDPfi0jJmwQ/xpp768sO0qVLN7/ROQt2KF46Ah8x5EfKoZtGpg4Q8
	SYviA6GPjrB+G9hUFJyD/8dwwuJ8vpbJTLGKAPHQi/5GLpsyP1mHk3QA5Ty7W0eyWr5UbHz7dCo
	I7xBZsLgR2HDfOaJ2hXe0Ka50P+Q0i438emQbKIyWwQ==
X-Google-Smtp-Source: AGHT+IFAAx8dCZW5sxAtJxsJ8h7rleku9kCiRB/ACgvBZLsXQvP3+irOU1FrmS7YcCG53fvngs7log==
X-Received: by 2002:a05:690c:9a82:b0:712:cc11:af8 with SMTP id 00721157ae682-71fdc3d602emr303845427b3.27.1756398601505;
        Thu, 28 Aug 2025 09:30:01 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5ff8784525dsm18841d50.3.2025.08.28.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:01 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Thu, 28 Aug 2025 09:29:32 -0700
Message-ID: <20250828162953.2707727-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move definition of sk_validate_xmit_skb() from net/core/sock.c to
net/core/dev.c.

This change is in preparation of the next patch, where
sk_validate_xmit_skb() will need to cast sk to a tcp_timewait_sock *,
and access member fields. Including linux/tcp.h from linux/sock.h
creates a circular dependency, and dev.c is the only current call site
of this function.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - patch introduced in v2

 include/net/sock.h | 22 ----------------------
 net/core/dev.c     | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6f47fd10e413..7471718772a0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2966,28 +2966,6 @@ sk_requests_wifi_status(struct sock *sk)
 	return sk && sk_fullsock(sk) && sock_flag(sk, SOCK_WIFI_STATUS);
 }
 
-/* Checks if this SKB belongs to an HW offloaded socket
- * and whether any SW fallbacks are required based on dev.
- * Check decrypted mark in case skb_orphan() cleared socket.
- */
-static inline struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
-						   struct net_device *dev)
-{
-#ifdef CONFIG_SOCK_VALIDATE_XMIT
-	struct sock *sk = skb->sk;
-
-	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
-		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
-	} else if (unlikely(skb_is_decrypted(skb))) {
-		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
-		kfree_skb(skb);
-		skb = NULL;
-	}
-#endif
-
-	return skb;
-}
-
 /* This helper checks if a socket is a LISTEN or NEW_SYN_RECV
  * SYNACK messages can be attached to either ones (depending on SYNCOOKIE)
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 1d1650d9ecff..3be07bc77cca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3907,6 +3907,28 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
+/* Checks if this SKB belongs to an HW offloaded socket
+ * and whether any SW fallbacks are required based on dev.
+ * Check decrypted mark in case skb_orphan() cleared socket.
+ */
+static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sock *sk = skb->sk;
+
+	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
+		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
+	} else if (unlikely(skb_is_decrypted(skb))) {
+		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
+		kfree_skb(skb);
+		skb = NULL;
+	}
+#endif
+
+	return skb;
+}
+
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
-- 
2.47.3


