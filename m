Return-Path: <netdev+bounces-236178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9BC3969C
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D59C3B6FB6
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267A23BF91;
	Thu,  6 Nov 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOQ7qcUg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkIBtQoe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24934D3B5
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414408; cv=none; b=Eq9yQlmFLXdqz/SdmItGBjgYwAq/RXeWIcrNnNBuncGHyBg9nAhl27rGDNOFyT6lZcIaZO1YO/SUFgoVped8gwOYheQp4igse/RbK5pYKgL+pTodxTL80itVqSrxY6G4EtL2Q7Xmpv8hl2dUhx7+hynj/sDQF2Ez+Kxd8QUkN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414408; c=relaxed/simple;
	bh=Z6rDoDbBzZehN05laYqSOz5TF+zWduNfgDpGobbtTm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaLoSEMeO5/36rPiYDUECyeXcimKcA0mMb+gvGf6St8/UyAjQ906o0edWqgj+b0Dd+gt5tRKCZnwDp4Z2ed+1jSCmD6oB+a1jB/BkM8zonvYgNjuDxM+ceuupMEz8ueHHIcO5fPBk2BV5dLA9ZvCkUzju6BszVGPlCqvVQ9qhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOQ7qcUg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkIBtQoe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762414405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYAde5e7XRo2nCFdsgkjpp8tUcZhDMLUB3jHCGqkjtg=;
	b=iOQ7qcUgR97zNz+PCohNQW93bGReZDuyBye0SwfKzLHvAREC34u4E9HUyucltYFd6aUm9Q
	G3MhmT47izEwxQ7AcpjSf3vsspT+u0DXJntfsOLDd8B1GLiv/F1PK31UTxPYvN5flatzP9
	1A7/LZ1ZbsLp3QxOh4l/6QajrzumzEk=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-SqJoG_INMP-TKCnzz1iEWA-1; Thu, 06 Nov 2025 02:33:24 -0500
X-MC-Unique: SqJoG_INMP-TKCnzz1iEWA-1
X-Mimecast-MFC-AGG-ID: SqJoG_INMP-TKCnzz1iEWA_1762414404
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dbd47fb70cso242448137.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 23:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762414404; x=1763019204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYAde5e7XRo2nCFdsgkjpp8tUcZhDMLUB3jHCGqkjtg=;
        b=UkIBtQoeMfJacwopcWshmm8pPW2qB/U2H3q9Eww7yM/XwImLgqjt7vup2/x6Y5kjHV
         wAqQVbhW3tW3fOcYbu8LQcd26dhx9VgpeINJOI2CBf5Wia8P5sKrT50UXYRxfNMxirs4
         UKhr3mJsd1UJSA2iu8Y7tGeatOyN4qgz66c9DZo3NiXajLLP8w3/oqw3wEyahpSMq/cs
         J7NVd3/RUuQ7rw6mle9ad4hvdAnxLvDEJ6kZT5Q7DziKgLmi9ebuPbEWeFla/03Xcr8f
         vzXdCU0JL2JVWvR0qUyjp4htwwDTU+AhPHzPxgb+/tmz2z+Bi+7uHrkV3SbSuwc0m4Fx
         +L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414404; x=1763019204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYAde5e7XRo2nCFdsgkjpp8tUcZhDMLUB3jHCGqkjtg=;
        b=BSp8EL+f8BEt9ce87dr2bWugeKOpfjFADfyLD6OAoApxpNtgGlJZWVGRmgc4ixTcuP
         cV9C7n6I9T1erxsLoDNzuI5DtJ9ChGUgzJNZw2EWZbT8hvcHC0MwVnsdFaJ1n3VaYl5p
         BYFbU7Nd0GYp49Om5N83WC7UnLASR6mrXC7MoRw9Yzl74JnQOP7v98YPe9cBO2TQPzXb
         PNja5gMRkrDqx164HzQsEyQtVcB5FWQMLGKhd0eOFCQYm828q5ffVBJh0H+otMRGJHCD
         INlyVcuE5iLrUI6WCBB9S6qJtaDxhAdO7q/u4qZbmD1YOcRx1I2TzADCsqC1+rDCbuaf
         MN+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMi1R+kU0bRmZ9itFOfVQcnRLZUFWDv6PYXx2LRNbBe7WlZhoXpHN9ODKVeDrXvePnwBwjwU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRWjd3obRtiKIbnvwYQ3mu4hosfbxzV7Ht/GA6XozDtRP4TOA
	KJJUSeZIiWPQQURWFJMpsQq3XNJTu5BNOsuuIGS3fg0cLCj3pvJQSajvAMEpMUAIMyTgPlIG7UC
	Mtcme2fBj89M8RyzjCoBPQAsN3MwKIuYKW80KRhajE8ijOEe1pbxXLaH/kxMNuYsXFBzQgwFkRv
	g///q5PdQ3ypn9z9gpmFbzaMtcSKSiBVP4PgcWUmLGaPQ=
