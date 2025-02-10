Return-Path: <netdev+bounces-164550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24763A2E2D7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 04:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020E93A4B82
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715C46447;
	Mon, 10 Feb 2025 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIbcB828"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA710EAF9;
	Mon, 10 Feb 2025 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158402; cv=none; b=oGe9z/cYGJZjxg6y6x4Za6Fr6L8dDBYNG7fwz/BBDsxZINfwPPOQh15CyCXl5vzvULqRzUgSR0TOd82p8dlC/c8lCjzfYe+qeaHBsWhHbhUBuwzFpKSdZIj2tWw6em2Qv0w+hdjYZmgpoZ7H66tyE1anxpiSfJzfEwNedtY5RWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158402; c=relaxed/simple;
	bh=ta/pyJoXAAQC6Ud4aMfarnt7JHE9YLMSkZS+iGOk9No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ei6X+YWoOyZlw1YMfBORnGtaCXtG57kw8yOnhs2gn0LFmRiOt9jjF+X5E1xlaWPAvkTH6QiwUhaNMpVVWCHoXEcIzdXVIvwUSkeKXilc381IhtwVmbdLwA10DqWPeDl1lF81qZFQDI3Gsbddb+v4mHfMimO6nW2uNOf660cDyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIbcB828; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso12950215ab.1;
        Sun, 09 Feb 2025 19:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739158400; x=1739763200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytFQTKV79+LnUBY/Ldx9tZwous46247MN1TjKF2jDC8=;
        b=iIbcB82822d1gdoW/nOhhtKQmValVA7LNapU1g8tXnboKatffIZqoNfKq99mw9CiF2
         q4Ovrj1QhLg0/HaHN+q89vpcE49024HgJYC0hVmKMAOaL6CzTUs4aJlqT6ofuar7uIrC
         9jiJ0W9CKESIVx0QvCLLSy52B7M/BAghAU8XYeszpB7k+gmSXNR7rl7TwR/7FXtwEuy5
         UC29JjFiyT4nQleGx4u+T0AAFsfcoNo18LkXeO0dbvl6f8RFfVtyvDL/O+ulLhQRHoX+
         1t66PmoGJyOoESDsZGfJxT8ihBYkVZiVqzIPdXsYGo6dnovvjlYCqMbjenX+LCDMLKAK
         XPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739158400; x=1739763200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytFQTKV79+LnUBY/Ldx9tZwous46247MN1TjKF2jDC8=;
        b=ZuCtBV023p0jiVG8HIaSOzYq/B61uTcgF1eZGpjki1DHRZrPDe0sYXVORo92C3sdwk
         LkSrY6vgXCBj/WPilaT23vKrB6Vgaf4m9DntHuA7vPSjUBMjY0tPEMeRQak+eqPg7nNr
         C8qCrKmcEMGmBD4hkjq4vE491qJ2XjjNF6VF0HS02omMTPgQBmAFFOehU8Vlq9CdrPOo
         DEl8w/ulDcT6oeopOv7LY5woJ6bg5iXUn9ROZwxQoDwVYdubIuyWqE/RfVXgbkHyNAS1
         mQknZrO2c67/2qAUqPH9gz4LU5pMnItzXsIp5FnbiOAxHcge9B1QtNs24hpvhR3aRt5j
         fciA==
X-Forwarded-Encrypted: i=1; AJvYcCVsVNfzR8t3cYQc/O5NQGy5uBeUGs1gNM3chUi+FiN8/s80IoK4IZSFVuYMkIo3nLrp8wPV148=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+FDuPWR5Z9oPN65AnIbabQige/ZT/lEjgYLFza7kirX6DEH7
	Mg4fSNgV7SV3r73vrK1rdR8JG8caedFjvikE0NhmZTnW1jH0C+R9IerF//HslANHLH+0fUfXFC5
	GBMU/I0pq1Dl4xVe1+/vVW3HlXQw=
X-Gm-Gg: ASbGncuQIjizGCJsp6I2pMK1nAqJCNDQ+y8+LLBA+KpGp4Iy3szAmyT55ony//okQxI
	7IqI6yCVVkY8B3vIDRGm/6MPimiCdL3gTjBg/5GCkPATDGfrVqtKZsK85RN3Xhv57/0C1UwA=
X-Google-Smtp-Source: AGHT+IHdOhMd/hHfdVG/7qC8djsgcOKmxpczgqa/YZAvwB+yt+w1TT8QKlkRwIRgt9X4sDpJHjnIDFVZ5ANUf9h9oiM=
X-Received: by 2002:a05:6e02:4510:b0:3d0:3fa2:ccfd with SMTP id
 e9e14a558f8ab-3d13dcde8c6mr92776865ab.5.1739158399697; Sun, 09 Feb 2025
 19:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739097311.git.pav@iki.fi> <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
In-Reply-To: <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Feb 2025 11:32:43 +0800
X-Gm-Features: AWEUYZmEiJj7zdDBoOCH4EI5S6VxSSdhR9sT15afB6-tI1Zdj-uUcpv6umZ_rEI
Message-ID: <CAL+tcoAjCYkwAzYC4jaEfsrFmNEhwnLiJCtEQ7un3wHTqnkwmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Feb 9, 2025 at 6:40=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> when hardware reports a packet completed.
>
> Completion tstamp is useful for Bluetooth, where hardware tx timestamps
> cannot be obtained except for ISO packets, and the hardware has a queue

Could you say more about why the hw timestamp cannot be obtained?

> where packets may wait.  In this case the software SND timestamp only
> reflects the kernel-side part of the total latency (usually small) and
> queue length (usually 0 unless HW buffers congested), whereas the
> completion report time is more informative of the true latency.
>
> It may also be useful in other cases where HW TX timestamps cannot be
> obtained and user wants to estimate an upper bound to when the TX
> probably happened.

It's worth mentioning the earlier discussion that took place last year
in the commit log. It's hard to retrieve such an important discussion
buried in the mailing list, which should be helpful for people to get
to know/recall the exact background :)

https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googlers.co=
m.notmuch/.
https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/

And it's also good to attach the real use case from the following link
for readers to know the exact case :)

https://lore.kernel.org/all/7ade362f178297751e8a0846e0342d5086623edc.camel@=
iki.fi/
Quoting here:
"
sendmsg() from user generates skbs to net/bluetooth side queue
|
* wait in net/bluetooth side queue until HW has free packet slot
|
* send to driver (-> SCM_TSTAMP_SCHED*)
|
* driver (usu. ASAP) queues to transport e.g. USB
|
* transport tx complete, skb freed
|
* packet waits in hardware-side buffers (usu. the largest delay)
|
* packet completion report from HW (-> SCM_TSTAMP_SND*)
|
* for one packet type, HW timestamp for last tx packet can queried
The packet completion report does not imply the packet was received.
"

> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  Documentation/networking/timestamping.rst | 9 +++++++++
>  include/linux/skbuff.h                    | 6 +++++-
>  include/uapi/linux/errqueue.h             | 1 +
>  include/uapi/linux/net_tstamp.h           | 6 ++++--
>  net/ethtool/common.c                      | 1 +
>  net/socket.c                              | 3 +++
>  6 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
> index 61ef9da10e28..de2afed7a516 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
>    cumulative acknowledgment. The mechanism ignores SACK and FACK.
>    This flag can be enabled via both socket options and control messages.
>
> +SOF_TIMESTAMPING_TX_COMPLETION:
> +  Request tx timestamps on packet tx completion.  The completion
> +  timestamp is generated by the kernel when it receives packet a
> +  completion report from the hardware. Hardware may report multiple
> +  packets at once, and completion timestamps reflect the timing of the
> +  report and not actual tx time. The completion timestamps are
> +  currently implemented only for: Bluetooth L2CAP and ISO.  This
> +  flag can be enabled via both socket options and control messages.
> +

