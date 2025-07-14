Return-Path: <netdev+bounces-206577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB3B0386C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482E5189BE07
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA72367C1;
	Mon, 14 Jul 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itboC17W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46A2E371E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479710; cv=none; b=Jm4QbXkUPKo5FiPUInoi6lYwkG/i5UP5Ivwbeoxpl7r4Am0Rp5qEWsWVEkMsE/PNoVDnHbIHhHEs2Qg0zk7SyorrgDk6Gf78nuzi7qc6O+nF186H5UdsKmQotxz2oIpOMrzaxrcXVLc1OfWwHkNSgzwju95VNtwHXZ7flLq71Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479710; c=relaxed/simple;
	bh=tiu2nK+C56Y4UTXeDLT+Tfbmtgme13MZm7oIc8lWWM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgDVsKHpAsUm5HIPRZI34oj9uwj6krsJGMMyvVfdPslKS+5xaEH7avclbDRRQCpqVTjFT7Kd0TjVCSYu4B5NpTokyS3mbiz1jUVx+MdGyAe523W5fXj/5JbMA3o7iePOtKHrCgiSt+8FDCaKo345YreVTvN2rXLe3hycXc2xsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itboC17W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752479707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvISYJSY/qK2kGKabHvUCxDGnx58jdPHinutempWO4Y=;
	b=itboC17WAaWE6a+4LblQ7Y7SqWyyiWoC2N8cjcimILDqMG94KbNmaupwAl0AOLkJXM1EBl
	9qaoeYTzVeqWDwkjHvwTXaYUZ+qS3MJTw++BlnI5ilF3IDOABA+ukCP/qhXIdV2+qD6I6J
	WrecUucX/MDlCxHiwJVCIR6yAcwv2RU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-abMPDL6CPwudPUJQK8CBDQ-1; Mon, 14 Jul 2025 03:55:05 -0400
X-MC-Unique: abMPDL6CPwudPUJQK8CBDQ-1
X-Mimecast-MFC-AGG-ID: abMPDL6CPwudPUJQK8CBDQ_1752479705
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so7454938a91.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 00:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479704; x=1753084504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvISYJSY/qK2kGKabHvUCxDGnx58jdPHinutempWO4Y=;
        b=wl9DzRUsVzpo3Vk9w7RNn9f467H400xpd+JUOdubhTE5reZ0ACuyCilae0R7pFS3aP
         DgYHinagw1xNkfKNvbFzo+JQuizgB4JWZiqBfCsJFbGtT9/HRhDPJYSJfJyvW5zjAXym
         WtGkYoMx1FvHhhzDoFqxvL756+sPgleryLWQofWDQpdPrhfTgGt98L6F0GeQpuq8+cjF
         Baw/YRmYvJ/JLlbHFT9cHEkVB8a7mX2CmK+9M/OkddvkJCHfc6l85DE0WNvQ3vW3ZBNV
         YFNtwpm2d/QslexFXm71zwbyu4LD21RR8sAz42wPbVHwZoXRLwYCrOfSrXBvLVhBcFJb
         EJog==
X-Forwarded-Encrypted: i=1; AJvYcCWFYxdbJYSigscQcWWCkRlZIJyS4kJloWwVu1KBpHHQ0AlOVI+a+xNAcudc4a+8K/rH6qcl1co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58+tH3LCrvO2kjJgDSZ2jXxxpDLjMcffzV6PqdMR0cUWQVywK
	yBNaGruX5y51iuVdiklIaWwdV7934eK+bS5HM9AGXhe9e5W1U7MW0O3LGSFhWr3rLW3J9fw7C0Q
	KMJ+Q0FeiKnSXdzm0hFdFiis3t3WgWmhkv8isdokqxP+eiC4Vfy1FUyrfXlhALf+5URq6X+1FIi
	UERnDimP5GKKz03/Hry6MLrhn6yEVjq9dN
X-Gm-Gg: ASbGnctmilqZTCpoeUPWsD4uqT0U5OgD9Wqk7FjkcYKKHocHaWftMAWXb6nhzrl4gKf
	zLOVeUnKpfClX77i/NILPeHjJ4Tew8etSY2vyQyzNrHHGhhEGKKPl07thdM9iGsPz6USb+OMD8C
	VWU2h/gfqwuzsEjL61qS8c
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-31c4ca8484dmr19569350a91.14.1752479704463;
        Mon, 14 Jul 2025 00:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnet4rC1xgcXEZ20xYgQVBr3JRR5R4FOhA8hV2O705o81pURROYmMQvBTkz/PEie7bN+76RHxpnjO5by0g3h0=
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id
 98e67ed59e1d1-31c4ca8484dmr19569328a91.14.1752479704074; Mon, 14 Jul 2025
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714071333.59794-1-lulu@redhat.com> <20250714071333.59794-2-lulu@redhat.com>
In-Reply-To: <20250714071333.59794-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Jul 2025 15:54:50 +0800
X-Gm-Features: Ac12FXwOxi5XmIWDjVBorqVT78hYR2jMNPSkm1W_ckD1RqpdpvGkBqoo8WdhIzE
Message-ID: <CACGkMEvZthxg3x=SLQMj5t_dunnuutFm_8ZZiO1MiQdWGqx9Cw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
>
> - Add 'fork_owner' parameter to vhost_dev to let users select kthread
>   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
>
> - Reintroduce kthread mode support:
>   * Bring back the original vhost_worker() implementation,
>     and renamed to vhost_run_work_kthread_list().
>   * Add cgroup support for the kthread
>   * Introduce struct vhost_worker_ops:
>     - Encapsulates create / stop / wake=E2=80=91up callbacks.
>     - vhost_worker_create() selects the proper ops according to
>       inherit_owner.
>
> - Userspace configuration interface:
>   * New IOCTLs:
>       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
>         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHREAD=
)
>       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
>   * Expose module parameter 'fork_from_owner_default' to allow system
>     administrators to configure the default mode for vhost workers
>   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whethe=
r
>     these IOCTLs and the parameter are available
>
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
>
> This partially reverts or improves upon:
>   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
)
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


