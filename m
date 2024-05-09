Return-Path: <netdev+bounces-94786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A418C0A8A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B651C210EE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184931494AB;
	Thu,  9 May 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/oM8gK5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1C10E5;
	Thu,  9 May 2024 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715229819; cv=none; b=mr8+sczOCrdXBCqdpWieRUwEB95foMZLTkRxpHQc+Ar0ZzItkSf37AeGmjsGs2WfmdxC1Ek1U9W6xbDpz9A1+Uj1nbajCsGfXT9gFe5Cvmpm4DCgeRRQib0ZjgsB0s/HzCKFBJehs+mIiRGVhAU/5PFXkyPFI9n+UFK+eVdrfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715229819; c=relaxed/simple;
	bh=wC8ROQGMCBiyRkgcqeR1VWvYtgaUZqSR/VXIfZ3SVZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVyASkgKg3CuCCQLdjzS81lErW2Ui49JPMerZ0f2FLHZIVxOqzZ+eoh9SERVWj7x/uNVOVz+sxTmOsAmx4TEmYK5ckGJ8Vrv7dRkvUuF5zZkRaAHvuK7lxDtluJ6vefwxQ2e1CCD4+rq2KZa/pPmwgvsup+8b35pLF2m3YRC2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/oM8gK5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1edf506b216so3070335ad.2;
        Wed, 08 May 2024 21:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715229817; x=1715834617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAVsowuKL8PpxwI/qtET9GJ7xFpj2lJ5HF1nhUYlHaY=;
        b=U/oM8gK5HkUr96YdtUNs6WL4FTDYAFE8HDYcnCDLQzfviPNKKoRra5OdW6uyCxXWQM
         pFstItpRfyI7mg4ERkHEXEZioVPDq4oj/HmvazZOYnZd+M9gzpnf9ReDhvvqYgG1b79P
         M9C0sa//IoZtID69f27ixbq7aCQ+pKlQXJwqineSaeP20rB0ypXW6wB0jCJVnJmxrsaC
         TBJ63lgtBvi0gtL+qtsXC51q7KtOI/VTRfQelAtZ3SWHzG5N2yImILb+UxJfsVKf7cE7
         K4yluMWxLkhb0i7XYcfgPXcmy7mVHkHLi0Bh/BJeRGm3UmJTLhn04ETAyTiNxr/1Ht0G
         0+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715229817; x=1715834617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAVsowuKL8PpxwI/qtET9GJ7xFpj2lJ5HF1nhUYlHaY=;
        b=KtHs+qHgcclHntvGAhbckfsRfGNfeK7maL9CgjP06pmS9XBaH/0Qoj7ZVmvEaUdQyC
         6bO7GfR6l9t6qph4Hf8uI3lzs8M8nS2nQ9a+BsQSBtyeYBNoRfuaTQh6frxcsfLXHYhY
         1VuMZLLYKjgYRfB2mUxXHb+XdbJcw09FfNLFi978DZMlR4HwzZzF0sD7q06jGZAn3Uug
         oGNKhZVH3bgfB/abqCYoEYoaaiKSe+4weHzIy8XD1bNMT6WcBU230iwxfdPVhVMlu/Ix
         aqmUB0DU2eaiDnrvYooSFUAmbutvWHzmCkzieRFpTDz75R913GNteHIWCgWwCyEsY7+W
         jgRA==
X-Forwarded-Encrypted: i=1; AJvYcCWEW/T5T6eSBk3jHdA0cBiaa25xVUAT/iP958atK4vT9yHq9xy3qo7kA1eZZFGl4/zUDa/wPoZyIj8pIR63jKfTt7Sjt9arAQ5MnLYiAaz299i0EByYDoOXH55Nj88TyxmI9Hpg
X-Gm-Message-State: AOJu0Ywi+/zyNezi8/XdOE5OpnkAY8PG17colc5ov27eRC0lWcMWnmGC
	8UnkHCiMKpEIFOREzunJcF83OxAdu3s8chPockDuYeKUflq2gHpP
X-Google-Smtp-Source: AGHT+IHjG84ykjAvUA3ORCTHT7UNqgZtDs11HRYoPIcMLVKsLvcqOsgyCDbW78ExK3X0UkfTlpXPcQ==
X-Received: by 2002:a17:902:edc5:b0:1e4:60d4:916b with SMTP id d9443c01a7336-1eeb0aa49acmr38936125ad.64.1715229816966;
        Wed, 08 May 2024 21:43:36 -0700 (PDT)
Received: from localhost ([117.32.216.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13699dsm4066405ad.239.2024.05.08.21.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 21:43:36 -0700 (PDT)
From: Yuan Fang <yf768672249@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Fang <yf768672249@gmail.com>
Subject: [PATCH 2/2] tcp/ipv6: fix get_tcp6_sock() output error info
Date: Thu,  9 May 2024 12:43:23 +0800
Message-ID: <20240509044323.247606-2-yf768672249@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509044323.247606-1-yf768672249@gmail.com>
References: <20240509044323.247606-1-yf768672249@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the netstat command, the Send-Q is always 0 in TCP_LISTEN.
Modify tx_queue to the value of sk->sk_max_ack_backlog.

Signed-off-by: Yuan Fang <yf768672249@gmail.com>
---
 net/ipv6/tcp_ipv6.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee..07ea1be13151 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2177,7 +2177,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	const struct tcp_sock *tp = tcp_sk(sp);
 	const struct inet_connection_sock *icsk = inet_csk(sp);
 	const struct fastopen_queue *fastopenq = &icsk->icsk_accept_queue.fastopenq;
-	int rx_queue;
+	int rx_queue, tx_queue;
 	int state;
 
 	dest  = &sp->sk_v6_daddr;
@@ -2202,14 +2202,17 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	}
 
 	state = inet_sk_state_load(sp);
-	if (state == TCP_LISTEN)
+	if (state == TCP_LISTEN) {
 		rx_queue = READ_ONCE(sp->sk_ack_backlog);
-	else
+		tx_queue = READ_ONCE(sp->sk_max_ack_backlog);
+	} else {
 		/* Because we don't lock the socket,
 		 * we might find a transient negative value.
 		 */
 		rx_queue = max_t(int, READ_ONCE(tp->rcv_nxt) -
 				      READ_ONCE(tp->copied_seq), 0);
+		tx_queue = READ_ONCE(tp->write_seq) - tp->snd_una;
+	}
 
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
@@ -2220,7 +2223,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 		   dest->s6_addr32[0], dest->s6_addr32[1],
 		   dest->s6_addr32[2], dest->s6_addr32[3], destp,
 		   state,
-		   READ_ONCE(tp->write_seq) - tp->snd_una,
+		   tx_queue,
 		   rx_queue,
 		   timer_active,
 		   jiffies_delta_to_clock_t(timer_expires - jiffies),
-- 
2.45.0


