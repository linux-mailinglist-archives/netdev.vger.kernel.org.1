Return-Path: <netdev+bounces-202444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BB4AEDF88
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2549F3A5E0A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265E25D21A;
	Mon, 30 Jun 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiP2bjk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06F1917ED;
	Mon, 30 Jun 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291395; cv=none; b=VJdGNbL1+G2bkhKi7YNBK4peZULg/lRxm/0wQ9/rofLT50TA2oAsCEMt99uu/eCxEuEqaQ4T1h6FUHK1BIQN8c+7lFiaUf3WdFuGiWwxWL9gtfkeixbEwFCA6O9EjsOO49EhC/ikiDi21++m6kGaDf/0X1fn0sm06sWnCOS/DgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291395; c=relaxed/simple;
	bh=bzoIOlWuvbbMCyXu6/siE/mgcgtZLTWB1WkT/gOYcOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLhtYTNBUiHS4RUOYUeJRFipq4DztOHAO5ijuBzszAEvc5fOMs670pFPbujbi7/QZw4Tuq+sVSM7NstgVeL4i7Dhdvt3MXLwQ+NOrO1T4VAhjbCljdaaOUenoLfUiPPEIcaN5I1WMUl4G/BIrhfXAy2dnr+EHpdMuCR5Ks5+QGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiP2bjk7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so18611171fa.0;
        Mon, 30 Jun 2025 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751291392; x=1751896192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmpyaTUE2J4jAFO05Ukiw9Q7CdozXE2TovrP208ubCc=;
        b=jiP2bjk7cvVwGUhGL0cHeV894ADW0fCTji5lVZQ9GOmiOPdt4W96ve7Z1l+tLDirEg
         Aq+1tAB3gqXO1ae8aJTxneJ33XN1vEl2/ZI4pGGY5uclTzKxdldjpTqgq6sFPqhAbyBm
         ZuGCjfBhqvx5STrRo+B+alszfsMURz7Hm1fJrvtjb2gvGyom/33I6HW7jNy8HBwXAYKq
         EjfdSI9XZmrV5J0DWuCaTvvr4nktytgdiDowHxhPYIPkecfJPbsdAqI7kGlN7zrVhzPx
         UIodCbRk9K70XfluGXZbwaFqXlb2OKeqCe9O6wzW2jfncNPFLj+9ZFG83M2jC6NZ/7lP
         i9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751291392; x=1751896192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmpyaTUE2J4jAFO05Ukiw9Q7CdozXE2TovrP208ubCc=;
        b=U8CUV9d7vz37iEr4+/fr+UVbd9ljhYUudst4qlEZ8qwAmFUK3rWnQMvuN76wNOe1t+
         XjYd8iHgk5qR6Xv49e267B6yeuJUtBYPPIIbirXCbxlbufOuaekchntXC+Jk2eBbIA60
         8w/1EzcqdrwlcAOXaKs+AEpnosHCdkmRCy19hS+yo7hz9Xx+caO0C77CcPT482MaqP2u
         PQDunjdEUoo7Mp2XmkxEgtX8B2gG824FwUEzAFTnqAcHBVL8w1ZX7HQH6XQenl0etVVz
         6iibVz/vDOWU6x+z5F4J74jbvjbd1HEaXdho+qUPCG8BUbo5UVDDpaJMe5H4tsVeiYB1
         xFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2FDDpEDn5E1vor1oOwOIOaa4OMUPB3wNxGnG+Gjk+MyJsM+0ptFpTLqs86VtQa0/8T6eB7ZZG@vger.kernel.org, AJvYcCVwy4ggzt24eOzlKqmpcDKNsPEK7/hzZfw5dqABnOBMJP84d4Tc2FIah5NQFrA3lv7sbxNSc1qexldP2dp4hNo=@vger.kernel.org, AJvYcCWfQWtff5gG5PYiQuOZDOfflj+wxNMrQitDrkL215VqaN/hx8NABRy8vZoEHLRW1M/kZ6ck6fi9Vk0N8rCH@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSE4f7CX9V2lKJOmL1Lu7plR3uBkIoVY84HcVzM0bC7M9YUaB
	6uIRlATA71JNhCUGL/LLzjZTwg3jvKtF3KXX6Yy7btEN9C3f5VDgN2or1UqRqjuVoddma0Nh0Gm
	3xRhJ7eTGKN1GuihDNmC8AF2P2217T+U=
X-Gm-Gg: ASbGncvTn/dXuhGCMwzoXMAlkXyBqJ3rCyyEmI4vS3vopNI9FKk2oa1cHlVaPmun1//
	+cxJ+PH30LXHwRlse0U0k4RrNIjJI8jh/2HzWi6yvQTfru00WKac4etpS7EttlKW37g9+JoN2FT
	RHUDq0hxrpusMQz81vnZyQAgefcaLk3p7I9JGFN5y6Uw==
