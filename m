Return-Path: <netdev+bounces-203087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DF4AF07C1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7090C4A2408
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D3171A1;
	Wed,  2 Jul 2025 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx+Q2Chj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13213AA2A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418506; cv=none; b=A6dXY5F/+UB7ztsvVi1f+zwnMBdrhkvOIRLTANx6ZASOMKRZ2oz8Yiw1XOgVFmP6nAvz17P5A2NiTNJzYY6yQFPXLrvb8I7MA7lmuK8YjjswT3HBZqITGcRm1h0W2lIIivhUjKGVi385cn9kwTjpq/6L/VmhgkIPuuzYNjIaMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418506; c=relaxed/simple;
	bh=YmWyZoHQKtLnQGYJtvBk/2SzzbYRpUhomtaZGd4p9CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8cfVqcF3t7iCrFBe1kUrpb1cvavznKWK9HHUv2Kq8K1mqKX8VKGp0FGFp1ltGh7X3TTQ1qGs1NQFrsbSULcUhsrS+On9P9KQWH9k5FHqgkRaxGK7EbXX6ZeG8SMnas9JpXaXtCtAAVlmZHFug9eLFlwJNa7gDrAL685yFzMwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx+Q2Chj; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3df30d542caso18905305ab.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418504; x=1752023304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um8DVG7yaB+zXdoU2whL8VcWDq+YKJI3aU4TO6yVrjk=;
        b=Hx+Q2ChjP0umDxXzrB0u1mYV5SYEIpZWjVV/7/rv5j4qJTnCzE/iBe5YEkq61iMHUr
         HEW1xZ7N0kc4YDxVY1M9ta/IKXSqLolgIvq1ya+v7M0/i1D5Gp2QIdnD6Ps0r5SFhKrh
         SnRnrjL0RypfDn1PZcZw/xqA8WbanP/HGbVQpsSv3MMr2ZkzOg8op4OM+7YXZXT9YtMS
         frw5hhc0QAv5qYeL7FWdrhG9dH8pg3tSgdFPtKZCD0VzxzupCO+Ctev8VjuoJzS2ZMYw
         9FdgFdlhlbfHR+UcLh1/gw88kPxX72SpFeHccJGBlYroXz3+dWMpKuxIVgjKNKBPn3/X
         xlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418504; x=1752023304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um8DVG7yaB+zXdoU2whL8VcWDq+YKJI3aU4TO6yVrjk=;
        b=TGY89O+kNF9vIx8pvQ0gfo/AwNJrPmafrgs77qudDugPO/kX8tEdOWHcn0xMs+2xHD
         H/1zA9Daetbn/rtBtykcJmG6a3XIXQs+SHqTS5DdCMaO5fScWgSuu4rwSYPyuAglKjn9
         bi2Bf653xmkMMFXQA6y7u4y2UCjs40DoIdAyluFsK1MQh6XhQVSRctCmA4fWHyktgHl1
         9ooTHcaqracTlfMKOph+9LPwcssx4Ra3FkE3yxRVnwkjC7eUCak8VAJHv0DOvlO3eWdl
         xysBdb6mOl4IQS/WTMz5dsKBxZq8YyapF/UU+sxjFVm+19toKh/rOEch+fA1C6dAndVL
         LHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLbXuzATXMNfI5TyyzsighecJ3l3tA9eB1VdOEQ1EEXlQ/CW/8H05kuOxayCvR1XT1w0IKTZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhR9SrCA77ay5MpUTntp/ybQlTH+8OsNgfRghgx/Z2nwR6oPsk
	D08VPtY3XI62szGO8epyDsSJchuxINA5tN7QyLeW/7x9heTFckLJXu330BAhqLHgb2j8hXHf7jF
	2HWTvSPYQ7xzJTc6a+gHm6VlagsY3PpI=
X-Gm-Gg: ASbGncsXwHmu4cRebSu+f4uSeAdGD3vFOhlw7Xdg4HAOtBbktSzY4B2GJFG5wpLJx6O
	JYk8JpVLwr+gufIMNZdrMKI0Xd14rfMm+VPGk45p+qcRt9JJMn70RnSM0+nerIrhLL8k+Bc4N4t
	0zCZF3YAxW0I4dgEEPpEHfZcZewhfwhBipqh0rkFRA/w==
X-Google-Smtp-Source: AGHT+IEPhf3mbo34cbCrL7zdEANVt2/sfv39fJTtvTKheg4c/E6mFVDOZItwGTat6z9awhs/yuFiMemVmDwCC9CZFzI=
X-Received: by 2002:a92:c26b:0:b0:3df:3154:2e90 with SMTP id
 e9e14a558f8ab-3e054a02154mr14816375ab.19.1751418504531; Tue, 01 Jul 2025
 18:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
 <20250630110953.GD41770@horms.kernel.org> <CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
 <20250701171501.32e77315@kernel.org> <CAL+tcoAfV+P3579_uM4mikMkNK4L2dMx0EuXNnTeLwZ3-7Po2Q@mail.gmail.com>
 <20250701175607.35f2a544@kernel.org>
In-Reply-To: <20250701175607.35f2a544@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Jul 2025 09:07:48 +0800
X-Gm-Features: Ac12FXyl_MBkquXYqWjMQDMHsMyMSv-Un2rADeC_8o9F7OwFw2KfQgUfUd6w62I
Message-ID: <CAL+tcoBu_jo5Nhv-4gRomwfOpN+Y_Ny+QJ6p1dk87gQ==YX-Mg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 8:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 2 Jul 2025 08:47:08 +0800 Jason Xing wrote:
> > >  static int bnxt_request_irq(struct bnxt *bp)
> > >  {
> > > +       struct cpu_rmap *rmap =3D NULL;
> > >         int i, j, rc =3D 0;
> > >         unsigned long flags =3D 0;
> > > -#ifdef CONFIG_RFS_ACCEL
> > > -       struct cpu_rmap *rmap;
> > > -#endif
> >
> > Sorry, Jakub. I failed to see the positive point of this kind of
> > change comparatively.
>
> Like Simon said -- fewer #ifdefs leads to fewer bugs of this nature.

Agree on this point.

> Or do you mean that you don't understand how my fix works?

I understand but my previous thought was not like this.

>
> > >         rc =3D bnxt_setup_int_mode(bp);
> > >         if (rc) {
> >
> > Probably in this position, you expect 'rmap =3D bp->dev->rx_cpu_rmap;'
> > to stay there even when CONFIG_RFS_ACCEL is off?
>
> no, dev->rx_cpu_rmap doesn't exist if RDS_ACCEL=3Dn

I was trying to say 'readability' of rmap so I used 'stay' on purpose.
As to the core of the patch you provided, it works for sure.

I will send a v2 as you advised :)

Thanks,
Jason

>
> > The report says it's 'j' that causes the complaint.

