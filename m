Return-Path: <netdev+bounces-166041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FEA340A8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52C47A4D1F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D924BC1B;
	Thu, 13 Feb 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqJ4TJSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DB24BBE3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454259; cv=none; b=PSPPl35Qs30eXxcxRTH1wPmTaB1KU7AkIGYJYpNy7E0qNRfumxy615izqg7fgcEonpABruTq0S2Ob4rB/fBg+zMxZ+stHeqMdBJ+Y2G0Eqvpljrwpsk6WAY54+67yeMHzoxDu7G6X0+9bFi6heiqlFZda1NP6JhUiKcu28KHy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454259; c=relaxed/simple;
	bh=KpHS0+Fx9Du+71+rV0jLhtAJFG0Xs9ubHzrmeYJZxRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6qQcMKbwtuyKC5g0Y6M7S/Dc/QcC5+DgGOp+8fm/dWMC4g/sjAiOYOuNcwH7JEzGgMJ0twbBIkqlp6d74XDFLXId1oZwVcYTE3K8GMFWv4N4mP+90QmZV22HiTUe3usb6e6Qx50Kf3oP+6z4ZrigDKg5BYqnMlP/uUGD4IgLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqJ4TJSg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so1430113a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739454256; x=1740059056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KklhPmutUxCxNcylmUDfq2OUN7hQopJjZ7Ytt/38sBY=;
        b=JqJ4TJSgiqMJk19HJkeWLeb2yfz/nlDlsjW2ZDwUKJqIPmajYDxbhSaJ//HcuHwAMO
         YRp7BAcYkD5Yd+7xAb943HQJtiVeA7g1UvTaWlArUDhgB+AE7y5xWGOP+R6ovQ0HiObp
         Yv16z/18JvKxQ5q10UQddapwQsXWmYhQfD0I1fOxUJMKiLPwKM0qUq0dfyrlMikxv5MS
         xFRifpPhyVYGaTiimRMYMaOm4gEhlx1qLeLMLryHNCaD0uOoS1kAmwW1liT4X3mrK2+6
         2PQcN8t6VqoMl6StpaaEU91zprVvdVLbkskhIIK47o3xP0yXQYaUOzZPmmfpuH+VR5u1
         6K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454256; x=1740059056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KklhPmutUxCxNcylmUDfq2OUN7hQopJjZ7Ytt/38sBY=;
        b=BO7onOgPjbpD6N04Plxmsd4WPfPkyY+ogksMJSwEtbxc4fu8MD42s/EU5zLVuk55fE
         nB3S+UB5codOhrZ2o8cHYw6VDIuPMAzHYiFp/ISkRV2q+4h8YffYjXrNQMRluSjlWZpM
         dmm2EyLHkMO2MP4mawlMIbTROMNtjtZ/GuefwSo/IJXO/nRDmethfn04/xDAXEn+mcf/
         ENIKLvZGxsVRxXJJTfueh0TjySvHswuLdLbJmAVZl0YvOH4pMwYsw/7b5wF7ftWQ6QKG
         j4m4WMiGXNPpyLsO8VS1g2tnjHKsQzd/a49DZvHv1tJY79r61XfhiDrCwD0rt9+kitkA
         HN7Q==
X-Gm-Message-State: AOJu0YwFn4tUmDJCHFJ3IJ8lcWQ0diNmxA1UvCfu+oK3Djftaz7FFCbz
	ikkz4e11o8wzkIUxEQak5rAfU43EGuAw4kfoXnTjAv05x7L52Z7eGv+8FVcuzlFKKxxcSXFmG61
	BPdlnzqYQc5RPUB2Y517tRX+1TYBwiTvbAmnyXytn7Mvyzm1/1oy4
X-Gm-Gg: ASbGncszzOyoVA9W2xgt14WBIQ8oAsFs+zaH0z+0AorDqkDIHO3GS84K337dgeiU/RK
	H9Ruiz9Va93o5uILs9jN9J3mxRy1EfjDf/pv2ix3FutgWWfhJEy4OGqvfMRoft/9gtScRRCdGgQ
	==
X-Google-Smtp-Source: AGHT+IF2xHaG0ugK7rygEYC7Bh6H1UxuTt/9uiIHqimVqrQRiqThjM3/nQsW081sXV/+3omR7NYDEyG37qjUwQ7iMTo=
X-Received: by 2002:a05:6402:350b:b0:5de:a960:11e0 with SMTP id
 4fb4d7f45d1cf-5dec9ff9de2mr2476048a12.23.1739454255689; Thu, 13 Feb 2025
 05:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com> <504a90ea-8234-4732-b4d0-ec498312dcd9@redhat.com>
In-Reply-To: <504a90ea-8234-4732-b4d0-ec498312dcd9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Feb 2025 14:44:04 +0100
X-Gm-Features: AWEUYZkmfpxxiya3eJMZx9eIQyfeIUwYrKgbEOplLd6ow1rFsL36n_-ds6wrCt0
Message-ID: <CANn89i+us2jYB6ayce=8GuSKJjjyfH4xj=FvB9ykfMD3=Sp=tw@mail.gmail.com>
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:08=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 2/12/25 9:47 PM, Eric Dumazet wrote:
> > This patch still gives a warning if  MAX_TCP_HEADER < GRO_MAX_HEAD +
> > 64 (in my local build)
>
> Oops, I did not consider MAX_TCP_HEADER and GRO_MAX_HEAD could diverge.
>
> > Why not simply use SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) , and
> > remove the 1024 value ?
>
> With CONFIG_MAX_SKB_FRAGS=3D17, SKB_SMALL_HEAD_CACHE_SIZE is considerably
> smaller than 1024, I feared decreasing such limit could re-introduce a
> variation of the issue addressed by commit 3226b158e67c ("net: avoid 32
> x truesize under-estimation for tiny skbs").
>
> Do you feel it would be safe?

As long as we are using kmalloc() for those, we are good I think.

With MAX_SKB_FRAGS=3D17, I have :

# grep small /proc/slabinfo
skbuff_small_head    276    391    704   23    4 : tunables    0    0
  0 : slabdata     17     17      0

