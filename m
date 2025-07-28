Return-Path: <netdev+bounces-210630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA2B14158
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D6218912C2
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A03275878;
	Mon, 28 Jul 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKhAQMC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C3275845
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724686; cv=none; b=VmPOtWyA54LCiBlvGKvMl+exP0WEVbSlNSzUBvpx6euQCbmZdPJH9sw/BLEuOx/IMNzutHq74zbO1AGztd+sLG8oEl+bOiR+EY7lycdTqu2VCbSad4K4SqAuEzdBjTIPfRARqmmyuN0jIogsY3P9+PeCHtmpnmBNXA4I+h717ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724686; c=relaxed/simple;
	bh=lgJkLpHOVKpZ9Pydo1mzO9Jlebs/wqxqJq9AZQ1sKeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxjsEJ0rRfAdiUfxPT0Lg0BgHQvqup/84ClCkogabD/JGAEqwE1ZvFLSB1hDRSuDmb3evSx81ulwbEBSQRJdYucI5JbQk02xlJbIImWIDf7ykRm2NNhb2Eazjf3kC2+gge5a605UyXK8nU1+1rkPyXvfFr6ujr14QBx3LsJ6gBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKhAQMC/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso20135ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753724684; x=1754329484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGqmfkIq6uvPHxaBaaqkZ1GQ74G0Q21vJf064guZvV4=;
        b=JKhAQMC/hm5X7E30OrLSNyzr0HsHjWqBtTo72iXnG/1DKVDEBKjUnn++6Lo4vShRFw
         9JA7mOBLRZ9z+kTBDQmSyRhASR2eqsdJIJ1XAL0Jm0ZM6gP65DWU2WZlm9RvxRdQEGzF
         zhtoFvNCvy9tIjeNW47sGK9yR18t1CLYp6zDv4NnHp1QLh1lNQlFngTHkJ/ZX9zICSnD
         76Zifw4PljuZ5earul6UfTfFwDZ0dsYqnidW7JALAjTvGRy8y/4g3yzwmxh+JzHIvsrI
         LHblXFiETI3E087O+tKayYMwWRJFJx8I43vuR2uiWhSDYS7hhVIQRDTRa0XzMUjXBfTv
         pm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753724684; x=1754329484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGqmfkIq6uvPHxaBaaqkZ1GQ74G0Q21vJf064guZvV4=;
        b=s83fwZqfgpeF3vtD5rc64kp5vUtiBvqHSD43EI3N07Zdm8ZcIS4j2W504M88aOO7eG
         g6BUOslpfr6470uLKUUEBvf4LypwxMeOhZkG6nKWnmvmiW3oTcmebeioy0vdNXFSC9dt
         QglPkqS34gG2Zz2Z8/kacPYSZtptTED1qJoyxyUL4B9NHqNRHxa20dF0KazUs7lc24zL
         jk4B+ir19M27QXbzotHL/CIeQ4aZ1LEH2ZAdqYvCZH6NnU/gdLwY3kJsdrExt1bKi0k9
         NqEAFSW3hd6WoCoa2kTUzJOqlo4png32Cqy+/kfDoPmBsiOCpF/WaT2T9Y2b/48xMMMz
         +0xw==
X-Gm-Message-State: AOJu0YyPHywFZnmd+V3maCSHEzvutwId34J4j7JAI78yt3hsuVfU84Ph
	mcXofD9a2IxPcBW6xDUQhv2gngPCouCKNSE88Rl55fbHGTAuGOCdBSz7E5mNqHmjFXMIPhIMYYt
	lGEJX4ZjUQbeOXPhhx3ItVPayTXO4o1vVllXXZ8hB
X-Gm-Gg: ASbGnctE2TLCX1nE4VFWjZxlWNi4AzX5oEQaPQPOf4quFLDZv8/OUINia++/9NXlvM5
	DgDB7rxcZ5F4rZDP7dAfmmdDy40qqyGgZggjd4sTsnyu8F899kBxZ2jc6q2W5CJ5//iN6YgvP44
	qxCld6OWcd7VL4l4+i4UcZ9Wrcs5WpqGeyo8IxZs4x9N/gfhNQKyy/XkmraLRCr7oSrr4KmRUVP
	8cROOZFCr9snZ69rMouo+UWNkRJlh8n+ypGwZQmiN0OUnef
X-Google-Smtp-Source: AGHT+IHI9LmkTOIIFW8FKIRxm5XFUJpxJk0MyASmM1W0pT9RDFwYfVLLLeibUswP16iAv5ku1T6mS4obtn5kggIDwuI=
X-Received: by 2002:a17:902:f60e:b0:240:4464:d486 with SMTP id
 d9443c01a7336-2404464d6f5mr2457415ad.13.1753724683985; Mon, 28 Jul 2025
 10:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728042050.24228-1-byungchul@sk.com>
In-Reply-To: <20250728042050.24228-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 10:44:31 -0700
X-Gm-Features: Ac12FXzboKcBSuT20U31AGaSJEuEkHnqSwc_Qz-jgAsGI0JbwDYBk_4dfCKZqCQ
Message-ID: <CAHS8izPv8zmPaxzCSPAnybiCc0KrqjEZA+x5wpFOE8u=_nM1WA@mail.gmail.com>
Subject: Re: [RFC net-next] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	hawk@kernel.org, toke@redhat.com, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 9:21=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
>
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
>
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Thank you for working on paying this tech debt!

> ---
>  include/net/netmem.h   | 33 ++++++++++++++++-----------------
>  net/core/netmem_priv.h | 16 ++++++++--------
>  2 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f7dacc9e75fd..33ae444a9745 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -265,24 +265,23 @@ static inline struct netmem_desc *__netmem_to_nmdes=
c(netmem_ref netmem)
>         return (__force struct netmem_desc *)netmem;
>  }
>
> -/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for acces=
s to
> - * common fields.
> - * @netmem: netmem reference to extract as net_iov.
> +/* netmem_to_nmdesc - convert netmem_ref to struct netmem_desc * for
> + * access to common fields.
> + * @netmem: netmem reference to get netmem_desc.
>   *
> - * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_=
magic,
> - * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can a=
ccess
> - * these fields without a type check to make sure that the underlying me=
m is
> - * net_iov or page.
> + * All the sub types of netmem_ref (netmem_desc, net_iov) have the same
> + * pp, pp_magic, dma_addr, and pp_ref_count fields via netmem_desc.
>   *
> - * The resulting value of this function can only be used to access the f=
ields
> - * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will res=
ult in
> - * undefined behavior.
> - *

I think instead of removing this warning, we want to add an
NET_IOV_ASSERT_OFFSET that asserts that net_iov->netmem_desc and
page->netmem_desc are in the same offset, and then add a note here
that this works because we assert that the netmem_desc offset in both
net_iov and page are the same.

> - * Return: the netmem_ref cast to net_iov* regardless of its underlying =
type.
> + * Return: the pointer to struct netmem_desc * regardless of its
> + * underlying type.
>   */
> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>  {
> -       return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
> +       if (netmem_is_net_iov(netmem))
> +               return &((struct net_iov *)((__force unsigned long)netmem=
 &
> +                                           ~NET_IOV))->desc;
> +
> +       return __netmem_to_nmdesc(netmem);

The if statement generates overhead. I'd rather avoid it. We can
implement netmem_to_nmdesc like this, no?

netmem_to_nmdesc(netmem_ref netmem)
{
  return (struct netmem_desc)((__force unsigned long)netmem & ~NET_IOV);
}

Because netmem_desc is the first element in both net_iov and page for
the moment. (yes I know that will change eventually, but we don't have
to incur overhead of an extra if statement until netmem_desc is
removed from page, right?)


--=20
Thanks,
Mina

