Return-Path: <netdev+bounces-164598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F29A2E67D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC73188BA36
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA121C1AB4;
	Mon, 10 Feb 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCtUw+hN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152E1BDA95
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176167; cv=none; b=u+i7pgQ2uIZFixMvqo5afrJqGAqUp0Qf9OIPPRjbFc6Ex2egxxFV8sYV0dYkK42g47sBuoH7b0VahY346IliCibncU5qsAbzH386vNh3S070/xzDWzCHA8SpBX+XZ+ON8NJ248fiCZErsbyoOpNMLXxq0j8XIFj7fOrExVOmHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176167; c=relaxed/simple;
	bh=tThUaZa3kvp7xPjJ/f8MdFYKnTVDefQVQHCbkhSgsEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfEG+tgvYN1kokH+eZfq7lXGBLXHJ4LblzY+uO1j2PYdEg92K7MCZWrsjAuXXbbayX6dOvr2FDvb4J+z+JyN820GvYMrCS2xPQAwXhm3OzIcGoSKe3zydGU1wmNcm7oJCIHkbTyoo+0EqqNjG5WHm5HEIXwA2yFwviHGykLOcD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCtUw+hN; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso43138405ab.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739176165; x=1739780965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tThUaZa3kvp7xPjJ/f8MdFYKnTVDefQVQHCbkhSgsEA=;
        b=YCtUw+hNA65JTEzd68wrPHFGYfEkw086khK8ydBAUh6UYWSljwu0SkZ39CHR9mVE33
         etrVt6yPa1MW01OVNQrXPqmcUKISgdtM91Ou9rLlDZwZJpvpdczlAF9CuxEp+HwUgUEo
         eIvTguAdVlX8k8ET9aQAyWVa1IgQP8Or7qLyRBEk0qOCS2r9bWAkP1pGlab3CHdnk9j2
         UY2cY+ogD5vCWvzRENJ71Pik7md64148FcYDv7RTpC5wenNFDucfM+5dvw/9XZb3u4+d
         cLnUU0mLc7E6dUbkYuSo1ODWrMDkhIxA+ZWcyC2W7ol1xVQwaqZ5t0ySwGj2d9vBN0IK
         P6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176165; x=1739780965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tThUaZa3kvp7xPjJ/f8MdFYKnTVDefQVQHCbkhSgsEA=;
        b=OBW03WKO9RasTihvNp16Bq+C9pR+UIP2wDm3/s/GVMqXkeYusvLlUe4fKcYV0Bnt9c
         dODD4Z7vd6Duf47KeWl8ZDC52oD1XfVvgFaCItSGeBy3ILcaTW6X8FGj7DAg2UT69QXe
         u7b3PfwZ+SfCTzmHmHu9cNA0H1OO9QLsxPSNkwBDogVklgfWLNgbjD++L8iOQpc+3eRL
         h2KJbxrtAXL4krnmpz6CPdi7m3eqdINARFhbLxGPRrZniEvPoqVfL/Zz2zAiIL8Xo97C
         JC0dLtlhLLmCE9tJRyOAWL41JntbbgbtM3aeYGYzOfvSFquSVPU5jSCwZrF93+RDYI51
         EaEg==
X-Forwarded-Encrypted: i=1; AJvYcCXbSQFeU4mfbliImbnqzjz6l0ni++GfTmqrZOJmUI8T43qXhxQphEMmHa0w9xS9ElKvOMUR3bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzz/BsDvPYMLJrkcYvsSsaAZWUG670d0JY5gyB5xsbRXupWv5e
	oaOkSFrKCpPgTdLjyVYgeVZJQmW3x8ozwE4d9TgXENUX/2g6TSE3CV9L7cBa5npxLGn0agbNs2o
	RmTtkXzLoaUY+g8trN1gX79nzL70=
X-Gm-Gg: ASbGncsx7pHEn0Oh3JMnNeZ5LsOjIhsO/ouGnYKYj9XsuQ2S8RlgE+PvWRkh8ORGV98
	j321tDErthIWqKvpIqPm9Lmn4kWNXizRnPQF3HM8Tb++Bbb+Lru87OSGofpbGORilaNi7ww5T
X-Google-Smtp-Source: AGHT+IHpPj2T4V3p82YXMBCO6SwIZMjyaRUeXc9YKF9j7anYBF40LuhqJPO04R9rHO/Wbjp2LZIvyN6lXAdtCwdA6cE=
X-Received: by 2002:a05:6e02:1a69:b0:3d0:2477:83ec with SMTP id
 e9e14a558f8ab-3d13dfa8591mr82841345ab.14.1739176165163; Mon, 10 Feb 2025
 00:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-5-edumazet@google.com>
 <CAL+tcoD8FVYLqJnA0_h1Tc_OeY4eqmrDPQ7wJ22f0LHxSG+zBw@mail.gmail.com> <CANn89i+k-EP+Xc8WWsESDGk+6dC31Tp0gSXg7MMdsB+sXmsm-g@mail.gmail.com>
In-Reply-To: <CANn89i+k-EP+Xc8WWsESDGk+6dC31Tp0gSXg7MMdsB+sXmsm-g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Feb 2025 16:28:47 +0800
X-Gm-Features: AWEUYZl9F8qVJgKSlgKCUMtQkWi5V8y5EDmuVXiJCXXquZtBN25FAsi2ZrM0Sdo
Message-ID: <CAL+tcoCGz-3_ThpEfHSBn6U8oAYwVY1OZ0FRwOGT_fSNDYio2A@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] tcp: add the ability to control max RTO
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 4:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Feb 8, 2025 at 6:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Fri, Feb 7, 2025 at 11:31=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > Currently, TCP stack uses a constant (120 seconds)
> > > to limit the RTO value exponential growth.
> > >
> > > Some applications want to set a lower value.
> > >
> > > Add TCP_RTO_MAX_MS socket option to set a value (in ms)
> > > between 1 and 120 seconds.
> > >
> > > It is discouraged to change the socket rto max on a live
> > > socket, as it might lead to unexpected disconnects.
> > >
> > > Following patch is adding a netns sysctl to control the
> > > default value at socket creation time.
> >
> > I assume a bpf extension could be considered as a follow up patch on
> > top of the series?
>
> I left BPF and MPTP follow ups being handled by their owners

Good to know that. I will complete the BPF extension as soon as your
series gets merged.

Thanks,
Jason

