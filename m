Return-Path: <netdev+bounces-244801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3451CBEE7C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D96903020156
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE8320CB6;
	Mon, 15 Dec 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="q940D0yP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19E2F3618
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816044; cv=none; b=VO7LaYndqoZitsewZqWHBSe7bBW0iWhcyu8oD8VCBiooIvcahbvBG9e+UmHY2PuWFoYKQtOXcHyhI9jZSYzS0J3CgEu4FUozR5CJesNkyZ/n0VjCmRgEs/kcvpbQgb6pumr1qZDMT1lMUEjl9lTBxG3QMYimseVY3NGwfvhq1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816044; c=relaxed/simple;
	bh=pGfGkm/LJKhlHj8QpkNFdNobVUFr7n+CQPnxy61rcfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKE30gxHcgXBRAAQEA1SVtXJB21bxYEpnz6BtMY0Y/XDRefVW0Lf+cpi7r/E4yDG+5CXp+PQ3r/cN7m/IU4RwwgBwBjwi6ONsFKSfl//jOcCAAruA/HKfQE2WrV3hhNiIAknOTXX/dRwpudb8gZA5Q5Hq8RpqL/QiAOw4hzX7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=q940D0yP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09d981507so15007825ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765816040; x=1766420840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeFjW4GGBlfUil//ONawh35XqY0NMR/rqexb+Jz1U8Y=;
        b=q940D0yPcJ5ZD/nhNMjoFOB+Acoeae4t0VkQ+iWA9qOCfirMbmF/cUeKMucelmn3Ki
         BC6jN3dWkrarT0Wi82suooSx75d0WhG9GISiyZF3I0BsLqYl047XL19i5nst/OiptvOj
         gA7QdsqkvwLBB6ba5N/XpzIjsPZIwPX75z7ZknONhpILNYg/0sAg/MBhXmh3+GHetovW
         Em0IG5GJjqU37gY6LJgllJUYOPjNXEUybmab2JRDF8QIlgOomfGXk3UZzdVbT9WcTsVk
         pbTqiMwdlPi0mw8kdT9vKQt4QXxepCH93KIVSlDh8sZ4L+hZPTkaOkj42wnUR1VzPmJ9
         J8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816040; x=1766420840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eeFjW4GGBlfUil//ONawh35XqY0NMR/rqexb+Jz1U8Y=;
        b=VPeIVH5U8/74tPV/8jucEuFCizs1uPk33RObFXjB1HIBO8uxgskP6FRhutT3DHtKZp
         n7Vzeo4iwGKbq2DbX9CP19i+XbQ/U5uXf+Fa2UFtWlyyGtUYqaBs6QfNXrHUmNgnlOCY
         02CWPRamiVuK9mkRnNIJz74ZVLmJp4xT1sLGtOdlxnMM6h3VM131GZ/6JP9PZm+arCqO
         dYaC86mZ+US+uF/1L/IQKySDC1GkPnpIOUZLYQHENMZ9CGMNRWUcEmkwsyIz+xDMK3Hj
         icjjdI7qAyqeWiAdRIhdwkhWmDah4FpmDJVdLRQDOmNzwswaBoEV7X4xnuK6dwtix8YJ
         GW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoHE3ABFUSxrcz1KnVvVSAe6xtvq69Bkl7DHYs4lQjZePhsWVzEgfKJeYG/Gb94lOXozt4gVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Vs0JCK0cGYHQHN487DeUvpdl8WxkLJQbZhx/LszbAVhLMQ2W
	YTUgZSDB2BKo6ERdPJIHEvoDIlPbcB3nzqZEzggJBIJxz+q8csbZaKF13ONbMq0vOJPXEdF1X83
	+VCJBeQJW1qnlizn4DC/YCQe0qb1j0tj3TY8xF21Z
X-Gm-Gg: AY/fxX6bid4zOrNKBXdYFf81K+/PiU3f2+meiL5bb7dkF8tVq3w94dvzVP2kAJkp1AR
	/Fu1HDdtA5iDAzbvFEh8zOB+iGXojFdN8zhiTWrZdHw1PjA+q3FqUdjpC5KcwPn66Omn0dZ5/I0
	ijSU8IjuNOYkOMx9yQ4WSSLIm2nnT9P2OSjaEePhr7dfLiaMzj1BoeVRmAqfG04CCv68ToKOVg0
	Wa12/3CMyiuVgBSXWO/mTu7qT/NB6+7jUJZCGzOB99MpxFgk5fKlNQsmVRgizpG9qYMaQLIKNzY
	byo=
