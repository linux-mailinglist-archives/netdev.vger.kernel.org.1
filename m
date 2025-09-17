Return-Path: <netdev+bounces-224146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D19FB8137F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265F6626F5F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA202FE05B;
	Wed, 17 Sep 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4y303Bc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979D229B18
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131015; cv=none; b=bxKeymybHEL1t14ohHxd96VK8jsftkUDTwuW/rC7lYdEk7J6TEpkfest5l5g0v484vvbRb4LWwdHIiYiQzaV+Q6Lw3DQfB49UhkaOZUf8YvjHDwCIiMc8CoDFLrXtGCDRiNispw4R85d4ATg/ODO1BBnPS/5VGn2KLDKiXhH0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131015; c=relaxed/simple;
	bh=cl/QBklktfInLptufkRFqpIhQE+bUOHby0dmoiW+QNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsLikZ/BwjJX7UCTAdvfQX/9W3xltDdTEC5UbAsctayHxO+IJN6huhjIZ8xfLyKWnq+HcyJx5zrvwmLnXHEZynqa6j0trx4FI1rj6uXipjfcPcDVsGBK4w7+uIS8rsaARWKVM1yFTQfOKct2EBQ/7xnKYMDMxZ7BmOJhaoR8HJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4y303Bc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5488c409d1so47343a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758131013; x=1758735813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo97Fly3OOsDHs8De0mPKOIklIZmDk0IMBGJgZmyy/8=;
        b=O4y303Bc0CD7s3JgbUvA1IYtCMKkmSmo7eesMHl5w2MUE7k/0roMndEhYjg+IDHVZR
         c7OJIHIPBc9Xi7WTZiQf9KffcvYZm7ja5zLcm8L58kJudD8MYznIu2l8k1bcXb/jz94q
         U9ciSfQJ2HDjc8pN7/OrqFNVXTL578B/nQ40HwOL4Xbl1LRpBpd5tZwsFT2/x6gkpMxw
         SHVgxqq1HMV+oPuXE5x4Cii8kgb02pXN+DFl/MinrcxrwNMMF62rWBGrhaCdqutU5yrl
         qCnXzSUIz6AkSFsOc7IDfTjmUmdXIJC+GHvaVfCzJOFobKkJCL5tQ/XPR+v0laXP0WVi
         e6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131013; x=1758735813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo97Fly3OOsDHs8De0mPKOIklIZmDk0IMBGJgZmyy/8=;
        b=XlcqXnYBOVsi9urQQ0sF1AYwsiAcuHktp5GGG/8jkEDGH/hCm4B1TwtTHz69NtSK32
         3Kt0xWebMpdo3pNDyPbjumBJlYo62wkxquJ7nrNY8Euzq6CIStpenUxdhwSvlvwrOwmg
         Jh59FdHFbj4YztKbRA9+tIFYOONLVn39T8By5vl45bQ602w1XwSsrkfZ5ewYKYFwpkBV
         vBj++4602r412BCxKBRviKctLYwhgtHl5zrL49zSkIXlkABRf1FFiIuhyBT3NbJNpZGu
         /rgaX2fhw+Far+tltPlEAJ/XfPgr/u8Ot1DOSVgHgPQFVKSzbwwtrAPitSpsi4ywN/3+
         2/GA==
X-Forwarded-Encrypted: i=1; AJvYcCXLaKUYsDhvbNeZHK0X+XjUoDb/6LUaY6RiPMUA9txJHAy5RoNOwTamstY2UWZNf6sYz4H1mjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qVCNtTsbcpuZTfroZlT7BUQMihVZw9PtT5nodhRT5ix6Br3+
	BAOWbeIiHGJztwod664t8n7K92q/ARs/tQf4Z+SOXoRDcLlhdqwF0ae/vagCmhbwAGe0kWAQ5g5
	nyR4s1NVcD2ugMBhEZ0IzE13vOiFvOCLnTrSxB1RD
X-Gm-Gg: ASbGnctwpnLvFRnxIpl3l23OEIYdKJCn92EVxwj6v1skuFQr11ouYUshauc9Y6zLYwj
	NZwoMBZhE2wcevgHKYTfdhoee+2JQUHn7etkJB2sP8/gpAUcPj+soMYXImCryO6wTPZtKI5IoiM
	pDsx1KWna0VyyhOEuu0CIYVb64tvcELx1HUJi64N0yaf/3K0cvfsPIAvPgh3N1yoforI++BzM1a
	LZ3OnDrLSWJuvq3aMUOOpOafVKVL32HHTkCZECNX8/YWxcU743SRtI=
X-Google-Smtp-Source: AGHT+IHRsNYTF8HFp02zV71mkFgDpJDb1RppmdmCpRXDipPQJRP2KRFw9F+po60L0KieDIvyZLOppfoQ4hJEG/V6GRU=
X-Received: by 2002:a17:90b:4cc7:b0:32d:d4fa:4c3 with SMTP id
 98e67ed59e1d1-32ee3f26156mr3717088a91.31.1758131012761; Wed, 17 Sep 2025
 10:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-8-kuniyu@google.com>
 <4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org>
In-Reply-To: <4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 10:43:21 -0700
X-Gm-Features: AS18NWBmYjxoJo3zWhukNZG1Bg8jiKna2xlrpyh2ezZh84z07q26ZAEQ7_PaSKI
Message-ID: <CAAVpQUCHUd+M-Kvbvpkd5qYcmD_UfCyC_2FeF9m6HkxTC6+2Xw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/7] mptcp: Use __sk_dst_get() and
 dst_dev_rcu() in mptcp_active_enable().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:17=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> On 16/09/2025 23:47, Kuniyuki Iwashima wrote:
> > mptcp_active_enable() is called from subflow_finish_connect(),
> > which is icsk->icsk_af_ops->sk_rx_dst_set() and it's not always
> > under RCU.
> >
> > Using sk_dst_get(sk)->dev could trigger UAF.
> >
> > Let's use __sk_dst_get() and dst_dev_rcu().
> >
> > Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole"=
)
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thank you for the fix! It looks good to me!
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> > ---
> > Cc: Matthieu Baerts <matttbe@kernel.org>
> > Cc: Mat Martineau <martineau@kernel.org>
> > Cc: Geliang Tang <geliang@kernel.org>
> > ---
> >  net/mptcp/ctrl.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index c0e516872b4b..e8ffa62ec183 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
> > @@ -501,12 +501,15 @@ void mptcp_active_enable(struct sock *sk)
> >       struct mptcp_pernet *pernet =3D mptcp_get_pernet(sock_net(sk));
> >
> >       if (atomic_read(&pernet->active_disable_times)) {
> > -             struct dst_entry *dst =3D sk_dst_get(sk);
> > +             struct net_device *dev;
> > +             struct dst_entry *dst;
> >
> > -             if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
>
> Mmh, I don't know why but the condition was already wrong before your
> patch. It should be the opposite: we should reset if we manage to open
> an MPTCP connection on a non-loopback interface...
>
> I don't want to block this series for this non-directly related issue.
> If you prefer, I can send a fix when this series will be applied. I
> guess it would be easier to send it to net-next to avoid conflicts,
> which should be fine if we are close to the merge windows.

Sounds good to me.

Thanks for the review!

