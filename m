Return-Path: <netdev+bounces-175528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A053FA66414
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0AD1896636
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CF4594A;
	Tue, 18 Mar 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGx77hxb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD84409
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258879; cv=none; b=IhhGG2uFit0RfhxirCTzf/jt5uXCedSMhM/p+c0cAPy4xp8x2gZyIs/pkzifgNSFzxYVMKqNugO+vXqnAng5PUV5vjii9jf+toqdx9fSezpRAslvfvzOkjO0ZI6fmn/SDvzC4SII+8117xQ2fgZEyErvTgJJmSnfdoGyOCN+VeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258879; c=relaxed/simple;
	bh=q9cORwpFr2i7u4nU59k5OUVSEIAbi61v48KFlNjBrec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW/LB01IecL4Eu9KBzOFO6SlaDhb6QM5XT5E2W4n5fN6CdsHrn1v6wCxRZ63S/85aaOPL2/MC+05zUF9F+VeakGBcjNudkVQ6cvHC6DcgY8q1RYCtdSnJo5RscJPPPVL/xJS2X56zrhibJW/682wJFCWAAFlm+GqlL9FTjmVTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGx77hxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZfDnbuROQarLxKZz2VKb8iNL/v4tVesJARFvFI6DSM=;
	b=OGx77hxbsN/9TvSr4gopO1JTaKyq4JcwQBWtH5rXEsS+LqQnCiDOXgVY8tgt7mxoGW2tKm
	ctDsconUMteClzW2iAVM4m2Aww952VSL51JyxBkZy8/VeHV9+saS2GeVTfkkGebcIif2hq
	90N99VaGp2WD25EBW4KcGemib2uVW0A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-CemCVxglNf6e9tPyZKB2Og-1; Mon, 17 Mar 2025 20:47:54 -0400
X-MC-Unique: CemCVxglNf6e9tPyZKB2Og-1
X-Mimecast-MFC-AGG-ID: CemCVxglNf6e9tPyZKB2Og_1742258873
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so4090026a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258873; x=1742863673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZfDnbuROQarLxKZz2VKb8iNL/v4tVesJARFvFI6DSM=;
        b=boBRuU2wCsT47hxH4Z43mYwextaWf4SwF9lGLqTtFNvL4ckTF8RSdqEF8puyeQLjxO
         WFWpP+VcP45b7lJKT5E3UN1hNvOSwNy5jWd1knQXddaH1+Nb27SgFHKPhYtCZgPBgf5H
         hf4OXmda6WdZBn2Op1aSFMJV+NteDL+d/n55jFV16mw16eEFxyO9riVurjdVDrrdkynu
         hlIu+8ePqZ32Mr/twntLJfqWlWDCf4soMm1/MPCON4UCvgxRli7zxJYRthYXFFmiLid9
         RHsrbNqVCuu1Zta0TjLQrKLWVtqzzjIA99PONSUQFovj4/+N5iK17ZnFsZakohrKeT4e
         elPw==
X-Forwarded-Encrypted: i=1; AJvYcCVV8vfswKj1qMnAreTAxLta9ERUHVwedDOA+fQTO4zQfhKAIUOp1T8v6BJurMAkD/+8svdGgNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXI1aYynMsWuLX2JIZ6jil51PfUECdbsm70naco7dwxIXn6tDW
	oXasAiaGH4cp9stqt+KnSTnwp6cm031N8hnBSDAdlKnT25pp9H9mSjmUKZ3UaPaakiQ1C5l1/x9
	4wLPDVs8p4Glo69vKK+G4arKz4StpPeX1EXTmVD2bpElVaiXWmSY52hiT9EEzOjgwBkF4zF6ppc
	2Ed9N+++RHYE8NGCYNQFWejx2JW4D9
X-Gm-Gg: ASbGnct7Yb/eywJ4sNzj37EA9B+Zu/EirLXwBiB5Df2MKEuS2ddOh6KiQYpxjDF2nb2
	ivwNDElkgZjwYzVPPvZeAwWksWHQgtvnyFK7Dam3Av/HMENZL2YCC37sEZMVO+po1rwJIzg==
X-Received: by 2002:a17:90b:4c92:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-301a5b12f2cmr456113a91.10.1742258873520;
        Mon, 17 Mar 2025 17:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzHqvPHhOWayxt9nOn+uABgh4pj7w82asDqMrwDQrO6X0w+kGSrD+YsTLhPM5iW1l3zRKfAFj+h8otb7DW0Pk=
X-Received: by 2002:a17:90b:4c92:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-301a5b12f2cmr456092a91.10.1742258873172; Mon, 17 Mar 2025
 17:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-2-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-2-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:47:41 +0800
X-Gm-Features: AQ5f1Jps6JQeDE5rVwNMXQm81xnyDS129cpfEryeka1nOPKDMf2qheCIDs5KSLc
Message-ID: <CACGkMEvDk-GzpVMPJPEJLRSrJjVHFsbXsd7LB9MjNEghbUc5pw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vhost-scsi: protect vq->log_used with vq->mutex
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:51=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> The vhost-scsi completion path may access vq->log_base when vq->log_used =
is
> already set to false.
>
>     vhost-thread                       QEMU-thread
>
> vhost_scsi_complete_cmd_work()
> -> vhost_add_used()
>    -> vhost_add_used_n()
>       if (unlikely(vq->log_used))
>                                       QEMU disables vq->log_used
>                                       via VHOST_SET_VRING_ADDR.
>                                       mutex_lock(&vq->mutex);
>                                       vq->log_used =3D false now!
>                                       mutex_unlock(&vq->mutex);
>
>                                       QEMU gfree(vq->log_base)
>         log_used()
>         -> log_write(vq->log_base)
>
> Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can =
be
> reclaimed via gfree(). As a result, this causes invalid memory writes to
> QEMU userspace.
>
> The control queue path has the same issue.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


