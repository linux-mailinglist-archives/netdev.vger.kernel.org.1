Return-Path: <netdev+bounces-217433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DAFB38A62
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1245A205049
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045B2F8BDF;
	Wed, 27 Aug 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSvNYN3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237932F291D
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323682; cv=none; b=FVp1BxNYQPAx4OdyvQuOnGTMta4N9d6RPKR1dseOYVFXQOgoSt1ZGWr1pZECtwadyIUEboC/Y0VlxT3iYooB+DKXcy2vI64zj32laOkJCbSbC5SfC6aQ8XLG6Jqt7HV9J+7OjbZN1ln9iVzFfwzzIGOC0U4dfzpLK6asTXZ24EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323682; c=relaxed/simple;
	bh=lTJBUXa731wmAEkf8x8Aq275GNYxHtJHPWm/QJRsZcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YvP5uz6+P/5z3DgD3y+9wqMv9QruuMIfeHLiNfygl7qAR/r2tPAqOtF6WG1cTx9tZdDdWsydu0TDIUn9AdkiIKzwFjqfcpoBODq9hsb++fZSJyeD6CdpFEuHQI7+yWFYFkN6JEg0j+cDrO8SIWlPYcXFcOIs653GRDji67taZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSvNYN3N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-771f28ed113so179159b3a.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323679; x=1756928479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CAjH9n8kkSU88PuzJQYl+lvrDTSiqH/ka8e0rLGYB4Y=;
        b=XSvNYN3NiHj7sEVZF3XAAW0ZkXOrTD9c+GLnwNP4+LOAp7J1KZDqNfegtCsNb5xY2v
         ERt8u0/Yet6Au4WQs1H/LiIZLDwYtI5+1dQ6ZzgNT4qFuNqCo9oHX91Tp95Us4HXejMR
         DhjHr1hVNc6KiUNC5p3GA3tmGgzZv8bQNrGt3LRoc5vzbaEYLxGLfsNIuYYYzT/cNa+2
         4BeKfoAruzWVEyIcLW8VLpkHp3DXVkRx23v27AKV+FALcvd3bpXrIcSsXqaYRFi/KdNY
         R+eOMYe+PgYeZI4Pzwl7VQwHRa7SsmukCI2o0qn9ED8j75g4ExuM0JpWo+faw+uwQK12
         SahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323679; x=1756928479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAjH9n8kkSU88PuzJQYl+lvrDTSiqH/ka8e0rLGYB4Y=;
        b=Ll3hOQ6T/64P+8JNw4C8C4f1UoLix+5oD8RvaOov7/GijqpmAYwdHargRbcFpzpVvK
         x/P8hAepo3CMPjkZZDgV6JaXOXCOgQdxngMJJhCDN25SFvBmz/iAA+pUcTJ24IpYgZWA
         WNTSNwpcsEYDi6YwG132Gc6udKMM7VhcmabFhFxoJfYQgOuhwEyGFfArY/pxoa8s9Eya
         Uum8YTQRW5yP/bpM84n8j0H2UC+z7jenFlQtuFHCcVyYPu/ta3EKg0cug9SOGYSzVlUk
         45cuVNFTsT0ze9y/Tg3XagmEfuyME0Ope2mnT+3Wk8HpyHGF3T1dC7hdJHkwDOmDQLPY
         pXyA==
X-Forwarded-Encrypted: i=1; AJvYcCUMF+zoG6txBWP9Vd2pEEBLUlTwFruo3DpxSzWqODrJ3MnQXS1p5a+XDHi2T2+IU7ISG5Rgu4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KBB9LI2ygdsxnZtjDhgzgeGq7SFlHPvrCCUVEeLbIhaxBpL6
	nCgkCBEFJ7bPm4unC/QS8sMHXgVyQE+Ee/FqG0Njj6svRZX7UogdpvRl+LKp0humu+PnTrFnwQn
	VrU0Jqg==
X-Google-Smtp-Source: AGHT+IGn5ya0kUr/fIdsXYaCYO+ay+bA4LFPlBe/3Tzu+o9LmKU3qy0T5mYaH3gAWJMuIZiqZ0SiVacudbw=
X-Received: from pfbk11.prod.google.com ([2002:a05:6a00:b00b:b0:772:77e:bc4d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1399:b0:770:5544:dc0c
 with SMTP id d2e1a72fcca58-77055544aabmr20236423b3a.32.1756323679372; Wed, 27
 Aug 2025 12:41:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:07 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: x86/mmu: Don't register a sigkill callback for NX
 hugepage recovery tasks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Don't register a sigkill callback with vhost_task when creating NX hugepage
recovery threads now that said callback is optional.  In addition to
removing what is effectively dead code, not registering a sigkill "handler"
also guards against improper use of __vhost_task_wake().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..ace302137533 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7677,10 +7677,6 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm)
 	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
 
-static void kvm_nx_huge_page_recovery_worker_kill(void *data)
-{
-}
-
 static bool kvm_nx_huge_page_recovery_worker(void *data)
 {
 	struct kvm *kvm = data;
@@ -7713,8 +7709,7 @@ static int kvm_mmu_start_lpage_recovery(struct once *once)
 	struct vhost_task *nx_thread;
 
 	kvm->arch.nx_huge_page_last = get_jiffies_64();
-	nx_thread = vhost_task_create(kvm_nx_huge_page_recovery_worker,
-				      kvm_nx_huge_page_recovery_worker_kill,
+	nx_thread = vhost_task_create(kvm_nx_huge_page_recovery_worker, NULL,
 				      kvm, "kvm-nx-lpage-recovery");
 
 	if (IS_ERR(nx_thread))
-- 
2.51.0.268.g9569e192d0-goog


