Return-Path: <netdev+bounces-167937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1ABA3CE70
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4951A7A6336
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 01:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAFA28F5;
	Thu, 20 Feb 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBPXwxp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5D8488;
	Thu, 20 Feb 2025 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013788; cv=none; b=a2WuDTJtkWIHfruLzNsv9y7y+Mhy2/E+cOCaMPX14ogUcC37qOm16y8iYSredZ7tGtv1JBwzjhCCQvRTRHWdTHyH6xUqPLpkKNND0YwgeRsi0G14BAk6unDZ7qNYYO+cUYZbDBq62eyDpPwaESgYW/T6GRyhEfLB3prWK+bqzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013788; c=relaxed/simple;
	bh=PVSEWgOKQB23UpbLrhOb8TAZQTO00wnC/r0zuXDlikM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvCWSjA72SEnb2GJwwFF3ymzXzXymzX8xvdxIK0mszid6+63pdfycRwX7Wc+8fDQUqxC538ErUmVHk2burddFnDMlX1PXLauTmIjpmwkgrd1VcVr/3roqPKGiC69CMLe9Z1zMciaT1cuVtROibztGcQlPbfryjLS/R+mkPkXJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBPXwxp8; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so1369045ab.2;
        Wed, 19 Feb 2025 17:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740013786; x=1740618586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVIJyBVg5+N3syBltgdH9fL9hJ0Uz/788anvS/S5x30=;
        b=aBPXwxp8zp+jyqbRDGq/uZRxTqVCfr1e9qHpE4aGUwwRMkrnAIcG3UNggtzx1juajr
         F7PDHvEKXf/eRWcwbbWvS85CkXHX6zcu6Q4uEclHnHsP8x+tNizvO74/L5Bi+r9uoeAp
         Qm/r2sxfxE3IgS/qTSjVYtM4m4ymjjN30la7bNj5lLO9iDwgKZyUHQozFepaaU87eqbk
         hvVcveS84/jQjAkP8HYzZrIJBrlUNmMJ1H0k024l6gL2CpGrUFniRc5k/fVk9RjOr4NI
         DU8HRHrLe/tg541Vpjz2WRhy7hzGle94pVrTPc4zi8hksE8RVlWnYmK/yKtfSSy+k/80
         PSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013786; x=1740618586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVIJyBVg5+N3syBltgdH9fL9hJ0Uz/788anvS/S5x30=;
        b=EQOTUhZgQ7DaHl9SOEa4z4R1iPSj9pnDdrmw1V62sExjJHDL4ZQiimVcEEVkfqbf6K
         /Ga13hys5fRPnZaj54K7Mb1jVW5rxaeLuZ3FGHjDMp22DjffTp9tiZTRIgowE0CNAhH2
         yH6gI2t59AQBAyIsfNw7TjAV2AEPyKqx+SbmrM1+qR4m+BeVR98XEFvNJFlFDYprS5LU
         56ETYF88KAWJj+Csr3ZaOn8xSmrp8apQyULKxOndFUoszqNoV9fkaQ/yKLwyS2Ej8BeS
         pwtZGgS6q5XcGWrhFvAyO8faa9u1hA6G8kmfKEsGTSArsP9/PK/nXtwuSwRDNV2hWqMr
         OIOw==
X-Forwarded-Encrypted: i=1; AJvYcCVdMD2hASHJA1kXGQdq1ZeFZ/XLGs0g85K1P6Tln4kPw+aeiY0Y/M8Ofjz26g2fuUMvNjntIi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxef1frUysSZ5xLEehiTcD8bz7G5xA1jSAja4UTRbM2EAPy4zw0
	VueRg787HW4Y72pfazoZDFE56dicqaPhkye5mfPoJmvrq/QgvYKFKnAdDDqGOqeNHyZUCrFU7Ie
	vie0ZuBkDtd8SInJn1cB0peVTRDcobBJ16nBpBQ==
X-Gm-Gg: ASbGnct7wiveHI8D0xyOuskA+i0SL9HR1p30QlQ6Xuw14ZTQ0xwWSkT9/u7HOvB7D9R
	SgFmYypFYknpLs1revf4V852r4h4tRY1j1mbT2SxZggZCjbnfh6/90C0qPAfg1KSGyInslSw=
X-Google-Smtp-Source: AGHT+IEmLu7+/if+HPcGCoBXkQ3PGalpCvcRHPE7fkeUQcFunpFwCz5/mVVPjZniEytHNhRMS/lhtld2uor2t6qCxQA=
X-Received: by 2002:a05:6e02:3103:b0:3d0:443d:a5ad with SMTP id
 e9e14a558f8ab-3d280771825mr209495675ab.2.1740013785905; Wed, 19 Feb 2025
 17:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi> <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
In-Reply-To: <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 09:09:09 +0800
X-Gm-Features: AWEUYZnIqFcvfOce2doy7Ic49ougeuxZU5UJ6HGQvsWKAvKqQ_YCLUx9-5MH4co
Message-ID: <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
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
> ---
>
> Notes:
>     v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COMPLETION
>         together with SND, to save a bit in skb_shared_info.tx_flags
>
>         As it then cannot be set per-skb, reject setting it via CMSG.
>
>  Documentation/networking/timestamping.rst | 9 +++++++++
>  include/uapi/linux/errqueue.h             | 1 +
>  include/uapi/linux/net_tstamp.h           | 6 ++++--
>  net/core/sock.c                           | 2 ++
>  net/ethtool/common.c                      | 1 +
>  5 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/ne=
tworking/timestamping.rst
> index 61ef9da10e28..5034dfe326c0 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
>    cumulative acknowledgment. The mechanism ignores SACK and FACK.
>    This flag can be enabled via both socket options and control messages.
>
> +SOF_TIMESTAMPING_TX_COMPLETION:
> +  Request tx timestamps on packet tx completion, for the packets that
> +  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The completion

Is it mandatory for other drivers that will try to use
SOF_TIMESTAMPING_TX_COMPLETION in the future? I can see you coupled
both of them in hci_conn_tx_queue in patch [2/5]. If so, it would be
better if you add the limitation in sock_set_timestamping() so that
the same rule can be applied to other drivers.

But may I ask why you tried to couple them so tight in the version?
Could you say more about this? It's optional, right? IIUC, you
expected the driver to have both timestamps and then calculate the
delta easily?

Thanks,
Jason


> +  timestamp is generated by the kernel when it receives a packet
> +  completion report from the hardware. Hardware may report multiple
> +  packets at once, and completion timestamps reflect the timing of the
> +  report and not actual tx time. This flag can be enabled *only*
> +  via a socket option.
> +
>
>  1.3.2 Timestamp Reporting
>  ^^^^^^^^^^^^^^^^^^^^^^^^^
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
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a197f0a0b878..76a5d5cb1e56 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2933,6 +2933,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghd=
r *cmsg,
>                 tsflags =3D *(u32 *)CMSG_DATA(cmsg);
>                 if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
>                         return -EINVAL;
> +               if (tsflags & SOF_TIMESTAMPING_TX_COMPLETION)
> +                       return -EINVAL;
>
>                 sockc->tsflags &=3D ~SOF_TIMESTAMPING_TX_RECORD_MASK;
>                 sockc->tsflags |=3D tsflags;
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 5489d0c9d13f..ed4d6a9f4d7e 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -473,6 +473,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] =
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
> --
> 2.48.1
>
>

