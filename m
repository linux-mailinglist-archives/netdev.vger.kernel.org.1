Return-Path: <netdev+bounces-135265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDD99D3AE
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CCE281E48
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8711CF5C4;
	Mon, 14 Oct 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dLXBS2w2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77B1CCB5D
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920325; cv=none; b=QLiRfcZBn5qH2Dxh3qNo5CHf4w+lirfhGfARA2tA13VET4rmV04cJu013Mn22YRGBJhOyKafisuyPqKs6fRZeZWssVAuF/xe0UaNZfhIvXCLxH0VA2dEzT+3qJ6U6sPLfW4g2sIQVi+H5vNTV4b2uyRSSctfCETOP47f36fLWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920325; c=relaxed/simple;
	bh=vc7OmTLH/01Z8jEmhW2hCpr6OvlMbxkqSwuRPTgWIpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AH2/thjR6CmTsXypJe3Aaz/I2Jfb2iu1l2orHedZYuYrk9CcA3XSAo2el4DKiVADvifIQphUJ/5/ToqTFH3G8QHTWEkWcPz4MGPOyYbNoy5iOLQTqQzWMRaeCodRpDxbiKqK2qyh3j5F4Mj0JMuKiuWKAEwunr7PJlyDu0OPS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dLXBS2w2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e63c8678so1984254e87.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920320; x=1729525120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItWQLKHEonR5Y2Gfm40nvdSQUxBxC+w2AGE8qbV4gnc=;
        b=dLXBS2w2f1B913FYyVksZ5CxT2FB/P+tRs39uNyDlb1TLRWeUYT/QYawOi8x+N/P+A
         5aQHYM+8mrlX7YEBLYq8XLQBif1j4y89y7ftPmjBbwEOjVsnOyZaA6MccY0LRNw9Sh2G
         tekWzAPCmS56R6wJRU6tmBWaZ5GkEmcQjGoK0K4jRC3RM3vHaKsC98ZF1nxUAZgBHM+d
         Km1YwFDgIDCPIejfnApah6wZQCkqro9Nb0q8WndtlIUTpGV/iq6rl5BRz0263+HpQwin
         ym+efHn4fKC1o991FRtxIXc0i7f5Y1lqe+K5B+K0kDgacoM/HiIcd3HUZFM+zv7Vajvk
         U3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920320; x=1729525120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItWQLKHEonR5Y2Gfm40nvdSQUxBxC+w2AGE8qbV4gnc=;
        b=MjwF3SPlxWibVymv+5IB3SofGgX6CMSivNay5nTBW6eXSRG+EFY4V3U8jZW9A5eLN1
         55dd18k1k8NjN7IYmojtp7ZblHtDv4kHeFJJ6KGOE22y7L1dNIIcWv2JfoVHOObmGafq
         DdJ7q7EXqEY4pM6Gbg2Xp8bWsSiHmMkKZnqg1EmFO7+f1cIGVU/feDW7qEzlqhni/0w+
         0qHKhbCIkHibyT8CX/6VdsBApViNZwjpp4MeDyWY+6RVFlUsAC7NwmwnMSaWJkNqcAhP
         ebAogvByY/FHZl6WanTACilS3vLzQe7RlckvacClgd2ayIaBmX2UtaxXyjkWUVBlYsRZ
         2qIA==
X-Forwarded-Encrypted: i=1; AJvYcCXndN4Lge7f8ZJHUS+OhUlHsAwQ5X80L2bH+xZt8h9IlRSAPWKSCe8EPZgWVE4TUvWowPavebc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwrUcL6XF3TR5u5osz4QMYH6dKKhUm0i0HJBvVx7aMOaqJ2RF
	z6ogkRJStsNVDPtVdTlDAlTjLa4So7SkmtMMr/BwpG8aKzNS6THrrb3ah2ejw3g=
X-Google-Smtp-Source: AGHT+IEttcKfkHe5cPisVJHUtmgl4wcFxdt3iQxg/FUhY3c3ela4IwMd9TUcQCCkSzxomrcD8IPSrQ==
X-Received: by 2002:a05:6512:3083:b0:539:8ade:2d0 with SMTP id 2adb3069b0e04-539e57282c7mr4527098e87.51.1728920320165;
        Mon, 14 Oct 2024 08:38:40 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 9/9] Revert "net: do not leave a dangling sk pointer, when socket creation fails"
Date: Mon, 14 Oct 2024 16:38:08 +0100
Message-Id: <20241014153808.51894-10-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6cd4a78d962bebbaf8beb7d2ead3f34120e3f7b2.

inet/inet6->create() implementations have been fixed to explicitly NULL the
allocated sk object on error.

A warning was put in place to make sure any future changes will not leave
a dangling pointer in pf->create() implementations.

So this code is now redundant.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/core/sock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 083d438d8b6f..a9391cb796a2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3830,9 +3830,6 @@ void sk_common_release(struct sock *sk)
 
 	sk->sk_prot->unhash(sk);
 
-	if (sk->sk_socket)
-		sk->sk_socket->sk = NULL;
-
 	/*
 	 * In this point socket cannot receive new packets, but it is possible
 	 * that some packets are in flight because some CPU runs receiver and
-- 
2.39.5


