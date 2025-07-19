Return-Path: <netdev+bounces-208378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9FB0B2AB
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75949188A2B4
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B51F289813;
	Sat, 19 Jul 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ9dCUZy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E7224B03;
	Sat, 19 Jul 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752965093; cv=none; b=hHdY+dxd3y0k/EGoFrU/0uB25HCZNKFyttKDs45GdxM2xzY8vu7YwkXEC8hfdqwQw1p3ypASU7TKxqnVXg6aoEy2V3jZZ3LrsW6iqJKWedsIO2VR8Dte+BvBJjhtVdM9KbhdujN3cyKaHkSzDUbP7gXsMUNc6b9UAgpRpPPZJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752965093; c=relaxed/simple;
	bh=6qfSM0PzYkFqt/iq+V37cz9N6RQ8WjfWo9zOIcJvj2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcxWqDDP1cc5owt66ysqz8MRw51DdSP2d4Y4J9Fi81w/le2uWKEjtwY+9ymMAKL1WQv8HRBCD/jqv+7CVE7kUob8IsrEsytwjxncXzvrA53F9kyEcTPbjHs8eE/eR+m3AqQYfoELt661vyNBxOYm/lVlEmrICqcKL3qr+MehU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ9dCUZy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4001400b3a.2;
        Sat, 19 Jul 2025 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752965091; x=1753569891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpAsf0u7qEqgOoCFSjCz2GmzUWqUwe0Q+8oQjkkFLnI=;
        b=DJ9dCUZyA2snq1lRFn5yHxjWTaETjZWaTfcoRZD3rBNJv4g/lWaToBXz6pXNYJBo06
         byYfm+obbaHu47hIW3H88HY69VodVQLb0FnwRmnrOz7HtRL6Rd/xoN3uBZQBm2vx3DSp
         gci1ZqdheCQcGh3OG3ZfPuu6DpiOa/DZwhTDSHfWxTnqprEz6U9sE5L025D8mPq0lOpw
         nYKoq02mL50somfoOEh+62olKleQbuXnFwnOAQqrw9d0kZ6rsZK7Ofy1XZkf0gz9ZF8d
         h8EpO6ZoszJqn7Z+k9mcqZ4r1CF5u9nuOfT35zuXRVGG3S8pNHaE/xhQBzJxpYT1kziS
         s3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752965091; x=1753569891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpAsf0u7qEqgOoCFSjCz2GmzUWqUwe0Q+8oQjkkFLnI=;
        b=LCud4CnjSgkKgJTQmsjq+AJu3ckxjBMssnOnh3c4P3pgBQTEjoCM3vAl9KvFWNQxGS
         j5Js4oPiLU1mgIUcfVY3fgtoVLz91iQRMDfoNyy0JSfxhqoYuTW45rkXkHs/sKwIYRNh
         pq6Vd83S0l1khROc7e9wxxh3iwlRRcbAz3VNcj3b5DlGhuTN57A/+QZMqGN8GUxhGqd5
         fcwbGvapsOIaTyb04PsOahhvlGEYcW7+yw223Zbp/zw1yd3pKaLrD0ijm2pHpuEiqMw0
         MmcVNElYcOyEiT6i6jSvH2lr41GNIMxn9Xtlg7tivay3GL9/0FZfVwq4qu6pAzZwwB6W
         MSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEnTcrOsJtgcJ7cHc42PRfZjVLjG8rnDKGJbab3xGAyGJHm9ILYNfC3VYdNQXc9OW+bsNYHMhp@vger.kernel.org, AJvYcCXkZMLUKcpiEl6o6MRNHHB/XcQTP2JxuWjcgl+UWRd2f07laHEz9A7Aul1VEF4dNkxQHTsjBrZbi4L/vik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RfR/+teKhiDGKOViqYXX0485zBD95JXjgY4FpQ/o3Yr2HyvK
	rc6w+CaWTwix8z1ahAvU7QkHkjn3lIVlGzcXFLdEGsBo+kAFViWpSc6J
X-Gm-Gg: ASbGnctKk58CQewpt/YGXMU2bRn4B5cCtppfOAGB6r9CtKG7P4Bu3jZmFiDVB6jw2FP
	ouHcltB5SL/XWSLdKSM5RrF5s5w4rg1XBBViE1Qy6x1e34Ex3t12g1sHsgFM95oqy6fComfphs2
	rgcs2l+s48xEu4kecBuJRrFCG19Bk4tF3doMULidcH8SmDhdCtme1nLVZadtoK6iMbtrq0OsnbJ
	mELozcsjlkuhBHnrTXlDCANcAoSH+hZCMxkbO9u0B05Sk/QrIYHbRm9ZYQ04v7VQj7U3NzCcdEw
	8+B8B+9DbcSdBLjbeOGajosRjAJdRMv9oGexxHh1tPrC3p5wVS2sVmrmxykmtmzpD/nI3lrR/yJ
	0Y4R4TmcNX7rO0BqsWgLrIQ==
X-Google-Smtp-Source: AGHT+IHcT8dNDaVuaPX3yRVrcUXr8thrmjlKHBv0UlcunqoXVQP9zrK9wnw3YGPrQjKRM87ibUguKg==
X-Received: by 2002:a05:6a00:460e:b0:748:de24:1ade with SMTP id d2e1a72fcca58-75722d62d06mr21940983b3a.7.1752965091327;
        Sat, 19 Jul 2025 15:44:51 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb67900fsm3327079b3a.101.2025.07.19.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:44:50 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 1/2] wireguard: queueing: simplify wg_cpumask_next_online()
Date: Sat, 19 Jul 2025 18:44:42 -0400
Message-ID: <20250719224444.411074-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250719224444.411074-1-yury.norov@gmail.com>
References: <20250719224444.411074-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
function significantly simpler. While there, fix opencoded cpu_online()
too.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/wireguard/queueing.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 7eb76724b3ed..56314f98b6ba 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 
 static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 {
-	unsigned int cpu = *stored_cpu, cpu_index, i;
+	unsigned int cpu = *stored_cpu;
+
+	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
+		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
 
-	if (unlikely(cpu >= nr_cpu_ids ||
-		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
-		cpu_index = id % cpumask_weight(cpu_online_mask);
-		cpu = cpumask_first(cpu_online_mask);
-		for (i = 0; i < cpu_index; ++i)
-			cpu = cpumask_next(cpu, cpu_online_mask);
-		*stored_cpu = cpu;
-	}
 	return cpu;
 }
 
-- 
2.43.0


