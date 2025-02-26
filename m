Return-Path: <netdev+bounces-169879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA67A46350
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588DC1899BDE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAC2222C3;
	Wed, 26 Feb 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViwZCdeV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202922222BA
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581053; cv=none; b=GNOMSGXY1vYDt4uzGiU+4B4+D6bPmaphC8Z1tu0f4P0HCcwv0NUZsaqNiLU0fW49IyL4p6ZmQo22fh71KgWbMMWZrIxbiUeaIEfUBE9AvLci9YX9rCzyNx3rL06+bcWLAtX/aLCASAd2Mw6BZKWbm0PZPkttN6YzBClm7w7jy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581053; c=relaxed/simple;
	bh=86Vzm+AK4JTzuoN4Lz2MEMbGoeh2oTUlxV6CbUR/CVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBtX3yXsKayxxd5h/sIT/514M/5wDiab8G9Uf3LMKMb8Dshx44jzQNuOQMONgbCkEkQgR1NPDlT0RSQwVUMhOKAPHop+hXIcCE2FMIeX4st/bTAms5uobO6usNsDNjQc3aRDoZUtThHdp4KKmBYkRtX99Qyu/w28f8UmAbfydzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViwZCdeV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so1794115a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740581050; x=1741185850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTNfSDwIAlbfeRCgAq6FoXGBkAILchgvoUx40MasxJs=;
        b=ViwZCdeVTiYK86TquTGoUjahwbeKiWYgGk8cWnA8Avz8v6ITjy8aF1HCLiIqWqmlDF
         U3WKhwPrT88faXas+JwZl4UF6helPwL5SU4rjyoaIdBmLF1GyXEJmMqNz5zlZ2TIxp8R
         i9h0y5T7Lov2mC4EOIHhBmMeU5g7dIscvyiF+G/4hhHjS5vXkBeSNVoqayo+QebE52Ga
         t4ppgPGM585m+uCBfV1jz4RTRjWN9XD1ZZivqgvw3VDOxGTGZa9MhHC/nuLVqckB9r0q
         hjIZczoQW+aPVBWjb64c2XdrzzubxOCw1U071Vup5BorSGzC0TiAPgaBmhIlngYuuC7q
         /MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581050; x=1741185850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTNfSDwIAlbfeRCgAq6FoXGBkAILchgvoUx40MasxJs=;
        b=kfs4ZIvt3wYpJitvTfdMaUZ25hVAWa/5/4LqAccUJivj8RrSYPingcb+PF4BIpEzXk
         3A5TpbdMGC9IBzm3ZXZ5rDAbenvb2Mc23Ar28r5zeQLCg/0zapwL2dEUcYN/rmKrsRn4
         8X2lGhZMSpenX459ZeXJnqo/IJaMvh/1kXrFTX4usKDy998+8nFhWJha8lmxF2an7k2T
         0PbmXNZ8MA6kumUbSqtzheGeCnooKIit9XdgPctxC73dUU4Tw/UUJIYFTY0BnPXLjjYK
         lKBn7lQSllwiA4TfCn+Xo7c8g5hUVToJCLA7wCI66wDzlcN0ZIj1FHBSQdJdK2E7i7Zr
         BpLg==
X-Forwarded-Encrypted: i=1; AJvYcCWaI+z+0QCJEbwjiSLgSLrQB7+Cyamrsl4DCpjeWSxslOU7v3CseIyVVrnCJAZyjZ8xzPNgY98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXkCunc1dQ+EyEaIMrYv6fGBKFCAEawdCAN1MjBCjbs9y+iBx
	B30DawMH3r93qgBwupJFnMqzfTYZ0EOM1FHVHfM3IJcoweczq3QnOXwDcIJsQIpGLiD6YiLdHXA
	EeWEHxDSALmzFMYWtRGDERiM3kZiBy6qDg0fk
X-Gm-Gg: ASbGncup+r9CDCO79vU/P9xRZ8IfFAj4TQj8DszdbDd/tEH8Xxvqq6LMXRleuifQBVx
	HAiiahtI2wl8eJ8nC9RH1bMQlLNvAAgSWlq+MlCEKWMbvG1AkJDLgOmVFksn5+pb4oZnOy42vv0
	Onem85ecs=
X-Google-Smtp-Source: AGHT+IExUmkWkDEUH6qgBarpkM5y1HC97eK44MeNGWJO6kg6aVqL+E9f2bv+6+tPIzjlcFL3Tj723r1hGFFbZxkwjcE=
X-Received: by 2002:a05:6402:524b:b0:5de:50b4:b71f with SMTP id
 4fb4d7f45d1cf-5e0a12baa86mr21959041a12.12.1740581050176; Wed, 26 Feb 2025
 06:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-12-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-12-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 15:43:59 +0100
X-Gm-Features: AQ5f1JrU_5gC822nCl_IGuB7S0n4n4uFMofOgAKbAdQ6F2ZPPjKq2KMcZxOguhg
Message-ID: <CANn89iKNGiLK-_LJu4tMriPMLeQs6ZWhEy6E-11dA1SEE68h2g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/12] ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:27=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> fib_valid_key_len() is called in the beginning of fib_table_insert()
> or fib_table_delete() to check if the prefix length is valid.
>
> fib_table_insert() and fib_table_delete() are called from 3 paths
>
>   - ip_rt_ioctl()
>   - inet_rtm_newroute() / inet_rtm_delroute()
>   - fib_magic()
>
> In the first ioctl() path, rtentry_to_fib_config() checks the prefix
> length with bad_mask().  Also, fib_magic() always passes the correct
> prefix: 32 or ifa->ifa_prefixlen, which is already validated.
>
> Let's move fib_valid_key_len() to the rtnetlink path, rtm_to_fib_config()=
.
>
> While at it, 2 direct returns in rtm_to_fib_config() are changed to
> goto to match other places in the same function
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

