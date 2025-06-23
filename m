Return-Path: <netdev+bounces-200208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD3AE3C1D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8CE3A3A05
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6F23958A;
	Mon, 23 Jun 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeIChkIN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F2238C27
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674087; cv=none; b=UYWZjFjnwYHFcZPYRD5jsKIejnlbBlnlqtZa2uWqTD7jCwA98uAQyBlHr8ZFtBfiN/3qSfT8jOb1pUwy1oCebiMUvNLHNn1Do2KC+9zka3JTMKcgB4zbB9FSWZhgSZqQUPTuI2h/i5pOp9TAAZZFrqsKcm67CevjoOhlpis0XRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674087; c=relaxed/simple;
	bh=CadnOnqUrP01j9sf1g6sUWHOFqKProxbSycYgQcVmxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMNLODUsyJYUGfDoQXV8A2L0C2AZgV7b1zl0XT3F4rfh2sPmr1vWFkpgfyjgzQM5Hs2SVKDKQ6OsaoBeo07oH1TTioVT1s1fSdAQjCqTQ9d6FKCRDs4lxikjYl8E2Z0VrGIOS+iRgap6iRFWCWvZpNVuEHGOIVHyCsOJQ6UZeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeIChkIN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750674083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lgw/bD4SindaQDwTXpeWQKLQPGV/k/mx1XMIx/reNQ=;
	b=MeIChkIN5mc9k0qLQ4zz/42LFZIUspwtuzfbWwT6CVQrEwM+5hCN8j5uDPLN1PsF0W37tJ
	SOUsdn0eclikM/i7IOyx7+jMyYYfClPQpCMP+488KxB7UiFWvoRa5IftHbyvPoK8P+qhmU
	pe+02ONbknHgKmx9lxQ71m9/DV0TeQA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-FfxBbhu0MpCIFGhLqSWNew-1; Mon, 23 Jun 2025 06:21:21 -0400
X-MC-Unique: FfxBbhu0MpCIFGhLqSWNew-1
X-Mimecast-MFC-AGG-ID: FfxBbhu0MpCIFGhLqSWNew_1750674081
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7118199f959so60180217b3.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674081; x=1751278881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lgw/bD4SindaQDwTXpeWQKLQPGV/k/mx1XMIx/reNQ=;
        b=O3rI3IwMiyZCLaTcRZaF2E+aegr3jKL7aRnbE68n3c8Co2qbDwpNgOl+cRtF/KAHj/
         RDK7cjVRJvGYM8ZAXp/6iNQVODyzv4nET7RurRFjFXqYtkFQap7gmBjSTGyqxDbCwGA2
         94lfLltuuBPtfyYBTruGktTwZlnOkgzm/NHX52Z8u4XwaHgfpoIb3b7bKYBstLDb1EhP
         m/P1aOUdnUgBO/hYEvd/mm2u7NPfBE+2lak5jxoVjJaFV0MPrx+Ms0k2OUGT/gpnd2FY
         TyN3WliQqTOpz8rgKJ/6AwFBwK0n5nTb8cxiEvoCwJpo5/TYIgJZFvMJSYyQihNxO1UT
         E6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWI52byXrqMC3JQ6hN7aaY0RyBhCg7pc1qh7KuQG9riiyNIzmQSrhw6cjgv55aqtjllLdBrDV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc60sZSNGWpM0+syhjc3ddMF9aBdClS4iFA4oWRAW+zVPtIdfn
	QVH991wSGptMKVUdy1m53RZKmL6iNMTI0Gx8aHmSrnjR36/TEFgqvoVqEgMMo8jGl9FM5HeoyTh
	rMKcPjHGAd3BPUlRzfKxahkSPJLfXk8qof2acFkll9/V8ztJiNys8rwiJdrgzsLEJdKmccoX/g7
	upT6OE4K0WsQNh+veLnBXkjTM/nFbc1Wvq
X-Gm-Gg: ASbGncuDycMfrdVepg2APNLv1t+R4joGKg0wpRA7Xc2Ar64lj5Cjh2qkOuZiOt+Uteu
	tYd+ImUGHtSUK77u5IR3Y+Yh9ObFBXqs/nHuyiRn03O1IFGSof9AEAYG52ao2vr19Tbuvfr9XE2
	PZ1IU=
X-Received: by 2002:a05:690c:6f93:b0:711:7128:114f with SMTP id 00721157ae682-712c63c5613mr173777327b3.12.1750674081369;
        Mon, 23 Jun 2025 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFiDnn92RagGTfufzHsxHhTXMUufsWyR4eKoIQO45W2ta/mlkrX/GRWBBKswWX0hUbhvXY3gbxHPfx0i3Xsoc=
X-Received: by 2002:a05:690c:6f93:b0:711:7128:114f with SMTP id
 00721157ae682-712c63c5613mr173777017b3.12.1750674081105; Mon, 23 Jun 2025
 03:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618114409.179601-1-d.privalov@omp.ru>
In-Reply-To: <20250618114409.179601-1-d.privalov@omp.ru>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 23 Jun 2025 12:21:09 +0200
X-Gm-Features: AX0GCFvydjAk0H9SdIviYpopwIHMR0R5bzlGmZzRGrpaLGnO5vBQo-A0rDztVy8
Message-ID: <CAOssrKddunTkNzY1ydgg-rpi1aTuq-ghgJcVuQOXnK1GH5HCtg@mail.gmail.com>
Subject: Re: [PATCH 5.10/5.15 1/1] fuse: don't increment nlink in link()
To: "d.privalov" <d.privalov@omp.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 2:00=E2=80=AFPM d.privalov <d.privalov@omp.ru> wrot=
e:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> commit 97f044f690bac2b094bfb7fb2d177ef946c85880 upstream.
>
> The fuse_iget() call in create_new_entry() already updated the inode with
> all the new attributes and incremented the attribute version.
>
> Incrementing the nlink will result in the wrong count.  This wasn't notic=
ed
> because the attributes were invalidated right after this.
>
> Updating ctime is still needed for the writeback case when the ctime is n=
ot
> refreshed.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
> ---
>  fs/fuse/dir.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4488a53a192d..7055fdc1b8ce 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -807,7 +807,7 @@ void fuse_flush_time_update(struct inode *inode)
>         mapping_set_error(inode->i_mapping, err);
>  }
>
> -void fuse_update_ctime(struct inode *inode)
> +static void fuse_update_ctime_in_cache(struct inode *inode)
>  {

Backport is wrong.  In the original patch we have

-       fuse_invalidate_attr(inode);

And that line comes from 371e8fd02969 ("fuse: move
fuse_invalidate_attr() into fuse_update_ctime()") in v5.16.

The fix is to not introduce fuse_update_ctime_in_cache(), because
fuse_update_ctime() is already doing that.

Thanks,
Miklos


