Return-Path: <netdev+bounces-200811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA18AE6FDB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7711895080
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2002EB5D2;
	Tue, 24 Jun 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J61/Gy9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F952E8899
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794072; cv=none; b=oPJW8oPlG2A0g756HHVh/mU2h2wJqxq7sIouP7vy1jIrS47M8tF4Cu/NT85wHEHH41/8PXhn1J77AwqR0kLbVf6L9a8ePGP9JZdrCvnmLpXE5lAVj/5P+vNc6OhvwBqVCa2FIUEkB+u49vzl6JyYsgp7jCIrWkfZjbqMOKvw+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794072; c=relaxed/simple;
	bh=XKWkUMZVzA+dBYCVPpvxIgaKdkXs4N/J7Rl8dOvJVz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+SV02fnK/jJmF/GVrPVwnjnXZxdPzEsXALSRn97DMnvO0yGGhbS7ovkPKp4v45grmCO3Hduf7nIsoXZShHK1vGcG3fQbyYFfzT01EF3SItnsQodyG+GEvtS6eicciFTVUIeTLmchNMd+4W5rv5qzewm6pTflXP2ra8cR+w40GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J61/Gy9q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74927be2ec0so4511969b3a.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794069; x=1751398869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXiP320Rk+IeNYwcDV4nPbIgqWo0YYn3LIURX0sKo4U=;
        b=J61/Gy9qKuFITkCnkJfsUCdOtb0wez6ao33eCNrOz3QA9deST3Wz58EDgCZUTX8VOf
         U/b9+2KRemW9fd0nYGbmMNAMY1mpj0xZcATPfpLFVljeK8i2jssYF0JodpnE5oOuX265
         LG+QC/xu6KuCswec+Sy1+PFWYqh1npHeU9MSj36VqxciCkLg4IwxHTpnzavufuHPgzGj
         VgnoveuemnXc2U55F8TdV8LDcWT2U6cEen+wj6/RH0NPr18wD6oQMNLCfxB3d8HWiYiV
         OajE37G2c+qouOZOtnx3GW1Sl3AsOWT7R/u2mqfvb//CQ9qELWT6c4CvjGMf0IXMqAUL
         XYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794069; x=1751398869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXiP320Rk+IeNYwcDV4nPbIgqWo0YYn3LIURX0sKo4U=;
        b=UgZOpmF0kz362qNeAF5xD7eJP3yLQeEEgJpGKBEpGVW7ixO1/wLCR4ry8MNPUUO3MF
         qWs0QMsQMhc8C/5dlf7mK7oaIw6O9o/PXugYVxqQS8kIq5JsaR6Yd2PboMhVFXazL1Pa
         rzFNkLSRE3cet8pPXzx/GLy2/oCS4zaYjJZq9Rvoe9ZzMMmEU1YvJECATUrRED7hfOtG
         yN+T00to45tp2niNfOzl7SUE2DjhIbgInULHgqmobpcQb0h9cl8ZhWSay0Ct940+fBsd
         Ryj5TSxkptMb0fJriAqX1lazSsZa6ckBktaztNpOIKpiY2bOyLnzJEYyYOpJufkBHVUp
         SxRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWH7f8jUXq8LUFa+psYdrMSS9eQqiXhcuzNBHSxK8RV5wZ1Rg3TEFU7NenAZCb7ItviHXSeqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDJmAGf06lK5JPfRLK8ShjGFPJ+TNNqDwtKjcaGwxg8UmDDyY
	yUJQFPYXIyxa0iQC1ytNvJKsREJ1RJfpWXZvFhwlo6haJAfDAP6rI0skE6GUuH8oUWpjziCiCCf
	cUj4nSg==
X-Google-Smtp-Source: AGHT+IF4iAyO0/jtdeTd/8bHHz1AfSHJa1kRLTY1ZYhbBi7eks2S0+pU5J68NpHqGCPbGgybwZERsmzdGEo=
X-Received: from pfx28.prod.google.com ([2002:a05:6a00:a45c:b0:747:a9de:9998])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ac6:b0:740:aa33:c6f8
 with SMTP id d2e1a72fcca58-74ad448fdfcmr481317b3a.7.1750794068977; Tue, 24
 Jun 2025 12:41:08 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:24 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079266935.516926.16732685121513755333.b4-ty@google.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 16 May 2025 16:07:26 -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a very simple concept (device signals
> eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> 
> [...]

Applied to kvm-x86 irqs, thanks!

[1/8] irqbypass: Drop pointless and misleading THIS_MODULE get/put
      https://github.com/kvm-x86/linux/commit/fa079a0616ed
[2/8] irqbypass: Drop superfluous might_sleep() annotations
      https://github.com/kvm-x86/linux/commit/07fbc83c0152
[3/8] irqbypass: Take ownership of producer/consumer token tracking
      https://github.com/kvm-x86/linux/commit/2b521d86ee80
[4/8] irqbypass: Explicitly track producer and consumer bindings
      https://github.com/kvm-x86/linux/commit/add57f493e08
[5/8] irqbypass: Use paired consumer/producer to disconnect during unregister
      https://github.com/kvm-x86/linux/commit/5d7dbdce388b
[6/8] irqbypass: Use guard(mutex) in lieu of manual lock+unlock
      https://github.com/kvm-x86/linux/commit/46a4bfd0ae48
[7/8] irqbypass: Use xarray to track producers and consumers
      https://github.com/kvm-x86/linux/commit/8394b32faecd
[8/8] irqbypass: Require producers to pass in Linux IRQ number during registration
      https://github.com/kvm-x86/linux/commit/23b54381cee2

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

