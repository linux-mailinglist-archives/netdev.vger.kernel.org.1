Return-Path: <netdev+bounces-240932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F3C7C2AA
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67C294E1472
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6A22D7A5;
	Sat, 22 Nov 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJEh+XZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640019D065
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763777763; cv=none; b=UwQPUkjbupEqsIdqWCri+SlRI32n78sjgqAiUR22T/6dZpjwUhpEIcIT2nQ4iCSlbBefXjx+M329StBBI6uR7a5xwNsPDzQRq7qUnbeBdJ+VFQaSyoWvDz5Mh67dpU68SvfWCcbCDQpwxor+SAFeZPOY52PsfTbOFHvm6pXxgbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763777763; c=relaxed/simple;
	bh=BHFJkb65NF6jyvP92hQZHaZ7yu+Ipv4m4/djl5gPcR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC4fmVbj9Fza7QylxEaWMIylM2T3iGdiLjNQBzQBmNveTgN1yFDGzpMAeI+A7+B2ZKSjsS1xeFCIAGp0bMej2IweM2bo4EbJ4IMiB3P79zoJwx9YsmXq2t673hixcgtPDA4UmBmrp9aRcGW61hexXo2IIfR+VCsMsIrK/NNs9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJEh+XZw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so3104540b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763777761; x=1764382561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwZHqk6D7/ztotFEOHDmupQkGYG2hAiZI4I+YGJ0Cng=;
        b=qJEh+XZwr2LDy3eFEKJtiZ8jGVMHXLfLVrkQMBDfZ8oX7HnrBHSwQGJOw+SjPgXplv
         3N++gIwLRnR3rIzlTaeKvjT0yr2sbsigq2pueJSYyTQvxiEpfrcDWkn8jLlpQBwO+eDm
         mVe4k65Cea4iOUJjT4wvun43hejgdCUUTtotvFTLwBLYSi9ukPkXjSOBVCbbKlDwXF+g
         +6erRFK0LDLthlNcBGUuabOIxIQ2Fv6hF7TW7NMPCj7JEDT9zrufTbN6ln5rTraCdOts
         YRg5jO2hD+pcF3sJqhTnY0IXchpkslGSaexT9o+fhsyP+lLOWrGI2mBBvBFqeKUFGbsn
         Mrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763777761; x=1764382561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MwZHqk6D7/ztotFEOHDmupQkGYG2hAiZI4I+YGJ0Cng=;
        b=n+fLIkaje5tqGmQUgyOLKMgwMt1M8s4MsQ/ScftqP+gKMRWKUDbjezw+qXLfQ/N3id
         qkJuci5/P4GWF4QtKJ6xe9NnntowTcA8hW0bvpg7BPBeSEhiGrwMIIl6fgfAxd1rxqNS
         kT8CFIAPhbezTb8pIQmAopwnzB0pLyK4XBeKs6lGLnvKMrLLn7iHG5TPlErqbHEZhnnO
         Ero5ne3OgTXl+UeI5+J5rotS07WtFRpfAB3zh3K0AnHYEU2HXFXkSWD0za7Rd7a6IDRl
         6lOEHC06q9jf2PIWeGftOvBfhTKY6ESPf/oqXvdpG7sij1UBJvqRKPv0qyPNu4iwpBSt
         8pgw==
X-Forwarded-Encrypted: i=1; AJvYcCXGSYh6TNzybyJbBoohAz1saCd9SYYuikgYcHGcxFpitN/z3Z+udwApw4Xlc4WhdVQV80P5Ab8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUzRBcwEYR6fPZei9to3X70uoxriRyk1BBNzOpN7GYMFodLqq
	DboCgt4RrFn1N9Wbll5+6RQOATygJGpu6QSlhEs+V7NUH/e9Uf42v4R8UUTZlqtUA+wMXT/8y8b
	wIZkTj3hpGLSEpjmNTtDrM4+S6O59IFpi8qwhybQIpGXguBbqQgqRmXc7l9g=
X-Gm-Gg: ASbGncszjUJx9qoG7yEj+2XcgGclf4/pDtr2/r8ZhYDBevxPPMxtSGYFocJl0jWpQ+w
	6A9HahzaaHHjwkbh686I3/giY2ouyi6JbiZNp5TS2I/W9mxB2hND49M5QfkgmymbM4KE/u++2Cs
	6FQ37sSCAG7bEOo0XNRRqCC11wPWCcHEPOWznnCLsTqvZ0uhwqSMikJL7QM8VOxv6WZL1iju3Q9
	SAmubzMjojGNXeVJNz9vwpX0h7BDxrFlFONroTxLkhTRrzUesfkyZ28X4btDWt0GbajEbw3WzB1
	Dli+8rPHHJJ6gWkcmdm/pDArGHQK