X-Google-Smtp-Source: AGHT+IGgaFLlKjjjCVMs+nZMIcXtZfFfNJ4BOpKnsZq/5dFH8MCARTKArHPB5BccAdKnh/MymRY+aAHrIQd0Mn9XZ2A=
X-Received: by 2002:a05:651c:40cf:b0:32a:8bf4:3a54 with SMTP id
 38308e7fff4ca-32cdc482b7amr30192051fa.2.1751291391775; Mon, 30 Jun 2025
 06:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630075656.8970-1-shpakovskiip@gmail.com>
In-Reply-To: <20250630075656.8970-1-shpakovskiip@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jun 2025 09:49:39 -0400
X-Gm-Features: Ac12FXw3PmrFKjrpDjyEBaBsLe1XDWNEu8EQrup3HMVbUT8LYY__w7LU958fRLU
Message-ID: <CABBYNZ+HzCDakR18naDA1dw-PwGn_F-r7yCK+EXUodmtKmawhg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Introduce minimum limit of
 rx_credits value
To: Pavel Shpakovskiy <shpakovskiip@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Mon, Jun 30, 2025 at 3:57=E2=80=AFAM Pavel Shpakovskiy
<shpakovskiip@gmail.com> wrote:
>
> The commit 96cd8eaa131f
> ("Bluetooth: L2CAP: Derive rx credits from MTU and MPS")
> removed the static rx_credits setup to improve BLE packet
> communication for high MTU values. However, due to vendor-specific
> issues in the Bluetooth module firmware, using low MTU values
> (especially less than 256 bytes) results in dynamically calculated
> rx_credits being too low, causing slow speeds and occasional BLE
> connection failures.

You will have to be more specific here, what is the use case and model
that doesn't work depending on the number of credits? If the idea is
to just disable flow control to allow the remote side to pipe more
data then the MTU that sort of defeats the purpose of using CoC, but
maybe the use case requires or the remote side is too slow to process
the updates of credits?

> This change aims to improve BLE connection stability and speed
> for low MTU values. It is possible to tune minimum value
> of rx credits with debugfs handle.
>
> Signed-off-by: Pavel Shpakovskiy <shpakovskiip@gmail.com>
> ---
>  include/net/bluetooth/l2cap.h |  2 ++
>  net/bluetooth/l2cap_core.c    | 17 +++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 4bb0eaedda180..8648d9324a654 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -437,6 +437,8 @@ struct l2cap_conn_param_update_rsp {
>  #define L2CAP_CONN_PARAM_ACCEPTED      0x0000
>  #define L2CAP_CONN_PARAM_REJECTED      0x0001
>
> +#define L2CAP_LE_MIN_CREDITS           10
> +
>  struct l2cap_le_conn_req {
>         __le16     psm;
>         __le16     scid;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c88f69dde995e..392d7ba0f0737 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -50,6 +50,8 @@ static u32 l2cap_feat_mask =3D L2CAP_FEAT_FIXED_CHAN | =
L2CAP_FEAT_UCD;
>  static LIST_HEAD(chan_list);
>  static DEFINE_RWLOCK(chan_list_lock);
>
> +static u16 le_min_credits =3D L2CAP_LE_MIN_CREDITS;
> +
>  static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
>                                        u8 code, u8 ident, u16 dlen, void =
*data);
>  static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u=
16 len,
> @@ -547,8 +549,17 @@ static __u16 l2cap_le_rx_credits(struct l2cap_chan *=
chan)
>         /* If we don't know the available space in the receiver buffer, g=
ive
>          * enough credits for a full packet.
>          */
> -       if (chan->rx_avail =3D=3D -1)
> -               return (chan->imtu / chan->mps) + 1;
> +       if (chan->rx_avail =3D=3D -1) {
> +               u16 rx_credits =3D (chan->imtu / chan->mps) + 1;
> +
> +               if (rx_credits < le_min_credits) {
> +                       rx_credits =3D le_min_credits;
> +                       BT_DBG("chan %p: set rx_credits to minimum value:=
 %u",
> +                              chan, chan->rx_credits);

This doesn't make much sense in my opinion, if we want to disable flow
control then we shall allow the remote to pipe as many packets without
waiting for more credits, note though rx_credits handling changes
after receiving the first packet then the credits are updated based on
the socket receiving buffer:

https://github.com/bluez/bluetooth-next/commit/ce60b9231b66710b6ee24042ded2=
6efee120ecfc

So perhaps it is the socket receiving buffer that needs to be
adjusted, which is something the process has control over.

> +               }
> +
> +               return rx_credits;
> +       }
>
>         /* If we know how much space is available in the receive buffer, =
give
>          * out as many credits as would fill the buffer.
> @@ -7661,6 +7672,8 @@ int __init l2cap_init(void)
>         l2cap_debugfs =3D debugfs_create_file("l2cap", 0444, bt_debugfs,
>                                             NULL, &l2cap_debugfs_fops);
>
> +       debugfs_create_u16("l2cap_le_min_credits", 0644, bt_debugfs,
> +                          &le_min_credits);
>         return 0;
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

