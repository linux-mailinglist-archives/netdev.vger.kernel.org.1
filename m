Return-Path: <netdev+bounces-88278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C28A686B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB34E28262C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841E27473;
	Tue, 16 Apr 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gNRAIhcB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F56EEAE
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263438; cv=none; b=JH1jSa6zdnWQKt0ksVtEeS2QVDYWx0ijrTVT0Sw9Uom3SKBn/zhcCXbYRI3IkXmDc0wGcMlemsP6tn4zwOl9J58i+YynL/9HTmyQNmFeybTAIv8tpJiIVnbFuIf9pasoO+IrvHjAqPYWgN3j/dqrXlcwC6ENX+9VLTvq7u3habY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263438; c=relaxed/simple;
	bh=fhsKxRZgA8sKUniRyswNzIqbiI7LVZWNRncTh5Ojw44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im8eI1nRWxte8zcBtAXnzDl6ETjOaKycwf3e3jVwf/7nk7CgKCyvkIggqMSw2Yoqhp0fOZcGv4OQq5qTvCSvZlvAhrYeXQ82EroD3hpcZiHvHf9rFfXpdn9tC8M6TaTb/xbMQMxQMMIi9MXE0cT378qPu3Vr2okMC0sMEufQMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gNRAIhcB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-618874234c9so40538567b3.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713263436; x=1713868236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlID2NAn8kOiLqIs+s0uvcUHKEMHWqO3XPyFBCNFUso=;
        b=gNRAIhcBl2zXdkfndcC7DA+Em/SFHoa2JUefNPHyvXcYgAALjD4tMZB8k/t4QiYbFr
         dTbi+ig7Cb61Cr1s9FiogqGGDyFUf8KffSaRkW7+tLWPLX2m4uGx/jSqje3UOoUHQrwT
         mCj172XjjiQe4o/leE5I/eHPqr1eRUvNWlYpVt+zYZCioDsoCBVN+mPOwtAzfeKpdmsk
         /gqG+fuuMNKsFd8h7rf4CSPMFZxb3ltcqLNC+nbyV22mZLJW2p8oz+9tMq7Idzep+t+c
         Mu4oT+9ZRVAaOt1RNp7e0oWLR1W74lu3Ck72HCpkFv7M7cBxRW/+v0VCH49HHk1MxOJv
         qQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713263436; x=1713868236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlID2NAn8kOiLqIs+s0uvcUHKEMHWqO3XPyFBCNFUso=;
        b=F5TgcqiehdPy9ZNz2bK1Ez1ecczkt43v7+6SeEChRfi3Lg6BIjDw9viZV3FmDIYgoa
         9mz5ocDnyw2tWUl001LNByrbR2A1V2NyJNTrmCUI68BwsmMa3eEC/DCC6vwdjysfu88R
         ALauBFr5uhX98Jf2sZQSzRAC/v0lkjdr0pnAOx7Ccl/5LY00rmQsFmpNQiFcVkrQ2ZT3
         6f2RCEQRghYpR/1jv7U65mSRizePF580EgQUYb9Nn4mfI9JVvMWDhbkgIWew0wJvmhTl
         +wM8lA4gjKDkgADpu6MFIgbt/Y59VGA1S3fe4h85KEywlULGNq2qs1fY2Hy+MG/Fgjmq
         xr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcBURPUbF39J93PWG4wK97OrzouubdSp3T6YN+gn8dvdIwqd2nBReC3rhmhFbTsoWrdoB7p5HhtBalkWTMF/7O1LMG5jqN
X-Gm-Message-State: AOJu0Yx9oXiVf6uxMGBMllfm/5XWOI3VC74GObldlWCOK/UGNgsX4bKd
	XzZfIPUEkPUmJEr89MrehXkYEiCuuf96EPYjY1eiDrWAqcI3fQfumqz89TW4lmRFr02O6Uo4eAj
	OmLiOCDYy9OyVTOvyAzRyf3FhKneStL4Y8bIs
X-Google-Smtp-Source: AGHT+IEjd+vGWazdZ0PqeqTMWbig+j4sSed/Vo7Hkehkhl5HzY2AOvhoH8uCSfjnJKO1/+JrhfBheF06ydmPGSK+h9Y=
X-Received: by 2002:a81:a9c4:0:b0:61a:c4a3:8a5c with SMTP id
 g187-20020a81a9c4000000b0061ac4a38a5cmr4986423ywh.44.1713263435895; Tue, 16
 Apr 2024 03:30:35 -0700 (PDT)
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
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 16 Apr 2024 06:30:24 -0400
Message-ID: <CAM0EoMmjxPF8TXfqEO2iUeHcEfnpD50CPGJ7dHiSMWmTU40PaA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Davide Caratti <dcaratti@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:05=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
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

I wish i'd remembered this ;->  It is exactly the same scenario.
Triggered  example(eth0-->eth1-->eth0) as such:

tc qdisc add dev eth0 root handle 1: htb default 30
tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth1

tc qdisc add dev eth1 root handle 1: htb default 30
tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth0

So leaving it to you Davide..

cheers,
jamal

> --
> davide
>

