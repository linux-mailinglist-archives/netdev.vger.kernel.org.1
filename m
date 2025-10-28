Return-Path: <netdev+bounces-233368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934EC12871
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7755E188C0E1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1722258C;
	Tue, 28 Oct 2025 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/lfOPCr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1214C6C
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614567; cv=none; b=Am4afuAeqabR8u6AIpMCqYK4p6L6Pcv9W40dsErpTDF8pDH+GVP6cZLiFWoZQutQTk6VAy267pvMmef8p8qwwsKeSvtkDbUByIOHJGams7CAFAOqe/PDihYdMyiLmMT92a8WsKXSvXGl14ps5H3dzHOAQK73oHKqE+/Y7M2mNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614567; c=relaxed/simple;
	bh=ez429fHGZ5tTsPuch7QScZAcZHiTLexLI+0HtTBbekM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoS0tmPmOmhI9ematGHLHFMLKpnD6i/aRZvj+zZ9Bn1D522EfV9Ads3WMTOC7PF4v1q522QEkqLtN8f9BbiYlt2F1/Nff2D18T3C/63Unxa3vrdqI1lM+quLHzwjJti2VMk5PMqOawYKhrDcNp8tpmXYaa8J63IIytl4X4n3yK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/lfOPCr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ecfafb92bcso117761cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761614565; x=1762219365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBmdf4B8atpsrsNVEjJuGlAJx4TugpH8gBXbTM/C5Lg=;
        b=J/lfOPCroC6HlDWCsaFi84E76oJeVNPzU1Qa8FbC8lLVLNUsqte3zobeQzwFDjXrxb
         m4BNrTerna4IxJ/tv9d/qwPh4svlMl+XubyKuZ5BeetbkiGQkEwCIfhm/as+gDpU6oAw
         eVGMGVD6LXogfAmj8RpSr6ihD5tcv1OUrxqSWNSN21Xywj8c4vB3tRDK1evC4mbmDQQj
         PKOkblwSnKqM0AYanrk2cqaizd3hqAOrlNlMOCMAAoI5kcPpXMBP5soVw0iEt07V03FD
         TzgxE9JGg3FL8JaDnuZDjUdSqoIPde5aW9SIZgRzOLa2soQiVHiL93b1MnKWlvI2zr0H
         EQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614565; x=1762219365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBmdf4B8atpsrsNVEjJuGlAJx4TugpH8gBXbTM/C5Lg=;
        b=teGvQu6C96/dZAiM7+JODvEnIMbrl14bK5xS/FlCrHHwvypR3z3j7ccGbPpczIsXB6
         ddmShAGQlRXN2tJ0Jdwty95aa7l804cZVCUzbDLWvMkuFIkoWFW8ojl/gGjYU0fqItB5
         gFB7l3uqN6L/kPIjJ0HOlDjQI0sCc4GVZIh80xMbKurRqaxFYvGs+X7/vsgGBRUA4+TF
         d8VBSWqNs3EHSYgWVQ80fNwJnuX3Ufy87Dc5/FPrkjs1fYHp4kb7mMKwxgMI27RR3Ps+
         TtXgCCQnH20W8d6TxcSNxU/HAS3lKf1eTcnBRMOoYFrVoihsrnUIcAiRvlI60Ds8cdOg
         C9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWJuU9t31Iw5/YAtTx+JbQuleDQHNPauA96UJlDgbs8LzoDE5EpIa5OwSUyaBPXUR9ZCWWa7kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+/uXl7rF1rBKuH5TMHspiY2VHemUkn7IZrmWjAwt+Hw6qcGb
	oEV9kPj3dlbZa7yTeBT0QZO4/Wvg5O1AYgzzUF6g1M/4QEPTzfhqFV5zP/wTHWq9UnR5ca+xmFe
	6LhmauzhVk599Tu1zZbPKraOYFmsNVI/4NtpT1b7e
X-Gm-Gg: ASbGncvrAf95eRWZ40TkSPrAGH8UQE6MiLMYD53mP3gjMf//CoPq4MiQgff6t5NnNQc
	frtQfqms0TRFoX69o9/rSYrD3R+tq8iBaJk36zrhCu6/2CbPlpm5/S/aAUD057bcW4rv+zLVYNW
	dPGBPBvtbB5XfqWtZZbE8b1dhlwy/1R8Fq3e3LNe5orOXxDLew8H0AZuQev9juiiR23+q3kwFTQ
	fQSDjn4kADBRu9D+IQWuUa4ldK9zKJwGL1g9Ya+cOFDfX39qeDyAnbrMxMIQU1Z7pOgKKc=
X-Google-Smtp-Source: AGHT+IEz8Kkdr7BTQN16P8fW/B56b1y35W/0fTSOf31uNTIbmVv0EoHJypKcYcVDXWx5JQ2hZsROEkLSKjFSsJRz7V8=
X-Received: by 2002:a05:622a:54d:b0:4b7:9617:4b51 with SMTP id
 d75a77b69052e-4ed09f6d3bdmr1872611cf.15.1761614564966; Mon, 27 Oct 2025
 18:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 18:22:16 -0700
X-Gm-Features: AWmQ_bmooOlk80xCzEMqcfrwDTup3DJ6XLeZRaKXED1cK03SyxGltVDePwQnAKE
Message-ID: <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem autorelease
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:00=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Add a new per-namespace sysctl to control the autorelease
> behavior of devmem dmabuf bindings. The sysctl is found at:
> /proc/sys/net/core/devmem_autorelease
>
> When a binding is created, it inherits the autorelease setting from the
> network namespace of the device to which it's being bound.
>
> If autorelease is enabled (1):
> - Tokens are stored in socket's xarray
> - Tokens are automatically released when socket is closed
>
> If autorelease is disabled (0):
> - Tokens are tracked via uref counter in each net_iov
> - User must manually release tokens via SO_DEVMEM_DONTNEED
> - Lingering tokens are released when dmabuf is unbound
> - This is the new default behavior for better performance
>

Maybe quote the significant better performance in the docs and commit messa=
ge.

> This allows application developers to choose between automatic cleanup
> (easier, backwards compatible) and manual control (more explicit token
> management, but more performant).
>
> Changes the default to autorelease=3D0, so that users gain the performanc=
e
> benefit by default.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  include/net/netns/core.h   | 1 +
>  net/core/devmem.c          | 2 +-
>  net/core/net_namespace.c   | 1 +
>  net/core/sysctl_net_core.c | 9 +++++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> index 9ef3d70e5e9c..7af5ab0d757b 100644
> --- a/include/net/netns/core.h
> +++ b/include/net/netns/core.h
> @@ -18,6 +18,7 @@ struct netns_core {
>         u8      sysctl_txrehash;
>         u8      sysctl_tstamp_allow_data;
>         u8      sysctl_bypass_prot_mem;
> +       u8      sysctl_devmem_autorelease;
>
>  #ifdef CONFIG_PROC_FS
>         struct prot_inuse __percpu *prot_inuse;
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 8f3199fe0f7b..9cd6d93676f9 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                 goto err_free_chunks;
>
>         list_add(&binding->list, &priv->bindings);
> -       binding->autorelease =3D true;
> +       binding->autorelease =3D dev_net(dev)->core.sysctl_devmem_autorel=
ease;
>

Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
that silly for a u8? Maybe better be safe.

Could we not make this an optional netlink argument? I thought that
was a bit nicer than a sysctl.

Needs a doc update.


--=20
Thanks,
Mina

