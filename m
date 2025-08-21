Return-Path: <netdev+bounces-215844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65254B309D8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AEA6225AA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13A278146;
	Thu, 21 Aug 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1+wL8hp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710C18C933
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817741; cv=none; b=l1rQqQnPLiWLnTOYQk7Au1er+Vz7nKCDEeXI9lO61UnFIhdKKIDzup21EQOO0ZiId2YIdcoUAhPIKAkoxwDrHRb55ck2yJkHhe4nrLfNVjb94wZ8TKBzNn27I4R3T7TRzEfgta9mqMtmnGHzXr7jeMvIO0PwqyBlnDxcKGLjCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817741; c=relaxed/simple;
	bh=Y5H03yME9tlnPLL7pIW9/OtSVagb7ZuTcfQ9D/jsVzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/s+MC/VwEX/buIXyv/PZFYRgREpVyfSdYcCW+pLy/N5YFja5YYKZi+2m/t+8VnMCB3Gwd4KxAjDDsQjGhnkgMaZ6RnqDjKxrDyZfzLi0ZyeJdD1Gc+9U+FYwTIGPVWQj1xZhsC/1dvzRNas+n7rwUJd08yhlqCXWzSi9RL24Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1+wL8hp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459fc675d11so13915e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755817738; x=1756422538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L77xUDEmyoLvrX97o1nUFPtOyxF9ceXHsdzlmWuagMQ=;
        b=f1+wL8hp10nXEpikMhrN6pPpEwGZ86riTLt+yad4l6gSVC/di9lH9M+OfAf6G5kqbc
         uxtALhJrHW49d/0AeiIAYJKQPOAaZB6GtfvIRTjBp/Vyl9mLmNylYUtyVR/If3KOWYuo
         EmalhNWSVwEFLXzqLCy+V2rjy3AWRxrRvCLEUMgEp4PMTMjEowIktiHCmH7XIKPeHpGX
         97dbeIw81IbP2gHvKLlArUVyG2hPK6OO9/gmt2h4aNiaQHx5pvksrtJ33iYw0eAyb63v
         +O//5bDIzzPLynz2iKo7JP1lZlGPBtWi5hoOahNJzJuoupZVPA2HcUI+HAhC3Wq8FZuq
         1zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817738; x=1756422538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L77xUDEmyoLvrX97o1nUFPtOyxF9ceXHsdzlmWuagMQ=;
        b=meVcKGZR1fa7yhr2QDEbavBGiHJO6SbfdTjEY2KCT04zCglfd9O9enbYWmAiBBBb/O
         lHkwhVpgKFUqQfKNqG8gZvS1JxWF4ET63phQ8+2mH/g6kB4pzQqnvCr3o0iTNaWFUyY0
         55yKcDR5fx9GvEAnKg/Iee22lh6bE7bpWN1RzwKhfci4Y5VMCdRagciEAu52oMpOa8Te
         QIf0YO+1l3uRyirW6Zdyk4FpApVZ3R1D/fz4vKRFQXYbqwFVPxlwxNDQiEOTrNgBOInZ
         G8Gp1CCiWcvToFZJO8APYHTj7lf6UfBGVWMxRxoCOmxNnMu6BxZXDM8jaASJzS1C9aTv
         eKgQ==
X-Gm-Message-State: AOJu0YwkvvIXqEXg3IP1W2CZNzisaHCBSX4vrgONi22MfR5Ws6F68jC7
	wqY6ioQ4GnyaPWeMl0PfaFQcDgDMdbyUDTAy1dz3yzTgMUv8EBFG7rO73q/VZewhTUi/5DBJZQg
	q7C5NRY026oIa1DKVQX7SQ6cL/JbaO3QcnlsJVFdL
X-Gm-Gg: ASbGncvuMksIQK18svsAyFh4oQWejCNMkA/qygiJTZHuzk3mQPVhKmOsDEKLoDX0JJf
	OuehyJ/331+rSJVP7Or8nW+y2e3UfqnB+3O6WTW6TCeZKNw1+oBw/9zL2Ai8kY+ylXkDf5mmHl5
	JKfTCSwxjXQcWUnQ4v0K4tS+JN2fxDJAbC+dtHCEGqFVIC41IufwNqzicTk84YfcYmJ31ysW/0e
	Ry68+fs0eQpmdQ2+SpYGSQm85OwJRLGA4QELes7s6cWs5U=
X-Google-Smtp-Source: AGHT+IHqxqiVwocOp0r5efeFXaRCBSd7tvJuGa3xj5Uo4LzMOxVOD2dlJdtT3gkdTDsuidX4F2vR/Ty1h77VkFuwobg=
X-Received: by 2002:a05:600c:8b01:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45b52119c8dmr234265e9.1.1755817737631; Thu, 21 Aug 2025
 16:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821030349.705244-1-almasrymina@google.com>
In-Reply-To: <20250821030349.705244-1-almasrymina@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 21 Aug 2025 16:08:44 -0700
X-Gm-Features: Ac12FXyYskNcdVHna1U4upva43G1arYBWxE-pS5te9bEvcxkDP-4_Li1vcDBayc
Message-ID: <CAAywjhQ7ySv_Bu4EFxxYnDL5Di4ur0wbFYyVR0bKP6ggMfdXHg@mail.gmail.com>
Subject: Re: [PATCH net v1] page_pool: fix incorrect mp_ops error handling
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 8:03=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Minor fix to the memory provider error handling, we should be jumping to
> free_ptr_ring in this error case rather than returning directly.
>
> Found by code-inspection.
>
> Cc: skhawaja@google.com
>
> Fixes: b400f4b87430 ("page_pool: Set `dma_sync` to false for devmem memor=
y provider")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>  net/core/page_pool.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 343a6cac21e3..ba70569bd4b0 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -287,8 +287,10 @@ static int page_pool_init(struct page_pool *pool,
>         }
>
>         if (pool->mp_ops) {
> -               if (!pool->dma_map || !pool->dma_sync)
> -                       return -EOPNOTSUPP;
> +               if (!pool->dma_map || !pool->dma_sync) {
> +                       err =3D -EOPNOTSUPP;
> +                       goto free_ptr_ring;
> +               }
>
>                 if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops=
))) {
>                         err =3D -EFAULT;
>
> base-commit: c42be534547d6e45c155c347dd792b6ad9c24def
> --
> 2.51.0.rc1.193.gad69d77794-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

