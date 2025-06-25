Return-Path: <netdev+bounces-201171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA730AE8539
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A129A189F910
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331D26657D;
	Wed, 25 Jun 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1FJYJ8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B84265292
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859542; cv=none; b=Jq5YNxMHywOpluVJlRprVu6KHIB4iOAesx0gDBAPiD5KrZNyTFRwgjOsObdgz1aG1mk4t/42PBYPIBpHTFn7FW4n+6sEv3RLRi/HzZF0MWItHO9WH+jO8ZnAPg4EPPqNLEhV3Cit4QYmoCsQU4olvBnR5ZvyJQcPEPwUa+58Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859542; c=relaxed/simple;
	bh=ObGwlkEleQsR7vQ6MgkMlm/1B0q3UwMYxPcgn0Uojg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQMR2scrS7hea0NTUu9f1Y16JKm1iwRAPyhrpf9Ip9BoHBLStFB+FxmZtUUx/q1bLeujYs4kZUhunbmvLOscDIrzywqRAXmbEF8uVj53gBXJD71qT1s6OvGocY7F32ZByxQLHI6o5BE39d5+dZiS9LCSgmnBZAYmhq/M0X38Jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1FJYJ8k; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8275f110c6so5013615276.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859540; x=1751464340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSusz0rB9k9FSPVC8BssiRy9vJJspTjLsmorzMeUypI=;
        b=J1FJYJ8kbc+Ls41wHnZ/bhY2YnaJf3YAc8jOybSTAjxZAD0pFMmh9Q2O2yGgJGDKHk
         axCKJqbeg7+lkp5PCXWbwfwpYVwfIQD/C1KFV6eYI3MROadpE3cTCYcDCRiZwnB75G6d
         IKIfDWDzqbmAque37sDvV4qgxpYDsGxXYBdLtjeiCsnQdJR+JLo4quh8YHFdvF4scwaP
         KlOUjfECS1VOmRnAD4obFHQwV4HCZ6lQ3x+x1qyT8msv9jDcyiJfGWBOfeL3VNFPZ/1M
         C/pR8acMy7lyncIK4N9WysDzz6H5Vz5f+SGhAsgaTNdlvvCRkRjnRRqNHU5d6fj+q6LP
         QMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859540; x=1751464340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSusz0rB9k9FSPVC8BssiRy9vJJspTjLsmorzMeUypI=;
        b=aIAhvlhZRHqVU3/gtCumHjGWIFuw2i5x9Ph/gtIro32UOD4WoxZHCE+UNluMiM9ExH
         mfQj6AZ2vupRskg7zUTI7K22dUyfBJQKQXquoeWKC34f0j2M7ubmM7ydL8/mlNRTyYbU
         9b7LNIzUFZ7YEFx6eXpz5+gIy4PK5OQg7BB6/XdjIaUq/NGYm7bEAUN1n/qMJOTB1R9V
         obR5rwSmCpMQ4Pd3wqUYC9UJathgK9MIDlPFhL7yDhSCg3/tdqtzDcPTW5rKpj+mlRoE
         XAEngK63Y74SCGNq7gv9xKPdAl2jQG7FgVXycMNjQWdgA4tgULf1qmt1kdMuTnc6nEvj
         r7VA==
X-Forwarded-Encrypted: i=1; AJvYcCWJZQz/YM4zzfiO+keCquQc+5DBnmtxZyQrfBAfL9EQuF5ALpeWsibxfb6xvLV7FZKQEbEPv90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oR8JXOS5NjReLJQ4vBwihGeZybPboGJVBrC8bEszt5X8InBM
	XdFBQS9A0D9xJMXgy0Nw47jup2a74ABMgys3vi8kHllw0t6wZyJznSX2
X-Gm-Gg: ASbGnctjLZpKrVnX52LbWbvWC1VnxDlJiq1fPMSUxSjbWjnauud9WFBc7MJgg9CwqsB
	YHM8GW6wWfX2/tub9UWjoSG5UaNfEmbiN4B8h5vskT//ZkbfPvaSaA8q6NePpF1HERt/9hMHHN5
	lisZ4QtnjeaQO4Yh+2/T/SDA5CSLtkpU2Ec+V+A0wb7a1dGi4Lj/iXWbdKuUBfLbAfws++h/Gz9
	3truoQViiSJ6ExB5cE6pip/QP81fHnJDeZXBMpa6zjewAiLxh0lBOQjarV/xD/ZgryMkRr474yZ
	scjBG4vCUV5QZuwU9znBbm4U0ZQZkdn9Xe1xYa2K3pJOxRcvhE3HQvxeNRw=
X-Google-Smtp-Source: AGHT+IFJuBCC/Kmq03Bz9n51ViVSOYW4/dBYBEbMGy1D3WDbKb75BUMI0hwh3rKCC5YoDXNjIlWOOg==
X-Received: by 2002:a05:6902:a81:b0:e82:99:efaf with SMTP id 3f1490d57ef6-e86019264a3mr3957263276.31.1750859539811;
        Wed, 25 Jun 2025 06:52:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab9809sm3691397276.1.2025.06.25.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:19 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 07/17] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 25 Jun 2025 06:51:57 -0700
Message-ID: <20250625135210.2975231-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a callback to validate skb's originating from tcp timewait
socks before passing to the device layer. Full socks have a
sk_validate_xmit_skb member for checking that a device is capable of
performing offloads required for transmitting an skb. With psp, tcp
timewait socks will inherit the crypto state from their corresponding
full socks. Any ACKs or RSTs that originate from a tcp timewait sock
carrying psp state should be psp encapsulated.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - patch introduced in v2

 include/net/inet_timewait_sock.h |  5 +++++
 net/core/dev.c                   | 14 ++++++++++++--
 net/ipv4/inet_timewait_sock.c    |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index c1295246216c..3a31c74c9e15 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -84,6 +84,11 @@ struct inet_timewait_sock {
 #if IS_ENABLED(CONFIG_INET_PSP)
 	struct psp_assoc __rcu	  *psp_assoc;
 #endif
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff*		(*tw_validate_xmit_skb)(struct sock *sk,
+							struct net_device *dev,
+							struct sk_buff *skb);
+#endif
 };
 #define tw_tclass tw_tos
 
diff --git a/net/core/dev.c b/net/core/dev.c
index b825b3f5b7db..bf013436a57b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3904,10 +3904,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 					    struct net_device *dev)
 {
 #ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff *(*sk_validate)(struct sock *sk, struct net_device *dev,
+				       struct sk_buff *skb);
 	struct sock *sk = skb->sk;
 
-	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
-		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
+	sk_validate = NULL;
+	if (sk) {
+		if (sk_fullsock(sk))
+			sk_validate = sk->sk_validate_xmit_skb;
+		else if (sk->sk_state == TCP_TIME_WAIT)
+			sk_validate = inet_twsk(sk)->tw_validate_xmit_skb;
+	}
+
+	if (sk_validate) {
+		skb = sk_validate(sk, dev, skb);
 	} else if (unlikely(skb_is_decrypted(skb))) {
 		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
 		kfree_skb(skb);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index dfde7895d8f2..859c03e07466 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -210,6 +210,9 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
 		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+		tw->tw_validate_xmit_skb = NULL;
+#endif
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
-- 
2.47.1


