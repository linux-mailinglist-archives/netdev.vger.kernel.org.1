Return-Path: <netdev+bounces-179393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22368A7C56B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08913BC83B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892522256C;
	Fri,  4 Apr 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g73MrNpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237992222A2
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801316; cv=none; b=bDy/rojHI2zqBwYEuh9GnzJdUY6UzarTTcPkNRs1/KJHhGF0SIM+ITWFQOBi2LROGB6I+9s6n+msKsEbHoxt/M2zJ/Sx80VjMgOXuiDNmEXu07mXA+uz22ivYzEwZ3NssA6pp2+C660iK/zo25t9qlVU3Q5A8BmcsggM/lRNqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801316; c=relaxed/simple;
	bh=v2ORapDpafgERkpHUzPjtrfKBhCT/RFfLsP2a6B2+4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BclMzSgNxnbwHy8mDu0ptOy8QLW0qFCyn0a9KM3NbUMVyhk/f1VYTCNFHVaSyHJirZhApaUVxNATCAwFwVEEFpJmLu+xhIBRDtRztNxyYmWmYT4FmGygMsjUWqjZcOl/DDcfYMefA/ApGFujSl2v6pJ+A8FYRbUVtPujYIgcYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g73MrNpI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736bf7eb149so1831236b3a.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801314; x=1744406114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ucS1cIhi1yvIAjPfmLIaKa4ZPwFGctQlvybswzj8SS0=;
        b=g73MrNpIqjV6llDwzck5xMyNaPj+gJCrxdjKFGua1JJ3npcyJpsbbWxC4A349jzGi6
         72+JzYcEhzsvr7UFvPAv1ZqhBAN6aHInFev+F1bIm+M3BSpiLxgwTk+3NljVbHQ/j8w8
         W0Zlsuu+o5IP4K7IwssqHsg3gtUZOdC+z2y3TVvp936zJF5HnQuxrfUjTKJ9RS5ysnEl
         1q1Y+99Cu0ltzA5x6VxCLF9ax+3Hk/gngRFckSYb3oqfKaUw9PJ7qACWDxZ/Zw19skgw
         KhbUzUsMtQtbO14ofmCTgsyXLZbUGHRYAzdKCDZyRthE1cJAtTS84s7SpbCgG2X3SUkx
         hM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801314; x=1744406114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucS1cIhi1yvIAjPfmLIaKa4ZPwFGctQlvybswzj8SS0=;
        b=Au+daRSZ1yjI3zY8B1XjNMm3oTmKacDegkSUxQUzNPJWE4kp/OOu9rgSCSM9A1HgxL
         EePdOKxBE6c37msvQ03mU2pEUSH42yXujryEeGCxfSCdhniWWMAyC8cDbj7nj9l0FTI+
         crt/OGMM4S6E88Z6ZY6OxqZupykxeN8tMKBHOxo65QIs8331Pupmk+owLakEyncMIYmp
         2GN1lCRuGp2b6kHbbf1VDdy2dbMc9fJ5d77nDHYMBUzT7c/3cJz+SRq13J3iiaoi13Sd
         OOHK0RgYAa9sMwpgCeZ+e6Qk4K0gqLkj2w+VZ6P5D5PtUSKj5NgdYQHb+4WCKC63L/lJ
         3NPw==
X-Forwarded-Encrypted: i=1; AJvYcCVPW7yYr9lNQyrbfeeeK3dClq02PdHvCTysQhoPANDkkzf0B251CluqGlenjPO8++l0FOZdXDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnH/Yzhbky3C3l6jvKhO/fgkaZbo1eTwW8QHlx2ncLdPBLkbI
	li94us3aLV6Dhk3MnQrSmzjUqgXG4I7koaHv+pOQ3aPXi5EZlCJnf+T0TsIbJEG58wS6o7gs5V+
	LfA==
X-Google-Smtp-Source: AGHT+IEDdhL+lnjtcVL1Ed1bGzXYhiIsJzjfh13+tnkRQcRgpIirVPKBZIbe1qE7JT7XC/jfJQDJSp2S8E0=
X-Received: from pjbqn8.prod.google.com ([2002:a17:90b:3d48:b0:2fa:1803:2f9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cd0:b0:2ff:784b:ffe
 with SMTP id 98e67ed59e1d1-306af71b814mr1108191a91.11.1743801314494; Fri, 04
 Apr 2025 14:15:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:48 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-7-seanjc@google.com>
Subject: [PATCH 6/7] irqbypass: Use guard(mutex) in lieu of manual lock+unlock
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Use guard(mutex) to clean up irqbypass's error handling.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 6d68a0f71dd9..261ef77f6364 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -99,33 +99,25 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer,
 	if (WARN_ON_ONCE(producer->token))
 		return -EINVAL;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->token == eventfd) {
-			ret = -EBUSY;
-			goto out_err;
-		}
+		if (tmp->token == eventfd)
+			return -EBUSY;
 	}
 
 	list_for_each_entry(consumer, &consumers, node) {
 		if (consumer->token == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
-				goto out_err;
+				return ret;
 			break;
 		}
 	}
 
 	producer->token = eventfd;
 	list_add(&producer->node, &producers);
-
-	mutex_unlock(&lock);
-
 	return 0;
-out_err:
-	mutex_unlock(&lock);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
 
@@ -141,14 +133,13 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	if (producer->consumer)
 		__disconnect(producer, producer->consumer);
 
 	producer->token = NULL;
 	list_del(&producer->node);
-	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
 
@@ -171,33 +162,25 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
 	if (!consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp->token == eventfd || tmp == consumer) {
-			ret = -EBUSY;
-			goto out_err;
-		}
+		if (tmp->token == eventfd || tmp == consumer)
+			return -EBUSY;
 	}
 
 	list_for_each_entry(producer, &producers, node) {
 		if (producer->token == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
-				goto out_err;
+				return ret;
 			break;
 		}
 	}
 
 	consumer->token = eventfd;
 	list_add(&consumer->node, &consumers);
-
-	mutex_unlock(&lock);
-
 	return 0;
-out_err:
-	mutex_unlock(&lock);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
 
@@ -213,13 +196,12 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 	if (!consumer->token)
 		return;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	if (consumer->producer)
 		__disconnect(consumer->producer, consumer);
 
 	consumer->token = NULL;
 	list_del(&consumer->node);
-	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog


