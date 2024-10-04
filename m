Return-Path: <netdev+bounces-131869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7A98FC73
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 05:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC61F22BD9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 03:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3422097;
	Fri,  4 Oct 2024 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDfLljWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CCDDA1;
	Fri,  4 Oct 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728010854; cv=none; b=LL6/tH9BtRuTrUyOn5A5WVb/vgcEPc+X94jAt+I6Nsx9TUZO7u3e0wXbHImgEzIICWGh/H6iSVE2liiuClF8oX7P9njuloeiDM/OnhayYpmULtzbtOfjZJ4kSf+a2YCc+Xi46uFc8qmgvs0i8SdhjqKkaH3dQg/DI6z7D1kvTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728010854; c=relaxed/simple;
	bh=08eO4rVSuL5Itu06fqQ6rH+zvRpYJ/V9/51Uuh/gTrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMunz/68uwM7ZGZ/cmWJfKNzmX8Q0EiMEfe8EupGKfEgsUDyIKjmCZ1G3RCMpjOw1yqz70JzwG6eGqaoDrihfT5BAVPYIFRu8cj6W0V6HmZChYzX9iWjczOApopPBrroYmaFzPKUAPdHFcM2VSu9f+sBQOg4+JQUu+sEvztY18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDfLljWl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so20764345e9.3;
        Thu, 03 Oct 2024 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728010851; x=1728615651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbp1AkhesU9hhRzgbyEVW16AAfvZIjNwVq3OXYiQd6Q=;
        b=TDfLljWlhwB3gXHhg3swg4LJp5pOOIfnIss1XpBKbheZpDDCwIT1/M+q/BP5VgeQR4
         CRgwcAcQs1lXndmoO9vCbR7xMueYt3X9LsqWoOn6nvwWvaw68/udxwT3fq5Lod5Q6naW
         P0stYtBuJ/U5uLIzpxlXzFPbM5ZHnb6tXzqjbDKVc0FJCe/6B0bc6qbn88uBb3X1ioSR
         I36nh81cYoEt5HM2h4zGTCvM+rz4U5v0lFmZQhAoYs9Zu+j+LLiDR+aTTWYHbnAPftb4
         +SgBUWCFj7HBTiJuFo63tEImSA9M75SGg34lvOJHKfgYXcrUNpa8e7Gb815m9kBK7bnZ
         WNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728010851; x=1728615651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbp1AkhesU9hhRzgbyEVW16AAfvZIjNwVq3OXYiQd6Q=;
        b=tvErVka4nOUSjfRXQUbgfNAc/uhIRH3hb+dqNVGdFDJw9JINbfrC88WE62gZJvqq26
         rwSuNOelcdC3CAhbzxuJbvHxRxZ03JvaiU06D2e364au7G2xnZYzFrhishtR/UEf3kox
         Bwytz50JtgPHXRfX3ufFuvCzHLsSLKyIZyZBEg1S7PoikCIoj3bKHeJhuVDno2Civj5p
         bOKrhxadvK5sD2Z2Ck5lgQRNTnRT1eRGtEkZylyH6ZULxfXfAAJePAo09SzhURwFIB4t
         QfiWnsR20xgEgPOugqAeOHQAFvdZIzuAt9kYBRs5JOSE1CdNF+ctF+vokT5m+GWY5TSv
         6IrA==
X-Forwarded-Encrypted: i=1; AJvYcCVWU3TYtn7w0fjBn68/Edx9n6ihk8i5UnisiSqu2hDT/LpVc2cxfKR/wmjkVg+5AHdN8L7QTUZ8@vger.kernel.org, AJvYcCXQBDqdetpZa9zUhntWc8EY60G5V7Zhf2VEEmOwQckWGOgZGv+gV6+lQtXsU6yvYid4+3HBC9xm1nqOthk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61kZmsqoKJA7H4jun7NyrznM7t1o3ZmP5T3rHsppHCjayi8qV
	6ne522BT+DhACavxbLwNN+x7acYpL4ITsMOw8uSLMc/An31fRqptilY/fkQVEIAL9cwPAgNMq3o
	3oKMsyXwg4MmnhQ7a99qUcwnTaec=
X-Google-Smtp-Source: AGHT+IEDGQvwmpIEDJ3EyYSzUAgad1wQGBiJYudeCLaHHvxeP0wsMi1NMM2pdsOlj8ZjOFDg+USt7JIsjjJHusb800Q=
X-Received: by 2002:adf:f58c:0:b0:37c:d507:aacd with SMTP id
 ffacd0b85a97d-37d0e724b97mr1056615f8f.14.1728010851339; Thu, 03 Oct 2024
 20:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001075858.48936-1-linyunsheng@huawei.com> <20241001075858.48936-10-linyunsheng@huawei.com>
In-Reply-To: <20241001075858.48936-10-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 Oct 2024 20:00:14 -0700
Message-ID: <CAKgT0UeSbXTXoOuTZS918pZQcCVZBXiTseN-NUBTGt71ctQ2Vw@mail.gmail.com>
Subject: Re: [PATCH net-next v19 09/14] net: rename skb_copy_to_page_nocache() helper
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yunsheng Lin <linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> Rename skb_copy_to_page_nocache() to skb_copy_to_va_nocache()
> to avoid calling virt_to_page() as we are about to pass virtual
> address directly.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/net/sock.h | 10 ++++------
>  net/ipv4/tcp.c     |  7 +++----
>  net/kcm/kcmsock.c  |  7 +++----
>  3 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c58ca8dd561b..7d0b606d6251 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2185,15 +2185,13 @@ static inline int skb_add_data_nocache(struct soc=
k *sk, struct sk_buff *skb,
>         return err;
>  }
>
> -static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_i=
ter *from,
> -                                          struct sk_buff *skb,
> -                                          struct page *page,
> -                                          int off, int copy)
> +static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_ite=
r *from,
> +                                        struct sk_buff *skb, char *va,
> +                                        int copy)
>  {

This new naming is kind of confusing. Currently the only other
"skb_copy_to" functions are skb_copy_to_linear_data and
skb_copy_to_linear_data_offset. The naming before basically indicated
which part of the skb the data was being copied into. So before we
were copying into the "page" frags. With the new naming this function
is much less clear as technically the linear data can also be a
virtual address.

I would recommend maybe replacing "va" with "frag", "page_frag" or
maybe "pfrag" as what we are doing is copying the data to one of the
pages in the paged frags section of the skb before they are added to
the skb itself.

