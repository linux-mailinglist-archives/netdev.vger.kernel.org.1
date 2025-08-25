Return-Path: <netdev+bounces-216629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62178B34B61
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E1E7B69F3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFF30748A;
	Mon, 25 Aug 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVIOMdjp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357128689B
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152101; cv=none; b=DjdlrbKBmDRKiFnMROX4zmEWutEOIXptMxoI0Piu5GkO2IxaCSvzqfozrjmd8LZA+2AR5Y81xLonnHL3EcF+3584L8eZJpBTFPEhtA3Z7CRPMlxO1eMGlWmHsxWIcF2k6pR0+CWBs0Y227018e+bSUGkeuXXk0/+jUcI21D+/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152101; c=relaxed/simple;
	bh=br8M0RG8+iM7wzQGL1KehMxDjNrgdHOY2rKZVdDDTSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5WvaRXdFJmR7iMnXC0gSd45WsVz+gmqE0iZqfBxqt1GLMPv7gAEn7E4zX+hcJv+GnIe/SANchFsp5jXLbqGF8h7YrdC1aeZlEChRhXDhyqdLJIC1CcpZNzO8FwxgjVdqBMkqGBopznI7Ffd7if8C0VQPlxeP0R2hqyAea5wzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVIOMdjp; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e9526271af9so2465644276.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152083; x=1756756883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l43/vTalGiHGtdwGifZlqUuxeM0lKvHihJgy8y1IcZY=;
        b=XVIOMdjpZ8Y/f7YDFMi2tCAD8TL+PXRxPn/4AxtGoq9glpYjtc64//Nwgq7M2INzrW
         EJVe71dZ50c1aCzUet0wKzlj0d+fJrYgyAZS5xexqbsYvdB1wEXe7ri5NhuTmO+TG+jf
         93uNpcDCopPmIBlDTgjnGsASrNTQt4IUcYHWWnbuIOfrcoT7hZQCou5iyqd/gq49w8Do
         wznubIsVFfZu2hXMA8HioYg/5ek8kznszD533iVL051PIaRFU543bpOfGlnfOOzBgfNk
         z30aV7sE8CDCpxFw7svnBM6QBhDv3bh7OnNf88R6tRaVPJongvyXUh/Ig94Vsb3ANaDf
         Wp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152083; x=1756756883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l43/vTalGiHGtdwGifZlqUuxeM0lKvHihJgy8y1IcZY=;
        b=vyo8Cb6M+fd275aAds+pvBqj+oV1LZsRGivp0/N4xa2qK3G3/4LblFtTVQQo5F9VYF
         AD3zLrh5bU0drNBjiPsFCLUYSMN4hGMgS3aXKUQFrgwRFfZ9eiW+ikFiLYoLlw1du2Pr
         /1cNSO8T83YxYXUvoyd6k6gjrxXQvbHeY7uIaMhprav6Hx2IXgUlTGH6mF4S8VEkc5n4
         bCSiAikq4ED4PtJqOkSUFuzufogkCUq0d+XzS57jpeXgxBb8Yn8NkROEPwD1LmymIRde
         PTtvgzWDpSgMlxdWnTZjtazF0VeEgZRUKIoSJY29Gh+wGzlA3ZnYVWIYS83mS5ugdBFK
         Fnrw==
X-Forwarded-Encrypted: i=1; AJvYcCWMX2IJc0muoI/Tst8K6YrfXk5vTSPm3czIT/9icgla+UveZq71OEk+XdNY+qHqGSSzqUiEKuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiL/xPiiJ3cckqNSw1t9zYAm1ibWiHkI4GXU0nhCSONPXb6T4
	FQWFShht/yRTwwH7rniMuHPim/ocyR8P3CTphAeWZUf075rnRvrRIYDO
X-Gm-Gg: ASbGncsN0PnRLWrlvreOgUwiwiubDbwbd+99+Wgwy3cGxyBaqQxk4Qg2o6adITa2z9U
	tmGA6SPZR4zVd5WAgp0f+MZqxl+uLwfzG9erOW2eqElbhhwxlNLYwFTsM8xaEY4QBUQtmDDb8hg
	mzJbIzzlqOCXCxR+JXHOeP7Lxc6XmbVDHk8nzLWUBCK+CrIPpuD+tupJfuKAN2HWTU/tfqO+B7F
	5iuiuqH1qQ3wdTDMp1KkegBDb5LTfvaThie1qAx4LEsHHg/X02EfgxY5+obyLQl8yoTZvU0sxTN
	5WyPJxcfqPeuVix4BQoQAYzcTHHvNHEj9uekP+XTciHDNuiSJJninwlgTXlPUSWGCsCmR/Mwc25
	qD4gnzvdajKpt8hLEEYJo
X-Google-Smtp-Source: AGHT+IH17lkLGoPxwPx4APtfXr+E5EmNJgUuig2YtryA4D2eVc7nqemQ0xV6ruxbovDbjMTWTosClA==
X-Received: by 2002:a05:6902:1505:b0:e95:1902:d7b9 with SMTP id 3f1490d57ef6-e951c2bd743mr14580658276.37.1756152082427;
        Mon, 25 Aug 2025 13:01:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5faec0f2a80sm211879d50.6.2025.08.25.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:21 -0700 (PDT)
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
Subject: [PATCH net-next v8 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Mon, 25 Aug 2025 13:00:54 -0700
Message-ID: <20250825200112.1750547-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825200112.1750547-1-daniel.zahka@gmail.com>
References: <20250825200112.1750547-1-daniel.zahka@gmail.com>
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
index e589eef6ce0f..a997b8af93ad 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2916,28 +2916,6 @@ sk_requests_wifi_status(struct sock *sk)
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
index 93a25d87b86b..979f04da94c9 100644
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


