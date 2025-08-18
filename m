Return-Path: <netdev+bounces-214792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57FB2B4C7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302442A7E2A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6A22B8D0;
	Mon, 18 Aug 2025 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALV5OOfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2720D51C
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560033; cv=none; b=JiXwY0CVZzu2pfs7zcpvXyGnR4pm1v7bkblGCclutg/Zi0ObNBGcNp0dyQ9TLKyKjK/w8iCEzioYBMFZKVpYaGh4IGskmB7pbR0zNAAiEDHVEO6jBynIOkEe2tOyINTgkSDa6wLXEPiONevrPmUEd47irdqIry4ZQepK75xhkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560033; c=relaxed/simple;
	bh=OoeYFB/BvC/0eRzNt4z96d91dntS57ys6UGlVQXsAGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPD4rmNngZWloZaAWmdAgLuKRX6G7KJoYGi1ytQWwvMpqRSkmCxNPz/BUSa0aaxUVMpqXAZNaXOP0qXhRjnNFIAlq4M35jbBKVpK3TGJ0ehSXE4XhLiLcXaHS2h/ouoK7LldajH2rf+vTgcYtNGWZqS2vAhnKhu015+DgK5J1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALV5OOfJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cc715d0easo3538e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755560029; x=1756164829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve2DzLaZnDqnbb7Kf6oBSozuJ15Yl3sv46ZZmhVCBOo=;
        b=ALV5OOfJwrWkFApNk++CdI5JqRT1SFNkuoBR4ninRxPJOMlvyDvldgDZNL1bbqIork
         rlf1DuToLYUSz1sgNPLqDkWrU80C86K1mbWu/MihZVc83F0TTUAeeUM05iVw156UhtCK
         GKMtpjJMyquMEjMu67PLzfHsZG7Fh5J5kdfUBg1HrTUKoNCN1L+fKoUpliwjRYiqFwa4
         DGitOVsWqb0+yWyFhs8SMvHAtBAeAfS5fyKff5dtjmgO6FhOTPcnw7RZQ+mxjh06bIJU
         DmZC4VKYXrhfIPowsfQLRUeDT4YfhOHEgjm6ujaesoUkK2hRfSwcODwGpyHyA4Asp0f8
         XdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560029; x=1756164829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve2DzLaZnDqnbb7Kf6oBSozuJ15Yl3sv46ZZmhVCBOo=;
        b=rzroMBv5rgevQu3XbwaELkxymKzZ/xh1PT3M1f3fSUCRl7b1fD/B04X6gByGdqxc0o
         14rfVyCZ3r3mooLjvRHauwLK2fzRKG7Ux9khIuE1ZW2MELvqRWA2g0gVtFcaxnt23CRn
         7BEryawzqB4qkqsbrqpy56pypDhNISPPF4/O3sCOl10Dl3vO5cL4I49Va2C5Utws0nj9
         8PJGEw/agK8oA2NxIaussRspWeu0YGT9lnld5QxcgzTQMFAtfGXFhTsVOw9k5rNduJHa
         ope/UTzxnsIPG4tkuHtadmPHhFX3dijAYhJl7BRdBkim33xCBKKDPNpffC2DV6kIfUKx
         JmYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/zv+W9wdAmCKacbH8m9wRu6zZsXo21TBSS9y5PYKLYJ5dgErswaHtFKe42rzsnYUcE9kvfFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQx2g4H4USceI4jqCFwu3v7UA2O99P1zAO/10o1MSH+UcZf0o4
	50vjqEkLBsdk/usME9adbMTbkMqgNHZaDM6E51BzBIldiwHuHPNqbdI+XyiLONnaVR+lY8wjK/w
	eLViSqumOq4LWZdtLLFhOPssotT/Ct5v8auL08Awc
X-Gm-Gg: ASbGnctUjEHfHXaCGKfN5zZleZVbEqck81qxBOIBxmUciTjR/oJ529FBQGNGkD4lCUj
	JohIcLHl6X4cnOMWWqhT0iPVqMpsYZkUtzyLuBRvafv6tQ+U1OXGRuWluleEJSUm6fq5qCXVXRr
	9gVI+LY6qvoxj5bAk9fPkrVsWuJr+XxzX4m1qsFNJYy5Df+llsoKGm/MTdKn3LQhcSyDHf7ECsg
	2rFdSG9lY0R4RGF/ZB0+R0+3blS0twbw/vWRWzBnXT8+7BQMdwYB8c=
X-Google-Smtp-Source: AGHT+IFwQTCOO7naIVkzrh2yLXB0Ye5C7kP2H4rJJJq+y1I2xqZOOFQLhHsiWjrfXhQk7xhvimRErO3eSsYfBgTtoKg=
X-Received: by 2002:a05:6512:134d:b0:558:fd83:bac6 with SMTP id
 2adb3069b0e04-55e009c6000mr76627e87.4.1755560029185; Mon, 18 Aug 2025
 16:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <9b6b42be0d7fb60b12203fe4f0f762e882f0d798.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <9b6b42be0d7fb60b12203fe4f0f762e882f0d798.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 16:33:35 -0700
X-Gm-Features: Ac12FXwfrqXSKcjrhl3FF7ja5U6Np0FPNPSAiVBM9uAKgBQErhZT7EQQpCxE7UU
Message-ID: <CAHS8izO76s61JY8SMwDar=76Ech0B_xprzc1KgSDEjaAvbdDfA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/23] net: page_pool: sanitise allocation order
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
> We're going to give more control over rx buffer sizes to user space, and
> since we can't always rely on driver validation, let's sanitise it in
> page_pool_init() as well. Note that we only need to reject over
> MAX_PAGE_ORDER allocations for normal page pools, as current memory
> providers don't need to use the buddy allocator and must check the order
> on init.
>
> Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

I think I noticed an unrelated bug in this code and we need this fix?

```
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 343a6cac21e3..ba70569bd4b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,8 +287,10 @@ static int page_pool_init(struct page_pool *pool,
        }

        if (pool->mp_ops) {
-               if (!pool->dma_map || !pool->dma_sync)
-                       return -EOPNOTSUPP;
+               if (!pool->dma_map || !pool->dma_sync) {
+                       err =3D -EOPNOTSUPP;
+                       goto free_ptr_ring;
+               }

                if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))=
) {
                        err =3D -EFAULT;
```

I'll send a separate fix.


--
Thanks,
Mina

