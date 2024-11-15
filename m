Return-Path: <netdev+bounces-145133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C349CD54D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7DD2817D6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BC136338;
	Fri, 15 Nov 2024 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS7lpVjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028C10F2;
	Fri, 15 Nov 2024 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637121; cv=none; b=t2ZHr1VDMWVYECQkFTRxTGJcKtFwjQjKLaxyRbRNnQvbkRC62y+f7oSZ7qyjsuukndpZP0etUEHqWWF6fcAGvajnS5HwgIncvSuuB35hwhOKmmwHI5VQNbtmWqJC8Q814eAamyDUY70UoT4NtXkL51vurfyLdOx5QCGNvRjF82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637121; c=relaxed/simple;
	bh=Qph75JNweT1LLR1DcyPp2qzd9+4Dn5t6LiP6wvbqJ0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asWyaAYKmjA4Zq5WGdhf2bL9AHuugjfRHyvttUWNGMjEobc7aG5HM1jNRj+Z9f8TsLigrXsc0ebXRpi1Osac9ohrJvX8cuXEL6NV3nbtpaxLfw03w4xkdCn9eraR6rrNBtKOSSjZ6UCtjCxIP7IpD2qg2amZz6yekIuPdCyUYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS7lpVjl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2110a622d76so11595865ad.3;
        Thu, 14 Nov 2024 18:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731637119; x=1732241919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeJPW6UAwV1UVyW8s7LJ69vgYJBnWwJLegIzuqvSMQQ=;
        b=gS7lpVjl6illiDItX6/OjAAKS6S4ZjQvwmquz+z/SAduO1sLqOenjocIY/Vua9+PVS
         zpysWVepYtkU2+eDx3gBziuKcy8q5HaOE1mcGV6qRwgozIAvh7dhofI6Fp1wJjh59XpX
         A/OZ17BAP6OaVE5Eaxl+emMbXze0XxoEu9TTMOaPjxH95YnMOGwDyIAAieSSMPGZcm+H
         1dBpvLwS6Bx117A0KzSq9moeJvZ9iz2/rbkR/nuGHq1FnQLof/ZTsoM3bOhOfW/0CYii
         y7pNDqr2idQPUGW9KSjNyF4HPCgWurlHknkStjPhXBKTTpXS5mSfNnnaIxYH0X/5oxQg
         Ipdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731637119; x=1732241919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeJPW6UAwV1UVyW8s7LJ69vgYJBnWwJLegIzuqvSMQQ=;
        b=EoPp0gRlgest6AL2p7iGCVR1cJrM9SYxlgZcbMR3CCs/er27knibTCNT5IwqwJn9lv
         S87R48ZY6zgULurkVYrvVMf2X2BFDuzEKDXiulFSLf0RDLwjGMbDlxvQMhVH7X1st4c6
         1KkT109arsCa2AYJTX5aju2f7EqIzXC3DT6e782cBJEfCVGPlvi7yrBmEP5ZKzGBJnni
         jC8X9dcNJenNIGPstnJsBGddRXmL6lzdXyvsURSYPRef92qGCO8C/MbmZT6T2A2b83T7
         vCS0StsOs+u+/6sA3per2QeOFLcp1cpzgWPVoug0IZ9KMgGj4yVScifo8gkug69ExgL7
         ZEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUheu1wGuiq4hObhQ/22J4FAiK+A7k4jiBkVxmEhDT82amvwHYhBlPvMpb5nn0jPI5olo9LCSrx@vger.kernel.org, AJvYcCUzZy3Si3FUk0fgOIRH37QWt+tvKFfJ86d/zkbVRxMH1no47OFKZ75z77AQrF+6S382Dt71jj/dif7c3yqW4cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzaHfldE45B8Tw71+o8qxWVVfer0RawLBc1mCOZvBnGo8OfWW
	lhhVD3bKMZe/fgMzB+lZgL1LqtFx714LbFGY8DuxYYoxCPwikFRw6HkFSbQgjTJ5CZK3LqO2Bt9
	FzuLAWDN/gxYayR/beRTne/hryZw=
