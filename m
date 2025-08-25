Return-Path: <netdev+bounces-216617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A94B34B53
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9233AFF61
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8428D8E8;
	Mon, 25 Aug 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDK5Xf4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CF288522
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152094; cv=none; b=pfqBLJpQCLdsvfj9PKKdfKcQN5SregcsqnZKMkVv6YqQlZhJOvUm2nCEWpRg+4cx4iygogfjBO8H3L3L9vrevM5jsLFAxxOKnABSnxrE0Y3TdCRi92EOXKYryP3Aj5PU2cv5J61Dw+IEFMVAWb0CQOx2ni2BhA0OZc+zW4Eo9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152094; c=relaxed/simple;
	bh=RR4/VGpXwFJXf/SvgWjzBsorweL+UAzlOCX5yTld4dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJr6rU/gdcu2qrWyA+dSrggEa5Qo3Creg4OQ+nxE4ULrztSx/Ps66oJy980UPSIkYSBpNbMjfbbEFa5vPBFLXgCpGZu6xwvirqBiz+3AQhKDRNRFD+UO2PpjU4zPSbqbqnuxHqaPe/Hrkr4xPVnt7oSVgL0rD413q9c6+oOAgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDK5Xf4N; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71fd1f94ad9so39191497b3.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152084; x=1756756884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJUFHpxIg4+b/x6tKOAg90+0PxH3vL+ciNQ2C7gA4UI=;
        b=hDK5Xf4NLYJT2t46ynXJreH6kj/nrONIFCmkPT9pQaWKciNwnQYuwnI+HiRSeh3/W2
         WnH97zhuNZyPoFqZal7yy+kY5kSJFPGRrO3708xVN9Vp6hs55dXuuzaUE0NyGznXIPxG
         L3q0pB904aZYzq++nCz0zn1TTiq7IjZrtUY7A5ZB3hRf3+9c7o/nsQKSpVoO1yQNlV0c
         T7FYCZJtKdX69IPfzPmwjZDhfqGsqU4Xeg+wY1KXUo/rfHvFCsDjaVH8WCQy/NegiQLR
         WdNCpnOqigYBfop9yIFk1UTr1Ryr+SlEepl1X2kBYFPv5ZwqjI5SCu3OQFwVmJU8z63Z
         GDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152084; x=1756756884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJUFHpxIg4+b/x6tKOAg90+0PxH3vL+ciNQ2C7gA4UI=;
        b=pKFm7ucHo/3hMAnx21csZ7MVAlDxBrrcFsfXQbJp9kLNuD5fEf9UhkZrSeQiHHIkOD
         AFI245TIbjQsM6JyHBVEI5I9R0aYSQAyFMrnvQCF0AB0Xh5yd4hWOYueozOvPoe7BCOp
         QW7QjGGloC5/5NwgPocYBXuumCXjAQpVRn0OrgHS2zjkG/+CsKf0JpxyF8whX2sedodF
         Ojt/OicbEfbkDeuVtOtpORZn9RThyaC4Z27VSnf3W/8GGNPgHLF5q8M02n4L1Of7POCR
         dz8fl0RhKAk6o4fnUgq7hzCYA70KeA1RX6km/LaghDmWN+f2WPgHim5JpYhCBiRI5Z9U
         YLjw==
X-Forwarded-Encrypted: i=1; AJvYcCW32St7Ogzv1/kgqt4ey4S43DipcQCvWYYw3kROg45FAA4A2yB3AL9MmD1nznv5YG26Bn2enNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5576+jdr7mTKdahkfxi2OghtIc2Z8TPMBH7Kjsnd9XDaCdLsn
	pzlge/2uawMlwqPDh5U9NDHs2EMLKvPGG/4x0rOlYmo4kOmJvF3ItTl5
X-Gm-Gg: ASbGncucKydxfILvK15P+LSMw94/8nr8uxNpH6pTGsZ4RWauzYjx8IRLCFZWDEEClFL
	9poObPW4h42tzUxY2HrxgVt6QK8Qxuye8a4fJPK/jCgfMTmCsrWDcZ0EFlkXPGWFehiGCHWpyWz
	dzZPRT5M2KrqMIwpSqkQRlt4BCAxSmznaONvndUglW661wpshROin6iS5u9ybuDOGA8qvF/HBZH
	ctQ3TC11Y8UBSNF48t0wDck776z4IHzrLfKH2SwoKHWeH/zHsScK4liymoDgGNcD0P/BuSxMN7D
	IAb3N5byyY6yp2W7g4yT00mQvd2/pFJg5G3jr5lqiYmRB7+PPOjdeIuHTcsBdZ8FolvXx52dhkf
	FjfxpWFurrEGo1a6XKiF9aHz0tyncrg==
X-Google-Smtp-Source: AGHT+IFlpZusbJqo+nVgdNWL/3suPwyK5ivO4aCl1E9HUnfiEelP22pyWjwD4FLlpBcwzEanN+1Zlw==
X-Received: by 2002:a05:690c:2504:b0:71f:b944:1009 with SMTP id 00721157ae682-71fdc54d3cemr147718547b3.48.1756152083697;
        Mon, 25 Aug 2025 13:01:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7212005f70dsm3324257b3.40.2025.08.25.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:23 -0700 (PDT)
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
Subject: [PATCH net-next v8 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Mon, 25 Aug 2025 13:00:55 -0700
Message-ID: <20250825200112.1750547-8-daniel.zahka@gmail.com>
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
index 979f04da94c9..b33f373451e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3915,10 +3915,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
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


