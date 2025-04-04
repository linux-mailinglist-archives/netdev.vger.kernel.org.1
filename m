Return-Path: <netdev+bounces-179388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440DA7C556
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F73D3ADD3C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E20821D5B1;
	Fri,  4 Apr 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfOsY+J3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157521507F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801308; cv=none; b=NIGJmPdFjK/u7w3tBxHpl27g7Bv7XCYj62waapLcMiYxxyLT/7PUCVnhRF59yJSunXLzczMwYgFxo0vg83Lx9ap0Uoun2NNwuq11FtoojiTEm+ZR9yZgcQ0I27VTx6pZ2L1dFmfk6N1eneHTExQo4jfPb1m9LDaFrg01EcXhfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801308; c=relaxed/simple;
	bh=3eQJAa9cubM3sOJ48FmMAgTG/qqYFR22T28SrTWB6pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=txU/Nx/16FdOk4jtMi0SDP1GJlEDF/Au6HV/zdkygHMC5eDnkQBp7KIBIB127F8xRemmCMOKy/Rqvn2Oc10bAE/hVQWEJfhWk6uZSbEa1jZBhGzmSqJWc5GUI23V/By6fmrzcR8KYVVJ6sWNxEnCKLx4TIu5ECy9pJsJPlkiCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfOsY+J3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227a8cdd272so22374335ad.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801306; x=1744406106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BV0n160bdAMJIwF9gIdsee0gSXMixk7gnYOIwMBSkTY=;
        b=EfOsY+J3Evu+cdhO1HPL7EDI03ImmRIYF1A7PuHvIEFMhk5UvDwD522hXpb0XwDHJW
         nzvVcLngrduWzo7d9x+x0diqFCq6iGo9FFNuEWI+86kSKSKTHx/sOLEt0M4cW+brQVBY
         uiroOjTm5+Jiwia87wnXKX+5bWN+/mawF9sfZJhrEm+Xy5wHM6vvJsuVtud1J5bB6XKg
         pOaLmA91rZv6OWfZDHKcPap1yWOIqTCrvDuIgW77EtiiKOcjoBo8WhiHT7pvUAcvfjnm
         /BaoeKPccn0D7xL6mdd3bGO2S5CN8leinwGIfALc5NfI0OE7NFyXQ8IhNndIauMeDX+f
         3Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801306; x=1744406106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV0n160bdAMJIwF9gIdsee0gSXMixk7gnYOIwMBSkTY=;
        b=XD/p4u84Q4DnjXo2Rtq7C/ghh4ZElNSyNOr7mBC+jXM6GtMz3nS1sfvv+P0TyVG3JG
         Idn2SuSalBuEaNGreXN5okaPxIiNUmdioHY4aOIXa0fpvaiWWzIw9DIu+NS3c5o201p+
         M5ok9+VUYsd+HznbBEWwnSMofXrHKV7BOJ/QGRg7cGkSPtMqxRANWymuuyfH3Up/P2uW
         hp6KTUPo6JFzBnMREANAl8nTbgMEtgMnR7Sgzdd2eFCgY+hpQ6oqBw2qliPwCB3p7zKo
         AGlnvwZw91+WUTtR7s6dtc3pvqOp5/ZjrdSfeWaMtqeKBgjVmJkPbq5aMoOzpCUEsnrO
         /BnA==
X-Forwarded-Encrypted: i=1; AJvYcCVLSaYy4E4Obj8doMWMTalCZKdpUfCcU3p+H1J/8ss2Ww5KES6PT8dC5QEQHMPRCLuiNC85swk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQmDkqN4MfNcAROpSFPsjP0HgsDF05J6Ptczl4l6E/SJ1pyjo
	S1v8QcGKZZbvjA7guLIDKFM+vspoPiIkzWKGxgbZkle0fnxIsbfZ4l3otxVxsgU1EblxqR2Pubn
	hkw==
X-Google-Smtp-Source: AGHT+IHGnE8XslHm/Dp26htMuuamh5CyH4BkTccpSE3E94306LmR6+QWCeFh1nKaosRJPLYDlX1yhMluHf0=
X-Received: from pfcf1.prod.google.com ([2002:a05:6a00:2381:b0:732:858a:729f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:224:255b:c932
 with SMTP id d9443c01a7336-22a8a04a526mr44725315ad.3.1743801305822; Fri, 04
 Apr 2025 14:15:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:43 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-2-seanjc@google.com>
Subject: [PATCH 1/7] irqbypass: Drop pointless and misleading THIS_MODULE get/put
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Drop irqbypass.ko's superfluous and misleading get/put calls on
THIS_MODULE.  A module taking a reference to itself is useless; no amount
of checks will prevent doom and destruction if the caller hasn't already
guaranteed the liveliness of the module (this goes for any module).  E.g.
if try_module_get() fails because irqbypass.ko is being unloaded, then the
kernel has already hit a use-after-free by virtue of executing code whose
lifecycle is tied to irqbypass.ko.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 28fda42e471b..080c706f3b01 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -92,9 +92,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -120,7 +117,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 	return 0;
 out_err:
 	mutex_unlock(&lock);
-	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
@@ -142,9 +138,6 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return; /* nothing in the list anyway */
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -159,13 +152,10 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 		}
 
 		list_del(&producer->node);
-		module_put(THIS_MODULE);
 		break;
 	}
 
 	mutex_unlock(&lock);
-
-	module_put(THIS_MODULE);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
 
@@ -188,9 +178,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -216,7 +203,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 	return 0;
 out_err:
 	mutex_unlock(&lock);
-	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
@@ -238,9 +224,6 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return; /* nothing in the list anyway */
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -255,12 +238,9 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 		}
 
 		list_del(&consumer->node);
-		module_put(THIS_MODULE);
 		break;
 	}
 
 	mutex_unlock(&lock);
-
-	module_put(THIS_MODULE);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog


