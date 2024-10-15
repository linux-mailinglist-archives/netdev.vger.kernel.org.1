Return-Path: <netdev+bounces-135469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7899E097
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF58281D81
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BF1B85E3;
	Tue, 15 Oct 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZe6Z4Rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458B1AB512
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980097; cv=none; b=FtT1GGom57pjODK6D1C98ig0q+x8RQ0D+xMMtnHId+ic4C3tQubyfIWasl1u0qoU6O7n0vj9TWL7nBexENUqvvgDX66cFDCqU+GQelVyo9Ehy35BY/MfTTZxIK/Zsle1g8xuRS6wERmQntYYzn1RlhpJ7xT1qoyJ9zq2aCQf9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980097; c=relaxed/simple;
	bh=i39xkjqTD75qvIyEPcQMyfF9wlXhwyWTk+K9pkvMLYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAQO4C7bNWfzgQw3ErebRTAcHyKgK9NaBcaUUH3blgL+yQygNq0yIbsToJloY8ElBvzpmEQw7u4coJgjX/JYX8P8sLy4UtS8NU94PHOcRMHlL+MeNGu4mtXKph6l4KEhM9uO/x2PjvECUlXwxqCNgxuJhJ2kXe3K9A97FJxB1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZe6Z4Rc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7356199a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980095; x=1729584895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i39xkjqTD75qvIyEPcQMyfF9wlXhwyWTk+K9pkvMLYA=;
        b=fZe6Z4RcMaihpi0+6OKlDrOT2FNc5DRBbGgGBqwco4n7lHb2keqEG0UjrzeyEA70pj
         YbgqduF+TYNkJpELiS2Ve75SHZ1dGnqIgwHbFL2irnaOAwEyYgBmcS1yMimHaMMEhalA
         mbhPKX5iB7A0ov3SB4ApIwAPV/LAvjX9h5BxCjNG1c7Fd7yXeP3HluglJVQp8uV4TtOd
         rDMsN43/dp+gUy4k1y9Fz93qd2leBRIZg/WDBFn+G0Q9f5Imqny+zmiDiVw8gDIxg3yx
         d8l/ZeFT86JEmbzEy3ZUCuNja/d1t9UJj259nqw9Y1LCWH2BbHAlGoIo7EbAOWDkvm+4
         BdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980095; x=1729584895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i39xkjqTD75qvIyEPcQMyfF9wlXhwyWTk+K9pkvMLYA=;
        b=FxSkqQe7U4P3yFbg3t+Wwb9vnQbCsjG9UAlQPl5CfM2GfZLO6HfbEV84EUZXWd9Z55
         7q1Tm7rqyZlcP1a/EyOwls4xnsc0sligYs996eQoEbZS2cGzSDnG4rfzEhFSHK9xmyH6
         Ds719fxzSI7yFiCV5uSsJhZHW74wxqx84HWXU7BlSXGoyOaX5LO9uFtPXakC4oIgyl/1
         w5AozgbgC72vUe4JbAELDir6FLnFPm2qu3l4VOS6v9GW3lJV/tgqkk1ULZxIsYGW2QYn
         kjio16aM/G37EpmpZFBPCCU8XmTgZg9dWBwAfm7FmCnSZw0eIfEJktOKxlcnsxwuFkiE
         AZrw==
X-Forwarded-Encrypted: i=1; AJvYcCW/kyj7yk0/e5jY4YOSbOeQEyirN+cbBUxVnp6c99XQdFLswYxVlrD5fPpLNn1EfTHZW3GboG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMFGy5ct8k3o3r7RBKlAzMGP3w4PyD4vrGxQOU6nsQPxHFa4W
	7kI1zXwtTbrp1MuIAfQFysaRZ8KZHmGA6rWOhA35Pmom8b67VKo573rnCCZueBbVVvSESlDXPyV
	CvXSlyrzbe6xML2wTf5y08XsHLsiv70Q7RhBq
X-Google-Smtp-Source: AGHT+IHfDyUxCuMks1gEk1R8nw/Gw2OvNPCNkufQNVD1rr0FcAvB0n0vKPUajTuf0EONWf6JgXuQT+/jndnAD407yAs=
X-Received: by 2002:a05:6402:2683:b0:5c9:6c7:8b56 with SMTP id
 4fb4d7f45d1cf-5c93354476cmr21546728a12.7.1728980094340; Tue, 15 Oct 2024
 01:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-4-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:14:43 +0200
Message-ID: <CANn89iJDry=WnwPrVDEx9Cc3kswM9zuQfpyAEWA03_MpMAgs2A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/11] neighbour: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

