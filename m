Return-Path: <netdev+bounces-154672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E59FF5CE
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 04:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEFF1882BA8
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F091BC3C;
	Thu,  2 Jan 2025 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZkwquN6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62E383
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735789035; cv=none; b=fics6SyxUtBYq+nWDONGvR7qDDMcxsVSe2oGaghHmoqYcXGcChXBZtTpW0WsreOodR/mUNvFRvzbG8aT53UHJjs96lsA32W+oEv9qtUjaakPRqYW4jENb7DIoWkisgvUgr+8HPrjxiXDElojqExC3qi+9V49B65jTtYMNIqWGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735789035; c=relaxed/simple;
	bh=dmWVtMJmFlRHZQQDk24frBVte6bV31kYMB9RRd/bh3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv3RDj52MTK9lGnj3kzlP+uh1rpuDC+sPe/p2IrgTaZsCVV+82/4PzbmzDsUVZCqBYuxIUVvhl3/DoPDOFf/OKYWQN4hnVJVbzaHygXrQ0hQkpJC9ltFN2s42NcGZyb20Xq2aMQWOnDXb2Yg8B9f/6hsO3oJkdUrGKhQ9419lG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZkwquN6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735789032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffpyplUxGLhUi/V0eUe73+tbKbjnY3d2j011VHNHs5o=;
	b=cZkwquN6R4ns9mAo46fPprka6+SoKJtZkN8fELUzkDtlsywyYxJSVb/y31GZtNeY57rpiS
	of5blKgrBwy4CTlPiJSnAY6XZx8s8PDBkM6bRmAfrq3SlDyMZ5fA290kTUMqQo+sadwclo
	jlhCmzKFGyhV9n4DDGswEij+/omcjFQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-II7DwF4GOIeSZN589NPvFw-1; Wed, 01 Jan 2025 22:37:11 -0500
X-MC-Unique: II7DwF4GOIeSZN589NPvFw-1
X-Mimecast-MFC-AGG-ID: II7DwF4GOIeSZN589NPvFw
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21632eacb31so110239895ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 19:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735789030; x=1736393830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffpyplUxGLhUi/V0eUe73+tbKbjnY3d2j011VHNHs5o=;
        b=Rcec/+7RYR0U9v3EAZ5B+62GiCrCwlab9z1Wa0QaNVfgeYL0RRTxk0xa4IdjopKOy+
         RnAbkQwaOfTA7i0b2YC6kK9r5t60Nkjp7IxFI3Uah+FjKGSwuoKaXEHf9IGwP6Dka+10
         0wG/T0BjOzwQTKFhtm32chkvDQB7DmnSZdQgA8KWkQ4WV8WqOmVt8ArpxZNr85Y1T2C8
         xi49G9gf1JRqJ8Dwr0O2x+2jHvSrCkhR91OcjurBC5aP9RB+6STN8gtxca7sThWGe4Pv
         DVwyPYtTsPF1QkIw0bJ9Z+WcPKS1FuiOCiLmZvwX/nuD5suZ2LZ+JWRk1HFRx0V5mytE
         rtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoBDzbsp64U5gZiFts1EDSkh4UE+CNRpfX9CUG+6e3abARis6WVtbOAdgEyKrhcT3MgaiTqJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNp09oVZ4NXK7uKoJH3v4KZXe96/DO+Db8edK2uuEercaZmBcn
	kMxBi7+D+3THj8ZSC5N+yJFWP4wmZAtlQ6WoIi/sj8/vCO6xWKTXIjea9al5yCew7swHdo0Vt2m
	IO0jVd8h7pSjIFkQ7g/ue3IKXMg8EqXVxAXt/6tBss+63lck0Xt8xferNA4z4ecOcjobOvwLdwN
	YM3mpuiEh0TL7/ws5wPsYM+A6ZtdNS
X-Gm-Gg: ASbGnct/31lAkykaG9ztipe86ITGJazwVkh8lUlJVj2oVATu+4ihZQ5r6k/OP35V3CW
	GZl+PWFQxz7SMc5XwUMBKCd2QsZ47XvmtKgZB8B4=
X-Received: by 2002:a05:6a21:3285:b0:1e1:aad7:d50d with SMTP id adf61e73a8af0-1e5e084b681mr79856344637.46.1735789030339;
        Wed, 01 Jan 2025 19:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv9voIrD/iC8Rr0zAukNWK0gKJsHiZ7mn9bKIKsQscGCQLf6WtrHGHwnd4n4LmogxuLWDEsoR/KjeMR/J8sTU=
X-Received: by 2002:a05:6a21:3285:b0:1e1:aad7:d50d with SMTP id
 adf61e73a8af0-1e5e084b681mr79856318637.46.1735789029927; Wed, 01 Jan 2025
 19:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-6-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:36:58 +0800
Message-ID: <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ff17c42e2d1a..47c1329360ac 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       u8 inherit_owner;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +       if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> +               /*inherit_owner can only be modified before owner is set*=
/
> +               if (vhost_dev_has_owner(d)) {
> +                       r =3D -EBUSY;
> +                       goto done;
> +               }
> +               if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +                       r =3D -EFAULT;
> +                       goto done;
> +               }

Not a native speaker but I wonder if "VHOST_FORK_FROM_OWNER" is better or n=
ot.

> +               /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> +               if (inherit_owner > 1) {
> +                       r =3D -EINVAL;
> +                       goto done;
> +               }
> +
> +               d->inherit_owner =3D (bool)inherit_owner;

So this allows userspace to reset the owner and toggle the value. This
seems to be fine, but I wonder if we need to some cleanup in
vhost_dev_reset_owner() or not. Let's explain this somewhere (probably
in the commit log).

>
> +               goto done;
> +       }
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..f5fcf0b25736 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,23 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +/**
> + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vho=
st device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread=
 mode
> + *
> + * When inherit_owner is set to 1 (default behavior):
> + *   - The VHOST worker threads inherit their values/checks from
> + *     the thread that owns the VHOST device. The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (=
kthread)
> + *     implementation, which may be preferred by older userspace applica=
tions that
> + *     do not utilize the newer vhost_task concept.
> + */
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> --
> 2.45.0

Thanks


