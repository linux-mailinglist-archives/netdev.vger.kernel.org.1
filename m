Return-Path: <netdev+bounces-227083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392EBA8115
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BBE175AD0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989F23C505;
	Mon, 29 Sep 2025 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPRmIJZ/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1244238C0F
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126065; cv=none; b=FG7ZugbRM1REM9u7CcfyW1DxYfvBt/JSs+zOyoFqKQ1+MmSga6ZWGiIlQPgJXkdHbCC5tq+WjzNgPbmaOehET0ricVHK17bARuTQzKzGqN5ujJlyuJUXEy1E9/xY7aVKBbfawsikWAhzXAt3sg1sdGBtE5Sd/gfPEHsrptQlZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126065; c=relaxed/simple;
	bh=IbEySVpKbLCFuZ9rrIjdK5cqttbR+AKe+UCoV2F1p5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liD84WCOKef/m5UaxpWGzdWDMX6uAVddPL4QGl6mabdZ96+c5NH1L1vDkaknhUc+/5Epa49Kfjn+6Jj/2cGQv2COWAfRR9zfs4LlY6pE0+XA1M9l5A73ekotOx5Ih8ZAASUjOB9Ai7wNFvHwoDwQCcvtP2zotlERokBsxd7FQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPRmIJZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759126062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBfJ6EZcrzpxQaUNzV7H/FmOU4A4hPZpwBb7rVCM3A0=;
	b=iPRmIJZ/O41BWHt9Bib6WEbZCsG9dw66mAo/o6tJ9/p3NWUauMi1kgExwXGQ9TDcE6KetC
	N7DrWNnva2d4Gj0rqIrrqaXpz5rMovTRlyn0Q8IzkOqWlkl/wsR1EuJfZvK8aqq+g7YCqD
	1DchwJx2//qOoKhddzKFQkDAQvKajZk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-BWI3Y_-gORCGT1xutaBEYA-1; Mon, 29 Sep 2025 02:07:40 -0400
X-MC-Unique: BWI3Y_-gORCGT1xutaBEYA-1
X-Mimecast-MFC-AGG-ID: BWI3Y_-gORCGT1xutaBEYA_1759126060
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-74983d5be0bso59623527b3.0
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 23:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759126060; x=1759730860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBfJ6EZcrzpxQaUNzV7H/FmOU4A4hPZpwBb7rVCM3A0=;
        b=UB+qRF2JKNk2vpPKFAexF0aq8Q5Q8rkoGELcCgZYGMLhT4vFj/74sDtQXMFTWoN+GG
         rkMDNzJfCImcXgI5FNrhAStupYpAIj9IJeE3GX4vf86M3JfJ+S3+384SMqCoy1HOHHgj
         1jFVyOLycCRTBQpTM/rySCJzLuK4Me/J7eVZafL5FnCEtIhct/owEfXn07tEVSsQY/bq
         b+g/7QT9DOy+SX3Ofz8W+CwP6ydaZOpfjbQjKMZJQLqBBG9Bz5+eMOpYa+3H3itW0bCh
         k/90LR1LSDIqwOacgpfdKWLswzNuP1jvFm0Gu6N9jsyDshvdT1a8ClsA5/ac8P8A/6yr
         7oGA==
X-Forwarded-Encrypted: i=1; AJvYcCW5xYZU5+kuTDmQpHsueUHblrg3oYf++9mxgtWatQZYrQQB+lCk/N/8LCq/6EMZEndO/7mRUWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSaqbBriKEV40+KtbRMg5KEsJovM51kYLRifQXqBcK1glaPYhw
	b/allb4N7f8rXz2W5QCqlmKpjPQvhP4PiNiACDXIKaWchdKz58faDbiUZ7EphuZzpEJ/yL+OIST
	E1yA0cq/FhVLSiKndonBRfBMSm+3gYlRUZCadZWbTDOPtN9ZnqlZ8lKCs/w30QuejU6YCo8PxkU
	BVChzlqdEQy858YcuJEWsHFYGIWTwvy+It
X-Gm-Gg: ASbGnct2yLTkCEk+DZgsQxJ/7mzMNp6grZfx6kNUmQeBM8mLqNdCJpR/7xf4bQFAAvz
	g/GjbZksA4ggh8ICrb89vDdjnerQFUBREb7o0FVkUaNB1xVNT1/YMsjP6Rem7w9EM/w4jq9Vm41
	jFagEV9pbyRHgBc6+BWjuhuSiK5yOv9P8WbL4zPp3uJAobx1ViBvT1fQK4kP9DkFpHhpKg1pmPm
	1fmPzYW
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id 956f58d0204a3-636dddd2be7mr7496552d50.20.1759126059827;
        Sun, 28 Sep 2025 23:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHruQhakXa8wGOKerNcye69UaAM4mVrSZQ9uhbK5P04HWTKnvPzXlUqVP3RMbc5y1i8ThnHdTlq1SvY2ch1664=
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id
 956f58d0204a3-636dddd2be7mr7496534d50.20.1759126059494; Sun, 28 Sep 2025
 23:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
In-Reply-To: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:07:03 +0200
X-Gm-Features: AS18NWC7XMXAuGMO8Eptz-Q_otll5LtJWRETocFL-g0lU0gc6j4WgNxpmozonlI
Message-ID: <CAJaqyWc58wnym96C79E-tG6yBvem5skE3M3vdzBxMYX0aNJVLQ@mail.gmail.com>
Subject: Re: vduse: add vq group support
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 4:22=E2=80=AFPM Colin King (gmail)
<colin.i.king@gmail.com> wrote:
>
> Hi,
>
> Static analysis on linux-next has found an issue with the following commi=
t:
>
> commit ffc3634b66967445f3368c3b53a42bccc52b2c7f
> Author: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Date:   Thu Sep 25 11:13:32 2025 +0200
>
>      vduse: add vq group support
>
>
> This issue is as follows in function vhost_vdpa_vring_ioct:
>
>          case VHOST_VDPA_GET_VRING_GROUP: {
>                  u64 group;
>
>                  if (!ops->get_vq_group)
>                          return -EOPNOTSUPP;
>                  s.index =3D idx;
>                  group =3D ops->get_vq_group(vdpa, idx);
>                  if (group >=3D vdpa->ngroups || group > U32_MAX || group=
 < 0)
>                          return -EIO;
>                  else if (copy_to_user(argp, &s, sizeof(s)))
>                          return -EFAULT;
>                  s.num =3D group;
>                  return 0;
>          }
>
>
> The copy_to_user of struct s is copying a partially initialized struct
> s, field s.num contains garbage data from the stack and this is being
> copied back to user space. Field s.num should be assigned some value
> before the copy_to_user call to avoid uninitialized data from the stack
> being leaked to user space.
>

That's right! v5 of the patch fixes the issue.

Thanks!


