Return-Path: <netdev+bounces-100846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB918FC44D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9F42887A3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CA18F2C8;
	Wed,  5 Jun 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wR4sUYOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD919148A
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571761; cv=none; b=bqYGXcgFhwNp4LaSavLPYlH0HutYF64bt7Z9LoeaKKkYtclFrKDzoSb/9sPqUp92gAheON+AwohkLIiJSUFYk5r37vS4Y5qH3rBBj09stU7CFp3nJuin+Gavyj2Gg8Gi8H2TP5l1S7ct5hTSPvuwnH4DbIaY3TKpW60pCRGCdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571761; c=relaxed/simple;
	bh=rMJnbMLONdx8crevHeHr1r1Va4Rzg59xhcvTxekZSik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ca9uWOswSubM/Hh4Z8MBCzdSh4PceAPsRj0Nh9PDMZ9ivDohzBx3gcW+TCezwhvqtuR/7NZSiVZrp/0fOlrk7gjZNHlLeVDWbaJbH2oH7aSC/JDUKFF03nM6QZ8aeJ8A44eeCJy1DlDFlUuXFPCXnY0eWqMfoj/WvHf49S22SZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wR4sUYOn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df796aaa57dso7856532276.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717571759; x=1718176559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIH0whQedBMQLxD1lF7hY5JXX4O8JNYqdi5UpXX5ybs=;
        b=wR4sUYOnSrfRYpQYQvivLjJKJ3JdLItngvR1rO3AQEglNko/AfjaiFtxdIKdkUL7Au
         vOXspQkdNiW5leOnNqZCnKZ60gRI8XnaoKe5MtH8/pXSvdX8U75cuDKTYWOvkJTWO7Ks
         5dYJa73YIZWZ8MGmnACobeSuDYKYIKciy6LK+ZNQxT6EnhDvFkiI28fr9mF5cG2Z7v4X
         T39S2CF4NYm7ErSrCUX/sg+6ZgsuYlBQP/inHFJ/kuBAQ1DygI9KACqI4uFPQyo92ARt
         eDc/w5iPLIGbKlHWAsrapmxGXvF9M6Rx3PoFP0sGqm4mshPMOtKXtz+SAWubh6GmHwdE
         aLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571759; x=1718176559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIH0whQedBMQLxD1lF7hY5JXX4O8JNYqdi5UpXX5ybs=;
        b=IoxwqS2oZaNtuRVP7AADXZOKzCUVYVK4dar2GXp1Lh23uYs1kZCUUFt1U0KhhLvD4D
         aMzixgxeReXW5Ssc/FkzNn4P2weUDawo/KNnnTfltOH+dElh3Bz3GaqTd7Mi4PKv0GYD
         O8eZPaKav3mebASkXqiEArOT0gqXjedksD42bzv6yr+fdw0t5D0iYMBhU+yQaFgmroRL
         Pk0M7wI9EJdAH4vCo6AGQoMfUP2gQcwW0sSwuo72ABvyykRSECpODSUBonaDfSftbgs0
         qGec7mQcFGKX3VFd9lVvfSkH/kpmvyOP+tz+dojJ/cK/GkcSwnXyFv5e+MzTO0V2sYmi
         4nnA==
X-Gm-Message-State: AOJu0YyamlFcESbbXvTXWAkUUX7WHYerw81sKIEgARJZgjq39rkhH8G1
	6NJoSJtCbm5S8TI/7Au2MEDaOTmtZ+gesF8PQ5tvxrJJdK49i2s7WaNhoIaPEg9WrWfPZV2FXIU
	bpuebqG7Ybw==
X-Google-Smtp-Source: AGHT+IGUla0W3/ozXGg8OroukkU8BlyEjF/KqSslV3v/W6z+l4UCm/3Zv+m71NJrxfSdoVVq7ywCzEmY1shaVA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d6d4:0:b0:df7:6f84:f36f with SMTP id
 3f1490d57ef6-dfacac3ad18mr74157276.4.1717571759216; Wed, 05 Jun 2024 00:15:59
 -0700 (PDT)
Date: Wed,  5 Jun 2024 07:15:51 +0000
In-Reply-To: <20240605071553.1365557-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605071553.1365557-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240605071553.1365557-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] tcp: small changes in reqsk_put() and reqsk_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In reqsk_free(), use DEBUG_NET_WARN_ON_ONCE()
instead of WARN_ON_ONCE() for a condition which never fired.

In reqsk_put() directly call __reqsk_free(), there is no
point checking rsk_refcnt again right after a transition to zero.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index ebcb8896bffc..a8f82216c628 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -172,14 +172,14 @@ static inline void __reqsk_free(struct request_sock *req)
 
 static inline void reqsk_free(struct request_sock *req)
 {
-	WARN_ON_ONCE(refcount_read(&req->rsk_refcnt) != 0);
+	DEBUG_NET_WARN_ON_ONCE(refcount_read(&req->rsk_refcnt) != 0);
 	__reqsk_free(req);
 }
 
 static inline void reqsk_put(struct request_sock *req)
 {
 	if (refcount_dec_and_test(&req->rsk_refcnt))
-		reqsk_free(req);
+		__reqsk_free(req);
 }
 
 /*
-- 
2.45.2.505.gda0bf45e8d-goog


