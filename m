Return-Path: <netdev+bounces-221482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD44B50983
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E7C7A7CE8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3FB17D2;
	Wed, 10 Sep 2025 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXUVzznj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60BF9EC
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462647; cv=none; b=r62KjYCSsrDEvHmEaEhqw/2iTZ/tUNTJFN/4qT5BKm706PIqVJ7Xg2s00z2crF5NtROUn+S5v4mnuyhIt8gaiN+DV+6AQp2dKvq4q5keq9T+SG0cAX0aWbCKMNFEAUFJNWux4nzzWTCMzEZKumbVGf5NH7YGHCMW4uvQEyQPtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462647; c=relaxed/simple;
	bh=4zV5RuNIyXG55ULWhnhF/NYTqg/90+SorMFur54xQaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNXtltp3NNhauHfYHN4NgCBDjOTcBefLorft+7A6/8Jn66VKV+QTUGXth8fOh3NlYUyeyvhwfb1iKJ1EtoAn1DICasokNboo3TUR/xnyINStNr913JRe/UjQpT7gFNJczBBGT1WanerS0sKC58hfnutYDJ49L1H61QmPnXI2/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXUVzznj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4dc35711d9so4403645a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757462645; x=1758067445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ja5aRRK67yFY84DIpJGjj5+ToCTaviVbIKyJTpFdU0=;
        b=CXUVzznjotdBQdnwv9JKEjJp6iBkX1S3nsRGhRrO1g/Vdiuj4AJBBmXUT6HPG1EHsT
         jLCyBQ7W95q3FYuMkEFL1bP1ataZyAvx3GSr0RNTiiy4u+fwpDlBYiGUWqQLKTk4HRZa
         n65AAQS25jj6tg6N4casvjj2oAOFTZszSY/QeJOOXUVkGtwoz/kQUseZbMIr3HsUY8VH
         aL0EqswxqzwYNnzEWXo4BHJM+7NIvsLAGf88TLLEIWzib/oGJ9NjVeBfaol99+A09G09
         qs992iYVdepsSKxv2eIVyt64oLipQKzYfxN+UXX7I0dOxfKfZ3IKo2fxvHRDd9H0yLrE
         hkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757462645; x=1758067445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ja5aRRK67yFY84DIpJGjj5+ToCTaviVbIKyJTpFdU0=;
        b=H4NXmVYuv11S/6OqQDTvzDcSV/9feDUI5TuA5noJYZkCOFajpAsaQ0TAdhxCY4JQ+T
         aAZ7hb57Dke/9iwJZLuOj/FvAttB4gbhWmblEgcg3cfYkOpXEIyiDZdo7W0fiuuXiwwG
         t6X7t7lFFcnvLj+/8+0HF4MNi6a7c1+N7rYn+20eITZyuD0QLz1+fj303kSIr+eHs7Qg
         4LcxLXNYY97QYTdSfSF5JdsvnqhogJP4c8yTEun0hL+9z5TxwQRQibmsx2NGkHzbFeK7
         n+aGTxhJka6jrDZnI9chTJvjNMAnTaWShY5cmZVO1kiTQX9FUucwfYZYI++YAEqXYJk9
         p6jw==
X-Forwarded-Encrypted: i=1; AJvYcCWd812RK9NF3T6jtCkVFh1MzwYh9zGOfa9Y7fU+D9oFKjC2TgZpZyuS+ePCe6SvvbxqqbbT51Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiyHZWLQYmzBW99oWlQSqtDbJb7/g+3vdiO+4mpN7dDNx5gB2
	+AwANrX5AOR5mvU52NXV5TabCrbbNAkjh+oWVwzlYxmyMj2+rRZVSfhTpjQc0UAixBvWkCleOko
	TFKoZJhJNYZY3G55aR9uYrCQM/90NfxRE4AMbhAut
X-Gm-Gg: ASbGncs96vgFKwlSJPwsyLKMzs3OLkrcE77j0+T3b+7b4dyxh+dCI0C+MuzZJ3jMS5w
	eDVDZZQ0E8TqtmBxbAUF2djuc4bjJIgGT1FUAEZRlL74+XHMej2gIJZFT208+MBZXGhe5h4jvt6
	L+fDJrpoeObAFz1/WvZPERgBFTZ5tzSAkmwI4KEsYTX3EWC2F5fnwdo8rlaJOINp3XNqdFp5k1Y
	6Sto3vnSeLoY/m9eo8qVC9nyf+gUks/TPar4EDpz3sv
X-Google-Smtp-Source: AGHT+IE1zcbuYIv4rWiM6Yf7a30YVxQGUJN+yzUzpQbD3OH+04xeheTD0mOt4U7WbsqIOFfpCPJjmO4LifM2Y8vMlK4=
X-Received: by 2002:a17:903:acc:b0:246:cfc4:9a30 with SMTP id
 d9443c01a7336-25173118d80mr176547935ad.35.1757462644670; Tue, 09 Sep 2025
 17:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170011.239356-1-jordan@jrife.io> <20250909170011.239356-12-jordan@jrife.io>
