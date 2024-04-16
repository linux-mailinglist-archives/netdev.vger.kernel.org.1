Return-Path: <netdev+bounces-88247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2A8A6748
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298CF1F220CE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C986658;
	Tue, 16 Apr 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXn1VolC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332788627D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260238; cv=none; b=bW62SEVC6d/ptupVtZZwgRu6geaayOVYbC4QXmg5RWq0IBeHebETWKqGXxiHcElhNrd5AphCHEtvKYA33oVfOP33LUUx06iRa1ZEzGK6Fz3gdiy18Uvj0J+hFFpz9z0AK2vbnqe7n7kapRFxyKjvRLYC9CzSAsr9xnD6o0lP+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260238; c=relaxed/simple;
	bh=wqgEi7o93XA2/8o/x89YsQ5AF8TpVKd4dJQ8AO91cxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy7Tn1QjgWHSP4mEz/WKccOQkzQKof+IxnmqLEIN6ralTfmavJaBfmKRnrDTChdBN2RQFJT7JqNTwfE7w0W4RLk4rY1x73ohi9H1o/W2GcRKbAHFhvMGcm/WVgGMa5Y1U7KkX5hB229xww5s+Ev7ldsOHS2eGwfVFkCYY0GUO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXn1VolC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so8883a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713260235; x=1713865035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnO2uU8K31ExiRl1JW9q3b7OEZQTYGnUK5483kXv13M=;
        b=FXn1VolCL2LLe7iSTNHEuuL7ynRgoTcjx9JMkx2piUXGQRYGvtzxioouA59DaKpecG
         2tiObUeu48hZM0xzwJaxvtwuL/H/1HhWEad6ZC5/0BUY88PXh0VNMdpasciPFw5lRlR5
         m0Em2opQdfpeILM3SXWif5Skga4BXeNzN6MQwDtwECckyQiXTjPL0EEKpINJjcR9PvbV
         9XUP8vIiu+bL1AND/tDxSfrKT4OodJD27MHz6SL32IocbHG9Qre81/M7m/6sdPbPLgAY
         B4iqYXh0qON8Y0XYJ+bb/y2OiHrGFFl15sEvJ2cOzFJMk190oj6k7kDcYHWcvTP1MVj5
         e4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260235; x=1713865035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnO2uU8K31ExiRl1JW9q3b7OEZQTYGnUK5483kXv13M=;
        b=E4r/p0oUsbNdRRQKoYljLx4qquPwmlXfd6dic/gKYHevL8umPujNS56IXtCYKJlXDc
         dulZ3DCkjudiH4SZ255JZ+tQHRXm2VIE8Oq38NeuMcBfQKXyC9xzmSDX1i9Ssxh7xKeU
         gy1dHY7q7BDEAXVApLmM3Bk0ifcmRoMV0iozB9eBO9eF6pwrcuTEsr06v0hvYgPIm1p4
         acXkHaHg+cTI32/e+rKcQ4Abcwn4Xo9PHTLChYihaFZZEyoSmujvzyKvE5pyGv+XTV2E
         AQH0cv2von/eGboeAtgLhZ1zMIY3b2Jm8TRoIp4gIrb8AbcXvLnhqh8YMi+pv8eOG71S
         5Lkw==
X-Forwarded-Encrypted: i=1; AJvYcCVDBz2PzJpIATUSTLXCbfSRyE1mrLf6DeZx3nIirqudyXwA8/MYSG7jJ0ufQHt6Au4GLeb0gakgqs0fijWMSA6dU4dbrctn
X-Gm-Message-State: AOJu0YwqYm44I3SR3p8DaxddX/j4R2hCDCgzha3vFJuRaueXsC20Sjk0
	pKdAGgMvZfR6gAqaFNr8jsJF2Abxs0CQBnfxdE5vvC63TVv1l02ProicB381k/nJ3Ijs90ATHVj
	fAErE0EjPF8rU33b5WctJjRCgUsmYup7Qw1y/y9uM013mUbaNaw==
X-Google-Smtp-Source: AGHT+IEPs6l6BkaDiuPmH0orkke9DhTYyNiu7kk5+YQxtiQg71X4vzRASOFoerVx9XsktAJQtBlKjNyEhDzQP6V4Luk=
X-Received: by 2002:aa7:d752:0:b0:570:fa4:97d6 with SMTP id
 a18-20020aa7d752000000b005700fa497d6mr151732eds.0.1713260235173; Tue, 16 Apr
 2024 02:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
 <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
 <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
 <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
 <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com>
 <CAM0EoMmdp_ik6EA2q8vhr+gGh=OcxUkvBOsxPHFWjn1eDX_33Q@mail.gmail.com>
 <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com>
 <CAM0EoMnKh67wGo5XV1vdUd8p8LhxrT5mtbioPOLr=sVprYNKjA@mail.gmail.com>
 <CAKa-r6tNMuAR0RXuGbYLFW0jhpbPn4BvW1erGcqu0nCLRzH-aA@mail.gmail.com>
 <CANn89iJQZ5R=Cct494W0DbNXR3pxOj54zDY7bgtFFCiiC1abDg@mail.gmail.com> <CAKa-r6tLA82W9kMJABKG1fKfBiWjsD3nkaSwwzhnRD0O8QfWwA@mail.gmail.com>
In-Reply-To: <CAKa-r6tLA82W9kMJABKG1fKfBiWjsD3nkaSwwzhnRD0O8QfWwA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 11:37:01 +0200
Message-ID: <CANn89iK92fYoHOerB_wArODthu30dcY753fmN6GQf1UP8ciwqg@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:28=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> hi Eric, thanks for looking at this!
>
> On Tue, Apr 16, 2024 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Apr 16, 2024 at 10:05=E2=80=AFAM Davide Caratti <dcaratti@redha=
t.com> wrote:
>
> [...]
>
> (FTR, the discussion started off-list :) more context at
> https://github.com/multipath-tcp/mptcp_net-next/issues/451 )
>
> > > I tried a similar approach some months ago [1],  but  _ like Eric
> > > noticed  _ it might slowdown qdisc_destroy() too much because of the
> > > call to synchronize_rcu(). Maybe the key unregistering can be done
> > > later (e.g. when the qdisc is freed) ?
> > >
> > > [1] https://lore.kernel.org/netdev/73065927a49619fcd60e5b765c929f899a=
66cd1a.1701853200.git.dcaratti@redhat.com/
> > >
> >
> > Hmmm, I think I missed that lockdep_unregister_key() was a NOP unless
> > CONFIG_LOCKDEP=3Dy
>
> yes, the slowdown is there only on debug kernels.
>
> > Sorry for this, can you repost your patch ?
>
> Sure, but please leave me some time to understand what to do with HTB
> (you were right at [1] and I didn't notice
> htb_set_lockdep_class_child()  [2] at that time).
>
> thanks!
>
> [1] https://lore.kernel.org/netdev/CANn89iLXjstLx-=3DhFR0Rhav462+9pH3JTyE=
45t+nyiszKKCPTQ@mail.gmail.com/
> [2] https://elixir.bootlin.com/linux/latest/source/net/sched/sch_htb.c#L1=
042

Great, thanks for your help !

