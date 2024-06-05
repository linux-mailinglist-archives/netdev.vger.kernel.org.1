Return-Path: <netdev+bounces-101079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C58FD2F3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F81C20B48
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11661FD6;
	Wed,  5 Jun 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkBmNAha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AE3BBEF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605068; cv=none; b=rfjIncg7UxdUcTAURwYmBZ81iSm6adbAQ9FoNEo6BS6EXqSNTP5ZG/oExGCx97h1jFUjzbjnG5Lfy2ow5Flu540KWUnEXjXVPWxi9wJS9XdGAKkNokq3GVjCgn3ACVNl37wxGFDS6l1SsphjfFdVMnM5PAFfbZuMauUKds+ZiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605068; c=relaxed/simple;
	bh=yhGpvjqbeuSwV7lXibVowSKDmnAo86JFfhCCtodgLvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUmH7Q+ncdlZNp5tOvijTSdvCbkxaLy4sFboHQ8XNzDtIP/Fim12J38qiclWEJ1JtYa0LxBweD8ljELKUXm4C1rT4y2xVWoPiuVzSP78ezehUZ/jlQw4pm9NOVHsWi6X/2UiFlPTHbxR9zJco3HcflLW6M9y9o1ilAFSVLO+Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkBmNAha; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6269885572so200658666b.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717605064; x=1718209864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQnCw54eMmA3H32Op6/EczJodEAQxrcR34/bUU4xRqg=;
        b=AkBmNAhaQ+PnLxg+/2uRNEXK6pmfuT/N/5hCFNcIC82PCScg3ilmS0zUqzsapo4elK
         gF0wCXbfhgtj1PKm4Vh0qhndf+m0oUqKxo3Y8H8Htz6UyX+oEhJ8s8GjBt0hnbUzx/eR
         d65dDgR7WwmyEZl4kO0yNKCfRJdvHAbt24H7tBQw9x06OuW3rWeI56GyfRYuaHy16qDs
         EQ0G+IB978wsg6g6G6pYfbMZ7VDWjlwAQYDvPY+FYCcwtXrOQ1uUEle0IfwE+sq2WZRO
         5psC4HZyHuVaaS4YjOKp+yW5wnHlnBK/w8Vh2udRr/h8v/5vigiKUzgUZAcySPCkNcd0
         V1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717605064; x=1718209864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQnCw54eMmA3H32Op6/EczJodEAQxrcR34/bUU4xRqg=;
        b=XDpSu2iezS2XDEAbG7lppnqYSzbHfyapI5uTA250EYWANNmUkgrvmpv/q5QZm4GOJ/
         Os/puj8wlKC8wfNbScdHVqMQIJsfjP2jB0u/JRiDlqu2u4vHtXLUmkj1LTf5/my3FFzZ
         8DNp1t5PC6+2+14pKU0KJeoj/XuTusaiXtR7RYyxV5TAOvM20XNndeBY8reRDXeubi30
         PsnNVvwH43r+A/KiKkxk21v6JbL9KFSmEE/gewMByEJ2XoLFpOaZXGQ99wFii6x7ddW2
         b+D4qhjS2Ovfe57xsZJBWRa7ObHg+Tc6eDmgd6r4joluFI78iCOWWEjzUpkixgbjarLs
         Tw4A==
X-Forwarded-Encrypted: i=1; AJvYcCXCd//qwbbbwOFH1aS5/iZjBU/ZNcPgyYoVw7rF+GnAjLv/SL9PKeIfqQHvr6HeEceNgc41liEGm9/pEWviaNgRCOudH44v
X-Gm-Message-State: AOJu0Yy6utZveGKiAK1vtRJm8jQtkuLK8MJAPhuzBCg65G03HQAw4GUC
	TRvFMzAUZFB2N6G3YZM1AtaHOn20682sjcBmwBAlTUU6ga/900F7vxt5Em3uoLclxZ2vDXPRFer
	5xjrNXI/ZAw64pFT7eXBc2NX5tG6MjtECsXjO
X-Google-Smtp-Source: AGHT+IEMmzxHnPPmwQTu8f/YLMchXnCj+p1Jdq3Aj4yEt/3jcHLpwAb7gnJj38q4OJ2mrGGCbUEoLW2azquBrpvIygE=
X-Received: by 2002:a17:906:dfd7:b0:a68:b073:14a5 with SMTP id
 a640c23a62f3a-a6c75fabb5amr14362566b.9.1717605064284; Wed, 05 Jun 2024
 09:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605161924.3162588-1-dw@davidwei.uk>
In-Reply-To: <20240605161924.3162588-1-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Jun 2024 09:30:52 -0700
Message-ID: <CAHS8izMWBDm5VDYOeJDy5J-pbLtsiBnP801PC17XAbzCb2oe-g@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: remove WARN_ON() with OR
To: David Wei <dw@davidwei.uk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:20=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Having an OR in WARN_ON() makes me sad because it's impossible to tell
> which condition is true when triggered.
>
> Split a WARN_ON() with an OR in page_pool_disable_direct_recycling().
>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  net/core/page_pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f4444b4e39e6..3927a0a7fa9a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1027,8 +1027,8 @@ static void page_pool_disable_direct_recycling(stru=
ct page_pool *pool)
>         /* To avoid races with recycling and additional barriers make sur=
e
>          * pool and NAPI are unlinked when NAPI is disabled.
>          */
> -       WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state) ||
> -               READ_ONCE(pool->p.napi->list_owner) !=3D -1);
> +       WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
> +       WARN_ON(READ_ONCE(pool->p.napi->list_owner) !=3D -1);
>
>         WRITE_ONCE(pool->p.napi, NULL);
>  }
> --
> 2.43.0
>
>


--=20
Thanks,
Mina

