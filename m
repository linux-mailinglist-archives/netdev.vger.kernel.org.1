Return-Path: <netdev+bounces-132236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E6B991108
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02900B223E0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A294313D24E;
	Fri,  4 Oct 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMQGLlOd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBB7406D
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075590; cv=none; b=rfWzk0NJyNqPwGOFnz7KqHibvz5U0BsEduHuW0WSMV4Tns1ndF66NIXSi/HZliclPqYC1FePDNJvVqr+oBTiS/Z38gxuYmxIAah/K43GnhiCds/INsqcUD/SoQsHF+AKs/auB1DOTLBurM56W1GDjLrIq/DtB6zxRcofRUp6kgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075590; c=relaxed/simple;
	bh=IZhtZxJdOWP4HiYZJz5p7s9fmsXTJJQi866mvSkB8XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3yJNsnxHypP2tEHuD7E7L6Yggy7iDbn4WYuTLfGQ1XCRpTpTJeRtdHuqBd+EAXnnsrUT1xNqAkMm6gRURKBcML1tjwUMGtd+qGdmzwiGACJCHMt4+888KQOboqartqToPVjtbswl2z5la8jbrBmc6vp46wdjesp7YCa/jgh3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMQGLlOd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89f3f28b6so3268199a12.2
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728075587; x=1728680387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laDyc/UyIgP6Cm2eF++SX1HNwKn9l9RUdumAX0fAOkM=;
        b=UMQGLlOdjylzWCxnRVAnmiejd48MWNgKKhmGOLQinp40liMQj2jMWSIWE0VElxGQnI
         2vjJz2iT1dtbdaiCmV2Xrtmy1mtAYZqMoBh/PKWuk+qHh0t9/99wWdrcWtgjRdEOQaOs
         nNnZy4u0korjw60oEWOU6K/1dphpK4oNmgZIn7I0Z/W5GtyMS5LAw27zZWS4xg7N3h2G
         H2VUZe8JTy6XGS2pg8E4Z6tlHOJWqLHZ8gEeo0yptu/61L+6Vke8KoO85AhTjv+5qpMQ
         L0EskHoeYyCCeBB35KeLuYP/alUMuxauZcuim7pvJDD7NbpOXOD1YArkZhhtHQdbPynW
         pugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075587; x=1728680387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laDyc/UyIgP6Cm2eF++SX1HNwKn9l9RUdumAX0fAOkM=;
        b=a9Im2DyKCnr2MKGlWOm2G1+MO2rcNiOSBL5IbBnZ2iErcqlKe2/vwS4ultBo/6OKiy
         JFGoyZFjrMSRXvAeZvKoV3Ncdlrnbr7GjGeDqSMhHmfxy8GOrjALD9CqEWJyTJH9csz0
         xQdRIvh2vQm/Ek79m+jZX144qq/55ud09LFIjSBH5BVtyekGmh8IP7QFs/Kwo2AvsivI
         4DfV5tTmpzvHrlGcsL3l7B4j+5JB56GLQOlEIDVvl0uO3ox+E8zB7vhC0fdP7dOPPZhg
         Guv5PpKiq0iD+mrucQVi8Z9GyCGcR9R9R6KW6XOncTTq8+7UR+t+4hjPzSnDDRaNUsj5
         1+sA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiRSf3DSmRK57PjYh9Zh+YxqP/Ro1Nl/OsDQxf/YBF4qRGfRKWQ3cDTdb3FS1bFdwmBBiaA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCi8x7bPPuXr42d5bdHoM46V8SzJA48v2z+sCZdTBf58ljxZ8p
	TJcfxWcCVfHjyjDPE2Lju3jAkpFKubedOpbvAxGpPVHJTqjSBwBG4ZtUPsfwjcDy9BEtZSrGrkn
	cRMZHQBpBoLvtSL5xW9x2f0cFBMjdSAcUNb1G
X-Google-Smtp-Source: AGHT+IHn2oJhwjvYfgqp+vnEi/H5E1bufLzB2+UNyn2bEYD/cVZqjOiHgFZeckrdsCZfNFF6qELxfj7blDALDGZjECU=
X-Received: by 2002:a05:6402:3483:b0:5c8:839c:8179 with SMTP id
 4fb4d7f45d1cf-5c8d2cff6f7mr2669872a12.7.1728075586932; Fri, 04 Oct 2024
 13:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004204526.68765-1-kuniyu@amazon.com> <20241004205104.69430-1-kuniyu@amazon.com>
In-Reply-To: <20241004205104.69430-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 22:59:32 +0200
Message-ID: <CANn89i+TbWXVMzzHYVWcyiO7rXnDWPMyuSK4g9=_YaX8qrC=QQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/4] rtnetlink: Add per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Fri, 4 Oct 2024 13:45:26 -0700
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Fri, 4 Oct 2024 13:21:45 -0700
> > > On Wed, 2 Oct 2024 08:12:38 -0700 Kuniyuki Iwashima wrote:
> > > > +#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
> > > > +void __rtnl_net_lock(struct net *net);
> > > > +void __rtnl_net_unlock(struct net *net);
> > > > +void rtnl_net_lock(struct net *net);
> > > > +void rtnl_net_unlock(struct net *net);
> > > > +int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct=
 lockdep_map *b);
> > > > +#else
> > > > +#define __rtnl_net_lock(net)
> > > > +#define __rtnl_net_unlock(net)
> > > > +#define rtnl_net_lock(net) rtnl_lock()
> > > > +#define rtnl_net_unlock(net) rtnl_unlock()
> > >
> > > Let's make sure net is always evaluated?
> > > At the very least make sure the preprocessor doesn't eat it completel=
y
> > > otherwise we may end up with config-dependent "unused variable"
> > > warnings down the line.
> >
> > Sure, what comes to mind is void casting, which I guess is old-school
> > style ?  Do you have any other idea or is this acceptable ?
> >
> > #define __rtnl_net_lock(net) (void)(net)
> > #define __rtnl_net_unlock(net) (void)(net)
> > #define rtnl_net_lock(net)    \
> >       do {                    \
> >               (void)(net);    \
> >               rtnl_lock();    \
> >       } while (0)
> > #define rtnl_net_unlock(net)  \
> >       do {                    \
> >               (void)(net);    \
> >               rtnl_unlock();  \
> >       } while (0)
>
> or simply define these as static inline functions and
> probably this is more preferable ?
>
> static inline void __rtnl_net_lock(struct net *net) {}
> static inline void __rtnl_net_unlock(struct net *net) {}
> static inline void rtnl_net_lock(struct net *net)
> {
>         rtnl_lock();
> }
> static inline void rtnl_net_unlock(struct net *net)
> {
>         rtnl_unlock();
> }

static inline functions seem better to me.

