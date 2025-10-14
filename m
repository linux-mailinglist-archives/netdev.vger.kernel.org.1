Return-Path: <netdev+bounces-229287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB6BDA1F8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A4E19A472F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625F30101A;
	Tue, 14 Oct 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHluXEw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CA3002DA
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452815; cv=none; b=STPH/uA+tsKDIF8InwfbqYiX+DUobpuEhCM5LX0b5WD6OKvpAPUOuJE35eeeD9V7wVODZ3xCFsksPHp9dt8IjMIyPiCnZSgqPSo6Mx37CvsnY4HSozJK5nLjwxGcxv+ipg2A2/2g8jdX6V459Hb4c6StEJ5A3IRoNRKMam+BbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452815; c=relaxed/simple;
	bh=p2MEHVG7Vzm46QdVAk/MrtWjsWMsTxtxdLw4lX8PFMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MM9tG98Wgr7UeN2Erk0nVP7RsjTBhzZOcE+xMMiwM+hdKOL7bomXsfdxhY66xUZkWIUHGM0onnhWIcVJvQfXudT1d9fE4jQXG7+SUS/AnZlVa8kFGkp0ZoqZd7sXMNKYZXMDp529+naC+QYcVCuGAzdgf0o1A2j2BEz2j35qAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHluXEw6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8599c274188so649858185a.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760452811; x=1761057611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkgeaQLsuiO0teqqOdLT1GeMdhJF9Rhz1O754tEMQ/o=;
        b=bHluXEw6CPzxxnoxMWzyj88EnuGVBg/Ey5Vk9g+OSN5lO0bjTfnTY7YTE5UjNPVgzk
         MvEmP25GiySLDaefYxI8udNOOpPUtYx7FB6dThJ5PCyewS8vtMFrlgyDtYw2He9E5itX
         LmsB9CTY0mb6ZAzdiu37BynGAzrNM7451BJzlCFelYQ4n53SsOOo04UCmVma3G79xtoo
         f34dqKUXkEFonS3vr3lALrzGUF9AbOFnVy1rv2oMTW1WzQEAkeQX+yFhZGsgHskElJEW
         m4T5nj17URVYmWxP6reNvfzZobumjhD6c6ZD1oQfUK0alHkAYCjBWWAM3/exdu+74yrp
         j/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452811; x=1761057611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkgeaQLsuiO0teqqOdLT1GeMdhJF9Rhz1O754tEMQ/o=;
        b=wYlfHMz6P8Cou4/PBlPYufVR1m8C/UjgvvkjuOC1oyxUpFDFkz7i96wqEmSEfNEssX
         Q2o0Aoj5wMsX9gsgLBETV/3LGdKPmbmUINOCNlEi0NqnkMdDb1njQricnJAgHpPmtCGG
         3yeLeztK74SwJdCoSynYN6F5frdGUaToNYKnWajHQK7lgjDcxs8NvprV1ZwaadA/Y5uX
         8AAp0GDVHfAgySV66lebJ8NxjZ0H6FiRXB3wq8FVJs7iYk5FHbq8ZaV4lhThA8rDOy1C
         yDTD9etbprm2pTIiCezF5xg7MkQsEaJeGPW6InnlQBjxM7YIxoiMJx8ZhHxbiTlSHis7
         nCHQ==
X-Gm-Message-State: AOJu0YwVghwxABXIA9rVeQaxciNyQtZbDo4oDRrOuZOa+Gw5voFcsf83
	crpznWZMp0Xz9IgH9wOdzC1rREX7/R3BIGLIil11F9kCXMXz5oqvFVahOGwEUBoSBmgDHCQeW5R
	9xWypYgsMdb3DFSp1NRZdAtfFdOXXwwVbyRUNlkhYEOzqIptetgZuBY/nywU=
X-Gm-Gg: ASbGnctlBOOeHZ72RNXgovu1cjLCrDgzpUVIvyf6GrKTzYD9A557/TIhoKcD6FyAozz
	9x07foziJ+pZegyQQ8j0lUVpyzZPRvD7y1aY46N8A93ZHXW4B9WL+Hu31rq3H9HYP4/EuBEnx/B
	/pbhUKo2a+OKacMlFt9vzwYET5maabexNXbzm9h2W86nKcJVaVxAu8XbTZ3mDhHrcOp290O31a7
	/m7umS17jErXRZ3BmvmswxTAR6N/VK2+pE7QGgvgf8=
