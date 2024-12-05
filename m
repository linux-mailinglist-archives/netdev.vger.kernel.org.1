Return-Path: <netdev+bounces-149340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505249E52DE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB022188037B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B511DB372;
	Thu,  5 Dec 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaDtVaSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4D1D4600
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395576; cv=none; b=HW5pfvNq7u34zNUa8L0nIrE8zC2krc2RBeckB9dxnF+mLAm0yMaU8qN2Mg2un57XCAD+/3WJw+MAnQ8fXiYlR52TjZcVCotH3635gIVaI5894xlX2/zpUoIeP0yOharjOQXuF0Nq8pmVa6fEwxmTt4wsouL1AD1pzsoQHfbl0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395576; c=relaxed/simple;
	bh=oVNhBXCZHLlY4dxQD5hBqJ1+AxFtxhvl9sk4zboNcUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkYiYuQ/ywXIrfKoTkTkNe1qmmuLlsUhC86JK7qINYwAhLokHvqEwOBR8zzS5ZRtFyivZXPFlKc7E+rEHptEDvqNTAJeWCt+5aYDMkCG0f7HTBU39v7Ddh0JmyQB/78XjngxAfJ+v+tdqjc37gEtE+O8QkWbueYnZ0JMBV8Ynqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaDtVaSt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e21c808ceso5e87.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733395572; x=1734000372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVNhBXCZHLlY4dxQD5hBqJ1+AxFtxhvl9sk4zboNcUY=;
        b=jaDtVaStIv3PlPacIhPFxMpHi17L94o1bFcYH/HrB9TaHLW2WE1lkBamS7uFC+nYyY
         yoTFxxdMS5JxBNr8Me1lDf6T3nic3fhyACKyZdx/saTNrv6lnhSdYlDXkKbzqOm7poh8
         5NGWXM/yRn7tI5HNiMyiZ3nLhQgEn7CgUSmpMRTf07A+kIKIWPYu2lhtpwm5KeAJ7lhQ
         EkdX/w7g7cqx45BEcE09pIpoPsSVmDPuscxnDDuYUHypIF8zg2e6QKCNYcedeMH5qXF0
         cejfkhX6NOzBrmubiseMxjtwCiwLOkfxXzRpMoKr8E9rcZEGMpzeJOhoDYYjA3BhCwmi
         7eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395572; x=1734000372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVNhBXCZHLlY4dxQD5hBqJ1+AxFtxhvl9sk4zboNcUY=;
        b=S6UjLg2fuazRi4rcYy75ganGWMCIYnHZIQfVmXKFGEJNOCKegbU3scPWzqhZr2hVrN
         oZ/eYcWSay/Esnvrx3pTTzjxwwykntX7WI0LH0Avg7rDD3N8cYlQRz7MHHp+3vgwWcin
         p8aLy76uQFVi3rdUxKqOT/9JCt6HFNhhgIB9l2Mp0UPO95mYL1+YRVzoFlR4QSrkhHfV
         Dk9DbZAnud7dHnuAny1HfVJMQb7MjaiErPM7oavnQ1jI2qQ8q5pQ0jYtaHil9t8JzkcP
         FoVaEM3hHOim1VmGhjbKIg7ml/ClJnUd8lUXmxLvUsWFxXNWxfvn01VP1u3Yd6g1shNA
         Q38g==
X-Forwarded-Encrypted: i=1; AJvYcCXhGFBY6Y8bh6eKXk9fXqEqON2LBt7gmOE1pjINZJAFNx0ev6qaD73qCHl9m04+0Se7PL0/gnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+t6dGqa5s0aRN/RVkQaihVkVTH/AvLbtA1fGXQMGDH1JrqeX
	6ZOWxYpWehHmlI7sIqJiw17MJSHggtqquXIS2sE0aq/pxavdPi5ryWfRTBqFRz6rcwC5swjxdfU
	tWRqVngdqygG64qaMQbduJ9f18O5vD5LmyKK/
X-Gm-Gg: ASbGnctBCohLoMYRLjWlRUenBceOMRdKR3F3LHVP1TgZhYm1w4Xu8/Pu/mx5WqDUUJc
	x/o806dXzjkQAXnl/uNNx5qdBeXW6LDmm1xs70fLh/Mtdvv8rzLAq7s1wN5qNpg==
X-Google-Smtp-Source: AGHT+IFR1pX3AvROCsYtcv9SZ2dU0xebTuhoeACy6GxIh+HqliCoQ59k6kO2zFvrnErJbjYAPkN4FAVr3UX5WjS9Bu0=
X-Received: by 2002:ac2:44ca:0:b0:53d:e536:c08f with SMTP id
 2adb3069b0e04-53e284b61fcmr915e87.2.1733395571039; Thu, 05 Dec 2024 02:46:11
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140208.2701268-1-yuyanghuang@google.com>
 <20241204140208.2701268-2-yuyanghuang@google.com> <7057e5e0-c42b-4ae5-a709-61c6938a0316@6wind.com>
 <CADXeF1GSgVfBZo+BmkRzCT06dSEU2CEU0Pxy=3fYbJrZipoytQ@mail.gmail.com> <617a5875-30ff-418e-998a-bef3c55924c1@6wind.com>
In-Reply-To: <617a5875-30ff-418e-998a-bef3c55924c1@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 5 Dec 2024 19:45:34 +0900
X-Gm-Features: AZHOrDmkYYiJ95uqo6en8G2yLV58MOdB061PcClxbzxQD0eIkVvjk1Dv-wub--Q
Message-ID: <CADXeF1E1Ms4=sbUVZWEJ0S4KyY5cyP7hdk2eFnfT=_t+UG=euw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next, v3 2/2] iproute2: add 'ip monitor mcaddr' support
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>It's not the same API (netlink vs /proc) but the same objects at the end. =
It
>seems better to me to have the same name. It enables updating the netlink =
API
>later to get the same info as the one get in /proc.

Thanks for the confirmation. I will use 'ip monitor maddr' in the next
patch version.

Thanks,
Yuyang

On Thu, Dec 5, 2024 at 5:26=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 04/12/2024 =C3=A0 15:48, Yuyang Huang a =C3=A9crit :
> > Thanks for the review feedback.
> >
> >> Note that 'ip maddr' (see 'man ip-maddress') already exists. Using 'mc=
addr' for
> >> 'ip monitor' is confusing.
> >
> > Please allow me to confirm the suggestion, would it be less confusing
> > if I use 'ip monitor maddr' here, or should I use a completely
> > different name?
> It's not the same API (netlink vs /proc) but the same objects at the end.=
 It
> seems better to me to have the same name. It enables updating the netlink=
 API
> later to get the same info as the one get in /proc.
>
>
> Regards,
> Nicolas

