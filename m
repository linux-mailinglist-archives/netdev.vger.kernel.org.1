Return-Path: <netdev+bounces-202810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80AAEF175
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36223189A1C4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD9426B772;
	Tue,  1 Jul 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AYTGavg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317926B2D6
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359273; cv=none; b=pBEBX5QrsDIb6UcS7bEnAWnAl9wxSLRDMtRXRbQ2YUjavXHeZdBtddd5vv1+5Gdp7elkjIWC+Wpq33wGdQL2Hg25c65M+ajjF9LeZ7rqCwOjLeYgaroKR9TWd661DB3vP04cdExkOf9XpBjpu3tFOXYu8mVVOuIZPV/KhuiUXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359273; c=relaxed/simple;
	bh=+sMr3wZCfdlUWMneZGOreaseAAkc+23zMJM5ICDMpeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjY1tjM2g+WgSb84Nlv+BnYYLaz8ST4+pVHgkCxDEWuynirjVQpvLD8+En3FVIjuP20bJDoi5R/deiBl7Pq43Wb5d6m9dMMX/gFUD1Hhg8mHDcWsUgTvkQUQFB/IoR9APXqsSbfagWQiPcR2nL0csS3vmZALMcSAGS5Sy+9P+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AYTGavg1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE6973F71D
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359266;
	bh=7R6rS2KkskS84A736qIaYQIuu8ODnigBZBalat5fXfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=AYTGavg1eSzKX38bEib/EgzUN9UyzfrEALrvI75sT9YP9dq3gEmx30vcSsoJIxaP9
	 /+AE+6qOe3qkDiFfXEVTSoFWTRC41IDK3Ahf4KZtjvCVU1DagOIUhdM2mVSJ0LDq5/
	 1O2uJg+qwnh6DSDWAjnmQNQk6EgDZaOIl7llWdb/3J/UDqX6Rp6kpuECQICUkSOVT+
	 A/M3N+K8v9+68kHxEwR/5JHL1X0JN+e9bpiri8vGIIDmk0Ro1x691RIyxBQQGQ3C+/
	 U8co6VekjIeXIbyE4xYj3ArQwZ49TtibhUipYx96QGrREcnwANc1gbMJALcPSZMyHR
	 XWMttucL9uQ4w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade5b98537dso275646166b.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359266; x=1751964066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R6rS2KkskS84A736qIaYQIuu8ODnigBZBalat5fXfs=;
        b=FsiTX0ATBQ4e3GmjTARPdTEjDeDnZuGMzLhv6I3lbotkA2/ssLZm4nMct5oBQanIxS
         DbYbF0U1IDac01c3RTOGjMqWz4IpLHknbjWO1KjYLkNzW9ag9ympLc+5nHMHkkTx+NW8
         aMlcMf/yKxhakVmACqIlRcOptfhlcj5cEUgeH+y08BnpeXHGOpBkuQ5rqhHChT0VxFSH
         LCqKdxuT5PsnLq15VOmI1RnyCnUYo6bxJntaQGpe258YVdn38gflUIxkXavPX2iFRyI4
         5nw9gw2XohPUmq3uWsvK/aAJfkWTiZvgEsekMleOHy+F1coElxFB/t1pGBbTmNj6LzPf
         PrOA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/akmP5gcl+RcZVPT/ctzvi8fyibaVWAP9H9gNhYPOLUCLaFMD+ofNGpgMkYHrIuqi1utUnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSVM1/H/GmZZChus7ydqrjDeKuCiuM1JMlTbZNj5247+LoRum
	0oMnl1BOc+sI74P3fShjOQysXwQcY/JPh17zONitqFNv/YZP/Akew4hC5AQV30GMIIGebAD7eEy
	1T0Ex4k4z0f49izKEQmQ5OUoiiMFCVhA822DgSZtOdX3OM78sgvwX6vqHdTmag0F2Cd7emPCraQ
	==
X-Gm-Gg: ASbGncuFVPWNDHwkVYAxYOel48uG2thZQEZaN4vMWul7Qt74Z0I6v4LFqRG1/Wqi7b4
	sB3OzM1eTFxIdosIui6R4ujck11PACxELt63JRFzIgnu2Y4kFw1QwkN3T9SuZ7d7m0rvKPfk0PO
	hGicBKPtDDFyK/yly8t0K3pZGr8W/bfivRC19a0ajsSu+cCilcI36d5AHZTLtObfXmjypkm1dmM
	ZDqbpHM4aYGFjrrfCr8zasWG/4KoGloB9GlI1pu2G5+Pday+WPKUEY3z7oJmCk46PGTwaAFRkgA
	I9sxv6uDU0GmkilO1VKOBZNNQYKLjTvss9ijd7+7rjAIt5+VXw==
X-Received: by 2002:a17:907:1c1d:b0:ad8:9257:5724 with SMTP id a640c23a62f3a-ae34fede1f3mr1555852066b.24.1751359266309;
        Tue, 01 Jul 2025 01:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaxWqS0edeNnSzlYF7Upe9kcBqlFQjGh4bLnX05mhxtBxNtyIBKe65cIfpFwUWnDOoa0N5LQ==
X-Received: by 2002:a17:907:1c1d:b0:ad8:9257:5724 with SMTP id a640c23a62f3a-ae34fede1f3mr1555848466b.24.1751359265842;
        Tue, 01 Jul 2025 01:41:05 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:41:05 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v2 3/6] af_unix: introduce and use __scm_replace_pid() helper
Date: Tue,  1 Jul 2025 10:39:15 +0200
Message-ID: <20250701083922.97928-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing logic in __scm_send() related to filling an struct scm_cookie
with a proper struct pid reference is already pretty tricky. Let's
simplify it a bit by introducing a new helper. This helper will be
extended in one of the next patches.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- don't do get_pid() in __scm_replace_pid() [ as Kuniyuki suggested ]
	- move __scm_replace_pid() from scm.h to scm.c [ as Kuniyuki suggested ]
---
 net/core/scm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 0225bd94170f..68441c024dd8 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -145,6 +145,16 @@ void __scm_destroy(struct scm_cookie *scm)
 }
 EXPORT_SYMBOL(__scm_destroy);
 
+static inline int __scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
+{
+	/* drop all previous references */
+	scm_destroy_cred(scm);
+
+	scm->pid = pid;
+	scm->creds.pid = pid_vnr(pid);
+	return 0;
+}
+
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 {
 	const struct proto_ops *ops = READ_ONCE(sock->ops);
@@ -189,15 +199,21 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 			if (err)
 				goto error;
 
-			p->creds.pid = creds.pid;
 			if (!p->pid || pid_vnr(p->pid) != creds.pid) {
 				struct pid *pid;
 				err = -ESRCH;
 				pid = find_get_pid(creds.pid);
 				if (!pid)
 					goto error;
-				put_pid(p->pid);
-				p->pid = pid;
+
+				/* pass a struct pid reference from
+				 * find_get_pid() to __scm_replace_pid().
+				 */
+				err = __scm_replace_pid(p, pid);
+				if (err) {
+					put_pid(pid);
+					goto error;
+				}
 			}
 
 			err = -EINVAL;
-- 
2.43.0


