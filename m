Return-Path: <netdev+bounces-173418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675FAA58BBA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82528168310
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E971B4153;
	Mon, 10 Mar 2025 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igW6/dsp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366649641
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741585550; cv=none; b=G71hGEIvGE73jhfLuRD7oinx/zupULh9Qc5fg8kpSx7eaUGbSf0IQa2UhVaB8cemREjezD653a9WZHno5YehOn3ODagC65GQJTm48ZszwghK4SI2VxVfGNpauUSHO6+ROZu9Dpi+kSIHZ5rmxMaQZE4wWuVFqLZoluO4uo8nq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741585550; c=relaxed/simple;
	bh=DY82KMX4hDS22dhJw5YHjL/IBpcRs4OLmCAM8hynbgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCoKrDjC1Fmqa3lLskCUKOW0yPt4hLtkY0Hqr+uChZUCmaNgKz83a24CQb25VplBEfdCyrNB8bnxRDYA77HtMPh5AJ4WQDwSAcYs8Iv2Wr8ylusMVP9u8gYE4n1RIe8nKA8Dk8xkUFv/q+sof/LurWJbzNM2nHrG/5l/bUc2IkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igW6/dsp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso174875ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 22:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741585548; x=1742190348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdk8JIsy8Nv4wZkNtHkaIEhtB3SE9Fe1TcjLHkiBi6U=;
        b=igW6/dspWz1lS2s9sdBO5CCJpZtFZxK6GFFFZbwz10Atm6B4Sml3P4umOcIkxumZGg
         sxlKoei8c9nfyRy+A3cIleGglNu1Mci3Aa3epzGX32FYJtY06YOi0Brpw4weoovzSE30
         haKfxSamA8bfeoxukOAfcC4Jc+f3cllnYEbPWU8bhHdvkxJG9tKy9z6gBJvGwh0F91fm
         6MswM6H3PTHYXrqLRK+TwWEJcFFR9IypMEPSMo9svPIDjhrp1FXbrm+idRrn6N+z0xNf
         Ts4p/Juzq0g3pI22/fbyCCr+DyDg0jnW35u2wnOWNJwE6eGm8S4koiiEH43+M35wiZwi
         Q1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741585548; x=1742190348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vdk8JIsy8Nv4wZkNtHkaIEhtB3SE9Fe1TcjLHkiBi6U=;
        b=F7XXaHzzIwx/kQMK1nM6FNGZuQYUurv5qBbBGOk4jj+xScGTosLw4uNPStSAxiZFC8
         ZcCI7WNzTAg3CqEKULlJV6jjaoOaeai0nyDdOaHFOc+KCGMf9zWmjswZx8vT1oIdjAWU
         a36qiHjLc1kl89bcXpfGwXRmmYm2SzP7VUK+QZGdAgDMxVvkybdq8kVif1iZoQZhKYhn
         IE4WAE4hX6dW8G+nRSe4C9HvZ1oSRvboV5cBks2+e/SRmqbj124s0s71ot29CODE/iqP
         mbdj0MwKfATUblJAKl5OzfSKCLNfLfjUFyET4BqwIMB9FTazCjawJnTs0jfZfNaTQpy+
         rdOw==
X-Forwarded-Encrypted: i=1; AJvYcCUzHaLm78BgIzt0Ms9EEkaIXUW4Iuht5868LgGM9Ak8SXkvJdbiwKD86QKxP+Uv2rAc2Qe8Zi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vuiQqawzI4OjyYb1H/my/UKg27S0ZgbnCOEU5dus99gglDFb
	YiwJb11k7JUUf1zEDzxkrycGrHdcJOJbA4CIOpqZ9x4Fp7Ecuh1OOHbmHCpcphTIdOrgrRoX9CL
	eYU4b2UVAADpmuNGzGlzNV6Fu3tp3h3UyNPfj
X-Gm-Gg: ASbGncvuaBIIUiH9Hq+XDtB6+pFuEJm5uMcS0zBv5Rjg2TvPwFR7/nvQ7JLjwnkJnR6
	HMSqeiX8amunO1cAPdeLXYlwbnTsrwqLH78Utb5/MI6YV9FoHZKKeYlGBotmLWwCtwyPsyRItVt
	DRqJwb9TkmjXdDAU5F+Wjgz3sYcVc=
X-Google-Smtp-Source: AGHT+IGxu7wIRTInzBiyf9nxCQSO1GLEfkcPemXrYOYE6jknsHBotxVlbcjDpO1VXJQy29bcwiKlXOFGjf2vqpUHvdI=
X-Received: by 2002:a17:903:19eb:b0:223:5182:6246 with SMTP id
 d9443c01a7336-22547816b5bmr2494655ad.23.1741585548265; Sun, 09 Mar 2025
 22:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307155725.219009-1-sdf@fomichev.me> <20250307155725.219009-4-sdf@fomichev.me>
 <20250307153456.7c698a1a@kernel.org> <Z8uEiRW91GdYI7sL@mini-arch>
 <CAHS8izPO2wSReuRz=k1PuXy8RAJuo5pujVMGceQVG7AvwMSVdw@mail.gmail.com> <Z85ycDdGXZvJ-CN-@mini-arch>
In-Reply-To: <Z85ycDdGXZvJ-CN-@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 22:45:35 -0700
X-Gm-Features: AQ5f1Jqk8kOtO3C5Pchm701Kts4Qy4PEDF_B0T63TmnCJ-VfgK7h_5EZzHN_Zng
Message-ID: <CAHS8izN0e5eXXYD+aPc7hJPa5yAfCQKfwvrMpk=gZ7QuH5CqtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, 
	dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 10:02=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/09, Mina Almasry wrote:
> > On Fri, Mar 7, 2025 at 3:43=E2=80=AFPM Stanislav Fomichev <stfomichev@g=
mail.com> wrote:
> > >
> > > On 03/07, Jakub Kicinski wrote:
> > > > On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > > > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > > > index a219be90c739..8acdeeae24e7 100644
> > > > > --- a/net/core/netdev-genl.c
> > > > > +++ b/net/core/netdev-genl.c
> > > > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *sk=
b, struct genl_info *info)
> > > > >             goto err_genlmsg_free;
> > > > >     }
> > > > >
> > > > > +   mutex_lock(&priv->lock);
> > > > >     rtnl_lock();
> > > > >
> > > > >     netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> > > > > @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *sk=
b, struct genl_info *info)
> > > > >     net_devmem_unbind_dmabuf(binding);
> > > > >  err_unlock:
> > > > >     rtnl_unlock();
> > > > > +   mutex_unlock(&priv->lock);
> > > > >  err_genlmsg_free:
> > > > >     nlmsg_free(rsp);
> > > > >     return err;
> > > >
> > > > I think you're missing an unlock before successful return here no?
> > >
> > > Yes, thanks! :-( I have tested some of this code with Mina's latest T=
X + my
> > > loopback mode, but it doesn't have any RX tests.. Will try to hack
> > > something together to run RX bind before I repost.
> >
> > Is the existing RX test not working for you?
> >
> > Also running `./ncdevmem` manually on a driver you have that supports
> > devmem will test the binding patch.
>
> It's a bit of a pita to run everything right now since drivers are
> not in the tree :-(
>
> > I wonder if we can change list_head to xarray, which manages its own
> > locking, instead of list_head plus manual locking. Just an idea, I
> > don't have a strong preference here. It may be annoying that xarray do
> > lookups by an index, so we have to store the index somewhere. But if
> > all we do here is add to the xarray and later loop over it to unbind
> > elements, we don't need to store the indexes anywhere.
>
> Yeah, having to keep the index around might be a bit awkward. And
> since this is not a particularly performance sensitive place, let's
> keep it as is for now?

No strong preference from my end.
--=20
Thanks,
Mina

