Return-Path: <netdev+bounces-170129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEFA477AB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26B03B0D27
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E157224AE8;
	Thu, 27 Feb 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlNuuFHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853822256C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644635; cv=none; b=Egehr7xLi2oKXzlr6XCKxEyOtSN0URriirI/vfP2N3zcmXrx+/rS1Cq8azr+zGJ9IdoKafZiEmAH031e2IMzCl+OOX7PLI1fRwCZiKn0jGmPsLX+EfSwOcirXy3SXN4do9jZSuAzAuS0pg6mFPX15+ve7x1P10RDSAV0GF0kEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644635; c=relaxed/simple;
	bh=Zteo2l4dqYLNSxyP664BkAgfcE1m1xZ+uVLxjADJ7+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXXGCPd9C4/+vTDTz9Glo1SlWAP2N/1m4WZ7WNzAOIXaRfa3SwaMHpNBRZlONAOwHOlo8mnaJxBixotZLanlURxAA31GyOEQssK/jNBZ3cUlY9jQFkOP13Ys1J2DWW0l8vHMmmXKZg+NfieYLXgvDhV/cdBHrvE3oLEB5OuTjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FlNuuFHi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8f6so5766761cf.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 00:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740644633; x=1741249433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zteo2l4dqYLNSxyP664BkAgfcE1m1xZ+uVLxjADJ7+4=;
        b=FlNuuFHiEDYKWSbnN8/djwDIkRloc+N2hvD/y/GdLGjpDSLvcKah7XA2KwQts6igFh
         Yee97+cqLOgVfN2Qz9Y6R4cOsae1bafBKRsbVFPpl0GyIo3GyPWzSmDYqYJ9ospJXGPV
         4Sa7HHK9rF1wGO3GOBtgEd3q+uJyufgB/jXAGUlVit9juC9jZ7ZMuiJOXc8YQ6WDA2Fy
         apXNNqYGcwzjLwJ0UhwwH7BGNIrF4DKEWQfQIloalumPwjheIBkzG+n7yOmSpgnygZDE
         AHvmy2DkcpK4WNIdEiBrJPGlw93a4uSYw2dsWsY2QxgIejJ+neLXhWXsZxomXgKRiw9f
         7o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740644633; x=1741249433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zteo2l4dqYLNSxyP664BkAgfcE1m1xZ+uVLxjADJ7+4=;
        b=UtuAaEGF7+CMeEdpBuMFXrCJYcf2JhL3E4mfDTLl0UMsMo3i4r+8jgUVEC0NFN+pMb
         cFl+6nriHoKEZmwHoB+vmBwWFxIyg+4fk4cgJBEpvmb+6vW6pX09QgmIxgx6kIdugSdj
         lBJ2hviHaBVeBVJb7WWnBEKMJ9e9vNoPts0qOjTK3YKMMRd2FhxuqEJnTl3zDbCevYLB
         /G7omtXqxcMzcmf5p9AZb7YlZTcGNMc6S/rYvaKQat440KVYwPaLtWtvoqLxkJ7NlNtk
         BnrsZO94YYD+lxFH9/7myiLVdVdjPNA1PgQuMhhVHlsGGtwbOFQpVPkEZ/+47eyGSlNe
         hZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUqxT4TW1SmFACBJfS9zE0dB43DH7WJtwBcHRndlZ9T/4vQsMZh/YBRjt0vLxkaveuHE8BYQ8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyks17xoz8ei6aGfBd5+/npq5XCT2OZftiE6+MGBhkO5Vhlz1YS
	04XbWf8lDK3KL6s/KG4ByGyFiIXJ/OMQptbBNVL7nSyqsr4Qsei/xVREQCTarFY5ae7osPAYMqI
	KRJwBiImrgxocBa6HwRZiuNIts3Coe0wxotfc
X-Gm-Gg: ASbGncvcH8X9vSWz8VkjxeLv6lR9QN9EfVhKrUn5sHgBM+90Q297Sg5quEOvbT3/i0+
	49tGpIj4qFPUEM0V9qqI8U/hqBVjWI5i6w0fpJyUA06xibe6aX+wwpcL/YlVn39qKDc3npmU4hH
	OCiB7YKHA=
X-Google-Smtp-Source: AGHT+IH98ewuMtamuZXaNWIk/Te5FEKizVKaxpFe3fIeA58sV+v0H1v4Qk6c+BUPcdraIlg1jrbBfb3fgHs8TBhhDU0=
X-Received: by 2002:a05:622a:2d2:b0:471:f730:20bf with SMTP id
 d75a77b69052e-472228c6ba8mr316474951cf.12.1740644632528; Thu, 27 Feb 2025
 00:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226192556.21633-1-kuniyu@amazon.com> <20250226192556.21633-4-kuniyu@amazon.com>
In-Reply-To: <20250226192556.21633-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Feb 2025 09:23:41 +0100
X-Gm-Features: AQ5f1Jq6Q_EWtu9Fh80F9X87jQVrds7t0u4YBUprF1eShkuGLce5DfrDfLiMCvs
Message-ID: <CANn89i+851PahsD9TLpqfWqmSLsG0nc=8sSD=0AQQgmRcp4zgQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/12] ipv4: fib: Allocate fib_info_hash[]
 during netns initialisation.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:30=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will allocate fib_info_hash[] and fib_info_laddrhash[] for each netns.
>
> Currently, fib_info_hash[] is allocated when the first route is added.
>
> Let's move the first allocation to a new __net_init function.
>
> Note that we must call fib4_semantics_exit() in fib_net_exit_batch()
> because ->exit() is called earlier than ->exit_batch().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

