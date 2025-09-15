Return-Path: <netdev+bounces-223221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C2B58646
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CFF4C1DE3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E22288C35;
	Mon, 15 Sep 2025 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI46tAAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA12773C7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970184; cv=none; b=TQ20h/PiqWKCXJxdYyhXbi+sCuXM59Hc1xeu7MwpGs4odWNldaSp6bAvZZpXxe+x+XjAw4Lmojk76zuUz8DKJWKclQdgkiRzVJ6820a5uVTmPPktHGOaeVtTLyw1UiiW09Oq+WYMLd8y+x14c+8asD9QzUQ/AyZcSPEcStnuvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970184; c=relaxed/simple;
	bh=fTSNHZAQcFYsYv6n1G4GxZktpGJ8qsXioj7qp8jjd+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FBUM7+TtU5CDdpP1BG4PXd9yBFxY5mUaKGrwpyey8bLE5MRiYdABFMhhenGYfAu+pHuQrkdHG6wFhRkOvCerMXAZzt+E3dojSMEwO79rVM8OX+cUWo3wBlTO28xATNB/A/O1JpK/0c7JrPZqPsSV9HxOx2muVia1HLwvdAXfAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vI46tAAV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7761dc1b36dso5596717b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757970182; x=1758574982; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxwTdZBEmt4jtUv/E6BNSirMqJUJGOYRGh1YXveb5WM=;
        b=vI46tAAVGlKFMbbrbWTw8o5gmnIlmjQSeE/qj3dAJXeWX5EglJxVraiqXFaDSFrM2y
         eRxg2hLVD77CHXL0ajYmPvyJeSLHLe/kyiRsdVwGzd9OuAHGD+5BYJX2xRULc7B7QGQn
         0evkDPB5+SVyO8lUxiBM+Z/3r6Fu1G6/vbr+ryVdWWEku2LhMy0/rMPUyAHUswDNPn7Z
         c/drTUZrzy5jsQyYEXNv8vLEHytG+iptdNBNr7YKuA03m+xdiW7UrDB4ErOSwvj7d0ki
         8Y4242uF5DAKHHQ5VuI0RU6Eu69IX16iRzHL7yOIYEOncKdK9C0RaIC9shHHYJKGNhi4
         YHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757970182; x=1758574982;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxwTdZBEmt4jtUv/E6BNSirMqJUJGOYRGh1YXveb5WM=;
        b=wcIaCrlub+oBSbPIFG9/cFG6vqBZFznp0mF1ns/dYmQMCCadizncBOTZmHLdPFPPMn
         hgvTilIsIqiySwB7sA4jCMmYRT9hNqCs7ETC9RbODbXRxCEcoGG9bwxTo78WHHGYmx3o
         YKhw2HOSAtF+WsxIoSnrmCVBXp8CHaPekvcQjfrd6PA5RIwYAvKYQKG3s+ESd1FBPCxB
         iBLvOh0OaSmU11xYRD0kxzYv/R2LrBS91b5K79dx/OHAQSPB+NMeNOPGIK1X9MZ5CJvs
         /pi2m428kp60F5u8IOrDsd55Ngkh8SUQHBXVbyNMmnja3xNdjsANZ8sLSQg1qlV88reb
         w2rA==
X-Forwarded-Encrypted: i=1; AJvYcCUsu3dqVSoUzuTFDRudo3SlvEhFctFkvvEN6fbWdtiROadY3H58/uyeENLT4cjlCtT3FRGULUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQ4Q60ikhYKHRjtL7MvvrEPZlN3b7U/z/O5d/EvVXWKcPxYB3
	RrtCVsGdi47G394oFG1Hq3CrXMF3xDSRfUabqlgBogVQA+xvB3hu5s9usE70bqcEHpY+bDJlDfQ
	+7f30GA==
X-Google-Smtp-Source: AGHT+IFuSpiuKJG6P8l3wSHwKGYEnnc3OxEX+l/ch1UwznTqKr0gm4ilazi12JKz5vJTRzZBy222Qo02Nhs=
X-Received: from pjbnw4.prod.google.com ([2002:a17:90b:2544:b0:32b:65c6:661a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734c:b0:24e:c235:d80d
 with SMTP id adf61e73a8af0-2602c14454amr18045793637.49.1757970181895; Mon, 15
 Sep 2025 14:03:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:03:00 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
Message-ID: <aMh_BCLJqVKe-w7-@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Sean Christopherson wrote:
> Michael,
> 
> Do you want to take this through the vhost tree?  It technically fixes a KVM
> bug, but this obviously touches far more vhost code than KVM code, and the
> patch that needs to go into 6.17 doesn't touch KVM at all.

Can this be squeezed into 6.17?  I know it's very late in the cycle, and that the
KVM bug is pre-existing, but the increased impact of the bug is new in 6.17 and I
don't want 6.17 to release without a fix.

