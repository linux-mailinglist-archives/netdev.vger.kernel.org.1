Return-Path: <netdev+bounces-142666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337D9BFED2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1551C234B8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304CE197548;
	Thu,  7 Nov 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiUkv4nw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190B193070
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963614; cv=none; b=sdoKU/zwQHbWUhVEsL36VBOQnuvzOrS+kgKdExqawAJUZ3r/IK09ZPROBiPxE80A+znXa2H3x0NrnDoMgQeg34ijcDN5+FA6SNhF7nvRVAdlW4hSsbVvOLLpfz/zxQXnEZwnpHrNA35FTYmuMTC+KXwfNtpbYVYmQOaCVpN8SoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963614; c=relaxed/simple;
	bh=gel4ymvhzgfyphfkOQM0eCFG3ixHvrzXAL4yolb2Iuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvazDzBmjtTTzkG1vctJiOc8+RrYq/os4NdCltBgKXWEuuOH8DEnXLpGq8RjieZ0gBt0JDUFm2q+Rmp6Bku2jBR6Zgq9bSRuAvWtVzsu6PKUorpZVAT5Xy103w9lHDzH1qCISCfnurYDdZsyyHllk8KQEs93ndJ5AHm2uFDnXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiUkv4nw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730963609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNDSKfo81YRRY9Pw9UoRu7CnoYy3QfKptUrjTGh4Vds=;
	b=NiUkv4nwFDxZBazoL+CtIahBTapjTutQJCPHeG40AX5Sj/t9odrSCKv8uPiiGrTDILXNkW
	4jTDmdSjmt+T6bbuu2KOa5SQhWXXrqmORhet3s8Z823wkonmSmSudyhL49QAZ1m2Qj29u4
	z2UgBwVSogypEK8u8OpHDYSVDDE4IQ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-AZrd-IIFM8KJ3MdcMqlG7g-1; Thu, 07 Nov 2024 02:13:28 -0500
X-MC-Unique: AZrd-IIFM8KJ3MdcMqlG7g-1
X-Mimecast-MFC-AGG-ID: AZrd-IIFM8KJ3MdcMqlG7g
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9e0574854dso43379266b.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 23:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963607; x=1731568407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNDSKfo81YRRY9Pw9UoRu7CnoYy3QfKptUrjTGh4Vds=;
        b=qxfAE1tyWjwa5OBwOTo3yRUfwXcZOgRXXi/tOEm4YayDwxlP1PZZMRWEpleHT3Qq25
         /ZQOZNajqiqiD5yEpxkL0kolUL9u9qXjBwuErjp7CX8e+PRPwmFS9vnlhXxXIBBMKUxk
         C7bH+kpPC9JJDjH/NyLrjLei2P/1wDFv1eIkOc8as2gbKD5t6S8AfR3kwH7H0VKk3IRb
         AopEtGTlTD3ZNpzr13vG7CNdiiW+qO2Da9mVusLzaw+DZ46SyeZHjbB503fcYrIPe4Zn
         05YsDJHdcrq20R6BKT+1qOaS+870e2rfo7lFkhrzX/3Fem3D1fQgdb6tQyxgclnAuSxp
         PTCg==
X-Forwarded-Encrypted: i=1; AJvYcCV9LtWJFgf+s8S/gfcgk1BsLcnFRYIRieAX6eZBvX3j+Nb1/4ofdmgWZd/jdmpQ0WhontWz6qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkW3FEDMuxDGJCWeOSbjsN2C3q4Zuh/V83R1nSTJrQ6KC22cpB
	6W3VsOvvdzI0jFou3ixF2GGMKt4vqt6jzW0DVKgZoy7LzuiUhBijOsrNVSqZW5iNFVP99ry1NsX
	Vk2V8V0mU+t2aYeZ6HohcTh4lsbBvDFhkhIQIMIRh8SL/UB5K0ofTFMwraGkNSSUJGLydN0VD8S
	PChT6aqZGSrtZxbvrZe/yV0hlnxRlB
