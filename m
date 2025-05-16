Return-Path: <netdev+bounces-191206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E3EABA63B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985BF1B68387
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A22836A5;
	Fri, 16 May 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7kY1pKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECE2820A3
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436869; cv=none; b=VfmXuVHaXsZ7RFJOh7gTJG+gHZ6laI5KQeCReWabXiA9a//Uyyx0Q036dykcc7Oqg3mdYVpTw7p+MjKhhmtFpaMmZwrcZl+oVQOZTe7gVAlgWjdu/zKD5kBT2i7qJlasHNDsiT/V2vEtsIySloqasHpGRZJb5jHs5Q9R27lFjsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436869; c=relaxed/simple;
	bh=9fbaq6CwF6vLyggy/XV/8/w2/CV/cudq3CDw85TXlSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njWriK2u0OKtaY1j5GhCCutcT2WM/xVQaaedvYkq2nbvuJMmP5pRWh1mdadZJYtLubC3jJUan+Er4SdVUO1m8CXAGjkfSrADChihQ6+Xf+xmcd8gw2uH9UVxLkxfgfHia9zGOJRM7D3DKKAU8CuLjMq8zFwuRIhabpUFtXGalzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7kY1pKJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e0fee53eso1353108a12.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436867; x=1748041667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oe5thiWbXg0oQhkHd+uP+1sLcx+Gwe9eK60YPiQS+Fw=;
        b=Y7kY1pKJnFIDf1qHpybNFR4/E0j2z6oX/y1xW/ATRroSbZ7hmZEXBf7/eOhY5NkUh2
         +Du3R2D7tR7Ik4wNPhgmPsyoAnYraDYJ1bCF4uyUlMe9Cmqq9NE0DY/x+2gyfrEMGajP
         xKMdIU9yKF1JxoRWSWgxGAi7tx8L6IvSYf3Z16VLOqVskEGpboSEzwHlDJA6yKGicWxq
         FrPV4EIJ+ATB5o/ziDxtPibMBDQCe3MDenYxenI7R1ecDlmoCaoGXlpFpFB93+fHxYZO
         SblxSlI3Llr9mBmdJag2fLpy8fz2mhgEvAmBzkBfPh1F7uG6Vw50qajc4eRllUka3t/W
         vaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436867; x=1748041667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe5thiWbXg0oQhkHd+uP+1sLcx+Gwe9eK60YPiQS+Fw=;
        b=NO9RAbi34IcGux/xJHXqkMBpQmbRlx9Gl4REgM8ZGH1d+0TkbnQ9RQjGZINbJmNTG6
         ir0oUrzewepC0s/O6xRng64KXdpnwkilevA6Y9ivvSymsVAA4cPM8bWkS4LFoL4mkM42
         PLXwMm/bbPR0P7mEFcw8fG73fZFRL3skQHvxDlOHnL31CgPtPDLXl75MVqOPl7jjN2Jx
         +vDx+cKLoVvaKCwYsaeKFOnMmDe1r5r6NzMfAW0hTt1ocUSEiI/VLcw3Y+GZdDGfLBDC
         wtLde6BA7IVjvH7GN9l2DxUd4m+M5gAmMdZdG7V4FFiXdXI8Op3zF4tM9WqeYMEuONoo
         wy3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3MBAINn3AUWaFCOKamMggiwoQaq4ycqGUs/QyivTmmNnC5DQS3Re5Q+osTXqQLHvM3yA8yhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC85v/MIiwhPV9Zx5FTdOM0pL0PdD8HUEzgwqkMwFniGES4Gt1
	/wxXr1oPfKHK6l7nxSBGdy4PvQA8NP2vjvQIDuOgJZdtRZVJsmj6hLHsWTBXq2zWz00lMYk1Cre
	aawgCYA==
X-Google-Smtp-Source: AGHT+IGwhN0lFa7qi9dcKhCQf1tbewsw4jw8vfokJ04Lk3TJnvb2OFxjdzkHkOC3oXEw4fYXmMusrSpK3XA=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2fc:2ee0:d38a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f96:b0:1f5:7280:1cf2
 with SMTP id adf61e73a8af0-2170cc66b99mr5833370637.12.1747436867484; Fri, 16
 May 2025 16:07:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:31 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-6-seanjc@google.com>
Subject: [PATCH v2 5/8] irqbypass: Use paired consumer/producer to disconnect
 during unregister
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Use the paired consumer/producer information to disconnect IRQ bypass
producers/consumers in O(1) time (ignoring the cost of __disconnect()).

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 48 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index fdbf7ecc0c21..6a183459dc44 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -138,32 +138,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
  */
 void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 {
-	struct irq_bypass_producer *tmp;
-	struct irq_bypass_consumer *consumer;
-
 	if (!producer->eventfd)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->eventfd != producer->eventfd)
-			continue;
+	if (producer->consumer)
+		__disconnect(producer, producer->consumer);
 
-		list_for_each_entry(consumer, &consumers, node) {
-			if (consumer->eventfd == producer->eventfd) {
-				WARN_ON_ONCE(producer->consumer != consumer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		producer->eventfd = NULL;
-		list_del(&producer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(producer->eventfd);
+	producer->eventfd = NULL;
+	list_del(&producer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
@@ -228,32 +212,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
  */
 void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 {
-	struct irq_bypass_consumer *tmp;
-	struct irq_bypass_producer *producer;
-
 	if (!consumer->eventfd)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp != consumer)
-			continue;
+	if (consumer->producer)
+		__disconnect(consumer->producer, consumer);
 
-		list_for_each_entry(producer, &producers, node) {
-			if (producer->eventfd == consumer->eventfd) {
-				WARN_ON_ONCE(consumer->producer != producer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		consumer->eventfd = NULL;
-		list_del(&consumer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(consumer->eventfd);
+	consumer->eventfd = NULL;
+	list_del(&consumer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.1112.g889b7c5bd8-goog


