Return-Path: <netdev+bounces-179387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D6A7C552
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA693BB4BA
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2AA214A66;
	Fri,  4 Apr 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22NB831z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DE1C84A3
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801306; cv=none; b=Ut2EUCV0uYcNz99hGcNyWMBxPzVGHpJO0RBTVwR8o7y4pGAuTtaXwyGJXyBUg8UwQAGb2O9vFahDS8n61Wf3rWeMnGSQhH2jGndr09C8eHlx6WYnCphp60T//IW+0eS44OKYAam1Z9nVLTOPsotwdsreGnoOJ8+MtGdXdxR1/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801306; c=relaxed/simple;
	bh=ItUeEJxyPrZVjz5fmXJVd+IubAfuc0Tp3x2Umz+G76g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KizZaVeBDts/WJ/4bUCwSTKRDz4vye6AP5Muw8vjriyrAYxzQXm/rERc6o91K8PkvY86YWLHxYyebWkob71ycqMjITU1MHjy8m6sAIHIXlD/a3YvffPwJyxcJZ+fN6KV4x+fFATVCzxReqVYI5KAekhFcErziAku2OPBOmMu9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22NB831z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso3513153a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801304; x=1744406104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkG9/Gie3NkMh7eSDfJzty3mxspo7ZZ0xVy2Q3dHWOM=;
        b=22NB831z0dVIPIj0q9WW60uk4KpeVzxXMha2Fb4AUORfrQlp17ZCH3LO/XNb7I+15A
         giqbWm9/ZAFlMSWeyhIT/glCMlDiCol5gNWn9aVO2idVZOPtO1dV9FZ7cJfzwNGx7lKs
         9e6dnPDKp6Wu9Peg9YBIcPfwvyU91m0mCI8A2b2qaA1x06qOlhwlKNZ+vAa7sB8oVUMa
         qrmcx6hx3ZC9+hf0eejdsqK2y33iXAyx07nC9RHVmoUmzAAyFk1eVDBeM+WlFXZq9Xv7
         BF7oaE8jyOYu9MN1JglYAHW5CPCBLh0YP6Bz8pMNYGCNPMysjy0uHuGjKCb0Mkpgypxk
         U8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801304; x=1744406104;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkG9/Gie3NkMh7eSDfJzty3mxspo7ZZ0xVy2Q3dHWOM=;
        b=Uvpp+S+45v3cHfA+fyEOGVf3UrjA7BtwpPg4w+cbSvn30GNQAe+Xm9QkuNaOetxKSS
         m9B2mp0vV4rnLXeRsKw8WA9+AgGoFsxWXpqfqI6MiJcOM+KW6sJ5DALAUuzlscmM4OWe
         1r9XXbxp9XqxF9iqB+7BXsWDkeMc3mBjOL05mr5eblNk4tEeqdleFQSUtnAtyr4boUtZ
         V6QZnm1p1cxpfr0sbl2riLLeOcugCmh2ZJZbFKiCMQmyO+U9O2Nchuyx9yxwdDA0OOFI
         MzIBtGTx6RewAyK7oGSzBVe0sXCYTHanG8cswFvB3OQ07/kG69Yr+fCnhojoqs2XY29/
         fWkw==
X-Forwarded-Encrypted: i=1; AJvYcCUxSqJGLrqidrG9KVOd0NZ8AMlv4VZVWRdAEXqRA4IZmDUI3Vkdgyf7FF9CtAgoO7wPlIMH4ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5ymjNeV+P1cuQ+0C/NQ1S9fr99n+H6S5N2NVhxWeyFQWChKW
	hurieUaQzlyNn1j2mbAMey0OLrCtfFTmX0Kc8i2nLXFjQy9iiRRHKHwSiCuO3xB2X8yAhhb5w6q
	juw==
X-Google-Smtp-Source: AGHT+IFs32FT+Ce+FtTQ8URjvqmCz/3ftaqwgA6qZrIK3r+Twdavhp7tQfXy+gW0pJuBHlqTt3ifIanpTwI=
X-Received: from pjbsf11.prod.google.com ([2002:a17:90b:51cb:b0:2ea:46ed:5d3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c3:b0:2f4:432d:250d
 with SMTP id 98e67ed59e1d1-306a617d201mr5610182a91.21.1743801304083; Fri, 04
 Apr 2025 14:15:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-1-seanjc@google.com>
Subject: [PATCH 0/7] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

The two primary goals of this series are to make the irqbypass concept
easier to understand, and to address the terrible performance that can
result from using a list to track connections.

For the first goal, track the producer/consumer "tokens" as eventfd context
pointers instead of opaque "void *".  Supporting arbitrary token types was
dead infrastructure when it was added 10 years ago, and nothing has changed
since.  Taking an opaque token makes a *very* simple concept (device signals
eventfd; KVM listens to eventfd) unnecessarily difficult to understand.

Burying that simple behind a layer of obfuscation also makes the overall
code more brittle, as callers can pass in literally anything. I.e. passing
in a token that will never be paired would go unnoticed.

For the performance issue, use an xarray.  I'm definitely not wedded to an
xarray, but IMO it doesn't add meaningful complexity (even requires less
code), and pretty much Just Works.  Like tried this a while back[1], but
the implementation had undesirable behavior changes and stalled out.

To address the use case where huge numbers of VMs are being created without
_any_ possibility for irqbypass, KVM should probably add a
KVM_IRQFD_FLAG_NO_IRQBYPASS flag so that userspace can opt-out on a per-IRQ
basis.  I already proposed a KVM module param[2] to let userspace disable
IRQ bypass, but that obviously affects all IRQs in all VMs.  It might
suffice for most use cases, but I can imagine scenarios where the VMM wants
to be more selective, e.g. when it *knows* a KVM_IRQFD isn't eligible for
bypass.  And both of those require userspace changes.

Note, I want to do more aggressive cleanups of irqbypass at some point,
e.g. not reporting an error to userspace if connect() fails is *awful*
behavior for environments that want/need irqbypass to always work.  But
that's a future problem.

[1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
[2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com

Sean Christopherson (7):
  irqbypass: Drop pointless and misleading THIS_MODULE get/put
  irqbypass: Drop superfluous might_sleep() annotations
  irqbypass: Take ownership of producer/consumer token tracking
  irqbypass: Explicitly track producer and consumer bindings
  irqbypass: Use paired consumer/producer to disconnect during
    unregister
  irqbypass: Use guard(mutex) in lieu of manual lock+unlock
  irqbypass: Use xarray to track producers and consumers

 drivers/vfio/pci/vfio_pci_intrs.c |   5 +-
 drivers/vhost/vdpa.c              |   4 +-
 include/linux/irqbypass.h         |  38 +++---
 virt/kvm/eventfd.c                |   3 +-
 virt/lib/irqbypass.c              | 185 ++++++++++--------------------
 5 files changed, 88 insertions(+), 147 deletions(-)


base-commit: 782f9feaa9517caf33186dcdd6b50a8f770ed29b
-- 
2.49.0.504.g3bcea36a83-goog


