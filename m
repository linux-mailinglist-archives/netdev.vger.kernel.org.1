Return-Path: <netdev+bounces-71405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420318532E8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16A5285E24
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD157868;
	Tue, 13 Feb 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIuUG1H5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B556B6A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834039; cv=none; b=Nx+WoMEija7wK5DMChAB/8/fuZrecbc8y9gzx+3+Uw3jRx50jhnhgWXcnmV3dh3zzYt8GxXfx8VN4Sb4C48n74mwm0oKuCPPOj0yrqnNWbKFN0gVFp1Yy/sWrruJkBafvqKIsAWjJbaY1Q9bmr8htFgd1I3poUnc2+JIk88OEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834039; c=relaxed/simple;
	bh=RsDazqaypNlM1vbQ7cw3xGL/WfYsa4pUy1w99TNFZ2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4u/3JOn7fBZuFr3pFw5CO4DEdZ7qjWDA/3ZgVvujmHeykp6HdFTaVMawxvmlgOWtEGhw4kMGj3f/LaqJUXdL2YydzR2W0Koq39I8I3ZS0Zu7dsd6vAut5LVFzTn1YVA7s/k9p7nFg3a7dhP7ytS4RKufr4HUY6yxvAMyrUkQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIuUG1H5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so10298a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834034; x=1708438834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsDazqaypNlM1vbQ7cw3xGL/WfYsa4pUy1w99TNFZ2I=;
        b=RIuUG1H5oE8wClZQYjXgC5QowMpV94A9JYsmYWN4kWNFmmSRS28nOe1MKuJtAJoLbu
         KLwjMXGjFt03xf7ZjwhZ3m5STpFGxXyHd0NedFvvscNU6ZEYHy0mIM4IKINKdZdbv9aU
         i0CFSVxIuJZy48pXTWjR4rYe5EgNmjaRWdsTIZz1A66LOTPLcF+iN9b3XFzRffTEYL4G
         9D+nqrQdRGwVi0NGQHdMblFw70SW69GqQMAP1KOPNGrg4BWMKWBtY3i95v4+6ITCjoz/
         0OAO79W8+IhPjgg3AdyuP80Hl3Ucn+9tMxG+10BIyuHKhzEYZGujCdxo8t6LIE7R76Po
         xFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834034; x=1708438834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsDazqaypNlM1vbQ7cw3xGL/WfYsa4pUy1w99TNFZ2I=;
        b=MoeiNDezvVX5hMqwNmDzKvf9zo+r3oUAuJNExL2KDz/NeXBtYBOR/uSs3NbJPx+Vk9
         wri9oAm1b86jj/kxVaNao+WSdLwi9ay/+BhBisoLWlh9xWLfTFmVH69SK6zW69fz+EYj
         UBhu2AGjuMHYockMuOar2z3WBoAfJHC+ar1/IFsjjUtssdqC7tERLsOggPlpE6kviksM
         Kq7n6iut0VuyORqI6uBBJ9mkGiDq0AgzmRMRjjjyIbq8Qp0QoezhcPNeHLxguJJhKEZ7
         I+6QNCMCXZLTZeXRDN56qeUJCFVXqw0STvFqyvPyzDMt3RDWWSoMYnjUDF3Gx/Phd2Gy
         gH4w==
X-Gm-Message-State: AOJu0YyBrqIh9h/vd9xiTrnIYyuhpbjAV+XSeOCEysrIRtcryopnR03d
	pODCjWuCSkKUAg4ftNsow9f5oxZVf/247FsyuhnhNPN0vi84bNVwdpaTH0fCZKiQph+IbLN1np4
	g0iM2PdhTR5QwBaUwydnhndt+YQm57fM450pt
X-Google-Smtp-Source: AGHT+IGd+fHnXdZUXuiTRh127548kPjpMRwL2YEVwt0Re+4ygmfQI1BFZaK4QzH6+ESAtIZvj26zk+SNJE7JoFUXV7c=
X-Received: by 2002:a50:a414:0:b0:560:4895:6f38 with SMTP id
 u20-20020a50a414000000b0056048956f38mr118965edb.1.1707834033864; Tue, 13 Feb
 2024 06:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210125054.71391-1-remi@remlab.net> <9c03284dedb5559de0b99fde04bc3e19b5027d6f.camel@redhat.com>
 <B523FFF3-4D2E-4295-9D0F-374FF3359DF1@remlab.net>
In-Reply-To: <B523FFF3-4D2E-4295-9D0F-374FF3359DF1@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 15:20:19 +0100
Message-ID: <CANn89i+g1mJK1E_DkVfugt5VVOsHvhivngmUMGW9apNZtF+eVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] phonet: take correct lock to peek at the RX queue
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: Paolo Abeni <pabeni@redhat.com>, courmisch@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:55=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
> Hi,
>
> Le 13 f=C3=A9vrier 2024 14:12:57 GMT+02:00, Paolo Abeni <pabeni@redhat.co=
m> a =C3=A9crit :
> >On Sat, 2024-02-10 at 14:50 +0200, R=C3=A9mi Denis-Courmont wrote:
> >> From: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
> >>
> >> Reported-by: Luosili <rootlab@huawei.com>
> >> Signed-off-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
> >
> >Looks good, but you need to add a non empty commit message.
>
> With all due respect, the headline is self-explanatory in my opinion. You=
 can't compare this with the more involved second patch. Also the second pa=
tch was *not* reported by Huawei Rootlab, but inferred by me and thus has n=
o existing documentation - unlike this one.
>
> As for the bug ID, I don't know it (security list didn't pass it on to me=
). Anyhow it seems that Eric Dumazet already either found it or filled it i=
n, so I don't know what else you're asking for.

I do not think patchwork is able to add the "Fixes: " tag that I 'added'

And yes, I missed that the changelog was empty.

Some words would be nice, even if the patch looks obvious to few of us.

