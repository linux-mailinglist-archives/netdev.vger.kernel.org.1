Return-Path: <netdev+bounces-168875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13017A412CE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FD27A1B21
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFB19D06A;
	Mon, 24 Feb 2025 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhXCxxb7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275519C54E
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362065; cv=none; b=S2yv9zhiHx3eqLxZPdflO5n+haswvGXKWuLIXQVEKnoFninjLBX8E4tGAOtViyKEA4cubl32aELEyVSroS8q7uUWsSmFDjUtYuCTJHcqFpXl+63RaP8UqM1AzzuJVu5tcgsTbTwpzgl/Gbq6qHfy0cf72bQaSxQR5Y6R4jr1hFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362065; c=relaxed/simple;
	bh=nD32JzlTG7byCRBkwQ3uZCofLUfybht+9/Qptp6H5VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLwuJLmwU3Td2XCFT2OZiy28FPjOgtO4z7TjaWT0oLysouGo3FJc2/lOOcqDsx7TJc/D9Mg0w2VQcaoZx/22ajXLsnvBIq7vQKIFvG7wJNIa+6D6sXUKyC6ClN8/JCQ/8LwCIRHe/ZjJmFO/xBAlzu63pa6GeZaDWjiHAqeUD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhXCxxb7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFIZpi/rBPDIT2lHx7g+LDcaJiO1Zdw8ZZRV1t7ECmM=;
	b=ZhXCxxb7Faf4KkO+d+jFB7kWc/ZcbrLzwYEyNT/TPO4b3y4KfjUl4iBPchWEtD3u3qOQN+
	QI8vJRdprGKWTTrawqqbJjRU9aR4zN4N8sVYlh9AS/vQK0F9FB7+78AhMUWCrbnzCyvKKp
	sM1bdDRD5jum1m7PdVkNtbZXoaeV3hw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-EdPce9aQPdWAJikShNSiTw-1; Sun, 23 Feb 2025 20:54:21 -0500
X-MC-Unique: EdPce9aQPdWAJikShNSiTw-1
X-Mimecast-MFC-AGG-ID: EdPce9aQPdWAJikShNSiTw_1740362060
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc2f22f959so9551766a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 17:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362060; x=1740966860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFIZpi/rBPDIT2lHx7g+LDcaJiO1Zdw8ZZRV1t7ECmM=;
        b=ewshEQek1T1eVcYpTiq7TIfhQJMmtG7brhB6irYh9bg70YFqbHJn09nVZw/b8Inc3V
         LfVGKmAvrQLYSFYJxvFjjGuknfHHwhdC6SOLQFnodWYZukzwUri/xV36jGuguvgRX2Qc
         b0g9z4QWL1ebcUoZe6fNEP83tmuGfn1ak3B4EmwjIJpPdqhf7wmNMH9uwhms4n/k/j0O
         0nc/WR1GqR7cYiaubjhdLabhXAQSeqWO/yxinp6rGmXqX54BcTvd6GToj7UNTel0Wrkn
         8Xwzt8Kerdt0rNErcgEg+XqB2AiikoB8/9swo0Y3Rl1hm5eHDlbVRZIdi0FpRbpkvQGD
         bcDg==
X-Forwarded-Encrypted: i=1; AJvYcCXb5crf/p0lTmXs5KKbDo0BbfKj47j1z8ImK9j8WyZGFaI9o3S0+En2lU8ibvpzLE/BglqOK6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOq5OcmHFnkfWFzvCvR65sw4wtOJAYoNN2A358H5oZZy9yS8S
	otvwTq+l27S0kh1pNAWeAXFeJ+2FtkLG4yuoSPW51l1fz23eRgKtCyMCI2qanGOlyY3y47xQ5zl
	EalMrg5/ZhPptimkr3o/xZA3t6iKH7mAyFUycxxTor6GpKCKSlqZxGRX6YmnHQX4+o2lGxtspec
	t90OMQIQSErE22zMZ65ZQ/aC/TZYpX
X-Gm-Gg: ASbGncv/5Ym0h8WuxIraha4CLe18NyjI5/i8UsLhmOnUvMfGb/feW3GIpQB9Jadube7
	ZO3YHpX9JACl7sMAQCIY7j7sbiKrIpKGZZljd7u3+UkQHYGD8yNWc41ePRQJhzYfUr8AtPktgcQ
	==
X-Received: by 2002:a17:90b:1dc3:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2fce7b747ffmr19787117a91.15.1740362059921;
        Sun, 23 Feb 2025 17:54:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQz2cyjfoUI+8wed4h5euyDATeuNA1Cp7VYDQFAtg3WkovlFwcGthW17REqwEC0lBIE42LsNki3cYepbjKMGo=
X-Received: by 2002:a17:90b:1dc3:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-2fce7b747ffmr19787096a91.15.1740362059520; Sun, 23 Feb 2025
 17:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:54:08 +0800
X-Gm-Features: AWEUYZkU_xjE1Be_7zMS3YfmfEN33QEv5naO52XNn_cqkUkwbYxBzK_psj0_Usc
Message-ID: <CACGkMEuocDajb0uANEOCLpXsi47Ga+d5K=oF12gDgLRfC2rJSA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
>  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d8c0ea118bb1..45d8f5c5bca9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, s=
truct vhost_iotlb *umem)
>         int i;
>
>         vhost_dev_cleanup(dev);
> -
> +       dev->inherit_owner =3D true;

Any reason this needs to be changed under reset_owner?

>         dev->umem =3D umem;
>         /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
>          * VQs aren't running.
> @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
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
> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
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
> +               /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */

Code explains itself, let's just drop this comment.

> +               if (inherit_owner > 1) {
> +                       r =3D -EINVAL;
> +                       goto done;
> +               }
> +
> +               d->inherit_owner =3D (bool)inherit_owner;
>
> +               goto done;
> +       }
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..8f558b433536 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,22 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost devi=
ce
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread=
 mode
> + *
> + * When inherit_owner is set to 1:
> + *   - The VHOST worker threads inherit its values/checks from
> + *     the thread that owns the VHOST device, The vhost threads will
> + *     be counted in the nproc rlimits.

Since this is uAPI, it's better to avoid mentioning too many
implementation details. So I would tweak this as.

"Vhost will create tasks similar to processes forked from the owner,
inheriting all of the owner's attributes."

> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (=
kthread)
> + *     implementation, which may be preferred by older userspace applica=
tions that
> + *     do not utilize the newer vhost_task concept.

"Vhost will create tasks as kernel thread."

> + */
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> --
> 2.45.0
>

Thanks


