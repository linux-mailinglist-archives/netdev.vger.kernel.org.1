Return-Path: <netdev+bounces-164558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C002CA2E376
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732637A2D85
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34016ABC6;
	Mon, 10 Feb 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZ3ATzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AD8C0B;
	Mon, 10 Feb 2025 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164789; cv=none; b=QPS6cy0aEOMV3/YwxAvwwC/Gp/3BqdRxv0aRxRd+zprjKdK/QVJZaveHaPQKV2OPnFaQ84dtigEvfhFi9aBhDASWEoeD51iPr8FuBJCqw648C3G+RAZqSfNkHpguKyNfSCzgufsqvyx00M5YJ8JUsltx0O/U53/mXLc8ECSSGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164789; c=relaxed/simple;
	bh=fZPrwY34ra1iptt6LNSIEPmUhUV96xQP6WUmUP5ZaIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o98NqZmOx+nTMlcNfOoO56KdJ6g+1fnY7GUc4A8DAtQI5QpbWA3ZgCeJYg3s6SD4kzqHP6AkxLMfcRAMP15II63+5IX1ii/lP0+seNeB/13jVIc/deDmdy7c2cz0iYUnOqCTXpkB/LPFivgYpYdtsNl8MZcPZwoS1m+6zkdjFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAZ3ATzN; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d15ce78fecso7769105ab.2;
        Sun, 09 Feb 2025 21:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739164787; x=1739769587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3uh2ILPMiksWEP7lEXKPKQV1OP3Pn2eNef2yeALT8k=;
        b=hAZ3ATzNQ2l0UtWQJF2M5lYNKET3Wj9CHgmpp0V3X0QxU3iXsUQRAYIK8Pf+OfKTCQ
         g14CchhKjF1njr7b+W8pdfABsyMkwmB2D7k0H9InNLwL+VqIyHJWqHsjv7ysqr69l6sn
         YLnS6gPo2dwF118+TrArOBlO/KJF5AMLsaQwZ42mxeEg3ndbwkq7ew8EORB/7CTxigdU
         onrmgE0BiaZxKgdw78Kq2i2w5DnopiddF7WdydWRdP33qE5EgIqtvjPrYnBaD5iv2k76
         V+tWBrnX6wb1VJkFph8xo43lQNUubudLaCyPS9XC3e7GbrLAjYE1sO1CNz8u7y2/wgaS
         f5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739164787; x=1739769587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3uh2ILPMiksWEP7lEXKPKQV1OP3Pn2eNef2yeALT8k=;
        b=JJ6HgBZsGhm2a2Y6gr/X/J7iRKb3YNt3tpNpL9ZaLUgpPDsSn5Us1HohJ01kpPzDA8
         2o1taI35hkzkvbEOGxjUmjeMm9f+xs5tgP/4e24j8URJfDDz4fKeBthiuIJaAxQJDCT/
         sp6xmd3ixA2lLcIKy/TWy6MCkipbMVQzcxYGDFRrYjTOCP0s1qg5ZJFTz3rNgadVJm0R
         6rndw2RBLAg0jNLYkZxQjRbUFhJcYMXzi7W9KygMsSuGvUxlGaXP9LzgL2Tw4eqQl2r8
         Dtwb6x+1ctKMgCBaKQ751YawIenU7ldliBk04kejwv+4FySXnjwwM15UPziP+lGJANoP
         e4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqs3TIxNFDrAtYEG8Es3DpFrvEo2Fc7nFEtnFV1m7bMQga7QU/AXqR7/NsYOkUnSIWilpQAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVyCMGLjC6jWl1HVzAZ18fTLYLe9csMIAkvOimYizq10CPpMZ
	sJCSUDssGE3UvHxlniZLB5SnDfsnY2wylq2dyg6wHb7s+k8xk3s44VUW8rBDFuSkMjHbsNw4B0U
	ImZlM6N/JCp1b7rFaIOJm22cSpA4=
X-Gm-Gg: ASbGncsA4ML67ce3L/F+YzzL+zQkQ0LcgbtRcjA9O5UyxMntqJ1L8U99VFfSmlJ1YzD
	URuCmKL4Vnz6ufi40XiGr8L7/pD+MNJt94M64f4DhQEtcwhnglcR/dk53hecuol7x+yZAhMkw
X-Google-Smtp-Source: AGHT+IHeZPwidZPjSmPln2DK3A71NDsIsP/SOZPxKHjTs2kfhiGf9dYDtQJCuTfccwhh/v0MF87xcpkPdSF0b9/sjiA=
X-Received: by 2002:a05:6e02:1989:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d13df22156mr102458325ab.15.1739164787322; Sun, 09 Feb 2025
 21:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739097311.git.pav@iki.fi> <f3f0fa8615fbfebbf58212bd407e51579f85412a.1739097311.git.pav@iki.fi>
