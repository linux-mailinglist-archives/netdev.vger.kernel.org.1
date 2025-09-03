Return-Path: <netdev+bounces-219418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF3B412CD
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86881B21051
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC682C21EC;
	Wed,  3 Sep 2025 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/kqaxo/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCB1DF742
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869205; cv=none; b=XYYZX2OB5C9SqPqc82Ib9hbgAFAEok799xrRiNAvSonWvsLxRlF6Go7xplXrwoexH9CpQwn8gq8cOS7Q8OzzVU3aHmMXZI8WdodBsNEsp9M5yZnFozf+40iGE6XOQHhhufJCMh0yiBd1Fee1iBXmXJLojSDzI2jR8enUd8R70Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869205; c=relaxed/simple;
	bh=XMHugQRV8upAY2qAFOtTHC5h06Ia39RID/0cXKLd44M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtA3pn59F+lDy4nhKOZ/2bgj9CrsARt5dDlVv8B/9VpHuEJ35+FzZjR1++OsPygtOcx7PmQRxxR7p3sje07La8DCw7D8CNEYwaVumSvjR2KFmIKdDz1jsaXiEIgQICpF4YoWPYYi2jXwiJ7WKlgBIfSKQ3FPvqoDFQKZj7oI8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/kqaxo/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756869202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xol+alIBvLCv0kDjUEFNYzYfWJLZoeFZJYHsWzrrfsI=;
	b=N/kqaxo/rDLOT8vnnmbCN0qZn1hQKf9uMbFnr0+IVuft0ReXXSRb5mRw51hJvnuBwH3o3C
	aSiYOldR9MytUHzhB0b5srJVysSIHUe3zC1pdtAPsqJEzdGaZo8zVUiOcWAZWFReGAGqvg
	uTfBOvIe5NRa3KD6U//m8xfj/yUUca4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-DFlt2x6QNlSozCucZkrSDA-1; Tue, 02 Sep 2025 23:13:21 -0400
X-MC-Unique: DFlt2x6QNlSozCucZkrSDA-1
X-Mimecast-MFC-AGG-ID: DFlt2x6QNlSozCucZkrSDA_1756869201
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3276575ae5bso6313757a91.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 20:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756869200; x=1757474000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xol+alIBvLCv0kDjUEFNYzYfWJLZoeFZJYHsWzrrfsI=;
        b=rB7c6DZumqVAkc6Q3RfI1wei463D4FvU/DsHOLFn4dFL9c+2Q+ES06RKjSibPuGiQp
         2AjvFAJ9RLDcje+R1ao8q6bbNBJ3iGXPpHF9qgDFOciYgncfaJtNdoIyi4UommLgPbyX
         LOj3vWp3e1pvihsocMSAzEMJFQTIovjIJNMjejLcZgc0oejlvWMtns2PRh3QNWyUQWt6
         +O1frgbC+Tvn1RBn3meI/X09456eyWHVvg1j0AUdZdPMgYLv8ZvnSQKuFL652LMDpOmi
         QTXrdwsKphqmlpoovhIbhXBBe2wY6QtijfDS08d1HBD7hA4SsWGQM3IBgQz1MF/TPUGw
         WiUw==
X-Forwarded-Encrypted: i=1; AJvYcCWTxOzh5oATCgKqOQI78xpc2/6JYUk8tZB2dkR/0zlIYsZcFvBx/gx0mD+DzjkCFK+oPyHoh8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdFjMAHCotCh5ZnIXCc9WEKFAUI6OaBbdgF6Qa6va2x8ycF6t
	mCG6x9cQyIvXcHkIrGpdNEflx7UF2RzLP48R+MyohwlyTY/nIgo2hBl3ADbJbz2rVIPUIIJN9C0
	eGuDZcMljfn6QYzDfu9Y2Dh3s6bsk/cOoXXxbxQV6j8ibjUgARsIGpSBJhmXqXqZGN/sRmD5kvq
	N5AI02bt59u4NreuaSPtNwQvmmPXcNXY79
X-Gm-Gg: ASbGnctYC594MHoYLbtsj+pIcUEpzFyh4rHstGeTL/s8mWlfbkQq9xlBMGCURk8okFD
	ERtss7y9u9v5st32ZwWO8BsENE+ZRTt1PrK0uR368NbGoPh1hDYm1C+qzri3l+I7D53mix1nhDS
	qnULCEppFOeWZpzgG/fjldvA==
X-Received: by 2002:a17:90b:5867:b0:327:fd85:6cd2 with SMTP id 98e67ed59e1d1-328156c623emr18214875a91.24.1756869200498;
        Tue, 02 Sep 2025 20:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTcvOJVfQMP9AtXeCfqc3GqOtFGl+2YHKFjgvAyMuI4oaGeseIgP7UAQtunJbi2+5RUMMF8o50W85VET7Ldak=
X-Received: by 2002:a17:90b:5867:b0:327:fd85:6cd2 with SMTP id
 98e67ed59e1d1-328156c623emr18214850a91.24.1756869200081; Tue, 02 Sep 2025
 20:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-2-simon.schippers@tu-dortmund.de> <willemdebruijn.kernel.6b96c721c235@gmail.com>
In-Reply-To: <willemdebruijn.kernel.6b96c721c235@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 11:13:07 +0800
X-Gm-Features: Ac12FXyivnmUX4HGcNjFfQl5uUVCs0KxooT46aj1-W0YWPU72YBI_ajqRuEAnwE
Message-ID: <CACGkMEuE-j0mwHUvDg9uocGCG78HAX4oCXVbt-YS7t5G1LTPfQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ptr_ring_spare: Helper to check if spare capacity of
 size cnt is available
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:13=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Simon Schippers wrote:
> > The implementation is inspired by ptr_ring_empty.
> >
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  include/linux/ptr_ring.h | 71 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > index 551329220e4f..6b8cfaecf478 100644
> > --- a/include/linux/ptr_ring.h
> > +++ b/include/linux/ptr_ring.h
> > @@ -243,6 +243,77 @@ static inline bool ptr_ring_empty_bh(struct ptr_ri=
ng *r)
> >       return ret;
> >  }
> >
> > +/*
> > + * Check if a spare capacity of cnt is available without taking any lo=
cks.
> > + *
> > + * If cnt=3D=3D0 or cnt > r->size it acts the same as __ptr_ring_empty=
.
>
> cnt >=3D r->size?
>
> > + *
> > + * The same requirements apply as described for __ptr_ring_empty.
> > + */
> > +static inline bool __ptr_ring_spare(struct ptr_ring *r, int cnt)
> > +{
> > +     int size =3D r->size;
> > +     int to_check;
> > +
> > +     if (unlikely(!size || cnt < 0))
> > +             return true;
>
> Does !size ever happen.

Yes, see 982fb490c298 ("ptr_ring: support zero length ring"). The
reason is tun reuse dev->tx_queue_len for ptr_ring size.

> Also no need for preconditions for trivial
> errors that never happen, like passing negative values. Or prefer
> an unsigned type.

+1.

Thanks


