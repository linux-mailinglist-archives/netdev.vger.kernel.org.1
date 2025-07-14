Return-Path: <netdev+bounces-206691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A975B04143
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B5D189AEED
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11425A331;
	Mon, 14 Jul 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcX3T5Eq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D3C2550DD;
	Mon, 14 Jul 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502550; cv=none; b=SOZIboBJvSvKDGO55TxQvmOfad+vSrmhc5ZxolIK21kWCQls1oe/bncR5dN35+CVNt1Fc+Gda5/H6Nx9M6iizLTZddoF3mpYp59bl6ygNWSqcYGuKd4ssUaOMAfCRp8y5bsVRwY2AROAho1WsHBS9uXqYHyjNjprtdcOLi5J6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502550; c=relaxed/simple;
	bh=E/M4rhGhFfnxw7bPtRF9RqwLFdfY9maeG5yJOOca5GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXNoM/LMCMqBjGrgOYoww9mRjVKc0pJXWIdMNG+//tDSzQeG5eW8yJp3wLSVs8u2D2chZi3s4PPvI4jTZtzYrw8/+sgWSFIpf+KKB+kBtrwhsOVhp2FM4alKO9YFBZVkjz2zeBSvpVBnbcOibbz0QlQWrxL4M0mSoxmYcg/oWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcX3T5Eq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b435ef653so34236081fa.2;
        Mon, 14 Jul 2025 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752502547; x=1753107347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJMP8UBbwSy0FLOvH5KG+nh1mXruEi32ylVnTk7hBpw=;
        b=VcX3T5EqMe2Yi6jXllNXrm4iW+B80sto0ZX0PnB5hH0w8pDuKS205Nxv7u3pjA15zh
         IGL8hbXE2EJ1ai6G8N/yT/BORE5RiX8jo58tkzs4SvyCMgLqg4pw5AXf3LXpkWi2aBS2
         aJmRfqhfLExCdadN9nxfYMzcKg4vmvs870KhpCgVPZPfZ/NgwlNZqUpEkbU17SYnjUJZ
         m8AiT/kj9V5QBxN7S+8m59SZj1HQgB0oONAo77E8A5rtqa3y51f99VQTSClGTOo8rc59
         7CMcf345GamHfWUHhVqshWhQCu05Nzgfia8DlAJYaByIOyD619adgeUw5c5x9PvQSp9D
         tU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502547; x=1753107347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJMP8UBbwSy0FLOvH5KG+nh1mXruEi32ylVnTk7hBpw=;
        b=PIweU9g1Bo51Dpk7oPUbjUhWamZfCwL4nk1rshPKUlv3A2TGVOSl8ksKE2UqbHwUIY
         NorVy+BXdFrx0UEfNG5ez/znX2b3vLVpcwhrxL5WkqafIdVUOeYPMGVBmMJEXkMPhwQo
         ZUMuzdde2V2yB9QnsDDUvR968xLaS43qdMwNRQkQ0TRqv05v2w1rAyL1UTXeKKVHr8Sj
         EgfXTYnXPuQZvXoQp4Ls60PLhDNPQPfgdjMU2iZ9/KYH0nIXTIJKCm6dpyVy1cq94nIW
         6rK3hG8hE7davnpazirDXTREu8H6EWXEDss6yqButEpftCXwAAFhKbbinq4dVCSg8fGc
         Xviw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9fVrC/pKZGjJ0UrwgaJRuFVei8YrN6vpNNh50osVtkpmwV2VHmltEMLbQAvYMJE9wRhToGevvYjNff8=@vger.kernel.org, AJvYcCXykaFDC4cPT2aYOWDJOyZOV/azt0pghXvAxMFlFg4Ei2ij6bBYiFus4Oy1E7vod9tazz/8oChl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BgsRqZQtG6Zg2YQyJ/BsLdkOAHFdzpsMTwSJy24xfCP7tsyl
	d7wpZBjqmf8mABgzppRycdv/aH0XUsFUMbp+XEh0MXqKH2X4oicfvVexJ7QoNz165/Q3Cum+cY9
	z3XauvSe7a8z3Ebcs+IVP8tP3UK+qAvY=
