Return-Path: <netdev+bounces-141198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C911C9BA018
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F6E1F21D03
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E44189BBB;
	Sat,  2 Nov 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyaLgwIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AF804
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551929; cv=none; b=VLpVeygI7K94QdyFzTTOrOBuKN38QreFw0n/GqtXZwGxiBREbdZ4ItUuTFSF6fp7ZDD7TS6qkjrNvlx0Gcqgvw6zr4Qy/Ic+sOTSDaVJDRpimB0ByYP7oKS3oZ1MPAmmHcIEkuCM1sKT/j/TMH962nhDh/vHVLmJERlhDIPwLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551929; c=relaxed/simple;
	bh=VR17NDuj+hqaxvDBFA1acIX028HPdS/pVscakTJLNzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM6voX+ILoy/pD5ueSOms63C4P8h0gi8y/tJPd7XyDJHWkR2mSUvwgspTQGsqFA78yBOrEPmC9y3TNwehvgVau21NOnrR98ULkEcSehxyJfGXQTftUTk/c2TXzWZwGDTbPcYx7Dex7hxZjtz4oKy3enHCgqkstNxpqJDqOZbuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyaLgwIU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431695fa98bso21255795e9.3
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730551925; x=1731156725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syyg/o6shfvunpoR5E1pb68wt2NFAsg8cY5/4Nq0NKQ=;
        b=YyaLgwIUuPsM0xGbriCZGPHPwCjZPN0mrG4Tr+RU1wInj/qpj03E4VyqLfHaIzGaah
         4/3+awgXzQc9IPHL4pAoGVbO39OYHR1cug5TAchCSQAo8hjK8EUfgnMAofvbbnKnkByo
         Wis0us+7VVAqLFiyPf5pKYiyB0o/0PKiRl6CUjxfOgsi/Buhwkk1QDB6LZ3WlRxYJUBd
         fWEc7+lbsKTg4skMxlsaYV2SkxUWup+MWXkl6xls2jjLxD+LIopJ/7hO1MZCUwWP1eaN
         bQUE0gmUrNMIRcaFEha0ZVivG7KbMFxc+8GSPye0kh8aeG/Pt4djAr30pKr0p/kN4Gt8
         pAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551925; x=1731156725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syyg/o6shfvunpoR5E1pb68wt2NFAsg8cY5/4Nq0NKQ=;
        b=FYCuaIYeT30DUs/eVHEQfXPOgayYrb1Ibw0s+vCGT17qImD32aTgZV9AqtPycbqJri
         j6EJ4Gg3xagmc1rYfyYpdsR986EcS187UjoKxj0OFguaRpof1Fsxij+sIMPlH5tw+fMv
         JUquI+/B7AgRQvXtWsQ809Eo5VcKcA3IDaXzJawoxItUZCmyOPZqWlXGgIXjyGHUZ3d4
         FqNFp++dK2Sv5Bl7quN/CeGl0pqjGWEr7TwrD8fG4zkI3mptYEmgMNPx2/trZ9cnD8ta
         1MTzfsOyLiX2G65Q6nXuBsC8ZwSKQMv4zqNGkBfs+yXTBjx2oHWotYUDkYXYgntu4X6P
         pEhQ==
X-Gm-Message-State: AOJu0Yzwt1IC+r5YEfl4/wnD0bU0fX5ObuGL5f2RPRGQM1aTkZvx/pcD
	NBbLyEViupyKxHLOgwG65kuUFDB+SYg6IFK6upww08cBoC4SoKqKLW2T6PzD
X-Google-Smtp-Source: AGHT+IH9mURRik7KiOJdnKUGenERsPeow2SYNid6UKYk82T6194Y1cNyqBUTf+N6h+kRCprioz1PNg==
X-Received: by 2002:a05:600c:3b9c:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-4319ac6fc1cmr254211265e9.1.1730551925574;
        Sat, 02 Nov 2024 05:52:05 -0700 (PDT)
Received: from raccoon.t.hu (20014C4D21419900D048749C30556844.dsl.pool.telekom.hu. [2001:4c4d:2141:9900:d048:749c:3055:6844])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947bf4sm127471305e9.27.2024.11.02.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:52:05 -0700 (PDT)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v2 1/2] Introduce sk_set_prio_allowed helper function
Date: Sat,  2 Nov 2024 13:51:35 +0100
Message-ID: <20241102125136.5030-2-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102125136.5030-1-annaemesenyiri@gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the priority setting permissions through
`sk_set_prio_allowed` function. No functional changes.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 net/core/sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7f398bd07fb7..5ecf6f1a470c 100644
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
@@ -1187,9 +1194,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
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


