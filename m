Return-Path: <netdev+bounces-123199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D585A9640DD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B21F22BFF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22741662E8;
	Thu, 29 Aug 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9zERSJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C622097
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925804; cv=none; b=d9V7AtG/89Mw72JLoLfQk5iaiC4jVqOZz36fnD6tzIck0eCOtzL0II+lJSG3Sb35CVzsomH/OTxiJ6NKN49aIQA2gmjbzWjTCrxltRy10ZlKWbSsB9YtIRqvF7HTcPy7qdrmAaq7+trY7IkMaALqENmFPcf97h6yF06tA/pkSjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925804; c=relaxed/simple;
	bh=tZ2IDSLLuFcz1PcAVkXGRj2O7AKEyVfPOXdjATbmaUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIFuy20Q735G7zynzZsuyjQqsAYwuALgP3s6WHuRQZcZBvk1pIoG8r/NKP8IJojghniNibLcmS1Nz+rynZafrmpo2JIOF6fJu57NZv/182IaXsOKREKOKsRB+Z4Xh/kxgqa3wtUczmwPBFAytBKb5fpYGBF/Uarm00cG216Bcb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9zERSJh; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39e6a1e0079so1489095ab.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724925802; x=1725530602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlsQGamaT9HsMT1BvU9oTSeIcy+YB2mdt9KYWjEAyCM=;
        b=F9zERSJhGGwixZLwpJAeo5ldLJwqFwSz/VaSFh4ubEhMk9XQoYGUaGD835KvW0FZBQ
         1l3RRTUF2py9VY2qmrIwvJ7Xa8M1ziv9e6zi4crC8KiACBA8roYfpvu2LUUb7HmLIqxs
         hpzGYG6NG0mHct4ynGUG3Iwzf7dkdWoUNHjCW1AKAs3G4rPNp54B+8cJpg+HDvWIsN5O
         LJjxgSuBpNx1M31ryyT/81z1RHSmbaTbpd1eLRJJojGnA968/59eqp8MISNAqQWf4Zv8
         xuPUC1mMqv++EfjCmjDPuimuuxKFOVSFHQCt7RcHiHfaZVfkB4sbT1jGChcquksSajEh
         S0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724925802; x=1725530602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlsQGamaT9HsMT1BvU9oTSeIcy+YB2mdt9KYWjEAyCM=;
        b=qu99Fyl7z4L8k/tmvZZvowFV+v0b1JuH+j3aD7ut1xaCcIWonX3aXdr9TcsT/GQIOo
         +9oZe2CgMzuJOAxWBmSjqETQrYqk7D/hF+cQ1WtpQ0zIUDGRJFAW1YRSXS+7LlrYgf/G
         4GzNspTcVjs3rUS2dnpANRqXY5AxPXqV/3ditmuvYQ/xOk2SIiMfEuJx1JVRlViHqnPv
         SyyjHozXOzpTLBGwHS8Qsoc9Yqb5sCQSIQ2AApW8qZcWH2mFIz88SwubWbkUyO7mWsVC
         SQg7Quf+vhJFWCDFK9Ix1FpCZAMxVIokuYMwuUKuI46D/98z2ybflRAmGkWl/RHQWJ2X
         kspQ==
X-Gm-Message-State: AOJu0YyHkDwPu2Td2ErdVeDZDCxGV8ET3nd+cHDAseMZG4NhfQrm4o26
	lD4nU1rteJfffO2eWbg3/6/gIGNzAShwQEcUv5t+2bzM25Az5pjeJ6nSW2Xp5F63+hzspalgSNt
	65Gn5YPqRhDXEmBAF9/H6KcJs84Q=
X-Google-Smtp-Source: AGHT+IF4q9e7A8Gejo7eMA6gXmqEpLI7oXswrKpLqquGpRJb0hPLzVonifX+JDzgyyGjdZrtuc0udsu73zwKV9UfMJU=
X-Received: by 2002:a05:6e02:b46:b0:39d:49df:90c8 with SMTP id
 e9e14a558f8ab-39f37896aabmr22366815ab.27.1724925801830; Thu, 29 Aug 2024
 03:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com> <20240828160145.68805-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240828160145.68805-3-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 29 Aug 2024 18:02:45 +0800
