Return-Path: <netdev+bounces-212681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B5EB219CA
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054034286EE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B02D5C8A;
	Tue, 12 Aug 2025 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRNA8X8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1F2D5A01
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958621; cv=none; b=QHGSC8hat/nh64+VHt5+u6QrYFa3KhnzOFNQ0QnB4z6R0WGKYzeWTOi3lY7XNmrNfZ0723KuM1aCkXEsuil1DRr9hn2lKhP0WvXOZK+TFrcDedMEgd3i6Z+o42+NdYdnaA1ccFU1ZSfGRCCjxew2u07F3OFSu+tQ9U0IBifABLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958621; c=relaxed/simple;
	bh=mOK7746OIJloNjHvxpBwMtr2b9bMupraTM0QDCp2Mbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tf1uCwnqJA2vMo4mMB+hvgBjhaG1yeHZ87rCsMnG7cDENL4HndIQGTtcDHVegWaJ2qxnvK8Z1Popr6v5AsBr20x2DA72t/x8iiaDRB2TajxKZZaCMwJ9P+BZfD/O3vSSbg4DX+kZKojlIh9AjV8pTrUucQo1keRj9Hxi0TyATto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRNA8X8n; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e917b687974so247972276.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958619; x=1755563419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY/rtGnpNN1+3mbmyVmYANP82JJSr8LwsotstG6izrQ=;
        b=ZRNA8X8n/Fc3pS1BFesB2bcukDSABgBYnIJVqb+L0SlNQb7KflzhOT4Go2pI9P1KP6
         e9b5AVOImvOdtsybNr1vsz5NB8w0+K5Sn2u1ByJ/mWeEJcI9RlIRUkdhCIVx0IIr2e4U
         L9nPTOVH3LVZ7oBbE6c1n9R4a0pxkE4xbcHB7MaaqD3D6eLlamWwABA3ebh1Mdpp6XEs
         xSCqfsavEMtshhfmApC95SsvnxcRXHxWTxnQfAzFd9pmtrRTBf00ntpu3emm5o+vibX+
         ECGc2VgGc285G/C8V+hthPBKhwrJisv685mLycZNLbmKtSDTjmkcqivf/9NjrN3HbxzY
         A+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958619; x=1755563419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY/rtGnpNN1+3mbmyVmYANP82JJSr8LwsotstG6izrQ=;
        b=oVXHbkUKyaL0sLJlUX9VuOkwQIAle/0W5wk0KkQtix6sd8+X3dLDhoJ7Br7FPlHiuM
         ik2Ri4jp4jGA8TSavWYnYqlCrZBKjlnDryPhIbAXgeDV3QtrtcvLYZVtkAKUBJ0TEJkD
         gjp9EwTFXUfdRO9wglqOqnl6KXY7i8jnW0p/vEBHcWpxXd52E8nsX+etppXB4Sv+2hN5
         Tzrc9/PKfavlafSZY7jQwt9mOCJKcT06wcfnB3GzOXSXK2RiBiLNZTsSiKjSoYWZscq0
         LCfuhU3NA7O3UCWR4QwmXZMUiVJV7aYNt7D7eoWNbBTbcxif+mgPlH6fC10e6UpWLoqk
         IFvw==
X-Forwarded-Encrypted: i=1; AJvYcCU9SqMp6c3zH7XpdGJ09PLyxXBwbdRHyeM1c21BBTm9ev4Qwr/OnEPOIgRpyIvaeBcuk3K0qtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4fgxaxZw2uX43hI1sEsxNDYRiIIUvn0NkzaE9/UMNZ96SEsBD
	aKsMNvNzygeUrbXGFwZTsRc7WI/qR+alCPWFCv3z+RIJ1iRFEYglE/jo
X-Gm-Gg: ASbGncvJGyMbWpbkFKdTeVSdiv3M7yrE0cnyBbTTq/XyYtAmaId9sem3a3pwDrbe4Fu
	FF0PM120ab/CPaS3RDF2+kwDsSBE9jqUQRx2I6/x8CY/N8ItQ8A8/v8jVIi0V+L3gauuAnDvejK
	7ocMLIdQ5BKIEdFFvwPIp86dKs3vrF2IkOYa2abqFyesY7YOiOaWExdaMqPtSd6v24UV7lUiiY/
	ihILG1gbijNsZcBWxCyulJ94jkHEpkhGaop4OZBZl67WLvAqoF+9HJ17pV/1qMbpuaYr3kQVWyW
	67AJPPtqsf57rA8/vOA/C0bxO1twhZvnCCnN8pvI8ZXgkniELOCDJyG7AXyRJB7uqSQLasE2No6
	mHyX7IHTmjh4+/Zmcm4A=
X-Google-Smtp-Source: AGHT+IG8ucKSq1BWHhRXyPuQnkT+CP2LlNrm6MkbEbl3VbVoSTosp2Stzy6IYhSKLr8nTJWFbMCRvA==
X-Received: by 2002:a05:690c:650c:b0:71a:3f0:b474 with SMTP id 00721157ae682-71c4298a1e2mr20097137b3.15.1754958618933;
        Mon, 11 Aug 2025 17:30:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a996esm72057947b3.18.2025.08.11.17.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:18 -0700 (PDT)
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
Subject: [PATCH net-next v6 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Mon, 11 Aug 2025 17:29:54 -0700
Message-ID: <20250812003009.2455540-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - check for sk_is_inet() before casting to inet_twsk()
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
index b0eaee5947f8..77808ac30a2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3903,10 +3903,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
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
+		else if (sk_is_inet(sk) && sk->sk_state == TCP_TIME_WAIT)
+			sk_validate = inet_twsk(sk)->tw_validate_xmit_skb;
+	}
+
+	if (sk_validate) {
+		skb = sk_validate(sk, dev, skb);
 	} else if (unlikely(skb_is_decrypted(skb))) {
 		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
 		kfree_skb(skb);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 88b5faa656b4..93c369cdf979 100644
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
2.47.3


