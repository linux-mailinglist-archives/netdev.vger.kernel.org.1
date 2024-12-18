Return-Path: <netdev+bounces-152856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC99F6052
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E62169BEC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3451791F4;
	Wed, 18 Dec 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvICn/++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD114F9E2;
	Wed, 18 Dec 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511266; cv=none; b=Nk+uUBedfSbkmW0rBmLN0u0t4JCSIlxoNWrWUIy+V74Ar02xl7V4Wsez2gRsGtZUdz49o0bGP2GZfC9vuC8eaddjhkNoqjqkCdkhEuVRTjkZo1S+AgrbNkUSCHQe9/n+7G7S4gKWLB2DF4EDfAn2Avk7SxIlbOvcQNDkdaiWjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511266; c=relaxed/simple;
	bh=n/qie5vH/eAqD1mHugHzqX3jkGmyJ0CSjiQvm6cwSXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsuA6G31h8m5N6H5ZOTIs0Wob7+TATaZdHmRsT8rtaVoV1atSnPuqdYJzNGYWjdwbUB6QKNbj2LVD7gyFOB6GPqZ8PFkUU3PXzPiODegSO9Og6nO1EO17WCJsmOijO/mtHpeJARx2EMjNQLI3DcFUxjs4SSRDl+6kmhM515Qkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvICn/++; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3022598e213so60043301fa.0;
        Wed, 18 Dec 2024 00:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734511263; x=1735116063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Uth7hzk5WKYEXwnMXWVgZ5kbZA+3ppaKuwLhWTd9os=;
        b=EvICn/++QAqpbPeekheNx8hkS4OSPPfPNyETnRO63EXEMkhmOZ7FrY/c0H/2K5Vs7P
         Rep0Q8w5wVnJmb8QKscX/TuXTh5kesfzfVnwsfwcnDgplQ77KJEYzr7Uh2lQqObQX2/i
         miqOuodkC0zlNemNTwUpOYXsew+DmQyZwHyFcNAgW2au2IHduFF0uxFv8KUP47V/GjPH
         HhFmfSt36ZsUtARIp29BVTCaQq0uAMYNG2Ab/4ZG8QWG8ZlrtUIW0nRHzkdy8ANx6Isl
         2mJpLvbaQ9Sc6d1UtXYb87Ggb9xymffd9stSbhguk7tC85QLoFlfSa4lEkoiwSe9UyeV
         +pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511263; x=1735116063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Uth7hzk5WKYEXwnMXWVgZ5kbZA+3ppaKuwLhWTd9os=;
        b=tTtqdcsDsxL4Smv+s9JoUImZeT2T/6PoRD1xKkoLKjIdy1FGC14iUsgoU92egztEew
         +VWRtXah/4so3lBlafUyuvrxAy7i0wCM7oj34kd6XlKZ2obuXfbec1mHSvqjKMdMuA0U
         tw9TPwvtfluHdC2o3GNBdb7i6wzR+/0qwFW60iUTUkwrsZhsxd9io0LN6TrB8ugMg/d+
         2NWCSlJ1DXkJ1VD2mNMLhuGLpuCoGn9Vvxo0+mTuSNJUqB9NdFGmw2/HwoA02KH0SFhr
         UQQeqeWJf8GJDjopxpg+VxEAKfNaML0XUmZrc9vRfIMLHRQZ+uF+Vp0YGP5GWTQSqjY9
         iDLw==
X-Forwarded-Encrypted: i=1; AJvYcCWvTts+G9E+kHm7MPs7hX8difqV+kRxLh8gI7VeY3BQOMh4rXBPaI+Qot2lBn3gWDiwqUhTI0Gs@vger.kernel.org, AJvYcCXAOdCsdnfi9e42laWQ1Xxqa3n3B2KxTDs9PClegL6akPuY/kdlAQsMiUGO5/i5KMs3AZtFxxh8AAHg0iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUeAzhsu36yZQabFu1osdmcy/7KyalABotPIhzfKohYLj1Q4+
	yMCAxCMf4CsY3/LP0W1s36ZZxuX1fteRGeB3JdK3kGmvybps80vs9yuBe/8box7FbeXL5Z8z3J1
	FhWVYqX96Icyuc8kq9K1sKkGNsPQ=
X-Gm-Gg: ASbGncsKXw6NKamk5xKAjHgPOVYped5wijU6kA+KK0gFRM/y+vzzwg6Q3VeTGcbhi22
	f5Chzqzf0vV/Uk38+cXl3nN5hixRmYGrWvU0zQA==
X-Google-Smtp-Source: AGHT+IHbWGwiqGhsP6zXehmQVddvNfAxD+0ZuLK1J7qM3ySYcwfbNR1Z7kC8GYFO5+f4dcJvuwhfzdMUmo1BSgfc5Cg=
X-Received: by 2002:a05:651c:198c:b0:302:1aed:f62a with SMTP id
 38308e7fff4ca-3044db05760mr6697331fa.21.1734511262601; Wed, 18 Dec 2024
 00:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021080856.48746-1-ubizjak@gmail.com> <20241021080856.48746-3-ubizjak@gmail.com>
 <7590f546-4021-4602-9252-0d525de35b52@nvidia.com>
In-Reply-To: <7590f546-4021-4602-9252-0d525de35b52@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 18 Dec 2024 09:40:50 +0100
Message-ID: <CAFULd4aL+qVxyFquMTTQLyVFpVSc1DwcahJprj73RtvrW_XsXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] percpu: Cast percpu pointer in PERCPU_PTR() via
 unsigned long
To: Gal Pressman <gal@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:54=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 21/10/2024 11:07, Uros Bizjak wrote:
> > Cast pointer from percpu address space to generic (kernel) address
> > space in PERCPU_PTR() macro via unsigned long intermediate cast [1].
> > This intermediate cast is also required to avoid build failure
> > when GCC's strict named address space checks for x86 targets [2]
> > are enabled.
> >
> > Found by GCC's named address space checks.
> >
> > [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-s=
pace-name
> > [2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Na=
med-Address-Spaces
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/percpu-defs.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> > index e1cf7982424f..35842d1e3879 100644
> > --- a/include/linux/percpu-defs.h
> > +++ b/include/linux/percpu-defs.h
> > @@ -221,7 +221,10 @@ do {                                              =
                       \
> >  } while (0)
> >
> >  #define PERCPU_PTR(__p)                                               =
       \
> > -     (typeof(*(__p)) __force __kernel *)(__p);
> > +({                                                                   \
> > +     unsigned long __pcpu_ptr =3D (__force unsigned long)(__p);       =
 \
> > +     (typeof(*(__p)) __force __kernel *)(__pcpu_ptr);                \
> > +})
> >
> >  #ifdef CONFIG_SMP
> >
>
> Hello Uros,
>
> We've encountered a kernel panic on boot [1] bisected to this patch.
> I believe the patch is fine and the issue is caused by a compiler bug.
> The panic reproduces when compiling the kernel with gcc 11.3.1, but does
> not reproduce with latest gcc/clang.
>
> I have a patch that workarounds the issue by ditching the intermediate
> variable and does the casting in a single line. Will that be enough to
> solve the sparse/build issues?

Yes, single line like:

(typeof(*(__p)) __force __kernel *)(__force unsigned long)(__pcpu_ptr);

should be OK.

Thanks,
Uros.

