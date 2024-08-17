Return-Path: <netdev+bounces-119392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18609556BC
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C51F21ACC
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2F1487C0;
	Sat, 17 Aug 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9vfKvEI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB81148317;
	Sat, 17 Aug 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886853; cv=none; b=UdPMgQQ+/OZzo0cx4lp2/AzsLBVrnsgUn3ZzaIHYXt4kVC2J4XaBG+ReltRsJhJ3Lofc3630TaJ1t9JifKzmow3Tvox7Cv25p6BcbXaqMoWY4ZS3WoLxvJIg8jjRYbGsX3q+gCXNTJ34VIG3gXRPK+DbEsGToDRUbsaoXiiIfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886853; c=relaxed/simple;
	bh=kGg9VSaWjG1r5mfWepw9eoy+c+ZwvFl5r/ZQEyLibDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhAkygMLmbmjqOTHANKwcQQOKcoadzdxsoTAeHP9nmFWUMCHDavD7dAJwkCy70Bt6OfbDEFYVu1xwHf124sIFOQd+BVwd37KewfpKu4mFn/rKMon41gSH8wO9QLMBuv5Ldrx2UClvB1Gg94Qj6OwVP5y+bjeLnrScPvgAEbVkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9vfKvEI; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4519383592aso16525061cf.3;
        Sat, 17 Aug 2024 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886850; x=1724491650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgRw6teSk0Vsqncxx6wgpyYYiQXJoNo9naphE5dxvn4=;
        b=Z9vfKvEI1qG9PPjTjvNfxXMlPGV7Zfzidv2/zHjYc+IImzmt64bl8rdr2sjc6XFMv5
         7+eVr/fQ8Wi5vwGl9G3UVSEVcbKuriHKRjZ8p7Tz+7BUjjqexXwMH/dhw3VRKx75OMZa
         X8v4n3mMKsJxUccGWHSPD/jzx/WAv0KT/zYy94KRiv5RA/HNTAEQfQ+cWNgCjpoWXAIA
         2nfLprlvg+wCqiPR5907tGmnb8YvWkLwNj/9XKKpsnxc/OXMkQey0kSJ7oTQcx/JBLpS
         +CFjZhfL5rGcT/rfq6k7cSUKz9rcohUxxlFWAWWJ0/95XYp4RobWpyPPg/C/SEA3naWK
         Gcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886850; x=1724491650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgRw6teSk0Vsqncxx6wgpyYYiQXJoNo9naphE5dxvn4=;
        b=qtyM1pUEL14LeKVY/CB7Po+v79P/babw/ZscCHyT7C8qdfwUx5wFquXOAl2ZAzFvcT
         8uBWrOVZZZmW98sl4WShBexD9+j7OJc+G42CJCdVDthhIRLgLdLtSxvknA5RVeJy5Vqs
         beAooIgu0QUDxmoIi0YQknO9oeQByn+VNwa9Zo7z24wK9luVpZX0Zzmr3FWyN4MlCnsV
         JqbcreNs+fAdtR8sK33Nzqaoqw5gbOKXHcaILpuLI3VMF3j+u2IpB6mhr3DJASOai3Jk
         1oUT0GXboDZWzXvExbDZmmEP3F/UO0nI+oI8csGOAQ4bcFvkdqcSQZ2RwL3kMbgbs7LQ
         BpbA==
X-Forwarded-Encrypted: i=1; AJvYcCVGh5WmET5rsYdmV0l4rnNalWUuaO36ohoVVA7MYEsGjk8yllDOhUjQh+qLAGqlEq1iB3ecb68OV0V7UtexGBTzJVUu5z4I99MMLU7G
X-Gm-Message-State: AOJu0Yxeyf4mlFJk6i/Bkou8Hmk3lW5ucvYUtuZyFLfsASLkz4WzHEEh
	fZGoKjihQ/8Szn0NfukIk137jOFNgQLGQa1rTbwpU8eI4cfHjMMzQxaXfjqCi2htXSHZK7oQO+k
	aU/8DdgVeIki09KGQG42rMdup1s8=
X-Google-Smtp-Source: AGHT+IFVo1p+v3CrXFfk3Gw22BDMFxLp7295yMXwWc9k/Zmg+GCLMbW9UUNXC0cNHga0lCO400RQjVCpS/G4+q3VlGU=
X-Received: by 2002:a05:622a:590c:b0:44f:c9ad:9cc2 with SMTP id
 d75a77b69052e-453743aa05bmr73314661cf.50.1723886849734; Sat, 17 Aug 2024
 02:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com> <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
