Return-Path: <netdev+bounces-224893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C0B8B4E6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF723B8F87
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1122D3757;
	Fri, 19 Sep 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5N+wFrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A02D2385
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316549; cv=none; b=MUH9Gf6Y5PmgRxXWYHCUAQfXTtMfLXlKraVnMCZlPqv1tPX9YZXFG4DhHeygVHQcJ6Mfw3cZ0HXpIM0T8s+lnAdfNCqE0x+BtULo0cvY3pRmuHP17lEzLOb4f1KYyZFF3XTDeZ2g5rYO4WV/WZ0LKmBLRqiVRTVAx/Z56R3D88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316549; c=relaxed/simple;
	bh=75+xMcEBZ4CCJG3zy2Fp8An358EsjOFKAwpWo1duVAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxVeVpurf/s4Sv0JIbLR5iek3jh0/OxUNZOUAJpqmwfcegV5DGet3TQzPJxT9tJkgkkBkTDhACSlm7LlPUXLB9R1B3OTW69HX+05DjR1vB4u3ZzvGCthjHzrI5e9uylVl5thIc3/pgmDYFroDVDIr9EBgHmswmMejwFujOgY/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5N+wFrq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26983c4d708so25040455ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758316547; x=1758921347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0+Liys18anQK6gRZATENTJbkZzHDkR1/8jEpmQV1kk=;
        b=V5N+wFrq6fqFRTC7AmC26PUcdxAZ8h9bG+e3cZ21ID4LzXmZfij2HTgMAGmOQc0rhC
         Ar+nVd4C5vdVvBX72hAvTyoBACMM7MjTNYUolzviG/e2E+cHlIs2iJRiOgbDCcAm+D40
         P3mwCkKBKS9IFUW464zmiarb5QrJEBcvN30aMgL6X6BrzFv5S6EBDZgzR82f7zKZ2tid
         RSO7h4XwwMRP4h+uHWA0QyXvtc+liL3LDpwl1GAJtCG+TNIrt8RES0FkSsoqRCSNhQdR
         Tpz6uTgQv6uN1VO0eqx7vpZDygwXapnfhuT+cMKG3L0mZ/GKZstsZUAmo/PzpS+drzah
         HTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316547; x=1758921347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0+Liys18anQK6gRZATENTJbkZzHDkR1/8jEpmQV1kk=;
        b=doCSTgQnRYsYawm2u3UC++cIMuAu3wakSW7j5VZlsk/TkFOFJHB5VAsel/rOdz8vWG
         XZTKvJzkOVoD6R1xnApoelEaY+hTEQTE9DzRVVF0McKraXTnaQhjf93FmmDVL/6gVAkc
         8dwHzmMcPvLORezPA6ySgpmJKqpVl1Z4r0SAvJU8zMs8lPnMlSX+m8op9loGShAasjpe
         PbpDhzNqEAZ7str0tr3nENK1mZdXPI2R7mXdrdF3zws+8bgng41DOXz1B/c2JQMDv/Ey
         d81rNWr7WdlLKp7fhqvYM+yXvv5GUk+dvqC61Q49UKSKHIu4XWdpnAotvK4mPrO0pNzH
         /9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJw9ouP0HBS7WrqCa/QZpCd7q6cEBK3MkPX73jLKCz/ve5zRqqp1liu5/sYow0lWlpuVbr8Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1rAw51AKM81DePWO4aejZhdZP3MbGe3SZktVu4E65aZPn2WZ
	W9hF9zaYzNc3PJn7YrpcEfTe9SptNIK4pI+igRnR6Wx+dxF+MGfyRy1YW/q/jn1hBsKqXtDKuoG
	KWC+eqw==
X-Google-Smtp-Source: AGHT+IFdtQnkscwGqsgriF6C5QkossH14ZthE8OI9NmQ2k9LQwcIhxPc2sZV4JW/RFjatX5u3z54HnLVEKs=
X-Received: from plbjh12.prod.google.com ([2002:a17:903:328c:b0:269:96fe:32ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac2:b0:25c:e895:6a75
 with SMTP id d9443c01a7336-269ba4f020amr59534475ad.28.1758316546890; Fri, 19
 Sep 2025 14:15:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:15:45 -0700
In-Reply-To: <20250918181144.Ygo8BZ-R@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org> <20250918181144.Ygo8BZ-R@linutronix.de>
Message-ID: <aM3IAaCVx-PDeDsi@google.com>
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> vhost_task_create() creates a task and keeps a reference to its
> task_struct. That task may exit early via a signal and its task_struct
> will be released.
> A pending vhost_task_wake() will then attempt to wake the task and
> access a task_struct which is no longer there.
> 
> Acquire a reference on the task_struct while creating the thread and
> release the reference while the struct vhost_task itself is removed.
> If the task exits early due to a signal, then the vhost_task_wake() will
> still access a valid task_struct. The wake is safe and will be skipped
> in this case.
> 
> Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Tested-by: Sean Christopherson <seanjc@google.com>

