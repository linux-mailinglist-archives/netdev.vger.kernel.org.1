Return-Path: <netdev+bounces-192399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA364ABFC20
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46241BC7E9B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171927FB04;
	Wed, 21 May 2025 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovoLN7NW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69C27CB0D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847821; cv=none; b=AxkKcQ8JV1yoB9u8kaAZPE4dY/4nIohIL0SoRRMduBcBCrsJFazLnic6EL5p0IorW/famz8Lh1P6YjWtIAYImKrgseIrq1UV1fdYwLu2VGk5Y+Te4L9jDQIBla6VcLR9E0M3D1onpKqd+4ZqHYkWl4jmYIMwlXIK0FB2mnRUg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847821; c=relaxed/simple;
	bh=D4ISe/FLvyr4CVhVYBHD6n3L5UFpgvuWP7bM5t7YOuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8b+frk6HcFzu6XkVr037HFC6wMSZkxjBDLnqLkI2CYuYBFdWfmRhJnOr1bhArIMzt8KAxBQCVey54Ljna9chlQ08IulqKJbH4n0tElbzd31gjMtw9lfAJd3jgj414FVBZUwO7DtcHijdu/UfmAafX/JI2h0Fm91fM7amiQUz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovoLN7NW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231ba6da557so752845ad.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747847819; x=1748452619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjNF/EshajwntpVrmxofKLtSpmDRMldtvHl1a1kJfXU=;
        b=ovoLN7NWm/fAj3Rryts6klo6HLNyz5amt6nL27kcFGNCcTWKd5S01e83iMN3oZRh+b
         fk/snncw+3smXPaTeWDV4SxfTTONGXnTlynasmSZDzbTEiiog5Jsb/aMWWqbhS0/fxCj
         pgHjz60x5BLfUdU4vsn63T2pufMquOH6ct0uW2ht7L6kN68h2B1oyO6rVu8tLH3dpdgZ
         wMsfLAMAz0wBob6chtRzrSQjWLvptqjOhJ84Ar3d3kE8+lFxC9a110TN3O1TBFZwHLye
         DF8CkQXNVypf0XsnGX3JCZrG/fiCm/IGCHtT+GBqojNFuWIR2oqsFerklQ3Cklld5nhk
         ltkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747847819; x=1748452619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjNF/EshajwntpVrmxofKLtSpmDRMldtvHl1a1kJfXU=;
        b=R9noUGUP1td/E3XRGwMefdljSVCZl3sXwmErP9+ev37YfLwzEf+Ykw5ij9EiA3MoTP
         tsuhJMqPZ+m41klfzmOG/g2XIkq6YSfZKyPyJp+r/9ZRNmyjoHzQCghjxLULkKJyK2BR
         7PP97cbcWfBqWNj4KHeZYDFh1mWzq0YhMyszypKwIeKUOQbHLA1m3kLDVol9YlUXENhR
         myOABEOsM1pg7s6rass+Q/BxkejVjf/8Yqjzi+NOR8LABMHRX4MLAdM7Sum0/Nxjep6/
         BL8WJiQFY8WJYnAw5EXBMsb/YflLm9sNiB9Bro2Z6fw6kKrlymAzDbEZqig9zB/ExSxq
         87Ag==
X-Gm-Message-State: AOJu0Ywc60YsTKoRErFTBTfU0hGGG4UziwRgfE2NbVaRsNUpCxdKs+TC
	YqmQGDByNYRi+cULlU9WsWIOya9at/YMjdHNrs/zslT2LGD2h0ch5BaxOmg8BFUkVLP6AtZIpjN
	dYZePrrYYMtzGRCV5gAwWyjEagsgmmvOmJvatrG04
X-Gm-Gg: ASbGncvaUNZnWEUcz0Zq8Ttr1+H3/UcrYhD37ZQ+IVLddU7deQnDNTQaYvyk7a65AB2
	XwEdENQFhmiJvXMp/E2yCarA9rw9R3xefnt7X5iwhjwvrUWTm+Nj0czt53T62Amly46AOHOc3AL
	9sfIzxMZXe5DgPfJ9mB2inniqBDTQRqU9ndCybTaTys/CW6J9unEXS2p3kv7tpG5FqfDcDHLDI
X-Google-Smtp-Source: AGHT+IEcLaieaT6i2N8bO/10/CNvd74NMT4xZt9ijO05OydHwziDOCVx023CgKji5TDdxf9zVv/qUvK6mdJYoPHbsrA=
X-Received: by 2002:a17:902:e80b:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-231ffdc5dd7mr11782905ad.28.1747847819084; Wed, 21 May 2025
 10:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com>
In-Reply-To: <20250520203044.2689904-1-stfomichev@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 10:16:46 -0700
X-Gm-Features: AX0GCFs1YWRcByoee8OrB1N_JWqtKzwROSm78yacol8kNV9a-DsAubo73LOdPp4
Message-ID: <CAHS8izOTWF9PO9N6ZamJ0xSCTOojXV+LfYm+5B5b8Ad1MA0QpA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: devmem: support single IOV with sendmsg
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> iovs becomes ITER_IOVEC. iter_iov_len does not return correct
> value for UBUF, so teach to treat UBUF differently.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Mina Almasry <almasrymina@google.com>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  include/linux/uio.h | 8 +++++++-
>  net/core/datagram.c | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 49ece9e1888f..393d0622cc28 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -99,7 +99,13 @@ static inline const struct iovec *iter_iov(const struc=
t iov_iter *iter)
>  }
>
>  #define iter_iov_addr(iter)    (iter_iov(iter)->iov_base + (iter)->iov_o=
ffset)
> -#define iter_iov_len(iter)     (iter_iov(iter)->iov_len - (iter)->iov_of=
fset)
> +
> +static inline size_t iter_iov_len(const struct iov_iter *i)
> +{
> +       if (i->iter_type =3D=3D ITER_UBUF)
> +               return i->count;
> +       return iter_iov(i)->iov_len - i->iov_offset;
> +}
>

This change looks good to me from devmem perspective, but aren't you
potentially breaking all these existing callers to iter_iov_len?

ackc -i iter_iov_len
fs/read_write.c
846:                                            iter_iov_len(iter), ppos);
849:                                            iter_iov_len(iter), ppos);
858:            if (nr !=3D iter_iov_len(iter))

mm/madvise.c
1808:           size_t len_in =3D iter_iov_len(iter);
1838:           iov_iter_advance(iter, iter_iov_len(iter));

io_uring/rw.c
710:                    len =3D iter_iov_len(iter);

Or are you confident this change is compatible with these callers for
some reason?

Maybe better to handle this locally in zerocopy_fill_skb_from_devmem,
and then follow up with a more ambitious change that streamlines how
all the iters behave.


--=20
Thanks,
Mina

