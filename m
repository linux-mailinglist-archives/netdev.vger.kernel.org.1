Return-Path: <netdev+bounces-217354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8E2B3870E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC86688033
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E730E83B;
	Wed, 27 Aug 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMKFA0er"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC8307499
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310032; cv=none; b=CuLtIn7ZSTeG7pA7E7gkaB1zbNubL5c1olNn+mEAsWhOlbuKInGQgeyYblFgXsa9BavtcFUHh080PzVQisUQpi+l9lCJpLO7KKAArVrEf2t+YN1WsPtJXaCMuCfIdlVJ6YDvRcc2CMIbTVv4FVMKkryv+tDWSaiXjWH902/OMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310032; c=relaxed/simple;
	bh=SzmcBu/1uve2VcHdkx1njC38rtOQ2H/T2kw5z+PRSIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX2D/iPfqQjJZzCEb3G7WfwIT6MZENvKijXNKskWx+HSrt05RzdNMDQgtJAnUNZCgoCXU8tF0FRs4/9ckH0HwxvMh1+UXkgvVq/LcXmerf8TqH8qmDvvdIM734yYGOODYYfuQkvlu6NkAtFCM6J2orD0B1UBRsZaPt87MEP9iD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMKFA0er; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96e5a3b3b3so1410676276.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310030; x=1756914830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MX45EBCqlKLMAhR3qda/xVVoLklJP4/fNvzkTiNNMA=;
        b=WMKFA0erxpujPJmq2WGNK7dhgCt3YBwKLgJvdpVRRi3ZZGWbtbyD7dD39qyyugi9hz
         WOgaG/ZM9+O2OotPbJBFNYI+oGFbgRkrSUXkk8FwXHtY/l78erE/XQzbQXk7KRiKFW0B
         H0CdvfCdZiZyI7/sN+HLE3MapoHgoc3pcT94CTrjhcRYWek29L/A9oSNybEY21X5Tp3A
         T3d9Sl5IAMkHz7TE49wvlAaRK9Xnis5PDxFsjEqnYNZZ3mmzM1vENBlfc3RfAesDffuz
         54EzBD6Jf6Xfpud6L5TQTFBBFj6hU5LpM6R9QavhALzG75111WO3RPcAIXIleZ1eIra9
         YT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310030; x=1756914830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MX45EBCqlKLMAhR3qda/xVVoLklJP4/fNvzkTiNNMA=;
        b=w2ae0RA8xw6xj8pSVn2TU4/LifKbpSgyYe72peOes8QWTFaT2kA5uhh6F+t9EKpZkh
         w1n1UdxnAyCQ55VBIpfn9hngDLu+QpTQ22s1eGAvCfgb6vXQyR8PB50TNewH9034IQ9N
         z6anfDVEwTMDZh3EDF374LDCLplAFUPAT5CgUSpawLDeIVVueYZQxp5uEbf7v3LnOIw0
         cI6go2zkx2RVqJMHKIdOmZDHZyY+XoSESE5og41FSsNRMRk0fZ+X0mhGbbjbP+ll+rUY
         17tvv+COCI5+IOkXWF6Yhjl4e3MnlQ+X/flyc3A6n27AkcJQ48I/RGCEu2GE8nOjsiCB
         8R6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU92yvWw2g28clP6H1xR6clCAiUcguFGhz8nztIjLKNnE/gagHB9zOjNDd61akV5YueYZU0CDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUb6OglXNSMVvljEG+/md2yaC+vcuOcYXCgpGggrAZ3x0Bo3u+
	4F7uw5MjC4T1NAGaye3sbzVYCnpwA2F9y+1rpp/JmEkULNyGR49m7hic
X-Gm-Gg: ASbGnctPJmJ9ITRrfvw0IPRnIiQ70LU3oqFgrQiib0rEhV51TV83FBN56PnOmikWBw9
	VKMg755IbAuyoGnVodvO7e2l7CDS+matHqIdzv8x31ssayQrPoxLVVDccV9hJo4AUOOQs17LuLq
	1vJMFuDgU1OowfOgSF8kfm1I8e7Q53wrbZGtbVCOqSSKTbG2g/l/rcMHkoe/4wRdTuwi8P1AnlZ
	m9OBurSI+PV1RSBNOE5oEX4U/yEQtsnruLQhKQkLPM5b+gtB4HZmQgahkQ7RzZ/ty6/kX3oscxz
	+v6EM7Ic6s+wT8ue+YO/a2gPk/p0JivZndDUB9LcKM3/jWF5T1K9PU26jI/yHjYQTl+54XuYNCQ
	Xb7Z/Fy2XJtIWhaAkkRI=
X-Google-Smtp-Source: AGHT+IGeFOGw/NVjjGGYS/mOprLBpSgv/FLUOLPW+FMnAlvCzzn2tGbBPrnDnLBC5D00/dcykO1qiw==
X-Received: by 2002:a05:6902:2b8f:b0:e96:ebb1:be7 with SMTP id 3f1490d57ef6-e96ebb10cb5mr5375417276.33.1756310029522;
        Wed, 27 Aug 2025 08:53:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d661d1basm1883500276.13.2025.08.27.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:49 -0700 (PDT)
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
Subject: [PATCH net-next v9 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Wed, 27 Aug 2025 08:53:24 -0700
Message-ID: <20250827155340.2738246-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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
index 1f83f333b8ac..2ca2912f61f4 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -212,6 +212,9 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
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


