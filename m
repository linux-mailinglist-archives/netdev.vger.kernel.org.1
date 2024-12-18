Return-Path: <netdev+bounces-152853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8499F603C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DC216A176
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E189BB6;
	Wed, 18 Dec 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFHXCwZC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247614F9E2
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511039; cv=none; b=VwH/DujkTJpFXhBfqjn0ZiM9M073QoMt2RLHJFNgJAnvqqgf0+pwByULcnwdH78soZcAbCJvURKQOVQP3U2EMMpKo3PcovUDeHAF5xo6ki67tgc7oBYiev6sF1WAERfLyQ+yNnTrqMITcnu3AQkXj4ejtEGsq6p6gA8F0yba/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511039; c=relaxed/simple;
	bh=KdNSPTYzI0yXRPOSxU2NZR4f+TDNEOZLE396GR9IUio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUbOnmcG5phJ3l9YkeyHv5IFuD18pJ//xrOh0kmT6wn3nrndnm/LWuum0QLb+Q5KmQewckpETejYqTjNbNBNoLLU+2Rd76WBhXTL7QBxDOTGkOj9z/11I/LmadFF1yR0nqGa1PwTxhm960sgpGXX2ypURW1mgs8ZayzAPuODJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFHXCwZC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS4RlJkSlafscPifZWZnqyNOXWHjYSJdsZMAPTjf4Xg=;
	b=gFHXCwZC6d+os9litCKmuGxIq1OysxKJpIhZw+Q2h6OnEYDzYiqbZi93KY/8HCnjwT85Tf
	Ahd56vdnKBfebDowEWVdkpzs9qgtTqjSO0tfmKudFfz7APoPE6gltrLWjn12gN+xEc29s0
	KrBG8+x03BUh5JUAVSwyL550z2Xgnqo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-HzHqE8cxPB6YIHIcE2fpkQ-1; Wed, 18 Dec 2024 03:37:10 -0500
X-MC-Unique: HzHqE8cxPB6YIHIcE2fpkQ-1
X-Mimecast-MFC-AGG-ID: HzHqE8cxPB6YIHIcE2fpkQ
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3f01eeef8so4601952a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511029; x=1735115829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS4RlJkSlafscPifZWZnqyNOXWHjYSJdsZMAPTjf4Xg=;
        b=OnBxz1SqjoUeFfISGSBoJcI8PnV/mBZoqDk0S54m5aApoPfqnZ//I9bD3aWR/hvUgX
         wE844R2JEN7yxf4TwkD5TWStvzQ8O7nzVRjwkLkO0DVku0tqIUu8Wdkhw8zQZtGDts9Y
         k3I27IV5afgKbnnhCwzRMQfGTf8Yo+nbPg45sNBjb05thE8Qib7hJMwzLoCUPTHOLmD0
         fr3+JdIUJoZ0jzkffbvvPWW2eguzWQwfj5QbMG8w/W9neldlTOY3qTnCaoinaSHfDTum
         EivQR6ZMU11PyOeHvMZTl2b1bmaE3xu7OEFpVxGpRGYM2MGP6n6R6onfiZ4Pg0K8plj1
         6RPg==
X-Forwarded-Encrypted: i=1; AJvYcCWFkx6xKGN39cI+UHAG7gF7LQDrNCbcjgp0zKfyOyR2ZfFoqu9I3x4woo10gUL68a6vict1nJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CxVC248Lu3lirqfMXEPBUJuxo1VbT7VdjaugPwEy52Gpueqq
	DisuNkOTmAawgRRYowBVdj6fSWrrh2YUE8MCYg+U8IfxlbCDPsTahV5QS3arTwZg1DTpWWZ6r6E
	9F19Ln13/erCEcz86jH36i+/f5GNIIakgg/hbLFH2BPGeLudzssRz5b8Ri3Yu7nQPqc9K88fcBk
	8bIUs04llbfgtamjn+pyROIKg6XGCE
X-Gm-Gg: ASbGncuD6flb2oMerKQ+4SC605YjDsdgaTQ/g1hLYjTrLcBz2BxKHgDl0fnGFszfxYm
	kUyJgxgine3BeYXwBcgTzNBnBs0MVXed//8kRDio=
X-Received: by 2002:a05:6402:34cb:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5d7ee3b57ddmr5014751a12.17.1734511029516;
        Wed, 18 Dec 2024 00:37:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsTO9d3Y4gBzRKxIZ2rqQKa8yVFxcJFzH6jsY0ql4eXDtA+BSmNxlStP+pIpwj1SFopfPZm0RqzKTnvpwlDD0=
X-Received: by 2002:a05:6402:34cb:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5d7ee3b57ddmr5014697a12.17.1734511029163; Wed, 18 Dec 2024
 00:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-2-lulu@redhat.com>
 <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
In-Reply-To: <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 18 Dec 2024 16:36:30 +0800
Message-ID: <CACLfguVbD_eti13-yVezT-z5Hy=U5FVNwmDO4ogVY657EYv4DA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:40AM +0800, Cindy Lu wrote:
> >The vhost now uses vhost_task and workers as a child of the owner thread=
.
> >While this aligns with containerization principles,it confuses some lega=
cy
>
> nit: missing space in "principles,it"
>
Thanks Stefano, will fix this
> >userspace app, Therefore, we are reintroducing kthread API support.
>
> nit: "app, therefore" or "app. Therefore"
>
sure, will fix this
> >
> >Introduce a new parameter to enable users to choose between
> >kthread and task mode.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 1 +
> > drivers/vhost/vhost.h | 1 +
> > 2 files changed, 2 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 9ac25d08f473..eaddbd39c29b 100644
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
> >index bb75a292d50c..c650c4506c70 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -176,6 +176,7 @@ struct vhost_dev {
> >       int byte_weight;
> >       struct xarray worker_xa;
> >       bool use_worker;
> >+      bool inherit_owner;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> > };
> >--
> >2.45.0
> >
>


