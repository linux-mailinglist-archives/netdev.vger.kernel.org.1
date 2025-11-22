Return-Path: <netdev+bounces-240931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 811EFC7C2A4
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639314E2FA5
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5F28750B;
	Sat, 22 Nov 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agDzsLuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86223183B
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763777675; cv=none; b=RIbp+N20CZxxy+E64mWAdUKDlRXAzzcdjtML9qdKRsGfvfkzs3+KR1dTxFK8uAQTQx2rxWHvifY3rvVNu5t+2slDa97CBbr11ffpA7VLu3Uyaj+kCtj9WN4d2O5nqGrrRutEotwH8WDjKQzDj+BdhbDvUH2hi4SmWYg51T3680w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763777675; c=relaxed/simple;
	bh=ixATDmWAQHR7JLkejaYEJz4OoiolULOVrQzGKRnEf1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNRzAzlX+u6FC5SbsYVi4zxjqFGC1qUMJR+OTsbYQlANkDzCxgGXx/TB/IzfY825xKo7ho1YGabvKdMz42kkZsUo9DOJcVd/NwOxPUEOfg9mJR/SrKIPvPJIwg2y58562VmrDebMctS9zT65PfF5TCeu6F5O6KFH0XcsmdLfbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agDzsLuy; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11b6bc976d6so3658317c88.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 18:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763777672; x=1764382472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXD8xGLkJpEXCjyfR6EzT6paW99a1b2ciKP2iHRz520=;
        b=agDzsLuy0Y0vpnKUpG4Ch95afHRWjDMxVjxfBrAnQ7wLAMsjYRiA4Q8w89IxzV5Q51
         RuWDalf+52Ekf4mGPwzOy0bVAg1YH3td0GdbJVicQzfPNGVcMMmnLGzns4d+cNztnWyA
         PusrrN97PmTCjbQMa0ezhSwRv/vfRO9gc/8u9R5RgeVEhpISmSi3ivxfVcy86DvJo3UP
         QRDlDQZYxGPkZg1NUBzF1xYixNpnwTIfV10+FqqV3cHTRCqIBRmCUstTh1ovebuWqNb/
         kaYnoC9Q5UXEXw7DlU+nwLrNxZehXhpWO3F7r6sW5jQ2GXFgVED+gNhdzrAXZ9Lo3Yl5
         0sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763777672; x=1764382472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXD8xGLkJpEXCjyfR6EzT6paW99a1b2ciKP2iHRz520=;
        b=YLvb4xryYt78uTlxMDn4/mhuwKEuMoqyOodrB0RCiSSKDiOxuYkeeiUJ7HWCR6T0tT
         LCpt2cu6RPpb/P7i63AaHZMJv1w5qU9zMDI2v1xKUwKALVOjhC3SA/Zo9SWlUNfpCNoi
         qbc2T/uotNEVcYsJrThsfFfNGCl01KlPr6hUjA1itjo9LM8DPXOKQrNJm8p3J2gBkkXf
         jO01bIHH8Xjsb4DKz+T61irZz7UMuVG3ILVi23usBOs3d2UxmJe+BTy2ofOZ1tYyJxtx
         aPfE73vxWHobsTpZS0FBV932hACSQfLJGlrWz9vKye2g9Z9keTsmJ42+Nqup8MWCwqam
         rG3g==
X-Forwarded-Encrypted: i=1; AJvYcCWoISTzI2W1CXU/6qB5VLQDZeuukfaGaz5rfYJq1DN5FryHFDKNS6WOJYi6zxCI/xffgpsj6hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHfVW6sIR3KjmFyvZYq7YShZHSq44HBnexeBBPDh+isc9IhbM
	VzrC/Vr4e1Jw6K9QEugADDOycV6QNUyBs4A8/JBtWFdBKmmgS8US9yuWB2ix7NKguNx+r3VPPd1
	oj3Vvt6zjuHFY/luq83bt5E54QiQYBaOZTuqYl/xH
X-Gm-Gg: ASbGnctmHdFkuolGw4dIZC3uiKcETSbmbNYedWFvi+/KE4L4E9mgs1GHEFN0aYfHzoF
	M70zsGdxyJ3fKrEsmBsLcY3sQC/heVxvZX8YSRWYAE6KKgV7MFbC9gapD0URe6ZVilwRVqVjiIg
	0UcyuU6d692sSwiEirUgyT/SI5a8rvusCkOhhqdQKUq+dLNIsJ4NIOLt3jeHHCCi+GmoOALq3Aq
	c/WfixeXXlkHDRkZcfHD3G8fvz/kFyeRoq29ci/h9h5YKFggXccDQ7UWIhKoctMsnfL5SbP4TtC
	S5524xfyk+FSCXZvZZLH6XQWKCPm
X-Google-Smtp-Source: AGHT+IEQd+Ucgwx1uwTerm8eYBf6Pw3gfuRxhCtxz1f3eUV5q504LT6oNRGWtpJFdyYlKNN0OCTvLlibWfcia6CJb+U=
X-Received: by 2002:a05:7022:1e14:b0:119:e569:f86d with SMTP id
 a92af1059eb24-11c9ca96a9cmr1214969c88.10.1763777672167; Fri, 21 Nov 2025
 18:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121160954.88038-1-krisman@suse.de> <20251121160954.88038-2-krisman@suse.de>
