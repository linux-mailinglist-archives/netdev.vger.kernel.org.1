Return-Path: <netdev+bounces-94678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419BC8C02BD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6A91F22F5D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0A1F93E;
	Wed,  8 May 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w642AIJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0FB8828
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188423; cv=none; b=rlLtpQ8Ko3Pg7c16PcW/zwBztJ7hCb8Lls6ehEx+eng4ZS6pxJ5AmEQofb3XN7ejWYAi/CEQfjZWh+BrsN6aChv2WbAL1E6+Xe/RSEJl0oH9jEowjRLwIIBgaaIwwwYAjkBMLW+JO6r0zL2YlZqhqKQ5PkEtAHOkG23g8C7Y12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188423; c=relaxed/simple;
	bh=cw3N3CICXHUW5OGSW6pfvTL8vPieyYDkFHFAUWuCSg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrDk6IZKfxRJUMWRy6Flexr6eNrSSkKo03Etsdod2TgtvcTnQvpCNKvG8xhSsT4MHP9VITyGUykYJmzPl9d371AZh9qsDgZVW8f2NJlxwD9XuOTkFbl78z7fAT4RfOBxUWMtwLU73mnbF1iPZqmG8viafLGfoyySobxahuvv8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w642AIJg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so7834311e87.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715188420; x=1715793220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsHfHo/aaweXCxZ5Mn8IWW/4F+6bL+ijooklIMIcIZw=;
        b=w642AIJgkRBnSEWyFpoWZ8CnTPmI1fa4An6QArmE8B4MCIEu47zHkrUeV2e1rx4wjM
         bB8Ktax4VSnP4GIWp+4vNjWQfjRzE0LivlNHY25b0VMgtbmMYuNH7feyBf8d0Atq3vRm
         0rSGRCpB3IRn9OyDJxY+/uwKye5yXHI1qyuABYG5SVMyNWOF+eC1VV84Bb4u3UFg7+DL
         0Y+oi7Bm1Y5B27pqjvRcA0WqRMkXIOjyEn3KY3CKTP0LMkxJCxnloifj0x0NTRF0IGu8
         66md834cbUqtlXf29udXYjN2Kw6fA0G9anp25Ajlxeuri2lUUb+3lttMe8vRBBVeUQaM
         JdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188420; x=1715793220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsHfHo/aaweXCxZ5Mn8IWW/4F+6bL+ijooklIMIcIZw=;
        b=EAapKo7ecsDAqeDR5zyzmZZ8uXPx+mk4GlsbZQjNOJyQ6KO16ildJJNbqmT092M3Pg
         qo5uEqPDQseNU1PrHKMspgKYU+2kMSL45Jr5+Y4rdiVe4MuaCm0thsWbhYKt113mFHrt
         7LWyu3nHLpzaIqGlT3t6pIx3wFCa5MDSIDkGgmtC96ycGzRQK88KqhmFhEGl1MGXEIZP
         8HP8ndK0uB19gkHP7ry91E79b8jY4iJLC6aqC9KrtNNFvHq9PAGOm9yBED/hKD+U5hqv
         gvKS3TEYck+qLXocsCGAkHHOc5myy5YiRzrVcR3uN/eTlunWuA21B/IQc0F9W8LyLxKb
         5Xlw==
X-Forwarded-Encrypted: i=1; AJvYcCWypx8sc+X3UQ5SKi3X4f9aDGUupYZE+zbi77RK+S4F1kTyMRUoQR5gUEa/uGwhts4iyn7qZX1zN6NFyxQjS5xaYh/Euv9y
X-Gm-Message-State: AOJu0Yyc3LfeFvPdYegXPEouwmlavVxPSIRIPbM8rM+JauieK6DjGrOL
	vpYD5ntb0/XG0cCUxJVn/ElrkYtzaCnuPIjckjit06Y0qFtzHqBOlssRxcIo582CnK7ocXy1ELk
	Jwwe3hVjhMaDo4EN7ofMge7ch8inWPSqL5kHZ
X-Google-Smtp-Source: AGHT+IGg5HastfF7A2YGc4hUvPKmo7uwA2j8lYoPiDngP5YSSTcSKQJp2Af5R2I929wit5insgUcTJPiO/0WnV1XiaY=
X-Received: by 2002:ac2:5f01:0:b0:51f:c112:9d7d with SMTP id
 2adb3069b0e04-5217c854dbdmr2318748e87.41.1715188419289; Wed, 08 May 2024
 10:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502045410.3524155-1-dw@davidwei.uk> <20240502045410.3524155-4-dw@davidwei.uk>
 <20240504122007.GG3167983@kernel.org> <b1d37565-578b-455d-a73f-387d713a2893@davidwei.uk>
 <20240507164626.GF15955@kernel.org>
In-Reply-To: <20240507164626.GF15955@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 8 May 2024 10:13:27 -0700
Message-ID: <CAHS8izPhka4inhyjDygvJU6kz4xFB8QVai=_M0nSiMFgK0czwA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
To: Simon Horman <horms@kernel.org>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Adrian Alvarado <adrian.alvarado@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:47=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, May 05, 2024 at 05:41:14PM -0700, David Wei wrote:
> > On 2024-05-04 05:20, Simon Horman wrote:
> > > On Wed, May 01, 2024 at 09:54:04PM -0700, David Wei wrote:
> > >> From: Mina Almasry <almasrymina@google.com>
> > >>
> > >> Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
> > >> taken from Mina's work in [1] with a slight modification of taking
> > >> rtnl_lock() during the queue stop and start ops.
> > >>
> > >> For bnxt specifically, if the firmware doesn't support
> > >> BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP an=
d
> > >> the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
> > >> attempt to reset the whole device.
> > >>
> > >> [1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-a=
lmasrymina@google.com/#t
> > >>
> > >> Signed-off-by: David Wei <dw@davidwei.uk>
> > >
> > > nit: Mina's From line is above, but there is no corresponding Signed-=
off-by
> > >      line here.
> >
> > This patch isn't a clean cherry pick, I pulled the core logic of
> > netdev_rx_queue_restart() from the middle of another patch. In these
> > cases should I be manually adding Signed-off-by tag?
>
> As you asked:
>
> I think if the patch is materially Mina's work - lets say more than 80% -
> then a From line and a Signed-off-by tag is appropriate. N.B. this
> implies Mina supplied a Signed-off-by tag at some point.
>
> Otherwise I think it's fine to drop both the From line and Signed-off-by =
tag.
> And as a courtesy acknowledge Mina's work some other way.
>
> e.g. based on work by Mina Almasry <almasrymina@google.com>
>
> But perhaps it's as well to as Mina what he thinks :)
>

I'm fine with whatever here. This work is mostly off of Jakub's design
anyway. Either Signed-off-by or Suggested-by or 'based on work by' is
fine with me.

However from the other thread, it looks like David is delegating me to
send follow up versions of this, possibly with the Devmem TCP series,
which works better for me anyway :D

--=20
Thanks,
Mina

