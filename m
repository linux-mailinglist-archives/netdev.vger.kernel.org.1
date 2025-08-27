Return-Path: <netdev+bounces-217430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02FB38A53
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C03BDD3B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163FB2EC57B;
	Wed, 27 Aug 2025 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuF7t/qO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760727281C
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323675; cv=none; b=sr3s2z9/ZcZcUpwYIksw2dc/Omt2uVW1N0tpT79kbfjl48lqcBbUyWUlDAeODrZbRzC6xpOUCZDI+gbx3IlfECogImLLAHK3WYZBx9YoU2riFrk3FH4pxk6M5wg7LLCfrLwMlSf57aq6EQ4M7LO5Wn8vini6bRfD+ZWehvKDB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323675; c=relaxed/simple;
	bh=x/i6BRd0cWtRfp3CxZsaVLLtvufEWdcUwwghTxEVFpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Of7dqMe6SEPgehdbaYrZ8sm2PYOv2QgAJbWidlhBy+c6wfTAMQT3RRTAQX88vAqPvIa+Pw+S4eGGYiERqKcqn58/4CML8hV05l2C8wsmMcF351RcFrY+7QT2Dq4Vdijq9OpCIIS+ziBs6vzB0x0Fw35jZnA+aNmrOHa2zxV7GL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AuF7t/qO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77057266cd8so161836b3a.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323673; x=1756928473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWAmWKV0YCAe3PkG8+/flyHk3YjgRL//qGGe4nfIRiE=;
        b=AuF7t/qOQm6qKXSPMaMLuRN6BsIljh2hAs2n96cSqDebchzPlBSsE6uIbP/MOkevzZ
         ET95rIxOvWEA61A0wwiarEBik76TxH8frvDqebgaviaGRVpaxr3WrY3HdhqNYyJdiMhL
         cUqloxI/T+NMiPzmfIM/MCpn+L6MD5XISHL2mrNO+emqa+a1ZYov+P1ely7+yn4CMGxo
         JntqgxWSRawdSoglQ5yaW7YZsdo7WcM4nrhm2I8mQyDt/bxa4Ye62pU2HfIIObJ53mfU
         BFtWGHkw1NGsjAkal3Mxu3HVIPfNIhpXYXouQ7Qn2rdISurIq1hO639HnfLw+gpc6l00
         /9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323673; x=1756928473;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWAmWKV0YCAe3PkG8+/flyHk3YjgRL//qGGe4nfIRiE=;
        b=XDmlmZ6cbqVE1PERqE1j0qamPk7cBLX1PMCwdh4vS3pw7nPB5wUfdkr1P7nplHsKt1
         YROkPBKGSmrQNskzGsRynpanCcDtWhkafeLwIwcGrA2vxsqd9RWzdMZL2M1iOvSQ5Fg7
         +pgqW0ehnnhpnrc17a9aZ8ziOgxeEhOsU6yUc04gONNGR/Ta1dDPYynLO5/XyE0dSeV3
         rBbLkCsK4mRsbcZwr7kqDhTN3mseB+Px5Nq76i8fx/y4VF5ZxmwW9fcNtjO3eNZyuIKZ
         d/+rGmCnTmy0g4jH7C+MINwH72XPDtnnw91mqAgNFmYJQaC7WMXsAzXlNK1rvPsXwd5w
         82JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVszc4jcShdrqr9MQO9nqH2uRA3V00gJqyVF8T0G3PjRxq3DmvuvsPM7ymSpuu4iDlB+5XmTTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNp5YUZNUL2hI/CQ/BDU/mk+ngi8hzeU306Ewmzz4naqopBC6
	aiNqQsBEhF3sEFzfeuLkcurwT0HGlCsXfkE7ToNSjnwo/bwQUu69beRxrea5mqIRHStyQv4etqz
	zSiWWYw==
X-Google-Smtp-Source: AGHT+IF3kgndwMxobuC1w46DvzTQVQ+70Io5X5LupzuJERdtYH2UT2HutkGftTPmJvqTvDvQz3iwKQFDQfQ=
X-Received: from pfjf14.prod.google.com ([2002:a05:6a00:22ce:b0:772:49a:524f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b45:b0:770:556d:32e8
 with SMTP id d2e1a72fcca58-770556d5e86mr17407883b3a.24.1756323672784; Wed, 27
 Aug 2025 12:41:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-1-seanjc@google.com>
Subject: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Michael,

Do you want to take this through the vhost tree?  It technically fixes a KVM
bug, but this obviously touches far more vhost code than KVM code, and the
patch that needs to go into 6.17 doesn't touch KVM at all.


Fix a bug where KVM attempts to wake a vhost task that has already exited in
response to a fatal signal, and tack on a few cleanups to harden against
introducing similar bugs in the future.

The issue is firmly a KVM problem, but I opted to fix the bug by making
vhost_task_wake() safe against an exited task as doing so is far simpler and
cleaner than implementing the same functionality in KVM, and I suspect that
if there are other users of vhost_tasks in the future, then there's a good
chance they will want/expect vhost_task to handle that detail.

Note, this only started causing problems when commit 56180dd20c19 ("futex:
Use RCU-based per-CPU reference counting instead of rcuref_t") landed, so
the explosions are "new" in 6.17, but the bug has existed since KVM switched
to vhost_task back in 6.13.

v2:
 - Drop the "safe" postfix variant and make the "default" vhost_task_wake()
   safe. [Michael].
 - Use vhost_task_wake() and __vhost_task_wake() for the public APIs, and
   vhost_task_wake_up_process() for the local helper. [Michael]
 - Drag the signalas back from their Spanish holiday. [Sebastian]

v1: https://lore.kernel.org/all/20250826004012.3835150-1-seanjc@google.com

Sean Christopherson (3):
  vhost_task: Don't wake KVM x86's recovery thread if vhost task was
    killed
  vhost_task: Allow caller to omit handle_sigkill() callback
  KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
    recovery tasks

 arch/x86/kvm/mmu/mmu.c           |  7 +---
 drivers/vhost/vhost.c            |  2 +-
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 62 +++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 16 deletions(-)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0.268.g9569e192d0-goog


