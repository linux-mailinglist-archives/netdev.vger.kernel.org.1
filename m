Return-Path: <netdev+bounces-75599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95CC86AA74
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176A51C219DB
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104D2D052;
	Wed, 28 Feb 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1hE9KH5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597792E84B
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110280; cv=none; b=gE4dSk+QGdE9O1WPVwK6vZrlhMSwQ2Q+EbC3N6G474fcF+Rm+rnaCK3yY0YjfcXEQNTkcLo1KvZIW27Q3UWNcYvAF/mpsLy3fbPGR5CbFqnb6aj12O+M3Y9cZaZXvHK6wuUsq2BcJ6jAuTF4NzknRUKUiDFVVFR1rQ4pjCJ4kzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110280; c=relaxed/simple;
	bh=VguwFI5Nh44AU3xfgts16zg7HtWLmV9rp4q1UGKzrss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqi+cjeceMXL5qK1o8lRxWMvS+cJctwU+0HU1FW6ir8UcjoaXXZpexwZ/tqPvreO2wQDN+cmRnH8Uy2icSBiVrSTGYMDUWFtkvt1qMHnUYWyrQj4dpRqQIE7V5mV71fvX5I1H1amxVukDMnyjNM9UGv2Cms4exfkgtWvPPfIv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1hE9KH5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so7129a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709110277; x=1709715077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4pXwMqJgJuF3cOjxHY0GqiKaFvqLPWxpxHNcks0dho=;
        b=c1hE9KH5hK/DzyUICGGZwt/4Mi4eIFgGeJb31P7dVE3df/PvSJksXWkIudEGz9gZL6
         hJHF2Voj7BUsOcFFZ6+8ZKc7huwuGX+DuRf8Wp18Jz3LGT6uN0Vs+BSJaZgiXLSwvQ1V
         ih4YqZ1Rmpy9pgj4xUVW0QRem5JO1lS+Uvtkr6B0R06LomsmN0S9YW073crwDBywcyJ3
         vPEyuxCPQ0gI+nHRiwk6dbOSPFhpVuBUgS6O9/H41fXcAfy0PZ/cxM/ESw+5/tNl7zhY
         oJ/X1eyWLyv+Vrq2PdyT/YbplDLUSftM1Rdvpaq+18sY0R79Le1a503WE4RJzxL8xf10
         hb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110277; x=1709715077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4pXwMqJgJuF3cOjxHY0GqiKaFvqLPWxpxHNcks0dho=;
        b=cxyXyoLIu5C6NBv+Jl8zPDuH3mhNHFhiNbWdjmN3vX/EeQLUd8Ws2G6DasbpUOcaPC
         zMUgUhW7ZJ+aHQ8/FVhm5oG/OkpWctQt10X8CGaw6UaO26jL7fW8mfuA31uDgvKi6vDQ
         q/rtIAkfIjzrj+0s7sVvKk6mR8p074+Ti0GBzkb7qEvsBQbgHkW3O8SxcLL6Vwg2r4wW
         fM4rXbWnfIVYFFeLsgv1uuT7ovwocA/zMVCMtauLW1tSX+cEeeCywJB3pltJMR8AX224
         DEfGTk9P2LTw/ar9voEdqsqZ0NGkcD4EAr/8M8CLTawXdtXy7ev1Z15D1TdODoPpOVAU
         d4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMnewpo819ZiO0bDoIQnGBLOV4C/NDRwT9GmQwbAuRiBJi/Xj7cdVxY2bAPlhWw4npQmTDzpmMY6cXZQQl3/5WmWhyd0kR
X-Gm-Message-State: AOJu0Ywm5RHGIvB7aMMDzcL8u/Q6XRXXb8TRadDQLaPQcKabNzEinsEt
	kshJnALi6s6KJM9UQW/iuYPcEZtDu8fR4PDA6nsHa0dxjeeT1ouNiRiLDWopKHKGu45NSLe6NOf
	KToloS8G5NEVxw9Q3iTlhfd/LasGmUsbi6lyP
X-Google-Smtp-Source: AGHT+IGsrNXzKQKzeZgehiNRjBTgkD6iz71BwwqNLTTr7IAiX6vjfUFvVK4Zi5+f7+m+LGY6Km2HgNlg2ViSzWF29/4=
X-Received: by 2002:a50:9f89:0:b0:55f:8851:d03b with SMTP id
 c9-20020a509f89000000b0055f8851d03bmr35592edf.5.1709110276489; Wed, 28 Feb
 2024 00:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com> <20240227150200.2814664-4-edumazet@google.com>
 <20240227185157.37355343@kernel.org>
In-Reply-To: <20240227185157.37355343@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 09:51:04 +0100
Message-ID: <CANn89iLwcd=Gp7X7DKsw+kG2FHA1PzwG3Up8Tb2wjA=Bz94Oxg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/15] ipv6: addrconf_disable_ipv6() optimizations
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 27 Feb 2024 15:01:48 +0000 Eric Dumazet wrote:
> > +     if (p =3D=3D &net->ipv6.devconf_dflt->disable_ipv6) {
> > +             WRITE_ONCE(*p, newf);
> > +             return 0;
> > +     }
> > +
> >       if (!rtnl_trylock())
> >               return restart_syscall();
> >
> > -     net =3D (struct net *)table->extra2;
> >       old =3D *p;
> >       WRITE_ONCE(*p, newf);
> >
> > -     if (p =3D=3D &net->ipv6.devconf_dflt->disable_ipv6) {
> > -             rtnl_unlock();
> > -             return 0;
> > -     }
> > -
> > -     if (p =3D=3D &net->ipv6.devconf_all->disable_ipv6) {
> > -             WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
>
> Why is this line going away? We pulled up the handling of devconf_all
> not devconf_dflt
>

Good catch, I simply misread the line.

