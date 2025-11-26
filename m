Return-Path: <netdev+bounces-242079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7EDC8C1D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C6414E31CA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C531A072;
	Wed, 26 Nov 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRUIgrGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456823ABA9
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193958; cv=none; b=ACfO41DD1keqCw6JH8530IWKWq2IW9X8dxJO24LPycwG2sEsse1vjasaTIqID+b9V/LVu9JF9l0QVB25iZwanA6t+Hy4xrosWd2y7hI0Ew1MF7uWEnl1fSwUDudwgKr0dNHLTl15ptYCVQctyWK9N5QhK5vaMsabQ1DLXeFMe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193958; c=relaxed/simple;
	bh=OA9IH37zSCd2RwtlrUotNgXyzNqRut+Yy0Urpo38jUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1nwAMADrAsmuFF0sBkdyGLpJ1e37iQLwKM3GSv53jnp+KdCN9Wt7hNVi4pW+HyADqPHGQRo17YcOVe7v9YK5w4DxM7HVKDgNjNxAlFmrm9xqOsrItr/eblqiVc/A9/CvYUj9fBMRD0Z6/5BWBYcxRCpbHGap2pv2luKCip+ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRUIgrGG; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640c9c85255so319010d50.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764193956; x=1764798756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWVBfG7V5vG8Nex2eHRPfQjXlHORQXw1wNWDWwMJmrY=;
        b=lRUIgrGGGNhj3o5qKGPiQNdufe1wAwgDGhqj7SEp1k0S9rhFRf+m3eLkt8TTUU2aL+
         CV18ATx1rEqaMYVU6/+xnqs07hS4tqKCgTP8WpI9ry16ugFSP0Ilf2puV7lZJpVRJHul
         jJQvFttAAYKlPEj/wBr0uCAY8kPMfB73KZIWytfVAMeTMCSnUQG+fcu2eHF2v28IOKnv
         gqxNFG28+bsJFQIy+9P0Ix93RJPbPd8vVgRBwJ8uYjM65/sh4BGOKerqVsKxrJLR09gb
         dN7zXdUyKBEp2zo7HRgxMUEdi4YK1/ng5WCpkbgc8VcTXSmgV3GGYnD2McBVfUIEdPzY
         mh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193956; x=1764798756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWVBfG7V5vG8Nex2eHRPfQjXlHORQXw1wNWDWwMJmrY=;
        b=s/Qci9RLlS30EgBlIVlrPnHwQLnn0Sw8tprdtl828SXnjQyqeO3HfCqNFSPvb52gE2
         wsb788DQpx2XwUURCpfILn3UmwZqzB2pzGbclmyL2izlVhVhX8hn6tsP0fl/j0+2K0WV
         dzdh7Gz3jPwpdUcwNJcyQQjFXyBfrve1WOAZiOwejTGZAV98LI9X90XFCak1KcGwZaqO
         xpyXjqp+lo1gPzDuwRdoaWOkQFwfO0Vc0DMVySmbCnvjOt0ZNNiAbzs0aBl/b0Pfhfor
         zpNBR9s9z1FeZC91MPcTxRGqZdkaknJ0zxbqDvz+FoinWHVXOwPHsfh+u+emTODKzJRL
         sZzw==
X-Forwarded-Encrypted: i=1; AJvYcCVzmIVIyk9xagsvFErzG5gwCPdSszme1xsOl736Yr3/mQ54irzSfbMVtsGMh+lh1s6g5+b6+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNgVDCz7UbSsdsR/FwflYxufl29Ck2ft96CuTBopFza+ZfLPD
	rguSyOZo/qfShXCPtgfL3HWRQ3fwyOAQjIRMvAe6MUGXbi/2wf6LqjlWb+2g6THEPqMe87xSatQ
	cte8ZCUkXetSoTADDI6JWFx6tcd3nZis=
X-Gm-Gg: ASbGncskAhYpDlGPN3XqKkgiqPKwvssPQVSeDp3kJfICjkqjQcx/Uj0ixlqR3uplPsO
	HmZ1yJIQtxuMCTbJ1Cfv8AELFiXaO8kWGeoNsbyK9lEGivtqZpZylw9Bk2k0Md8rbom6SQFM2zc
	EYPcs5xeiLMEC4uiNACPRCaEUtO0Q7ikkcW9ODrYYVIH1ggwyM0BIxjdX1Uvpv1qq7aA2nLDCLK
	1mz8kR04i7liRmiCzMyorplA7unA9st1zlumP5IHJIwb2tUhfQpq2vXmLAQ2+SDvdrzelo=
X-Google-Smtp-Source: AGHT+IFsbDsdBbQPlYbOXdmpEUQUAZMmeapjcBh7uxFrCAUP+guyuTT4S34owbxZk0R7VvNTUpcy0DM8OxvGbYnnVqM=
X-Received: by 2002:a05:690e:4182:b0:640:cc09:b7c8 with SMTP id
 956f58d0204a3-64329320a59mr5250531d50.23.1764193955965; Wed, 26 Nov 2025
 13:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com> <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
 <20251118104247.0bf0b17d@pumpkin> <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
 <CAEf4BzYmi=wJLpz18_K1Kqc-9Q4UKbq+GsyVH_N+3-+_ka0uwg@mail.gmail.com>
In-Reply-To: <CAEf4BzYmi=wJLpz18_K1Kqc-9Q4UKbq+GsyVH_N+3-+_ka0uwg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 26 Nov 2025 13:52:25 -0800
X-Gm-Features: AWmQ_bkYE45o4Eofaaf7jqxeVL278vqXILvL1HWnLZTKzWLJZO1yDFg-KTqB2Yw
Message-ID: <CAMB2axO4hmeRtGFWW58Rx6PCLgLi3Dr+Uiq6JScw+Wm5AcrkLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 20, 2025 at 12:12=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 18 Nov 2025 05:16:50 -0500
> > > Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrot=
e:
> > > > >
> > > > > Locking a resilient queued spinlock can fail when deadlock or tim=
eout
> > > > > happen. Mark the lock acquring functions with __must_check to mak=
e sure
> > > > > callers always handle the returned error.
> > > > >
> > > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > ---
> > > >
> > > > Looks like it's working :)
> > > > I would just explicitly ignore with (void) cast the locktorture cas=
e.
> > >
> > > I'm not sure that works - I usually have to try a lot harder to ignor=
e
> > > a '__must_check' result.
> >
> > Thanks for the heads up.
> >
> > Indeed, gcc still complains about it even casting the return to (void)
> > while clang does not.
> >
> > I have to silence the warning by:
> >
> > #pragma GCC diagnostic push
> > #pragma GCC diagnostic ignored "-Wunused-result"
> >        raw_res_spin_lock(&rqspinlock);
> > #pragma GCC diagnostic pop
> >
>
> For BPF selftests we have
>
> #define __sink(expr) asm volatile("" : "+g"(expr))
>
> Try if that works here?

Thanks for the tip.

In v2, I decided to return the error to the caller to align with
another test case, where the lock (ww_mutex) can also fail and has
__must_check annotation.

>
> > Thanks!
> > Amery
> >
> > >
> > >         David

