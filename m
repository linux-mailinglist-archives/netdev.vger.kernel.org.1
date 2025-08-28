Return-Path: <netdev+bounces-217581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D9DB391A5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE421B20536
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6125487B;
	Thu, 28 Aug 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUo4cdnD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584230CD8E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347589; cv=none; b=dK95Ql0saDwjdoqex1LHPNBVfXrEbhuitN6n+VMLdV7B41ZtnMZ1iF4YqVXvmZwSYdVOWo0zf827na1nuvk5mmB670nAyuBx9s2uo5/mqH1gvbVhXd/j2PhpJd7kGefORowRO4RYP3HwL67zsGLPOINPAfUXbt1IvTH11O2lG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347589; c=relaxed/simple;
	bh=hvnRnQeBlWogViGHqrd2JOdKSR/3mg9vBmKlLw/Pvz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvoutrXyfocIQ8OKIFoHJwzQsF0Y/utIASnD3TEaxjX/IgwiOJFGyTMwS3a5nPLVs6qzl6MFhxm16ltJ6bsH7f8bjhmiM8fw+WoICT9Icp6hBfJfZl5K4x9jeuE+9Je1QIMt/q/X+P3Z74fxzMC98hDaIsV2L+jTavPy5wB0OK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUo4cdnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756347585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuWJUdUgE10jBMdt4FfzRaIc9EOrRfX0+GmPYVYhe+4=;
	b=fUo4cdnDD4bQHIgvyADfwS5jTzr4vlzgzgTu2mnDIZaKIl3xzaQokh02DvV+3zP+0oNPNN
	HBH7ykCrPnO/LWLaa90m/+IWAOg1fkoeS45p1XrAqdF0EWVw/x7rRHhdNTos/5+Sh328Zm
	HyKDUtX4yebonoYZnWUApUUNilaBdzE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-JpmoyKZyPreKl5SL6vcT-w-1; Wed, 27 Aug 2025 22:19:43 -0400
X-MC-Unique: JpmoyKZyPreKl5SL6vcT-w-1
X-Mimecast-MFC-AGG-ID: JpmoyKZyPreKl5SL6vcT-w_1756347582
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afeb71cc67cso78669166b.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 19:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347582; x=1756952382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuWJUdUgE10jBMdt4FfzRaIc9EOrRfX0+GmPYVYhe+4=;
        b=PEJCGVp4hypakq4XslYFjeQD6eTeJxDe/jLiVjdZV8yJQXUGL8reUzi5TtAPyl3iWd
         SfIl216NipIbnIDo6Uagcbyr6xt5ZBsIpf2rj/SImoo6tGRJI0sK8VtFBWWC02RVniEy
         2sBU5aepMI0wKJOq4RKb+ZwwxBZehxeMRQMZc6yT80xph/iuYo5QF+BUEU+F5tHUSyu3
         cqibZDPxcoMRwJ7IO/sLRW/N2m8Adxj6+j9YLbZhIX/aHMGKFlm54vRz5HIGC7AoaUeU
         xCiGk9j4avyqvF3FqFNDddSlUQBDP/aHSSCqyH9URpcwK6spkX/p1keu6bi4+Bdzrwv9
         cq0A==
X-Forwarded-Encrypted: i=1; AJvYcCVf2N4wqTzeOpsV1msZeamo6sGYOWyndLtIgdpry7gTy8ueGN8pHGnSnDs1/Fj6t9snUTGhgqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynKJDx8/dEaIx6VL8TEXkEC3vCt8zYWo5df9SlnviGrfmrkhYH
	j5bZfqj55ruG1WXBwpbNdZcnhmdZLxLlI4sIkNyAVO3v+KRdYq3t2rsk+hwxBMNIxkaQLP+4Joe
	AbyNUWaURWt1/wwviHNadTluLY6TQqv+vw3uqzdiLnikICOsPrMwC8532vYQXddwGNYoqHkJxes
	3gJvEHeVonuZ9MpyY8yY5vdvuBjBvfd/ZP
X-Gm-Gg: ASbGncu6ZoUUuuXMUFtTrxRJgCUDV9f6Xo3s/DKa9ij+qS88KS2wff1IbdDWLueOsun
	zTIPwzVdLg5V4StiPDg5W94Z1IoQgQ0P5FT4O+lA8OtjEai5K31ZM7zbq4l6GJG+7sgenIcnTXU
	msT1o0Xb0PA6mEfylADZ0kWA==
X-Received: by 2002:a17:907:3e0c:b0:afe:c803:a0cf with SMTP id a640c23a62f3a-afec803db44mr338070666b.50.1756347582058;
        Wed, 27 Aug 2025 19:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywnZxZXd+LrwXaJupMXn8D4KG8fZV7ZXo9Nhl8+J+/NoGVlVy9jGmEHSZX26lkU7wovhDS1MB/Wlat2HYVJY=
X-Received: by 2002:a17:907:3e0c:b0:afe:c803:a0cf with SMTP id
 a640c23a62f3a-afec803db44mr338068966b.50.1756347581664; Wed, 27 Aug 2025
 19:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 10:19:03 +0800
X-Gm-Features: Ac12FXx3ye1m5pDHDoHQMdklVzQePg1kNlD8XHk5EhKfbtJVcOqPjtReEt75Bpc
Message-ID: <CAPpAL=wp61suVw-VdqpT-Kxxztaokg_-DkjsVEHDTg7rxzsnbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost_task: KVM: Fix a race where KVM wakes an exited task
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with vhost-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Aug 26, 2025 at 8:40=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a bug where KVM attempts to wake a vhost task that has already exited=
 in
> response to a fatal signal, and tack on a few cleanups to harden against
> introducing similar bugs in the future.
>
> Somehow, this only started causing problems when commit 56180dd20c19 ("fu=
tex:
> Use RCU-based per-CPU reference counting instead of rcuref_t") landed.  I=
 have
> no idea why the futex changes exposed the bug, and I don't care all that =
much,
> as this is firmly a KVM bug.
>
> Sean Christopherson (3):
>   vhost_task: KVM: Don't wake KVM x86's recovery thread if vhost task
>     was killed
>   vhost_task: Allow caller to omit handle_sigkill() callback
>   KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
>     recovery tasks
>
>  arch/x86/kvm/mmu/mmu.c           |  9 ++----
>  include/linux/sched/vhost_task.h |  1 +
>  kernel/vhost_task.c              | 52 +++++++++++++++++++++++++++++---
>  3 files changed, 51 insertions(+), 11 deletions(-)
>
>
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> --
> 2.51.0.261.g7ce5a0a67e-goog
>
>