In-Reply-To: <20250909170011.239356-12-jordan@jrife.io>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 9 Sep 2025 17:03:53 -0700
X-Gm-Features: Ac12FXwbFj82XjsFYqjpS_h3rixgtfK0Hw3QdCZncnZWLUkWeREwv9zScHpVq9E
Message-ID: <CAAVpQUA8VyP=eHtQ3p4XJYwsU5Qq7L-k1FRGhPN+K9K+OeBZ+w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 11/14] bpf: Introduce BPF_SOCK_OPS_UDP_CONNECTED_CB
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:00=E2=80=AFAM Jordan Rife <jordan@jrife.io> wrote=
:
>
> Add the BPF_SOCK_OPS_UDP_CONNECTED_CB callback as a sockops hook where
> connected UDP sockets can be inserted into a socket map. This is
> invoked on calls to connect() for UDP sockets right after the socket is
> hashed. Together with the next patch, this provides the missing piece
> allowing us to fully manage the contents of a socket hash in an
> environment where we want to keep track of all UDP and TCP sockets
> connected to some backend.
>
> is_locked_tcp_sock was recently introduced in [1] to prevent access to
> TCP-specific socket fields in contexts where the socket lock isn't held.
> This patch extends the use of this field to prevent access to these
> fields in UDP socket contexts.
>
> Note: Technically, there should be nothing preventing the use of
>       bpf_sock_ops_setsockopt() and bpf_sock_ops_getsockopt() in this
>       context, but I've avoided removing the is_locked_tcp_sock_ops()
>       guard from these helpers for now to keep the changes in this patch
>       series more focused.
>
> [1]: https://lore.kernel.org/all/20250220072940.99994-4-kerneljasonxing@g=
mail.com/
>
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  include/net/udp.h              | 43 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/bpf.h       |  3 +++
>  net/ipv4/udp.c                 |  1 +
>  net/ipv6/udp.c                 |  1 +
>  tools/include/uapi/linux/bpf.h |  3 +++
>  5 files changed, 51 insertions(+)
>
> diff --git a/include/net/udp.h b/include/net/udp.h
> index e2af3bda90c9..0f55c489e90f 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -18,6 +18,7 @@
>  #ifndef _UDP_H
>  #define _UDP_H
>
> +#include <linux/filter.h>
>  #include <linux/list.h>
>  #include <linux/bug.h>
>  #include <net/inet_sock.h>
> @@ -25,6 +26,7 @@
>  #include <net/sock.h>
>  #include <net/snmp.h>
>  #include <net/ip.h>
> +#include <linux/bpf-cgroup.h>
>  #include <linux/ipv6.h>
>  #include <linux/seq_file.h>
>  #include <linux/poll.h>
> @@ -661,4 +663,45 @@ struct sk_psock;
>  int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r=
estore);
>  #endif
>
> +#ifdef CONFIG_BPF
> +
> +/* Call BPF_SOCK_OPS program that returns an int. If the return value
> + * is < 0, then the BPF op failed (for example if the loaded BPF
> + * program does not support the chosen operation or there is no BPF
> + * program loaded).
> + */
> +static inline int udp_call_bpf(struct sock *sk, int op)
> +{
> +       struct bpf_sock_ops_kern sock_ops;
> +       int ret;
> +
> +       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> +       if (sk_fullsock(sk)) {
> +               sock_ops.is_fullsock =3D 1;
> +               /* sock_ops.is_locked_tcp_sock not set. This prevents
> +                * access to TCP-specific fields.
> +                */
> +               sock_owned_by_me(sk);
> +       }
> +
> +       sock_ops.sk =3D sk;
> +       sock_ops.op =3D op;
> +
> +       ret =3D BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
> +       if (ret =3D=3D 0)
> +               ret =3D sock_ops.reply;
> +       else
> +               ret =3D -1;
> +       return ret;
> +}
> +
> +#else
> +
> +static inline int udp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *=
args)
> +{
> +       return -EPERM;
> +}
> +
> +#endif /* CONFIG_BPF */
> +
>  #endif /* _UDP_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 22761dea4635..e30515af1f27 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7122,6 +7122,9 @@ enum {
>                                          * sendmsg timestamp with corresp=
onding
>                                          * tskey.
>                                          */
> +       BPF_SOCK_OPS_UDP_CONNECTED_CB,  /* Called on connect() for UDP so=
ckets
> +                                        * right after the socket is hash=
ed.
> +                                        */
>  };
>
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detec=
t
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index cc3ce0f762ec..2d51d0ead70d 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2153,6 +2153,7 @@ static int udp_connect(struct sock *sk, struct sock=
addr *uaddr, int addr_len)
>         res =3D __ip4_datagram_connect(sk, uaddr, addr_len);
>         if (!res)
>                 udp4_hash4(sk);
> +       udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);

Why is this called on failure ?

Same for IPv6.


>         release_sock(sk);
>         return res;
>  }
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6a68f77da44b..304b43851e16 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1310,6 +1310,7 @@ static int udpv6_connect(struct sock *sk, struct so=
ckaddr *uaddr, int addr_len)
>         res =3D __ip6_datagram_connect(sk, uaddr, addr_len);
>         if (!res)
>                 udp6_hash4(sk);
> +       udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
>         release_sock(sk);
>         return res;
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 22761dea4635..e30515af1f27 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7122,6 +7122,9 @@ enum {
>                                          * sendmsg timestamp with corresp=
onding
>                                          * tskey.
>                                          */
> +       BPF_SOCK_OPS_UDP_CONNECTED_CB,  /* Called on connect() for UDP so=
ckets
> +                                        * right after the socket is hash=
ed.
> +                                        */
>  };
>
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detec=
t
> --
> 2.43.0
>

