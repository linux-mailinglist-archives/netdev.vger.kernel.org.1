Return-Path: <netdev+bounces-215036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3DEB2CD25
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161DE1C249F9
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B212340D8E;
	Tue, 19 Aug 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmMWyOV0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32533EB1C
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632642; cv=none; b=bXamB0d90Fp0IiPGQf5unwKZ5qai4UI2jpP/n2vc7J6CF7zF3JTzZWUO0uO09YfC+g6A1YqntrmNbPedN4xLcEmmZW4mLywlbSGtOYeBtuMAtwyNRgnfiSTjbCkn0YB2Yofzy4L1/0vvd1uJW3Nxg4sf3pDg6IoKY9c6NoTG4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632642; c=relaxed/simple;
	bh=zat7NJlmUUgoU/fA5UVQBv+E1bcTWYWMLkGLrDLXRWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be2jICS2eiHbSJJgubN0pizZkQOeIzYCMUY6y1lzXuLR3JP6gRZYIvtOqi0HpSqVRU3xjt7RpDbc198HtNWrrso7Yuoss+Pa9nRmAb9X1SrUOFgZwf1nwJNRH0pQDf4whh1MGsjiBzbgZ9nDwcfwWER18M8XyJkLzkWeKnzAgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmMWyOV0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b12b123e48so59761cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755632639; x=1756237439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbRKg2jA2OAQ/GBAnIjxqbjjLFTiafS/NzVrNjbA9ac=;
        b=lmMWyOV0zjPpHYfAsJDNe/t/tNnkHKl0I7KceXdBHEuIyKvDNPdeynikZQ8+gueufX
         bBNWkVRHgUByt32ASbJanra0T0cqZT5YlAT5ZoK05HLXkTxqJ8QU0cOUnPbonB7x8OAw
         2rHncC2T1YxUK6QFt2llPEYesOW5cWig1XqeCzKgXWEjmN3GSgzlOidTCZcVStOoA+RM
         OtJGRJQ2yxxB71QGj6Bio9gBcw6tNuz36V/g0MvfH29EYC6e7VeZh8UN4wr7zHvtymI2
         uEj1VQ+t8atczvgZMSpGi4eJ01MV4JmJC+kcdzxCTOQjOAwvBsGWr+K63uKzjm/Mee7I
         rqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632639; x=1756237439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbRKg2jA2OAQ/GBAnIjxqbjjLFTiafS/NzVrNjbA9ac=;
        b=A7Nmm1pI/y/oypAOKaf7MTdKWLGQbt6l4D1wEk+r+i7YGmouK9hWklKkWyYuMJ2wAr
         OwSFYQ8lvxtxbHS4gbGiiEyuX7FALmpehiMDt1Q7gvzRCfcFioSJcNGr26Dy0VPlz4FF
         J9KAEqGP+yzT5XKx2C/id/I0XQ3XMDHkzvwX7in6Ns1p/d1KpHAeUOO7zkxbvHUTOs4C
         6xkSOJegIWqtok1UUkOzxHLTmRQmBP7i11jRYyOLdS7qyTIeP2p++aN+++bA5AZqU9YY
         i3uaoz1fMOq5fuuQrOiopUjxC50bul6aqWetuikk03izvCSD3sBcfWVPCi8pCl9AD7nY
         lOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUISZNsQQjhHVenxPmQ5nj34J/IjlyaO7HWfu+nIxec5h1dqzK5Kc3FYQVycFN1qEfh1X8r6ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvDlE04DRG5CObO0pCBF37EVkszabjqXvcMe7mtZp3awR7g+R
	g/iTQA3zXKHMRnU5VggVb7LOoktWoI0UEUsm/7hc3yYdLUzle8iE1dzgtmEoZG8wlGAK1ck19V+
	QVLuzkvTIAm/9FK+Uo892o+ioNePlzW4oe7MqurF6
X-Gm-Gg: ASbGncu7qvpBqx1pORKC7hKv69ujVDJnNjgEbcnt62uYIFwJhWvNAJgJMqrREtOYlg4
	0OMmsKtEOQJknsj4KmI6fQPMcH7bdyqg74Rfc8D54hKcVnm+WPBxO1LTkQPVuaMAgxZrYf5oWqs
	0Hq7zF1xOE9w3s4TnFTceoeFb+7sDf5s2s9Uc5EzaRWlkywfACbTPzvjkaD0WEZhFqvO04dinvg
	fVpIUlamyQZdgLbAIdly/sqv2UPTLwV6yFcx0hMAhI9OJq30wO3sQZQpmnFEs9Djw==
X-Google-Smtp-Source: AGHT+IFzbmgTMllsQwidG6Y92/6CAaMpD7aJeIN5NSqfB7vUGkLJw6cipWLEHY8Trox0LsgRl4K4iCsM6CobCLztYvE=
X-Received: by 2002:a05:622a:114:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4b291b3f5ebmr783351cf.13.1755632639143; Tue, 19 Aug 2025
 12:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <51c3dd0a3a8aab6175e2915d94f7f7aece8e74d3.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <51c3dd0a3a8aab6175e2915d94f7f7aece8e74d3.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 12:43:43 -0700
X-Gm-Features: Ac12FXy7pxgC5oceITb1cGTDtOFx_puzv-LutwCFhZgB_W6rHbLPop9FaZfQ_sU
Message-ID: <CAHS8izOs_m9nzeqC5yXiW9c1etDug4NUoGowPzzPRbB4UFL_bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 08/23] eth: bnxt: set page pool page order
 based on rx_page_size
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> If user decides to increase the buffer size for agg ring
> we need to ask the page pool for higher order pages.
> There is no need to use larger pages for header frags,
> if user increase the size of agg ring buffers switch
> to separate header page automatically.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: calculate adjust max_len]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 5307b33ea1c7..d3d9b72ef313 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3824,11 +3824,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *b=
p,
>         pp.pool_size =3D bp->rx_agg_ring_size / agg_size_fac;
>         if (BNXT_RX_PAGE_MODE(bp))
>                 pp.pool_size +=3D bp->rx_ring_size / rx_size_fac;
> +
> +       pp.order =3D get_order(bp->rx_page_size);
>         pp.nid =3D numa_node;
>         pp.netdev =3D bp->dev;
>         pp.dev =3D &bp->pdev->dev;
>         pp.dma_dir =3D bp->rx_dir;
> -       pp.max_len =3D PAGE_SIZE;
> +       pp.max_len =3D PAGE_SIZE << pp.order;

nit: I assume this could be `pp.max_len =3D bp->rx_ring_size;` if you
wanted, since bnxt is not actually using the full compound page in the
case that bp->rx_ring_size is not a power of 2. Though doesn't matter
much, either way:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

