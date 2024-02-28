Return-Path: <netdev+bounces-75808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7986B3DD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BA1B215D5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EF15D5AD;
	Wed, 28 Feb 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bUuqaAYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823A146015
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135847; cv=none; b=rkZ5yHlfWj3HAFdM1Zj3JFCbJ+3N7/fi8NZRAsOUUIgiCLPzp16NfhuQET5CIedun3iEb8lbJBVXRGy2+riGEGRTfOdZo/O2ivdwv9BEQ4LCT7OAgtIXj/RliW3mICGCUWDOZgPJj1Ru5EUrjiNXq68s8lrufEA7kpeGRDCci88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135847; c=relaxed/simple;
	bh=TntFyzEBDmvjeG6lgJOTxzaH04I3ce53rz5JasdYp70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr5lj1bEFGMbihZpqR0FyOtJAbjeTq+4S93jRbxdWx3MMpg+jQvCza4XFJcCtJ3zgMzDFt1CpUrLYGuN5T6f75dJaOCsXS5uXNLrQmovRhoG5sRZqeATMbqY2zwMKFGYsYmGjTHhnq4OWAycdh39MLK/PXxSfNGgST+k4c6bJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bUuqaAYC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so7368464a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709135844; x=1709740644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWTMXfWT3+HIW/VeHNOCaZnDk8xJkuA4vn6TyWTnAFY=;
        b=bUuqaAYCb/0yKZJkefXnqNBOBM4/t4KlwX9depAjKf+mTQEGguayD1CbxeuGG7tiAs
         GI3dGts8ddNwkY2k1zOMTpqrZy2wzs8SgjXF73apVmzTsEh3+HwYvSR/XDlgjfoz8MTa
         Ui6M4P3aSqrdt5TJEUutPk5ZAtgOOFAvLxPJVCf3NaLV42uxv9g7q/FPGeGwJwDTsRkK
         cG5mZs5mkJCf9HT8f7Sm5Q1LYcvfoBiKIJvHiaVRwMhnRxyT/ZSatdW9Ew2+kpOvisbb
         mPLcEASNgoWEniApjgckDAzgxD3seZRp4otEcaGgo/zYeV1Xk32Mw5+ov9V5tgxpDCOj
         wRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135844; x=1709740644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWTMXfWT3+HIW/VeHNOCaZnDk8xJkuA4vn6TyWTnAFY=;
        b=gNxi56Nq4Lzzhstmt8BcMbKfbWZE+rDKXWZDAw49GyLry/C1Yr4sIxlSN0+g+2rtJR
         ncIX11tk73glCOZZsszMTlr2EZx92W4rcfZww5wGqMmfHUHbicYrMZu6OuYpzjRtL0oJ
         fcuy1QK+fQMD6YKldh88MdWI4da3J+6PMTjVsQ7iHo7pIun/zQJHxdgOCasgxdvelQfs
         ucay3I0Lg2+LZhCV+d9zaMAHvmuDmPBn0kgqEuSy6II8XVrwS84zZsywjGrir6Rq3/6X
         j8vsISx+bPMI0ufD4yHpD4Ty7K/0sEPiYrJOyqOa1eaSVTA7gLjlDunViBRFs560JHIY
         XgrA==
X-Forwarded-Encrypted: i=1; AJvYcCVyY6lTHhlU7JSu067mMzegnc+gCQB1nzfJFw6HJBxjv3jyaz47rR/kFTRbQKhbmPCdD85cVLBsueYYkQHTCUEZIQK6lSJn
X-Gm-Message-State: AOJu0YydtPSK1UvPaeUpwSonQMCLvMujDzsHx08K0EG09mMRLB/JYK5d
	j47oP5IUSZi1QDeitf3e0nXBZlpYdvuk75rzAYwVPmueaL8XUsqhungWuT3CusLAnr+uhH0T+gZ
	G39tp+mmaBENBsHLnYqDgxvd2ijyNrb4rPw8RYQ==
X-Google-Smtp-Source: AGHT+IHLo6cGjMnZBsFUHICQtxAQoz4FMO0YzyebxfXgxsFVXIWI5YRBRpigVFarMceZT4fNTa7BinDaYjco5LKfF0I=
X-Received: by 2002:a05:6402:3456:b0:565:6bbc:3839 with SMTP id
 l22-20020a056402345600b005656bbc3839mr8344503edc.40.1709135844452; Wed, 28
 Feb 2024 07:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <20240227191001.0c521b03@kernel.org>
 <66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop> <20240228064343.578a5363@kernel.org>
 <9a0052f9-b022-42c9-a5da-1d6ca3b00885@paulmck-laptop> <20240228073544.791ae897@kernel.org>
In-Reply-To: <20240228073544.791ae897@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 09:57:13 -0600
Message-ID: <CAO3-PbrFSrQZQczp7nEj=HLn4GLL+UY0SUCJentgOAJ480dqRg@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Feb 2024 07:15:42 -0800 Paul E. McKenney wrote:
> > > > Another complication is that although CONFIG_PREEMPT_RT kernels are
> > > > built with CONFIG_PREEMPT_RCU, the reverse is not always the case.
> > > > And if we are not repolling, don't we have a high probability of do=
ing
> > > > a voluntary context when we reach napi_thread_wait() at the beginni=
ng
> > > > of that loop?
> > >
> > > Very much so, which is why adding the cost of rcu_softirq_qs()
> > > for every NAPI run feels like an overkill.
> >
> > Would it be better to do the rcu_softirq_qs() only once every 1000 time=
s
> > or some such?  Or once every HZ jiffies?
> >
> > Or is there a better way?
>
> Right, we can do that. Yan Zhai, have you measured the performance
> impact / time spent in the call?
For the case it hits the problem, the __napi_poll itself is usually
consuming much of the cycles, so I didn't notice any difference in
terms of tput. And it is in fact repolling all the time as the
customer traffic might not implement proper backoff. So using a loop
counter or jiffies  to cap the number of invocations sounds like a
decent improvement.

Let me briefly check the overhead in the normal case, too

Yan

