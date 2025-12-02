Return-Path: <netdev+bounces-243269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2AC9C66D
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4F63A5E57
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA429E0E9;
	Tue,  2 Dec 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huZ5mDda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFF201004
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696731; cv=none; b=rhEniIOfWSySoRfrgecH5QFh37sLvKTNHZ4sKMlaL5xz7IJhSp25hT57jClBc0DpjOr+qq1xBY0yeBJew1Zzi3jycYzNnMJbZ1jbovEtQbrD9876exeVzD3d1G0TMOGKLez1xZA4xxibQotFg4Vd7UEuT/t+kZwwLfPWlkmSX4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696731; c=relaxed/simple;
	bh=0xAiPLicgB03cktuxcQuchZBR+UbZFRbsMP564Obddc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV/KEimIRsNrz3j/ybniJxnAfS0+hbUveqr09IsWQWsJPFwIhVVL+cllN/fo3CpkswHKxDK2d08EPDbZFG+sgN59Kd4yh5TeEmpx0Z0qQn3cKEFEMY7LdsDp0+izeK4jk8DnE22PtQdI/7z4h3/+IIz5w7Xo53BGWlLBgH1vKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huZ5mDda; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so1715619f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696726; x=1765301526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZFItyLY22Boxo7GM+d0AYn069sCXHjKGVjBq4SXALY=;
        b=huZ5mDdamWjyaEE60MqnOA5maWKL99SypcSNchj5RcUI9bcuZUEMrGsI+Vk2VudkLv
         4rbuzgWKwMkjTXYS29+PQxdRxT+UiO5OC2v/9v1tmKxdTw/Q1qe4vCA4pVoW4immU1/J
         anze5BGTnxtq4fEan8jByrm/cI5Qmcw58O8o/KA2OwGatX272E7JJfGAbOvVkhi77FrV
         QbvBLnkZhhXaeQUt6aUrrpPWvd06vyVPYL8tdVEab7tXS2KcHnGWX5+8gRR7NQbTJixa
         hhS44pLhaKk04rL548s1uUryO8fWoGkX+ONqumXrR4TuExNrMF/oYWkAKedoKlx1qq1F
         TqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696726; x=1765301526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZFItyLY22Boxo7GM+d0AYn069sCXHjKGVjBq4SXALY=;
        b=olMw5MUAI/gnRKb3bm1vo8YaoOupxRNVh64JVXqrgSpYLLbHUJw/I2+a9BBpEXjqQA
         S+/dJbnlghIDExZIjkrNMYcX49DRpbiuA6CSikj8UnZm9OQT23w3xG3xD6ZQEtCib6ST
         U5OvBt9xV2N7hxToOJQg21ofzx+07UaeSzKN4AgVdCpdNkX6akg9yf93p8N7BAwPLAEY
         wteyJ+D52cStfs0qVT8/Jmp2qVmUkQqadBvOVEVKOc+eGlCJ0Lgl6P61Nf0E7HBTtG3q
         +uG1JH9XBbgl9sf6JtY9EeDUs4QDCdfG88qlywsQRyuVYvbW6TcXreYodHIOb+9acEHO
         h/qA==
X-Forwarded-Encrypted: i=1; AJvYcCVs8WYWHlP86l+XUDKEg20KlmGxKu0lx9d8u0nfp6A7CxXH4/gqYOpMno5PL63gMvTNw2ikwpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtg8WUPU3H0hXTiY5RkuhaOA48Q//IzBc8LbyZdWYBl8sAoY5
	0t0w1OSH4PhX9mCjLWQMFDXa5d5MhfnO14RdfUGojRudIo8vUhcZA6lxxvhL3dYI6klim/kQmLG
	vly4l37SXIUr9A8ShUVcHXQ2G/rMlEamOmA==
X-Gm-Gg: ASbGncsJHlo8/hAh2Vz0EljSbWPf9ZJXK+5ib0PSFXY+GjKgqsTEDqL872Wg7fhYLQ7
	V7Fjm949jl99VmSHHH9R/4t0tcwle7u3yU+DtTSkLyvYrbTkmYpgVbiIDN9NxQXJUmzcqCIa1BU
	fWWyru2NGjxZ5GB1rvVvFKH/NMmBZns0zapXf8CnMzubE63pRjggXwqngB5EtqXVipp0jGgNzW6
	ogYkFyR9y/ok4/OkP78XFkf6WWF6DmXXXIvUJyug3L9A5NDQ+zeVSBPTSQYHTPprc2XNTD2wI5o
	A0AJ/ZqU1myCqDUMpnwnfd8Se/Xa
X-Google-Smtp-Source: AGHT+IEAFgWi6gP2U+zqOrhDN9UN8+v6KtZ+Qnk7WwAuexnI0r211s/FhNyKtGzUTYaYH0Q4SdHFHpeqneIOWU1FExM=
X-Received: by 2002:a05:6000:1a8e:b0:429:cf88:f7ac with SMTP id
 ffacd0b85a97d-42cc1d35d6dmr43796524f8f.44.1764696726355; Tue, 02 Dec 2025
 09:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com>
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 09:31:55 -0800
X-Gm-Features: AWmQ_bmnMVc5ThyHPiVbWV1Iz9SOLG4q3niwo-bZHB9zmrHf3MJLwg2YOziSTbg
Message-ID: <CAADnVQKvRYnKME8-Q24=CqaNz24ibqfbczrRB4_BJxbNcj2oNQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:16=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> by disallowing tail call to programs that use cgroup storage. Cgroup
> storage is allocated lazily when attaching a cgroup bpf program. With
> tail call, it is possible for a callee BPF program to see a NULL
> storage pointer if the caller prorgam does not use cgroup storage.
>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@=
hust.edu.cn/
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b317..9c3f86ef9d16 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map,=
 struct file *map_file,
>                                  void *key, void *value, u64 map_flags)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       u32 i, index =3D *(u32 *)key, ufd;
>         void *new_ptr, *old_ptr;
> -       u32 index =3D *(u32 *)key, ufd;
> +       struct bpf_prog *prog;
>
>         if (map_flags !=3D BPF_ANY)
>                 return -EINVAL;
> @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map=
, struct file *map_file,
>         if (IS_ERR(new_ptr))
>                 return PTR_ERR(new_ptr);
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY) {
> +               prog =3D (struct bpf_prog *)new_ptr;
> +
> +               for_each_cgroup_storage_type(i)
> +                       if (prog->aux->cgroup_storage[i])
> +                               return -EINVAL;

hmm. I think AI was right that prog refcnt is leaked.

