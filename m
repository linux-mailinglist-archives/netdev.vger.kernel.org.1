Return-Path: <netdev+bounces-162810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F0A27FFE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97AD166B96
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7E25A63A;
	Wed,  5 Feb 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3lR+Dbt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E2802
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714259; cv=none; b=AYTOayhmm8jgMt/dkxtY2iFhWNugX4AvwVE/bT+h/3jk9tSXdS1LkjYSag9/SbTu174wBAu8+kgPnchslYqBp+JJ3jnc2L9v6tsB0DvfyeCdKdx1drIzqn9A2euHsWD7GSSCTjrEWgqp4px19pynCFOMdSME9X4rowUfVCmZLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714259; c=relaxed/simple;
	bh=3pBkuUxg/nYeSzKcAUj65vrufUT9p0wbFt/OGJy0oiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MgIZAx54EBtN3xsQMIswowGyca+Kpcj4rLWcHgG0KDae6Ds/J7TBpDOzcYSQjMY8XF7tpYGB6ZR/AKaPRoFe3w+rfRwRVNtlI1FoO9NFdSfpbI4lIJjKAJ967ZP13TnvmBkIDsXCRCEUYa87sKUlLJxEdS0hx2bgXC4jtWN+QzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3lR+Dbt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so135884685ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738714257; x=1739319057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFFdGkl893I80ON5edlJJ5zUbvDxkjqJ3KmjYhJCAGU=;
        b=N3lR+Dbt1nJIyFWtvALaAnaYJhDiUCJj6EyUx16OTYvFsAQ2Ltm0VqrDLT46LhjLcU
         2rahQ9lpqkFu2pdkGfEVyv+z742uOeHfhEAkoLnzSVcgO3P2C7zcPQ+ZhzySWuHsJk3S
         czsF+AslTWiQMVRL8ZBTdqv/lPBIK0+7vCw00m6YspEiOhJXBduh0NB/s37kx3cQn8we
         y7Nu3pQ0gz2hu84cgSKSsqzgOgklGFdRCi5Yl+CcgJQCGyrxhnnrlCx3ZnEIEeRJdIZh
         w51ib+6Ym7g/koDoR2ZeJggPpfiQ45S9pEHtIYjwDSrt2wIMtgdD089wgV8TzlcbBh9+
         OT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714257; x=1739319057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFFdGkl893I80ON5edlJJ5zUbvDxkjqJ3KmjYhJCAGU=;
        b=WWk4238ayUHTm9PRsHthL92njxLoctykVaZWozwhqMXLJlrIWNzlMBxBSkpQxgKU3n
         Po2VN2wCMU6REL6k/vgullL6A/4i1CAw2JXHrIP3ocx/st09NEBYNycKd71W9FfhAdyV
         BBuBKZY4CqMtLyhhIWXmGcUQ8GDeqCl3hx8yniNqeUzUCc7RZfiXfbgAutes098cLXYD
         1DBqlMsqXpz1C0nJ3X8Q1Iyc+bET1d/Q7+vmhF8Qd5Et0AjaiY2amsAC7+JlmyRkvKcE
         SnSNcnRNQlyD8eEFnriQ5Qp9wd0JTKxVzGKSM3bBT7aWUOzRfGNVbe1CQoXlsa8XDTPL
         nt7w==
X-Gm-Message-State: AOJu0Yx0J4fqJIdV88GKKwcw1hltIEhTT22XYoBtwJ0/IpwkeUHspEq4
	0pZpbJ9mzmJ2mSTNhxtp51+R0iWAtwRWw2zIU+40JA5JtY0Kfm8vys8PXTyQ3H53izSUEuT17T8
	VZJ7uwW8+CQ==
X-Google-Smtp-Source: AGHT+IFzOoZQsgT1Z0EhMGMwfCJnmtJYJoeOn//kq4CLQ/v0vVVXjNfMga2xoi2W8DnXgq+hEJyT5F4xd/vkkg==
X-Received: from pjbli13.prod.google.com ([2002:a17:90b:48cd:b0:2f5:4762:e778])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ced1:b0:216:69ca:7714 with SMTP id d9443c01a7336-21f17e2bfecmr13651095ad.11.1738714256764;
 Tue, 04 Feb 2025 16:10:56 -0800 (PST)
Date: Wed,  5 Feb 2025 00:10:50 +0000
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205001052.2590140-3-skhawaja@google.com>
Subject: [PATCH net-next v3 2/4] net: Create separate gro_flush helper function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Move multiple copies of same code snippet doing `gro_flush` and
`gro_normal_list` into a separate helper function.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 net/core/dev.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 50fb234dd7a0..d5dcf9dd6225 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6484,6 +6484,17 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
+static void __napi_gro_flush_helper(struct napi_struct *napi)
+{
+	if (napi->gro_bitmask) {
+		/* flush too old packets
+		 * If HZ < 1000, flush all packets.
+		 */
+		napi_gro_flush(napi, HZ >= 1000);
+	}
+	gro_normal_list(napi);
+}
+
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
@@ -6494,14 +6505,8 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 		return;
 	}
 
-	if (napi->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(napi, HZ >= 1000);
-	}
+	__napi_gro_flush_helper(napi);
 
-	gro_normal_list(napi);
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
 
@@ -7170,14 +7175,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 		return work;
 	}
 
-	if (n->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(n, HZ >= 1000);
-	}
-
-	gro_normal_list(n);
+	__napi_gro_flush_helper(n);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.48.1.362.g079036d154-goog


