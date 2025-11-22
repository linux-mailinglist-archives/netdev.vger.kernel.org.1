Return-Path: <netdev+bounces-240914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4749C7C043
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A9014E1553
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB321DED49;
	Sat, 22 Nov 2025 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwOF9dFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB414A91
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763771679; cv=none; b=K36IwoiR5nlaffUm3QDdndMCn+rrGF2L2v+7Xx4cL7Mvee6Cbo+FkOrlUavUwy27tJMAJe77H79lbRwn4QRPzmurcimLrpR8VF9pzy5CEnGGlk8oWQxC3Zr5ohikEySJ/YAmfxfSQMVgedqUjdC6RaUIYX9LmH8PY3ncn3LB3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763771679; c=relaxed/simple;
	bh=Pg/OW9saPiNfnY22pVtquN0LCbn+Lzy9m13QsPz3Yu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdA7kFoNQWa+t2+tjVSIUMKSDCvcCxEulRg+RNfiscrIx4oC5XEqXkbOxP4MDN8AB8+hCMJOt/tEHmcWTsCaekh0lw6IHfo+y+nvfQQA6ePVI/rBXSfoQF6muUZO8wQDan9OHT4BSgsbRfcXruZXtJl5pX84IaUQRdZb6icLXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwOF9dFH; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63bc1aeb427so2207459d50.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763771677; x=1764376477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQkS1cETZxYgPThXfkDjdzrQav1uw4NzyFlzBGaLEvk=;
        b=OwOF9dFHbukf7Xyc6QENaigmMxTzPuAN1YsiLuMf/G0vIf1AT3C5P7kfC0lgsjFIQ+
         Aa2rD6OnDtHwozQ4QE3UtdRssWi1MGADvbz3Mro062BJ9c4QA1UcmrDzndY2o8cvQ6xE
         ZPqcbMB58B5bAV44ftYt0pDpEX6E31KTLkJ4cspMvKpVDXplt8TNrJgeul6WO9iDmueW
         Zo0JPoOlFvPjQkETkfnzlxg5P5zYSAHVKph57vBG/8NLsnQ2S6JRT63EJ3shv5MlZy+h
         DHiRdtGvyC/OsD3Bmk8PS+7LpKe/YzQLTAYcqBgZuwONoEa26WHwcMPmPdPYWh8npeVD
         qb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763771677; x=1764376477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQkS1cETZxYgPThXfkDjdzrQav1uw4NzyFlzBGaLEvk=;
        b=uOmVeYhXV2gCax9d1iarD/+WrfGG3o8ItUriipj+FODnlwef0bzDKEhWIq1HWNHqMN
         928M6YAKYgduVBxnsqbjN19neg5Sddl7XdZTs1uZiv6PF5JM1sBAp7w5a3GiylzNlfZ6
         HYz6GQMEuFoOof7KjgtAJvIVz8q3A7b4aC/hp6Ktpx/N+vgRuQDOCJSX1Bvfb43tiYEF
         uxL34JmdT1+IrGrDsaO3sWw/x1rAiaC+Sk26pN3rTEiUOIeq72LaoqOPOH32GlhowseU
         4vncQB40W3ZjYx0Odo435siifHSamv+j/NtiwyVi+EjGUPn5qwMynvPGXeeY1xeMaphr
         OosQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1juO//6qk/6MhOBadjO5f7XD30Z/hDYWquANe74eq9Ce7xKlQLNyb9PL479VJm1fc3XfePY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ho1D8Zs6DG+W1YF/qG1hkPEcvWMhLqHBNg15OduB73ea962A
	NnaZOajgi8cO8jJMOeeJSTe0vs6/2/BmieQSZ585J+YZ+ST9zeplDWilmQ/celSznAj/Zerl+sw
	1uJWwXA8Ua0BcusXl7ejgSL2debBAOfgE/Q==
X-Gm-Gg: ASbGncttM8VkNyVSCUTt4iTCBxPJsF2cwoIAURDNzZuu6LGhHOSUFu6cfJJcGCcq2GA
	c/Amvq4Qi0YaPCMz8tTxIjvf6IPMvSnPANUJD0jhDmiGBT628QzU9XQ2dPmqPceAdjNVoCuX078
	YBaoodKpBe/EgZGGi+5SCMfKS3Qyb8HBkpCRE+XXvE30kjQj7UFpJMWMaM+hu30/BqoRaafTZdF
	RgRf4J5mNIjhRR/3kHJ1/632ApUte3NBQRJX6MqnnRhxrLxgtVzMLEMp1TPO6xcp5Vz77C+2o+N
	/AtzJQ==
X-Google-Smtp-Source: AGHT+IENwuHlGwwYNW8hhhyKct8eakoXi81jziCzpyiK4XX7FIICIoPiBYfvkNIVVnhWlh4FUD8NXF13qnUYmXDph8g=
X-Received: by 2002:a05:690e:2008:b0:640:d038:fafb with SMTP id
 956f58d0204a3-64302ac99e5mr2288195d50.64.1763771677068; Fri, 21 Nov 2025
 16:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-5-ameryhung@gmail.com>
 <CAADnVQLeSP654facoQxW9EHJpLBivdM3rm6WpCsimsnXPbYJ1g@mail.gmail.com>
In-Reply-To: <CAADnVQLeSP654facoQxW9EHJpLBivdM3rm6WpCsimsnXPbYJ1g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 21 Nov 2025 16:34:26 -0800
X-Gm-Features: AWmQ_bnb_zIJIzTox8-b4QZMvdhPNo0o2MJYofRK2yw3ki7OjQWQ04OPpMbjmVU
Message-ID: <CAMB2axPpZPD+h_AmKY2ypNomOHViDCsSxoPUYvikEd1EeGtxjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/6] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS
 command
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 4:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > +/* Call test_1() of the associated struct_ops map */
> > +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, v=
oid *aux__prog)
> > +{
> > +       struct bpf_prog_aux *prog_aux =3D (struct bpf_prog_aux *)aux__p=
rog;
>
> Doesn't matter for selftest that much, but it's better to use _impl
> suffix here like all other kfuncs with implicit args.

Thanks for taking a look. I will add _impl suffix to the function name.

