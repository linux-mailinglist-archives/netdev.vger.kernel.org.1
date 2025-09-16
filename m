Return-Path: <netdev+bounces-223367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293AEB58E31
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517CD1B28051
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FD2DE71D;
	Tue, 16 Sep 2025 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ+7WkfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841A2DC775
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002402; cv=none; b=UcKn9qaBXQqjXZCXSU7hQetomITtulafI25QxCZBAND+44uFSeZ+EMgGV7Coe6uCcXR4OPYAZpBpMxctQsNsIQMed3FKPcAI01mbGorJgNsImnyhGaGABem3C2pZD7AW+DZXcVbiJDtFURQX5aHCdQLTYTuw9YYBbbIAxfxpYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002402; c=relaxed/simple;
	bh=ljoqVmPtyWJEQ7U7MOfPa8LsiwPv3AOqOyuXdT6fCjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5WluQPuY24S7kcLZ36rgTJNF+yoVNXBcmTRlAPo7bsV03Ylj5xWxihGuSRJuidc3uC5atm074InWzjphX5eqTsBvgEtJ4r60st8lb8Jjq/uxwCQPQ8+c7DkiZoq3ReBpWQV7WNtpEHtEHhoOkRBTnsNnZETXAids0qzD7c3A4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ+7WkfH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7a40c7fc2so21983241cf.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758002399; x=1758607199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lta4t//ehvgO4Xrq14DW07TQW6qacrgDSlXFltVJrFs=;
        b=pQ+7WkfHnrnmjk+ynBnKk8NgPibZRbd/Ty+ISgab+vCnICbtm2boSaurEviAWosMp4
         6VixIxiR7JUOiqg3zhM7GrilKpmYAEIMCKymbb6K01yzJ5UoiJfZecyO+ZmyKQkIDLF7
         VUegAJuH8ZxyLDjAirsmdAWe42Olleh/g/ytsG+i+hngqPHzIx0zBvB9RAVP6U6BN7U3
         WDTZnPKpO1xorXqnMJIfBqDgql07fuWXea0rKV/esyEYx1BfANGNfSJxVDHHDeG38f4A
         LgmdPy31It1gwkdduimlHq8heb+Fn4YTskRhiu34mKr8e/4LIUPgmDHU7hrhf08bHvMh
         Eg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758002399; x=1758607199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lta4t//ehvgO4Xrq14DW07TQW6qacrgDSlXFltVJrFs=;
        b=t9YP7ENxW6U+X8RiFVzfQjA5WcJuFKCJiyTPK+g0h86r/WN2aB10ThIfYOkCJ1hm3e
         m+K1P/1oqDJ73YItuhofl8vrUNjpwqYPgA0DwlFHY5Dd7G7G74HZ3q19EVVEVBg5uPFO
         kqO93UFuxPnQpqRZZY76eeVob3KVWCSpCJr5RhnMl1X4lFAYJAFqa6YJ16nWHM2PjnGF
         nU3/YAOpYQl9r2ZIZLM1s12IbA7ovESTnQ3SDIZq8Kq/k8A+rOJbVMjO2L+0KqbqW+tR
         o5FmUMLPZ33w+/+WWv11kYTEwWDro/O9PKAN7dL6Hc3UaGFGv9vWMNZH3l8UTNRPNNA4
         3lcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9SI/1tRULfEe0zfGwgXXOnxyAvQLc84XHtQOCdRGGk3yfjFxmN3mY8uWVNIZO0MX4UW+19NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTd4hINyvXDioJkSsfAKKrBIeJ7Xds6Pmn/8JtaPdvvIk+Tqp
	fUNRp73Uc+jHNFrqh2Z+Fn1MjssoooEpLd1fWF29qxv6iZk2GvamhY6/VbJqKKak6CuGOVevcbb
	Q5OqXZZC8Pz8gIG82MlnjKOn+bed6XiRkcBS/I1oh
X-Gm-Gg: ASbGnctVLaIkz97VKL0rOsuw2DOSlvUcW8/frV8o+Z3B7VoWpbYgu+O2eixAZdh1PZP
	Vey6B/5StWVCjh5+zvUdDX5uLR4Z5wHGGkwVY3UWMAKLGSeNZQKyn/waeN/n9o/AIsH1X3XBeqv
	N2vU1ZPVY1+LtTtfaMps1Xese+oOGRvSkthAHv8hxqem9PdnNRC96wawBkMHZBchhOkaZiQW0P8
	eCrTAPu6YL30g==
X-Google-Smtp-Source: AGHT+IEALiIbiBGWbxH9zWJXsRjXiSuplBD4Cego9ysHIAowKr6mniZNtJZI7xpMyEDd86lmD5lNHrIjCoYW2RYaFBs=
X-Received: by 2002:ac8:5882:0:b0:4b6:33e6:bc04 with SMTP id
 d75a77b69052e-4b77d05a075mr161544331cf.60.1758002399132; Mon, 15 Sep 2025
 22:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916034841.2317171-1-jbaron@akamai.com>
In-Reply-To: <20250916034841.2317171-1-jbaron@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Sep 2025 22:59:48 -0700
X-Gm-Features: Ac12FXwCdwRq-w5aW00Jpqxtm57WMWsFNDi35qDcaFlfsjhusKR6MvqvNKGiyQQ
Message-ID: <CANn89iLMd64djnN_KZi6y49zcd46Lg96uDO7YxkHaDsaJ=vdAw@mail.gmail.com>
Subject: Re: [PATCH net] net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS
To: Jason Baron <jbaron@akamai.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:49=E2=80=AFPM Jason Baron <jbaron@akamai.com> wro=
te:
>
> Currently, alloc_skb_with_frags() will only fill (MAX_SKB_FRAGS - 1)
> slots. I think it should use all MAX_SKB_FRAGS slots, as callers of
> alloc_skb_with_frags() will size their allocation of frags based
> on MAX_SKB_FRAGS.

Hi Jason

Interesting !

Could you give some details here, have you found this for af_unix users ?

They would still fail if no high order pages are available, for
allocations bigger than 64K ?

>
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 23b776cd9879..df942aca0617 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6669,7 +6669,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long =
header_len,
>                 return NULL;
>
>         while (data_len) {
> -               if (nr_frags =3D=3D MAX_SKB_FRAGS - 1)
> +               if (nr_frags =3D=3D MAX_SKB_FRAGS)
>                         goto failure;
>                 while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << orde=
r))
>                         order--;
> --
> 2.25.1
>

We require a Fixes: tag for patches targeting net tree.

I suspect this would be

Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate
bigger packets")

Thank you.

