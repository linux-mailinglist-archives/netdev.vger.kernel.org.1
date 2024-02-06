Return-Path: <netdev+bounces-69497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B584B7DA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AF81C2190E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF31332A3;
	Tue,  6 Feb 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wss+AlvB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70780132C35
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229607; cv=none; b=UNs5/AR8564sizBa1riAEf+L8+24QlfCMhig3D/ilebBMB/a2jKlSCryzYjgq0Sn7U4Ap2A5tKDV965bVU6HfN8XmebiJ0lOg3pXnJlFe7J///D6WYf6Vy38cY6XXGhMPDkBdYBTl6lJ3wgeatxO1Ep6qeGSdcKg0rSCnysGNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229607; c=relaxed/simple;
	bh=AhYaiQirIdTgeAFrgav7YX/uK7UoH071E5WHx8NanEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CrmwDkEc1neSvh7oGco3Hy0hFx23xLNTG2sfJ0M7rP6QsOgkiRnS+1EkzUyPhgz9A4/dkgtkpt3zBzctJZLAWGjde7y7/svi72r8/zr0PIhX0Z4G39msvv0DRefuvLCbgcw0PE765FGWDaVmfXjn2ggBD3br+msMooOKM3aqH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wss+AlvB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707229604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/N/vRk6/fRthFrE/hmK6Y0LpIn8IaBHgzVh8Ly/Y4Q=;
	b=Wss+AlvBB7saMwYxWWrwlU8ERoz25WOCE/IxbyJk7xfTU8RwM6x2g9JrNoYVjso+AUQcFV
	4KFKiWORNtKwfBkp2rkARmd2M0EM/23xLIs2tvwakEmj8YR7LETFQakRP8nXu9a7ioLjPF
	9zidWkCC1GHThmcVNusjtHCIUpbYdeg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-zK1FpD-zMdiC0ZGx0Ftokg-1; Tue, 06 Feb 2024 09:26:42 -0500
X-MC-Unique: zK1FpD-zMdiC0ZGx0Ftokg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56064e3e00aso1061674a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229601; x=1707834401;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/N/vRk6/fRthFrE/hmK6Y0LpIn8IaBHgzVh8Ly/Y4Q=;
        b=ix3zchi5i0R/13qgm6CF2tIPb0N1q7DEW3o4NZgoLejluVSYaCzmiQ2eQI+IJ2ktzU
         7r1zS3hbZmERH19QEcK0PZ7txKt6k8/dy87soeDigzezo6ZLgywsCZlhTd2Y1z5yg/nT
         KjvRo48yGhWdeaXwh5SAXlnP0r2a4xluBgtBeILCOyWL+Tqx20eE8QRAjcZjI/nJzIml
         Od0wiC4fR9xy0DJwNYShGU639m6S/IMyo3NYNXKXgfam6tfDyZ2kAF3JOR8ZbHFNb23N
         UgMzJKNBugHJ21EHvZjq13R/nhDrlzd91Ogrh3bOES4KeQmY4bGtVqJSsvffwgEUBN+d
         Whug==
X-Gm-Message-State: AOJu0YyTJsmDuBs6FSuiwUjis/2dYx3FIoCGFE7Gz15Am452Wcp5wGYE
	QgMJZaJ1IWoCR7ZmElKa77CzOZYOGkOb5wQs4nW22Dr1z9Lsow9hV3t29cJBrM8Zvtt07seXYJd
	g7jMuymOvDCNRISFG5xiRDrpc+67TMLJsqyCQQazheb8+yOYXKkXZ2y5cDbL7Q7FSQnG9Nm5vQO
	4Z3iSi7gKXpgYltU640QtXvbbV/YX2oeiN2CLHCpY=
X-Received: by 2002:a05:6402:695:b0:560:9267:95af with SMTP id f21-20020a056402069500b00560926795afmr1553148edy.22.1707229601137;
        Tue, 06 Feb 2024 06:26:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRdTcfjYzbCNkhZtVotCuMQmDrVhn1zSrRgefyzfviguxq2oKuaBu81VGAAbQyzom2xTsM/cQKecCshbYbRk8=
X-Received: by 2002:a05:6402:695:b0:560:9267:95af with SMTP id
 f21-20020a056402069500b00560926795afmr1553131edy.22.1707229600709; Tue, 06
 Feb 2024 06:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206141944.774917-1-sgallagh@redhat.com>
In-Reply-To: <20240206141944.774917-1-sgallagh@redhat.com>
From: Stephen Gallagher <sgallagh@redhat.com>
Date: Tue, 6 Feb 2024 09:26:29 -0500
Message-ID: <CAFoKQtycQJd-fgosPBoXeJN8Crd31U8-kG5QHOz4KHe+5o1mTA@mail.gmail.com>
Subject: Re: [PATCH] ifstat.c: fix type incompatibility
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard; I titled this wrong. Please see "[PATCH] iproute2:
fix type incompatibility in ifstat.c" instead.

On Tue, Feb 6, 2024 at 9:20=E2=80=AFAM Stephen Gallagher <sgallagh@redhat.c=
om> wrote:
>
> Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
> type, however it is defined as __u64. This works by coincidence on many
> systems, however on ppc64le, __u64 is a long unsigned.
>
> This patch makes the type definition consistent with all of the places
> where it is accessed.
>
> Signed-off-by: Stephen Gallagher <sgallagh@redhat.com>
> ---
>  misc/ifstat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index 721f4914..767cedd4 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -58,7 +58,7 @@ struct ifstat_ent {
>         struct ifstat_ent       *next;
>         char                    *name;
>         int                     ifindex;
> -       __u64                   val[MAXS];
> +       unsigned long long      val[MAXS];
>         double                  rate[MAXS];
>         __u32                   ival[MAXS];
>  };
> --
> 2.43.0
>


