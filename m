Return-Path: <netdev+bounces-179389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD9A7C55A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494131B61568
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90F221573;
	Fri,  4 Apr 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6hKXNN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845621D59A
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801309; cv=none; b=UxNKCOs3f3bazG9nPfGJEDfLy/vfi2WCILizttO15Mmuf5KB3ZsEBSZMCTtphiEHqbiQ+TS+jIlTuze3ifR/x9qoPI9Raf5ZVKEwhNgR3zaQHo3bIAH69x3wFhLuzVcxA6zvJ4pMUjv+7WDz1nti1+rvrhQe7j3vIlYMXMRA2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801309; c=relaxed/simple;
	bh=lt3v4NByeuFhsRflhATM2AU2H0rLtGPyZ6uc0g0P4aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mmsv3KOQ6JeADRNtorSMkK2ZKBOh0XdYjl7rGippmjm8fDxq1FLElLAhlbj00XotPQ90GqpL8CPtG3nuBcNSj6O7adtKQTEjEBJnUIPeklb3W59syDoSFVpMkRVVa+a+3VsViGmataQLeUY99JxjIFRlcs8VHA+FcwPUXloOjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6hKXNN3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so3642367a91.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801307; x=1744406107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj98VhLI5wUP0/dBD7V9/B8uk5MsLM5FlS2oO+5uLWg=;
        b=I6hKXNN33W6fvlYWWn1oGiSxM3RrDcFoDvq8grXNLQUld+mA8s1zWeg924FpZkYXd1
         s7/1Qfa3FhzA6ERTjNsRhJSW2V3j466Wb9ojTb76tOmWteyZZkvpbRMOh+VDzcSWIZkE
         kyFxyQlgFR0nvn82xlUU4qTa3Gjop6aFKBDrlCCcRQOnfDw/Cq/9+/ew/9JdJg5Q5sTC
         cDZzd04jFIWz8xZOZCHeCb5b4O6VgWxIicjcHQJn1uls4pP+fHRqGKy4kUf3t1Hr9EIx
         RhbZmEDw+B8uSLiOwig5SCG5n4Et7XKmNMWLbKRx4mcOl+Nx2obnGPKS/hlCVPqQxSfR
         JA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801307; x=1744406107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uj98VhLI5wUP0/dBD7V9/B8uk5MsLM5FlS2oO+5uLWg=;
        b=alz4yebychahOM7SoIysqAs5qQ8CU+D+By6qDvCKTPjD721OqPEtxtJcRVTKRnBW5c
         KN/38zlFmnKHu4PGe1H6ixFY8v3/c2BhAvmc8mAtiKqP3RE91FxdjEP49lrHF28xllVb
         TJlHsJCFQj4Xo4ObYlCX6Dr7o4e0QNWDOsJsQ9QNb5q4/yew2IYA6/cSj247/aYsg/wc
         uRNcJGjkaaOqCJiVh0QQ4HzMwfn00eXY6Hyrt4Hq1SOLYJjuI6qz60GHMTf7B8d1S7g6
         +eHO60r9jU4S2Ny4RmvAMgM8geM5TP1TU1BMRs445ljYiGU02Y54krjz4Ea6ZeohO9IE
         nZNg==
X-Forwarded-Encrypted: i=1; AJvYcCUwV5gHJf/Yh8r6PtTiNzW5TKrvL3FHxlJwUO6G0dPQYnB2Jvy/B9o+CARVZx2Lo72Egp9mHkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTxsH2gNKEK5qJo/vJiQvCxjhMg9L6rU8P3WPl8B76yWVJMnB
	3I7bMXaY/p3Y7i/fYlihp6seUIQCKvsGqRwEYc2MneJqzilksdXXJoJ/272tbJf5/WMTI8i042a
	TRQ==
X-Google-Smtp-Source: AGHT+IFMRINuT3JO84ktvwx/JXf2G4VgNPaO3sJJsL1cqLAvtapdb4dYJmi4mlrlNRrGxzPd+4aTdmn2mM0=
X-Received: from pjboe14.prod.google.com ([2002:a17:90b:394e:b0:2fc:e37d:85dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d47:b0:2f6:f32e:90ac
 with SMTP id 98e67ed59e1d1-306a6154f18mr5792179a91.11.1743801307592; Fri, 04
 Apr 2025 14:15:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:44 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-3-seanjc@google.com>
Subject: [PATCH 2/7] irqbypass: Drop superfluous might_sleep() annotations
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Drop superfluous might_sleep() annotations from irqbypass, mutex_lock()
provides all of the necessary tracking.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 080c706f3b01..28a4d933569a 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -90,8 +90,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return -EINVAL;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -136,8 +134,6 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -176,8 +172,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 	    !consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -222,8 +216,6 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 	if (!consumer->token)
 		return;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-- 
2.49.0.504.g3bcea36a83-goog


