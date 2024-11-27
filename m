Return-Path: <netdev+bounces-147554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962399DA273
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 07:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B74B2831AE
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DE13C9A6;
	Wed, 27 Nov 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg20+Lpv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3211946B
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689935; cv=none; b=g0UXRlB8ZrPR1ikudsOME3mGn0UDTWYgqvfvx0ZNKEKSqNyS0M9TWoIy6/Nb8Rwhd04jsT/RdbftzgtdOd8oW/6OKkRGstRF41aa1aoI/MBg+qRB0T7XCvcnwmzdkRZVsbSeca1tgJPSYDXxI5IZC+pK/09yuIGB7kPxvkO2MGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689935; c=relaxed/simple;
	bh=RNmNT70ps+kx7slfSFuJ9G/H2xuAhJkWrfXMq+752EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwlENx+Nyz+leKwMB2dgCYDOckhDwVoOe1hYQJmNGKkaBcNYiaBIm1E2nOYortNS3/83HgEIWLe5uxENHTOHsEluc03G1ur1n6ZucfMSnhnzbrOGmaPgRidQpy9PJApsSioIeCbbYDvSaoaUYckNG6cMllF1cTiIyzOks3jr62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg20+Lpv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732689933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/rI2EY7Ph6b3KZhYxy9/j/W0i2aqaLJSO/nDcTsMvA=;
	b=Kg20+LpvVR7ZZ/T2BQ2xaa9/rNRkfcO2ej3XoGvGzsPERVwXv7Mvtk0p9hBrUARt5wx/Bx
	PpA35R9/pJkVXu8RD9BH4rsBeQVBa3BHu4qmLJKbX4YkzhVwu9ci+3DChdkNEOQaP0pMc2
	SSc3Ka2SvuhiZiwnRY5cDVAee5B4JTY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-8UaeEvSYP7SSG_61XWviRA-1; Wed, 27 Nov 2024 01:45:31 -0500
X-MC-Unique: 8UaeEvSYP7SSG_61XWviRA-1
X-Mimecast-MFC-AGG-ID: 8UaeEvSYP7SSG_61XWviRA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa525192412so295123166b.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 22:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689930; x=1733294730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/rI2EY7Ph6b3KZhYxy9/j/W0i2aqaLJSO/nDcTsMvA=;
        b=hA99bj1Hig15OyMuAi2l/q9l825AY2Z4C797e5jcEp8i3SkJLSJewMVQO/BjEYDXS3
         2v9BEAsZYRAhNjlgIblYO+aO1K+GzDZA4i18bUR+VbXA0IQ4UvvApZdFoH1guUFuD7zJ
         QAgTAoa30e0865nIdTYD6gta/0/ipUWQgvuRg+YxTeClF26kWZgqxsEkqFV09VlT72iC
         YBJELVc9c0G32+a4crKDe2bhtfbgbMZJpCXUX+VVnEc06+LLa9+VAJo4OPuNy7/SwRGz
         Vcl8jiRgJvgZsGCwA/yidUJMx5as0e7rSEAzd8yhhjDJfBfBY7SBrsuqhnx89kZ0C3c9
         d3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVdKuUkzsTtyZ01xZw0QBhTt1ncEjBq9JeuD4mwVjlcXrwDtf1qvDHsK/fki+40IitJ3Govg2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOycPdA1WyNgf1A5QGQAOtLNhORcwRWnhQSfG/g/1/FOIT020
	qGugo/WY4Ib7xvbPH4gWFOPjd60cmyDMvpFk0JBJX3q6MdVgv+0Wom/GdfJkjXRNNtILrBCVP5x
	F/Q0XsFQu5sSRpRHyY0+lklONyyRhVZNbTTa86ppNEAb+6ZyxkfScixEZbnWZm7TGXWn0z+jBcP
	rZCCgB/8YwVYPn5/wEGbzh1f91MPar
X-Gm-Gg: ASbGncvSOtQwM5Cjv2+Z13rY38/lHEGLSRaI56ISWB8GIC7C/PXRx+XshqWhOLDZ+yN
	N2QXgzPleV+4y6VjaOYTtioOUiFf+EsJQ
X-Received: by 2002:a17:906:1ba2:b0:aa5:2f8a:b952 with SMTP id a640c23a62f3a-aa58106613bmr111618166b.54.1732689930419;
        Tue, 26 Nov 2024 22:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUP0/KWUbb7Co3AncLRdOmYqmNvbV+nqgWBTGrmbeqC5ZOJ62cFI33uH+j5QLWBacrMzgyNp/kkRsf6zhWK3M=
X-Received: by 2002:a17:906:1ba2:b0:aa5:2f8a:b952 with SMTP id
 a640c23a62f3a-aa58106613bmr111616966b.54.1732689930058; Tue, 26 Nov 2024
 22:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-4-lulu@redhat.com>
 <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
In-Reply-To: <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Nov 2024 14:44:53 +0800
Message-ID: <CACLfguWGxNX1PgTCgH2NbBZoJhRSNnvVKzUzq2=cYY60+-kReQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vhost: Add the cgroup related function
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:22=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/5/24 1:25 AM, Cindy Lu wrote:
> > +static int vhost_attach_cgroups(struct vhost_dev *dev)
> > +{
> > +     struct vhost_worker *worker;
> > +     unsigned long i;
> > +     int ret;
> > +
> > +     /*
> > +      * Free the default worker we created and cleanup workers userspa=
ce
> > +      * created but couldn't clean up (it forgot or crashed).
> > +      */
>
> I think this comment got added here by accident.
>
will remove this
Thanks
Cindy
> > +
> > +     xa_for_each(&dev->worker_xa, i, worker) {
> > +             ret =3D vhost_worker_cgroups_kthread(worker);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return ret;
> > +}
> > +
> >  /* Caller should have device mutex */
> >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> >  {
>