X-Gm-Gg: ASbGncsQHC8eK7vcTKkYrMfmzNjsTakqKRpDQrLBNPLBQoI8eUk4RJ2dB5Np4dmVC8Y
	qLc1d1hUUE5xWIPHjOKy+fxe2RU42SkmkACo4XTN+wtUmzR8iPg2HzS9EBkq5Z5xH3FBrmSJ5LO
	ME0uj1qPQocBvsNzT0BJhYA/xJJ/fS2q30dbA5Q6doiUll911spdNOI+X9
X-Received: by 2002:a05:6102:3053:b0:5db:d07c:218d with SMTP id ada2fe7eead31-5dd9fdb4d0fmr879053137.15.1762414403883;
        Wed, 05 Nov 2025 23:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfgJ5v70iJc90m1C5a8kGqaC50su+K78cw6ZlEPzjU2+a4nohKdaZgEJEwG3WrJX689N8V+NwxJorp4vWreDI=
X-Received: by 2002:a05:6102:3053:b0:5db:d07c:218d with SMTP id
 ada2fe7eead31-5dd9fdb4d0fmr879040137.15.1762414403476; Wed, 05 Nov 2025
 23:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <miwqc3uxmvvs5efvcqv7s4boajxjgko2ecqkyeqk62e4pwjexa@qi24ta7rftx6>
In-Reply-To: <miwqc3uxmvvs5efvcqv7s4boajxjgko2ecqkyeqk62e4pwjexa@qi24ta7rftx6>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:32:42 +0800
X-Gm-Features: AWmQ_bnoiY8Gk32PJh58YA8qenD4YokFKdcWQ14qjx3RkyIPx105xiGyaIgP11w
Message-ID: <CACLfguWr37_OON9f7T3=tu87Fp1ZDm2gKxREikAUCnD8+McVvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

whie

On Wed, Nov 5, 2025 at 6:03=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Thanks for your patches!
>
> On Wed, Nov 05, 2025 at 04:01:41PM +0800, Cindy Lu wrote:
> > Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> > feature bit is properly set only when the device is not yet in
> > the DRIVER_OK (running) state.
> >
> > This makes the MAC address visible in the output of:
> >
> >  vdpa dev config show -jp
> >
> > when the device is created without an initial MAC address.
> >
> So when the random MAC address is assigned it is not currently shown?
> I don't fully understand the motivation.
>
Yes, when the device was created without a MAC address, the
VIRTIO_NET_F_MAC bit wasn=E2=80=99t set during dev_add, so it wasn=E2=80=99=
t
displayed. At this time the mac address is 0. I think we can remove
the VIRTIO_NET_F_MAC bit check when showing it.
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 82034efb74fc..e38aa3a335fc 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_d=
ev *v_mdev, struct vdpa_device *
> >       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >       mdev =3D mvdev->mdev;
> >       config =3D &ndev->config;
>
> > +     if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +             ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> > +     } else {
> > +             mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\=
n");
> > +             return err;
> The err is EOPNOTSUPP. Is this the right error?
will fix this
>
> > +     }
> >
> Why is this block not under the reslock?
>
will fix this
> Thanks,
> Dragos
>


