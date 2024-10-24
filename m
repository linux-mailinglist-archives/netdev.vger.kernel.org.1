Return-Path: <netdev+bounces-138738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79C9AEAFC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8991F23992
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15297158A31;
	Thu, 24 Oct 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5Ibinkn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA016190C
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784722; cv=none; b=qikpwQpOxN0FJHoFiTurlFNCaTCVbwCphID1hWLknVXpS2mWGNupviDZ4yuYGTRDQXps2g4n4tsVDpjHfpZjQtoTkkIQzrVLSHBwYuJBv6eXAWUo2fb9T55MTdOk4XWU2C+U043aIZyP+HBFeXNSHEMs0LH2ZAlO4FPUNFdD3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784722; c=relaxed/simple;
	bh=bADyOcTBBZUwpPcm06ubRYizL0bWyOGXdK/W5xV152Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYQXEZOqKQt6gZM+vQHWmmLzKnTfp45fT5Y9i2HSCd/5jhMTS8awpqgrgkVbiwnZWZOh+LHhXM80XT8JJytK++JjXP3CUSEXGdnLdzBrAu6nusPd8DvpBR73lLms4/qSh+epsIJt63Dh0kB/VvoNNC4VfgBKaM29lyv61XdWF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5Ibinkn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so218435e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729784718; x=1730389518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx6RQ4IOTguti6j4JOHAPTS3WTvI+coioyQGM+yTY58=;
        b=i5IbinknQZG37F64tC/hA2kzBBSiFHVIo/6BeRkBYXmpDpxULK8xvMkfJhgTrEaoG8
         dhsqDk2MBzgrJirVlJMHq/pJlZa8cROYhTGec7Y0DA2Trmo0cRIZj7vgK9R8uZAIc9dq
         buzDy4B+Hlqyas84COLdQDRCCcPjWDdFj5bpQ5eYKDkAfkDBHHuadgJxgX5b6euyx+dX
         8c5hb0ZaMnKDz3jqA4ffFEmLsmGZBFOcOob0VcLVpp1Z9uhGUSmmhufasAe8mK6oG9B6
         NvV3+jqOxs3Bn6PVVyegwW0zFtW4UwHohE5FKktMjR2yEbGwp4jBdA4gOVT3NTvagKyO
         gf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784718; x=1730389518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx6RQ4IOTguti6j4JOHAPTS3WTvI+coioyQGM+yTY58=;
        b=Cq7Z65RdVAW6MD8egalzfpcGg3GwbMfjC8WJ+PqYVIiIpgiav+5utOoEOTo4+RvCpv
         yKwPjZKeq74nI9DE5BplqWW3NymqCINIqJM2qNzwqW+D/fkZ9uFeQwnuUZTemKuHidq8
         DHrFZfsvaK7ydF1K0PUhaZ8Z/JGxSkkc4mW/qpD6s/Ev/YpUp+KJSylvEW/ShgH4UXlR
         mSlfIK1YV0xVPlcXwRmIUoqRtnKpbv0d9q7soalzKxAYeoOcX5s5kGaqwGoQ8w+swd6W
         lUsgELFWM+xhybTvHT1zTWJF0fpANdnW1iVpqdT03FoMLWeC7wC35tYdNqueTFjAAwmM
         V63Q==
X-Gm-Message-State: AOJu0Yy0dKpA5WgHQ8CpUEnU795EJlj3n+5D75HDgJw9GqXjSqQs0YMr
	tTt/kxlwPOx8w1xnnw5gl12NAsO9u6vUlewzWdIFBjiNuuoJvU3x28NbX6v7ptDbra8/7qObEDW
	0UBmIfDdYPAShF+aNQpclqvcHjcdoPr9OBoMW
X-Google-Smtp-Source: AGHT+IGB0X1POfnnRhq4665jiAkYHAzgsgEBZvc6LvogqBdfW8u5BrJiSLxu+lAsdzyqiOxNi5+9E+6zherF0HLTrOA=
X-Received: by 2002:a05:600c:1f14:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-4318aff2d08mr4156805e9.7.1729784717254; Thu, 24 Oct 2024
 08:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024154119.1096947-1-maze@google.com>