Message-ID: <CAL+tcoAKyT6rdBxScEszjCw32XrsShci5a=a_FEg7fWB-ePV2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:01=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like the previous patch in this series, we need to make sure that
> we both set SOF_TIMESTAMPING_SOFTWARE and SOF_TIMESTAMPING_RX_SOFTWARE
> flags together so that we can let the user parse the rx timestamp.
>
> One more important and special thing is that we should take care of
> errqueue recv path because we rely on errqueue to get our timestamps
> for sendmsg(). Or else, If the user wants to read when setting
> SOF_TIMESTAMPING_TX_ACK, something like this, we cannot get timestamps,
> for example, in TCP case. So we should consider those
> SOF_TIMESTAMPING_TX_* flags.
>
> After this patch, we are able to pass the testcase 6 for IP and UDP
> cases when running ./rxtimestamp binary.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  Documentation/networking/timestamping.rst |  7 +++++++
>  include/net/sock.h                        |  7 ++++---
>  net/bluetooth/hci_sock.c                  |  4 ++--
>  net/core/sock.c                           |  2 +-
>  net/ipv4/ip_sockglue.c                    |  2 +-
>  net/ipv4/ping.c                           |  2 +-
>  net/ipv6/datagram.c                       |  4 ++--
>  net/l2tp/l2tp_ip.c                        |  2 +-
>  net/l2tp/l2tp_ip6.c                       |  2 +-
>  net/nfc/llcp_sock.c                       |  2 +-
>  net/rxrpc/recvmsg.c                       |  2 +-
>  net/socket.c                              | 11 ++++++++---
>  net/unix/af_unix.c                        |  2 +-
>  13 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
> index 5e93cd71f99f..93378b78c6dd 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -160,6 +160,13 @@ SOF_TIMESTAMPING_RAW_HARDWARE:
>    Report hardware timestamps as generated by
>    SOF_TIMESTAMPING_TX_HARDWARE when available.
>
> +Please note: previously, if an application starts first which turns on
> +netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFT=
WARE
> +could also get rx timestamp. Now we handle this case and will not get
> +rx timestamp under this circumstance. We encourage that for each socket
> +we should use the SOF_TIMESTAMPING_RX_SOFTWARE generation flag to time
> +stamp the skb and use SOF_TIMESTAMPING_SOFTWARE report flag to tell
> +the application.
>
>  1.3.3 Timestamp Options
>  ^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..b8535692f340 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2600,12 +2600,13 @@ static inline void sock_write_timestamp(struct so=
ck *sk, ktime_t kt)
>  }
>
>  void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> -                          struct sk_buff *skb);
> +                          struct sk_buff *skb, bool errqueue);
>  void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
>                              struct sk_buff *skb);
>
>  static inline void
> -sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff =
*skb)
> +sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff =
*skb,
> +                   bool errqueue)
>  {
>         struct skb_shared_hwtstamps *hwtstamps =3D skb_hwtstamps(skb);
>         u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> @@ -2621,7 +2622,7 @@ sock_recv_timestamp(struct msghdr *msg, struct sock=
 *sk, struct sk_buff *skb)
>             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
>             (hwtstamps->hwtstamp &&
>              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> -               __sock_recv_timestamp(msg, sk, skb);
> +               __sock_recv_timestamp(msg, sk, skb, errqueue);
>         else
>                 sock_write_timestamp(sk, kt);
>
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 69c2ba1e843e..c1b73c5a370b 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1586,11 +1586,11 @@ static int hci_sock_recvmsg(struct socket *sock, =
struct msghdr *msg,
>                 break;
>         case HCI_CHANNEL_USER:
>         case HCI_CHANNEL_MONITOR:
> -               sock_recv_timestamp(msg, sk, skb);
> +               sock_recv_timestamp(msg, sk, skb, false);
>                 break;
>         default:
>                 if (hci_mgmt_chan_find(hci_pi(sk)->channel))
> -                       sock_recv_timestamp(msg, sk, skb);
> +                       sock_recv_timestamp(msg, sk, skb, false);
>                 break;
>         }
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..d969a4901300 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3677,7 +3677,7 @@ int sock_recv_errqueue(struct sock *sk, struct msgh=
dr *msg, int len,
>         if (err)
>                 goto out_free_skb;
>
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, true);
>
>         serr =3D SKB_EXT_ERR(skb);
>         put_cmsg(msg, level, type, sizeof(serr->ee), &serr->ee);
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..b79f859c34bf 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -547,7 +547,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg=
, int len, int *addr_len)
>                 kfree_skb(skb);
>                 return err;
>         }
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, true);
>
>         serr =3D SKB_EXT_ERR(skb);
>
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 619ddc087957..1cf7b0eecd63 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -880,7 +880,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg,=
 size_t len, int flags,
