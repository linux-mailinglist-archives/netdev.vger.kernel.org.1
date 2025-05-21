Return-Path: <netdev+bounces-192100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD34ABE8C5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3765C7A7683
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20052745C;
	Wed, 21 May 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDYv4LMO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AC18035
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789251; cv=none; b=HI5SVYdUs7aAzjo06dCf5MvnivwGuSEq9/9OR+j7cz0q8PFBnSvOPuraqZc0iYvGDR6Kyn4QdDMajJTSp1fmukmiU81CAANFxXQPac5pEZM+gx4YYaMO6lHMpPlWgqEq8euQc4TYeZAHRBRD3lI0zyEAtUQ/XelR2OdiTcOSKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789251; c=relaxed/simple;
	bh=UwyvllrCJPVWC5ocFz+1hBFct3kBz9xuj8wxTC0pGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/M9sZa9Tc/aPYBBhFa9FMy/VySRpbUiH1aZylQ3Zzl4vy6deEQHDv855SF9jcVEfBp5eATDOQ3x92AvAXKDaA9aGiPDrYZWFfl9bavVWfkR/sliHsQ5gXERhuzIgyd2hQxwmVBFBUt3TCBDinOpFQ2MUFWdPwEhzDlJLnD0FwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDYv4LMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747789248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5UU96bQp+9c05rasuJ8OHXH1EUH9d+HdLZb9k7tA/A=;
	b=jDYv4LMONJiPa0plOzvVZiPQhP+ZNTTsEiSyVgUjMOa4NH8WcD4OMdte18VUqXlvybY138
	p2uxuPJs/nT6pCRvo9AF0GyXjU/WwcljMRobxg+/hQzBWrRhunATDPolmG0yquCCmDBG32
	38RBzTyQAyXrnYOrvt1d+gXd7yC5l/o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-mY34ZWlAOI6bs3gqIkZNGw-1; Tue, 20 May 2025 21:00:46 -0400
X-MC-Unique: mY34ZWlAOI6bs3gqIkZNGw-1
X-Mimecast-MFC-AGG-ID: mY34ZWlAOI6bs3gqIkZNGw_1747789246
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30eda215ea4so2777526a91.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 18:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747789245; x=1748394045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5UU96bQp+9c05rasuJ8OHXH1EUH9d+HdLZb9k7tA/A=;
        b=Frir5moYCEyyp3tGXB4/ThnDnr6vTg+ehO3ivH99uScl/lzT0pEQzhSQERk8EAu/nw
         T8B5ROAsAOjEt8bL9uG9fl//GIupWa1BX6kQ4Iahwr463QhaUcq0GENFQ0eVQpIkQPwa
         LjZ7D9+SFMS1YcQg6uGkMUcVf33y63ccoEIwu4XKskgyJ2/Z6jefEdRWK0zCdG654Au4
         vmN+mzISp1y7tb/7aVMJk86QFN/D7uviVSvUL4cQtTrbR6nqTaTPo/TQOAju3WKMCah3
         jgshD+mt6rloUzvj5Y6FS8iDOp+dSmDK452kB75V6g2Z54e2m24kCyCEQ2Gh5QEsd2wB
         oP9w==
X-Forwarded-Encrypted: i=1; AJvYcCUIIo19+EEU6LLAn+f0OxRYXWdrGql6+tMwpiHHVlC2979sqkluUt4g21mJmlW43zrJdrgMtMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XbLGBUl7+QFj0g+kRekrX9M8vLB9NZrNAyIfdrecmIn+DvA9
	rTxec5H+yrak34PtRkUOy30dkH04BO6UzxrnEsrneJOWqQ/Fdg48WV6IkjfxTjEFyvC/PRFB1fx
	tIeOtD8VpXsS9CFRvdk/Jpgb0UpGG4YEa/56sOZtrw3klS3MTFlKSDnF/qfbZcTCBPtIWjlZSXO
	6fmFIujfw5iVdg3imCHqA/M1s4CQYQ56bs
X-Gm-Gg: ASbGncv6MT7bviMG7ACsFbqfOfEAhzfSWSORwllrMimEiPmdSMd3/YPH2WqE6cCys91
	YhhTOFX6G3yK1tzwq0hCUmuOb/XdNbTmLiUzZM/hyY+bA3pRYpF3FSdRR8I02E1nAiCx6PA==
X-Received: by 2002:a17:90b:48ce:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-30e7d53fedcmr34181863a91.17.1747789245669;
        Tue, 20 May 2025 18:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwcEKoM8Rbsn/a4WndKnzdXbjNGmiuWmbI2Y5I8bxlXXtoVUQyT+CI3h7RbvzZ1zmkJYmKWfeUsMGX5k4wCxw=
X-Received: by 2002:a17:90b:48ce:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-30e7d53fedcmr34181821a91.17.1747789245236; Tue, 20 May 2025
 18:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520110526.635507-1-lvivier@redhat.com> <20250520110526.635507-2-lvivier@redhat.com>
In-Reply-To: <20250520110526.635507-2-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 May 2025 09:00:33 +0800
X-Gm-Features: AX0GCFss55bkUwZRoC8YeL_R-ecnSY7xZLVonSottICbFZGTPlnRjiGhH-GAQn0
Message-ID: <CACGkMEsO2XFFmJm4Y__9ELo5YQOve1DgE2TVOO2FgB1rmZh58g@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_ring: Fix error reporting in virtqueue_resize
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:05=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> The virtqueue_resize() function was not correctly propagating error codes
> from its internal resize helper functions, specifically
> virtqueue_resize_packet() and virtqueue_resize_split(). If these helpers
> returned an error, but the subsequent call to virtqueue_enable_after_rese=
t()
> succeeded, the original error from the resize operation would be masked.
> Consequently, virtqueue_resize() could incorrectly report success to its
> caller despite an underlying resize failure.
>
> This change restores the original code behavior:
>
>        if (vdev->config->enable_vq_after_reset(_vq))
>                return -EBUSY;
>
>        return err;
>
> Fix: commit ad48d53b5b3f ("virtio_ring: separate the logic of reset/enabl=
e from virtqueue_resize")
> Cc: xuanzhuo@linux.alibaba.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b784aab66867..4397392bfef0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2797,7 +2797,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num=
,
>                      void (*recycle_done)(struct virtqueue *vq))
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       int err;
> +       int err, err_reset;
>
>         if (num > vq->vq.num_max)
>                 return -E2BIG;
> @@ -2819,7 +2819,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 nu=
m,
>         else
>                 err =3D virtqueue_resize_split(_vq, num);
>
> -       return virtqueue_enable_after_reset(_vq);
> +       err_reset =3D virtqueue_enable_after_reset(_vq);

I wonder if we should call virtqueue_enable_after_reset() when
virtqueue_resize_xxx() fail.

Thanks

> +       if (err_reset)
> +               return err_reset;
> +
> +       return err;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
>
> --
> 2.49.0
>


