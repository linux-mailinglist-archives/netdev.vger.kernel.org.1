Return-Path: <netdev+bounces-178964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7845FA79B97
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 07:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C667E3B6E06
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD319C554;
	Thu,  3 Apr 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5p7U2Xz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991519885F
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659591; cv=none; b=AQycxUOkIQXky7HZPyjOKmJyutGJDdQvxTWkaZhyJuUxpw1HcSgydyqpNd0lTOqZsNZzMH70numHf+wYz/sRmMoKdh/9C1lBIMTG3bvx9aFLgLCgd866wifY4rhiwBzc+fopynDL+zjfGq63BsIGF8mB4AdEY3pGWozxv/x/hYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659591; c=relaxed/simple;
	bh=4bS5onAMqnZXsH3MQL3fZNQzN/QQVysLsc6zj/UJdIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA6a2cwxVhxVSRbQP569rOd2KV7qH3s5j9XUKiaxnCZQE2Pl4N8GR1f9PodNgceaiGLc8s8BAxTQByS2rSGgHZBxgtMvbtAD8g9LrXw3MhAdbucmYOHK677JNOffDUb2ndGHDb9yn5P0W3FAhkU+6FiAgHB82+pyv7b4i5johI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5p7U2Xz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743659588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3jbd2doY1NSOX00VkbRurvkdLq9F5tN6tB0xPnD0Og=;
	b=U5p7U2XzKE/QDl8ZXuLr5dvZXS3Xh131BVbeK7JeAefhEMPfn0+AgXbsfJOMAI4/vcjn9p
	hAThUNzOEMsfF/PH3hB2Y3GFy+VfFHv4zdqnSJjqN65pGXtSQsLnW++Zk5UHkbs7FEUcd+
	qaQK1e8lrUTbzK6ytH8tAmSLuDeyixU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-BPoPX5iAPv-bAsKDqoa06g-1; Thu, 03 Apr 2025 01:53:07 -0400
X-MC-Unique: BPoPX5iAPv-bAsKDqoa06g-1
X-Mimecast-MFC-AGG-ID: BPoPX5iAPv-bAsKDqoa06g_1743659586
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac6ef2d1b7dso36985566b.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 22:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743659586; x=1744264386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3jbd2doY1NSOX00VkbRurvkdLq9F5tN6tB0xPnD0Og=;
        b=nBMMx7+SskC2heiGXakF8XOQ5Fqs10Cp6OIq8smwwuaRDXVQdws60rWD93wW/5NwxZ
         FeiiUNiOjAI8FoOqMhLkoS9dXLfjdhMoKeeSk8THrHo/cRlY0z53FwvocdC0L3WxNmHL
         +hNHUpPMT2q0N1Dh6dkfcdkmYhSQukzZCGTtOhRJYpqOxy+rhfie3NgM7koSXWxA/NKD
         7rxggkAmwpAlRh9YTpazFSx15AvEabQlpnr1PZE35iFn5crlB/CfCxwPeZdwGdCCfNPF
         uF6DRRfWjulH/YH6TToPYVZbyeV2tIzQq3hwSvGxnfQM1da9L0g3vB4L0LNhGBPyn8bz
         cwzA==
X-Forwarded-Encrypted: i=1; AJvYcCUDJ2vPl54HIBChXM+lpw9XxQi/9NHevDO2DjJTxT+XEGPBWlJPbYe4LDppDVcjUSysqZ7qbQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bIEpYhoduRM+CWtKjvjkqzFc1+RZbQD9Zlpzx+pPBTK8I9Iv
	gTSTNFgSdwTSZsSrRfjWipOXPJB+gXhGAhK4KKBNiUooJF3N38Q4uD0V2dsEEHPqx/DlwK3KhAa
	0gVrQuP24sJ2mMVT7wP21BaA1TVDzH7MFCZ2afJSADbeRwmySRLbxlvP53X4eSnz0snXi9hAmVT
	+P+e/6FcEpScezoPGsbjGZMz+wQlBh
X-Gm-Gg: ASbGncuOb7RGD6r9tp5rvtsPxrfnzKPl9uToZHi+JzuxE+TqA9iNk5nzPHOeppsLQME
	yVZNIa4EkhuRCrxHQ7wd6pW6hjTFSnEb74yf9ap944gvOu12h98aM161yyOTBF0K82UbhK0lK0A
	==
X-Received: by 2002:a17:907:7daa:b0:ac7:322c:fd0c with SMTP id a640c23a62f3a-ac738be4bc5mr1287978066b.40.1743659586304;
        Wed, 02 Apr 2025 22:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Z7xb5HzuAp3VvTBF4XJMRYjpTwnMri/J3XyJV/X24GWV812YboBMK2hckDCVRlWhGZcOzWwt5e0C8UfpFi8=
X-Received: by 2002:a17:907:7daa:b0:ac7:322c:fd0c with SMTP id
 a640c23a62f3a-ac738be4bc5mr1287975866b.40.1743659585908; Wed, 02 Apr 2025
 22:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-2-lulu@redhat.com>
 <74u5ppfmuf4gwjup3eotpnd6bulocerdk4l54qvykfcnesf6hm@udabnuiw2v6y>
In-Reply-To: <74u5ppfmuf4gwjup3eotpnd6bulocerdk4l54qvykfcnesf6hm@udabnuiw2v6y>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 3 Apr 2025 13:52:29 +0800
X-Gm-Features: AQ5f1Jo1foH-PvZGrIRlU2VXTP0saZl6MC9BSYsmGgkgWtc7Py14P3qzqSSJo7E
Message-ID: <CACLfguW+k0BJQMMU7fRKqJtidA=+p=Ky555bhcZ0kdU8fJOhhQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:30=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:45PM +0800, Cindy Lu wrote:
> >The vhost now uses vhost_task and workers as a child of the owner thread=
.
> >While this aligns with containerization principles,it confuses some lega=
cy
>
> nit: missing space "principles,it"
>
> >userspace app, Therefore, we are reintroducing kthread API support.
>
> nit: "userspace app, Therefore" -> "userspace app. Therefore"
>
> >
> >Introduce a new parameter to enable users to choose between
> >kthread and task mode.
>
> I would explain that by default this is true, and so we are not changing
> the behavior with this patch.
>
Sure,I will change these
Thanks
Cindy
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 1 +
> > drivers/vhost/vhost.h | 9 +++++++++
> > 2 files changed, 10 insertions(+)
>
> Anyway, the patch LGTM with or without the commit tweaks:
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 63612faeab72..250dc43f1786 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> >       dev->byte_weight =3D byte_weight;
> >       dev->use_worker =3D use_worker;
> >       dev->msg_handler =3D msg_handler;
> >+      dev->inherit_owner =3D true;
> >       init_waitqueue_head(&dev->wait);
> >       INIT_LIST_HEAD(&dev->read_list);
> >       INIT_LIST_HEAD(&dev->pending_list);
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index bb75a292d50c..19bb94922a0e 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -176,6 +176,15 @@ struct vhost_dev {
> >       int byte_weight;
> >       struct xarray worker_xa;
> >       bool use_worker;
> >+      /*
> >+       * If inherit_owner is true we use vhost_tasks to create
> >+       * the worker so all settings/limits like cgroups, NPROC,
> >+       * scheduler, etc are inherited from the owner. If false,
> >+       * we use kthreads and only attach to the same cgroups
> >+       * as the owner for compat with older kernels.
> >+       * here we use true as default value
> >+       */
> >+      bool inherit_owner;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> > };
> >--
> >2.45.0
> >
>


