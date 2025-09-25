Return-Path: <netdev+bounces-226556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD4BA1F25
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F881B27107
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727BC28C037;
	Thu, 25 Sep 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDWMj+yj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66022E54A1
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842201; cv=none; b=Q+fRXaY7d9q5OZdHbTJwDZ5gZ9AJObWXjWmUioX/9cYPFTUM3EyNZOldcOv6vunQ0KH9c9a6CB8JlLT3s6zIlqrFYC7B336G3RaIkkuGYMJyaZuSDxb2jtG3fUyq7cLDzPpobOigQm+rkLAzMzSmuW2PK8yX+us2HH4rT0gpJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842201; c=relaxed/simple;
	bh=QSP5hpmKquI2DT7cAKF4RU+bPaqXuFEs2ESj2HkDt+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZ5tN66wX3240HXLJp0xP01nVxWy6j2dXda1j7whu3Idr1tQ8YVJyoOxpijj8PNfZeKbOHzdCosXKOiJ5W1HRltHM8P8Cy0qKo4vXw3pyEr61W55lVwo4gwV3XVHWZCkbZHpCQTWdiHrd6SmP7u36TtpbsqshRfmc29QrHH1ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDWMj+yj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603a9cfaso15232517b3.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842199; x=1759446999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cFA0nHeOQJ6lV3+re9Is1GE0VicKUVL3iUDVSUeV2g=;
        b=NDWMj+yjEwsNod9RDfSzy27Wl9HraRy9x4xbglmBEM2ozdOnRW5XQv2qIfTBXvp0/g
         EYj1EbnPQsawlCLhOdipRCtY7kOtjnXKlxErud5Jeq/JbrRIXZEqkxyq51m3vTXhcrZB
         TrZNTboOiAD5zNK9d7DXdc8W/XurnmSWEVzrgohs0WO4D4drmCxdadWozxeZrvjAdLZz
         nUuNYRvcJ+N2ngipbrLx2gx2enYRYG5Bsmhee1huuTaOos46HaDVQOW9C42oUOjRb/2b
         I2EHI0+/SV1zBWk1V/SiWQfr+vTi0ciHxnrrhjovez+LLink9Szek83lD6Kh7F/ydsHv
         yaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842199; x=1759446999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cFA0nHeOQJ6lV3+re9Is1GE0VicKUVL3iUDVSUeV2g=;
        b=HQnBXFZSinPszTq8k6awRvIkHn3Vava2TyU/H4552J55Elws48SSJwULoFg0a3C2YN
         e9CcjuCZHjD58YgH68+LBSjKGpfa1gSC8viklIL1j1Vcf5kC7Yl+zevHrj4qKW/PEOeo
         tpt+CbzzHvzXjbRQ00I10CmekgLGY2Cb/uUDc4jIvoJm8fRFAhhFEMf+ct17u1gsEos4
         XprWrJCj9ikgtRtLpDf0FVi06J2aI/LAjPD7z/tdGfw0HBdyLkeKsE6W6Cc9tifeWY+s
         V8kNdYsM7DaYF0Kv9TZ9K3H2tcWnCfYLYF3vBqhYyheG4yLoJ6ZpdichoeZYEKhj1U9V
         Ua1A==
X-Forwarded-Encrypted: i=1; AJvYcCVsjR8TgzOR0+BgWNfOYGYrTvEPDSSO8mImsqu792Z7hlAcrASEQLqbuuU13f0e2+f9n9CApkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XiWFpljw9RD+pwbjmrnyVw6q4RIlaegHoPUVVCr9ELPo/ehy
	ZSfAg2LQmlgIev0XLEMAuIMbKpXBG0m7Us6KBJ5otNvedxYyFvWnhxBS0pwcwuPWjR7ZwldgWIl
	nXhfZjuTyn3L6+rU6IL/R89d44c4NuyI=
