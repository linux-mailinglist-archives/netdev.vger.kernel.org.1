Return-Path: <netdev+bounces-88220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEDA8A65AC
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A49BB21704
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661A82C8E;
	Tue, 16 Apr 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht4CpKzG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991C6F066
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254752; cv=none; b=P/KOABxwW7tASmNqfLwVEQyn16tQozM5MecISzi3pAT/XM1EMPReSNDlCUXXgg2Nj0VmwLkgoUpvrtus/He8PoJqct4ku2E/xVMbpSWZCyaXaqPdI3ILCort23VonQFsZtjxqC/Axq6WM4arH0UMJ2Zns+OEaBU9phmDAobSqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254752; c=relaxed/simple;
	bh=Dxj0Hhx6hXr6d5PMmla7qb1sW6EAca1XfiNKS1tQGhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5E8omplpiYOUpNSWRE3HQbRrrTVv8mCiaATyQKgxILzqUed0VCP41Guw2dO3CH7cfEz4XvfM+/JHVHpbokKuYi0yNSQVfgCxl5BmKrObOuyR77LYhjz4uyBfU4QpAd4goD2vv22bDoz6/iOdMRX0m/QlFmI5nD7XAm4MuTFT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ht4CpKzG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713254746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8M2+7m/dx14DrPihTBNC9BjUd6JP+Zvk5co7qqWvO0I=;
	b=ht4CpKzG582DgcNbTlPM5zlgm3rQJKCL21H04zi5eP0p5IUhejP029K9GJhKjg/ARlp7uc
	GljhwkbYgzr+93nUk4BSEEHvHiMCTGPQb19HHIOt7sOWj6b1TWnL311nf6E51DInjT5c6k
	IGYvAI94vBQoCh3I/Fk/WlnEepi0mNc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-P5izMkakOXGNww6XSTDnrA-1; Tue, 16 Apr 2024 04:05:44 -0400
X-MC-Unique: P5izMkakOXGNww6XSTDnrA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a53909676fso3834823a91.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 01:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254743; x=1713859543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8M2+7m/dx14DrPihTBNC9BjUd6JP+Zvk5co7qqWvO0I=;
        b=gIjy+ql6OLz5QTkT0ydAmHe9tk26nMtDcTijlll6jD3vN1mY2S9uZ1C3z3b/U0VBDq
         3jHmhmaBrMcrN0QD+9knFCU8MDutSi69zUHz2PpdB0UYACndeqJGj8/Ni84PT94V2l5Y
         Lksq0l+0RRgSyCwukCzwjtJBY63nUbRtflELEaoxJnIEAKqYON8TH7lgVhddxEvpVTru
         iXQP+BAZGZzC2oVXhYQjNLrYm01LkPdxPPArjUsVRE9AHTZg5Nyw/eirbNvmEL4lCPCf
         Dq5wiLTtLtNkZrU6nTrlyAG/A6Lyjj6RNqJovia5CAMM/96cyKy863CARmo61ERpByQJ
         JoNg==
X-Forwarded-Encrypted: i=1; AJvYcCVAO62sOGaM60rdT6XBDtcuyVTuFZYW7Oi8NLZUieTkhC3LcSi0uE6Nrxq7rHeXkFtAoSxq25902PJTL58GC21zYdODj6oT
X-Gm-Message-State: AOJu0YxaDafNHmnYnQiIMOcxoKDYu5CSZGG9qblHvTgeqnQwOAiLBbnT
	yhEYGC6TejgmFEvCLMipuG6lJpP+7n4Q1seGo85m/TBdXabErlIL+f5kO9gvLJ/VHSSVMtbi73Y
	PQ/EfxNoK2sBCnXd+fLcS2eUX6a4zgSZhuJo/SPVJSmLmtVJ+hkuTJ5dt7/k9Fg2meYjBV5Mw8q
	xa3YxKD4RRDlMiDZ6ztbqwbnBUgRCZ
X-Received: by 2002:a17:90a:dc0a:b0:29f:ef34:3004 with SMTP id i10-20020a17090adc0a00b0029fef343004mr10514423pjv.43.1713254743048;
        Tue, 16 Apr 2024 01:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIthdkzYZyQB5RfrPWYbm8VKYTlfdr9CE9FoaXNprgDKvBhnS3838gkc7f54cTc8wvylu4sncEJCMD5gBIa1s=
X-Received: by 2002:a17:90a:dc0a:b0:29f:ef34:3004 with SMTP id
 i10-20020a17090adc0a00b0029fef343004mr10514398pjv.43.1713254742535; Tue, 16
 Apr 2024 01:05:42 -0700 (PDT)
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
 <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com> <CAM0EoMnKh67wGo5XV1vdUd8p8LhxrT5mtbioPOLr=sVprYNKjA@mail.gmail.com>
In-Reply-To: <CAM0EoMnKh67wGo5XV1vdUd8p8LhxrT5mtbioPOLr=sVprYNKjA@mail.gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 16 Apr 2024 10:05:31 +0200
Message-ID: <CAKa-r6tNMuAR0RXuGbYLFW0jhpbPn4BvW1erGcqu0nCLRzH-aA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Mon, Apr 15, 2024 at 11:15=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
[...]

> Victor sent the patch. As i mentioned earlier, we found a lockdep
> false positive for the case of redirect from eth0->eth1->eth0
> (potential fix attached)

I tried a similar approach some months ago [1],  but  _ like Eric
noticed  _ it might slowdown qdisc_destroy() too much because of the
call to synchronize_rcu(). Maybe the key unregistering can be done
later (e.g. when the qdisc is freed) ?

[1] https://lore.kernel.org/netdev/73065927a49619fcd60e5b765c929f899a66cd1a=
.1701853200.git.dcaratti@redhat.com/

--=20
davide


