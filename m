Return-Path: <netdev+bounces-212904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD7BB2277D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4A51BC043A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9398F275AF9;
	Tue, 12 Aug 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfFpH4CE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106F27A90A;
	Tue, 12 Aug 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003153; cv=none; b=Nzkfv7C22EmmLGtbcz0r2/gFBbpCh+eZyCJopQxjY8AuUnRpFOH26rgGxCiypNNHCK9li/nxuOUlbTEwE9oA3DhWDCdIPAXnIOLI3defBJ/A2lSdbT5Yy2IlfnMZ15AM2L6mcH7s4YDUBFGM3jZsoCpdMDv5xpbnn7wq19jdzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003153; c=relaxed/simple;
	bh=+KnzwoKbA1GtBdrTr//kfdTYJsbn0oZ8P1T5y+ypoxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7JpLrojLyNATJ443JHweE4EpaLS2U80kEl6gobkiJtON8WHTNkAA+Ca5KbU+b5oX/T5n5PC+EAxSuxLXzmlGZISxJO0U8YQDvhmGuxulBtibniNm2sKE9Wr70CiJlaMusHQGBYhdw2RYXIo++uoOA4BqeHkyBvoX932oIER9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfFpH4CE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so37111115e9.1;
        Tue, 12 Aug 2025 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003150; x=1755607950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJmbqKfhPmGmgPRu3RIwXN3mEJ4fXgB708Rx4HkKDQU=;
        b=AfFpH4CEIDWbx3zKX1W5f3c+BLy4joyllmXBFxVWKQ68YoC0zkd2k9eEKdC4LSLo0h
         TQL69GFUTaYD4CqIi7WUWDf++NlM2/9EuUmy1WAHju7ChCgpHjX4afzyVomkhbNoAWEr
         WXbQ/zdzq+vo46ohP/MOj2/qSFccyyroq2THbhGayMUBrxwA3YRAjDiph2I3rAEfzTgb
         zJXkVT0+usOdxjS/yxRfoLupJgXsC1KCm8Zp3zuj2eL5uxL9WC9VPRYRADxwi4iP9M3U
         7Cqn7SzilEUSt2+T1lGEG1rO47OvDBnZe0KNhGJhfHA5hUp9NdBYcKaLTnJs36czAtS+
         6ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003150; x=1755607950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJmbqKfhPmGmgPRu3RIwXN3mEJ4fXgB708Rx4HkKDQU=;
        b=A+y9vsjP8AqC8kxSlqcAxgDWokh0+uAALQhh2OALVWba2jLykVLLnsRPHPE37M7aqL
         AU/ZJdR48KwSsCTfL2GlTWHkP8OGCLfujx65aQ9X86ICBHXWfKC/isumT5WyU4gTVlKI
         Mss8wPEoi5ccP72RYIPteMDX4Q4YSXxe5RU4vm5r4OjqmIm3GryLmLDugLlBcTrY3BL6
         fGfhuuPk/Qktpo9mWxUbCr92rIFQURw59iDS5HqcyfTwNEOWL6vzfwtdxE7U6xohGzFb
         KuozChsfieQ/QBl7cuaSenhM6GJhsabN2p5L3TRJiOG2NAK9Fw60MFdzvkHJc9/x5X6R
         Cd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPv2HKtX9MmzEg/QngEIqF+1Y3ydi1T973GF0tNZerF+YX6EPq5mRjhjTZzjImC7nacnDd7vb7vkiLUn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9B2o9t14OoNovaCPqGiG+lk0hZypLbDvHaRDIJRFchgnNmcU+
	9E6mttjJ5AWGpJlmJGjUwpC2uHBJNyZXzBO68ijvv+BtntJVm7cqw280Tk3BqLRmrvr+8A==
X-Gm-Gg: ASbGnctz3n1bj5j03/RPld/XLqq3zzSkSubHYi8sAKM73zA5b5dN9WX0S8HNtaWoXQ6
	khgYMqIBwYKspY2tFgCeG4tOR2U7Gn4ObfpB7rJpv83MPluzF6Y5S02L7QokCVxyylaCgxxpFTI
	YvQNf78yf9FdsISDyfPn4s7mRVGAxih/6PEjMzQ2rrJLwpc0lIlXRMEC9rhsH9ssMLXskLVlmlR
	Gz+xS73vsO6RNnHmd/h3++by6n0vn3gSG/lSo3f/B6HiHp0FH+dOaVS95NF5R3d1SehEE5R6AE0
	NYF7lIY4si1AFTJX5cYRRJScrgSDkamb1FGXbwayFeIV1TvpYizZA6PYWYrwMGh6rTML9QdfU0a
	fJzW7kIUG9P7QGR3ib/NnjHiK9m9H8S3dfg==
X-Google-Smtp-Source: AGHT+IF7FOf3ezDUvrcZ7a7p8x0YEBe56/F444t0glGSLYpp7mg0GhpKdEA3LOGMp5pO+OnYr0XvVA==
X-Received: by 2002:a05:600c:1d28:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-45a1382a982mr17035695e9.0.1755003149708;
        Tue, 12 Aug 2025 05:52:29 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586eef8sm292832635e9.21.2025.08.12.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:52:29 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 1/5] net: udp: add freebind option to udp_sock_create
Date: Tue, 12 Aug 2025 14:51:51 +0200
Message-Id: <20250812125155.3808-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125155.3808-1-richardbgobert@gmail.com>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_sock_create creates a UDP socket and binds it according to
udp_port_cfg.

Add a freebind option to udp_port_cfg that allows a socket to be bound
as though IP_FREEBIND is set.

This change is required for binding vxlan sockets to their local address
when the outgoing interface is down.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/udp_tunnel.h   | 3 ++-
 net/ipv4/udp_tunnel_core.c | 1 +
 net/ipv6/ip6_udp_tunnel.c  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..6c1362aa3576 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -34,7 +34,8 @@ struct udp_port_cfg {
 	unsigned int		use_udp_checksums:1,
 				use_udp6_tx_checksums:1,
 				use_udp6_rx_checksums:1,
-				ipv6_v6only:1;
+				ipv6_v6only:1,
+				freebind:1;
 };
 
 int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index fce945f23069..147fd8ff4f49 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -28,6 +28,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 	udp_addr.sin_family = AF_INET;
 	udp_addr.sin_addr = cfg->local_ip;
 	udp_addr.sin_port = cfg->local_udp_port;
+	inet_assign_bit(FREEBIND, sock->sk, cfg->freebind);
 	err = kernel_bind(sock, (struct sockaddr *)&udp_addr,
 			  sizeof(udp_addr));
 	if (err < 0)
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 0ff547a4bff7..65ff44c274b8 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -40,6 +40,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 	memcpy(&udp6_addr.sin6_addr, &cfg->local_ip6,
 	       sizeof(udp6_addr.sin6_addr));
 	udp6_addr.sin6_port = cfg->local_udp_port;
+	inet_assign_bit(FREEBIND, sock->sk, cfg->freebind);
 	err = kernel_bind(sock, (struct sockaddr *)&udp6_addr,
 			  sizeof(udp6_addr));
 	if (err < 0)
-- 
2.36.1


