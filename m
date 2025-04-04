Return-Path: <netdev+bounces-179392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D03A7C56A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F03F17C2C9
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92C2222AA;
	Fri,  4 Apr 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyGi+dNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED4219A9D
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801315; cv=none; b=lvH9AwWm7yPqVqlagWq1iLG+2gQradPCDkgRbaJAlboRQdmVoTnYJb/j6Oj8ZsuZ95bE998leQjURCrD38+06dUGnSgmLobRxM17SF/trHXvRGyiea/ddzN93ndPiI5raT58moVZN9cPEO9dDgCst5D9B3wrmXKUhJb3Guuc5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801315; c=relaxed/simple;
	bh=R8NuUhmI02N5n1m2zQQJmYcq/tgo+PabOiQg+/IuxGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AsZ2HjXfm1mDhDmnqLglOeyyciuuxlJ0em13K1UbonN8M49u/hC7lno/MKAMaSiMuToIF1yCyvIij0o0j3GaKDm1ANrvh94W3vhf9nRMsNyBCvGCS6ZG5Y2AsncdKH5nNxaLId3pYM6CKj7qrHP/dPu7OuWBGeppU3pDZdwXXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyGi+dNm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736d30d2570so2196281b3a.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801313; x=1744406113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+c3CamxlMu4cATASgv0Iy6Lf5d+wt8ucP9dRv+3+Crg=;
        b=RyGi+dNmo0BgsZBqodEkGGcqn0l+ZJrVdlX7al2r9GPIi19p6iyazBVfXdySUcHaEl
         zOEoHdJpGRcaJTnYuAN5JmIiHHJz7M2q48GfsBGM9IOqtNWW74TxTXydWrQ3nAK5L8gq
         cAUsWSrFsiVwL1U/ucLoqqoftVTzb//eb3UuZPJP2uj7zkYFxV2g/6zHBTIT8Zy/+t2v
         Pq/ltO/mVHbKWO1zBGF7cl9KmqurvTNyjin4K0lhN2WBifk4qY2FSBNQSMWiuFvcM/nV
         VHZBXV3EqBtZ0LrluCHA61GI38r2D4MHjzVc2PGZrNzmoiop9U4vTS1V7N3L5QAP4VH2
         u5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801313; x=1744406113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c3CamxlMu4cATASgv0Iy6Lf5d+wt8ucP9dRv+3+Crg=;
        b=HbXQWbTZUoeoOwKAfLoHWeDn6ArNKON5evu1NQ6u3sKpsJirTwUgf+XwiZuq594vOj
         HIoMfWiA5JEXg/2+kNlbA4pk7fDXqY64LV8yWS938L335hvEkL8WwvGuzPh2saPkdNa5
         4fWsdBt3JOaPwyuGejuqwEmPfN6RlPn7Qiqg/oi3Crn8Q30IZ3YK3yxWZY4BM3wiKlXf
         i6WAb4FaNtAz3eruKirGsiHI6lh584m3oRFJEjiZFdKH7Y0hGFGXUrIeoFihwm9WM0mx
         a0cjT9cIErmxrDXN4wxz4KBNoYfMTnjuasS+Fv/ubr673o1osPLOrBmBLSXOBcP00epx
         8xJA==
X-Forwarded-Encrypted: i=1; AJvYcCUZl2a8suN9v6yCo14TG734Qnq9EJoOgfB5Dy5L+Ouqkei/yOOCygmtvqOrYPsw/5SJ4GAR2YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzetq2UqmcWSGpFgSjrxQNaVDFIXx5Pq1TN0ZGQ9jJ4CO/BCond
	cvXnYwK2qHUxDk6LWDTY9XBMsqgYH8mD4bIm8rJ/1LkcItig8+ultAAAagEm/npKUMZ1ufmSqJ2
	8RQ==
X-Google-Smtp-Source: AGHT+IF1tacFrLaohc7CkMS1gtWVWkDqbIHHrrY0gCvWvfr9O5duisiiz3XdJWCovxvuLreYisa8S4H6eT8=
X-Received: from pfbhg1.prod.google.com ([2002:a05:6a00:8601:b0:736:3d80:706e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a2:b0:1f5:75a9:5257
 with SMTP id adf61e73a8af0-20113c57dfcmr1150484637.13.1743801312641; Fri, 04
 Apr 2025 14:15:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:47 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-6-seanjc@google.com>
Subject: [PATCH 5/7] irqbypass: Use paired consumer/producer to disconnect
 during unregister
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Use the paired consumer/producer information to disconnect IRQ bypass
producers/consumers in O(1) time (ignoring the cost of __disconnect()).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 50 +++++++-------------------------------------
 1 file changed, 8 insertions(+), 42 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 4c912c30b7e6..6d68a0f71dd9 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -138,32 +138,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
  */
 void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 {
-	struct irq_bypass_producer *tmp;
-	struct irq_bypass_consumer *consumer;
-
 	if (!producer->token)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->token != producer->token)
-			continue;
+	if (producer->consumer)
+		__disconnect(producer, producer->consumer);
 
-		list_for_each_entry(consumer, &consumers, node) {
-			if (consumer->token == producer->token) {
-				WARN_ON_ONCE(producer->consumer != consumer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		producer->token = NULL;
-		list_del(&producer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(producer->token);
+	producer->token = NULL;
+	list_del(&producer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
@@ -173,8 +157,6 @@ EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
  * @consumer: pointer to consumer structure
  * @eventfd: pointer to the eventfd context associated with the consumer
  *
- * Add the provided IRQ consumer to the list of consumers and connect
- * with any matching token found on the IRQ producer list.
  */
 int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
 				 struct eventfd_ctx *eventfd)
@@ -228,32 +210,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
  */
 void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 {
-	struct irq_bypass_consumer *tmp;
-	struct irq_bypass_producer *producer;
-
 	if (!consumer->token)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp != consumer)
-			continue;
+	if (consumer->producer)
+		__disconnect(consumer->producer, consumer);
 
-		list_for_each_entry(producer, &producers, node) {
-			if (producer->token == consumer->token) {
-				WARN_ON_ONCE(consumer->producer != producer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		consumer->token = NULL;
-		list_del(&consumer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(consumer->token);
+	consumer->token = NULL;
+	list_del(&consumer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog


