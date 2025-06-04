Return-Path: <netdev+bounces-195018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF7ACD7DA
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE643A48FC
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F62AF0A;
	Wed,  4 Jun 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLnpojqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781C14286;
	Wed,  4 Jun 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749018743; cv=none; b=tZl39blWYqks1r2m/5P+c1T2bCYax9GHzDEYtzsIm5mPYtAZjiA1QmlzKB4NRMaPqvrj+k46JNb/5jLHoDGTRoo5qLbhGUqw77tmItYTxAdy4NE9QuUtcOioAxNZ6NcLQp9J2g/b3yM5Vs0IdyDzCw9yppjMexKm4jROV72TZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749018743; c=relaxed/simple;
	bh=HrUA/493NEN9uE8zA3xiNFXWRTC6qwWQJcNULV0EPUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIhMiJkvnCka6sxGrY/BDtTjDfE2FueiLvb0urTIGhiHZflob5tNRs8tUJvlGpV64w+53ZyOkFhGqsc7/Ft2gaVTzbGtuvAb8+Mp0tFRLQRDkn8uEGBFkagdomTOBHvXjtGia81qpfdTKqDrChJFXd+qUGWbS8mbm2POmEbJ4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLnpojqS; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3ac940ecso47977597b3.2;
        Tue, 03 Jun 2025 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749018741; x=1749623541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms+LCbsutb8KW48WzOhQS6Y9P4iFjvEFRghkClssGZo=;
        b=nLnpojqSkZHIg8ePZE0xrGh+cQtSWlW/nqmL5rU+83FPxMGyHQqUK6GtpQrruVeV/u
         EttHbACSdlyqYgK7kKMxMTqTdM5yqhKUiiULlbMbQlzNrMApnVwu2MbvQYY9cBgaRqZV
         LGCrR+qYtaErIBkAWY7+5F+kcxgI6NX6OTvfBZ/84dbzFUpL3K0Ho3a4YIqVB8F1QreW
         6HN3EiFXdc2hpLrQY9V6coGva4ltD26fF4FSy9fIglyHP4rZDd733+Sj6ryLYHGdBBI5
         /lpk2Gs7IVVvRzqzIvAdjaX5is+Y3F6HylxGAIMsLv1mm8ERfVZ/rNfE2gIgFfbW/TQg
         xSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749018741; x=1749623541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms+LCbsutb8KW48WzOhQS6Y9P4iFjvEFRghkClssGZo=;
        b=jhthNHC3IX6sIHmd7TESnU2abrmARdDfKZdJ3wKQZ5ChRbXulNT8+WzNIRoPOT1W6J
         95Yj1bmT+6WOGLRrjCMZsw7E/8Z0VF2TLHzKJW2fWUBw6kwAuB8fuoi512ArxCSPQ0O+
         kZb1Hd5Fx/Ollui8bNGR6NlQdaUt3q9T/ReItfiyoDrmIPKgL5K8V0dW0Jn/eH0EKAbV
         plujcSutqEhqkh15OtZWfTXURcm62jCHEMGFymUX5qMZy2lIet41lKlmht/eIoasPW/l
         /+WNsxowZRwUxJjb9zGnOUeyceN3wCf7RfKZoe5rx1KlzjAWz5ZpuVduyxG5fJjETE2q
         F2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUqNpjBRXWyhC7u1IO5v4gHu5+/YEJ6sn2/PuZs+TvyNdB0aDG9rJpp/Gk3gAI/EO3920hw1jEZ@vger.kernel.org, AJvYcCVLfqpnTznX1W9FFVt3kSGH0RjHhZgE4Tu3QXNpYaWHVuugjwB+u4W7UVor5y6HMxzAhP2xi0FTCUw9tAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CEjlxmp1uh+0MxfxzevqI6gQ64c9GaxFeHDIMmqWdvEhyX6e
	oGuR3aRcDkRxaQNORfqkXgV7c51fJmb3EhlB6v1maTIb4BgoGJY/OG26m81QBGwhnvTMm82chWc
	JXXei7nnDh6dadoJ3hCxbETkYDUbXWkFHXg==
X-Gm-Gg: ASbGncsfUyQLNxNgcjzUtTrgwpEQkGe+RErEzzJL8V0kzj6DpJ1zVorx086x3c3IybY
	SroSORO9Ofi8YpR98R0xxnfmuIpP16myy1Rl7kIcX2RfqxVTqdqA2YbJiZHr3HQBY0NoZP+Jc+A
	IYGtuSDpwzHjJ+cG8q4xmvIJS3uHsk7wI=
X-Google-Smtp-Source: AGHT+IFS2DmutEXJW+Z0K5aNrE2XFe43CoGAyxSeKa7W9mRcsqTTn2m/46GhQsIhF2o8C0f08KVkuY4Pmfa5btILNwI=
X-Received: by 2002:a05:690c:46c3:b0:70d:ed5d:b4b2 with SMTP id
 00721157ae682-710d9a70674mr21676607b3.13.1749018740846; Tue, 03 Jun 2025
 23:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603204858.72402-1-noltari@gmail.com> <20250603204858.72402-2-noltari@gmail.com>
 <507a09f6-8b6e-4800-8c90-f2b1662cafa2@broadcom.com>
In-Reply-To: <507a09f6-8b6e-4800-8c90-f2b1662cafa2@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 4 Jun 2025 08:32:09 +0200
X-Gm-Features: AX0GCFsyMq2aZf5NHYqZfwT6MTm2ZeUU_GTj_9sxXkTzEzNrK3kVErt9rYfPTA0
Message-ID: <CAOiHx==HkOqi4TY6v7bdzWoHEQxO4Q4=HH8kWe7hJiEdLTy3-g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 01/10] net: dsa: b53: add support for FDB
 operations on 5325/5365
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 12:10=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 6/3/25 13:48, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > From: Florian Fainelli <f.fainelli@gmail.com>
> >
> > BCM5325 and BCM5365 are part of a much older generation of switches whi=
ch,
> > due to their limited number of ports and VLAN entries (up to 256) allow=
ed
> > a single 64-bit register to hold a full ARL entry.
> > This requires a little bit of massaging when reading, writing and
> > converting ARL entries in both directions.
> >
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
>
> [snip]
>
> >   static int b53_arl_op(struct b53_device *dev, int op, int port,
> >                     const unsigned char *addr, u16 vid, bool is_valid)
> >   {
> > @@ -1795,14 +1834,18 @@ static int b53_arl_op(struct b53_device *dev, i=
nt op, int port,
> >
> >       /* Perform a read for the given MAC and VID */
> >       b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
> > -     b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
> > +     if (!is5325(dev))
> > +             b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
>
> I used the 5325M-DS113-RDS datasheet for this code initially but the
> 5325E-DS14-R datasheet shows that this register is defined. It's not
> clear to me how to differentiate the two kinds of switches. The 5325M
> would report itself as:
>
> 0x00406330
>
> in the integrated PHY PHYSID1/2 registers, whereas a 5325E would report
> itself as 0x0143bc30. Maybe we can use that to key off the very first
> generation 5325 switches?

According to the product brief and other documents BCM5325M does not
support 802.1Q VLANs, which would explain the missing register
descriptions. It does have 2k ARL entries compared to 1k for the 5325E
though, so I now see where that value comes from.

If it really doesn't support 802.1Q, then checking if related
registers are writable might also work.

Jonas

