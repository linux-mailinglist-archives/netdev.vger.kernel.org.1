Return-Path: <netdev+bounces-171758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911DA4E805
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34431424A44
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365952857D2;
	Tue,  4 Mar 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VCBLsB9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4432054F3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106612; cv=none; b=fAbstyNxTIcquHvlx9Hnqz00Lf2xwyE5KA8Ovfgy8rWEXKEAoxw8dp+L2Ya6sAIRa1y3DpJi/54ztG2T0JwEo+wXicTD6NpAqONsESz6K+aIJEWfDPWfSrBnSJxjwiaENsou2kMs2RWQtQB7HpFbr2hta+udenF4O2v4M+Cpmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106612; c=relaxed/simple;
	bh=n9zLfHC+0kz8wFG1LCf3tUN+hFtXc6AOAykHjA4PpQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiFZEyJyqz91EkdwSq/hwC98fHKoYeorW7xVULyybWYSCa3VFS3NKCTOwpyrnF8uJ48/vYwERpKAdCsiZU8V15u3StDsLF6QwpRKo2o8S2FR5cktX8NBNOlx7LViqJEFJfj8QRTPEkjRLEYF7ptDzId0tl+zZDnT3R2B6iJk6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VCBLsB9s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223a7065ff8so67141765ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 08:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1741106609; x=1741711409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGI6UtEs+1U4fZxhmHd5sQSqIrbXPIW03BdcHxZf1PE=;
        b=VCBLsB9s2n4eCubAgKAGE0SlIFHoUIe54v3Y14o8xM+l74wQNp/Vfr6Y2NtIN6JZYn
         rwoWlf8Bykc7hh3H8oI5/kx02wyUBKCYPQBtzUZYme6QFhWzOYK4UhKXJrZqQvFgUCOg
         TFDRwo+ESPUThJF8gSPfc+U+/7Qqd9bf9pxiuSCWCgiy44q8NU3GEVZp7pQs3jz5jUy4
         17NZziSpeGJ2h3EgLqGWqhnwA0z9epkBpZwlHZ09gk/nFTxmeOVxl4f6EAWaP1a4u7Vl
         udLZggREZ/M6rzLG6ix/DeuZtA0W79jjf+uWhPcvpQ/zANVHU1LgnipkI2qaaCUw15wj
         DpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106609; x=1741711409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGI6UtEs+1U4fZxhmHd5sQSqIrbXPIW03BdcHxZf1PE=;
        b=fdDvm88dmyg+T9KxZcyIJfsL+x84PlC+Y5TVaee/C7SfWY2+lYxsFb770TNHCj6loj
         RMgzBOmEKs5q2r0cxmcWfGt6mP3KI0U1Zkvy3RmCF1opblKTy6G25PHpFX9PV7WMGLao
         hAHc0XR1d+mAcNIP82knkp+CQGnoBgJDN3kpq02I97QsdXwJbcChSn/9HKBLzhlbND1O
         vRsOx2eP/GkSrY+Kd8XG8Z1Yxx5hlGBGrCM79db0DXn1b25MzOuPvhCXBJlvkdFdlvIh
         bEV3qbglr/Xae7+44qHXM+2pMeZLlbYcF7jKKTwNX4/uGYN6MEf8qm83nQ9hml41E/wJ
         F+rw==
X-Forwarded-Encrypted: i=1; AJvYcCW9xgKncpt5SWjqKGkA3SqbIDrm/GLZZx4Woef33J/EUjbIA5DDljtR+w9UC191WLYtTlf0apA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4h/QYDvQkZJZuTJEgttGyW6TRWkttMDLpvWAA0t+o8N6n8WJE
	MFJONWau70yhOYpwOmBqGqZklqRWA+GqReNWKZwKUc13WgTruPhrzxuaIYGLZKlakhw+NNhdRKE
	TFN05Kdju+RF5+KF9AcHn1fGSvGeOc7oc4HMp
