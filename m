Return-Path: <netdev+bounces-175959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB9CA68119
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CFA188E3B1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408EC801;
	Wed, 19 Mar 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7uE20AQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858138F6D;
	Wed, 19 Mar 2025 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343246; cv=none; b=oC8CQrpgH5rK0yuj6lKSBkj9QYSnhEE2XpykBsDzLz3mu4WngwMFI6KB5jTxNv6GHO3QQghOChXdvUeAJRs+FZwK/GTb66lL+rWZC8Bv8it5+GjKbwLQT5ifwx36UemH++WTirzcAo3Kll/DBfgLutiMPQH5PigYqyQHLkf327U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343246; c=relaxed/simple;
	bh=MKV9mldf0+4FyDmj8o9yUY5iaNVxvWM0Ed5a/roJW7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct/22OmGuyP0DnmYAFdm7OB8yoBXgGIvW80QKpN4j93b6htSkWvxZAjH/98H59D8NK0DkRodC9nMouZ5cemZepEb2bNEXYIkZ6dK+LG9gcmPuRvTbPHP5EIfF5dMxM2l9jYSLZAzt583XE8rq+wS7mfa9hJaOKpVZ0VDAtia08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7uE20AQ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d450154245so47113685ab.2;
        Tue, 18 Mar 2025 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742343243; x=1742948043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2fi7e9XAXBy8lWgbII5AXZTyL4VEd07+VXnYBp5Ecs=;
        b=f7uE20AQ8t9+DDB9yseKAaVl9gOfrJtrcV5fbYMKKhDxNswAohxuE4cFvEsz/UzRKm
         VkK6lWntzYOFooPbbf+l84IGwQ5eZpQ6AqrKxrJuRINFKe8fuTmTDRj/MaxgQWRs0fIx
         ZOoUpjKKFffVMOO5gWTJzS3BF5KxpzahqCC8e6TWqlS094+HcjUuqacDFIuWcCvsAFrJ
         x1ilW2GoaJVx69/ZcVUHrHvJkwSVN9UHPBVBU8DHvHF0C/2gEe4Y8cRS31UzUUiNEy1T
         LuaEE4JAECbjWeBFf75TOSILmPrdNoKdKGtD5TNCIIHgPp4ucTxzDm2Pd2UtlUathUgI
         yQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343243; x=1742948043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2fi7e9XAXBy8lWgbII5AXZTyL4VEd07+VXnYBp5Ecs=;
        b=K83NCOojLlK60oq5tFzc22kX+CGmcyYHzYZ1FCoBuBvrftDvdhmy+75KjuHFFxMFT4
         ASJ5/iPdcGAtPHIlz2cSFj+hryGKa1ZR5AEwJV8ZtBDCbpsIfoVPH0ZdmdDzboT55KUG
         zqlSUMF8vki1rUXITasD+lHYakS2ttubWU7PfuHxjVIywgAhj521rCqWVdwZFZSaYqma
         Mgw5ZELvUGqkS/k89tnUp3RkWiYGlIOwtrTx9mrQLbZSXhL29gF0iZHyDam4K0w6meaV
         YQsjxmwxTyIzLxat2OqoBOXgVwHlk1KbbmathWbST5QVvsMju4vMXMC+gxocljHziFQ5
         jC3g==
X-Forwarded-Encrypted: i=1; AJvYcCUjloUGEOlgXWvkAnrtY0j6k5hgtO9yjJgqN+ZOfInxIxcRaf+ahIyxV6jYiof/sEMspmJT6I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuzFJwGNpqkVNEpQrr//rwnGg2aUAXld9vyjrwbkyzUxC6llOh
	YnilcRtdddwOcIykbVKNqUn80ok+yyGkmHRMo9hVHz2NtJ3Nmr1h2BT3iRLsVhriR36AGyEA5KC
	UHCt2nZPsZ/nBtqE/X8ZWUQFpVzNb9qMw
X-Gm-Gg: ASbGncuk8NmuMuutYKjMO7xK1kw4yGvZkFcxXuhIzStfb6BbYKqvOgWjfc3yjJrt/St
	MW+E1diZ2aLctw8AyDCWRbfhr8RVTr3Tf7IwYVUqqa2ezUbzvQYdOELtPxdMYwQDRaqKnbAB4y2
	wCcsxpaUZwFpmPRCwXfjXGH7oe8QICDqQFOtA=
X-Google-Smtp-Source: AGHT+IE3gSCH9UrTcfxJRC0OGpuf/+vx1CqPVrvnShQCtYDOtQq48MC7EjkJveX0rCxuXIiH9HKa5jX0znahwJbSs2A=
X-Received: by 2002:a05:6e02:1a47:b0:3d1:92fc:fb45 with SMTP id
 e9e14a558f8ab-3d586b243e3mr7670635ab.5.1742343243477; Tue, 18 Mar 2025
 17:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742324341.git.pav@iki.fi> <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
