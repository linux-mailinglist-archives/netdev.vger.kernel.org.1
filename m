Return-Path: <netdev+bounces-176749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8CA6BFA8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A413D1B6090A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2591722C324;
	Fri, 21 Mar 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag7J/jkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D022CBDC;
	Fri, 21 Mar 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573859; cv=none; b=q4JZ3YUJLWdoGc+Bd1tTZX2PEcD1tnHBYCx2I9yoC9yrgCo1yQqfyZpTjuyQ4qnEyGvi6n6CODQInGiGfp6Hw4hL1hLTfth2WfcUzK21fg0e5nU8gqwlfUDnqqckuEhFAyLp1WRDp9B8vQeFbqBbltGhjF71tFFZ9ivVGi7O7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573859; c=relaxed/simple;
	bh=K7QVaDnAGXLmGEUEBzanuOP8h9JUI6CUFV+cdqqmN/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT6rsutZgiQ5fHKLBUJYT6C38W3alafnZN+YVU0kkfSIa354VN/xKiYsl/fUgXBAS/mWJo4Kg/pxttLsx/MdGwdUVhRTMc8yjw7uNCeiKppwRiHzs6DPZWFdw+oiVPnDS9UImV3OCPquT6JQbmXZi2kHIX6ZplBYEbr9zuU16Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag7J/jkj; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d445a722b9so10883155ab.3;
        Fri, 21 Mar 2025 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742573856; x=1743178656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB2LddsMl//YUnKCjcOJrbsbuFk6pwEh4cQ45Dr5HRc=;
        b=ag7J/jkjRpZNwaooJCx7zfI3uEEtOn7/IPcDFfF8Xkok2UMZu1cm/2RDmi/86syeTk
         EanM2338tqRw42MalzuthMKegV4ERonWtWLZn3HZBPkr0ozzVlUF+lxArbYHWWrqfp/T
         0xyDX3C4ghduSnUO0XKQCET+zEp2h5vtycLyuKo9WvmkCtuOz8fhOxco4G+DOg6Ga9Gr
         t3fOzxpRY4AguesHhQgE/FPOA6d/j2DW7HabLzMk530urFSx95ekX49WcILF1x8hUL5y
         QqexIF2kMAntdmPFmzZ4WZrNyYlccx7Q/q7o100zu9En6EAQgt4glwSMJ2/Ut5CHI3e8
         jXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573856; x=1743178656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB2LddsMl//YUnKCjcOJrbsbuFk6pwEh4cQ45Dr5HRc=;
        b=sJmqu1xIi+4WWkSkcwddLjUhfLnSv7PkGM9dot4EaMlculE5LzAgG/nDqm0MOQ9sud
         473qnlwRPbx8EHvPYzZMz9e7F0YLg9qn/I7NMLOoLOtVH6YKdpqrr43TLuKgHvYTlI1Y
         e8WvyFCrEKkAaT4NUkWmPnrQJFdPZW/Au5SXK1CbAs3QccvygzHrSsT65ApVbr121iqh
         z/96eTFVcD6v1/5eI2nTmqS1wqBr657NPF3Q5SvbZzTQOBXEsdWexwHCIkyRurPXpUzT
         r5CiEHswTZc5JXuZKsLEPexRLUjf0YEIRkD0FuLEk/gJ6JBC5JDUJDdYneemJqfDEzs0
         HqWg==
X-Forwarded-Encrypted: i=1; AJvYcCUEDzZIaNkvahXth2HjX8qzR245VW3Dj8VHIbkOe1npA4NQOQI468BXMtzwjVcZMOUTU9qiHX/08Abzm94=@vger.kernel.org, AJvYcCX3rpP/VhrSrMwMYOTzswppBoffzvEI4/QGn8uJfQRV9we8kk87IrCbSr5+HdLywQKg+DO7ShjU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1mJiFk0prlnzMBilhLwvBMY0v1g5i2c9pn3U3dLvpNdD4FYI
	xzqCBw9fgs89cuOgwQf7QnnAwnh3oI3vz8xl03Hs8Hz4nWPXJ6+Z+BbxwSeR5zh/d5pQRaWwX7r
	/MY2gIhPHuULCtJCVM24AnvsuXro=
X-Gm-Gg: ASbGncuwuxDDZveHCJfoqDEys2vvSkVm+MojPbIQ+g0vSFrumcOHKidyOhv38iM2f26
	X6ug/QGRNFsLbzYbycS0CVi0OQLI71ZNnHCjxkK1oXU7fwFx54ysckkzJi3NkWR+UvUaO87vP7K
	LhLIcxuNmDgElEDUcP9yLsHHq8Z/coUC1RnXIl5A==
X-Google-Smtp-Source: AGHT+IF/cTwa/Ayq5CoNHqC35AhWyYP5kDowB9jCEl7LGxlA43AUsug/c0VuT+er56UZPSwPE7unIoT/6An3lvz8EGw=
X-Received: by 2002:a05:6e02:1fe2:b0:3d3:faad:7c6f with SMTP id
 e9e14a558f8ab-3d5960cd064mr37698385ab.5.1742573856023; Fri, 21 Mar 2025
 09:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321103848.550689-1-praan@google.com>
In-Reply-To: <20250321103848.550689-1-praan@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 21 Mar 2025 23:16:59 +0700
X-Gm-Features: AQ5f1JqjM4GK6CzHqw2vIfkX6OSsc016A653q3dy7QXb9gXqPTROO7S1fob5YLM
Message-ID: <CAL+tcoBhKBhXxN0H0dmZVuD5x=cnUaZH0ZMhb2WM9ndDsqJsuQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix the devmem sock opts and msgs for parisc
To: Pranjal Shrivastava <praan@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-parisc@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 5:39=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> The devmem socket options and socket control message definitions
> introduced in the TCP devmem series[1] incorrectly continued the socket
> definitions for arch/parisc.
>
> The UAPI change seems safe as there are currently no drivers that
> declare support for devmem TCP RX via PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> Hence, fixing this UAPI should be safe.
>
> Fix the devmem socket options and socket control message definitions to
> reflect the series followed by arch/parisc.
>
> [1]
> https://lore.kernel.org/lkml/20240910171458.219195-10-almasrymina@google.=
com/
>
> Fixes: 8f0b3cc9a4c10 ("tcp: RX path for devmem TCP")
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

When I did the review for [1], I noticed that. Regarding to the patch
itself, feel free to add my tag in the next revision:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/com=
mit/?id=3D23b763302ce0

Thanks,
Jason


> ---
>  arch/parisc/include/uapi/asm/socket.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index aa9cd4b951fe..96831c988606 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,16 +132,16 @@
>  #define SO_PASSPIDFD           0x404A
>  #define SO_PEERPIDFD           0x404B
>
> -#define SO_DEVMEM_LINEAR       78
> -#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> -#define SO_DEVMEM_DMABUF       79
> -#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> -#define SO_DEVMEM_DONTNEED     80
> -
>  #define SCM_TS_OPT_ID          0x404C
>
>  #define SO_RCVPRIORITY         0x404D
>
> +#define SO_DEVMEM_LINEAR       0x404E
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       0x404F
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED     0x4050
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> --
> 2.49.0.395.g12beb8f557-goog
>
>