From: Alex Young <alex000young@gmail.com>
Date: Sat, 17 Aug 2024 17:27:17 +0800
Message-ID: <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com>
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	security@kernel.org, xkaneiki@gmail.com, hackerzheng666@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

Thanks your mention. I have reviewed the latest kernel code.
I understand why these two tc function threads can enter the kernel at the =
same
time. It's because the request_module[2] function in tcf_action_init_1. Whe=
n the
tc_action_init_1 function to add a new action, it will load the action
module. It will
call rtnl_unlock to let the Thread2 into the kernel space.

Thread1                                                 Thread2
rtnetlink_rcv_msg                                   rtnetlink_rcv_msg
 rtnl_lock();
 tcf_action_init
  for(i;i<TCA_ACT_MAX_PRIO;i++)
   act=3Dtcf_action_init_1 //[1]
        if (rtnl_held)
           rtnl_unlock(); //[2]
        request_module("act_%s", act_name);

                                                                tcf_del_wal=
ker

idr_for_each_entry_ul(idr,p,id)

__tcf_idr_release(p,false,true)

 free_tcf(p) //[3]
if (rtnl_held)
rtnl_lock();

   if(IS_ERR(act))
    goto err
   actions[i] =3D act

  err:
   tcf_action_destroy
    a=3Dactions[i]
    ops =3D a->ops //[4]
I know this time window is small, but it can indeed cause the bug. And
in the latest
kernel, it have fixed the bug. But version 4.19.x is still a
maintenance version.
Is there anyone who can introduce this change into version 4.19.

Best regards,
Alex

Jamal Hadi Salim <jhs@mojatatu.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=BA=94 23:04=E5=86=99=E9=81=93=EF=BC=9A

>
> On Fri, Aug 16, 2024 at 12:06=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Thu, Aug 15, 2024 at 9:54=E2=80=AFPM yangzhuorao <alex000young@gmail=
.com> wrote:
> > >
> > > There is a uaf bug in net/sched/act_api.c.
> > > When Thread1 call [1] tcf_action_init_1 to alloc act which saves
> > > in actions array. If allocation failed, it will go to err path.
> > > Meanwhile thread2 call tcf_del_walker to delete action in idr.
> > > So thread 1 in err path [3] tcf_action_destroy will cause
> > > use-after-free read bug.
> > >
> > > Thread1                            Thread2
> > >  tcf_action_init
> > >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> > >    act=3Dtcf_action_init_1 //[1]
> > >    if(IS_ERR(act))
> > >     goto err
> > >    actions[i] =3D act
> > >                                    tcf_del_walker
> > >                                     idr_for_each_entry_ul(idr,p,id)
> > >                                      __tcf_idr_release(p,false,true)
> > >                                       free_tcf(p) //[2]
> > >   err:
> > >    tcf_action_destroy
> > >     a=3Dactions[i]
> > >     ops =3D a->ops //[3]
> > >
> > > We add lock and unlock in tcf_action_init and tcf_del_walker function
> > > to aviod race condition.
> > >
>
> Hi Alex,
>
> Thanks for your valiant effort, unfortunately there's nothing to fix
> here for the current kernels.
> For your edification:
>
> This may have been an issue on the 4.x kernels you ran but i dont see
> a valid codepath that would create the kernel parallelism scenario you
> mentioned above (currently or ever actually). Kernel entry is
> syncronized from user space via the rtnetlink lock - meaning you cant
> have two control plane threads (as you show in your nice diagram above
> in your commit) entering from user space in parallel to trigger the
> bug.
>
> I believe the reason it happens in 4.x is there is likely a bug(hand
> waving here) where within a short window upon a) creating a batch of
> actions of the same kind b) followed by partial updates of said action
> you then c) flush that action kind. Theory is the flush will trigger
> the bug. IOW, it is not parallel but rather a single entry. I didnt
> have time to look but whatever this bug is was most certainly fixed at
> some point - perhaps nobody bothered to backport. If this fix is so
> important to you please dig into newer kernels and backport.
>
> There are other technical issues with your solution but I hope the above =
helps.
> The repro doesnt cause any issues in newer kernels - but please verify
> for yourself as well.
>
> So from me, I am afraid, this is a nack
>
> cheers,
> jamal

