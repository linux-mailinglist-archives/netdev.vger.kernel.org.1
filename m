Return-Path: <netdev+bounces-119524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F39560C3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780B328175F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEEF1A28C;
	Mon, 19 Aug 2024 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzFSNJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3EC125;
	Mon, 19 Aug 2024 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029859; cv=none; b=BvosL08uZPLmrMlGOZEe8JxyL4fznWVVwPqWvEmPbMeRh8v5fuWZkqNslxPG18zIoAR31gE4l+LY9e9dJxRAmILMhzMHAohj/AV2/Xdaa5qtXk7LMocYDdGOJjgbjnZnOv+QfAHyLIYOTpyS7+zyYjfiv7Rl70OCTq0Ya9MPP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029859; c=relaxed/simple;
	bh=FHPayM0LoVPMxk1TlBxfGt+GXj8BcMKlSff2TiTAQgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5GPe9s7z7r5PVTv81hHqkKGkI4f7qDe/jKwYfvyc27bDYZVWsQnaTGeVmawN1vrNhMWaACHgjt2BtnyDHpKI+jWD+JuHhKYEQhv1FKs6DuefpWQbRD50YsG+22tHBeopYvMP8smru/IuGSRLJCdCIQAn++iaOl6yZ4jEiWHXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzFSNJV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45006bcb482so20163621cf.3;
        Sun, 18 Aug 2024 18:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029856; x=1724634656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6iLuHHstLUsYcIKd+4Evekv/FBo6R/JH37NwWFMKUI=;
        b=JZzFSNJVR+Kl0mQXkRgfcmndeR7TiXQ3dPd8nri7GyRUO7E5oV0Ff5H5kwWIRSjmkY
         YKq7wVhTyTDyGgtRNgcRmdqC0fEhANbJqqZZSNTldyWKJnjjrECRMHD4/Mg5J2yQr99e
         /o9MubDOzu3LM/XOdHl+YLB0rAG5wO3szZFqz6yhB2slL9TZI6gBkBoZEiy2I0/aej3Z
         V6yXeL0jUeLyUaM64jdqEiKZp8twXozgXHoxEaEUq3WWGNOq3EgzVFLJaqvEadwQcinx
         ER36D4VZHQVuWTkdy2TznDqNttQimdbrMI5rQ0d2IsdD19lPG82k+W3rOqI0Tb8AhfJD
         FROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029856; x=1724634656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6iLuHHstLUsYcIKd+4Evekv/FBo6R/JH37NwWFMKUI=;
        b=brulUBWg5MUL7SFhsWk+IGAAlnawji4c4AITjM/4CbvMZvFQoJ+Y1r+ROwgjkSw8tO
         aQUNXAtQwA/GFFny3orcclamrMuoZ/JstbQmrYFK7dS4dMgTa6ZEplFLOVDG9CJBtCqq
         hArPVxrcyH6MfW6fO2Pq2oN1t/IW09K/h9T7YgGRLfNf6WHdgWNxBR0CYCK82im1dykl
         zqh/4+VDK8918q53k82gjjKwFfACBeSJRQaPpAJ9q+gk6nwWzqYZTF3qU3V5izccV0+f
         oxxttCN0CNPBLix1djeO7hiEuL6waEw1SmJXtKlWEIh2yV896F7pdJgOD7X0umSZFrE8
         H9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXrTDyaT3+ExOce/eZk3qMiQ397EG4ZygpBHzfeqoc2iRIZ3/DIqYeiodHp5cpUgTSAA5DW8jfBHKJdtJlKd9inolBbBLZS25n23aDIgaY2wCiG0gs+KCkF6wEY16zP1JFFPfB
X-Gm-Message-State: AOJu0Yy6V2lwMoi/J/aNMwnZ5/I1kHePmrgui4TIhO/02TAp4y1Ji6aa
	B/L4psP2wV8vKW3BtKzadjX6YwJte7KbICVLA63A/I69P58+6NThmFegHSf6CEBxBUDGxtKxdU5
	FVPfJ1er65iNTT9ZwsuqvJecjepc=
