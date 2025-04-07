Return-Path: <netdev+bounces-179507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1DA7D271
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251B63ADC1C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 03:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A70212B0B;
	Mon,  7 Apr 2025 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlejdInf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24D7FBD6
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743996016; cv=none; b=Evkwde1RCNhR3W8wCWeTQrEdD3fOSkp1OypGOoTi7qu23zx/YU2ppKAG0rLwrWzXHmynl7bnFFttolx9AzpIXN6cTsJq9RYvT8thpSbX+QjfkAFnyGRZic7TGUWKqbeziuLmqJZQemEns4hS7oOcrDy9YXwHp5MiZkXqxiLumpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743996016; c=relaxed/simple;
	bh=u0c6Avm1gLozqeIt/1O0xn96n0POL5Eca/kJDjcZzkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRsCbDTzrJPYFZjvrATkIwoEUGzqTii6jLC4vfEP6oPveb/4qj06VJ3s9jc9vJ6SckKMPqBDrItuQvJx9UmYkUhrw96LJGbuQMyzWDYs+y6wpB5bbnK1MbVAJH1iMZeOvIiozjQUHPx2wlIOWXeELV7nlhJqQ2IjqmpQyNFCG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlejdInf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743996013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKZcnqeoJM6ayZoyXnhIBesFK061IAtxlU5uJ2H12OE=;
	b=FlejdInfkb8z3CW8nRkpOXcnxACsEHgWAy25yiKj8zV9jbbbZSj01GhOIsqpfUmviofnDI
	v+SPWfqydaaWteAgur6rxjdVPMPb5ay50dReopKtnn0Xpdht4Earjhr4xsoO3AA8QqgS8s
	PZSg1PyFqKB8LQ2/IZK8ak13CF6y43w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Tytpvi1pPPOZilCH03O9rg-1; Sun, 06 Apr 2025 23:20:12 -0400
X-MC-Unique: Tytpvi1pPPOZilCH03O9rg-1
X-Mimecast-MFC-AGG-ID: Tytpvi1pPPOZilCH03O9rg_1743996011
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3df3f1193so299739866b.2
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 20:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743996011; x=1744600811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKZcnqeoJM6ayZoyXnhIBesFK061IAtxlU5uJ2H12OE=;
        b=uB3xDoQF27yEnjGC7eOrP5bCQkIJOfTl6StxAf5LSvZmX9+EanlfS5MuhNLuYJGWih
         ts95dWZZHNakivTGaZRbwCGkIemCsySoffSal1kk8sGWlhwkdxzQOLUhODQNC2y98428
         RpeXBUoB2gdSgQDr7tJPaFngtI98prLB+hwaFfogtZyWqTFajJUhUg19B/uFJOPmlY+G
         pA4fLManaSmWiF9pdEeTZ2HmKpSgGEiUWMHIupLuRgLrXadIsEdRk1N7X5t8XjcDNzaJ
         jTdbZbCmf8vi0u4/EzaV5ij76hijkdRYtEI+HjVuj8wxEHD3q6HOimEA67Zkpe1AoI6f
         d8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV212XZVbyctieMDKXCEXPP9JO1aOzlddHPIbOaDJ4C+RvEd51EwXhb6DrU2IBVg0ujCXmd9do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0jBWykXWP/m5nkEsaWgtZxB96rWFe5fYcPH2VZ2IdyXOTfGN
	Z9/3tc56Mg/gnQ7Geo4bJ9b75LDdW6TqzXIMejM3/wq5VqG6n4kD+bq42Fg7GDYn7XMDdJFPqys
	wm0QoMu22NzryrwQzoJxh7UuvFAHEJ/pF8ZnbYKr2Q9hB66l6C82/LT0jW1xglpY8+FXtx4BQZE
	KZ54ppxczH10kyGuJNKIw8GfSgrTyl
X-Gm-Gg: ASbGnctikDdlYFriTv5278yUUSZw3B1nPLbVO2emzb9y8byi/Wo9gZ1Nin5g49tgRci
	Pf96hyKYgx22lXIgO6YYb3YFyeLoCjpjEDYbXVxJL6OlxcyzvhG9PDjs6Z6WfoQJlgy7iTXrBjQ
	==
X-Received: by 2002:a17:907:2cc5:b0:ac7:391a:e2d5 with SMTP id a640c23a62f3a-ac7d6e9fedfmr940790566b.60.1743996010759;
        Sun, 06 Apr 2025 20:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyaASIls+cOpryke10gRp95gULeuPF1FuQluD5pPvHsnbXkXlhIa7Ty4Cap0zu4wlhYBi4L2p7sScEvmBHme0=
X-Received: by 2002:a17:907:2cc5:b0:ac7:391a:e2d5 with SMTP id
 a640c23a62f3a-ac7d6e9fedfmr940789366b.60.1743996010431; Sun, 06 Apr 2025
 20:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-7-lulu@redhat.com>
 <pgcopzs6q6kqwlmndtbt2bdpbj3xvosjjxb7vikte3gnt643xh@5qhv5myd2cpc>
In-Reply-To: <pgcopzs6q6kqwlmndtbt2bdpbj3xvosjjxb7vikte3gnt643xh@5qhv5myd2cpc>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 7 Apr 2025 11:19:33 +0800
X-Gm-Features: ATxdqUEqOkuVmABA1s36h59JIHqt9NVOz5EMMRXCcAsp0MZnvUrNJ_xlQuJAb58
Message-ID: <CACLfguV9F7wR=NE1GbjMuvFL2drZ8FLSR-UPPfavWvsuoWJPBw@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] vhost: uapi to control task mode (owner vs kthread)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:57=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:50PM +0800, Cindy Lu wrote:
> >Add a new UAPI to configure the vhost device to use the kthread mode
>
> nit: missing . at the end
>
> >The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
> >to choose between owner and kthread mode if necessary
>
> Ditto
>
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
>
> Ditto.
>
Sure, will fix this

> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> > include/uapi/linux/vhost.h | 16 ++++++++++++++++
> > 2 files changed, 36 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index be97028a8baf..ff930c2e5b78 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, =
struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> >-
> >+      dev->inherit_owner =3D true;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> >@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >-
>
> As I mentioned, I'll add the Kconfig in this patch to avoid bisection
> issues.
>
> The rest LGTM.
>
sure, will fix this
Thanks
cindy
> Thanks,
> Stefano
>
> >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >+              u8 inherit_owner;
> >+              /*inherit_owner can only be modified before owner is set*=
/
> >+              if (vhost_dev_has_owner(d)) {
> >+                      r =3D -EBUSY;
> >+                      goto done;
> >+              }
> >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> >+                      r =3D -EFAULT;
> >+                      goto done;
> >+              }
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >+              r =3D 0;
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..1ae0917bfeca 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,20 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost dev=
ice,
> >+ * This ioctl must called before VHOST_SET_OWNER.
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1(default value):
> >+ *   - Vhost will create tasks similar to processes forked from the own=
er,
> >+ *     inheriting all of the owner's attributes.
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - Vhost will create tasks as kernel thread.
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> >+
> > #endif
> >--
> >2.45.0
> >
>


