Return-Path: <netdev+bounces-95672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3FB8C2F5E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6248C1C20A6B
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E536AFE;
	Sat, 11 May 2024 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc4EKJ4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B431843
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398320; cv=none; b=EJxTMH0/3o7U4GJ4TIv3RVupU7vpwDO4gBKTcNTNZRn+wExljSIkaxQiQ/+5WdGA4xSFPOOm0nTI4UEwwtyPRwF2HlTqLegUxZhYifWZuIL5GKnj11RAOBwd2Z4E4OLkk8XnQsBUIjJH4lv4Cnkn+qQo8aeqyY2pVdcyXKSAXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398320; c=relaxed/simple;
	bh=k74GQ5uTlanNKEBqFG+YfCXARAad6aZ8GQrXlAA/Gis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmaoCnnpfNnur7dR8IPWKPkHHodh67TnIeV/1po632UxMDHwX3M/M3gvv8lb33bl5IBF3GKEP4apqjMAuui0rXRnlYlXABRlJYhr0413myFr23gnfoyMCfODwTiMCgbU7Opng2VZdO9/kT6qNXegr93cZxCoJWhukdlst4UdkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc4EKJ4o; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso3635139e87.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715398317; x=1716003117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bet+86JPzdUIr/52bYNt4dp7zDPRay7patpJlaTQxt4=;
        b=cc4EKJ4odMMNFXN5DkeJEYYxNzFzGbPiS0bzHIJzHV0bSNv1kE8S6+ppPfTbCFasZb
         tXPmt6ymdwvEj+gY+ETkhcjD4T6Hz8Dk41eR1YNtppLnlGZh4zB2kMZGROmQOpQM6RvN
         nYTA49+JcaPxMxBgPdvgyZA+5qzgkkBMClO+Es9v2OHP5G9YRZpzN1BQxKdT8q4K0H+d
         c+odc3h7ktyvq7FQoKS6p2g4/+x+HQYO3VgXVve712rvuhooyo9WkTHzsT13OhPULCos
         hYDgdEngDSNQf7/xDKTOpRbNjssUTWALUbXfYOPjxtcuT2J4zqjXuygIKyd4Rkttv2Dh
         YORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715398317; x=1716003117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bet+86JPzdUIr/52bYNt4dp7zDPRay7patpJlaTQxt4=;
        b=VSuenpcOy+yXL/unXmTxntW1fjTLcFjYc2Y0N56c6ErU/Cq39moQfAzYOX+K6BHvfO
         I6tzUG1cAl41/R3DOUiDVmObIYnuRbcCC4kaO2gaUG+WdkF0kd6Z75qZ2CgRzjBdZqil
         dwQJBCkoRIBBGmIed2gHBgqtxpWbLL63gfciQjFRBZPmR78ovLOgL+mcsRDi1civ7iDk
         KIz8QxteLpFkPFX+qilsXSDAVcGMY2XNirsHnWJ5/nrXu1O4NaK35bXYpqBwcIvYJPTF
         3BkxYcEB2y5hlnd4weA0UCMiPqpIz9WASUVkNL7aMfl6W9S/F/X60RZ6igv2+tmO9YX+
         P13w==
X-Gm-Message-State: AOJu0YwC7f+AdUfb4JI/Av+Q8PnxxDqV+khwitGkufGLpzXn9rhtsoU0
	NStVxTHQk2Chrlc3ovOE8o+olpxWgjiRZ/wHPAjfVZPNpoX+v1O4W4v4IASMlyAweOOWzKdJMYL
	y2uwHhj+fL8ImSuKCuGFwrUsf10c=
X-Google-Smtp-Source: AGHT+IHhRTHg5msUv+nda60P8Qu5F8FmHirX2Tw1rE8ahnYhJjqHin8GASHCvEByhmUgihzyEXlNvQ4q+Lkvlkj8nK8=
X-Received: by 2002:a05:6512:230a:b0:51c:c2c1:6f58 with SMTP id
 2adb3069b0e04-522105792e0mr3025298e87.55.1715398316715; Fri, 10 May 2024
 20:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510201927.1821109-1-danielj@nvidia.com> <20240510201927.1821109-2-danielj@nvidia.com>
In-Reply-To: <20240510201927.1821109-2-danielj@nvidia.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 11 May 2024 11:31:19 +0800
Message-ID: <CAL+tcoB0TmcNoLdFMcfOCKGbkqAttV7UpCZf8D3TTjKwvgw7Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] netdev: Add queue stats for TX stop and wake
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 4:20=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> TX queue stop and wake are counted by some drivers.
> Support reporting these via netdev-genl queue stats.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Good to see this finally :)

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  Documentation/netlink/specs/netdev.yaml | 14 ++++++++++++++
>  include/net/netdev_queues.h             |  3 +++
>  include/uapi/linux/netdev.h             |  2 ++
>  net/core/netdev-genl.c                  |  4 +++-
>  tools/include/uapi/linux/netdev.h       |  2 ++
>  5 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 2be4b3714d17..11a32373365a 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -439,6 +439,20 @@ attribute-sets:
>            Number of the packets dropped by the device due to the transmi=
t
>            packets bitrate exceeding the device rate limit.
>          type: uint
> +      -
> +        name: tx-stop
> +        doc: |
> +          Number of times driver paused accepting new tx packets
> +          from the stack to this queue, because the queue was full.
> +          Note that if BQL is supported and enabled on the device
> +          the networking stack will avoid queuing a lot of data at once.
> +        type: uint
> +      -
> +        name: tx-wake
> +        doc: |
> +          Number of times driver re-started accepting send
> +          requests to this queue from the stack.
> +        type: uint
>
>  operations:
>    list:
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index e7b84f018cee..a8a7e48dfa6c 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -41,6 +41,9 @@ struct netdev_queue_stats_tx {
>         u64 hw_gso_wire_bytes;
>
>         u64 hw_drop_ratelimits;
> +
> +       u64 stop;
> +       u64 wake;
>  };
>
>  /**
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index cf24f1d9adf8..a8188202413e 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -165,6 +165,8 @@ enum {
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
>         NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
> +       NETDEV_A_QSTATS_TX_STOP,
> +       NETDEV_A_QSTATS_TX_WAKE,
>
>         __NETDEV_A_QSTATS_MAX,
>         NETDEV_A_QSTATS_MAX =3D (__NETDEV_A_QSTATS_MAX - 1)
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 4b5054087309..1f6ae6379e0f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -517,7 +517,9 @@ netdev_nl_stats_write_tx(struct sk_buff *rsp, struct =
netdev_queue_stats_tx *tx)
>             netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_BYTES, tx->hw_=
gso_bytes) ||
>             netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS, =
tx->hw_gso_wire_packets) ||
>             netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES, tx=
->hw_gso_wire_bytes) ||
> -           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, t=
x->hw_drop_ratelimits))
> +           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, t=
x->hw_drop_ratelimits) ||
> +           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_STOP, tx->stop) ||
> +           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_WAKE, tx->wake))
>                 return -EMSGSIZE;
>         return 0;
>  }
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux=
/netdev.h
> index cf24f1d9adf8..a8188202413e 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -165,6 +165,8 @@ enum {
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
>         NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
> +       NETDEV_A_QSTATS_TX_STOP,
> +       NETDEV_A_QSTATS_TX_WAKE,
>
>         __NETDEV_A_QSTATS_MAX,
>         NETDEV_A_QSTATS_MAX =3D (__NETDEV_A_QSTATS_MAX - 1)
> --
> 2.45.0
>
>