In-Reply-To: <20241024154119.1096947-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Thu, 24 Oct 2024 17:44:59 +0200
Message-ID: <CANP3RGf1mWxnkZjtxd-_wD2g+m+zV-6UeB3YPhvo2=UUWwbpYA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: define and implement new SOL_SOCKET
 SO_RX_IFINDEX option
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:41=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> This is currently only implemented for TCP and is not
> guaranteed to return correct information for a multitude
> of reasons (including multipath reception), but there are
> scenarios where it is useful: in particular a strong host
> model where connections are only viable via a single interface,
> for example a VPN interface.  One could for example choose
> to use this to SO_BINDTODEVICE.
>
> Test:
>   // Python 2.7.18 (default, Jul 13 2022, 18:14:36)
>   import socket
>   SO_RX_IFINDEX=3D82
>   s =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
>   c =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
>   s.bind(('::', 8888))
>   s.listen(128)
>   c.connect(('::', 8888))
>   a =3D s.accept()
>   print a  # (<socket._socketobject object>, ('::1', 58144, 0, 0))
>   p=3Da[0]
>   p.getsockname()  # ('::1', 8888, 0, 0)
>   p.getpeername()  # ('::1', 58144, 0, 0)
>   c.getsockname()  # ('::1', 58144, 0, 0)
>   c.getpeername()  # ('::1', 8888, 0, 0)
>   p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
>   c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 0 (unknown)
>   c.send(b'X')  # 1
>   p.recv(2)  # 'X'
>   p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
>   c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 0 (unknown)
>   p.send(b'Z')  # 1
>   c.recv(2)  # 'Z'
>   p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
>   c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
>
> Which shows we should possibly fix the 3-way handshake SYN-ACK
> to set sk->sk_rx_dst_ifindex.
>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  | 2 ++
>  arch/mips/include/uapi/asm/socket.h   | 2 ++
>  arch/parisc/include/uapi/asm/socket.h | 2 ++
>  arch/sparc/include/uapi/asm/socket.h  | 2 ++
>  include/uapi/asm-generic/socket.h     | 2 ++
>  net/core/sock.c                       | 4 ++++
>  6 files changed, 14 insertions(+)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
> index 302507bf9b5d..5f139b095a49 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -148,6 +148,8 @@
>
>  #define SCM_TS_OPT_ID          81
>
> +#define SO_RX_IFINDEX          82
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
> index d118d4731580..ff25d24b4dea 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -159,6 +159,8 @@
>
>  #define SCM_TS_OPT_ID          81
>
> +#define SO_RX_IFINDEX          82
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index d268d69bfcd2..3f89c388e356 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -140,6 +140,8 @@
>
>  #define SCM_TS_OPT_ID          0x404C
>
> +#define SO_RX_IFINDEX          82
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
> index 113cd9f353e3..f1af74f5f1ad 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -141,6 +141,8 @@
>
>  #define SCM_TS_OPT_ID            0x005a
>
> +#define SO_RX_IFINDEX            0x005b
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index deacfd6dd197..b16c69e22606 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -143,6 +143,8 @@
>
>  #define SCM_TS_OPT_ID          81
>
> +#define SO_RX_IFINDEX          82
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 7f398bd07fb7..6c985413c21f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1932,6 +1932,10 @@ int sk_getsockopt(struct sock *sk, int level, int =
optname,
>                 v.val =3D READ_ONCE(sk->sk_mark);
>                 break;
>
> +       case SO_RX_IFINDEX:
> +               v.val =3D READ_ONCE(sk->sk_rx_dst_ifindex);
> +               break;
> +
>         case SO_RCVMARK:
>                 v.val =3D sock_flag(sk, SOCK_RCVMARK);
>                 break;
> --
> 2.47.0.105.g07ac214952-goog
>

Note: I'm not sure if I did the right thing with parisc...
It has:
#define SO_DEVMEM_LINEAR 78
#define SCM_DEVMEM_LINEAR SO_DEVMEM_LINEAR
#define SO_DEVMEM_DMABUF 79
#define SCM_DEVMEM_DMABUF SO_DEVMEM_DMABUF
#define SO_DEVMEM_DONTNEED 80
which is weird...

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

