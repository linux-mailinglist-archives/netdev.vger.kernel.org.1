Return-Path: <netdev+bounces-132863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620B993964
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CBC1C22853
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D677418C929;
	Mon,  7 Oct 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fwi1TuZE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070BD1DED73
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336958; cv=none; b=al3+tZ3H0HZbRYpSlJ1UjFc5pVHNQ96fEWOaFDroVT+3RW8ld0Mo6BuFdKOx9C9LqgU/L6MB2TYApLnbJkPeaGPX+SUKmzhOCNMET5kSTOybGvVhQPRcXlE/FsnTsFeizPenD/MEUiw0WTZRrnsI7YW1Kv91NAw378r2Fdu+ktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336958; c=relaxed/simple;
	bh=B2jIOs9L3gzL5PsTv6zAjfQ7uhJ1V7bXBI/aVWUwbYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoRXPZlLfUJLjiTrC82jRVzAn903jd7mTg0nO3XVT/izjjcuacHwPCbpy6eF3OEnU9I5Duh0ykoMrNNr4xR/fMetBECXUiyfh8JAdo5A0uLT675by+SyuIdCS8QHsCwkiCZLUzAT7KNnSFpefcfz98sCcNa1G1VKpw8g6m1zhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fwi1TuZE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d1eda8c7cso1089203f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336955; x=1728941755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc//y1BjgJvxxX3rGB4aDZ3xX09SUgENBX50qA84hL0=;
        b=fwi1TuZE6U+cV626UHx2sfHQOtvBK4ewje5Ti3AQ+2l1Aez2OmKyZ6zr5pIdE2z6v9
         /XZjYBsm/b/6WmY3v8aFONI+5YPww37GCXD6u8W/NN9oEJgEB7Jz5EiqXw6Gw9oBuiU0
         AlqwxE5oYzKjXOiKQFya+KrrOIfXcOKO9fMt8GBWw+fhgNMnwXn5RwDuvSlM0HDZGxGz
         HRE40KxC7KmVwbRUIoWtoh0kKW5s/pmSozzLAknn/9x0x12Jq4HX9oHB/ts2R2OGPdL2
         e7sGq8iO92k3xIxqiXHEmcqjMZfAraBxkD982nldy2zJxZyrprysYOuMpnQ4zuAUuLoE
         6BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336955; x=1728941755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc//y1BjgJvxxX3rGB4aDZ3xX09SUgENBX50qA84hL0=;
        b=txFQ4UcVBiO4Qze1cI+ZzlEWn15dj5hl4hO10C+77AORsHE4/p2N1Z7h5gTnTNnh1j
         2cwI7UfQT2xnD+7XcH9dzoGPUcCZrTFpp7L225WJUkv/JbVs9Fq8QblQtr7bCFVNs6tY
         erMsKHZaWRITElxEbIElP4SH9GEvUpSSwVOkKcYeSKodCJ4zSpQvomrXNT7UgdxGX33w
         LHGWfh42/U9MOPm/r7dq5S8lvmAZzKQvSZZ+O4qlygwgp3EQ6mqk8qGIiMq5pi8mKLYN
         0mfNBgb5RCXTG1Bgi+npp+9leZkEkdBtJP5n712BvrGYzzhO/HS5lNFk+u+5cZl+LPU9
         ZmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSqapWilkGCZTqM34yUtbis+Xm8ryloj4/Ug3fseA//p0NrxuLcbZKcTHWh22AjVubkoWhhTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hnCwK2K2Y8jbpqnLaFWqEywvYsZ1WxKmUJuyeLmtGMtgmONu
	Z7US5OHbSN/RR/b66WnvbMkICUVyazip9TwphhYOvaodC9dM4e7ZIHxt70tXkh8=
X-Google-Smtp-Source: AGHT+IFlr52AJGKwlZWzuyM1U26fNN+5lWsZfsZ3/C7NwJE8QNsJ8h0z9W2aZlJldJJxtKVirxozSQ==
X-Received: by 2002:adf:ec03:0:b0:374:c11c:c5c3 with SMTP id ffacd0b85a97d-37d0e7d3e2amr7529022f8f.41.1728336955301;
        Mon, 07 Oct 2024 14:35:55 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:53 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2 8/8] inet6: do not leave a dangling sk pointer in inet6_create()
Date: Mon,  7 Oct 2024 22:35:02 +0100
Message-Id: <20241007213502.28183-9-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_init_data() attaches the allocated sk pointer to the provided sock
object. If inet6_create() fails later, the sk object is released, but the
sock object retains the dangling sk pointer, which may cause use-after-free
later.

Clear the sock sk pointer on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ipv6/af_inet6.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ba69b86f1c7d..f60ec8b0f8ea 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -252,31 +252,29 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		 */
 		inet->inet_sport = htons(inet->inet_num);
 		err = sk->sk_prot->hash(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 	if (sk->sk_prot->init) {
 		err = sk->sk_prot->init(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (!kern) {
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 out:
 	return err;
 out_rcu_unlock:
 	rcu_read_unlock();
 	goto out;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
-- 
2.39.5


