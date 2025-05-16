Return-Path: <netdev+bounces-191202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE9ABA630
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6135A06BA5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A63280CE0;
	Fri, 16 May 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3VauYOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA628031F
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436862; cv=none; b=EEjx0kNRbR1RW+RrM2SyKOnIAgDV2adOks3xR8gp+Y9fuRAtb/iO9MQ7TN6SQdB+LapUrFUf/XbWmWK84dHRns+MMWXHbC1g64Jdv1C1oVJ7fuvf0gEtsd/OEhwEMQ9t3gs668qba9vkSLmVrlXx5e7fgV9mOPiSyMHzOaqQQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436862; c=relaxed/simple;
	bh=I1ALcWIwC8w2ZTqFEjmPzQUw5bLz7mdjqS6Qdf0kmJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tf3dc0V3vmybjWmeNtxQvla9fWHuUngL2Z4hytWVAdpD6E5Y9MkK48LAbxT29xLyhqMCHide8sSKzzmajGnF9RlY6S4gKqkXYEPKzpMI9KFXptzvqNWvoiZPzAV5/0IdbaOXHO+QdQJ1Ba/IcqieMwbwoHfWzWJqTkFj3ApUF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3VauYOt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1f71ae2181so1644936a12.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436859; x=1748041659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8kDa/puR8zC/TVy/ii11k+vGNrXdae9yxfqU/1udF6g=;
        b=q3VauYOtN04RZ0hh3sol0uU4/jLOh+yA68XJ3uItKyLT3IGd+IUTszJX85M7o6zT0D
         7qy0tqgNdqvp1wmKi2BFS+nrWhz4T0xENqoVxul4ie15EgDjHQij82WJa/3Z1IB4PT7V
         rT8v+FuB8kKWm2gxY70LBr7Br2/n95XjlOV9kVGaUDbPS5vaxCttCDLJ1TFmX6j/g7OC
         0I17Ed9BzisZ1vSGkvxDzJmZN8rFAYUqeSRDCtz3qE/jZgzeKU687JXaGKnp/BuV6eCq
         amyWSsLC908LB5kFMPQtclFcR/1whoRqCGHVG67bUjTwOweZ/N+3j8pM8JsQhLG5pmVh
         mTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436859; x=1748041659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kDa/puR8zC/TVy/ii11k+vGNrXdae9yxfqU/1udF6g=;
        b=fyINdYvdSf15jzuCQNrw1dbXffhIKzizfD0/ku5CUxjsTHN6pIRKLxGwa0PeqQLisP
         U+4k6G8KsprNat/iokY9wTdIE2HghYDLkKV3wHkt3nb8fLb2Wvc/Gld2bXs6cc6czADU
         +f7dOmadZmeS0Ri8dXUYmxQ5abpfKn+SLVXIgscvZG16hXyleEnHJ38ie5DzPF95/HX7
         /FiD4xm00DeY0oYpAvINpyhCZmJhA9NFVMnIdt4WGVSm1aswUtzscm8y0jIAz1H0m3Co
         nTOGKhziVhuX2vc2qLIq0musHjF57WDqEhkcDDxOhwLGjQSWzksMjSH+AcrHDBTijoOE
         PqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCURKy+UCWuoHz3NKTkEnWh7fF9tCCf1qvTJqBH+zVQEdiDmL6BRyF54VvyLpUPeIxWnodco1Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBJyS05ETJdmsNqnU4sQfy89aisSKwTW33Ea0ElliKF2JLp8W
	FQHg0ieKiFQtsKY1MB//62/VNkXqmgyZwtrPdCCM8J//ikaiJ51DsXlgIXuymuOZdYXPJVIfvFU
	pZzu6gA==
X-Google-Smtp-Source: AGHT+IGms52EOzdUpeUySel370WkLvf5qcqXwBrssv6N0gEIpnS2oZ+4XnP+3IKYtmrBjEsQ2ftNzRdpjys=
X-Received: from pjbsb5.prod.google.com ([2002:a17:90b:50c5:b0:301:2679:9d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8e:b0:301:1bce:c255
 with SMTP id 98e67ed59e1d1-30e7d5a93bamr7142197a91.27.1747436859419; Fri, 16
 May 2025 16:07:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:27 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-2-seanjc@google.com>
Subject: [PATCH v2 1/8] irqbypass: Drop pointless and misleading THIS_MODULE get/put
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

Drop irqbypass.ko's superfluous and misleading get/put calls on
THIS_MODULE.  A module taking a reference to itself is useless; no amount
of checks will prevent doom and destruction if the caller hasn't already
guaranteed the liveliness of the module (this goes for any module).  E.g.
if try_module_get() fails because irqbypass.ko is being unloaded, then the
kernel has already hit a use-after-free by virtue of executing code whose
lifecycle is tied to irqbypass.ko.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
2.49.0.1112.g889b7c5bd8-goog


