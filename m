Return-Path: <netdev+bounces-185721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA6A9B8B6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CB23B3B42
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5CF1F3FC2;
	Thu, 24 Apr 2025 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ha2Stb0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA291DEFE1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524947; cv=none; b=RxwPE82sbllsK13Xs+hNY9cRIbLl6IfTfdJzF83f3sU8XkPhBHucOBpDMWEvTHnejRxxbjA9s5DNIsP6Xon4g4tJ2+yoPVYhfndM+dV+sY1cPlQTHiXnItv5viK2NwsVb++MCYtbIUDPavYuwCa4GFEVqNrfFtWxc6pUrSuYAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524947; c=relaxed/simple;
	bh=G5FPgGIAr56Dm6OmAiw+3TfnWCz38ztk7aeIWvtCXi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H54VTXfAaHJBPTDeZbepezwaG6lfZR7y/aMJDcieFw7mSHRc3UeHYt6i2DgAVQJoTebMkcJVGQxzqhq79K98mH/N4dIuAtATCsTvnNx/0ocQ6tYkYHa58dkF6yTyphcvLecNOcV7GaJYouSE4wf7FiO96XbkpLYGwlVdUeEvfrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ha2Stb0i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395095a505so1007404b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524945; x=1746129745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ooZondSay8yMIwv4kizpeQOme/3qbIrv74ViJyS8So=;
        b=ha2Stb0iQCfpnd8xvOe4QzAh6a9L53jaNgtjhsjixzFSEvq2LNbZ5DoyUDTmMQbC8L
         UsHBa8Ls4S6ZhO28kB1WsYr3UOQdH4lRdpSAOqkT7nGc278rEdZQCxaOjFtOn49rAGS4
         9VAyC75dEPIY+p5hGhUz4DBopssbLOIDQqnDtCOQSwP632f+BEPakCuf721qEet97c9f
         8xXPQWhj85F2uIr2A8K3njCZPlzMK8mtlzWeKk4oHy9dOqWiGY7bhgA0o7yFBCT2Hc81
         NOzbPvycD646tKr05NHLQ9+NhqjDiVjiePqI01xEpxgBLXDQ9UnRI2eMBLt5QH6USfhp
         NlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524945; x=1746129745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ooZondSay8yMIwv4kizpeQOme/3qbIrv74ViJyS8So=;
        b=X6AplXzKlzuB7jAllppWX4KIyX/78K6k/ncKfwhh4g4Zrzmiomz3nkgptWhNyJVwht
         APPAOQwoha1BwPaVJirINNzTr8h+l5Q5dyPfESZfpaQAAo7Es9h6ne9CdkpMREY1hJSk
         IQtUb5RTxx5IfCQf2A1oTzxfe8cYI1JINP8NtnrdSYJhPYfyvvaeC6XMU0dlJsm6r4i3
         ANUGl5IThpNt/IPK4nRJCCJilHQxUFNkvuYJ78+H7QTYk6ASK0I+34YrUp8WPXZ069dy
         Fb651VgJamaP1TIh8w+SVHaqCRMyYC0Vepmc+B3h6cC7mB1Y/mLD4YbgHGC3Datp/Mg8
         KSjA==
X-Gm-Message-State: AOJu0YwKdhJDXkbXz6wOHOSjKmDRAx2dqZ9PN9jzDecPsp0Wkf6jg0KY
	hcPNWyLuxozW+sKFDhnLRahO5oMg1boc3pnYTT9nt+ar1TT/vrVzOc581Rv5xEbPoKVuaE/HVPc
	tuOp3KMmv5A==
X-Google-Smtp-Source: AGHT+IGnCTq3uFWoGSZDQMXFqj+tvBmeVrw5krdRqV2P8kU24Eil7AmcwEO/M263FNw2c+qll2fUUcSz+woiYQ==
X-Received: from pfuj21.prod.google.com ([2002:a05:6a00:1315:b0:739:485f:c33e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4090:b0:736:4bd3:ffab with SMTP id d2e1a72fcca58-73e3309416bmr992142b3a.17.1745524944951;
 Thu, 24 Apr 2025 13:02:24 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:02:19 +0000
In-Reply-To: <20250424200222.2602990-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424200222.2602990-2-skhawaja@google.com>
Subject: [PATCH net-next v5 1/4] net: Create separate gro_flush helper function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Move multiple copies of same code snippet doing `gro_flush` and
`gro_normal_list` into separate helper functions.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ea3c8a30bb97..3ff275bbf6e2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6506,6 +6506,13 @@ void __napi_schedule_irqoff(struct napi_struct *n)
 }
 EXPORT_SYMBOL(__napi_schedule_irqoff);
 
+static void __napi_gro_flush_helper(struct napi_struct *napi,
+				    bool flush_old)
+{
+	gro_flush(&napi->gro, flush_old);
+	gro_normal_list(&napi->gro);
+}
+
 bool napi_complete_done(struct napi_struct *n, int work_done)
 {
 	unsigned long flags, val, new, timeout = 0;
@@ -6538,8 +6545,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 * it, we need to bound somehow the time packets are kept in
 	 * the GRO layer.
 	 */
-	gro_flush(&n->gro, !!timeout);
-	gro_normal_list(&n->gro);
+	__napi_gro_flush_helper(n, !!timeout);
 
 	if (unlikely(!list_empty(&n->poll_list))) {
 		/* If n->poll_list is not empty, we need to mask irqs */
@@ -6609,8 +6615,7 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 	}
 
 	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&napi->gro, HZ >= 1000);
-	gro_normal_list(&napi->gro);
+	__napi_gro_flush_helper(napi, HZ >= 1000);
 
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
@@ -7433,8 +7438,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	}
 
 	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&n->gro, HZ >= 1000);
-	gro_normal_list(&n->gro);
+	__napi_gro_flush_helper(n, HZ >= 1000);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.49.0.850.g28803427d3-goog


