Return-Path: <netdev+bounces-88240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8C8A66CF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D9128629F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5F67A1A;
	Tue, 16 Apr 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrsZHW+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59185205E10
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258888; cv=none; b=puth1ndZCiU2h/DPP5pVIqS3mQkqqQJQH4lCfdvmuHwbM370T6nJQynfMH1d0v73/SXGeFbHAg+OW5An610q4XoVrm9KY/NfUD2GbjtCsA8JcOlw+/Lz0WYqEcqHZnSXcJvPesoOvudsxWPZtApX2TlrNByGw2n4MwNhwnFSaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258888; c=relaxed/simple;
	bh=p5A+FmshabQPklerWfVdNunFt6kxFD+LtiOLKOrRwmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzOB8GR4JdFnrPZoitjrpGOpFxN1tGcneHRgqOoAKJ6Tmnmi4EM3UyhkVWm/swTJg0vXcyK4FXuAct+wW/tFgsK0LJPYXJjX1PQM6ro3FbRU7iktgA8GU5l+a7cRtzFuM36ggWYPbbtr3PtMFsNVuQq87WtORmJfPII3HEurn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrsZHW+U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso8883a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713258886; x=1713863686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T1/g8SLYMEVMxmnwXmx00cL8lyMdNVj3Q9MXayeKsE=;
        b=lrsZHW+UwhZbH6wn45Y38a+H9Rga72D6ax/KEqnNZC+WQM7Wy61G+dchKL4V+tP/fX
         HhG9qLUjK0Aj08Su2oce+JZ/OTSoQVUpiZ0y0epaDtqrKFSwo0Eadpb/84OlkLypkH1Y
         PhT5TGFnEIL5QlfM/gk9wLAkmBAOczL0GvPLtuxEiwdVXJgWgBSaEp92Xyo0q8FLq09L
         LTlqP0mfVfgCDm60Pw2wXXJW3RtU1uY+/P5dD7nFCw8WOcx8pcLV2IdAQGA7IfAM7d/w
         PKblYzP+On7gFtkGft39Zwggeqb8ItZLR+aWJhvkk5xhBY+9vWWdkJ7p8tt/Tjv4j7tb
         v36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713258886; x=1713863686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T1/g8SLYMEVMxmnwXmx00cL8lyMdNVj3Q9MXayeKsE=;
        b=eINsBu+HmSIO5SH6ukGecWbWf3HwnehziJg3TlzV4rqe3qUcF5ovtOkRUXjWrAQfpx
         3JSl6n/40OIL3NCKtLfyleiOSRPtce4ksaGBkPeiW5kPUfvVzQQoydwNh2+dZavlXt3b
         KZKXxdr7CjxvQOg7yz+z+0mENo8wPenLvLdBPYlIWMd+PzG9panzNyvFUUx4sonJ4TeS
         emZzmwjxDVrRFt2JFCLJno65felNdvz4Au9L6n1uY5+HuPVifORbQ2m4hZu06TsDvZko
         ji2UDsahmHdAw2ORmMe+VpmjgGbN+LU9dso4tiNLFumnXSbbOMD5KFJ3s666Q8g3qrGo
         l2DA==
X-Forwarded-Encrypted: i=1; AJvYcCXKfzZAhz3ORj7rdSvf2DHni23eUpMm4YNH8neQs0Z/78xa3NKI+i6rZYrCfoa2RlEJ9440elGyvQ/4IRZ7vN+ZfFVoxYjg
X-Gm-Message-State: AOJu0YxYAfDY2q8CJFDSy9PAcyz7ls5ln2YntTSFNwvzm9mCb/1kzOnZ
	l5WorVN8UDc54yS063Etlh4g9e6UAJ0jeJh//mR52p4OCED6I7xu+0wjMhV/8Dx8Is276+XtGFN
	L0R5K5e+CwLWnyaywPOJqh09HdwyGqTd+dJ36
X-Google-Smtp-Source: AGHT+IEJnJuIkdmQhKmtemsqDE0mH9/bJXAX8RSm6OTDfuWp2hgtbOdgm/KhEpR2/qeEnMhYjpcqucZJMllqfTMHTvk=
X-Received: by 2002:aa7:d654:0:b0:570:320c:821a with SMTP id
 v20-20020aa7d654000000b00570320c821amr133279edr.2.1713258885418; Tue, 16 Apr
 2024 02:14:45 -0700 (PDT)
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
 <CAM0EoMnKh67wGo5XV1vdUd8p8LhxrT5mtbioPOLr=sVprYNKjA@mail.gmail.com> <CAKa-r6tNMuAR0RXuGbYLFW0jhpbPn4BvW1erGcqu0nCLRzH-aA@mail.gmail.com>
In-Reply-To: <CAKa-r6tNMuAR0RXuGbYLFW0jhpbPn4BvW1erGcqu0nCLRzH-aA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 11:14:30 +0200
Message-ID: <CANn89iJQZ5R=Cct494W0DbNXR3pxOj54zDY7bgtFFCiiC1abDg@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:05=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> hello,
>
> On Mon, Apr 15, 2024 at 11:15=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> [...]
>
> > Victor sent the patch. As i mentioned earlier, we found a lockdep
> > false positive for the case of redirect from eth0->eth1->eth0
> > (potential fix attached)
>
> I tried a similar approach some months ago [1],  but  _ like Eric
> noticed  _ it might slowdown qdisc_destroy() too much because of the
> call to synchronize_rcu(). Maybe the key unregistering can be done
> later (e.g. when the qdisc is freed) ?
>
> [1] https://lore.kernel.org/netdev/73065927a49619fcd60e5b765c929f899a66cd=
1a.1701853200.git.dcaratti@redhat.com/
>

Hmmm, I think I missed that lockdep_unregister_key() was a NOP unless
CONFIG_LOCKDEP=3Dy

Sorry for this, can you repost your patch ?

Thanks.

