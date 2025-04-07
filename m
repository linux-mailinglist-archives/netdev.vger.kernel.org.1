Return-Path: <netdev+bounces-179949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A93A7EFCA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C53AC107
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2B218AD4;
	Mon,  7 Apr 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Q3JufR5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC6185B4C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062044; cv=none; b=hIMSk9qh2vnJwdSV3jbnYNZq3rmvQQEftHVHeAaCvrUvD3o5Aiuzs1OtAEf4c6kbaiy3sGMz91WnzdeHq03TWJnMjGjS5rC8HaCRt72slplpuW26D5IZlxinyc1jyiTwALT/LgTnyiacgbQ8By1+OL4TY+tUMu5eXQW01OLp6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062044; c=relaxed/simple;
	bh=8b6L288ce9kPStFFdbHMgKjuWtDMisNJ9Rs9Z0uAFe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYbMXDacT60yPkaxu0LsCgPqiScGP4nwLOL40EL9uridUo4zYP5t2YTtd3y04p2oTPAbgSfRpWGCftYX/xdkc2v8QTQ8gBs2BajuJZEzSb3AWkrPKmlVCpD+0R4ZIQivAeb/ST9yK2MJtj8n6IRk45PGxTZ1rrdxnczxtvj7KrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Q3JufR5l; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a72220edso4971728b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744062042; x=1744666842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+yX3lf5yupaNyVH8f1QfKtugS8p08jP2Veqy8Hq8R8=;
        b=Q3JufR5lPnun5LEGkCGbxSNBrehuRaskV7bgSu4eui9b5AyS/66SJjNPihLToSHjmQ
         tS9Hu/EOsRkhIAt65rQI+bE3RjoJ8cdfTSE9xmDskA3TlJ1sGeWsRfMFYjogYvdhfC8c
         PNCobYIDGkTvmwIQsEf6QciBC3eSwBA5CiNl6hVtGVE+3raPdvhipnHa/mBuVcQ8mqEN
         BWqYBO+MYWQ6wUkHoMhLibtzSrIGbxi7L51QyBBeN/INYUhpeOaBs5IfYcJznt4YbANB
         6QjBmbPwfmtvAeskgAjRrosZ3m9Ghn94NrKEW4FZ/8IlKYouFtKXmnyKyGghuFXQC90w
         jNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744062042; x=1744666842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+yX3lf5yupaNyVH8f1QfKtugS8p08jP2Veqy8Hq8R8=;
        b=q3LEHnHIPE3wY9vb6Md/L8c9H8Hm+P3z+Mo+lWy5eRjRyW4EZVx2q9tujPAKZFv/S8
         qINap18LZK+APr7cAG4q4Zt4ffr6AWPyimCYmMI0V/EYzJO7ibvSR/faN4xr0kKPI2Vl
         M/1htTnCEn8LZhNg1kL3sivavhi6cIGOrzsVYoB7iWSCfMVG1M3Mc5VUfIYNDAJzvQGU
         1aNYX5mQWMNWDU14v3BE5pO4zX2oQLiSfrcAlIvXXbIL0e9cmEkY2cYPnqAaOUcXV/CA
         Gb1iKVcgaAN97lkDP4M3Y+6OwQIUFiEGumSVv898/fFxTXkiH3WxMjjoQ2lq211C20V3
         KzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiW1ym6rbnnLuCH6iC4p4hgR2oi0NOgJMUCtxtqdlWcLgRK2Ho5wvysbNH/IddjYS8hnOyshc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvjbNz+2OfUWs7a/gV93kBbDXCCD13AY6e+YRaPK2ttqHMKes
	gizHA/EhQU2AZ+CpK8u3ngk22KcgbTIMYEhraWG+FMVJbaKSN9i0APrAwV+qQOkaKRmrl/VOKV7
	K6fdoB7cuhplhoRHCGACjUAK7681tyQJgC+bt
X-Gm-Gg: ASbGncuxEahqZCB+bKlRCGvfPo2/8CQLvChJtQNWS0+Sa+FFJJVUH2sZ5CQSqEBCMQ9
	J1KWxfixxA7I47ae26h9yC7NQCegoi1Yz+mHfnxNiBZMZznSdLnQO62CiEBHPHK9nHjsYzpOR7+
	mw6OvNINH4E1OnoeiXplkjjjK8xw==