>         if (err)
>                 goto done;
>
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, false);
>
>         /* Copy the address and add cmsg data. */
>         if (family =3D=3D AF_INET) {
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..1e4c11b2d0ce 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -479,7 +479,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *m=
sg, int len, int *addr_len)
>                 kfree_skb(skb);
>                 return err;
>         }
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, true);
>
>         serr =3D SKB_EXT_ERR(skb);
>
> @@ -568,7 +568,7 @@ int ipv6_recv_rxpmtu(struct sock *sk, struct msghdr *=
msg, int len,
>         if (err)
>                 goto out_free_skb;
>
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, false);
>
>         memcpy(&mtu_info, IP6CBMTU(skb), sizeof(mtu_info));
>
> diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
> index 4bc24fddfd52..164c8ed7124e 100644
> --- a/net/l2tp/l2tp_ip.c
> +++ b/net/l2tp/l2tp_ip.c
> @@ -567,7 +567,7 @@ static int l2tp_ip_recvmsg(struct sock *sk, struct ms=
ghdr *msg,
>         if (err)
>                 goto done;
>
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, false);
>
>         /* Copy the address. */
>         if (sin) {
> diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
> index f4c1da070826..b0bb0a1f772e 100644
> --- a/net/l2tp/l2tp_ip6.c
> +++ b/net/l2tp/l2tp_ip6.c
> @@ -712,7 +712,7 @@ static int l2tp_ip6_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
>         if (err)
>                 goto done;
>
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, false);
>
>         /* Copy the address. */
>         if (lsa) {
> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index 57a2f97004e1..5c6e671643f6 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -869,7 +869,7 @@ static int llcp_sock_recvmsg(struct socket *sock, str=
uct msghdr *msg,
>                 return -EFAULT;
>         }
>
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, false);
>
>         if (sk->sk_type =3D=3D SOCK_DGRAM && msg->msg_name) {
>                 struct nfc_llcp_ui_cb *ui_cb =3D nfc_llcp_ui_skb_cb(skb);
> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index a482f88c5fc5..18fa392011fb 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -200,7 +200,7 @@ static int rxrpc_recvmsg_data(struct socket *sock, st=
ruct rxrpc_call *call,
>                                             sp->hdr.serial, seq);
>
>                 if (msg)
> -                       sock_recv_timestamp(msg, sock->sk, skb);
> +                       sock_recv_timestamp(msg, sock->sk, skb, false);
>
>                 if (rx_pkt_offset =3D=3D 0) {
>                         ret2 =3D rxrpc_verify_data(call, skb);
> diff --git a/net/socket.c b/net/socket.c
> index fcbdd5bc47ac..c02fb9b615b2 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -893,7 +893,7 @@ static void put_ts_pktinfo(struct msghdr *msg, struct=
 sk_buff *skb,
>   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
>   */
>  void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> -       struct sk_buff *skb)
> +                          struct sk_buff *skb, bool errqueue)
>  {
>         int need_software_tstamp =3D sock_flag(sk, SOCK_RCVTSTAMP);
>         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
> @@ -946,7 +946,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struc=
t sock *sk,
>
>         memset(&tss, 0, sizeof(tss));
>         tsflags =3D READ_ONCE(sk->sk_tsflags);
> -       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +       /* We have to use the generation flag here to test if we allow th=
e
> +        * corresponding application to receive the rx timestamp. Only
> +        * using report flag does not hold for receive timestamping case.
> +        */
> +       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +            (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE || errqueue)) &&

Hello Willem,

After considering this part implemented in sock_recv_timestamp() in
the previous version over and over again, I think I need to add back
what I removed in sock_recv_timestamp(), because:
supposing we only set SOF_TIMESTAMPING_SOFTWARE, we will go into
__sock_recv_timestamp and do nothing but return, then we will miss
setting sk->sk_stamp in sock_write_timestamp().
In that case, the socket will miss two chances to set sk_stamp.

sk_stamp stands for the timestamp of the last packet we receive, it is
necessary to set sk_stamp in sock_recv_timestamp() one way or another.

I wonder if I understand correctly?

Please also help me review the remaining code, thanks.

Thanks,
Jason


>             ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
>                 empty =3D 0;
>         if (shhwtstamps &&
> @@ -1024,7 +1029,7 @@ static void sock_recv_mark(struct msghdr *msg, stru=
ct sock *sk,
>  void __sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
>                        struct sk_buff *skb)
>  {
> -       sock_recv_timestamp(msg, sk, skb);
> +       sock_recv_timestamp(msg, sk, skb, false);
>         sock_recv_drops(msg, sk, skb);
>         sock_recv_mark(msg, sk, skb);
>  }
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index a1894019ebd5..bb33f2994618 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2481,7 +2481,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t size,
>                 goto out_free;
>
>         if (sock_flag(sk, SOCK_RCVTSTAMP))
> -               __sock_recv_timestamp(msg, sk, skb);
> +               __sock_recv_timestamp(msg, sk, skb, false);
>
>         memset(&scm, 0, sizeof(scm));
>
> --
> 2.37.3
>

