Return-Path: <netdev+bounces-228274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3959BC606A
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49121887A1E
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09529AB1D;
	Wed,  8 Oct 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHj49RiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7C288529
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941068; cv=none; b=l/KmHFux8qvqRQNugvtoER4nxrRkaR/kY6oUN8LK7cCIqs2O5w/rbi81q6b3ENGAvVA0zFildaIiaTyLNT9Kd1fQJyQSb0HdJ3Rv4b6EYmdGr60cEa1H9KMxr4pddt3SNLy1CjgwaH0aMyRi6hGbP0QihrzIFHScYMXXmfrlAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941068; c=relaxed/simple;
	bh=QEiFuU1KfCPsQteehgfxfuF/7UHf+unS8bkJKHG8nA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mACJuIgdiaig238RYNyFVnvVBBugjqeRfR5OLzfaMpNzdzCtnMcQjD4wg0AXfkCA8W3+aqKV+YVkIhPpDBKwI16XU0a3BjubMhaQtpnW8ONYeDV3Bt4vJcuzvUHHTkfB8FpUbulFiPf5N95uL9ws3vGsSs2NCWWWcnwPOI+62OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHj49RiT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72ce9790acdso611687b3.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759941064; x=1760545864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//VncRn5qjjkxpkItOVK/z8vaM00DXBcQrrIm+OM/qQ=;
        b=rHj49RiTjkI5BAk9jCPMnRJWK6Ll4HPOE5hpA5bdA9gptD369WHMX3eG1SEiI8SiX5
         fg5WCeeZCGwuFxJMsdWJEPWsbJBigN2rKAXp6m75I5BbPyjz92fvPfG5CQsnXxWRPc5X
         0R2E8mT8Oai5diHYKKQHBRncUReoAhPemvfUKmbEENzcpaO4ODZm6lM6CdYIBtFa+6AQ
         7tORRaZrsB/ao9wqhGLibgj0eMBVmk0bSwTPaT2vJi1S4GNiFgiagbq3LXPgrdAyBGzP
         H/XM8KqTGHVG0FGR0apZ7mAH6+AxCHjYTCXZ01nlrWm8F50M3Qw9hqJJR+rvGh/TPj9J
         d1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941064; x=1760545864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//VncRn5qjjkxpkItOVK/z8vaM00DXBcQrrIm+OM/qQ=;
        b=KVDuEcmpCPuMl+T+aBuXIUzzdW7bQTZSkYo441N+0zW1Yt/niqPWLjBp46RCdCcXzr
         TZyTOTXpX+LJ1MgrPHQ1zR/xwfJ6NEA+3BdoWBFvUJIEa4Z50eRa5oeJ7qnMvpNx1/va
         3y0rxMhPB4I+M214AEYd9WrjtY18dBluTVN7fkZs6mLaKSojhn0bQGiZtpgxY2biVg67
         0ySkup+fTMApxR5KWdD/qKv6fUjsJw1LDNCCSEwuTUn6TbeybWM8BIZ5pK/cn9xTwEjO
         CebYPIQZmJu7MMJWHwp1+SgPv0CZyB+zjMw2212zkugqSTNZf5moj5RHt+jzQ6sASKvi
         JciQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwWTNVXVCxiMI9gCDig5/6YR9jgImc+jYlh0KpOClwMWFn5ARXMVdriGTzUHto9ndL5hCPCVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTm1zLmxa9zoUFnVp0GueZLBIpqmVPa2QD+Z2tT2juVroJ3hR
	pDPD/8M84I6JOZGGGvw+V0P5QhxYoya/Y9+JRvNDFZpEMPY7LoQK2ihmVFT6QV2mlJN2xQfHpej
	nN2B1qiUO0EMcWFgi5vHDKGStWRz2pyINAIIcrSrT
X-Gm-Gg: ASbGncu04skZH0hQSZ1BrpCN6QbTGjOgavvK/xZCYI1IdGKndXzD5AK1hgBiYVoz9en
	hJ7KUFfEvq4KAL88JwyEr0bnmO6Vmdqtyf07GudsfcDfbWu4SpXYDr+Nmy64XmBBJaU1XIEf2r6
	yI5JnDbc29j8nVU6LDo1vKAZ32TvGe+O/Iju5pSjJ/1rRUEX2QE9eomxN5HUQvY7nDDdBih8/Rr
	yZz07BIvDIRiMdySe9xz3o7dl4RpN5dR0sFDA0tQgp7ueCe7CE3gjm/CBGji+bWLDt2NO6YMbp5
	nHEu6I0=
X-Google-Smtp-Source: AGHT+IGde7044Ux/MnmPmWmn0VLateCQgjLkbYZweua0Y5m86UlgVY7J9w+1T2kLi9XSbkejfBi8R8SuP0Sqt4bYMNA=
X-Received: by 2002:a53:c043:0:20b0:635:4ecf:bdd1 with SMTP id
 956f58d0204a3-63ccb9685c2mr3643475d50.51.1759941063668; Wed, 08 Oct 2025
 09:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-5-edumazet@google.com>
 <eba94a12-299a-46db-adf1-5f37f1b9b993@redhat.com>
In-Reply-To: <eba94a12-299a-46db-adf1-5f37f1b9b993@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 09:30:52 -0700
X-Gm-Features: AS18NWAZ8H5r6yLvKfQOmb0SYgwf0YmGvXPYj5-QhFtxFvISUuTGlUbSClIE-MM
Message-ID: <CANn89i+2W-es3buD+7TMMqXdEDu4FU3HORaKvNToUkaPR1dyag@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 4/4] net: allow busy connected flows to
 switch tx queues
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/8/25 12:46 PM, Eric Dumazet wrote:
> > This is a followup of commit 726e9e8b94b9 ("tcp: refine
> > skb->ooo_okay setting") and to the prior commit in this series
> > ("net: control skb->ooo_okay from skb_set_owner_w()")
> >
> > skb->ooo_okay might never be set for bulk flows that always
> > have at least one skb in a qdisc queue of NIC queue,
> > especially if TX completion is delayed because of a stressed cpu.
> >
> > The so-called "strange attractors" has caused many performance
> > issues, we need to do better.
>
> I must admit my ignorance about the topic, do you have any reference hand=
y?
>
> > @@ -1984,6 +1985,14 @@ static inline int sk_receive_skb(struct sock *sk=
, struct sk_buff *skb,
> >       return __sk_receive_skb(sk, skb, nested, 1, true);
> >  }
> >
> > +/* This helper checks if a socket is a full socket,
> > + * ie _not_ a timewait or request socket.
> > + */
> > +static inline bool sk_fullsock(const struct sock *sk)
> > +{
> > +     return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV=
);
> > +}
> > +
>
> I'm possibly low on coffee, but it looks like it's not needed to move
> around sk_fullsock() ?!? possibly sk_tx_queue_get() remained inline in a
> previous version of the patch?

Yes, I was using it in sk_tx_queue_set(), then realized all callers
were already doing it.

Thanks.