X-Google-Smtp-Source: AGHT+IHRy9WTqwJZTYoDkJo5vOGYP0aPTr61U99yGuw2nfMFdQukR3yRm5J6pvCCXtuwf542nd68QfFe4+DiOLEEzh0=
X-Received: by 2002:a17:902:ec8e:b0:207:3a53:fe67 with SMTP id
 d9443c01a7336-211d0d77f83mr18054155ad.32.1731637119135; Thu, 14 Nov 2024
 18:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co> <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Nov 2024 21:18:24 -0500
Message-ID: <CABBYNZKYn9anog0tK3d_k3A9ENXBX_YA=v1+z5jiGdiNaJWVzg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
To: Michal Luczaj <mhal@rbox.co>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Thu, Nov 14, 2024 at 6:33=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> The bt_copy_from_sockptr() return value is being misinterpreted by most
> users: a non-zero result is mistakenly assumed to represent an error code=
,
> but actually indicates the number of bytes that could not be copied.
>
> Remove bt_copy_from_sockptr() and adapt callers to use
> copy_safe_from_sockptr().
>
> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() =
to
> scrub parts of uninitialized buffer.
>
> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
> and hci_sock_setsockopt().
>
> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user =
input")
> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt us=
er input")
> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt use=
r input")
> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user =
input")
> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt =
user input")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

> ---
>  include/net/bluetooth/bluetooth.h |  9 ---------
>  net/bluetooth/hci_sock.c          | 14 +++++++-------
>  net/bluetooth/iso.c               | 10 +++++-----
>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
>  net/bluetooth/sco.c               | 11 ++++++-----
>  6 files changed, 33 insertions(+), 40 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index f66bc85c6411dd5d49eca7756577fea05feaf144..e6760c11f007752ff05792f1d=
e09b70bfb57213c 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -590,15 +590,6 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct=
 sock *sk,