X-Google-Smtp-Source: AGHT+IFSlLaChurqBHaSpi18i/a6WfagYkOePrr4xUA0CqD25ygg4qed6gdbZk8aE0bWh+i9CMqAxQrr+lzVw25bhGc=
X-Received: by 2002:a05:622a:4889:b0:440:6ccb:e6d5 with SMTP id
 d75a77b69052e-454b68e2b85mr59000071cf.51.1724029856352; Sun, 18 Aug 2024
 18:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
 <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
 <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com>
 <2024081722-reflex-reverend-4916@gregkh> <CAM0EoMmUSGEY_wGHmZJkP5s=sr0zPJ2sOyTf3Uy6P3pN8XmvhA@mail.gmail.com>
 <2024081839-fool-accuracy-b841@gregkh>
In-Reply-To: <2024081839-fool-accuracy-b841@gregkh>
From: Alex Young <alex000young@gmail.com>
Date: Mon, 19 Aug 2024 09:10:45 +0800
Message-ID: <CAFC++j0y7LZuZaZrVa01o3d1OSbo1VOccEw=zhJ+nc=-6bZOQg@mail.gmail.com>
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	security@kernel.org, xkaneiki@gmail.com, hackerzheng666@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi greg.
Thanks for your suggestion. I will try to use the new kernel.
By the way, the 5.4.y you mentioned does not fix this bug either.

Best regards,
Alex

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2024=E5=B9=B48=E6=9C=8818=E6=
=97=A5=E5=91=A8=E6=97=A5 18:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 17, 2024 at 08:11:50AM -0400, Jamal Hadi Salim wrote:
> > On Sat, Aug 17, 2024 at 5:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Sat, Aug 17, 2024 at 05:27:17PM +0800, Alex Young wrote:
> > > > Hi Jamal,
> > > >
> > > > Thanks your mention. I have reviewed the latest kernel code.
> > > > I understand why these two tc function threads can enter the kernel=
 at the same
> > > > time. It's because the request_module[2] function in tcf_action_ini=
t_1. When the
> > > > tc_action_init_1 function to add a new action, it will load the act=
ion
> > > > module. It will
> > > > call rtnl_unlock to let the Thread2 into the kernel space.
> > > >
> > > > Thread1                                                 Thread2
> > > > rtnetlink_rcv_msg                                   rtnetlink_rcv_m=
sg
> > > >  rtnl_lock();
> > > >  tcf_action_init
> > > >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> > > >    act=3Dtcf_action_init_1 //[1]
> > > >         if (rtnl_held)
> > > >            rtnl_unlock(); //[2]
> > > >         request_module("act_%s", act_name);
> > > >
> > > >                                                                 tcf=
_del_walker
> > > >
> > > > idr_for_each_entry_ul(idr,p,id)
> > > >
> > > > __tcf_idr_release(p,false,true)
> > > >
> > > >  free_tcf(p) //[3]
> > > > if (rtnl_held)
> > > > rtnl_lock();
> > > >
> > > >    if(IS_ERR(act))
> > > >     goto err
> > > >    actions[i] =3D act
> > > >
> > > >   err:
> > > >    tcf_action_destroy
> > > >     a=3Dactions[i]
> > > >     ops =3D a->ops //[4]
> > > > I know this time window is small, but it can indeed cause the bug. =
And
> > > > in the latest
> > > > kernel, it have fixed the bug. But version 4.19.x is still a
> > > > maintenance version.
> > >
> > > 4.19.y is only going to be alive for 4 more months, and anyone still
> > > using it now really should have their plans to move off of it finishe=
d
> > > already (or almost finished.)
> > >
> > > If this is a request_module issue, and you care about 4.19.y kernels,
> > > just add that module to the modprobe exclude list in userspace which
> > > will prevent it from being loaded automatically.  Or load it at boot
> > > time.
> > >
> > > And what specific commit resolved this issue in the older kernels?  H=
ave
> > > you attempted to just backport that change to 4.19.y?
> > >
> >
> > And if you or anyone cares, here it is:
> > d349f997686887906b1183b5be96933c5452362a
>
> Thanks for that.  Looks like it might be good to backport that to 5.4.y
> if someone cares about this issue there as well.
>
> thanks,
>
> greg k-h

