Return-Path: <netdev+bounces-156726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C167CA079D6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A403A7BBF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1B2185AC;
	Thu,  9 Jan 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqAjn7NS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6A21764D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434599; cv=none; b=EW5rfAnIpyNefvqJbfSfuiazrkO8TpacOpwwlfHlzp/vwtljcnP6OvNZ+kYiQrH6ouVLbqXxcu4pZh4PHfd0vjrQ8jFvXlIDHeLR8OC8oK/P2JIgt1ygceVblvZzjEefiaDcbJMzXhieZ3/xhOnt6Ovju0Oobusu/o+f6UnaCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434599; c=relaxed/simple;
	bh=Wq1W5SdbTAgcDnemQXNPaTquQUXKrrFh25MbfnwDdF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3J6WjuvrQPDqmp4diPeH0UJbddmpYRufBpjcr/j6f7N/h2EqGxFklpTpSfg1LB5HTjbYsbaHeoH3UAuSddziD/4G5yqKdaJy15kLQAq6DhvtCpTEmhQ6JPmRChxdKQvBW3lMLmZ4DUQJa7WgzPUy+rhn0g0m0QvykGesz3Y6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqAjn7NS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so1374845a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736434596; x=1737039396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsVA5zcRNLnUHNShAg5rbAgv0zI23W1c5lFBP96eoMQ=;
        b=RqAjn7NS9guBu5mHD+6Av0ipiBri9/UDQJfSRXAbJ3hyCj+reGNW1YhGFBJG5Tqq94
         7qCWlb08wh28nVDAqqiwgUdNUhleyPVfQELXU5llHmHYRzhTNpCHonGQpCMNNHxXrWjs
         /jM1DoalPdhDdJzHIVPWx9D/qGJqRENRwqHDrA4fhCrW0QhhVmtX7vY9OIR0hWe2kk+T
         M40STxAzGO0h1zHFCrnD69qWGUZ8K/5RrgVsClyLthzbaGwggKTFPng8AbJRFWINlUHm
         K1iiyFhzsrpabIM4O6UA/f2R3upjXHFWhar7pbnoCG5gCOMVA96ONlzE6EE0b2Bprzgw
         iZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434596; x=1737039396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsVA5zcRNLnUHNShAg5rbAgv0zI23W1c5lFBP96eoMQ=;
        b=mkx93j8FrCZkLYrouJhrG6QGF+9nqy8VQhf8ZMckfWxD0mdHQ0PgiTwew/P9Slcz76
         55DXLb7O4WHYKogPGe/eB6mR3hVvGVyRq/RaZsU7SMYnszKHo7WYDoza/pEUA32ClYUO
         ZNiZ/zCrCtc76vUpRN8iYdvIVIiAKMIlQirVDXrhSg9qLOR5yH4PlWgYXkFi4ldK2lQ8
         gbKFudyY73s/z3Jc5/kgop8FB85tQlijCqd8mZfOtuCsgtVevNeH2ccuFVugezRkY/0u
         33n/lGHcS5UqdYJP8KgLBrHeFS4rO/ttEkIciUNKK2ZNW9ysDfHLq7McyYjfJDexBU9x
         buEw==
X-Forwarded-Encrypted: i=1; AJvYcCVz/7Cwk6shx36nukhw5vgbWQP7WIDBW1GZWdZSjAWFtQYEmnguhRyhpqvzeqh2OtZ6PYMkgkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBvaXPBjW8SVNrEjQKw7Bm9XPb6bNVnvWxb0TJxORdVw6eavW
	Vb1Mw2zqivhy0De4FQjo2W0X2qb5eYSmgnf0Id9SCNeuhFuOkcbJZjiuiu9VlfxBfM/Lljb2QCX
	KIags4AX0paziwuKNW6sSNVM1PZhAd79PfE0jBJVDqSWPnwQ4fA==
X-Gm-Gg: ASbGncvsxeodp80lEe8iWtjCHBEGHoBe87I6x6eS1AI71UPULjpbPi3PpKxuV9U+QyM
	MicrgR3ofeul6N81knXPNoBgJ6azmfbE19ft0/w==
X-Google-Smtp-Source: AGHT+IGFyAV7yc2JvyrclzC2Uys62am1FXdbTdw72OOQjGneO1VFYkCSEcMTBrBFhy3w4iSyWH0sl3YxQQRiOdKJP34=
X-Received: by 2002:a05:6402:5251:b0:5d7:ea25:c72f with SMTP id
 4fb4d7f45d1cf-5d972e4e6e8mr5724813a12.25.1736434595726; Thu, 09 Jan 2025
 06:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109142724.29228-1-tbogendoerfer@suse.de>
In-Reply-To: <20250109142724.29228-1-tbogendoerfer@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Jan 2025 15:56:24 +0100
X-Gm-Features: AbW1kvYsOQH25fjeTRYqNL1tcprjkMIKWtgg60XMQrxX9Vi-DZAin7bOZlWmPMM
Message-ID: <CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 3:27=E2=80=AFPM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> gro_cells_receive() passes a cloned skb directly up the stack and
> could cause re-ordering against segments still in GRO. To avoid
> this copy the skb and let GRO do it's work.
>
> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  net/core/gro_cells.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index ff8e5b64bf6b..2f8d688f9d82 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcells, struc=
t sk_buff *skb)
>         if (unlikely(!(dev->flags & IFF_UP)))
>                 goto drop;
>
> -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +       if (!gcells->cells || netif_elide_gro(dev)) {
> +netif_rx:
>                 res =3D netif_rx(skb);
>                 goto unlock;
>         }
> +       if (skb_cloned(skb)) {
> +               struct sk_buff *n;
>
> +               n =3D skb_copy(skb, GFP_KERNEL);

I do not think we want this skb_copy(). This is going to fail too often.

Can you remind us why we have this skb_cloned() check here ?