>         return skb;
>  }
>
> -static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
> -                                      sockptr_t src, size_t src_size)
> -{
> -       if (dst_size > src_size)
> -               return -EINVAL;
> -
> -       return copy_from_sockptr(dst, src, dst_size);
> -}
> -
>  int bt_to_errno(u16 code);
>  __u8 bt_status(int err);
>
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 2272e1849ebd894a6b83f665d8fa45610778463c..022b86797acdc56a6e9b85f24=
f4c98a0247831c9 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1926,7 +1926,7 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>  }
>
>  static int hci_sock_setsockopt_old(struct socket *sock, int level, int o=
ptname,
> -                                  sockptr_t optval, unsigned int len)
> +                                  sockptr_t optval, unsigned int optlen)
>  {
>         struct hci_ufilter uf =3D { .opcode =3D 0 };
>         struct sock *sk =3D sock->sk;
> @@ -1943,7 +1943,7 @@ static int hci_sock_setsockopt_old(struct socket *s=
ock, int level, int optname,
>
>         switch (optname) {
>         case HCI_DATA_DIR:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, l=
en);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1954,7 +1954,7 @@ static int hci_sock_setsockopt_old(struct socket *s=
ock, int level, int optname,
>                 break;
>
>         case HCI_TIME_STAMP:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, l=
en);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1974,7 +1974,7 @@ static int hci_sock_setsockopt_old(struct socket *s=
ock, int level, int optname,
>                         uf.event_mask[1] =3D *((u32 *) f->event_mask + 1)=
;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&uf, sizeof(uf), optval, len=
);
> +               err =3D copy_safe_from_sockptr(&uf, sizeof(uf), optval, o=
ptlen);
>                 if (err)
>                         break;
>
> @@ -2005,7 +2005,7 @@ static int hci_sock_setsockopt_old(struct socket *s=
ock, int level, int optname,
>  }
>
>  static int hci_sock_setsockopt(struct socket *sock, int level, int optna=
me,
> -                              sockptr_t optval, unsigned int len)
> +                              sockptr_t optval, unsigned int optlen)
>  {
>         struct sock *sk =3D sock->sk;
>         int err =3D 0;
> @@ -2015,7 +2015,7 @@ static int hci_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>
>         if (level =3D=3D SOL_HCI)
>                 return hci_sock_setsockopt_old(sock, level, optname, optv=
al,
> -                                              len);
> +                                              optlen);
>
>         if (level !=3D SOL_BLUETOOTH)
>                 return -ENOPROTOOPT;
> @@ -2035,7 +2035,7 @@ static int hci_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                         goto done;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, l=
en);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 7a83e400ac77a0a0df41b206643bae6fc031631b..5f278971d7fa25b32b6f70a5f=
c5a7500db0fdc99 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1503,7 +1503,7 @@ static int iso_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1514,7 +1514,7 @@ static int iso_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         case BT_PKT_STATUS:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1533,7 +1533,7 @@ static int iso_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&qos, sizeof(qos), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&qos, sizeof(qos), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1554,8 +1554,8 @@ static int iso_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(iso_pi(sk)->base, optlen, op=
tval,
> -                                          optlen);
> +               err =3D copy_safe_from_sockptr(iso_pi(sk)->base, optlen, =
optval,
> +                                            optlen);
>                 if (err)
>                         break;
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ba437c6f6ee591a5624f5fbfbf28f2a80d399372..5ab203b55ab7e2c0682349a6e=
ab9620e3e8a024c 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -755,7 +755,8 @@ static int l2cap_sock_setsockopt_old(struct socket *s=
ock, int optname,
>                 opts.max_tx   =3D chan->max_tx;
>                 opts.txwin_size =3D chan->tx_win;
>
> -               err =3D bt_copy_from_sockptr(&opts, sizeof(opts), optval,=
 optlen);
> +               err =3D copy_safe_from_sockptr(&opts, sizeof(opts), optva=
l,
> +                                            optlen);
>                 if (err)
>                         break;
>
> @@ -800,7 +801,7 @@ static int l2cap_sock_setsockopt_old(struct socket *s=
ock, int optname,
>                 break;
>
>         case L2CAP_LM:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -909,7 +910,7 @@ static int l2cap_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>
>                 sec.level =3D BT_SECURITY_LOW;
>
> -               err =3D bt_copy_from_sockptr(&sec, sizeof(sec), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&sec, sizeof(sec), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -956,7 +957,7 @@ static int l2cap_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -970,7 +971,7 @@ static int l2cap_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         case BT_FLUSHABLE:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1004,7 +1005,7 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>
>                 pwr.force_active =3D BT_POWER_FORCE_ACTIVE_ON;
>
> -               err =3D bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&pwr, sizeof(pwr), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1015,7 +1016,7 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>                 break;
>
>         case BT_CHANNEL_POLICY:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1046,7 +1047,7 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&mtu, sizeof(mtu), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -1076,7 +1077,8 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&mode, sizeof(mode), optval,=
 optlen);
> +               err =3D copy_safe_from_sockptr(&mode, sizeof(mode), optva=
l,
> +                                            optlen);
>                 if (err)
>                         break;
>
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9=
041770ede4f27b8 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket =
*sock, int optname,
>
>         switch (optname) {
>         case RFCOMM_LM:
> -               if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optle=
n)) {
> -                       err =3D -EFAULT;
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
> +               if (err)
>                         break;
> -               }
>
>                 if (opt & RFCOMM_LM_FIPS) {
>                         err =3D -EINVAL;
> @@ -685,7 +684,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock=
, int level, int optname,
>
>                 sec.level =3D BT_SECURITY_LOW;
>
> -               err =3D bt_copy_from_sockptr(&sec, sizeof(sec), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&sec, sizeof(sec), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -703,7 +702,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock=
, int level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 1c7252a3686694284b0b1e1101e3d16b90d906c4..700abb639a554521b9b5d4629=
8d5ed926d228470 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -853,7 +853,7 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -872,8 +872,8 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>
>                 voice.setting =3D sco_pi(sk)->setting;
>
> -               err =3D bt_copy_from_sockptr(&voice, sizeof(voice), optva=
l,
> -                                          optlen);
> +               err =3D copy_safe_from_sockptr(&voice, sizeof(voice), opt=
val,
> +                                            optlen);
>                 if (err)
>                         break;
>
> @@ -898,7 +898,7 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                 break;
>
>         case BT_PKT_STATUS:
> -               err =3D bt_copy_from_sockptr(&opt, sizeof(opt), optval, o=
ptlen);
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
>                 if (err)
>                         break;
>
> @@ -941,7 +941,8 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                         break;
>                 }
>
> -               err =3D bt_copy_from_sockptr(buffer, optlen, optval, optl=
en);
> +               err =3D copy_struct_from_sockptr(buffer, sizeof(buffer), =
optval,
> +                                              optlen);
>                 if (err) {
>                         hci_dev_put(hdev);
>                         break;
>
> --
> 2.46.2
>


--=20
Luiz Augusto von Dentz

