Return-Path: <netdev+bounces-88243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F288A6721
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F5EB22DD3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063D8528F;
	Tue, 16 Apr 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnxHmjnb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC35A10B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259733; cv=none; b=SiTYRHAqnzaQ8ogeIm3I8VIvPoGrRLvzZPfW0Fg0jXkYnCBqp2CcpG8fGSRhxUvJF6NWu4yE/i24NIOZS5M5VpzhGteaAzL4zkWDTjqSrJNSScd0UE54hzo2VQXzPuB3zPJv/5uSlka17RUBr445RYWv77Ws3o5HMQSQvE448Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259733; c=relaxed/simple;
	bh=WhINVkDszqAkUyNwPPJsYbWmg+wqw4ZzDZG+iWCtja4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpkfekgnQPiXc4cpjY3B257qyt50AI0QXJg9SPOmfQyrPDjiy5SXng8e0wIUWT6Ed6xI18hYSfltUCyyYM49b3KY8tW06KZp+sMHkusIKRNIGscb4DvCOaIYDjwx0zwHajXdZsGLUZzXjyf2qpG8z7eyY3+KNIxZ+1F6NfSw//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnxHmjnb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713259731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7W9hQvlTkAh6+Z3RN9R1kaKhMSBVVpbCl4DAfDTy24=;
	b=CnxHmjnbt8Ipvl385P8qIMgNL4cARVOnLdQEldKxIUMtHOvgYy1MfGO/N2SBDkXZTC4faZ
	mOD6Z4qjtexXVop4a05dL5B8u51bnRzQhEPaYIl+G0pUZQdVybTYZS8VzHeigS9VnZQ4N0
	Giu70wLvokqwvrtuNBohEND8VIAXgCw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-6kF2Ci_jN3mX9-HZqXQdpA-1; Tue, 16 Apr 2024 05:28:50 -0400
X-MC-Unique: 6kF2Ci_jN3mX9-HZqXQdpA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so2215750a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713259729; x=1713864529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7W9hQvlTkAh6+Z3RN9R1kaKhMSBVVpbCl4DAfDTy24=;
        b=YElf6QqcoJ0JtRKn6BqlMT38/l2KNtewEMVaL6nK/Zy40PGhnBruzvT82Ji9vDUml5
         XW48ooi/SbtVEGqDhj4F02HvlzMTYN+uLe6JDxbuWOCW4EqNBI++Ka2UDFIYT0MpUk17
         nZ2mRmYKL4Ht/knSzNtFQJp/ThYqQNyeIcpNkKrhxXtxhNzwyLALdC2jqiXu6xtRQnGb
         wNu+HLcuobgfdtND2p7kBs01Nl3EjXPWSe+I5dKQsBei+dtQ8ojxvtu5SdnGR/yA54le
         0Bts4vh6SII0zJutvg+gXOqWBGdDb5cvfEF5zKf/BkNSfyeyx41RqsJ3IBCliZL5YNi6
         vTwA==
X-Forwarded-Encrypted: i=1; AJvYcCXj6qtLS1wXUoSeVNz5p3AUp/NInQYNEdcyvBNeVwfVRhk2YfOgzMqiU9jiXKMehEsFslYRRakOiKcA+4VbDm5pXrR6nda4
X-Gm-Message-State: AOJu0Yy4SXY+1d0LfjFAnpShfxLGq8sE8e/DSza5G2q8KVtNnY3Zmojs
	opzR9IGr5RYqmVSfyTa9gZeC4ySx+5NrIj+t+2hJW5G4h3qxWnknaaDyt5bVD5qRSHdpatK+20i
	8aVOHL2zp4MLHvDK/MXOVFJgdtuS7UyV1ylRtB3PR0RcJHXfhP8OxKRkdrr5W0aVSz6aHGJ1rqS
	rj8flOM+lTtib4W9126jvfgm1vgAGh
X-Received: by 2002:a05:6a20:1059:b0:1a9:5bb1:ba27 with SMTP id gt25-20020a056a20105900b001a95bb1ba27mr10711411pzc.9.1713259728511;
        Tue, 16 Apr 2024 02:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvI8wL9HDi5f1mmAsblnELdBmGyhavlblo4v+pk+a08zV2V/Vjg1ue792qwHGy75Po1a9JBDjE7rn14eVmeUI=
X-Received: by 2002:a05:6a20:1059:b0:1a9:5bb1:ba27 with SMTP id
 gt25-20020a056a20105900b001a95bb1ba27mr10711395pzc.9.1713259727937; Tue, 16
 Apr 2024 02:28:47 -0700 (PDT)
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
 <CAKa-r6tNMuAR0RXuGbYLFW0jhpbPn4BvW1erGcqu0nCLRzH-aA@mail.gmail.com> <CANn89iJQZ5R=Cct494W0DbNXR3pxOj54zDY7bgtFFCiiC1abDg@mail.gmail.com>
In-Reply-To: <CANn89iJQZ5R=Cct494W0DbNXR3pxOj54zDY7bgtFFCiiC1abDg@mail.gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 16 Apr 2024 11:28:36 +0200
Message-ID: <CAKa-r6tLA82W9kMJABKG1fKfBiWjsD3nkaSwwzhnRD0O8QfWwA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Eric, thanks for looking at this!

On Tue, Apr 16, 2024 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Apr 16, 2024 at 10:05=E2=80=AFAM Davide Caratti <dcaratti@redhat.=
com> wrote:

[...]

(FTR, the discussion started off-list :) more context at
https://github.com/multipath-tcp/mptcp_net-next/issues/451 )

> > I tried a similar approach some months ago [1],  but  _ like Eric
> > noticed  _ it might slowdown qdisc_destroy() too much because of the
> > call to synchronize_rcu(). Maybe the key unregistering can be done
> > later (e.g. when the qdisc is freed) ?
> >
> > [1] https://lore.kernel.org/netdev/73065927a49619fcd60e5b765c929f899a66=
cd1a.1701853200.git.dcaratti@redhat.com/
> >
>
> Hmmm, I think I missed that lockdep_unregister_key() was a NOP unless
> CONFIG_LOCKDEP=3Dy

yes, the slowdown is there only on debug kernels.

> Sorry for this, can you repost your patch ?

Sure, but please leave me some time to understand what to do with HTB
(you were right at [1] and I didn't notice
htb_set_lockdep_class_child()  [2] at that time).

thanks!

[1] https://lore.kernel.org/netdev/CANn89iLXjstLx-=3DhFR0Rhav462+9pH3JTyE45=
t+nyiszKKCPTQ@mail.gmail.com/
[2] https://elixir.bootlin.com/linux/latest/source/net/sched/sch_htb.c#L104=
2
--=20
davide


