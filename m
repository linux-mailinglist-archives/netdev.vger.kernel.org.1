Return-Path: <netdev+bounces-186648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5976FAA00AD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638F35A1903
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC325F7AB;
	Tue, 29 Apr 2025 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtR7Al/S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E01D540
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897996; cv=none; b=VihrW4Mwda0O+cH+Bm3dxyaywfXFio+XMvAhwIj8kylLAxmXk9MSMp2Mm9fhy4N8LhB6cbCbUd0zYgtj0qTfXpZFHomciSp1OEgOartm++CV5BCifd9vyLv/W6+wrKLZl03NQ4gyndLoylE9tKld2O5Jjqx0/8cRpLwpEzvPQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897996; c=relaxed/simple;
	bh=CZ+mWcXOnoNmB5QyyZZqqFpy5PLSEtLDvf2WP/DW33Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5IY81P7k903i7L0zL2MQmKDFL2LxcWVt8FcyBPu5xQr0UeMXxVr3y+2AvoWMv1/ecoizQ7FKC3gGrBGAewoxYnnUG9F1YyUKEzq23U4wVuGm+IB4YT1fcyVMGfdw47467mQOkibIzYqn2RWlLM2Mkibn7wHAqi+hexEniVda4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtR7Al/S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745897994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZ+mWcXOnoNmB5QyyZZqqFpy5PLSEtLDvf2WP/DW33Y=;
	b=YtR7Al/SvAHD8T1A6ELqi2CJzDK2Dzw/a7NkdgYu+CTNT5u8DEezCWV1F2GV2xjbG/HY+j
	S7gpVmnSdcEaNzXe/pasMmdAqHqLdZj1Id0AsKbwWElYa0sEYZ2Cm+l2/lSnloZ8cxzrI3
	TBD+UWEGvaFf9aQLipNs5iWYLWJTY6A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-aUxPNY-FOD-3jeBQDz57bA-1; Mon, 28 Apr 2025 23:39:52 -0400
X-MC-Unique: aUxPNY-FOD-3jeBQDz57bA-1
X-Mimecast-MFC-AGG-ID: aUxPNY-FOD-3jeBQDz57bA_1745897991
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3087a704c6bso5416884a91.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 20:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897991; x=1746502791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ+mWcXOnoNmB5QyyZZqqFpy5PLSEtLDvf2WP/DW33Y=;
        b=FbqjmLfV9iaNqiAPFVCBGc/bXS5q5PT+4hIHJlOzQHi1UPEYIdedJxGjtYlKLg0rQv
         NCXlUfW3gSDKFLVEMrTnQSjq9MXLi+mtoLVZxh9vTBs8nLxcKLYB7/ozPyMBrOBfx56N
         aHASZfFXjxOYSPAiXDpWTJoFIlBC3G4id9BOpst7d4wXSZ06mRBcFn3RHa+zgEwmzTGt
         kvLhFexMxzZy3tl5WXZKiv/zfVzhaXws7sv3gU2OEl2MFDMwD4OO+n4+AdXke4XtpZ9x
         Q1DpgybYqyhUnOahIQ3ten6CvV0vBB6LwC35a19R71v1PTJpv7yunST0DWC7VJjHy1b9
         8tww==
X-Forwarded-Encrypted: i=1; AJvYcCV2uEyAO2wrXBujPcBBYUvNnCkOTfoZE4x+1/Q4jDsC0BLOwZEm9ywK6GrWYakLyta4HWm5KiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6i1ULtXvXITQsNT+Zn1ulzHtkyyXUkCG9ZTnDfLFGVp4+kIB
	5MMo22POiC6UoMTo1/uBJpnXIIpg2TkwhAwE8uQZPcS+fWYcgVrA2udflz+vLLCuWmotnuhY6Ov
	c0Al0VQKq0laS3S+eQ3HmhTUchbUYT1+Qdy7ygsrSFXRSDY6zhiCg7rQEiaFcw/Z0W6di7bbuPI
	eSFaKiEPT/wuGlbU2f+o659FvXmG+T
X-Gm-Gg: ASbGnctymbqpIAm+RcZ559+k7vwNIwksSiLHcuw4DvuyQq029fOz1iMxd9+c186gXGv
	DdSkE2824XZ+mZ5PTrQUL+KOOok1pNJNZs15KMnYl2FxcWe+pe3L1Aw7ST0kuvY3+uQ==
X-Received: by 2002:a17:90b:4cc4:b0:305:5f25:59a5 with SMTP id 98e67ed59e1d1-30a215a9e6cmr3195106a91.35.1745897991094;
        Mon, 28 Apr 2025 20:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO25nt6hV3dV111j+arayWq9RJrat5QwpIGcVcLMQhppu+t5T6cKy8dvsGeNPzrwkLvZvBpyPz/UcGeHutQWE=
X-Received: by 2002:a17:90b:4cc4:b0:305:5f25:59a5 with SMTP id
 98e67ed59e1d1-30a215a9e6cmr3195076a91.35.1745897990674; Mon, 28 Apr 2025
 20:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com> <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
In-Reply-To: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Apr 2025 11:39:37 +0800
X-Gm-Features: ATxdqUEwpamsgyJSROjElXTifDP9gzLG-yrcg3CrQ8683svXB8ELNH4GnXFNWQM
Message-ID: <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: mst@redhat.com
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > >
> > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > is disabled, and any attempt to use it will result in failure.
> >
> > I think we need to describe why the default value was chosen to be fals=
e.
> >
> > What's more, should we document the implications here?
> >
> > inherit_owner was set to false: this means "legacy" userspace may
>
> I meant "true" actually.

MIchael, I'd expect inherit_owner to be false. Otherwise legacy
applications need to be modified in order to get the behaviour
recovered which is an impossible taks.

Any idea on this?

Thanks