X-Google-Smtp-Source: AGHT+IEI6Wav+s3ovrrzGPy0tAgVPOiCNvOpprW4y75yQDUyDlGq/QmssmyxF6T0pDTCpNKEiwZUcvURRxdf5tIlVOc=
X-Received: by 2002:a05:622a:550a:b0:4d8:3c3:27c8 with SMTP id
 d75a77b69052e-4e6ead6334fmr373773741cf.67.1760452810885; Tue, 14 Oct 2025
 07:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014004740.2775957-1-hramamurthy@google.com>
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 07:39:59 -0700
X-Gm-Features: AS18NWBRQgkFHeg5z9fFjMi-kojUhY4h7zTv2rWHAhH6eoTmNCo4VDyzZ5ixrPY
Message-ID: <CANn89iKOK9GyjQ_s_eo5XNugHARSRoeeu2c1muhBj8oxYL6UEQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw timestamping
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	pkaligineedi@google.com, jfraker@google.com, ziweixiao@google.com, 
	thostet@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:47=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Tim Hostetler <thostet@google.com>
>
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do n=
ot
> hardware timestamp the SKB.
>
> Cc: stable@vger.kernel.org
> Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestam=
ping")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h          |  2 ++
>  drivers/net/ethernet/google/gve/gve_desc_dqo.h |  3 ++-
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c   | 18 ++++++++++++------
>  3 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index bceaf9b05cb4..4cc6dcbfd367 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -100,6 +100,8 @@
>   */
>  #define GVE_DQO_QPL_ONDEMAND_ALLOC_THRESHOLD 96
>
> +#define GVE_DQO_RX_HWTSTAMP_VALID 0x1
> +
>  /* Each slot in the desc ring has a 1:1 mapping to a slot in the data ri=
ng */
>  struct gve_rx_desc_queue {
>         struct gve_rx_desc *desc_ring; /* the descriptor ring */
> diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers/net=
/ethernet/google/gve/gve_desc_dqo.h
> index d17da841b5a0..f7786b03c744 100644
> --- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
> +++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
> @@ -236,7 +236,8 @@ struct gve_rx_compl_desc_dqo {
>
>         u8 status_error1;
>
> -       __le16 reserved5;
> +       u8 reserved5;
> +       u8 ts_sub_nsecs_low;
>         __le16 buf_id; /* Buffer ID which was sent on the buffer queue. *=
/
>
>         union {
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 7380c2b7a2d8..02e25be8a50d 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -456,14 +456,20 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
>   * Note that this means if the time delta between packet reception and t=
he last
>   * clock read is greater than ~2 seconds, this will provide invalid resu=
lts.
>   */
> -static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
> +static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,
> +                               const struct gve_rx_compl_desc_dqo *desc)
>  {
>         u64 last_read =3D READ_ONCE(rx->gve->last_sync_nic_counter);
>         struct sk_buff *skb =3D rx->ctx.skb_head;
> -       u32 low =3D (u32)last_read;
> -       s32 diff =3D hwts - low;
> -
> -       skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_read + diff);
> +       u32 ts, low;
> +       s32 diff;
> +
> +       if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) {
> +               ts =3D le32_to_cpu(desc->ts);
> +               low =3D (u32)last_read;
> +               diff =3D ts - low;
> +               skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_read + =
diff);
> +       }

If (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) can vary among
all packets received on this queue,
I will suggest you add an

        else {
                 skb_hwtstamps(skb)->hwtstamp =3D 0;
        }

This is because napi_reuse_skb() does not currently clear this field.

So if a prior skb had hwtstamp set to a timestamp, then merged in GRO,
and recycled, we have the risk of reusing an old timestamp
if GVE_DQO_RX_HWTSTAMP_VALID is unset.

We could also handle this generically, at the cost of one extra
instruction in the fast path.


>  }
>
>  static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring=
 *rx)
> @@ -919,7 +925,7 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx=
, struct napi_struct *napi,
>                 gve_rx_skb_csum(rx->ctx.skb_head, desc, ptype);
>
>         if (rx->gve->ts_config.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
> -               gve_rx_skb_hwtstamp(rx, le32_to_cpu(desc->ts));
> +               gve_rx_skb_hwtstamp(rx, desc);
>
>         /* RSC packets must set gso_size otherwise the TCP stack will com=
plain
>          * that packets are larger than MTU.
> --
> 2.51.0.740.g6adb054d12-goog
>