I'd like to know if this flag can also be applied to NICs which have
already implemented the hardware timestamp, like Intel i40e, no?

Thanks,
Jason


>
>  1.3.2 Timestamp Reporting
>  ^^^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..3707c9075ae9 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -489,10 +489,14 @@ enum {
>
>         /* generate software time stamp when entering packet scheduling *=
/
>         SKBTX_SCHED_TSTAMP =3D 1 << 6,
> +
> +       /* generate software time stamp on packet tx completion */
> +       SKBTX_COMPLETION_TSTAMP =3D 1 << 7,
>  };
>
>  #define SKBTX_ANY_SW_TSTAMP    (SKBTX_SW_TSTAMP    | \
> -                                SKBTX_SCHED_TSTAMP)
> +                                SKBTX_SCHED_TSTAMP | \
> +                                SKBTX_COMPLETION_TSTAMP)
>  #define SKBTX_ANY_TSTAMP       (SKBTX_HW_TSTAMP | \
>                                  SKBTX_HW_TSTAMP_USE_CYCLES | \
>                                  SKBTX_ANY_SW_TSTAMP)
> diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.=
h
> index 3c70e8ac14b8..1ea47309d772 100644
> --- a/include/uapi/linux/errqueue.h
> +++ b/include/uapi/linux/errqueue.h
> @@ -73,6 +73,7 @@ enum {
>         SCM_TSTAMP_SND,         /* driver passed skb to NIC, or HW */
>         SCM_TSTAMP_SCHED,       /* data entered the packet scheduler */
>         SCM_TSTAMP_ACK,         /* data acknowledged by peer */
> +       SCM_TSTAMP_COMPLETION,  /* packet tx completion */
>  };
>
>  #endif /* _UAPI_LINUX_ERRQUEUE_H */
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tst=
amp.h
> index 55b0ab51096c..383213de612a 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -44,8 +44,9 @@ enum {
>         SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
>         SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
>         SOF_TIMESTAMPING_OPT_RX_FILTER =3D (1 << 17),
> +       SOF_TIMESTAMPING_TX_COMPLETION =3D (1 << 18),
>
> -       SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_OPT_RX_FILTER,
> +       SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_TX_COMPLETION,
>         SOF_TIMESTAMPING_MASK =3D (SOF_TIMESTAMPING_LAST - 1) |
>                                  SOF_TIMESTAMPING_LAST
>  };
> @@ -58,7 +59,8 @@ enum {
>  #define SOF_TIMESTAMPING_TX_RECORD_MASK        (SOF_TIMESTAMPING_TX_HARD=
WARE | \
>                                          SOF_TIMESTAMPING_TX_SOFTWARE | \
>                                          SOF_TIMESTAMPING_TX_SCHED | \
> -                                        SOF_TIMESTAMPING_TX_ACK)
> +                                        SOF_TIMESTAMPING_TX_ACK | \
> +                                        SOF_TIMESTAMPING_TX_COMPLETION)
>
>  /**
>   * struct so_timestamping - SO_TIMESTAMPING parameter
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 2bd77c94f9f1..75e3b756012e 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] =
=3D {
>         [const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
>         [const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-tcp",
>         [const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] =3D "option-rx-filt=
er",
> +       [const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] =3D "completion-tra=
nsmit",
>  };
>  static_assert(ARRAY_SIZE(sof_timestamping_names) =3D=3D __SOF_TIMESTAMPI=
NG_CNT);
>
> diff --git a/net/socket.c b/net/socket.c
> index 4afe31656a2b..22b7f6f50889 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -693,6 +693,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flag=
s)
>         if (tsflags & SOF_TIMESTAMPING_TX_SCHED)
>                 flags |=3D SKBTX_SCHED_TSTAMP;
>
> +       if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
> +               flags |=3D SKBTX_COMPLETION_TSTAMP;
> +
>         *tx_flags =3D flags;
>  }
>  EXPORT_SYMBOL(__sock_tx_timestamp);
> --
> 2.48.1
>
>