X-Gm-Gg: ASbGncsbDQ24a7htoC7wtVU3KjJ86SpL5XtsV89Jp/zM/Fjc6D/GmICC8liUqaKMFlr
	LqiikI0DJfLSiCtTHBpJu4qsT2uV3/zpzXbXKIsyALkj7ZZ/+pbfZt8SO6exNz9Mkjn+33nSsvc
	5P00iFq9Xbso3zzkeJtxQpGEWzgCQcM4g7Iz0Czd2c1AIWaxLhusf/TkHPf2LkSEImiGWNj8bdM
	wqNcyOCcfxPcFXdDbveNRQ=
X-Google-Smtp-Source: AGHT+IGt0XT6DRpZq3m0PwvCVD9z1EjxHFgTtcrghDBnPh8gCv4eKAYbRVrhHk51lTs9KwbneDAJmQ8F4Fwuijk1xy4=
X-Received: by 2002:a05:690c:338a:b0:766:aa17:14b2 with SMTP id
 00721157ae682-766aa171e5cmr37658687b3.48.1758842198785; Thu, 25 Sep 2025
 16:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925170013.1752561-1-ameryhung@gmail.com> <20250925170013.1752561-2-ameryhung@gmail.com>
 <87a79618-cd71-4f4f-ad65-b492e571ade5@linux.dev>
In-Reply-To: <87a79618-cd71-4f4f-ad65-b492e571ade5@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 25 Sep 2025 16:16:25 -0700
X-Gm-Features: AS18NWCzOoH4_6IjhcQ5yMbuWgwmKX0Ye0BGLun2vI57KRM8U2aMzvrWLo1kUHw
Message-ID: <CAMB2axNBzcShfP6ENKqRW_PiruCKA=keH9oDQBgNEzWFLN-7eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test changing packet data
 from global functions with a kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/25/25 10:00 AM, Amery Hung wrote:
> > The verifier should invalidate all packet pointers after a packet data
> > changing kfunc is called. So, similar to commit 3f23ee5590d9
> > ("selftests/bpf: test for changing packet data from global functions"),
> > test changing packet data from global functions to make sure packet
> > pointers are indeed invalidated.
>
> Applied. Thanks.
>
> > +__noinline
> > +long xdp_pull_data2(struct xdp_md *x, __u32 len)
> > +{
> > +     return bpf_xdp_pull_data(x, len);
>
> This tested the mark_subprog_changes_pkt_data() in visit_insn().
>
> afaik, it does not test the clear_all_pkt_pointers() in check_"k"func_cal=
l().
> Unlike the existing "changes_data" helpers, it is the first kfunc doing i=
t.
> Although we know that it should work after fixing the xdp_native.bpf.c :)=
, it is
> still good to have a regression test for it. Probably another xdp prog in
> verifier_sock.c that does bpf_xdp_pull_data() in the main prog. Please fo=
llow up.
>

I will add another test in verifier_sock.c.

>
> > +}
> > +
> > +__noinline
> > +long xdp_pull_data1(struct xdp_md *x, __u32 len)
> > +{
> > +     return xdp_pull_data2(x, len);
> > +}
> > +
> > +/* global function calls bpf_xdp_pull_data(), which invalidates packet
> > + * pointers established before global function call.
> > + */
> > +SEC("xdp")
> > +__failure __msg("invalid mem access")
> > +int invalidate_xdp_pkt_pointers_from_global_func(struct xdp_md *x)
> > +{
> > +     int *p =3D (void *)(long)x->data;
> > +
> > +     if ((void *)(p + 1) > (void *)(long)x->data_end)
> > +             return TCX_DROP;
> > +     xdp_pull_data1(x, 0);
> > +     *p =3D 42; /* this is unsafe */
> > +     return TCX_PASS;
>
> I fixed this to XDP_PASS as we discussed offline.
>

Thank you!

> > +}
> > +
> >   __noinline
> >   int tail_call(struct __sk_buff *sk)
> >   {
>

