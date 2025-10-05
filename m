Return-Path: <netdev+bounces-227890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B82FCBB9683
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 15:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DBB3345698
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6D283FC5;
	Sun,  5 Oct 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBhNDEyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075841E49F
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669488; cv=none; b=EUZ/fSq4DSoog8ZKMT0P4eM96Tu9PXa+ZXlY37Qkq7yQ6AvvElDc3B0MAO6+RR7XeqxpdgVL7+wK+Fb/afTCL5kwAaJDO11wllXCEQTEEnsM/hWO12OElDuCSijmEQdum9OrtLxy6z3F1INbFmFtI/2mkSKgzV2IitpC6jX40rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669488; c=relaxed/simple;
	bh=IBM0gXe2yx+GuSNwZdH9eUDPRt/hJimlr6GRydvgk7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQY5iYmwArgLEhXIiTl8Ok7+xvMX5PNoRcx6eExNijHXPkoPsazf9DXoddg6dxZ8bP4kjIX80mOLxctGHRMLvveFY3VmdC6Q27jwkHvP3m6OAzC7UatzSO3oDtIrRTR3+KJUsYeWUeOHeZnegCj/HZGygNGTge9p+ryMxxCOXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBhNDEyO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e4b340f99bso33335681cf.1
        for <netdev@vger.kernel.org>; Sun, 05 Oct 2025 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759669485; x=1760274285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+RJQKjQrFkOXYT+itRREJcbwRQ3We70gB/GA7XkcNY=;
        b=cBhNDEyOta2wB1P//4V3618rwYnhuTb0R4QwvgJncTEoyw4PKmT+swBJxGyLIjq3WC
         jqRw7wGH9qMKUDD5VLguzgxGhD8LuTLrogmSfw42yItX8zdaUPEaUtoE1bZf9EUWbewL
         pUcVpAMA85v9BzN30r+hYvY9WJLTl28IZ+TB2Vpm2nLTZLpkm0M/2e33D7/cS4Ct9eHL
         OkbU/31e5zceaIXsT+48QJ/rbRwYboUrXi2F5MJR6EeNOC/Uxb7wakHiFto+qzp3oXk0
         T+gg4mW3xBSrZvPGdp69uGFzMyQNFc0Cjf3TFsNxx5XUo7lAbMffYj+Wm0GHuNUmHEYE
         R7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759669485; x=1760274285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+RJQKjQrFkOXYT+itRREJcbwRQ3We70gB/GA7XkcNY=;
        b=okkj0qSASKtzx452swqAUcI1aXvxwbGOvYElFJlVHjHgdFgkEQVovNbR/fAN+Xlhjg
         rNuakGnHRTTCqW2xfINRQ8z2bZUNTjxbtW6HvuHA+FjnbPH3iQ/RjvpO8aFMIuwWhUuR
         XmUrOsJX38phBXz1LMj7WGOJkIkFKqF3bJar20iTHIWbJto0TOjdCXnrjWFvEXzXCmEw
         8jG3sE6yYjTqbtWkJXKEcYCABIUIAJA/jypnHzFC58pn40wUltxH2dvNFg0/JvTgfXxK
         xKix+jec7y9WhJA0sMliVu3llmFCO9DlmAGbrxfJVAIYETplFl+wmFhkKtpnn3V9vGA3
         +ilQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyLL2auJ9pCp1ceI2/5wBcS9qUQkIrGVG9Gn3s0fWY4DOwQJAljUAn0x8NlpWZudJqMREEm+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4x50/CK7UghZ7pSBoj75n1/EVjgoYgd5oo9xf5phbioHQbc1p
	qqF9r6SrxfogHM70Nxc4caQgBJQaFJk3iYJflvpxLhbNChtqGu2KSxyXGWq8bL+pPkReY6yAP/2
	ctl1MKS6ZtBnfkqN9gA2BUZ0zULGuKdPLuLYKAioQ
X-Gm-Gg: ASbGncu397YF6VnXNPCJZDpbN+1XRfUFTpeiOPoCyBA6MkR4b96wZ4R/wdsBdtVDsMW
	5boHMfet8EW48oz11zcApZU+Egrrn9fF8lUQECKv4U4msS8NLAjsz1QFz7ar/MHvP673kY0k7HW
	zRM06xj33wfaNwsO9wXLeIBNqgpBAMZKr7ombmNpPavzmo9e/nm8CYH4veLaSpvNBAc2a5KI9kS
	UqxHthE+Fd8PL4rVQOhhzJ5uFEC7OmrrujDV4/U/Fx0Lxoy
X-Google-Smtp-Source: AGHT+IGPsbMcZU+vFeo9ZAmXgvwpBCCrndDdbMORhec+3i6dz7273LfwEIxnyR+I3xhjhE1r1jbPhGJsmb1RmGw5LpA=
X-Received: by 2002:a05:622a:1885:b0:4b7:90e2:40df with SMTP id
 d75a77b69052e-4e576a44e99mr114292601cf.1.1759669484326; Sun, 05 Oct 2025
 06:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005122626.26988-1-wangfushuai@baidu.com>
In-Reply-To: <20251005122626.26988-1-wangfushuai@baidu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Oct 2025 06:04:31 -0700
X-Gm-Features: AS18NWAzrupW0HYnpOxSwBwRSmRYD-ffu1xxO0-ekzBqui4Dt-9D_s306e6ZH0E
Message-ID: <CANn89iJs+Y7Ge2sbAOQSsuE6O1GbxuHbNrFxBO0fq1C3HOfxPA@mail.gmail.com>
Subject: Re: [PATCH] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 5:26=E2=80=AFAM Fushuai Wang <wangfushuai@baidu.com>=
 wrote:
>
> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
> the code and reduce function size.
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Hmm... have you compiled this patch ?

I think  all compilers would complain loudly.

> ---
>  drivers/net/wireguard/allowedips.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/a=
llowedips.c
> index 09f7fcd7da78..506f7cf0d7cf 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
>         }
>  }
>
> -static void node_free_rcu(struct rcu_head *rcu)
> -{
> -       kmem_cache_free(node_cache, container_of(rcu, struct allowedips_n=
ode, rcu));
> -}
> -
>  static void root_free_rcu(struct rcu_head *rcu)
>  {
>         struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] =3D {
> @@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *nod=
e, struct mutex *lock)
>         if (free_parent)
>                 child =3D rcu_dereference_protected(parent->bit[!(node->p=
arent_bit_packed & 1)],
>                                                   lockdep_is_held(lock));
> -       call_rcu(&node->rcu, node_free_rcu);
> +       kfree_rcu(&node, rcu);

kfree_rcu(node, rcu);

>         if (!free_parent)
>                 return;
>         if (child)
>                 child->parent_bit_packed =3D parent->parent_bit_packed;
>         *(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) =
=3D child;
> -       call_rcu(&parent->rcu, node_free_rcu);
> +       kfree_rcu(&parent, rcu);

kfree_rcu(parent, rcu);

>  }
>
>  static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8=
 *key,
> --
> 2.36.1
>

