Return-Path: <netdev+bounces-170595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C314A492FD
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259573A963B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A61E25F2;
	Fri, 28 Feb 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwqQpQdB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86151E22FD
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730092; cv=none; b=fKgmQHlfjbh6n3mDx8Zhie5KtP7wOyurFPc7AY4LgG2dZrhf5H2w4BVKqgRcLhEaxIkU37nI0mpB8A3LPRBc9HdZuCauVfdemDuuUEc4hivow+y46Z1EKG/ERd6WBZa0H8Bc8v3PF/fo7KlbvMF5gok3uiwukzpkBGigioeoqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730092; c=relaxed/simple;
	bh=r9GSmtMicPcq5rW2NPP7VRMa9gYB5kx0AW78fr0QhO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tySBY3E/9wz+Nz1xMbGe2aJH7uT78xBk5M7KBMqM1QSbehxy2akCFX+tX4CXRhsPfVLI/BuPPryfPI2q6wip2xsJqNSR6s6Z14RvTvFdecDjDLjJbpeokyx21h2t4iv8YAtlyjCerey5qfm2NNbkq55uKvl32AXNngmz/H3tTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwqQpQdB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdUTuAdjhkxdXouf9L2YfL8fvPAf9Q3Za2OJ9RnA1QY=;
	b=GwqQpQdB4AxZuofKRmSjci5r9TUXHyO7hc/7/QxKbPbmxzxKGwaTqBOOGc1rL9m9rvqMFt
	g1MDmQZbP7+71Hxl4DDYhelb4lUdsfYz79wf+o0RsFnwRf0GbYyIRXTM4Dk2zX/CYXtPDy
	4e1meH0ZtrGnUKIdZPcHBuO1FTIiG+0=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-uaMBohluPoGignIPm5z-Ng-1; Fri, 28 Feb 2025 03:08:05 -0500
X-MC-Unique: uaMBohluPoGignIPm5z-Ng-1
X-Mimecast-MFC-AGG-ID: uaMBohluPoGignIPm5z-Ng_1740730085
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-52086843004so2678439e0c.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730085; x=1741334885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdUTuAdjhkxdXouf9L2YfL8fvPAf9Q3Za2OJ9RnA1QY=;
        b=oaL3nORSuz2uvpMWRcgAyc+mn+uMtPsmjdcbX4z0IeFuVlpSbkyzpKvgu00TD/oHjg
         XOcKMfqWpZSdBx5yghe240yPuKIVBULBnbh7FV2XGdLzOPIh1FS30hEKOCC0eoo+cJaH
         sJYp60gdQPtrwz6m0bg82jrlfYxNN7B0L/Qk048/Fx6JrGAT3oUjKp5jbsmVJ/de0vtt
         zOE2Ni4z90ZFRo8THw5ZFFQK+B3wFuS5/DTxCyGs6hJzXw0yECEF7T1bIYab82iheEuo
         hnrnUMU5WCl5NZjpYHzIcGLZ7YAzmmxE9O0oSC5/C7CMjXNIWoaGnYbV3HuI8OoOQbia
         GhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaZW7ENRQwJNnIxPfSHWhZj3ysVeKZf09KyD3P3jdfd/vNBPiU6+wAktRS2lMXP3uAJGkfIdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsxmtFqrDmUP2C56hOQZr8IqnglcMpxssggKHu2g8bqCVhIBo
	IwKCrJ2G1wG0c26lBScHli7XulbjerqvL4ZazYjhA/zLed4AP+yWr1zEfD3w674VBvrthQVAH44
	HF+CCNPA7UKwRuxIoVAXmMmc6KhanpuHWcD3vBHYyLUL3nUT0EjRJ9TLdfmNP1z6Un+BvCLHfdS
	qJyiO/QCxvkICEngU6pPvHrJoqvbsX
X-Gm-Gg: ASbGncuxzteYdvPOA2lhfn0Gy2yOCTspRbndlnUPDPEJoGCejFQJv44iG6SOGhH7ES0
	2w/BRBLHsJoBFouuhZz3SsC2QNFFxTqrcuHYjYRkanKhm41cxPkVlNnZR09NZ4aNRoWRqJTpp8A
	==
X-Received: by 2002:a05:6122:8293:b0:520:4fff:4c85 with SMTP id 71dfb90a1353d-52358fa2777mr1810207e0c.2.1740730085120;
        Fri, 28 Feb 2025 00:08:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnzJbPx76VPjBpQt7am7d8LKNakTr6F/2ZNTopcxram3/9GKreE3AEQUVie6mNxSMpVmuq6MObJy/GAXT7g5A=
X-Received: by 2002:a05:6122:8293:b0:520:4fff:4c85 with SMTP id
 71dfb90a1353d-52358fa2777mr1810203e0c.2.1740730084874; Fri, 28 Feb 2025
 00:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com>
In-Reply-To: <20250227230631.303431-1-kbusch@meta.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 16:07:24 +0800
X-Gm-Features: AQ5f1JqPk0QRBHoltnkDQ29vhpwSBSIPKORj3Gk6lgM7TDuBtJyK6aRdH4dto9I
Message-ID: <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/2]
To: Keith Busch <kbusch@meta.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org, netdev@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Keith

V3 introduced a new bug, the following error messages from qemu output
after applying this patch to boot up a guest.
Error messages:
error: kvm run failed Invalid argument
error: kvm run failed Invalid argument
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000806f4
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200error: kvm run failed Invalid argument

TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Dc5 5a 08 2d 00 00 00 00 00 00 00 00 00 00 00 00 56 54 46 00 <0f>
20 c0 a8 01 74 05 e9 2c ff ff ff e9 11 ff 90 00 00 00 00 00 00 00 00
00 00 00 00 00 00
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000806f4
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Dc5 5a 08 2d 00 00 00 00 00 00 00 00 00 00 00 00 56 54 46 00 <0f>
20 c0 a8 01 74 05 e9 2c ff ff ff e9 11 ff 90 00 00 00 00 00 00 00 00
00 00 00 00 00 00
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000806f4
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Dc5 5a 08 2d 00 00 00 00 00 00 00 00 00 00 00 00 56 54 46 00 <0f>
20 c0 a8 01 74 05 e9 2c ff ff ff e9 11 ff 90 00 00 00 00 00 00 00 00
00 00 00 00 00 00

Thanks
Lei

On Fri, Feb 28, 2025 at 7:06=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> changes from v2:
>
>   Fixed up the logical error in vhost on the new failure criteria
>
> Keith Busch (1):
>   vhost: return task creation error instead of NULL
>
> Sean Christopherson (1):
>   kvm: retry nx_huge_page_recovery_thread creation
>
>  arch/x86/kvm/mmu/mmu.c    | 12 +++++-------
>  drivers/vhost/vhost.c     |  2 +-
>  include/linux/call_once.h | 16 +++++++++++-----
>  kernel/vhost_task.c       |  4 ++--
>  4 files changed, 19 insertions(+), 15 deletions(-)
>
> --
> 2.43.5
>


