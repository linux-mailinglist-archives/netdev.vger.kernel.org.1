Return-Path: <netdev+bounces-212680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE9B219CE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979641908937
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A12D541E;
	Tue, 12 Aug 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDJLwgD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8362D543A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958620; cv=none; b=EdO6jQ/GM9YmQYiJQzaA22j+zzOozi7/bggN6BNK3HkosGvxLgOZm7vhv8KOEImyQnaVY8Hyo4bBWNYIt+5ZRz1CUJucfBACPz4tMUNEm112LcxK6R92tJyJp2Ttufz/ulsFDjEkNiK/fHwxaCkwwD5mzjAMJ9VzKNVLPwccpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958620; c=relaxed/simple;
	bh=eZ3fYN7W6VbxNlm5zx2M8T502wLNQuJSfkdfHwkFJdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2w2IDWFD46MkE/zyP/3oYhBdDB5umP7sUCzZoCPuN64O/pjl/dRdVnund31f/ZPcApU3CkpZ7KEWlduA03h49/HeIlszf0A3hurA59/SI8HfVzK6La3uipYGJrW7FlNkkvF/FY5Aw5RfYdMjbGalDAQFZw+N8HBnFaaU9Z5els=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDJLwgD9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e9173b5fa26so781136276.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958618; x=1755563418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InFCsR3FtXa/ZnbBZVSizU8Y/aQczCxEwnEIR+aNdaY=;
        b=aDJLwgD9ilSSJLCC+mRZ6gcsEIgfloyPWlsDog2HrZSeXX9sUEIHzxhpwVYpl3pJXh
         7BRw7xP/rtNYHbsAltgocLub5ezgf5PgROfygioqowVLEFhEbYLkHZKRcI0FNQjZy1FU
         R2kHwb4Gu3U1ostzyA9pwNNZsNQJHCB3EqoZh72IP9YVqcWOUJ13RUfTSaXutyb/XEXp
         w9xMArYFG2rIQljIrfSd7x1Mh61LMg9qp6dwY5J/T9rGy27PTrFQ2o7KaWepkq5EGf/8
         hb2pAKgqzMPorZkRyXZmiLZEnvW94tCnHbGMI4eTciSliWVDKkniMCQh0tUueFQQkq2+
         T9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958618; x=1755563418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InFCsR3FtXa/ZnbBZVSizU8Y/aQczCxEwnEIR+aNdaY=;
        b=hGR+O4234Y2Upu5Pw1suqsO7p5zkj64frHRlQycXz8xERvIqI4JROFea87XulHVEP5
         szlNaQuqPVAsUn7Fh/2AmsHlOq8fv7SBWdfscSsB4nf2apQ1rd7KuW0NPBV+RjOZ9jta
         n8AIRbzBcB+0djaI/OF+D1n3nNVh/ScFswLsgZZfLmKzrqunrKmI0qF1qMvi8pyTk12t
         e/WM7PYTSvA/Byn9orVyzqoYEG17gf8r5L17QM3nJoiUGeA6HwGbEHJ7ED4fximOinEi
         0c7R29hv37+oipBlG6bE0ah4V7S8TTkC4u0ZJ8xAkgi8RtucqnCBVd0pGK8zuOkNmfzo
         Qdpg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0gJZAqOP5eV032Cx9TkYTK28ZvNXJKIlL5nZHzBQBF6xvt11R2fG3ED9uVxHl5Q/zE/Gceg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYy4+g/uZ5aY2P2h6wxkqZOPp6+ikLWx15wU54bDbeOFd9vfeJ
	4Bf7CkGGkSshkJiIfAW7DGIrQRUya86vEdRTI/DyT3T30RJyymMPnOH1
X-Gm-Gg: ASbGncugEcoB/sJFetxW23slrlOWaXUPgPsQkSIL7vdOvQRhXpzrqr++ikXKyvELmPv
	wgv4bnJMBscm4PREeCuOexickSifF42PQ2iwFNR0J6HnOHOi+J/Th/7Mcpo6X6aQRcRFBh66R7Z
	wZBeIHReCStug8a1IrSTj5mJDHRIuOSX3sVENh7pBYJPH3V8aeP24JfggZI9MMOcxC4if6JSJxo
	A6d8rPUN4MWRRQ7bd13pffNvqC+mIyarFzobuSmAPDzZgPWkgcOn67fPgZtIDWsV8vt6ZH/6vL6
	M9iPEGnbuPoFTaWJkTwAQB1iumS5Lpr8FoUeepFjkT3NJ9ETA9DngLx4EQBrn8MbFz8y04HtAUU
	itGMQiAbsFIdwIcXj/DBS
X-Google-Smtp-Source: AGHT+IE1h105lxc84AfnzRf/kuNNThDny6sfgYlY9AKEopjJdQqi9JZ9qTvl+5A3fWhha/VZREWrxg==
X-Received: by 2002:a05:6902:2b91:b0:e8f:e61b:b48 with SMTP id 3f1490d57ef6-e917a26b769mr2288013276.37.1754958617828;
        Mon, 11 Aug 2025 17:30:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:13::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e90662e236dsm2231669276.5.2025.08.11.17.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:17 -0700 (PDT)
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
Subject: [PATCH net-next v6 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Mon, 11 Aug 2025 17:29:53 -0700
Message-ID: <20250812003009.2455540-7-daniel.zahka@gmail.com>
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
index 94ff9b701051..e028560a6ad2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2870,28 +2870,6 @@ sk_requests_wifi_status(struct sock *sk)
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
index 68dc47d7e700..b0eaee5947f8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3895,6 +3895,28 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
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


