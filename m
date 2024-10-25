Return-Path: <netdev+bounces-139142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E199B060D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BF928317F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D12022EC;
	Fri, 25 Oct 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlQl1+fe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F7212171
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867474; cv=none; b=lrl0WXxZmogI9QKDHTtrWu3xnoELnEYlIQp0IfJvzrLIRiKlIRU/lmYWGAeH6TUt4zK8oBrSvYq/P8cg8iQQNI1Q27NUBORSM4+pCHdpFf4nsq/as++cUdGnl+HpSAS7/XTfvMQVFLKatSoAczrg9zVcrhE8TMffFhx5ICqRlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867474; c=relaxed/simple;
	bh=xXyaenSZWxcNEDIWK/wS/GUlgDNsg9t7l1vV5tloyAg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=svTBH+HnJiayC619/vFTwjUqrsTcgBiglE5CQNWq+dNnE6w35f1dPZYdaYvcyQtL0kkS+hXirrVL99r4yWSDctqcc7ddvjKoLnN+uPY2pKw7W23Ou/2e+AY341kV6Q47FsxKg8oHRhWn1LmPKuQ7hoETXrBLTsl2RNOieDoRq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlQl1+fe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4611abb6bd5so10975911cf.1
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729867471; x=1730472271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adXStwVy6dxwqClf5SGi+fGiePGZeqzntdE4f1cFzkg=;
        b=nlQl1+feckOzD2BElPdfEEu6W2EM7S5n/O0vJy4ci6rAPTAIgN2fPMtU9QN+ocYF/l
         PKomxbLD97hq3AIwKkrKjhIIi7prK/n80h+b3Q1WXzq85mOeQ3rHI4jOFlUpaoFTmQoq
         1koL7Pqzw96al4N0655kdnmzWA72V0FY4D98JVOdaRM/IALhtSHvdPtnCo0YQhUa+pTN
         4x9A7uTDa9D7pETcDKTKR0t+7uDHNl7wKQBBFUo936UKAkoa5k5RUz3OvliO/drShvwU
         qGM6Ncu1IpXS0TkppT3XfCedZIfkVHACJzOLyfKil+ZmGci2UdSlwlnugrapFu9u+b9a
         w7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867471; x=1730472271;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=adXStwVy6dxwqClf5SGi+fGiePGZeqzntdE4f1cFzkg=;
        b=pwCg7oX1qdtcvJmZppQi+tdRc7JT7umHNUyu9n2Tn5RdktMbCjST/mW2baLwCe8bek
         ygJimt3mnE7Fra0wILHzYTVPvTUGPNNWrnlTY77LZS2I3MNPDH8hVY2S0RQMwZ4ViQAm
         xy5t3VKgNQmJi6XCvgeog/RXbFIt2UcsE00auHVLYG4cgLMXhElu5Ni2D52I9debX8tA
         e9j6VlheVxSqcwE2z0QGzosuLiJMfemps1AwKSeJEuP6czs3CTY2ijBDZ27LtLtz+mIM
         JFSQ3eBvh1ad6nN/Gcg7oYQ5aQBuDmiSopfalFkGUB8UaG66mt3imQtp+fVlPguszI4/
         K1zg==
X-Gm-Message-State: AOJu0Yxf1fu3BGSx/N6Chuyeag/SXJXIcS5hGadC1XAJThdCaDxsc6DV
	na+6rwTKbIcWpgt0/qf3ff00yN3VclEg6jo4V2xwR5IpVCrEAfBg
X-Google-Smtp-Source: AGHT+IG40ZM+ldhNJLasD+JNI4hNNOGpfRdgXae1XHfKYeoLwpvSSklyD807H9hYpvRbujpkNzz5xA==
X-Received: by 2002:a05:622a:40d:b0:461:2b8b:52db with SMTP id d75a77b69052e-4612b8b58e7mr63087551cf.37.1729867470779;
        Fri, 25 Oct 2024 07:44:30 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132297c39sm6545811cf.50.2024.10.25.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:44:30 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:44:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <zenczykowski@gmail.com>, 
 =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Colitti <lorenzo@google.com>
Message-ID: <671baecdaa3e9_34060c294e2@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGf1mWxnkZjtxd-_wD2g+m+zV-6UeB3YPhvo2=UUWwbpYA@mail.gmail.com>
References: <20241024154119.1096947-1-maze@google.com>
 <CANP3RGf1mWxnkZjtxd-_wD2g+m+zV-6UeB3YPhvo2=UUWwbpYA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: define and implement new SOL_SOCKET
 SO_RX_IFINDEX option
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej =C5=BBenczykowski wrote:
> On Thu, Oct 24, 2024 at 5:41=E2=80=AFPM Maciej =C5=BBenczykowski <maze@=
google.com> wrote:
> >
> > This is currently only implemented for TCP and is not
> > guaranteed to return correct information for a multitude
> > of reasons (including multipath reception), but there are
> > scenarios where it is useful: in particular a strong host
> > model where connections are only viable via a single interface,
> > for example a VPN interface.  One could for example choose
> > to use this to SO_BINDTODEVICE.