X-Gm-Gg: ASbGncvLCwCwpmassmYaG/4stW2ZLMUpEJcn+uwe0y6bVvmjVkpGLRivLUsOjwCeac1
	RKtLxyMYbKyKjWtn5nkofUHjiAWgWI2iIbpFVmKMH1cJQu96kxtE6ihAvveeuOwrlHKoSaZVho2
	kmDMNZfD7xg8np/5gHYRK7GyMiPceX2F2DQAFaTh3g/BriCGHz0qvj70uCt2ZQ4tY6o2OotvN7e
	5eW6w==
X-Google-Smtp-Source: AGHT+IEUaE5gFGObzdCuRYpZfGsk182J7MxPdMrBzmOMMtr1Ni7Z3zepZYEbNNPafHgabCMvGQANepuJE5WmX6v9YmQ=
X-Received: by 2002:a2e:96d1:0:b0:32e:deb2:f75 with SMTP id
 38308e7fff4ca-330534669e9mr33153591fa.23.1752502546483; Mon, 14 Jul 2025
 07:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
In-Reply-To: <474a5321753aba17ec2819ba59adfd157ecfb343.1752501596.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Jul 2025 10:15:34 -0400
X-Gm-Features: Ac12FXwSbcDIs1Lgv9_LDVgaN6D5S1j9jFB7Rcef-B_YHU65F9CZ2tLxbwrw4JM
Message-ID: <CABBYNZL0FjLf6NZ1U0Wo4cOyCfH=17FkN_6-CT1RqNdJVyMfZA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: add socket option to report packet seqnum
 via CMSG
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jul 14, 2025 at 10:03=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> User applications need a way to track which ISO interval a given SDU
> belongs to, to properly detect packet loss. All controllers do not set
> timestamps, and it's not guaranteed user application receives all packet
> reports (small socket buffer, or controller doesn't send all reports
> like Intel AX210 is doing).
>
> Add socket option BT_PKT_SEQNUM that enables reporting of received
> packet ISO sequence number in BT_SCM_PKT_SEQNUM CMSG.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     Intel AX210 is not sending all reports:
>
>     $ btmon -r dump.btsnoop -I -C90|grep -A1 'ISO Data RX: Handle 2304'
>     ...
>     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1=
713 [hci0] 22.567744
>             dd 01 3c 00 6d 08 e9 14 1e 3b 85 7b 35 c2 25 0b  ..<.m....;.{=
5.%.
>     --
>     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1=
718 [hci0] 22.573745
>             de 01 3c 00 41 65 22 4f 99 9b 0b b6 ff cb 06 00  ..<.Ae"O....=
....
>     --
>     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1=
727 [hci0] 22.587933
>             e0 01 3c 00 8b 6e 33 44 65 51 ee d7 e0 ee 49 d8  ..<..n3DeQ..=
..I.
>     --
>     > ISO Data RX: Handle 2304 flags 0x02 dlen 64                      #1=
732 [hci0] 22.596742
>             e1 01 3c 00 a7 48 54 a7 c1 9f dc 37 66 fe 04 ab  ..<..HT....7=
f...
>     ...
>
>     Here, report for packet with sequence number 0x01df is missing.
>
>     This may be spec violation by the controller, see Core v6.1 pp. 3702
>
>         All SDUs shall be sent to the upper layer including the indicatio=
n
>         of validity of data. A report shall be sent to the upper layer if
>         the SDU is completely missing.

We may want to report this to Intel, let me check internally.

>     Regardless, it will be easier for user applications to see the HW
>     sequence numbers directly, so they don't have to count packets and it=
's
>     in any case more reliable if packets get dropped due to socket buffer
>     size.
>
>  include/net/bluetooth/bluetooth.h |  9 ++++++++-
>  net/bluetooth/af_bluetooth.c      |  7 +++++++
>  net/bluetooth/iso.c               | 21 ++++++++++++++++++---
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 114299bd8b98..0e31779a3341 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -244,6 +244,10 @@ struct bt_codecs {
>
>  #define BT_ISO_BASE            20
>
> +#define BT_PKT_SEQNUM          21
> +
> +#define BT_SCM_PKT_SEQNUM      0x05
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> @@ -391,7 +395,8 @@ struct bt_sock {
>  enum {
>         BT_SK_DEFER_SETUP,
>         BT_SK_SUSPEND,
> -       BT_SK_PKT_STATUS
> +       BT_SK_PKT_STATUS,
> +       BT_SK_PKT_SEQNUM,
>  };
>
>  struct bt_sock_list {
> @@ -475,6 +480,7 @@ struct bt_skb_cb {
>         u8 pkt_type;
>         u8 force_active;
>         u16 expect;
> +       u16 pkt_seqnum;

We may also need the status or are you planning on reusing the
existing pkt_status? In any case we may want to add something to
iso-tester to confirm this is working as intended and catch possible
regressions.

>         u8 incoming:1;
>         u8 pkt_status:2;
>         union {
> @@ -488,6 +494,7 @@ struct bt_skb_cb {
>
>  #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
>  #define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
> +#define hci_skb_pkt_seqnum(skb) bt_cb((skb))->pkt_seqnum
>  #define hci_skb_expect(skb) bt_cb((skb))->expect
>  #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
>  #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 6ad2f72f53f4..44b7acb20a67 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -364,6 +364,13 @@ int bt_sock_recvmsg(struct socket *sock, struct msgh=
dr *msg, size_t len,
>                         put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
>                                  sizeof(pkt_status), &pkt_status);
>                 }
> +
> +               if (test_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags)) {
> +                       u16 pkt_seqnum =3D hci_skb_pkt_seqnum(skb);
> +
> +                       put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_SEQNUM,
> +                                sizeof(pkt_seqnum), &pkt_seqnum);
> +               }

In case we want to reuse the pkt_status then perhaps the order shall
be pk_seqnum followed by pkt_status otherwise we need a struct that
holds them both.

>         }
>
>         skb_free_datagram(sk, skb);
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..469450bb6b6c 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1687,6 +1687,17 @@ static int iso_sock_setsockopt(struct socket *sock=
, int level, int optname,
>                         clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
>                 break;
>
> +       case BT_PKT_SEQNUM:
> +               err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
> +               if (err)
> +                       break;
> +
> +               if (opt)
> +                       set_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> +               else
> +                       clear_bit(BT_SK_PKT_SEQNUM, &bt_sk(sk)->flags);
> +               break;
> +
>         case BT_ISO_QOS:
>                 if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOU=
ND &&
>                     sk->sk_state !=3D BT_CONNECT2 &&
> @@ -2278,7 +2289,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon, =
__u8 reason)
>  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  {
>         struct iso_conn *conn =3D hcon->iso_data;
> -       __u16 pb, ts, len;
> +       __u16 pb, ts, len, sn;
>
>         if (!conn)
>                 goto drop;
> @@ -2308,6 +2319,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff=
 *skb, u16 flags)
>                                 goto drop;
>                         }
>
> +                       sn =3D hdr->sn;
>                         len =3D __le16_to_cpu(hdr->slen);
>                 } else {
>                         struct hci_iso_data_hdr *hdr;
> @@ -2318,18 +2330,20 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
>                                 goto drop;
>                         }
>
> +                       sn =3D hdr->sn;
>                         len =3D __le16_to_cpu(hdr->slen);
>                 }
>
>                 flags  =3D hci_iso_data_flags(len);
>                 len    =3D hci_iso_data_len(len);
>
> -               BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x", =
len,
> -                      skb->len, flags);
> +               BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x sn=
 %d",
> +                      len, skb->len, flags, sn);
>
>                 if (len =3D=3D skb->len) {
>                         /* Complete frame received */
>                         hci_skb_pkt_status(skb) =3D flags & 0x03;
> +                       hci_skb_pkt_seqnum(skb) =3D sn;
>                         iso_recv_frame(conn, skb);
>                         return;
>                 }
> @@ -2352,6 +2366,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff=
 *skb, u16 flags)
>                         goto drop;
>
>                 hci_skb_pkt_status(conn->rx_skb) =3D flags & 0x03;
> +               hci_skb_pkt_seqnum(conn->rx_skb) =3D sn;
>                 skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-=
>len),
>                                           skb->len);
>                 conn->rx_len =3D len - skb->len;
> --
> 2.50.1
>


--=20
Luiz Augusto von Dentz

