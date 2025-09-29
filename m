Return-Path: <netdev+bounces-227082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A811DBA80E5
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E4218975C1
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE5E238C0F;
	Mon, 29 Sep 2025 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq5Xguna"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E4238C36
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125962; cv=none; b=kwgh6EvGiWWlL7h307H4bpZEutvTl9A3GUEgnvaDIcEbB29c46rO/4ZV66h8TT/o9wM2wNnUzdrgSWwPk3DapQ/PZk7oVXMtuUT7JBi+hEdA/LduNnTH8vbu8gL+HyG/I8eDg5x4tbf59XyVJth2DtVwXLYFkyVVgsKEFEildt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125962; c=relaxed/simple;
	bh=4ZVJUKJcStOkfQvNu132ByH2QSL2oYRTRtM5t2938z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDPfmgwWgKgaVvKp11f2jbA0RS4pIysvP3xco2iLSVBuF8QIhxXQHxVSV5c55iGBevvDuao4tBhBqdXfUPi/YzSTQS6W3E0Ni5vOUDqMD0llKxKquONQ1WcrW1tAhcwNa5MEZI899gqYFZRdm/BLsz1gE98Kfuld1wVYiRAsnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dq5Xguna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1yGIQOsQZ3m8F6SURAT4ync4Dvco6agAIcb00xK3BQ=;
	b=dq5Xgunaqhs2l5WgHv8lbg8roz+C3fwbLoGf8ChBTx9zIBeCSrEviji02T7gvg8MNTRhMN
	LUZWbq9Sc7IVFxr4O/11AnjfY4kFOhvsnDvLSM9BsbnPeFLejEkTiGTCwqJHa20dw4pgGe
	80mlj+ttL1nmhtNjEbQbcHqaJi4IWGw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-03WpyuF_PNGa5NcYz1MJBg-1; Mon, 29 Sep 2025 02:05:58 -0400
X-MC-Unique: 03WpyuF_PNGa5NcYz1MJBg-1
X-Mimecast-MFC-AGG-ID: 03WpyuF_PNGa5NcYz1MJBg_1759125958
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-744bf8a764aso56565467b3.1
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 23:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125958; x=1759730758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1yGIQOsQZ3m8F6SURAT4ync4Dvco6agAIcb00xK3BQ=;
        b=xGW5jMbSOKd86kQCQ98LjNNN8I7b8Q7ZO3GvOZZf1Y+40CdiYL59BXbPBOy6LT0OY/
         rJYN+k/mIYCjU0xokqyG/nClN2JTbCJ5IDftFd7alhvlkSfCb9/eWDpFdW6XurS76Rgu
         lg7d9Do9zQTiwsID+HZeUjUPBQyN3P7LBdANoBn3RNKTMCqGXgqdDQBrpC3jdItwYa8P
         oGPc+9ptfKa0ziRLWlSrlc4GpZe/6xKKxHcaVUUo/dZUPjgh/6dgZqnL5K98R2fuvlST
         1NyRko2r/i6MCSwZMm2IGHqW5iN0yksjceankvb0TimiWmIH5yve506VuNsE2GM+IFCQ
         ofeg==
X-Forwarded-Encrypted: i=1; AJvYcCX6uWxuil/SFjSx5DaH88oq2gmrR0mqq0Fjp6xBB1DuQkdQMr691Bgao4lwieYyQqujLc1GsCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIac7LcHF2hiO6b3yxBoI+I+5erng3UM50YvQaO+b5+l8xmo3X
	mvr8LpCPqzI81Tv1loPRIG0E9crk2jQWiTiIuXbqS/PdbdK7hJFli59Z7xx5AwKROlCubjJoYLi
	cQa5p1wqi7ck6iiM/fZpa4Rer8irmaQrf3LzVCBHFX2/MnJ2zsdiIWHT67684MQWs+eTS1rdO/w
	bUJy1vhK/+hw5AOsCEscM6yoA8bMN/7scm
X-Gm-Gg: ASbGncsp1Jde+bkAy4CkJd3ows4oeqz6vJLVyFyVcj+DAf1iB4Vk/4XxOj8ThyMhF9K
	QKEYeIc4QaB6XvCivvrDUnzBUt4Cq7N9r4T7m0jQsSAUr8R22R89+cjRjqhdoF1X/I3deRY/UgD
	bGbwAdkgzUKmiOwjWbJG5jANrZRNwfoe1gfNg/OC4k8vEILihUsnFCpY1YpplmjnV1/SOYCrPF8
	rF2ze1k
X-Received: by 2002:a05:690e:4289:10b0:636:ca97:d6d2 with SMTP id 956f58d0204a3-636ca97d773mr16173571d50.20.1759125957872;
        Sun, 28 Sep 2025 23:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BjaVuGyoNFx3yUGngOCBRLm43JB3sIAw6ThgC682NtQbB9nf4C73RlWOHPZlMIy2Osnpg0Z6d8vSJeF229Y=
X-Received: by 2002:a05:690e:4289:10b0:636:ca97:d6d2 with SMTP id
 956f58d0204a3-636ca97d773mr16173546d50.20.1759125957498; Sun, 28 Sep 2025
 23:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNfXvrK5EWIL3avR@stanley.mountain>
In-Reply-To: <aNfXvrK5EWIL3avR@stanley.mountain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:05:20 +0200
X-Gm-Features: AS18NWBs1i9BHagRuYUX084a7zMJ_6ylNkBNHWiX3YPpcoyysxZQU5lwQENWqTE
Message-ID: <CAJaqyWfBoY0_X=xRnGBecDFUJqSJEitgVKzopumA4fsZVfC11g@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:25=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The group is supposed to be copied to the user, but it wasn't assigned
> until after the copy_to_user().  Move the "s.num =3D group;" earlier.
>
> Fixes: ffc3634b6696 ("vduse: add vq group support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the kvm tree I think.
>
>  drivers/vhost/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6305382eacbb..25ab4d06e559 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                 group =3D ops->get_vq_group(vdpa, idx);
>                 if (group >=3D vdpa->ngroups || group > U32_MAX || group =
< 0)
>                         return -EIO;
> -               else if (copy_to_user(argp, &s, sizeof(s)))
> -                       return -EFAULT;
>                 s.num =3D group;
> +               if (copy_to_user(argp, &s, sizeof(s)))
> +                       return -EFAULT;
>                 return 0;
>         }
>         case VHOST_VDPA_GET_VRING_DESC_GROUP:


Thank you very much for the report Dan! that should be fixed in v5.


