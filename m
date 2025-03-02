Return-Path: <netdev+bounces-171009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D78A4B19C
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 13:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB93C16E0EC
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA41E4929;
	Sun,  2 Mar 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxeHDecU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A531E3DE5
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919363; cv=none; b=Px58zkxNc8r4T7UqgaCTokduq7f0Xd0QQn51Q6n/9wHyPUQ0Z4uYwt4/MGcjf5BI12qLxzvU+tphsE0T3RgWA30+d5dcJOORQHjNAVVtPkVZrwzvWXL9Qom1BdIcSQWcUtUFY3LtT9SdybOT/bFLt9bwl46qEVTCKGKDIpLHEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919363; c=relaxed/simple;
	bh=p93rH5PdMjPPgGz6GV5q/VnBL2KH+Cct81/A/oCWYfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j9T4Ps/Q8FJgBSOhnQnvltt5JQpEgdDIQFpuDyZJUAlRbxDWVzJMd1659pZgiPnYXZawns/2gsEraQpd39seqS/cfm5puyYxFqJ5Rzy14ILwwthzhFRvnfhS9ckMlK3FG5iMuQRcUVQ+wWZAJd4rYunjyNl6qTaYND6gpM/RuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxeHDecU; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e8993deec9so89313716d6.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740919361; x=1741524161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s0JdeHQMm3xtUgmOsCtNWrZ/gZJbYB8dsrL51tkmKLQ=;
        b=kxeHDecUZGZyMUi7JW/YyLR5Ur65t9YAS7MVZb+JD+sRp3Er7SatSxWpgyJyR61uK6
         Xxl36Iln6v8+e4aSZeZDklrOSPxFvtOq6noT/iclQ73H5vHzfbOn4vqDL8ycaWdhPb+V
         HnAHp5EHkWRHmrDHvGe2YsqodxqNrD9HZ5FR+12GL8QTESEAi0akkfuBVVyeOyTE+Ys/
         lxvhIm8FKDb7tUUQnp5M+P6U/F92WM7pARZW9wMEBH1zroTJUhZqn8KhhwWunEtJvhtz
         elXl73lm94rJ+pdPBQGMDKs5aH+CZ+ITp3efPN04C0sjDUPY8V7iXXWBxX7by1QZVj0u
         FQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740919361; x=1741524161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0JdeHQMm3xtUgmOsCtNWrZ/gZJbYB8dsrL51tkmKLQ=;
        b=bJgByXnMyJCPszMEFx7KNy/W0ydjY+vJlSHxYRTxQlAVKsfiwsncrGt5/3KE5hAhYK
         JNgTMp54CrbUuS8v+qFKaYq6wAtoC7oMWgtpUxcP5bPPQ1fz05AOCICU6XomcGsJb/xX
         5FPcX+aRU9SCUIPTgpiCMqZon2eQL0DEj+gonsmxvhvOQU+yozQwz7GmNGpgqMvAiqWo
         9VKZj7ls7SP8KQ/tx0PGMPxGrMupgnEHtfX0nS9qVAVdSmdno2d/+5UHBaekmJuNCZln
         ZNmWUoG5tNJsM9JI3HoJSjUuhYvNdeVZSY8WCobeF7LIZqF6js2+Uwkk1nSfSsvwsBac
         HMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB0F/1PRKRaiXtFv2IDgt71Wv42nPZb1yjjibjAfsPSBulckgFjcYQLQlx9CIYqfOtJ/CP8tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVNloDSh1zLKEqcGgPKZ6EAKaC+6amRdg+cSURdxY9k1EMRz/
	+nn4vkY2WsCnBJi0He9hLrMTZ7sKO4t+wyt+Hg5XXYh3npFcY/Pz7Pl+D2NzNRuLOtpgJy84xfR
	hzz3fDWGluw==
X-Google-Smtp-Source: AGHT+IFUFVcnKbe1r9qAGX9bBRN0X4yUWdEs+MT8sUa8UNadSW4x4KoYCkOYHHG6ALf39iIwuhb6WIj6VHAkIw==
X-Received: from qtbfy11.prod.google.com ([2002:a05:622a:5a0b:b0:471:a4e2:f6f2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:178d:b0:472:614:19a0 with SMTP id d75a77b69052e-474bc0edbf0mr137297261cf.35.1740919361415;
 Sun, 02 Mar 2025 04:42:41 -0800 (PST)
Date: Sun,  2 Mar 2025 12:42:35 +0000
In-Reply-To: <20250302124237.3913746-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250302124237.3913746-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] tcp: optimize inet_use_bhash2_on_bind()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no reason to call ipv6_addr_type().

Instead, use highly optimized ipv6_addr_any() and ipv6_addr_v4mapped().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index bf9ce0c196575910b4b03fca13001979d4326297..b4e514da22b64f02cbd9f6c10698db359055e0cc 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -157,12 +157,10 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6) {
-		int addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
-
-		if (addr_type == IPV6_ADDR_ANY)
+		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 			return false;
 
-		if (addr_type != IPV6_ADDR_MAPPED)
+		if (!ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
 			return true;
 	}
 #endif
-- 
2.48.1.711.g2feabab25a-goog


