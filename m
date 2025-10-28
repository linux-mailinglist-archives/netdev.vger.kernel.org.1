Return-Path: <netdev+bounces-233346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B433C122E1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16E83B4F23
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F720B7ED;
	Tue, 28 Oct 2025 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GVgDpE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9A20299B
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611812; cv=none; b=S/R1u7Ai45rTgBoxP/tGNbGGexEQcdmKyaSMuwGHxiB1ygqLiiij9XVJrBOTMCQHCGSHrSwcr32udi7PKR9j9PYRonZgesXQGFOyLjQMo1DcOWWjzjWO2rcy9JeisxrwvNnyD2bfH81zZwnLc1VgyVgbof6qgcNkTiibXdCj3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611812; c=relaxed/simple;
	bh=HfMKxWya+alo4HTeH/VJeMJH6ra+r5JHKOIwTNWoCcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlgDw8Ub3+klmO2QPMaEZY9MYsOP31r+FOBoY4AvybL9FBxfrg1g2n87hBLJUpuUV1pmIUn+bNUaAvU7UoDGCHUlMHmh9EdRsT5yE1P/RPdaL6Y95BNFyr5XoNYzQ8O5zV/DruECMcvsUJ4ZhAYbpcqblrTP9+idzAoJEjlbNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GVgDpE4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ecfd66059eso158701cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761611809; x=1762216609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9airE2D5p1Y8Na0l8E2tZxHyd99hjP8VcmYGJ8nfrs=;
        b=0GVgDpE49wQrtTRP2GiWnRfHni+5po3seRc/tXryRhv25DaEdfxD45cODcCAgL2NgX
         fofdWTBVMTIED7xvQSvI2ZA7Xe3yGCvDcb/MbWIhNgRTh4fMMVyDaV7pcWUecevdA/ob
         lbxzZdjaJpz+E1LYuR6X3T+uEbu0/qCbFlXojdxpcoY9zGQxxhIfOINHrTw3bJBow6Jc
         yJ4B9akGwHy4zfkXZcPbc9WXX+J4hXNjhlS2XLlYHFV8k6zmayC3IEOUax+qdSJJCSol
         FsWOa7f9yd/8WjNqo9/x89XnZOB2fZVzaxFTW4K6r11DE/BKNlyK5Dx2yduaoLZeDxEO
         qnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611809; x=1762216609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9airE2D5p1Y8Na0l8E2tZxHyd99hjP8VcmYGJ8nfrs=;
        b=vTGKhGo7Y25KIw4HdlqcbLMrCgu6EsHgPDXRJVnBwvRGqr282vNu8/Roy8/9p+Rz7I
         XHfmHhHP0eSTOjADyo+urU8OVvn0eaf+VLVzDt32WGhMgCFpBuxMoKM+rageP/Kro2LL
         YBzemu3Ad9jL91oC1vIvxBXN/Cy5b/vg3elxHCIuGodntU222GbpyQ/qjWmv1okaPCdK
         H2q5VSv2q5zrSVB/ttVtNIYWS2f8L41GZ9oOimdIq2ioW9lXNbpjDF083DmZ4xe87zfq
         cMgADHoYOYxH6rK/3ZzTYj6vlskls/nS5HFJKQOcgDFUdf5Oy5/vn6k4F4YKflzVKAKS
         MffQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7JetIy+fprP6rnXjY2GEJ8+NlUCUD6jltp5qAa1pjJv3ipq5G9BniMEYSmY11XOtlPqXMsdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCSOtUTUOPEye4/Y7phZY5Bs5YibFzEQ3gGcNmEfeseqjm2xH
	fgvp/tthUng9fzQUfQNQt/KUeBhCM4vbv/H+zv/ZflpAHKYvJ0XtzjXDI6dHo3DX0+BG+p6UMk9
	hZn630hvyLBC758zp7pFtYpTG2uAmP0JLaFTCCMki
X-Gm-Gg: ASbGncua/9y+b9ZPoe1JhkCZbsJnvYnWJxPJuQi1KOe9FqrNVdksUhdg2ogQFVv5jGQ
	bRZpc2zt1Mkt+7nsz02kKztsRgViBeTibx9i5rjqIHtvOEX9+vyIY18eKoLIRr3Ixoaphipoqql
	MZWNZNRuOflpNzoCukE6CNkQok8Lc42wbjvmW8J0PkIJ2TxGng2ZP7kOzAhD6AG1686JFxrPFpx
	RuY2+YKu86AAIaQ2TPnXl0NNkjrggHgY9s1QMNUVAFmiFW2eAWCl9DLQ8pB
X-Google-Smtp-Source: AGHT+IGMk9j6UADKczeIdBycT7NeHvpUha15rA19nFLr68qYQwbYTKP3it0bS1on0J71a7haYB5nb6d1uLCJfAJbKPU=
X-Received: by 2002:a05:622a:48d:b0:4b4:9590:e091 with SMTP id
 d75a77b69052e-4ed09f3e5cbmr1623131cf.5.1761611809252; Mon, 27 Oct 2025
 17:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-2-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-2-47cb85f5259e@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 17:36:35 -0700
X-Gm-Features: AWmQ_bkLe3qJG0bwA6CrmauGWKqYZgOx7-sOTZCMpb-2yOZRyd8jDNdsw2rnu0o
Message-ID: <CAHS8izNB6s97X8srfZQ1upUNOOx0vwj4Aa9gMUZvneoyefqdrw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/4] net: devmem: refactor sock_devmem_dontneed
 for autorelease split
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
> Refactor sock_devmem_dontneed() in preparation for supporting both
> autorelease and manual token release modes.
>
> Split the function into two parts:
> - sock_devmem_dontneed(): handles input validation, token allocation,
>   and copying from userspace
> - sock_devmem_dontneed_autorelease(): performs the actual token release
>   via xarray lookup and page pool put
>
> This separation allows a future commit to add a parallel
> sock_devmem_dontneed_manual_release() function that uses a different
> token tracking mechanism (per-niov reference counting) without
> duplicating the input validation logic.
>
> The refactoring is purely mechanical with no functional change. Only
> intended to minimize the noise in subsequent patches.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  net/core/sock.c | 52 ++++++++++++++++++++++++++++++++-------------------=
-
>  1 file changed, 32 insertions(+), 20 deletions(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a99132cc0965..e7b378753763 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1082,30 +1082,13 @@ static int sock_reserve_memory(struct sock *sk, i=
nt bytes)
>  #define MAX_DONTNEED_FRAGS 1024
>
>  static noinline_for_stack int
> -sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int opt=
len)
> +sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *t=
okens,

Kind of a misnomer. This helper doesn't seem to autorelease, but
really release the provided tokens, I guess. I would have
sock_devmem_dontneed_tokens, but naming is hard :D

Either way, looks correct code move,

Reviewed-by: Mina Almasry <almasrymina@google.com>

