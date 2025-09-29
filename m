Return-Path: <netdev+bounces-227081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1761DBA80D3
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC233A927C
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05051238C3A;
	Mon, 29 Sep 2025 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL048wyP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC91F30A9
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125940; cv=none; b=BH6sbSfnjxTbXwFrKuyxiShu5l/IfpE+1a81FO225wyAoo1g02oe0CQ8mUIyMmn8hvYhqiJxZm52jgxyY1lB+g4iNbsmw2eH5OJHZBk16oZj8xYwvawYmuCqrIF+dcgtERmOkHj6/8XTBfz7BCScB/+3+dHJ4jaIsGkwQ4DK5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125940; c=relaxed/simple;
	bh=9WPqzjmiWMki4xWlLoYtm9WlKZ743i+2Jltc2U63LGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCY+FRPLDKFH6oc3FfY/NkqgPi37wub5o7mW+gdUNfQbzCLx/L0B05VH/6dyPO9GqsZ+iGkvyCxLqxINgG3SjWIpg2zVKeLi7TiXuFeeV1DFvkAcY9zT7fUTifbjN13/i03KoFe/tJ8LS5dr5WuZtlKG7vHLYI3K0iVLqglmhfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cL048wyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEnOtbURDkBn/yuAWcxy2EnBdqVr8YnzLqFxCwWilb8=;
	b=cL048wyPGBB/q1YBW5mK9HYGu2gbx3IO7g+XdSUVl+pr25+3Ll0+z53uMmrlFaf8+TfY+K
	24ck22LhNxhRvAThxSKdIl9bgMvsjEVi42wHLMUPZgRfqjytGx2m/X9vOqXrF+s33sNk/k
	Fhx1403HdWCcfRo69BISzXCoxJ8FEz4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-b48nqAn-MSyXzDIzZFSkMg-1; Mon, 29 Sep 2025 02:05:36 -0400
X-MC-Unique: b48nqAn-MSyXzDIzZFSkMg-1
X-Mimecast-MFC-AGG-ID: b48nqAn-MSyXzDIzZFSkMg_1759125936
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-76c0ad16289so33670647b3.3
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 23:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125936; x=1759730736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEnOtbURDkBn/yuAWcxy2EnBdqVr8YnzLqFxCwWilb8=;
        b=msMkMkmz1rjVm/HTPwizxcRINilNkMI7Q9B+I43jai6d/EVBb5XmSKSDQ4IBD9t3r/
         GS5edfSrq8ifVTtZy204Ft86lpH+RmeBH/+CFBuIsyHhd2A8AwSZQUSD0eotP5XgbH0f
         bpXoETFMuDL9jjTelCGMCiu6KejTWzb+GRwMAWIcRDXtbp1Gdu18JRy80wuE3TY2KRE2
         r/r6Lrndf2h03QOTnOwAdpz+uWbE7kMAmtkL4tLWv2vjxOoC0tbwl35f07FkYi/6PDqd
         gdYL9CELkbRvjz6G/YaAzz8tUhP/sZEb7sk/Dg/OsdMwwqX7Siz78oBnUXlw0svaf4q5
         7u+A==
X-Forwarded-Encrypted: i=1; AJvYcCWq5IoJOx3erZEY+7u+/ydSPz3q9xN3I0Rz5HQOQPQrmYc9ZOewViLC/K66/yvuYCfrvusjid0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ngLE8uR2m6YsM88XI+0vEv1mnUaMU6e5bVsD8fIrBkSWYbJI
	Lzbj2bXgBEiSLtsD37qyN5s5heFIvUpbYO0euZun3CzdtIN5KDVvQRQYg91OKcpSAlqwlcF04CE
	F2a9ByuM7mdDYof82FOFke4F5HGFAlwD3SdisPuMuh+wQzq7syp3yrJbYma494Yco7LdEwY9Lor
	X1SHKvsC7FwqeIimlN4JbM3WjO7iBCjE/2
X-Gm-Gg: ASbGncs7NILiP4L4VJq5Uk1LZVyyHy48O09s+WbO/PM9X63YJLg5jJ0x5yu5YqCgCMe
	xYQMJY3L3O+fsdqUxaUJGvr4gO52cqv7rXbb0FwIFHPwcTLVyrsZkw0xLpeoSQUJgIZJhp95Gzs
	ZV88dArwb0seq21ePXiA3N/NZGUU3c3Sxg7jkeTqpOIMeK1dWQUE0Ub+Lpzghxsrc06zG4qsOxj
	FL6co+l
X-Received: by 2002:a05:690e:2497:b0:62a:38ab:fc31 with SMTP id 956f58d0204a3-6361a70fbaamr12442135d50.14.1759125936010;
        Sun, 28 Sep 2025 23:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPkWT0XTYRzHEmtMC1RyCXLhMmcayEELVp/4odWdM3T+vaRsOTnuGwdr4KePk4Rygkx2XQiQoOU0Uftn//F5c=
X-Received: by 2002:a05:690e:2497:b0:62a:38ab:fc31 with SMTP id
 956f58d0204a3-6361a70fbaamr12442116d50.14.1759125935623; Sun, 28 Sep 2025
 23:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNfXvrK5EWIL3avR@stanley.mountain> <20250927083043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250927083043-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:04:59 +0200
X-Gm-Features: AS18NWCNnLHKyzg0qEsFQJWCKx1nz3MigsaubwNAQ8KOkZjUMutEQnjkPj3UxJw
Message-ID: <CAJaqyWcdQbt=PUG0GKQ8euXVBZMKEURURuHDijPNpzuf2e9xWg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Sep 27, 2025 at 03:25:34PM +0300, Dan Carpenter wrote:
> > The group is supposed to be copied to the user, but it wasn't assigned
> > until after the copy_to_user().  Move the "s.num =3D group;" earlier.
> >
> > Fixes: ffc3634b6696 ("vduse: add vq group support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This goes through the kvm tree I think.
>
>
> Thanks for the patch!
>
> IIUC this was in my tree for next, but more testing
> and review found issues (like this one) so I dropped it for now.
>

Yes, that's fixed in v5.

> >  drivers/vhost/vdpa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 6305382eacbb..25ab4d06e559 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdp=
a *v, unsigned int cmd,
> >               group =3D ops->get_vq_group(vdpa, idx);
> >               if (group >=3D vdpa->ngroups || group > U32_MAX || group =
< 0)
> >                       return -EIO;
> > -             else if (copy_to_user(argp, &s, sizeof(s)))
> > -                     return -EFAULT;
> >               s.num =3D group;
> > +             if (copy_to_user(argp, &s, sizeof(s)))
> > +                     return -EFAULT;
> >               return 0;
> >       }
> >       case VHOST_VDPA_GET_VRING_DESC_GROUP:
> > --
> > 2.51.0
>