In-Reply-To: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Mar 2025 08:13:27 +0800
X-Gm-Features: AQ5f1JoIE7st4RKueBH-_TmpE1yFcPtsvt5-6nt7lNOw2_qPUkbl84LiibMF_hY
Message-ID: <CAL+tcoDL0FwC6i_3q46HrKA0Sua-KKXxTpWpR94ev9RovdHgWQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:08=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> when hardware reports a packet completed.
>
> Completion tstamp is useful for Bluetooth, as hardware timestamps do not
> exist in the HCI specification except for ISO packets, and the hardware
> has a queue where packets may wait.  In this case the software SND
> timestamp only reflects the kernel-side part of the total latency
> (usually small) and queue length (usually 0 unless HW buffers
> congested), whereas the completion report time is more informative of
> the true latency.
>
> It may also be useful in other cases where HW TX timestamps cannot be
> obtained and user wants to estimate an upper bound to when the TX
> probably happened.
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Hi Pauli,

This patch overall looks good to me but it depends on the small
question in another patch that is relevant to how we use this new flag
in reality. Let's discuss a bit there.

Thanks,
Jason

> ---
>
> Notes:
>     v5:
>     - back to decoupled COMPLETION & SND, like in v3
>     - BPF reporting not implemented here
>
>  Documentation/networking/timestamping.rst | 8 ++++++++
>  include/linux/skbuff.h                    | 7 ++++---
>  include/uapi/linux/errqueue.h             | 1 +
>  include/uapi/linux/net_tstamp.h           | 6 ++++--
>  net/core/skbuff.c                         | 2 ++
>  net/ethtool/common.c                      | 1 +
>  net/socket.c                              | 3 +++
>  7 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
> index 61ef9da10e28..b8fef8101176 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
>    cumulative acknowledgment. The mechanism ignores SACK and FACK.
>    This flag can be enabled via both socket options and control messages.
>
> +SOF_TIMESTAMPING_TX_COMPLETION:
> +  Request tx timestamps on packet tx completion.  The completion
> +  timestamp is generated by the kernel when it receives packet a
> +  completion report from the hardware. Hardware may report multiple
> +  packets at once, and completion timestamps reflect the timing of the
> +  report and not actual tx time. This flag can be enabled via both
> +  socket options and control messages.
> +
>
>  1.3.2 Timestamp Reporting
>  ^^^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index cd8294cdc249..b974a277975a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -478,8 +478,8 @@ enum {
>         /* device driver is going to provide hardware time stamp */
>         SKBTX_IN_PROGRESS =3D 1 << 2,
>
> -       /* reserved */
> -       SKBTX_RESERVED =3D 1 << 3,
> +       /* generate software time stamp on packet tx completion */
> +       SKBTX_COMPLETION_TSTAMP =3D 1 << 3,
>
>         /* generate wifi status information (where possible) */
>         SKBTX_WIFI_STATUS =3D 1 << 4,
> @@ -498,7 +498,8 @@ enum {
>
>  #define SKBTX_ANY_SW_TSTAMP    (SKBTX_SW_TSTAMP    | \
>                                  SKBTX_SCHED_TSTAMP | \
> -                                SKBTX_BPF)
> +                                SKBTX_BPF          | \
> +                                SKBTX_COMPLETION_TSTAMP)
>  #define SKBTX_ANY_TSTAMP       (SKBTX_HW_TSTAMP | \
>                                  SKBTX_ANY_SW_TSTAMP)
>
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
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ab8acb737b93..6cbf77bc61fc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5523,6 +5523,8 @@ static bool skb_tstamp_tx_report_so_timestamping(st=
ruct sk_buff *skb,
>                                                     SKBTX_SW_TSTAMP);
>         case SCM_TSTAMP_ACK:
>                 return TCP_SKB_CB(skb)->txstamp_ack & TSTAMP_ACK_SK;
> +       case SCM_TSTAMP_COMPLETION:
> +               return skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAM=
P;
>         }
>
>         return false;
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 7e3c16856c1a..0cb6da1f692a 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -476,6 +476,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] =
=3D {
>         [const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
>         [const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-tcp",
>         [const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] =3D "option-rx-filt=
er",
> +       [const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] =3D "tx-completion"=
,
>  };
>  static_assert(ARRAY_SIZE(sof_timestamping_names) =3D=3D __SOF_TIMESTAMPI=
NG_CNT);
>
> diff --git a/net/socket.c b/net/socket.c
> index b64ecf2722e7..e3d879b53278 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -689,6 +689,9 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flag=
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

