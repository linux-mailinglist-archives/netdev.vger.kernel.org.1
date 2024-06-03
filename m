Return-Path: <netdev+bounces-100273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ACE8D8608
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CEA1C21DD0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CEB130ACF;
	Mon,  3 Jun 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wgaOVD1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041F130A79
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428424; cv=none; b=sOPnQgHBMTEhpObwZ8Z3T22OsD7WicBLIUKo/rHZeczgeIXl03aHl3vvWtuYQOUD8S+0mY7Zv25pVpBFi0E7BGzuY5Vwvlyao/Zm6KiIuDVX8Ffzqh4FsqI1QCHABGmu6lnbIp9HN+aEtO0wZe12K7UMEY7MYrpgJUukS6t47lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428424; c=relaxed/simple;
	bh=GCysREynIq/k51pK3FKpKnbZv+Fx3mwb/h1RL1zfJf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G913ZwaM3yew4C8ehpUmXiWMu+4dZy4LOzHiyLFr5uUHB1zw0WjSj1rZCR8KBCHGalFzzrKK82iRtqvfFEpOU9alCvA+kDgo22Firz58CQNCQl9JVqsIBxqpdT1sAg95m50bta0sS67Apv33u8Oodlw9r8Gols/NjvmM9MfXElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wgaOVD1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so20866a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717428421; x=1718033221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVxi/LkSwefxfDS7AW/R5wh+l7a4RTyOnxlV/0NRh9I=;
        b=3wgaOVD14H+4llJEvl+cMrVbW1LJr64Sfb96dgZl2BGPtXY69ZxW1vP74tSH4jhAOZ
         F8vWWKsaEa95CsPAUERqO9ZeHEIOQVEN0TJBOBHPfYMRep6zku8BSlXbzIUSMHNdH8hw
         31mjb/s5SAyhdTEtW+LGeAbME0irpDqBAQge1x5WYj4V0ao7i8wMp8sShqQ6pxGkteMd
         7j/K0AymjGjxpgfvPh9l6gb2V92lpw3TxmMl1696ETXWyKaFIGWhyKgeNY/PorZOGYA6
         KoDF1frlJVABZ4qwbwOqJAJ07jU8hfnqjXJKCKduKCZAD6MJ/wfL/jW9QcZLMsWs/JhE
         Y34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717428421; x=1718033221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVxi/LkSwefxfDS7AW/R5wh+l7a4RTyOnxlV/0NRh9I=;
        b=c5MPoDXFoxwcuJAQjzYlKRhFHfSZKJXhnTurJr2EWB7N4oC+dzYSXuyC9VxlFw4DoZ
         AXmrHzzOkcmm+Ek31uCehDbaC42gTGyaMf0JN8VK/j0dAWHn9EX8VrkYyPaFikulLx8O
         pRh2GxDjM/gOri79tZsSqtUIcLyre4zL4h3w10j2HN5Mry7Hbrn7IpStKW/MXIXq+EQx
         Y0sq9nqfSjmuSeAabhTRtq8fuOvi39k//wcbNF6O966TS5g7Cqi0kerPOtUDEhAt4RUk
         oyIi5iPsjVbELYExVftKddFqLLXNctE3bh+9YqpQSgyAqOT1zK5OTNFFsQcyHfohHryj
         eBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLChs1KZRMZU7+KXcsCAKv5qpBkT5Tz+wagoLzOuMlF9JczT4WtqydsS2d3+5qlRMGz+ZlXDowH6YkbprhThcZozI/4kJU
X-Gm-Message-State: AOJu0YyhEg/R+uuy/tJYA8Nk5ejTsIlgQXX0SlfBdVwf4x3K6rPd+Fed
	07noefadiKHa/UCohbMKO1jLTnydeSgoKN5WUlo8EMTiSuILPSPf/xSpdNtnQWpyS3yKPylcxKS
	vlVlL/ZwvDUOkqY5ynmf1eGymgrtMOUxLLxlldJaO6mkppjf/Hw==
X-Google-Smtp-Source: AGHT+IEJie29gRrZXmpmVBvoKCO+i4C2KqVEvQbrFdH2NVmjrW0Z6GhwwdwpKM+0oESJ3vTVZLe5hyr90DPQuDg3TO8=
X-Received: by 2002:aa7:d48b:0:b0:57a:57e3:ea0f with SMTP id
 4fb4d7f45d1cf-57a57e3eb9amr185511a12.5.1717428420392; Mon, 03 Jun 2024
 08:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212517.644844-1-kuba@kernel.org> <20240601161013.10d5e52c@hermes.local>
 <20240601164814.3c34c807@kernel.org> <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
 <CANn89i+i-CooK7GHKr=UYDw4Nf7EYQ5GFGB3PFZiaB7a_j3_xA@mail.gmail.com>
 <20240602152102.1a50feed@kernel.org> <20240603065425.6b74c2dd@kernel.org>
 <CANn89iKF3z_c7_2bqAVcqKZfrsFaTtdQcUNvMQo4mZCFk0Nx8g@mail.gmail.com> <20240603075941.297d1e56@kernel.org>
In-Reply-To: <20240603075941.297d1e56@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Jun 2024 17:26:46 +0200
Message-ID: <CANn89iKax5w4Cx+q-fZa5GEjXwgZzn0Z_=VUWMO_F4Po3hFyxg@mail.gmail.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 3 Jun 2024 16:22:19 +0200 Eric Dumazet wrote:
> > > Hi Eric, how do you feel about this approach? It would also let us
> > > extract the "RTNL unlocked dump" handling from af_netlink.c, which
> > > would be nice.
> >
> > Sure, I have not thought of af_netlink
> >
> > > BTW it will probably need to be paired with fixing the
> > > for_each_netdev_dump() foot gun, maybe (untested):
> >
> > I confess I am a bit lost : this part relates to your original submissi=
on,
> > when you set "ctx->ifindex =3D ULONG_MAX;"  in inet_dump_ifaddr() ?
>
> Yes, xa_for_each_start() leaves ifindex at the last valid entry, so
> without this snippet it's not safe to call dump again after we reached
> the end.

A generic change would be to make sure we remember we hit the end,
I guess this can be done later.

