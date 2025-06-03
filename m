Return-Path: <netdev+bounces-194750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5BAACC42F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0863B16F7B6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA361D63E4;
	Tue,  3 Jun 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px+wcPLy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671341DC9BB;
	Tue,  3 Jun 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945665; cv=none; b=CAM5wjHKZfam/5w12CzUldfq87DFv7eSAP0sE9fciGJc7OXTfOy8pqkhJPuDslWYOCMx+waKyW0aW/y3RDceBhhWdsv59lrZTm0oy2eFpH5U0bUn8tH3W9ouzBhHJigWVLrdIePSYwe44SaGkCVZN3z1D/TkZiVKq1aSc2D1d8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945665; c=relaxed/simple;
	bh=SwDfqV8KrvkovA/Y/yyycICdpiYK8FWzTfV8vFk4lOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2sFBRUdoJG+Cx/x5kt2s2d8Bgc9SapD7AHOnQVXA74MQL2QxatH4AnDKop/9kQKHH1KZ/UlSw7uwXTlyMwLZ3cEoCRJzx4oi55z7sLzP0mU9rvnCrpxU8Q+6+aXi1UVzMF/sNnXvbYATPCRRciLqYm/rSn2i2Ze8WE98jZeAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px+wcPLy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so5826054a12.2;
        Tue, 03 Jun 2025 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748945663; x=1749550463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwDfqV8KrvkovA/Y/yyycICdpiYK8FWzTfV8vFk4lOk=;
        b=Px+wcPLy2yJFKqKxVgap8jU2qjDYx20ld+Gjkx6gIY2PxAGNBCFZcRBPy70RtFhul5
         MWKVIoNJvdoZdyZAOxLgA318WOUmmg/bTgMKHh2qoiYNQeFOnLfEQHvZYwT+54ABXSHR
         7+/ySlOPKK7KiEunuSz/ZvOfbBw4tSupsUEtX7Lh2Q0CoeKzg+WNSKb62y4Z3DEgoD0b
         oLctbh6auL4K3Gt0V2+BF9LCv5FlmdIAM2XhpXlWosBfquoaj7wE6mrpX0qS0qW8Cm5O
         4UtvvA2UOtt26QzGCB5DecjUDja5BfII7nr5K7MCWkg++dwu+HkZ3M43E3EIdvs/1Luy
         maUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945663; x=1749550463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwDfqV8KrvkovA/Y/yyycICdpiYK8FWzTfV8vFk4lOk=;
        b=cnA1ynMGh6I3fsdeeUYK4+hqT+6e0SvrYasHZmhoD8FKpjYxlMcqsgnsC5pyP6Rb5U
         3pzQJOBX+SsokXCpZpN9ZaI4UaHhghH0HYHCRfkYEgnAbM7XsvmodlWy+JAKqoZSrvQu
         5Qv/NOW9mBCixAnsTp6mvtJ78XbzQqsW3Mi5qFYwHWegx0IpgkYl8ZzL+DoGU4MqgXKZ
         Oeq0tUWKEltSrYZUGPmUQ4lFdtlO4IHZyyhPSdcOq09Rjm1HGe1Sc6XlRz9aX9Pl7r2R
         u1xLSbq1o+h++onPSNdzzYNBV9Dk/7W1O8NaQ4+jcK+1FcAXa00kHCzj8ihzmaxBAozu
         S+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVP5fiyhpJBaOzPkjElHcEroaHNmc3qLE2VmT3oenZi7aHf89fBQEvSLASgUQRRpd8p6iUsYWnmHA+WC0c=@vger.kernel.org, AJvYcCWhRTFrT/bUN6ChMW/uhJrmIUx/Nu24GT/p447DxXoCjogHouv3e8ZWIAQQPeLh393egrzDi2tM@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkXoSUVHaKmp7E/DXWcdvX2g1VjxYJdCs8zUDnWabGimu9eKV
	AntxtRpPIX9VBa6egxPY25/ia4qbDBuU9Pdxx7R9su9esdzIb07EXfX96wywsAwfOJrt1yqHMgp
	tVI0d/Z/0ZamPe6d0AO5iOZmK+e9fDXw=
X-Gm-Gg: ASbGncss8ZDNd0v5C35DY4M/O2z+AoacK2sUMc34oOnvu6KnReHodKGb3QAki2+py8q
	KD4ZiQBExL/Nz7k6DvVQJTPe+pbKt+EVjUr+kRjayCDuvyH+D/4vcNbiOawm9uBrMCv6Qxlm5+j
	OnSasA4vaC/d0gH2K6FURCYzhHsLIooAO8uJLAS1Tj0O4SzWEtVkve09R92JV4LVTj2Zk=
X-Google-Smtp-Source: AGHT+IFkU/rtMFcEfCGQgAXeoinXY072kvOEm9KaFp9HZuJsqzno0tiN7dudO/VQza3ZbsxxGjOBifLpqeLSLv0S20M=
X-Received: by 2002:a17:90b:2e50:b0:311:cc4e:516f with SMTP id
 98e67ed59e1d1-3127c870734mr16735156a91.31.1748945663531; Tue, 03 Jun 2025
 03:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-11-noltari@gmail.com>
 <d7dd8b1d-0e36-43e7-abc1-74a477dba06d@broadcom.com>
In-Reply-To: <d7dd8b1d-0e36-43e7-abc1-74a477dba06d@broadcom.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Tue, 3 Jun 2025 12:13:50 +0200
X-Gm-Features: AX0GCFu0OsjAe-iuIqR5ud4LbDYOnjGFk-V-K4wXs4u7V24gNhT8oAGJQ2GoTXw
Message-ID: <CAKR-sGf7tfLY3DpMCce1MaL-dAPejN2x3G=0BS7e+skmMdf3tA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] net: dsa: b53: ensure BCM5325 PHYs are enabled
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

El lun, 2 jun 2025 a las 18:00, Florian Fainelli
(<florian.fainelli@broadcom.com>) escribi=C3=B3:
>
> On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register t=
o
> > disable clocking to individual PHYs.
> >
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>
> Would this be more natural and power efficient to move to
> b53_port_setup() instead?

OK, I will move this to b53_setup_port on v2.

> --
> Florian
>

Best regards,
=C3=81lvaro.