X-Received: by 2002:a17:906:fe41:b0:a9a:478:2ee3 with SMTP id a640c23a62f3a-a9ee2465a3dmr92173766b.40.1730963606920;
        Wed, 06 Nov 2024 23:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9nOjZkrUMvsk+/S/SdzmWVcuWDW5P1sCd1k6qp08zxaqsUfPOHSxDgZIsk4urxkRouosnxeAyM0eHS+o9qqo=
X-Received: by 2002:a17:906:fe41:b0:a9a:478:2ee3 with SMTP id
 a640c23a62f3a-a9ee2465a3dmr92170966b.40.1730963606570; Wed, 06 Nov 2024
 23:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-8-lulu@redhat.com>
 <6dtic6ld6p6kyzbjjewj4cxkc6h6r5t6y2ztazrgozdanz6gkm@vlj3ubpam6ih>
In-Reply-To: <6dtic6ld6p6kyzbjjewj4cxkc6h6r5t6y2ztazrgozdanz6gkm@vlj3ubpam6ih>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 7 Nov 2024 15:12:49 +0800
Message-ID: <CACLfguVNM_b9LdiMyj+pZH0WHu=-Nrit8-cr+QH9=f7tMLDd4w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 6:32=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> >Add a new UAPI to enable setting the vhost device to task mode.
> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> >to configure the mode if necessary.
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 15 ++++++++++++++-
> > include/uapi/linux/vhost.h |  2 ++
> > 2 files changed, 16 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index c17dc01febcc..70c793b63905 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> > {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> >-      long r;
> >+      long r =3D 0;
>
> I don't know if something is missing in this patch, but I am confused:
>
> `r` is set few lines below...
>
> >       int i, fd;
> >+      bool inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> ...
>
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
>                 goto done;
>
> So, why we are now initializing it to 0?
>
r =3D 0 mean return successfully here.
Therefore, in the case VHOST_SET_INHERIT_FROM_OWNER function, I don't
need to set it again and can simply return.
....
    if (vhost_dev_has_owner(d))
       break;
.....
> >@@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               if (ctx)
> >                       eventfd_ctx_put(ctx);
> >               break;
> >+      case VHOST_SET_INHERIT_FROM_OWNER:
> >+              /*inherit_owner can only be modified before owner is set*=
/
> >+              if (vhost_dev_has_owner(d))
>
> And here, how this check can be false, if at the beginning of the
> function we call vhost_dev_check_owner()?
>
> Maybe your intention was to add this code before the
> `vhost_dev_check_owner()` call, so this should explain why initialize
> `r` to 0, but I'm not sure.
>
Yes, in the function beginning, the code is
if (ioctl =3D=3D VHOST_SET_OWNER) {
r =3D vhost_dev_set_owner(d);
goto done;
}
if the ioctl is not VHOST_SET_OWNER,  then the  code will not run the
function vhost_dev_set_owner.
This ioctl is used by userspace applications, so we cannot be certain
of the type and sequence of their calls; therefore, I added this
check.

> >+                      break;
>
> Should we return an error (e.g. -EPERM) in this case?
>
sure=EF=BC=8Cwill add this back
thanks
Cindy
> >+
> >+              if (copy_from_user(&inherit_owner, argp,
> >+                                 sizeof(inherit_owner))) {
> >+                      r =3D -EFAULT;
> >+                      break;
> >+              }
> >+              d->inherit_owner =3D inherit_owner;
> >+              break;
> >       default:
> >               r =3D -ENOIOCTLCMD;
> >               break;
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..1e192038633d 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,6 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
>
> Please add a documentation here, this is UAPI, so the user should
> know what this ioctl does based on the parameter.
>
> Thanks,
> Stefano
>
> >+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
> > #endif
> >--
> >2.45.0
> >
>