X-Gm-Gg: ASbGncvAKihFQNz8upzNjncRrmT51xIe6Q01lq2UosJVFuaEU+7ETEUHFjKjqEnZNGP
	wRFHkcMw4ZTQ8xZ5USQr0jHpDU3sppRZTNu2dWhDN8309g7h23tXK5BB3Nr7UulgDevu6ueHbPJ
	1wOD04f/aOaGmxz1J13DLgfNIwrw==
X-Google-Smtp-Source: AGHT+IG9P0P0HTm1+q38r1UAT+31Psg+HRluQoFAsO6R9gRR74E+ypnrcCt5xQm0pwwBvg3S8jEsS308E7Uzf8FB8fE=
X-Received: by 2002:a05:6a00:1407:b0:736:546c:eb69 with SMTP id
 d2e1a72fcca58-736546cf7efmr12509477b3a.9.1741106609490; Tue, 04 Mar 2025
 08:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302000901.2729164-1-sdf@fomichev.me> <20250302000901.2729164-4-sdf@fomichev.me>
 <CAM0EoM=jOWv+xmDx_+=_Cq2t5S731b3uny=DWrVX4nba3yjv7w@mail.gmail.com> <Z8XL3T8sOM43BnEc@mini-arch>
In-Reply-To: <Z8XL3T8sOM43BnEc@mini-arch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 4 Mar 2025 11:43:17 -0500
X-Gm-Features: AQ5f1JreAJJlQT_e3raxpUcTKubbW8MLMskzi-bstYVphSfzTByosA0Qa6eLZKI
Message-ID: <CAM0EoMkw=3SvEDyzyjM3zY60nGTDMdfXYp0Hz43YfVThfmqyTw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/14] net: sched: wrap doit/dumpit methods
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:33=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/02, Jamal Hadi Salim wrote:
> > On Sat, Mar 1, 2025 at 7:09=E2=80=AFPM Stanislav Fomichev <sdf@fomichev=
.me> wrote:
> > >
> > > In preparation for grabbing netdev instance lock around qdisc
> > > operations, introduce tc_xxx wrappers that lookup netdev
> > > and call respective __tc_xxx helper to do the actual work.
> > > No functional changes.
> > >
> > > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > > Cc: Jiri Pirko <jiri@resnulli.us>
> > > Cc: Saeed Mahameed <saeed@kernel.org>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  net/sched/sch_api.c | 190 ++++++++++++++++++++++++++++--------------=
--
> > >  1 file changed, 122 insertions(+), 68 deletions(-)
> > >
> > > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > > index e3e91cf867eb..e0be3af4daa9 100644
> > > --- a/net/sched/sch_api.c
> > > +++ b/net/sched/sch_api.c
> > > @@ -1505,27 +1505,18 @@ const struct nla_policy rtm_tca_policy[TCA_MA=
X + 1] =3D {
> > >   * Delete/get qdisc.
> > >   */
> > >
> > [..]
> > > +static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
> > > +                          struct netlink_ext_ack *extack)
> > > +{
> > > +       struct net *net =3D sock_net(skb->sk);
> > > +       struct tcmsg *tcm =3D nlmsg_data(n);
> > > +       struct nlattr *tca[TCA_MAX + 1];
> > > +       struct net_device *dev;
> > > +       bool replay;
> > > +       int err;
> > > +
> > > +replay:
> >
> > For 1-1 mapping to original code, the line:
> > struct tcmsg *tcm =3D nlmsg_data(n);
> >
> > Should move below the replay goto..
>
> Since nlmsg_data is just doing pointer arithmetics and the (pointer) argu=
ment
> doesn't change I was assuming it's ok to reshuffle to make
> tc_get_qdisc and tc_modify_qdisc look more consistent. LMK if you
> disagree, happy to move them back.
>

TBH, I never understood why we had to reinit for the netlink messaging
per that comment: /* Reinit, just in case something touches this. */
I dont think anything will change that netlink message, but who knows
there could be some niche case.
IOW, if you are going to respin for another reason then do it for
equivalence sake.
Worst case, we may be able finally find out why the code is that way
when someone reports a strange bug ;->

cheers,
jamal

>
> > Other than that:
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Thank you for the review!

