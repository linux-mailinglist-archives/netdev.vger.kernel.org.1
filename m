Return-Path: <netdev+bounces-76227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E046486CE33
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1621E1C20C28
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17014BF56;
	Thu, 29 Feb 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF1qJLON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF214BF3D
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221860; cv=none; b=EgZn/7n711LCtXM1VlanLf0GqIxwVeI3k9m5CtnItR6fl9wNfIv5l+qfqSEoZSlQVVkPF9CjJtTk33quUQHZL0BnuCsAodHVFwpbH5mV25NdywmYvpD7KWAr9CN1JoX/dq+4mkZh7RzmdXUXRsdWsYvoXZeogiag7V510dcIbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221860; c=relaxed/simple;
	bh=PLICJXABggPD0V4BYJaT+5CSRFRoKrzR9mbkxfHqsEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDU+ftXn9vOIdqH1XY0dbujB8qkWTvz1noncx7z2KTYYo73IJT8aBEXJsgI3TX7l0aLD9uwhEKb6jastYQl6Q4CnHw7uPcycERBXFR5nlplSuhYkZzAjuhq9di4CKfqmtt9QlpxMzgYV/VzXx2sx5+M+ZvaPDxE3cRs650vbeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF1qJLON; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so10858a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709221857; x=1709826657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv5hTs6eUFyQHuQetzzGpdmxL8RB7LyyxPcBHVlpN80=;
        b=IF1qJLONewZcl8RNL/CY9Tut0AejYDuWDvz55k3/v0YSDodB4fa/lzcZefEeFxldsB
         guY3BsewL5Z/t9F76CqBlHtQDA3+nqr0RMY1J8dzUlVx9VX7pnDUmTAflA8y67rUbSMN
         9R5IDq7vJqp0ScP02SGXuK4+s7putBOA6EFdMORbafrx0JJYiXwQaCdV7qKuTcUGK2gb
         UpjKTgmHepJ2q77qSxO0zLQuuvbh5zv7WOzKztcw0AUFb/MzY2adhWz8EMMF2Px1MEXc
         +LdOYPT1g6Gt6qZWNnhXzo/0wKFJyWKel6sU6wPtpd5NlxZuPIiWwoZHFSWbbRWPv/ol
         Z+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709221857; x=1709826657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv5hTs6eUFyQHuQetzzGpdmxL8RB7LyyxPcBHVlpN80=;
        b=lXpGJk4G7j5Q9AOjDr2aBSPikl0B8wMLFZy7/97k+5fzFuaaq3UVDZIr+zRLuGwTlG
         toZKI4VDfyfdQb54qtf1c+MN2jVrKFSbtTJ+9w7/0AEGkcNKmH8rZRsYOI+jA7WymEKQ
         W2ALoRxQCCzSvBXq7mFqzn6hhFw9cyRSUziipIkwPjcvYtiCSFGEMIO92pPslFfbkIEC
         ECRG9m0huj4bn42pMcRZYXIF0Uc0l1AeoMRpV2uC2Y++/ReHr7rk32cDukweEIMCHKp7
         mlQCYiblNlOU9AtE6j4nQ0AuKbLh4rr+Cyd4lHI08Is9UnMuZJJwH/IEdp0T3e/zGxmQ
         48Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVA+MrQqesBO5kPZUhFpIUe3bqeiQZP8HLvvqltUNJijvFz2MjGj1krA0Ufirin7xvpOTcVkhIgjcrslin0AchkRKsnnsvb
X-Gm-Message-State: AOJu0Yw/v01cp28jc/fRsapKs9KrDStKCeD1zXsrAzvxPQeaB3Od+JgP
	QEAqP6IwbkCrlucP2HlBXmQ5mFiqgfwg6VCE407aZXbfOBATf8zI3d8MpVoBudTtc37ssY/d7Tm
	5at3QIii7mXr3xwUpMf63gxvVkLyX4Nr2vWVF
X-Google-Smtp-Source: AGHT+IHTxDFuh+64LOxfkqjIDCcJEYH6OixFDEBI+H9+v6zG6NpV0bHvlT45/rh+80uH1YUF/AKPgiKv7wFFOOe9mDg=
X-Received: by 2002:a05:6402:26c5:b0:566:9818:af4c with SMTP id
 x5-20020a05640226c500b005669818af4cmr203182edd.4.1709221856790; Thu, 29 Feb
 2024 07:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com> <20240229114016.2995906-7-edumazet@google.com>
 <20240229073750.6e59155e@kernel.org> <CANn89iLMZ2NT=DSdvGG9GpOnrfbvHo7bCk3Cj-v9cPgK-4N-oA@mail.gmail.com>
In-Reply-To: <CANn89iLMZ2NT=DSdvGG9GpOnrfbvHo7bCk3Cj-v9cPgK-4N-oA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 16:50:45 +0100
Message-ID: <CANn89iLPo61i8-ycKYVrUtEUVMGg09mw153eB3sPX24jXaD9WA@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] inet: use xa_array iterator to implement inet_dump_ifaddr()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:45=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Feb 29, 2024 at 4:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 29 Feb 2024 11:40:16 +0000 Eric Dumazet wrote:
> > > +     if (err < 0 && likely(skb->len))
> > > +             err =3D skb->len;
> >
> > I think Ido may have commented on one of your early series, but if we
> > set err to skb->len we'll have to do an extra empty message to terminat=
e
> > the dump.
> >
> > You basically only want to return skb->len when message has
> > overflown, so the somewhat idiomatic way to do this is:
> >
> >         err =3D (err =3D=3D -EMSGSIZE) ? skb->len : err;

This would set err to zero if skb is empty at this point.

I guess a more correct action would be:

if (err =3D=3D -EMSGSIZE && likely(skb->len))
    err =3D skb->len;


> >
> > Assuming err can't be set to some weird positive value.
> >
> > IDK if you want to do this in future patches or it's risky, but I have
> > the itch to tell you every time I see a conversion which doesn't follow
> > this pattern :)
>
> This totally makes sense.
>
> I will send a followup patch to fix all these in one go, if this is ok
> with you ?
>
> Thanks.

