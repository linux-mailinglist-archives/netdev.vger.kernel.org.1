Return-Path: <netdev+bounces-243277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B0C9C715
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431043A58BE
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B12C17B6;
	Tue,  2 Dec 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYUpz3BH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDF2C1780
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697481; cv=none; b=DF6e8GZRJ5p1fy2BV7WzvFy6OHJUAc/LM7OsP0TxmUS/fetprltU8h4f9hv7mqYBlJBubxTXUivX6cFsALxNac/aHsACxvTeM2PBg4l2cx40K1k0FDsA1BhyCnqFJw9oXNJui86R/hLiQZcoTgl6ozIcBwyWxwGJcn9QtagIFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697481; c=relaxed/simple;
	bh=saK7OctyxgWhisy+qF8s5lx1yaFhDmsKK8qlbKzyuWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9F9fO1nDN4Ipjzk6X9EAEycPVvZj+mdOfkyprmDZlnbnZ9uNy6DbwozNd8AARzP9mtVwnUuXKoZpiu5zzE4fi2KgSwSvD8FvXmlsolsDf7VjX1+/NB+wqsrMLaFfTUM/AdanO/+fCa6G03cauND4kKOBBIQNcZu/c/f3HykDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYUpz3BH; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640c9c85255so7490329d50.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764697478; x=1765302278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1QXCWStMxfmVW47fiVgRuxVCfQyLhwauTimKRg96bI=;
        b=EYUpz3BHxGKJy6h+H32v9YGW3xEuPyBMFZh2HmiAMrGiyu4HiPRrpZahfcabUIuTss
         zRCPklywF8Ge4QhjiVcEok/91OLh/IV/F1sJIn++JoxaI0UQ7bDKbo+p+LWLpUe3xRZn
         IUFg+w8rM8jM0qYTb+cFgDTnPPySa62fF35sCDJZkmlqjMgzfXCCTs/hDZNQEGHalmFt
         ZpvnOAdeT+M/TvUywgyALp0EYMojDkeyVB6AnMIkNlEFxx0yDmD6m53YhiApY6cyeoU5
         HxXaldaG/NY5/eV9+Bl+Wq5dcqYe2eJ0snTZ1CiFHdSuSMHPudl3GCjPz7ZxHkRrnzZx
         c8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697478; x=1765302278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1QXCWStMxfmVW47fiVgRuxVCfQyLhwauTimKRg96bI=;
        b=sjB06UEv4FIuQB5FBmRZeAhiDwRyb5YKaegk8NmKWl3GMaxiNwh7k6kM5310sVyqFm
         //hSYZ0Gw1sKms7byjFf1HTk07a3bLJhnwqtH6zen9TiMLcK4OcpT0BHLIMX2kz1UGsT
         NiyP+qoCvRmZRIs3AFkQppOJo+MfzYMDQptwKNW1D/8z0Qme1FKUExkl6qzcyyXek+dw
         104xYDbqUrIPrPIvRaqlg6wUUsMLZ5I74Jsb3nDtXv3K/j86plgwZ8Wpsm1zYNAoUrAx
         Duli6jAfiMpeswozLtZVRQ3wOl3NJKvoGzEzDBvRF+3/Ca7pLVi74PRabpXaRcwwdcpY
         o9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUn35rfZ1yTxK2x1eorpF6fQRmwIaKwCQgqO2Cf43AqWoP6HXQ0mIPcwG7wqu+3KIShgLcOhEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lRLdkv2XnX4kYPf8prLd0BscBxqXGKXVsDf6naffNpsTbO/V
	u+nh33hPixOTnbBF2IQeHSPnDk0EWZjbFxLSd7s+JQ9MXbO4wJuPpeKVEjKW1rKDsqJoXEiIG14
	CJXcMZ5en1DtSZS86JpjvJ7HGVoZ1TbA=
X-Gm-Gg: ASbGncslWEynt/6+QThoHRPO4bar2wE3FGuZ4Rroi3k+Pxc8XYt4anOURfQd85B4uB4
	RQ1sCjLnIqDKT9u3A+w/yCxzLQltBBY4v/CLG8sqWyifxYEo7o6y9r9kRm6GjhWYH+/w+kt/yXB
	5q9nXt4bYHfI87Ory+2dUuXgL/HezwdyIH6R7I0aH8PWDboKhn0+/7C2i1b787SHWSlfhX7W0Qp
	X9fGCDdqeQ1hnK3dRPg2O0xoulZffcFOUX89yvbOj45vqcjf9lB05P0eDDZ45eE7dPJhGhBkUCW
	LwI1OzPTtus=
X-Google-Smtp-Source: AGHT+IF3T7gonVEzDbMH1IjvcZAcl2do8qpFUbUVbAiGLDEWU32llXfeCPujEBw+pJANdPjzkmUbRgZcUQJ0kyPObxc=
X-Received: by 2002:a05:690e:191d:b0:63f:c019:23ee with SMTP id
 956f58d0204a3-64329320b2fmr20274229d50.21.1764697477976; Tue, 02 Dec 2025
 09:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com> <CAADnVQKvRYnKME8-Q24=CqaNz24ibqfbczrRB4_BJxbNcj2oNQ@mail.gmail.com>
In-Reply-To: <CAADnVQKvRYnKME8-Q24=CqaNz24ibqfbczrRB4_BJxbNcj2oNQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 2 Dec 2025 09:44:27 -0800
X-Gm-Features: AWmQ_bkeUgvkkC8TtxSkopI-F7dx1MlUMA8yZ5Hhz__NeAUN7rXeWM3a2PJkCis
Message-ID: <CAMB2axN3ZyvvRLAD=xUE_VO9a9aAAYq5DV6_vym5wRTy+xNi+Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:32=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 2, 2025 at 9:16=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> > by disallowing tail call to programs that use cgroup storage. Cgroup
> > storage is allocated lazily when attaching a cgroup bpf program. With
> > tail call, it is possible for a callee BPF program to see a NULL
> > storage pointer if the caller prorgam does not use cgroup storage.
> >
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> > Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521ad=
b@hust.edu.cn/
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/arraymap.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 1eeb31c5b317..9c3f86ef9d16 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *ma=
p, struct file *map_file,
> >                                  void *key, void *value, u64 map_flags)
> >  {
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> > +       u32 i, index =3D *(u32 *)key, ufd;
> >         void *new_ptr, *old_ptr;
> > -       u32 index =3D *(u32 *)key, ufd;
> > +       struct bpf_prog *prog;
> >
> >         if (map_flags !=3D BPF_ANY)
> >                 return -EINVAL;
> > @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *m=
ap, struct file *map_file,
> >         if (IS_ERR(new_ptr))
> >                 return PTR_ERR(new_ptr);
> >
> > +       if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY) {
> > +               prog =3D (struct bpf_prog *)new_ptr;
> > +
> > +               for_each_cgroup_storage_type(i)
> > +                       if (prog->aux->cgroup_storage[i])
> > +                               return -EINVAL;
>
> hmm. I think AI was right that prog refcnt is leaked.

Ah right. I forgot to map_fd_put_ptr(). Will fix it in the next respin.

