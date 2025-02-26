Return-Path: <netdev+bounces-169668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51686A452F0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB15119C2B36
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73D219A6F;
	Wed, 26 Feb 2025 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuP770TJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F5217F31
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536195; cv=none; b=Qi29+AkR/S6P2QaRRmrLbf0VDuBHv6kOHjqBbas+FHFWzxrKbc5aBIB3GJeBCE+Qob2L2Ezf7WaRGXLhmdcUYaMET01lQxJSHLWWxiQHoYI524Ry+gEWSBiIS60JzeZjDH9uG5viM0vjrFaMwepmt4CXn5d2VV5kVJJfpCtUoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536195; c=relaxed/simple;
	bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sErG7BF9pxIhTssUGPn6tkArAAmHYryaeTERHWIlb9JtQPHzGhPTUwtedltC/sLm+TAFEhmkO43bKTkP7+VeCZCoY4Ky3PpEDAaUGR9alTYk49MfFPB202fZMpYIFYLlUvpDSvj1I8OSOiYPaS/AN8GJDPjePJeARA9/UVzIriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuP770TJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740536192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
	b=JuP770TJi4vt6l3oAK6QQfLxyFtaQVCLEIncJixMhZ0kQfTCQdb3PwB8LcD8DySBpsX3fR
	StSr4suXTsAOx8bcPQTG38kmZTcNoR0olK6xDj+34i7IVEWKYolq3Bw9ZThqfYMVgMXvJH
	8KP3kdykMip2dH23o0ZmUxqsVdJfcro=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-n_URIwkCOhWy1Mn-teb2bA-1; Tue, 25 Feb 2025 21:16:30 -0500
X-MC-Unique: n_URIwkCOhWy1Mn-teb2bA-1
X-Mimecast-MFC-AGG-ID: n_URIwkCOhWy1Mn-teb2bA_1740536190
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e08a9627d0so6985231a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536188; x=1741140988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
        b=atU4oC2FAvoUCHgUI+3a/DtfSZa495AGkWElzNezlNUC91/0fDnrUL4Dgct1OahZGK
         51J+7BadZOLA4XePfVRFF31IRQ+SH1XjTlk0obqNcrz7Wup2Z/Tdt0drj0NQbGLtGF6R
         jt2fA2SLJ6YfXdwFLrnrVh1lNwI09EQAsceUlj83v+LqCJ03/AlVXXsthgv437NjtE/5
         HrRomqj7c/BOKXEIdDSM6g5R/CnnISXqyIr9Bd+eU2I9Oe7yBCMmFePEAn4Escye0KOO
         OCHkm9FZqwUamUNhnEK8n0En4/M4uGUEXDZFonW0bQ0csMpHQVUkYnPneIn7LpCRBypw
         ZGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgk7czG1oERvt0u1G9OswHZSMcDJL9nY7H5HXxFOrsgNye5PFm+2v4b9ThDL9+yYiNu7A8qzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/CXIlpjcdDTPHGVNgBF85TQB93RRDsJSR7XDyZaAIvCQ0tQf
	+4C8TJfQbONXwgBajMwQOZD4nge0leXNXmDFKh0cCnHmkLqBb9+Cj8OmwOp695ZkAspFqZp1NfF
	I87qMoZlcvLZ8JaLn4ImqWu/6PuPXYhkBticWJrRBIm3BvpddHl7hqf4GNygo16yauCGcJCV/lI
	qJb52/Ue+S5G+mH9UIoIJxpYOmJIL5amFr4yBj
X-Gm-Gg: ASbGncsNxqRMVHsRIUh4y2Xff/wXGUVH0QqaL/Ya9JknNp07Xwqf8pm1SA9rHBhAnmM
	Znz+xHGeR+TbADE/NBMSyMXcUdURuEQmLtJ5amMdDTwU1JYk6uVZGmBLB9DFEXDsiURNkOI3HRA
	==
X-Received: by 2002:a17:907:7814:b0:ab7:e3f4:51cc with SMTP id a640c23a62f3a-abed0dc9452mr553604966b.33.1740536188070;
        Tue, 25 Feb 2025 18:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhDcZYBxYTCIPyqQmJDzTI8escqv2G/xUepMmTfzT/MW2sRWZSvR7tUcN9f1IoR9eS9p/9t9NJQgWekG117/Y=
X-Received: by 2002:a17:907:7814:b0:ab7:e3f4:51cc with SMTP id
 a640c23a62f3a-abed0dc9452mr553604566b.33.1740536187769; Tue, 25 Feb 2025
 18:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-4-lulu@redhat.com>
 <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
In-Reply-To: <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:15:50 +0800
X-Gm-Features: AQ5f1JpCVVTdAD7in4OYX8nBzFHVlW0XKfuEec4cZsngVbG26UwAUfOQRbaJMlI
Message-ID: <CACLfguUpbD2LMz+yn6zK16yto4X1UUjV_1dRa_VJDsx0fXmi2w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Add back the previously removed cgroup function to support the kthread
> > The biggest change for this part is in vhost_attach_cgroups() and
> > vhost_attach_task_to_cgroups().
> >
> > Reuse the function __vhost_worker_flush, but in this situation, the
> > attachment_cnt is 0. Therefore, add a boolean to disable this check.
> >
>
> How about just tweaking its value to INT_MAX so we can avoid this new par=
ameter?
>
> Thanks
>
sure, will change this
thanks
cindy


