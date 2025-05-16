Return-Path: <netdev+bounces-191201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694CABA629
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38B51B67AAE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5BA235056;
	Fri, 16 May 2025 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAfwHezS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1222C35D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436860; cv=none; b=twXvAjU572DP0cY+sb4lYbmNaNLxo8QGKy40rN4mUMG4dsFAKWnWsb3odC1c0j8MdDOk6xdHHyJUs8ajrKaytYRQKks58LQK2QvKXgZD8WvLuSrdKnDGX1KNRsiGeBijc50x8M7EwgK/grWNiw2TmxHbMzxVKV6kPMl9FEvm8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436860; c=relaxed/simple;
	bh=AVnn78Uc3EWeUJSQ7ziRvaqm0OPYoWQKB0eMNz4K9JQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LXdkPCBNL29vZdQrs4/jPvXSiLj3SBb1l96Rj0byw5dpbvp8rrv0jsAAKIU+40hgt+lGK2nVJmTPEVsJpA0pj3O87ZqmK9G+BVQWL2Jr7O9oJmSbbZWuAmpKaNlf1VKGvVOTQJU7pbPrOwzQlupWox0+1EjDFDNKDfkFY8vW+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAfwHezS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c50f130d9so2297832a91.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436858; x=1748041658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuPZrVo3m9ILiCK6u6rwy2V97Y83MmsuXvc2pUzideg=;
        b=EAfwHezSm9vCY59gWxTn2oVu2ODdv4BTL0jS/G1SOZYpTpd6RqWpd9iiwqG0bLPQR/
         mentDoc2U+AmX3B90Owx/+fohgnxONjEwYnWcn5XMpsy05iUWLCeiLVKQctxWb3K2mpW
         41bp3L0Fg8WTYrOhv78rVUbwPTNjSQrsQwG5hRATJOdPZ59fBe00YIVf9EDiVNYqK6IG
         gsgbXcfLegMmTjJNgwRbyMiq+V2SEB9qd+Ml705SoRlTdLm0Nj1ks0TrQfFUZR3aDwIq
         PHj/THmbaYbhHYmewb4mZvqnWNnV/j7f/tHkpi1qLQUnv/Ua9GPDHiNHU4UMM6s8oIr/
         0amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436858; x=1748041658;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuPZrVo3m9ILiCK6u6rwy2V97Y83MmsuXvc2pUzideg=;
        b=cddPSDkYSp5cfUuzI+nKA1Ae1EtftvDM3NqoC6/QbDZkvZTG3llro+9vZYEksx5nBM
         XhP9PW2elkiC9PwcFWh/Qno/oHZ4d6oM4bI66umrsU4ughYxP8NKg4MWoaXc3LSLBKvm
         SzEXUY9IAmzbFO6RnJJF4bghQJEW2iYEO70DnRZtr61URWk7dblokrVhLptO23xOXyWC
         g556j586Ishbfx82JxbH5HF4dSaeph1tm/j8pJjwEu7hpWoo77QlLcHa81TnIF8jjs7o
         zUqK0rDB21cKq6VZ8Dw0GH20cVggR2qexhRJOlZ6T9s5Kq5+/8j/TWNAYfRdJjthKI2v
         /hDA==
X-Forwarded-Encrypted: i=1; AJvYcCWKHJX1JDTcutPa6jzshsF9+8u552EYJ4kJR/eO46YKRHgO1TMlslK+ON+Hjp9eowocnMHlyM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ud3Kq5Twe42m9obxAYoOgvno0FHud1P4pQZ4aFdZqNDXqRPj
	xhMlUDOs2WzDezmuuP/bKozNssL+t8w5Rrj80M2i7yn5P6g3gXiWChq47aao9zBAZT/pa1D3ZhN
	zoGykyw==
X-Google-Smtp-Source: AGHT+IEva6akKzygsV3eTjAuHUFzTW5RKHcvkYUPembdBdAiDgn0hyDfnrXciaaTEYE+lnp6Pa6eayl2kZA=
X-Received: from pjbse12.prod.google.com ([2002:a17:90b:518c:b0:308:6685:55e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a83:b0:2ee:9b09:7d3d
 with SMTP id 98e67ed59e1d1-30e8313da6fmr5609248a91.19.1747436857700; Fri, 16
 May 2025 16:07:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-1-seanjc@google.com>
Subject: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
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

The two primary goals of this series are to make the irqbypass concept
easier to understand, and to address the terrible performance that can
result from using a list to track connections.

For the first goal, track the producer/consumer "tokens" as eventfd context
pointers instead of opaque "void *".  Supporting arbitrary token types was
dead infrastructure when it was added 10 years ago, and nothing has changed
since.  Taking an opaque token makes a very simple concept (device signals
eventfd; KVM listens to eventfd) unnecessarily difficult to understand.

Burying that simple behind a layer of obfuscation also makes the overall
code more brittle, as callers can pass in literally anything. I.e. passing
in a token that will never be paired would go unnoticed.

For the performance issue, use an xarray.  I'm definitely not wedded to an
xarray, but IMO it doesn't add meaningful complexity (even requires less
code), and pretty much Just Works.  Like tried this a while back[1], but
the implementation had undesirable behavior changes and stalled out.

Note, I want to do more aggressive cleanups of irqbypass at some point,
e.g. not reporting an error to userspace if connect() fails is awful
behavior for environments that want/need irqbypass to always work.  And
KVM shold probably have a KVM_IRQFD_FLAG_NO_IRQBYPASS if a VM is never going
to use device posted interrupts.  But those are future problems.

v2:
 - Collect reviews. [Kevin, Michael]
 - Track the pointer as "struct eventfd_ctx *eventfd" instead of "void *token".
   [Alex]
 - Fix typos and stale comments. [Kevin, Binbin]
 - Use "trigger" instead of the null token/eventfd pointer on failure in
   vfio_msi_set_vector_signal(). [Kevin]
 - Drop a redundant "tmp == consumer" check from patch 3. [Kevin]
 - Require producers to pass in the line IRQ number.

v1: https://lore.kernel.org/all/20250404211449.1443336-1-seanjc@google.com

[1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
[2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com

Sean Christopherson (8):
  irqbypass: Drop pointless and misleading THIS_MODULE get/put
  irqbypass: Drop superfluous might_sleep() annotations
  irqbypass: Take ownership of producer/consumer token tracking
  irqbypass: Explicitly track producer and consumer bindings
  irqbypass: Use paired consumer/producer to disconnect during
    unregister
  irqbypass: Use guard(mutex) in lieu of manual lock+unlock
  irqbypass: Use xarray to track producers and consumers
  irqbypass: Require producers to pass in Linux IRQ number during
    registration

 arch/x86/kvm/x86.c                |   4 +-
 drivers/vfio/pci/vfio_pci_intrs.c |  10 +-
 drivers/vhost/vdpa.c              |  10 +-
 include/linux/irqbypass.h         |  46 ++++----
 virt/kvm/eventfd.c                |   7 +-
 virt/lib/irqbypass.c              | 190 +++++++++++-------------------
 6 files changed, 107 insertions(+), 160 deletions(-)


base-commit: 7ef51a41466bc846ad794d505e2e34ff97157f7f
-- 
2.49.0.1112.g889b7c5bd8-goog