X-Google-Smtp-Source: AGHT+IGAaMURnkaq310fyg0Wb9dvAqbuphD+TarzzsWQ+JFJsiGeiTAHEnwcvgyS0Z7Fu8eLX6onNS0Rs3wGFJ9c4f8=
X-Received: by 2002:a05:6a00:1308:b0:736:bfc4:ef2c with SMTP id
 d2e1a72fcca58-73b69a3ef7emr11643239b3a.0.1744062041994; Mon, 07 Apr 2025
 14:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407112923.20029-1-toke@redhat.com> <CAM0EoM=oC0kPOEcNdng8cmHHGA_kTL+y0mAcwTDXuLfiJhsjyg@mail.gmail.com>
 <CAM0EoM=EL-KVC-LKC8tyY1BRSYtjEgKPPmcwzAvj+z+fw04gpQ@mail.gmail.com> <CAM0EoM=a=MuV5BOrPbFmkJa_5aYeDwk49mRXtVncwLwA_a8uwQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=a=MuV5BOrPbFmkJa_5aYeDwk49mRXtVncwLwA_a8uwQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 7 Apr 2025 17:40:31 -0400
X-Gm-Features: ATxdqUEN-4A_28q5EldGWbhec9X1ZIHi5DvrdQ_KtOqg4g_vwxEcHrFtr2lsI0U
Message-ID: <CAM0EoMmswUHjcewAESuz0jsB+qXJ+QPB6kVzjS8bzqm4niFF-Q@mail.gmail.com>
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ilya Maximets <i.maximets@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:10=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Mon, Apr 7, 2025 at 4:08=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Mon, Apr 7, 2025 at 3:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > > On Mon, Apr 7, 2025 at 7:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
> > > >
> > > > While developing the fix for the buffer sizing issue in [0], I noti=
ced
> > > > that the kernel will happily accept a long list of actions for a fi=
lter,
> > > > and then just silently truncate that list down to a maximum of 32
> > > > actions.
> > > >
> > > > That seems less than ideal, so this patch changes the action parsin=
g to
> > > > return an error message and refuse to create the filter in this cas=
e.
> > > > This results in an error like:
> > > >
> > > >  # ip link add type veth
> > > >  # tc qdisc replace dev veth0 root handle 1: fq_codel
> > > >  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for =
i in $(seq 33); do echo action pedit munge ip dport set 22; done)
> > > > Error: Only 32 actions supported per filter.
> > > > We have an error talking to the kernel
> > > >
> > > > Instead of just creating a filter with 32 actions and dropping the =
last
> > > > one.
> > > >
> > > > Sending as an RFC as this is obviously a change in UAPI. But seeing=
 as
> > > > creating more than 32 filters has never actually *worked*, it could=
 be
> > > > argued that the change is not likely to break any existing workflow=
s.
> > > > But, well, OTOH: https://xkcd.com/1172/
> > > >
> > > > So what do people think? Worth the risk for saner behaviour?
> > > >
> > >
> > > I dont know anyone using that many actions per filter, but given it's
> > > a uapi i am more inclined to keep it.
> > > How about just removing the "return -EINVAL" then it becomes a
> > > warning? It would need a 2-3 line change to iproute2 to recognize the
> > > extack with positive ACK from the kernel.
> > >
> >
> > Removing the return -EINVAL:
> >
> > $tc actions add `for i in $(seq 33); do echo action gact ok; done`
> > Warning: Only 32 actions supported per filter.
> >
> > We do have a tdc testcase which adds 32 actions and verifies, we can
> > add another one which will be something like above....
> >
>
> And using your example:
>
> $TC -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in
> $(seq 33); do echo action gact ok; done)
> Warning: Only 32 actions supported.
> Not a filter(cmd 2)

Sorry the "Not a filter(cmd 2)" should not be showing up.
The "Only 32 actions supported" you see was a quick hack to your
extack "Only 32 actions supported per filter"  because the issue
occurs whether you have a filter with > 32 actions or instantiating a
batch of > 32 actions.

cheers,
jamal