In-Reply-To: <20251121160954.88038-2-krisman@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 21 Nov 2025 18:14:21 -0800
X-Gm-Features: AWmQ_bldxb5SIHv_YOpZvE401zjUsj8FuLj8HQweQYc9mQQFBc9DBQXfMLtf7as
Message-ID: <CAAVpQUAvDMCLySn_gW+abifVpt_=tH771ZzOxVM8mYsO6mgaMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] socket: Unify getsockname and getpeername implementation
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
> They are already implemented by the same get_name hook in the protocol
> level.  Bring the unification one level up to reduce code duplication
> in preparation to supporting these as io_uring operations.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  include/linux/socket.h |  4 +--
>  net/compat.c           |  4 +--
>  net/socket.c           | 55 ++++++++++--------------------------------
>  3 files changed, 16 insertions(+), 47 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 3b262487ec06..937fe331ff1e 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -454,9 +454,7 @@ extern int __sys_connect(int fd, struct sockaddr __us=
er *uservaddr,
>  extern int __sys_listen(int fd, int backlog);
>  extern int __sys_listen_socket(struct socket *sock, int backlog);
>  extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
> -                            int __user *usockaddr_len);
> -extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
> -                            int __user *usockaddr_len);
> +                            int __user *usockaddr_len, int peer);
>  extern int __sys_socketpair(int family, int type, int protocol,
>                             int __user *usockvec);
>  extern int __sys_shutdown_sock(struct socket *sock, int how);
> diff --git a/net/compat.c b/net/compat.c
> index 485db8ee9b28..2c9bd0edac99 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -460,10 +460,10 @@ COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 _=
_user *, args)
>                 ret =3D __sys_accept4(a0, compat_ptr(a1), compat_ptr(a[2]=
), 0);
>                 break;
>         case SYS_GETSOCKNAME:
> -               ret =3D __sys_getsockname(a0, compat_ptr(a1), compat_ptr(=
a[2]));
> +               ret =3D __sys_getsockname(a0, compat_ptr(a1), compat_ptr(=
a[2]), 0);
>                 break;
>         case SYS_GETPEERNAME:
> -               ret =3D __sys_getpeername(a0, compat_ptr(a1), compat_ptr(=
a[2]));
> +               ret =3D __sys_getsockname(a0, compat_ptr(a1), compat_ptr(=
a[2]), 1);
>                 break;
>         case SYS_SOCKETPAIR:
>                 ret =3D __sys_socketpair(a0, a1, a[2], compat_ptr(a[3]));
> diff --git a/net/socket.c b/net/socket.c
> index e8892b218708..ee438b9425da 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2128,12 +2128,11 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr=
 __user *, uservaddr,
>  }
>
>  /*
> - *     Get the local address ('name') of a socket object. Move the obtai=
ned
> - *     name to user space.
> + *     Get the address (remote or local ('name')) of a socket object. Mo=
ve the

nit: Get the remote or local address ('name')

Otherwise, looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> + *     obtained name to user space.
>   */
> -
>  int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
> -                     int __user *usockaddr_len)
> +                     int __user *usockaddr_len, int peer)
>  {
>         struct socket *sock;
>         struct sockaddr_storage address;
> @@ -2146,11 +2145,14 @@ int __sys_getsockname(int fd, struct sockaddr __u=
ser *usockaddr,
>         if (unlikely(!sock))
>                 return -ENOTSOCK;
>
> -       err =3D security_socket_getsockname(sock);
> +       if (peer)
> +               err =3D security_socket_getpeername(sock);
> +       else
> +               err =3D security_socket_getsockname(sock);
>         if (err)
>                 return err;
>
> -       err =3D READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&a=
ddress, 0);
> +       err =3D READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&a=
ddress, peer);
>         if (err < 0)
>                 return err;
>
> @@ -2161,44 +2163,13 @@ int __sys_getsockname(int fd, struct sockaddr __u=
ser *usockaddr,
>  SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockadd=
r,
>                 int __user *, usockaddr_len)
>  {
> -       return __sys_getsockname(fd, usockaddr, usockaddr_len);
> -}
> -
> -/*
> - *     Get the remote address ('name') of a socket object. Move the obta=
ined
> - *     name to user space.
> - */
> -
> -int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
> -                     int __user *usockaddr_len)
> -{
> -       struct socket *sock;
> -       struct sockaddr_storage address;
> -       CLASS(fd, f)(fd);
> -       int err;
> -
> -       if (fd_empty(f))
> -               return -EBADF;
> -       sock =3D sock_from_file(fd_file(f));
> -       if (unlikely(!sock))
> -               return -ENOTSOCK;
> -
> -       err =3D security_socket_getpeername(sock);
> -       if (err)
> -               return err;
> -
> -       err =3D READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&a=
ddress, 1);
> -       if (err < 0)
> -               return err;
> -
> -       /* "err" is actually length in this case */
> -       return move_addr_to_user(&address, err, usockaddr, usockaddr_len)=
;
> +       return __sys_getsockname(fd, usockaddr, usockaddr_len, 0);
>  }
>
>  SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockadd=
r,
>                 int __user *, usockaddr_len)
>  {
> -       return __sys_getpeername(fd, usockaddr, usockaddr_len);
> +       return __sys_getsockname(fd, usockaddr, usockaddr_len, 1);
>  }
>
>  /*
> @@ -3162,12 +3133,12 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned l=
ong __user *, args)
>         case SYS_GETSOCKNAME:
>                 err =3D
>                     __sys_getsockname(a0, (struct sockaddr __user *)a1,
> -                                     (int __user *)a[2]);
> +                                     (int __user *)a[2], 0);
>                 break;
>         case SYS_GETPEERNAME:
>                 err =3D
> -                   __sys_getpeername(a0, (struct sockaddr __user *)a1,
> -                                     (int __user *)a[2]);
> +                   __sys_getsockname(a0, (struct sockaddr __user *)a1,
> +                                     (int __user *)a[2], 1);
>                 break;
>         case SYS_SOCKETPAIR:
>                 err =3D __sys_socketpair(a0, a1, a[2], (int __user *)a[3]=
);
> --
> 2.51.0
>

