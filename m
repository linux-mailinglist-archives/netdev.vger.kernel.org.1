Return-Path: <netdev+bounces-98030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C48CEA69
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E076AB2207E
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A6284D0B;
	Fri, 24 May 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsCmZlFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78984DFD
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579402; cv=none; b=RngzRlkMm7rSC+6Ep705rkCKr2Wk4tmWyXJ5PgNSfCoIKb4fp1kcLd08k0XJ8jJ1/WtazOs+Mj+Fm1XLjeP4Mfzqp4uUsEP03W16jPA8I7EQIbeM0nZcFG9uN5zWS+67pVlQ+qDkn03bFxywjLwlI4kACseL6ndorqRCDx7fT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579402; c=relaxed/simple;
	bh=nwY4a6uCgWev5GNG+aDQeObLSEQw497lbarZGqgL6KI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7hSLTkxXqKFY4UYcPR0hDFVaJnk95MDDrzzoG6oKIZFBIf2ew1NBTKLJe8CV8kekiuQ5K6z8Cic6umAV9pPfS9SbSpot6ir6Ua7xYjtZTkefX5SaRTtfRXsrEoBct/QRyi0RsVqOpC2YhhvHZ3l6A/18pvE3y9NJn6V0P+JtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsCmZlFx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4d631a4c1so961663276.1
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716579400; x=1717184200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da2shUIvj+ymaVnO7Kn/JRSXGfAaQ5BBjgrAnxRBjs0=;
        b=vsCmZlFxwQwIvybhvmngTo5eLbxpURq8fchpXfpuANm8MePRk1kLO/lrvDpaS2TB8n
         rrFQlo9EvmJvgSyXWqy442XtJJjBYidQDELzkEPSI19LPkt7gpxGRYmRIVJ/MPJ279c6
         r3DD2r1uWm3H1k7J1AlX3IIj7LhMXLLJRYAsrky61o+eARQEgtMOneQ88HU+gHmDdRsh
         ae/elYcD1g65AQnnBA9Q1vMBcg/jaD4M0dfs9/1QgvXLCZLcNVL5+0VB5taEZm4jIC4Q
         k6izQWDwQjBo0ycYwLM6N3UP6cnYu18d5SOYJq0cnSog13ANqAERgic8CmcgZ7TzOnWk
         R12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579400; x=1717184200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da2shUIvj+ymaVnO7Kn/JRSXGfAaQ5BBjgrAnxRBjs0=;
        b=uvdfHFICcc+VVvWuFRXSf515cFSWdCKYvduQFOBkovR5osJivsarMP0RuNjSFQzwcI
         asQk8hcoYOPTk6bVpxodc/HyIBKlItxu3FiaVlUIjQvDL3IAxq1MfIaQt6L02QQamQ5H
         TI/hWNnLNB6k3Gz+NwhwMVLGkBuCwOsdU9LdxXC2ZsJMwB16FcCcTpDpN+Qmp4sZRbJi
         RxlqNU5xQEXNwwikER03wy7YauLZ035qx1PfSEJpYBxcQkUPyZzbEVMkRMuWs4JlJ7Q4
         OXuVv+KrgtABvNuupfcPSHYOCyd5tXpIxBmkAkp/frJ8PSY5UQEm2mMNy0FiRq/3Ufnn
         aQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWYgV/gOmdB0imQI8WVlKgcnjDJQN4WiyyHTgQuR/+Xn96E/1dcKXj7xrKeQac+MOTGXPFPio22LmqFVxkvAGmZhlhVb+Ar
X-Gm-Message-State: AOJu0YwntX6nIrK746GagoXhDjmlDx4fDV16pTT64RKBEBTLqaxFTPEX
	VuuXm6/DccWdDHGtKZpnD22N5LTPvQm/M/bi3ZM/5k692/doT1yUmYVsFrIFet/FbIsDEtYs7f9
	ZaXvjMLgipw==
X-Google-Smtp-Source: AGHT+IEHQaBLUQxjsmT7W3h2zRuecy2h4RS6+Mw1rKDtuee+Kczg6ynNzVB3uX8qpwJANadP5u++ZU5n+YdBPA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154a:b0:df4:628c:3045 with SMTP
 id 3f1490d57ef6-df7721f39eamr261134276.8.1716579399767; Fri, 24 May 2024
 12:36:39 -0700 (PDT)
Date: Fri, 24 May 2024 19:36:30 +0000
In-Reply-To: <20240524193630.2007563-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524193630.2007563-5-edumazet@google.com>
Subject: [PATCH net 4/4] tcp: fix races in tcp_v[46]_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These functions have races when they:

1) Write sk->sk_err  [A]
2) call sk_error_report(sk) [B]
3) call tcp_done(sk)

As described in prior patches in this series:

[A] An smp_wmb() is missing.
[B] We should call tcp_done() before sk_error_report(sk)
    to have consistent tcp_poll() results on SMP hosts.

Use tcp_done_with_error() where we centralized the
correct sequence.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 5 +----
 net/ipv6/tcp_ipv6.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 30ef0c8f5e92d301c31ea1a05f662c1fc4cf37af..09192c786d145ee97058b6bab61d96274a883aef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -613,10 +613,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
-
-			sk_error_report(sk);
-
-			tcp_done(sk);
+			tcp_done_with_error(sk);
 		} else {
 			WRITE_ONCE(sk->sk_err_soft, err);
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4c3605485b68e7c333a0144df3d685b3db9ff45d..41ddc7c768ce957ff64aac6de4a2a59227e7c7ff 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -492,9 +492,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
-			sk_error_report(sk);		/* Wake people up to see the error (see connect in sock.c) */
-
-			tcp_done(sk);
+			tcp_done_with_error(sk);
 		} else {
 			WRITE_ONCE(sk->sk_err_soft, err);
 		}
-- 
2.45.1.288.g0e0cd299f1-goog