X-Google-Smtp-Source: AGHT+IFUVGYJxDeOj/+7z2Sw/SnjfxffqQt8jBtVOKRWth8gPUTjMl0KDV8NE/zl2q1+LXxUhP1x5cGN20SnRcoqe3s=
X-Received: by 2002:a17:902:c94d:b0:295:6117:c597 with SMTP id
 d9443c01a7336-29eee9f1eb6mr160256245ad.5.1765816040355; Mon, 15 Dec 2025
 08:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com> <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
 <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
 <CAM0EoMneOSX=AMe53hQibY=O6n=KYnudAWfVtUdOf8qc_Bmw+Q@mail.gmail.com> <3kwhg36anlckq57bez25aimvyj@altlinux.org>
In-Reply-To: <3kwhg36anlckq57bez25aimvyj@altlinux.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Dec 2025 11:27:08 -0500
X-Gm-Features: AQt7F2qOz_HulbV6PMgGMsTzSxb-3zDgxkIjNkh0vPROCEBMB_qv8gXlxJpj1fA
Message-ID: <CAM0EoMk+5z0uiwdjvm6Fvx-RWOy0hWJrM4C6iPnCKv-Sh=uk4g@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
To: Vitaly Chikunov <vt@altlinux.org>, stable@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ranganath V N <vnranganath.20@gmail.com>, 
	linux-rt-devel@lists.linux.dev, edumazet@google.com, davem@davemloft.net, 
	david.hunter.linux@gmail.com, horms@kernel.org, jiri@resnulli.us, 
	khalid@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 4:38=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> Jamal, and linux-rt-devel,
>
> On Fri, Dec 12, 2025 at 11:29:24AM -0500, Jamal Hadi Salim wrote:
> > On Fri, Dec 12, 2025 at 11:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Thu, Dec 11, 2025 at 7:54=E2=80=AFPM Vitaly Chikunov <vt@altlinux.=
org> wrote:
> > > >
> > > > On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > > > > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > > > >
> > > > > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > > > >
> > > > > In tcf_ife_dump(), the variable 'opt' was partially initialized u=
sing a
> > > > > designatied initializer. While the padding bytes are reamined
> > > > > uninitialized. nla_put() copies the entire structure into a
> > > > > netlink message, these uninitialized bytes leaked to userspace.
> > > > >
> > > > > Initialize the structure with memset before assigning its fields
> > > > > to ensure all members and padding are cleared prior to beign copi=
ed.
> > > > >
> > > > > This change silences the KMSAN report and prevents potential info=
rmation
> > > > > leaks from the kernel memory.
> > > > >
> > > > > This fix has been tested and validated by syzbot. This patch clos=
es the
> > > > > bug reported at the following syzkaller link and ensures no infol=
eak.
> > > > >
> > > > > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.co=
m
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d4=
86aee
> > > > > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > > > Fixes: ef6980b6becb ("introduce IFE action")
> > > > > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > > > > ---
> > > > >  net/sched/act_ife.c | 12 +++++++-----
> > > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > > > > index 107c6d83dc5c..7c6975632fc2 100644
> > > > > --- a/net/sched/act_ife.c
> > > > > +++ b/net/sched/act_ife.c
> > > > > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb=
, struct tc_action *a, int bind,
> > > > >       unsigned char *b =3D skb_tail_pointer(skb);
> > > > >       struct tcf_ife_info *ife =3D to_ife(a);
> > > > >       struct tcf_ife_params *p;
> > > > > -     struct tc_ife opt =3D {
> > > > > -             .index =3D ife->tcf_index,
> > > > > -             .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > > > -             .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > > > > -     };
> > > > > +     struct tc_ife opt;
> > > > >       struct tcf_t t;
> > > > >
> > > > > +     memset(&opt, 0, sizeof(opt));
> > > > > +
> > > > > +     opt.index =3D ife->tcf_index,
> > > > > +     opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > > > +     opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > > >
> > > > Are you sure this is correct to delimit with commas instead of
> > > > semicolons?
> > > >
> > > > This already causes build failures of 5.10.247-rt141 kernel, becaus=
e
> > > > their spin_lock_bh unrolls into do { .. } while (0):
> > > >
> > >
> > > Do you have access to this?
> > > commit 205305c028ad986d0649b8b100bab6032dcd1bb5
> > > Author: Chen Ni <nichen@iscas.ac.cn>
> > > Date:   Wed Nov 12 15:27:09 2025 +0800
> > >
> > >     net/sched: act_ife: convert comma to semicolon
> > >
> >
> > Sigh. I see the problem: that patch did not have a Fixes tag;
> > otherwise, it would have been backported.
>
> Thanks! I will pick this for the local builds. But, perhaps, someone
> should send it to stable@kernel.org to fix the older -rt kernels too.
>

+ @stable
Not sure if this is enough. Let me know if @stable needs something more for=
mal.

cheers,
jamal

