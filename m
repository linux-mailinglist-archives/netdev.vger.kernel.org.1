Return-Path: <netdev+bounces-150808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80C9EB9E3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9351885D50
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD8214209;
	Tue, 10 Dec 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLejjT72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB672046AE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858028; cv=none; b=eJN9kS/f4vKKXSz1tyDK878lFOPGvUUI2cH46VNhc6bKM6NilRMb12JBISczs4PtarNV4cXRWsQ+ODcePj0H55HcelyLWQwkYn2iI8vRL3F4xQ3x57o86lGhQFhix/LbIaVcGM1iDU7AA58M0SjGJn+IFyuZG6FipC+H6Sjy8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858028; c=relaxed/simple;
	bh=QPh03QEa0M8YEQs8GzmP3qJH+OhK905FKbbXXrN+B+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2uzFXAuRO4WjgasOwQI9S5qxD7T3wzHat3nnpYSdeF4J0C0Dgzy4PX/K4qztTPr2pzuG5GocK9Phh8oyrS0IlWHgwczwS2f83mwPVlG0JH2wqrwE38yvZfzNNCuqvDQK8UtO7kC3vz2U7ByCXEC5UIu0crGWjZl1i+9x5n2Q6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLejjT72; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862df95f92so3034161f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733858024; x=1734462824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=JLejjT72hjIOFXkpEwLSBJgN9Qgly3Ao73HqgftOMd7lt4pbREfGXWWNtVOY4MqwvO
         5TGbWvVsxXIGHqe+/9ZTXwrrp70un9LEMsmLiBMnugFs02CVmv5SmpzSNwtC6O8uq/Vu
         tZnczs6YNBygC5cQfg9aGChtoWXelMosOJL5I2/isPE+aMTXe71m+ShK8v/CD9pOJpye
         Zt4Yxw0frPCh8k0GKmbo9aCVVFG6cxvSaZFcc+EXv1+am4zxAM+mpo4qmndbBbxLkeUP
         PKvlgAfdgTGBvYMmcm2k1db5qzzK8/w0eij73gEKTxf10tJvWyXc4rY6TeIpz81KRmuB
         w95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858024; x=1734462824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=JWZSE2g4z2YmCoITjDZee2K23pv6iOW/eiLc5hpk0qTtCiGvpNVbbn3Djv7qIgHCD6
         jJUamCCgFXaXxbn9W9irSZ7Wh3NW24YTd8A4U3l3vJ+NC2W0hB62Gp5c/nbGCcUQIfUY
         Pgc9Im5iGkcw1L6ZFNjnqDbRU8AScIAwsiKD+WVN5UyRLbmqlrykCGpYg1gZx/Y8zYkX
         UqruzCxYq/QZu4KXUvMsUpaexc5CiSFNDEmIC4hX5Ss7UjPDX7uwowgYufT/wPpjPHV9
         kO3BJ1g5TJvf5Q5yIb8Z6uBXpEUp5VVk6B5dYV6KVToeLtpfm0tcwGj8LqTAP+Ye4aqQ
         12kg==
X-Gm-Message-State: AOJu0YzhGaOTMcJflSWWNEtH5KparwwO/hNU3ZKuIxwilgZKBbKm7yrZ
	IXLU2Z9MS7855S0w8VU/e1zde0AydGyU5oCqAkrFmb8LKG1qSqIUV/ipPNNPtYQ=
X-Gm-Gg: ASbGncu7RNTfyGpq94j+Nr190cTeZFqiEYitkI7pKb5iIKW/cN/6op26Iw95GIoxikW
	jUdNArQ4e7wedPoO9FNpdhr9vh+1HKwdzT6WrlFnmFjHKzGMI9BVXlPDvaXAtxNlNRGKyXKWaOa
	AbebNezhF14WE0frXpegamp0VKFMXWdTdSkQMY8lg9ViQNDjsEbdF+2jIrTom42h1jxrQoy5PlS
	w3DoZ2LeOyigidTVD8SB0uFkLQo94wkQEyTKhtwnPo+hqK5bgUtGLHs/jwjZM5hHpxmfyoj9csG
	sRjbWSgDL0PhVl4fpEcsefrqjB63Q3hylGiQCGl3oC0PYaXmfBQRYOEWMNMsxw==
X-Google-Smtp-Source: AGHT+IGfksZlNLmG4OiXHSKyN6+5vemY1rdHg/Nk6T9Ijqym/Wncl4Y+X/ri+qPRrLAa3LLOFqdcow==
X-Received: by 2002:a5d:59ad:0:b0:385:fc32:1ec6 with SMTP id ffacd0b85a97d-3864ceab34amr158271f8f.50.1733858024219;
        Tue, 10 Dec 2024 11:13:44 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C7006406573B5E53AD5C.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:6406:573b:5e53:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13310345f8f.108.2024.12.10.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:13:43 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v6 1/4] sock: Introduce sk_set_prio_allowed helper function
Date: Tue, 10 Dec 2024 20:13:06 +0100
Message-ID: <20241210191309.8681-2-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210191309.8681-1-annaemesenyiri@gmail.com>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify priority setting permissions with the 'sk_set_prio_allowed'
function, centralizing the validation logic. This change is made in
anticipation of a second caller in a following patch.
No functional changes.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 net/core/sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..9016f984d44e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -454,6 +454,13 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	return 0;
 }
 
+static bool sk_set_prio_allowed(const struct sock *sk, int val)
+{
+	return ((val >= TC_PRIO_BESTEFFORT && val <= TC_PRIO_INTERACTIVE) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN));
+}
+
 static bool sock_needs_netstamp(const struct sock *sk)
 {
 	switch (sk->sk_family) {
@@ -1193,9 +1200,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	/* handle options which do not require locking the socket. */
 	switch (optname) {
 	case SO_PRIORITY:
-		if ((val >= 0 && val <= 6) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (sk_set_prio_allowed(sk, val)) {
 			sock_set_priority(sk, val);
 			return 0;
 		}
-- 
2.43.0


