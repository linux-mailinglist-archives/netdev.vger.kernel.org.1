Return-Path: <netdev+bounces-191203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BCABA633
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C767B9E11
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C70628135A;
	Fri, 16 May 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SJwF6jV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CED28033C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436863; cv=none; b=lCcRMF3b2qwTovZTVG6B282Nk9Gq3PY70O7oCi0VU4k8vygpY2FyoSzAIX4kBlCPUmrar4GN9TkxTCB1v6vgtSnHnBZLaXDJyOcN+XGLurR850/JHqXLlu/iDRAxLfFwltZBSR8wh/fcwfv/Q7hChlWQM23PbVR4hOKZx0Fql6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436863; c=relaxed/simple;
	bh=53lKZIp0QEDIxAnbUsZj0HBAIqsGZWy+CnuC9aywW/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pWciLXriy0UwUuxf2a+Jnu1aNzo9feP0s8bDoAEy1/tKAP530IyvAuaBDTKxY73lYpZzir3HlAEGn+saX4rr3Ul7HUKNIaWBneVPmiuEB1CC7XDgvNNQ4TlFJpHpHKnIrOatXE8wNTlfHLV7Vv13vgGGTjsppvoy6tylHRjjW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SJwF6jV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740270e168aso2422454b3a.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436861; x=1748041661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NfgqeidfxQ2kyf1sJo8U3YZ4JNEzadROFUB65CCKoYo=;
        b=1SJwF6jVGsvJoqd7rhdiq8l+du2JROSxasleJXx2a1zJBqZXLji5/fkOVoQd8NqSxH
         pNbdrk+mTqX9TtvCsHE9HjJx4j4svaV/P+xtnm5hvPCBHWSCe+8YF0ryxYnvVk396c7P
         HqRhRQUNx4qcWu4S8rhczJaraF8RFGo49QbbzrwurKLMl/mra89bohu8veF+4h79eTtg
         aRCSabpnOqgoyKNFKPk+nuxLMYD3KSBxT7XUxuY/37Txi6a9jsNwgpHMKs6QCiP74kor
         hQtv0ZfL9YKNKqgbmc27MPeh6w3DYczy0gSFLlu1Sw4zg+pwyaniaaaC29hA6smVkhGk
         1gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436861; x=1748041661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfgqeidfxQ2kyf1sJo8U3YZ4JNEzadROFUB65CCKoYo=;
        b=Fr1ulazSpMa+t1UlJfm3fLQlUBFjkyMJ5ykt4+wwlMfptbL1c9Z+i2QnqyR31gZhYc
         vzaQyzTs46HD4DjivOaB/hZG0eg0eEi+l0Wh/lJ7tg+8q/ypBlWXQBJGmHkFUCwIeqMw
         u6PbbdjXjcw8PJ+jspznpvUkuMZvTx2AhEHTfY6unaK9A29W7PA8EJxjfhbIxFliWzZL
         LSZKy34xLMZ+KGWH9QKjNKzVwfwowONdKq1anPIaO32bILt6B9CYouFWXknjPebJ82S6
         DFL/Fz+TcYJr+FUz9FXhlW9VdhaBosqOzvM8VBabDB/O5PZWD3HzbClqHlsRHo3Oz494
         dV2w==
X-Forwarded-Encrypted: i=1; AJvYcCXAxjVXBafS/xPRSxBjmTZahz63yMjNaS/2NAfOuyGUUAKy1EwYbmWf8M84PJ506/IxCadOZdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUHnl7ZRx2N0qVbktaOW9f1eCCygcAeuOm7xnQ0VnJURKVTd2
	meG3i+HQm5yrxfCJ6coy1URXKpdfx1lYgNoI4n2vFhaFfmnPavcg0NEgRPwBMgzdTYMbq7oNZvS
	j5l8wlA==
X-Google-Smtp-Source: AGHT+IEpuk3JhFswrcOYHhuNZFtNFDjaC6SxgeOCtP19MsiXoVMuiAOEkn9SRzfq0mcswFVBZevjQHeWqN0=
X-Received: from pfst15.prod.google.com ([2002:aa7:8f8f:0:b0:742:aa0f:2420])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac6:b0:736:32d2:aa8e
 with SMTP id d2e1a72fcca58-742a97a16bbmr6249072b3a.6.1747436860987; Fri, 16
 May 2025 16:07:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:28 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-3-seanjc@google.com>
Subject: [PATCH v2 2/8] irqbypass: Drop superfluous might_sleep() annotations
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

Drop superfluous might_sleep() annotations from irqbypass, mutex_lock()
provides all of the necessary tracking.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
2.49.0.1112.g889b7c5bd8-goog


