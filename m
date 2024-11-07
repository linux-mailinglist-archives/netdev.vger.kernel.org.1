Return-Path: <netdev+bounces-142836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A39C072E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB42282535
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A92210189;
	Thu,  7 Nov 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8UndFW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687B20264B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985785; cv=none; b=PWjetn2RlweXa9fIfw8QlQIR+oJLCCGUPPOSrwzWtokFF/kupT9NQfZXEymHtr3jXwwe+m8UsuNGcSsrdi8qd/slcNAjiaN6NWU+MTIjK+DFkY0tADG3uLGU7t4sigzsolZseY3SzS7NJL8HYRmL6GMRLysJ9YizxpkMKiafFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985785; c=relaxed/simple;
	bh=uakT95QRKAMPGr5rnEGSIF9eg7YeOoKPeqHEZ1Rwq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAz7R9Itead5Ui4TgKuuJo4sCe4bPkzxdKjhO/ngcna7CzD1pJ+KvwiRWHSByjRRFaPYZ3rR5/1t+0yGVgeL0dswQPQM1rHOXoDYrYiePDu+mr7Fs0PV5xycKMi9DjaSMMc0WfT20goLDomv0PvEEQgRy7nafRx98hmOSG5nj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8UndFW4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43163667f0eso8482485e9.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985782; x=1731590582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQCT6XBkf8PIWDwSJOYK/aa3L+Wngjl/kOH95i7z8SM=;
        b=R8UndFW4DVSUcz4OTcfCylZOzOzbO0chj3n50yRxFyES+R5e3NQaRX8GnrnDSuvfoA
         Wf4vxQRNS+cIUCSJsBmbsXe/uzxTb9BT2rWj7sK2kUL7N6EkfgfsAJoBalJKhoN2teSD
         H8nP9JUpTtrR+D4S7fmVAogLuTWNHfMZASIgzPDJvZtF96AfjTMPpqgPFzmmdrltP/Sz
         QLjnVSd+/9cdy0DPacQbZtlYRvcXZBEiWpFX9gDQ/Fpa+k+SpTruAExTD9lG99lgDvPn
         JPfeIgiIhG/PxC4oqgFavRvzBcD5wTcJHx3FqQHxd1Ntxt5eRYDRPNaue4TneAa8nDsh
         7YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985782; x=1731590582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQCT6XBkf8PIWDwSJOYK/aa3L+Wngjl/kOH95i7z8SM=;
        b=Sj4aLlwMN+rMx8K/IUS07v9hES5gOLZiwn5Ru65FpJkHyMYx33n2V2S1VHBDJ5Wwmg
         vkWpB/0XjqjJIqmYbT35iV8aq1Lt3KQt+Pinc9kXMkRANfJhynsmq4BVQulD9gJc8MDR
         ceoWZTujefkStXcqWvuaZV4QQSr/CgPr46JkaNeLJWcDo65ldGC07sGY9MhHFEu0odYR
         xo9+UqquFHWGqpl8s1BcEy/mYKcv6oztUrNW4J2Vh4AOyoA385peTU2jEoeWXPbR5kwK
         0pE1FNFYFO5Ibo6s9IDrnrvdbmOC5yTogRz58kDFJxMg/KH/1KHMLeA/ihVrasycs4Y2
         eEcw==
X-Gm-Message-State: AOJu0YyUuNltG/m8JyAGnth/Ptoq5I7Go/nR5R367YBYvOfLEzqwy/DS
	JChHUfdT68rrR35d1WL1fk7nfEq8nKZpF/oP3scvF6GjT1xSWEwiJb8UvNnw
X-Google-Smtp-Source: AGHT+IHZ8nDuF4S8EY3SoNlZX6/LU7oASeMi5NYSrG4Fkg1lDnM6yhlvMqeR7eArYzJRr7pkkht5kw==
X-Received: by 2002:a05:600c:3c9d:b0:42f:823d:dddd with SMTP id 5b1f17b1804b1-4328327e6ddmr195374135e9.27.1730985781897;
        Thu, 07 Nov 2024 05:23:01 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E912B00E77793ED09024636.dsl.pool.telekom.hu. [2001:4c4e:1e91:2b00:e777:93ed:902:4636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm24372355e9.38.2024.11.07.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:23:01 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v3 1/3] net: Introduce sk_set_prio_allowed helper function
Date: Thu,  7 Nov 2024 14:22:29 +0100
Message-ID: <20241107132231.9271-2-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107132231.9271-1-annaemesenyiri@gmail.com>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify priority setting permissions with the `sk_set_prio_allowed`
function, centralizing the validation logic. This change is made in
anticipation of a second caller in a following patch.
No functional changes.

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


