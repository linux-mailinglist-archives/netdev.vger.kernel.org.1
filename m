Return-Path: <netdev+bounces-68569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D084732F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B81BB252BE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040231468FB;
	Fri,  2 Feb 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eErp11Hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0BF14460C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887911; cv=none; b=qOro9+72xcQmiODFDWU85lqfCmpKaITPQdjjab19IhqxdwT2wqoGCYNX1UPC9+wWnRzIqNCK6ZN/wn9ygbpr7xorZVpxrvYgpBEuubfeLPzGTzP4uuS16cKiaj/LtEQbF+WDXWcr/d4JL1MK+2b7VlY91wskzZ5aGHoOn/79H1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887911; c=relaxed/simple;
	bh=X7CHp42Qev89FZqIAikgLbDlNbexH9c5Zo5LqW50PQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lP1EfeU1VSCBDDh01/K0oyi5Fpqt1vBKwaePT2534ANvPjrBKusXrYn/p6WUiBGUK872S0y8STUHM8wRkjaePRKBT/RkWuPxF7R22TTZ5vCLMGlCQpIb+wuqyRk2QwOR1KgRIa5FdoEc0p9T6zLQaEywwbXkHsrFQ0mMjB1SjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eErp11Hu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6dcd91364so1631134276.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706887908; x=1707492708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyvOAzMFIzsSlq2kiKta6LgOvAhbSJpfLskxvPgpInU=;
        b=eErp11HujsPY4cWoXSjHHOZ7vPmZED3O/U8ftVzZuTZ9g8qtb1trzvxG56JUjAaxMe
         RYQwlFbhMdnu52+jdMDjo+xHKRRUCrDwB98PFLqVAyWEsuG9nYI/1bWr1/WZOM6GR7PM
         mDqgxLlkDkuKH2n5zT7fADQz6mAC+zklOOkx+B8YzO7FhSG76XI6cXN+GrD0tZyXOpWL
         /i2EbwUNkBn8XW1MaKndDq0v+JxbYX7Qh91kOTTym5JUIT3CA2kn+df1ZilHYqBBUqgs
         mZuCQUU7pJXm9KOFOp8RiJajcoHhpoxEVR3UUobSDWfHKC7DEv+J1y+X95C6sSgQmRFi
         DEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887908; x=1707492708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyvOAzMFIzsSlq2kiKta6LgOvAhbSJpfLskxvPgpInU=;
        b=NkwO3h2Tka6x7OBBOMzNhfP+yfvDiglZC224YybqZX6nONvu4/TnCww/D8A9FKX619
         m60k5Jc7IHQbN/fCCzNsZZHZzH0OvnxSQcsMXd3UCA1iqTn0bP/JXprP0TGGuF/zE52Y
         pq3v3stIsqDX7RYLpa3IeLsduzwh91uh4Cn55g9WyaqIZcwCzkkj0KSH4YbQOd6EkmDP
         w4mC+d5+gODADiAuqqwoJxLXN9iX2bWnsIcV5qvoQzigzkrrdkAbaG6NfYqrGh0Y6/LC
         C7cf5UzFhgRR0T1geh8BqLaBqeGmSLu1oayRTpTk31tKEQv/FtmrDGYpu5jVtKi+xLdx
         fg8A==
X-Gm-Message-State: AOJu0YxmZlQKtjyaPGNszDW9dUykVyuMXPs9SMfmQEwXQZVOfp0Lh/75
	eAFKtZ5xKVvWSBXZht+4l+BUQDzhUWQEKcO6jgCPfbyYHJpWn/71uby6VjybKWHkBlMDWA5t3pO
	Gn4uUk+r4uye6bXNd6bF9GyNKBBwK+D3T3EDY
X-Google-Smtp-Source: AGHT+IF23FJH1CrfkAGumfzPLOg3qie8GMPsuoo1BWOC2z8criLcQmZEuP8ymTXXNdxx7AdItEawlzLieCj8emW2AW4=
X-Received: by 2002:a25:df91:0:b0:dbc:c56f:465e with SMTP id
 w139-20020a25df91000000b00dbcc56f465emr8987242ybg.3.1706887907968; Fri, 02
 Feb 2024 07:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202034448.717589-1-dongtai.guo@linux.dev>
In-Reply-To: <20240202034448.717589-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2024 10:31:37 -0500
Message-ID: <CAHC9VhS2F8LkjRNQv7=x1DyRqDjatpuHJL5QNjqz7ru8-0Y1_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Modify macro NETLBL_CATMAP_MAPTYPE to define a type
 using typedef
To: George Guo <dongtai.guo@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, George Guo <guodongtai@kylinos.cn>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:45=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Modify NETLBL_CATMAP_MAPTYPE to netlbl_catmap_map_t, which is more
> readable.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h       | 8 ++++----
>  net/netlabel/netlabel_kapi.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

I'm generally not in favor of minor rename patches like this unless
they are part of a larger effort (code churn with little benefit).
I'm not going to block it if the netdev folks want to merge this, but
I can't say I really support it either.

--
paul-moore.com

