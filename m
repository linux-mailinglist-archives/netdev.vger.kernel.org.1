Return-Path: <netdev+bounces-150921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79609EC1B1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE18284F80
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276B3A8F7;
	Wed, 11 Dec 2024 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0EQjfAB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD72451E2
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881478; cv=none; b=NSESfzo9u35UIr9r4mwyTK4WPRL0EQL01rp59bvlHfjrTFDND3NIlGllrHnpL7II5DczDdEf9Y4QK47gKqE/0vH7u3t0Y1qWjFa82ttvweCgV301anlgfR8mUcKh2e4tdIbLAQ+/jJu4xWCw0WIFmFsubDwWYCuUxTdpJsJB/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881478; c=relaxed/simple;
	bh=2rCReVUMGJ0g2/GRoyymGEfrwqH2WPfzgitFkta5nbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9abhGgjrzbWBIDAIvofP7qprA8mKGr6YgeqVcXyq4Wld6EH3iKikpTiO7JUptniDKAL+aEZRSZE9fyqujqDijkp9ZMLMVbPBaJVZp0tgiJmkR5Uep/JYmhCZGUkykHgJBcNxO/4hxJk67E+XZtUQSpu59KLacSRFlJS3PAsPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0EQjfAB; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a9d5a7ecc3so145ab.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733881476; x=1734486276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rCReVUMGJ0g2/GRoyymGEfrwqH2WPfzgitFkta5nbg=;
        b=S0EQjfABV/RZ/f0RddHhESyVxRn1YI33f5nrNGc7dE4MOa++TJo7oqmUERQHbLaHXE
         4/Wu7MUb78cP7EJcGhbubxGZQ9uNB3Y4rFzQI/ZzYXIh6idC9hISu4fA5Z0vJWEW+atn
         izq7Unuqo3hj9BkWbQ9tN78PkreFFM0M/hLE/qIe8euR+Hrbs10pULChjMUGTGNCff5U
         /MhRXgHVEByeH7P2OpD53j6p/5/MBCjZQnsxwYl5yCpeIccksxzx4iy1GCS9idMex7wY
         dEhobGrK71F9daKwIHmXdIPq+rbs9NasrjrSR/4opaPOBj58ertf1cOhCx8uEB0p+wBW
         Z58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733881476; x=1734486276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rCReVUMGJ0g2/GRoyymGEfrwqH2WPfzgitFkta5nbg=;
        b=JXrGsMc6mBBuCsUuGvfbgof3oELFWANzf0ixp99/BCxHo+AXJSxFwVuxhxsdypgbZc
         DNq1SgIEE7E1+KBZNXmHpP/s13dY7qIi0/7e1Na18pWt8woi/d/EjPRxD7jPP1S/Ck9W
         OU2crUOgwfKJsC+K0Js2e8fVSsQI4wEw+HP849jNyj5fgKxfeidtOqL0jYUzDxIunIgH
         NXfrRevEUZyEp28Flvu4+/KlKAsL2E1Zwwc9g07bhekvMgdHxYuB1L3y0PPufo8iCRSs
         u7H6h+WWt9pGQqe4fv8alqDHtQLtv023jWlrxwd6QhjtwucdbZGz44ebIhHft/Wl24ZH
         998Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIFJGWd0mqlCN/xOTd5b1Pba87u4ESNUD7tIFug5xfK2Eg5CB6LEy6b+IR0C/X2a6SQcDeyDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlYFU85F9p1UrNROZsIRZ1eH3BhHKEEYkF44NI6/wLNCWD0hW
	jItsGrHHb3CiOxueEJ1vLsFsZnmXvnwSp1O/+7I42SpA05nCB0uXwk6GjUkyloyfoRJ47goAO3D
	ZjGw7lPWCvSS9W+pA6MwDYdxqJFC1Q+6SPmRB
X-Gm-Gg: ASbGncttB3Djx0oiEWPyUDSzn6Wf/UpGRywnbwobzCB33Ec+yKAolWGviB8GHmK3OqM
	sqNkWSB16j+5zS4x8XDzyD1QKwqy9PMOPrB7KLjCkEtnRJOrI44bTuSoMe6i+y8B9PAoT
X-Google-Smtp-Source: AGHT+IHgIUlCaSckRytllOw1VFbpzaTh+/80yziR7q/Xmb+k9VGDi2X9upi+F9cSMbDIb5/8fLtXjq1G7w0wnZABZuw=
X-Received: by 2002:a05:6e02:1093:b0:3a7:d682:36f6 with SMTP id
 e9e14a558f8ab-3aa3bdd73d2mr394565ab.0.1733881475762; Tue, 10 Dec 2024
 17:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206041025.37231-1-yuyanghuang@google.com>
 <20241209182549.271ede3a@kernel.org> <CADXeF1FNGMxBHV8_mvU99Xjj-40BcdG44MtbLNywwr1X8CqHkw@mail.gmail.com>
 <20241210165024.07baa835@kernel.org>
In-Reply-To: <20241210165024.07baa835@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 11 Dec 2024 10:43:58 +0900
X-Gm-Features: AbW1kvZGxNtmoat3xNO5M6L28CiAjfyABhacfn8s5McTBq1vnYGf9zGTXWlu_G8
Message-ID: <CADXeF1GoaVbobrTe99R0FVUuxcWxxaH=XCOusCq=+vS1QvEc9g@mail.gmail.com>
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>TBH I'm not an expert on IPv6 address scopes, why do we want to ignore
>it now? Some commit or RFC we can refer to?

For IPv6, I think rfc3484 and rfc4193 talk about address scope
selection. However, I am not aware if we have any clear definition for
IPv4 addresses.

Based on previous suggestions from Paolo, we should make IPv4 and IPv6
rtm_scope consistent. RT_SCOPE_UNIVERSE could be a good fit.

Link: https://lore.kernel.org/all/1a4af543-d217-4bc4-b411-a0ab84a31dda@redh=
at.com/

>Perhaps you could add a new member to inet6_fill_args to force the
>scope to always be set to universe?

Thanks, I think this will avoid me affecting existing usage. I will
apply this in the next patch.

Thanks,
Yuyang

On Wed, Dec 11, 2024 at 9:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 10 Dec 2024 12:19:11 +0900 Yuyang Huang wrote:
> > >u8 scope =3D RT_SCOPE_UNIVERSE;
> > >struct nlmsghdr *nlh;
> > >if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
> > scope =3D RT_SCOPE_SITE;
> >
> > Is it acceptable, or should I update the old logic to always set
> > =E2=80=98RT_SCOPE_UNIVERSE=E2=80=99?
>
> TBH I'm not an expert on IPv6 address scopes, why do we want to ignore
> it now? Some commit or RFC we can refer to?
>
> Perhaps you could add a new member to inet6_fill_args to force the
> scope to always be set to universe?