Fair to say that this is the equivalent of ipi_ifindex in IP_PKTINFO,
but for non datagram sockets where skb_iff cannot be read directly?

> >
> > Test:
> >   // Python 2.7.18 (default, Jul 13 2022, 18:14:36)
> >   import socket
> >   SO_RX_IFINDEX=3D82
> >   s =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
> >   c =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
> >   s.bind(('::', 8888))
> >   s.listen(128)
> >   c.connect(('::', 8888))
> >   a =3D s.accept()
> >   print a  # (<socket._socketobject object>, ('::1', 58144, 0, 0))
> >   p=3Da[0]
> >   p.getsockname()  # ('::1', 8888, 0, 0)
> >   p.getpeername()  # ('::1', 58144, 0, 0)
> >   c.getsockname()  # ('::1', 58144, 0, 0)
> >   c.getpeername()  # ('::1', 8888, 0, 0)
> >   p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
> >   c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 0 (unknown)
> >   c.send(b'X')  # 1
> >   p.recv(2)  # 'X'
> >   p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
> >   c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 0 (unknown)
> >   p.send(b'Z')  # 1
> >   c.recv(2)  # 'Z'
> >   p.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
> >   c.getsockopt(socket.SOL_SOCKET, SO_RX_IFINDEX)  # 1 (lo)
> >
> > Which shows we should possibly fix the 3-way handshake SYN-ACK
> > to set sk->sk_rx_dst_ifindex.
> >
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >  arch/alpha/include/uapi/asm/socket.h  | 2 ++
> >  arch/mips/include/uapi/asm/socket.h   | 2 ++
> >  arch/parisc/include/uapi/asm/socket.h | 2 ++
> >  arch/sparc/include/uapi/asm/socket.h  | 2 ++
> >  include/uapi/asm-generic/socket.h     | 2 ++
> >  net/core/sock.c                       | 4 ++++
> >  6 files changed, 14 insertions(+)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/includ=
e/uapi/asm/socket.h
> > index 302507bf9b5d..5f139b095a49 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -148,6 +148,8 @@
> >
> >  #define SCM_TS_OPT_ID          81
> >
> > +#define SO_RX_IFINDEX          82
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/=
uapi/asm/socket.h
> > index d118d4731580..ff25d24b4dea 100644
> > --- a/arch/mips/include/uapi/asm/socket.h
> > +++ b/arch/mips/include/uapi/asm/socket.h
> > @@ -159,6 +159,8 @@
> >
> >  #define SCM_TS_OPT_ID          81
> >
> > +#define SO_RX_IFINDEX          82
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/incl=
ude/uapi/asm/socket.h
> > index d268d69bfcd2..3f89c388e356 100644
> > --- a/arch/parisc/include/uapi/asm/socket.h
> > +++ b/arch/parisc/include/uapi/asm/socket.h
> > @@ -140,6 +140,8 @@
> >
> >  #define SCM_TS_OPT_ID          0x404C
> >
> > +#define SO_RX_IFINDEX          82
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
> > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/includ=
e/uapi/asm/socket.h
> > index 113cd9f353e3..f1af74f5f1ad 100644
> > --- a/arch/sparc/include/uapi/asm/socket.h
> > +++ b/arch/sparc/include/uapi/asm/socket.h
> > @@ -141,6 +141,8 @@
> >
> >  #define SCM_TS_OPT_ID            0x005a
> >
> > +#define SO_RX_IFINDEX            0x005b
> > +
> >  #if !defined(__KERNEL__)
> >
> >
> > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gen=
eric/socket.h
> > index deacfd6dd197..b16c69e22606 100644
> > --- a/include/uapi/asm-generic/socket.h
> > +++ b/include/uapi/asm-generic/socket.h
> > @@ -143,6 +143,8 @@
> >
> >  #define SCM_TS_OPT_ID          81
> >
> > +#define SO_RX_IFINDEX          82
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__I=
LP32__))
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 7f398bd07fb7..6c985413c21f 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1932,6 +1932,10 @@ int sk_getsockopt(struct sock *sk, int level, =
int optname,
> >                 v.val =3D READ_ONCE(sk->sk_mark);
> >                 break;
> >
> > +       case SO_RX_IFINDEX:
> > +               v.val =3D READ_ONCE(sk->sk_rx_dst_ifindex);
> > +               break;
> > +

If it is limited to TCP, return error in other cases.

So that we can extend it later with well defined behavior.

> >         case SO_RCVMARK:
> >                 v.val =3D sock_flag(sk, SOCK_RCVMARK);
> >                 break;
> > --
> > 2.47.0.105.g07ac214952-goog
> >
> =

> Note: I'm not sure if I did the right thing with parisc...
> It has:
> #define SO_DEVMEM_LINEAR 78
> #define SCM_DEVMEM_LINEAR SO_DEVMEM_LINEAR
> #define SO_DEVMEM_DMABUF 79
> #define SCM_DEVMEM_DMABUF SO_DEVMEM_DMABUF
> #define SO_DEVMEM_DONTNEED 80
> which is weird...

This is a common pattern.

To define separate SCM constants for cmsg fields, even though they
have the same constant as their [gs]etsockopt counterparts.



