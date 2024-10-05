Return-Path: <netdev+bounces-132427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13250991B29
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 00:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BE1C21498
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90E7158861;
	Sat,  5 Oct 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4urILfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D52B9A6
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165906; cv=none; b=YKMB0N08Pfe0vDQqhZHPeD6/se62kZ6GTPWXSvrFARzmQTHE6jKlu/ZFwRqr2BxGLJRRnzGnNuGd9wRKRlKjzpBA2PS+1Wil9ArvgVFceJvmHnvEIOLJojrEMEfTbkeAc4fgTk2mlrBkFjI3ZzM+POR9hKDVxGHJ5RsXp5mSoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165906; c=relaxed/simple;
	bh=uluPxiT8ajTcK7AvwbozLFhg10X43nIleEVyovq14y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZskpVmBhnPo6lU/HZPl9DWtxNjyybmAVeqXpJ+w/LOBVwWfQsbxu520TpMi6y7iGbblcx9Ro3zAQQ/Cs/GDu910ZF7pnuO4p8ljDw6dZw1swgRIU4Dg3Qes3weayp+FIHhPBwmRuhO5FgOlBaQvHZJFiJTXC3ZnFtw0G0UwEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4urILfD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a377534e00so6233125ab.3
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728165904; x=1728770704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNN9CRgD/KjOQR8JjEHMP5AsiBIotNmYxefMRjK0/mk=;
        b=I4urILfDE1gQLofw1eZtyRt2lZI4ZttNrU6Sqcuvt+TO+4WJ2Rgx5h0eLJJGupGFGA
         YD5FABrpZ+txtPbaaZEg/WNqJyEa+iUFHMDUTofwoNEg/bnYl0cAHyMyio5FMw96wSgv
         HYYJjHixqnL5ZydwwkTObNCWS1cTz4vQyH1xpvL/PMtLkddLbbVGD46cnZ+43w9JOZ12
         gthv2ryn7Pk4Yz+4k4F1aP29NhnnWVWByKg0qGdHZNeZto5PZ4ZVs0xVzowUL5dBMBgO
         34fnV//wd0hTNh7/fUQLoKJyeSh1S3X/KWrNTOmroi02jbhnn6Xt9qo4GBiJkfOMrzaR
         hX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165904; x=1728770704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNN9CRgD/KjOQR8JjEHMP5AsiBIotNmYxefMRjK0/mk=;
        b=A86A6cLHDMh1LUSD4itNSt2Q6qLJ/9H7KwknIXmB+aq2rbtWYwXXkh+vbOf3JYuOZu
         lTlqljleNesoUxozBfSczPiidmvsn6txZE10cTO4xbxZyGd1Tg1cKh/ob0MxoTb47krx
         HlPj/948qkNwxlAUJ+Z2nnoIsQGNwLm/PT4Mz8tuEWkcBGDM1diwlHemnmXnnCzDyPMe
         ReafrPPMfDI82NiHaWBb3UaaKrKAof7N71FKvQdL/1Nd2HSFEKELLokFCY0e3nzpfGmg
         ZmMbLsWxAkFAOA4VCmY/qcHdlxH4pPnhM9Op85kLhdkF4VZxJ6jndRg9ruNbrQxkzOYF
         2PIw==
X-Forwarded-Encrypted: i=1; AJvYcCWliuy9y/lr+YoxphHy8bsz0gcu4nRaw/sZvZo+t64NiO53vMlaQSaztIog73vfdMerjrN01gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfLFMprCkkXE3PZ6zyQ53LvlXG0qIrMyx52U8IEbm5QkjBFk+
	Hnt90etBVnaAq0lRMwwC3FjehCohmdCy1BmthyGN0XOPLMED3JkOT5Ax6bCHznqSQdsto/ldDnF
	A/qN1XjYaFERMSy+rFeZ31ywYPks=
X-Google-Smtp-Source: AGHT+IGpe33rzdmHE/dlJYNR7X1FSc5cAukdiYGkPeEDv09RN/gz9QXDolPfL9NJjEFCiznw2wYH/PV1QIvjTvvv46g=
X-Received: by 2002:a05:6e02:16c6:b0:3a0:9f1a:7908 with SMTP id
 e9e14a558f8ab-3a375a9bd55mr68969115ab.11.1728165904189; Sat, 05 Oct 2024
 15:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003104035.22374-1-kerneljasonxing@gmail.com> <20241003221007.12918-1-kuniyu@amazon.com>
In-Reply-To: <20241003221007.12918-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 6 Oct 2024 07:04:25 +0900
Message-ID: <CAL+tcoBxZB-OmOyA4NDOnRgj8S7x3nnssdYdLdU+5fGU8EY6iA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net-timestamp: namespacify the sysctl_tstamp_allow_data
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kernelxing@tencent.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	willemb@google.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:10=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu,  3 Oct 2024 19:40:35 +0900
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 86a2476678c4..83622799eb80 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -491,15 +491,6 @@ static struct ctl_table net_core_table[] =3D {
> >               .mode           =3D 0644,
> >               .proc_handler   =3D proc_dointvec,
> >       },
> > -     {
> > -             .procname       =3D "tstamp_allow_data",
> > -             .data           =3D &sysctl_tstamp_allow_data,
> > -             .maxlen         =3D sizeof(int),
> > -             .mode           =3D 0644,
> > -             .proc_handler   =3D proc_dointvec_minmax,
> > -             .extra1         =3D SYSCTL_ZERO,
> > -             .extra2         =3D SYSCTL_ONE
> > -     },
> >  #ifdef CONFIG_RPS
> >       {
> >               .procname       =3D "rps_sock_flow_entries",
> > @@ -665,6 +656,15 @@ static struct ctl_table netns_core_table[] =3D {
> >               .extra2         =3D SYSCTL_ONE,
> >               .proc_handler   =3D proc_dou8vec_minmax,
> >       },
> > +     {
> > +             .procname       =3D "tstamp_allow_data",
> > +             .data           =3D &init_net.core.sysctl_tstamp_allow_da=
ta,
> > +             .maxlen         =3D sizeof(int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_ONE
>
> It's already limited to [0, 1], so you can use u8 and save 3 bytes.
>
>   grep -rnI proc_dou8vec_minmax.

Thanks for your advice. I will update it soon.

Thanks,
Jason