X-Google-Smtp-Source: AGHT+IFUCKrwrkIcJ5jIciiCusYue03VCH60BWqW2feFIKgRses9GzdMsYNos9kodqTwN4Qd4PyVYtvrtAC+VnfymC4=
X-Received: by 2002:a05:7022:6610:b0:11b:9386:825e with SMTP id
 a92af1059eb24-11c9d8720a1mr1680122c88.43.1763777761039; Fri, 21 Nov 2025
 18:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121160954.88038-1-krisman@suse.de> <20251121160954.88038-3-krisman@suse.de>
In-Reply-To: <20251121160954.88038-3-krisman@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 21 Nov 2025 18:15:50 -0800
X-Gm-Features: AWmQ_bkwrD2nvWkLk9hhcPJr_JfmdYMmx4MR6B5cjS0XjdSIov_5qt_nublNG5s
Message-ID: <CAAVpQUAPrmDH6-ZiEioJ_sohbQ-kBu1MFBssPVzY34FRnsnz0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] socket: Split out a getsockname helper for io_uring
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:10=E2=80=AFAM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Similar to getsockopt, split out a helper to check security and issue
> the operation from the main handler that can be used by io_uring.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  include/linux/socket.h |  2 ++
>  net/socket.c           | 34 +++++++++++++++++++---------------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 937fe331ff1e..5afb5ef2990c 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -453,6 +453,8 @@ extern int __sys_connect(int fd, struct sockaddr __us=
er *uservaddr,
>                          int addrlen);
>  extern int __sys_listen(int fd, int backlog);
>  extern int __sys_listen_socket(struct socket *sock, int backlog);
> +extern int do_getsockname(struct socket *sock, struct sockaddr_storage *=
address,
> +                         int peer, struct sockaddr __user *usockaddr, in=
t __user *usockaddr_len);
>  extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
>                              int __user *usockaddr_len, int peer);
>  extern int __sys_socketpair(int family, int type, int protocol,
> diff --git a/net/socket.c b/net/socket.c
> index ee438b9425da..9c110b529cdd 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2127,6 +2127,24 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr =
__user *, uservaddr,
>         return __sys_connect(fd, uservaddr, addrlen);
>  }
>
> +int do_getsockname(struct socket *sock, struct sockaddr_storage *address=
, int peer,
> +                  struct sockaddr __user *usockaddr, int __user *usockad=
dr_len)
> +{
> +       int err;
> +
> +       if (peer)
> +               err =3D security_socket_getpeername(sock);
> +       else
> +               err =3D security_socket_getsockname(sock);
> +       if (err)
> +               return err;
> +       err =3D READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)ad=
dress, peer);
> +       if (err < 0)
> +               return err;
> +       /* "err" is actually length in this case */
> +       return move_addr_to_user(address, err, usockaddr, usockaddr_len);
> +}
> +
>  /*
>   *     Get the address (remote or local ('name')) of a socket object. Mo=
ve the
>   *     obtained name to user space.
> @@ -2137,27 +2155,13 @@ int __sys_getsockname(int fd, struct sockaddr __u=
ser *usockaddr,
>         struct socket *sock;
>         struct sockaddr_storage address;

Could you move this to do_getsockname() ?

The patch 3 also does not need to define it.


>         CLASS(fd, f)(fd);
> -       int err;
>
>         if (fd_empty(f))
>                 return -EBADF;
>         sock =3D sock_from_file(fd_file(f));
>         if (unlikely(!sock))
>                 return -ENOTSOCK;
> -
> -       if (peer)
> -               err =3D security_socket_getpeername(sock);
> -       else
> -               err =3D security_socket_getsockname(sock);
> -       if (err)
> -               return err;
> -
> -       err =3D READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&a=
ddress, peer);
> -       if (err < 0)
> -               return err;
> -
> -       /* "err" is actually length in this case */
> -       return move_addr_to_user(&address, err, usockaddr, usockaddr_len)=
;
> +       return do_getsockname(sock, &address, peer, usockaddr, usockaddr_=
len);
>  }
>
>  SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockadd=
r,
> --
> 2.51.0
>

