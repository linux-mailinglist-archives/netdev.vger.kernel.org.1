Return-Path: <netdev+bounces-149036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DBC9E3D2C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52671601B5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7906203718;
	Wed,  4 Dec 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5fPhC5f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2B1BC9F0
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323736; cv=none; b=RutNPFcsfj7BshzvDnZJRiSC448vKJ6sSoejn9Ac1aXB51qAMSeCdmA+RqGjjWM+mHYEg0xSlXPITg10jvSjmDeEiGPniq0LfGuXFaJ8vF0bPPuNul0dmIrjWRTEUna4So7auqxfKA0PwhjK9SqIENDvkynDrF4t67uwvHDFUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323736; c=relaxed/simple;
	bh=exNkTbJgEBjjF/1XzUa1Clyd15Medxdg99b4b89dyTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCgA5YJC+AlPDJiUiHj83r27uqG4+4g5+FuTULtNhceUNipfKhTpqVbTbHtB1OCgAUv4swDNTg6aPnqrh/6bAwWf8+St5nREiK7kaYB6qXoIJghrb3QcK4D9pzdy0Q09qWNUcIaf/2/NUMZapnzIYlVJSqe0m9ADNDtENyxyTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5fPhC5f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ddfc5901eso9e87.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733323733; x=1733928533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exNkTbJgEBjjF/1XzUa1Clyd15Medxdg99b4b89dyTY=;
        b=e5fPhC5fdThhIFaD/nW2P1mkTSjQq+aP892J5M+xl2O3vjPlHotfoBZULuDNFlFBjw
         7FB+jD24xoZBVrUaNcmYO6+1ylEQ+wE5L11tW3/ubEJgUhRzGzDdpGWqWoDvncvz8SaA
         JZdit1n3/3VBJ/536r3uN0T769KFsYSnF6bJOKU9ibNhsQovjKCD4e9f1eXYB6a029su
         ymjT1WrslaDR/zqAT3Tm6pjQJ7iTkCg4AEPLIs2yLPR4yqFAIX+qsfkNuK6F1j2ZSttT
         ISDDbKa6B100OPL6emQJQBxTts4po7QBaWUqH4GZoFotsF/6ClH9mj/5t2lmIrnGnuZU
         UN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323733; x=1733928533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exNkTbJgEBjjF/1XzUa1Clyd15Medxdg99b4b89dyTY=;
        b=RkywYdWNFk2alHvvipvegqhC+u/ga8iOaeOmNC/H87v+GIEj9g9UaMEiVVzg/7FcpQ
         tnSepNPPOxvFadNocsiMAWxlCagPTN1cIdJNx9TmMY1ayLi7xqJiI6kaVsA3BmwrK3pI
         ga2aYVlGtq8lqTeXZPM5o3t035V6cL0hC/4kAMerFBQzVbJab6EFJKB1j5t01FI/qjyu
         7i27NUX2JHZr+1L/l6XX/vS3cX48DMUSLanLde2VJZHQkplIc6X4lCG2j6jwjrMHcI4W
         6ofUpoaKbQVFln3bWOCOuM+zvN/TbxkEVwmcCZDfSWPmAfihkCMEFKyWHM1Q5DkYBd8n
         w+sg==
X-Forwarded-Encrypted: i=1; AJvYcCW6TzsxF58aTbEmwLlqAj84H9ymqGPtEbtG8ZyTJlhwlDtSilRa8wXZ+ZH8KfAET0IPau2IZmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPii8jbf2WEJMqUBRZKU1FvPoUE45dNnQh2gFlIUjzLUn7UFx8
	Om4+Dqdtr6Q30WDPtHBZUMcoWCX4qEBf2guX4WmgL5U8cZA9mAuqidHcwD8vxrD+VSLYfJNSkUZ
	P+GupEiJYnCZr7j+b/MqgmBPJMBPDYeZNRKPD
X-Gm-Gg: ASbGncvNQyMpdleOeAPBYZKzDBZCsil+TyS0EfV/wrNEzUTOu1Xn25JZJ5nnXNWxVEF
	aJB7iMdIxW6ekmNkwOmBwMn7oEUtiFtlhiQ1Di4QaclM+t+Oac43JPhrv2jwg2IRZ
X-Google-Smtp-Source: AGHT+IHTwaGeK8ug66PK5JqxNCfQyINVfppfW8hITLpxJV46Y/5CqoUKfS162sDG/pcbDw1/Nf3ldb3ENNdE1nExxfQ=
X-Received: by 2002:a05:6512:405:b0:53e:c5b:5752 with SMTP id
 2adb3069b0e04-53e20c1e405mr2189e87.0.1733323732248; Wed, 04 Dec 2024 06:48:52
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140208.2701268-1-yuyanghuang@google.com>
 <20241204140208.2701268-2-yuyanghuang@google.com> <7057e5e0-c42b-4ae5-a709-61c6938a0316@6wind.com>
In-Reply-To: <7057e5e0-c42b-4ae5-a709-61c6938a0316@6wind.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 4 Dec 2024 23:48:13 +0900
X-Gm-Features: AZHOrDkpQa5jqpVzZFVPjszcYzApHloRrCYLswgO4jgQh3N8OFfED6kpbP5x29U
Message-ID: <CADXeF1GSgVfBZo+BmkRzCT06dSEU2CEU0Pxy=3fYbJrZipoytQ@mail.gmail.com>
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

Thanks for the review feedback.

>Note that 'ip maddr' (see 'man ip-maddress') already exists. Using 'mcaddr=
' for
>'ip monitor' is confusing.

Please allow me to confirm the suggestion, would it be less confusing
if I use 'ip monitor maddr' here, or should I use a completely
different name?

> You could also update man/man8/ip-monitor.8

Acked, I will update the document in the next version of the patch.

Thanks,
Yuyang



On Wed, Dec 4, 2024 at 11:17=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 04/12/2024 =C3=A0 15:02, Yuyang Huang a =C3=A9crit :
> > Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
> > multicast addresses. This update allows the command to listen for
> > events related to multicast address additions and deletions by
> > registering to the newly introduced RTNLGRP_IPV4_MCADDR and
> > RTNLGRP_IPV6_MCADDR netlink groups.
> >
> > This patch depends on the kernel patch that adds RTNLGRP_IPV4_MCADDR
> > and RTNLGRP_IPV6_MCADDR being merged first.
> >
> > Here is an example usage:
> >
> > root@uml-x86-64:/# ip monitor mcaddr
>
> Note that 'ip maddr' (see 'man ip-maddress') already exists. Using 'mcadd=
r' for
> 'ip monitor' is confusing.
>
> You could also update man/man8/ip-monitor.8
>
>
> Regards,
> Nicolas

