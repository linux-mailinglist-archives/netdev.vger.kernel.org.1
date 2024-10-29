Return-Path: <netdev+bounces-139811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D161A9B445B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4161C21658
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C461D203712;
	Tue, 29 Oct 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGyb7Jh8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8D1F7565
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191072; cv=none; b=Vg78vBnMJi/udEXlFnL37BrhVJEcFD1HBj6wlJ7L6NrGZtXHqYVokMMBMTWYw/1xZONboQSbMfT4NbKtj8xGQTU72Q9+Jv9sjk6IWp7oQ26z+WhkYwAqh6c7zE3JJiFoOHYEVACEBPzet1buCc0AwP1tzX9oiuhsrLvSFq7/2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191072; c=relaxed/simple;
	bh=XsSSGobFDoTfqbc/OK0DfYnUmsAkdP/dMq7ELVtfne0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ne4YT5wvnbg/1SsOzUsCUvhoZ0R8+cIpeqaihf4HtQFn3c5to8kKFMHMAoq+IiXb0Qhk95qSTWZL40Ulbp4xq/uPJ8KtieCSZ9rsxC30SuusvYSTo6uLI+2fYr5yBKI5jl8Gc7UWNVpIqfsLsz3vZ9z8wPCaZYlyqaim9iKjA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGyb7Jh8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7991118a12.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730191069; x=1730795869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsSSGobFDoTfqbc/OK0DfYnUmsAkdP/dMq7ELVtfne0=;
        b=cGyb7Jh8giGdX6cH4NQl05JNZ+CMYHIDHu4LRIDn6Ei35y8wsuAF03wzRNpB+gvMis
         +jRembUpQYGruO1XV21McVW1NyAEtsThjyiTJQY4CeZiIsgNngjqvnEVMsiq6R3FzKKv
         73WvpYWDWG73+n6/OFTmdsmwuYpEGS6CZjcDMvh96BkXfezH4khuvcxAhoz90WXrlWOD
         ZXvSEmgFqVEYxwyzq9ZxhwlL62QKX3wE4Ou/HRkcCKooZPv/1IA7HYyOjTYEHYmffUrU
         C6q3r2Vn9p7hX+RDM/Jt1/lvT7izeJEdZQa/hW2J8A6BGQ6FZoHarL6Pl7OlxDEuQ3/e
         S/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191069; x=1730795869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsSSGobFDoTfqbc/OK0DfYnUmsAkdP/dMq7ELVtfne0=;
        b=btgFLYTvHjR/0fjseG/m0sCA8r+OIC3leCw6w7uDtOevPMYDT1+GVbJzoy6QC6fQMC
         dPf2PjtG4NkDcDs0v02fua6ZXVqJXs0Q2AUtXKtVCHclNyGFfmPL05rbCaWVEAbQ84Bt
         OE1EC6+pGFLz+YZ2D/nlcj9Xkv8u3CIyXTx3EXe3jWHvbRcYx4WkdL8Wi2vS9xl4ij3i
         8ShGjgOz9o9wsL7D3dzcTKIdJ1l88x7DBFCFam3hgaHRWqD6uu78FnRJCDg9379l8afw
         wrJtWmgXXOcSlwK2r2bnI4OYbA+5bjfoGosD2C7r/72BodCFfGcQrW83NH4AsbgeYNbZ
         B4XA==
X-Forwarded-Encrypted: i=1; AJvYcCVx0XZS2dDigs13oAiSDIJU9MYsLJBQ2g/TZmt7MwdEhGFw4TeoIHYSqEgtEX6//DMiYRYjev0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WNv/fniZq9MEUcPwaHwh9MMKeS/GDcZVz/TvK6M7ojLAiWbR
	081hug3Ds695L5Vkw0hT2+lNX6slrrm/RQZ6zziuueZGH8uQthvNOBCGgmfbf2TmsLNlac+LpJ6
	nPPWGUeqnUTNr7zMByo7slGMVTGjrMVRS2YiU
X-Google-Smtp-Source: AGHT+IGR0wHAvJN1o6fK3TVq7JmV924+KNHOsKIviQgBB1Ftq8AqxA6K75mTC7o/i1xV3xBxG/hphWROcMHVcDnyOyc=
X-Received: by 2002:a05:6402:35d0:b0:5ca:d534:8072 with SMTP id
 4fb4d7f45d1cf-5cd231765dbmr1360516a12.15.1730191068704; Tue, 29 Oct 2024
 01:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024201458.49412-1-kuniyu@amazon.com>
In-Reply-To: <20241024201458.49412-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Oct 2024 09:37:34 +0100
Message-ID: <CANn89iL+nXCD7465Q19mpT8avL1MZDr7o9fVi6U1C7YjpTOZug@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] socket: Print pf->create() when it does not
 clear sock->sk on failure.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> I suggested to put DEBUG_NET_WARN_ON_ONCE() in __sock_create() to
> catch possible use-after-free.
>
> But the warning itself was not useful because our interest is in
> the callee than the caller.
>
> Let's define DEBUG_NET_WARN_ONCE() and print the name of pf->create()
> and the socket identifier.
>
> While at it, we enclose DEBUG_NET_WARN_ON_ONCE() in parentheses too
> to avoid a checkpatch error.
>
> Note that %pf or %pF were obsoleted and will be removed later as per
> comment in lib/vsprintf.c.
>
> Link: https://lore.kernel.org/netdev/202410231427.633734b3-lkp@intel.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