In-Reply-To: <f3f0fa8615fbfebbf58212bd407e51579f85412a.1739097311.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Feb 2025 13:19:11 +0800
X-Gm-Features: AWEUYZlWmiY1UXow62fqSoEDXBtdhaO8lH6y5xeIBpkbw3vi50_SGY4UcPtI4qE
Message-ID: <CAL+tcoBZU8C76XTLoz9LEWR+e+x3ct_izbC0q-kKXkTxxqhoHg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: ISO: add TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 6:39=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add BT_SCM_ERROR socket CMSG type.
>
> Support TX timestamping in ISO sockets.
>
> Support MSG_ERRQUEUE in ISO recvmsg.
>
> If a packet from sendmsg() is fragmented, only the first ACL fragment is
> timestamped.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/iso.c               | 24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 435250c72d56..bbefde319f95 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -156,6 +156,7 @@ struct bt_voice {
>  #define BT_PKT_STATUS           16
>
>  #define BT_SCM_PKT_STATUS      0x03
> +#define BT_SCM_ERROR           0x04
>
>  #define BT_ISO_QOS             17
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 44acddf58a0c..f497759a2af5 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -518,7 +518,8 @@ static struct bt_iso_qos *iso_sock_get_qos(struct soc=
k *sk)
>         return &iso_pi(sk)->qos;
>  }
>
> -static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
> +static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
> +                         const struct sockcm_cookie *sockc)
>  {
>         struct iso_conn *conn =3D iso_pi(sk)->conn;
>         struct bt_iso_qos *qos =3D iso_sock_get_qos(sk);
> @@ -538,10 +539,12 @@ static int iso_send_frame(struct sock *sk, struct s=
k_buff *skb)
>         hdr->slen =3D cpu_to_le16(hci_iso_data_len_pack(len,
>                                                       HCI_ISO_STATUS_VALI=
D));
>
> -       if (sk->sk_state =3D=3D BT_CONNECTED)
> +       if (sk->sk_state =3D=3D BT_CONNECTED) {
> +               hci_setup_tx_timestamp(skb, 1, sockc);
>                 hci_send_iso(conn->hcon, skb);
> -       else
> +       } else {
>                 len =3D -ENOTCONN;
> +       }
>
>         return len;
>  }
> @@ -1348,6 +1351,7 @@ static int iso_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>  {
>         struct sock *sk =3D sock->sk;
>         struct sk_buff *skb, **frag;
> +       struct sockcm_cookie sockc;
>         size_t mtu;
>         int err;
>
> @@ -1360,6 +1364,14 @@ static int iso_sock_sendmsg(struct socket *sock, s=
truct msghdr *msg,
>         if (msg->msg_flags & MSG_OOB)
>                 return -EOPNOTSUPP;
>
> +       sockcm_init(&sockc, sk);

No need to initialize other irrelevant fields since Willem started to
clean up this kind of init phase in TCP[1].

[1]: https://lore.kernel.org/all/20250206193521.2285488-2-willemdebruijn.ke=
rnel@gmail.com/

> +
> +       if (msg->msg_controllen) {
> +               err =3D sock_cmsg_send(sk, msg, &sockc);
> +               if (err)
> +                       return err;
> +       }
> +

I'm not familiar with bluetooth, but I'm wondering if the above code
snippet is supposed to be protected by the socket lock as below since
I refer to TCP as an example? Is it possible that multiple threads
call this sendmsg at the same time?

>         lock_sock(sk);
>
>         if (sk->sk_state !=3D BT_CONNECTED) {
> @@ -1405,7 +1417,7 @@ static int iso_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>         lock_sock(sk);
>
>         if (sk->sk_state =3D=3D BT_CONNECTED)
> -               err =3D iso_send_frame(sk, skb);
> +               err =3D iso_send_frame(sk, skb, &sockc);
>         else
>                 err =3D -ENOTCONN;
>
> @@ -1474,6 +1486,10 @@ static int iso_sock_recvmsg(struct socket *sock, s=
truct msghdr *msg,
>
>         BT_DBG("sk %p", sk);
>
> +       if (unlikely(flags & MSG_ERRQUEUE))
> +               return sock_recv_errqueue(sk, msg, len, SOL_BLUETOOTH,
> +                                         BT_SCM_ERROR);
> +
>         if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
>                 sock_hold(sk);
>                 lock_sock(sk);
> --
> 2.48.1
>
>

