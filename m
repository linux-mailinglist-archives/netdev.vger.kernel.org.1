Return-Path: <netdev+bounces-183345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D193A90729
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B70189A9CA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B31FC11F;
	Wed, 16 Apr 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SydVNaLL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84A1FAC23;
	Wed, 16 Apr 2025 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815688; cv=none; b=Fn8+5xITLoaqy0watWA4aG+F3nVlFeq7nYvE0/Ww9DTQQ1D9nv9LSyJMMxY+VrpqRw6pyuqRFXNmWJkkzW4LQAzMkZtApd2J3UwoGGYIfL+C3dnthG+QSsHBtzedvkygD0ptsu7iNlqlY1UVULz38XQHmtG4EVXIkEox4zB7VFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815688; c=relaxed/simple;
	bh=vl7iPlZCQbv2e58LMMtyYnM2QEyrQoMAueg8Yzr1VwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsbJ3UO6qM1fMVJYrrzFdb+pvaE9yr4H0NmqMN//8vjqUIVhoq60E6CTRjLUDqmrPtqSoHWqVJpsG+IoRHfvhEWgWuW7QlGaEieyyl8zSAy6obCLx28BNQAHzv9uUBJWG2wv+7bCwbM3T65dSqMVvwu5e6krBQ5c3MIy2mjL+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SydVNaLL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so60458661fa.2;
        Wed, 16 Apr 2025 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815684; x=1745420484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEA4bMgoWkNAjdVq+sKhszOqmVBDfX3d4YkLfqOPUFo=;
        b=SydVNaLL5Y2Du+6hQJ3P6yig6+Luj6eiWXQVBzKs17YDrM9Lm4hPNyVlwuqzQoN86g
         tHjrzUdEpBgr7HMrovqO/lXjd3bEtaA0qTkwlaCaLweQiW5Wwuti9QXpTUqLMasJ8NOW
         wBuIOPvdhMrxxegrLI0xD4urq077qFMliLVoGb0MNTsf46NVz0WHfrv3w86Wc/XmFnih
         L2Z5dqypBwB2oFfxfndaDnrg5kDldgqogELJk5qEPnjFgeBvHBUyOjuXQXiGjOIbTdR5
         xl4Gg0+QCl33yPtp/9PCP9j8J97GO0Y39vJ3meUpo0SMl6OpNzznGWCXTOgaFOMjEXHR
         FoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815684; x=1745420484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEA4bMgoWkNAjdVq+sKhszOqmVBDfX3d4YkLfqOPUFo=;
        b=vLBC1vWEeHwCEOXnziNWkyvvTD4khqjJq+CXRVhXP2jzXeS1Nveq5/+/9xLZ+UBbp/
         eFOB0XmoKSdVpadBvQ7ProG37GhT+N6mr88w9ZGr0gqDYQHrBPJPA8HBtaKCPtnL8ZKI
         Tybu84zCKZa7nNbyAp45M4W93V8a+4ksPpwEw2J33BeZ133gYtwTlGpUGT4EMi/99TA7
         lQoab+Qk9V8isPrkCUoALqfSuUORPj+MYiqtJSBEYMeelfGbXbbQXq6DD9Y/8vSSYFWR
         sPXV8D+LnE+FZPdITBsgMfy4IKF0npM4LvaOVb9irHOFcd5buHj3osf0WASZsoisONCT
         7h5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9vPiiKHzKld5A5rTEumVfsyNBhIb9+eP56/lZC440MqHIMlSVnyZJhaUUzRCEI5OEBy5DjbKL@vger.kernel.org, AJvYcCWPtuFElSJr1PTYv9uTVxV5TjZ85BdNQm3pZJ/L5hO1EWYk0F2vHVgx030QqQo7TpeCKUVkhzP9Iu8WBEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmwI++Isqi+kslMsDTnRKO1bd8UbB9o0+05vNL6U2WP/oGY9wB
	uJJqr61Sg5ed5qiYyXkbBMdiDYT/KCkIneoFGE6aEftWGDSZdMDtuKNMr38C6x0DOqYWHJiu2oI
	r2y6EscrKc6JneuLDmVjSvMDZMxk=
X-Gm-Gg: ASbGncuzEZRpO5kGlOq+m4P6FBjPqggEuyFFw1ErNAo9i1i7INHyk/t+MVJ4sN6OVST
	4wiixFm+k8gwYjEG6O6q7uDiTcPc35RpbT5BLQU3auW0a0NJQ19UUfkOEoKvjD7F/oi3lDw8Z1O
	5bEkFvGme+AD9UcgIoBsw/KmUbsDUEJ8OAN/7CVEW1TAqStdYuEoLPvwScUOo6JO24rw==
X-Google-Smtp-Source: AGHT+IHxPF/SyvfM4nKlYbpB7R3CCIgdNgXKO8k/2PeWF2tVp39aX1c6NsGRhUXtrCeIRNYx4l7pgCDsOTfa+nDbWbE=
X-Received: by 2002:a2e:9a0b:0:b0:30b:cceb:1e71 with SMTP id
 38308e7fff4ca-3107f6bf07bmr10316081fa.9.1744815683949; Wed, 16 Apr 2025
 08:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412160623.9625-1-pranav.tyagi03@gmail.com>
 <20250415163536.GA395307@horms.kernel.org> <20250415171927.5108d252@kernel.org>
 <20250416111727.GO395307@horms.kernel.org>
In-Reply-To: <20250416111727.GO395307@horms.kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 16 Apr 2025 20:31:18 +0530
X-Gm-Features: ATxdqUEJHVF7jhvx1Yuewr4b-DfNrQF96QOpK1ztbrFqXIqR6UoHQf3WrImSbOA
Message-ID: <CAH4c4jJpfztu9mEBv_p8ACOa=h-WSTa+vJ45U0GUZ_nf0WsiRA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ipconfig: replace strncpy with strscpy
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, skhan@linuxfoundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:47=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Apr 15, 2025 at 05:19:27PM -0700, Jakub Kicinski wrote:
> > On Tue, 15 Apr 2025 17:35:36 +0100 Simon Horman wrote:
> > > > @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
> > > >                   *v =3D 0;
> > > >                   if (kstrtou8(client_id, 0, dhcp_client_identifier=
))
> > > >                           pr_debug("DHCP: Invalid client identifier=
 type\n");
> > > > -                 strncpy(dhcp_client_identifier + 1, v + 1, 251);
> > > > +                 strscpy(dhcp_client_identifier + 1, v + 1, 251);
> > >
> > > As an aside, I'm curious to know why the length is 251
> > > rather than 252 (sizeof(dhcp_client_identifier) -1).
> > > But that isn't strictly related to this patch.
> >
> > Isn't this because strncpy() doesn't nul-terminate, and since this is a
> > static variable if we use len - 1 we guarantee that there will be a nul=
l
> > byte at the end? If we switch to strscpy we'll make the max string len
> > 1 char shorter.
>
> Yes, that makes sense to me.
> And so I think the patch should also increase 251 to 252.

Thanks for pointing that out. I appreciate the feedback
and will send an updated version with the suggested change.
Regards

