Return-Path: <netdev+bounces-185280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91CA999D3
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC4D16C1B9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840A1DFE8;
	Wed, 23 Apr 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTND7A4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6DD530
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442018; cv=none; b=Lcm85JGwACG229lXGgYf1G5WR8ghh0QxTNAktUlNsAdpcwg4h9spnNXXDtVEcRwOQ8Wms/60Yv9wJUcwyjNhEV8hOQmxCas0KJ40lKAwyRWIyplcBM3+SYs9A693/hWhgVN0rB8a62bcqS1Ekq6/hsx0rUuybDIsE6H1d5MWn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442018; c=relaxed/simple;
	bh=3xHrSPv0fX/BUoyyvuqyKUO3RZRn7qOtKmhKtZoMRgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR5ISYnWB17GoHB242eZbZtAj3054VyaKHn88BKfQIO+b38tb/E1oTg+XasbTRBn6CF9V383W99MzylX0/ceoZWZsGZFtbUi4tS/RJFzALTtmI+ezEgyEUsXeJzuMsSWicIIrNURoR0rB6Ns+tLNZkTO4SBS2Miu1gZ6YltGBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTND7A4l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so65865ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745442016; x=1746046816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsu7fd5pla5b9F3bbYeYfKE9XXWx6yShCYlf/0DhYvg=;
        b=WTND7A4lYFwlb9qt0KFnfoMmwsaU2Wndo4BLnvl6j8bg2zCXIJZqqEg8f7auWM7jmV
         QMaTiiMKkD1LESg1MsgQ7WcQgG1PtA9j4bFE1MdIhhcYs5NjgVfBmwrm+FurVuOCn3Rz
         kL9Ww5OH6NqyDdhKa9BXU+Clk9liiN6Yej1oNzJNxNKlTKeV2zmGoHOwDU3iItBY9Nsy
         Z+1wAkFmF8mUQO+Yawcf+wGlWigQbAXdJqYCNdKHnWzy+qzpHkvvgGwfbBt17NAoCfiD
         YKtPtw+MTWhExzLG5G+vcamDZwWX+KljFdWr8eeBczcZrbPHKA6CQiU7mo9vODWxRDMt
         +OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442016; x=1746046816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsu7fd5pla5b9F3bbYeYfKE9XXWx6yShCYlf/0DhYvg=;
        b=A3fwh3s+OeO84W+J/VY2ZC7N48sCBuaTH4QO9ZR6G3yGcjfSzPwnUb9KCyH11+REoA
         hORTRQtovvOs26ULK6vDmYT32EfjE6P79pO+IWXLJJkvF2aVhmIaIXLQ27CqgqRFeKuc
         ohN6xb7taDezKp5hrSLCwm4LKW76MjRthEHJUp02jpaLnixls7kF+OjKSmFkUbCcy5ul
         faqPmX+8XREreHo9tl/ewlATXG9NoqN8PKmRw2ZKqdahgCLfXz09SE1iNxut/bfegwu0
         ajKVYJvxklnnjsaCL7oCrBi38+13zhL1/I/UNEnx+pUD4ryZWXBSBJKMkDkrI56eByTX
         bnbA==
X-Forwarded-Encrypted: i=1; AJvYcCWGJcgqyRenrSF8oD3Wo03w1/Lh7CKPAc372ixK8PZQXpQyAMju5+xWSPILFg9ZVHpPiFTF9hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KsFnq0fubCuolJpDBD6S5crAeGUs7xVO2Kebp/h0irSzKeUj
	hxOht0zP+XuqesE24argwB06H5fTPH+0KY3G0jUieFCKApdiBPp+5wH0JsePQij2RSVRFB0yhgw
	Ihk62HFojDD+ycMwmsBuYlqxj+I80N2S31SOHgX5DYdl4YAqbfA==
X-Gm-Gg: ASbGncsIw8VGPnrAtmiOthv2NMf+REk40VKC2556lHQDWc0C/li0WZsTPYLJWBLLLPi
	vtKz5zBQRtJBP2nq1a3Bcq5vB4K/uXAN6UB30N/YUxmnQNdCR9qKwOJVwojmB34gAyTrV+tcaiO
	4I4fIkhbK9y1cQBhrpiy/Jrqf7Fbb3SinTtlTjSdRVDZBmaT0VFrfw2JqUoUtOo50=
X-Google-Smtp-Source: AGHT+IHpsfDz3aci+hpRI0RoSo70cEE8Ca9ffuQ6dkdWUwWRb/YFF+yEkv7YyeIHU2BaXSUpaQXX9eqZ8+zLD9SR1Mg=
X-Received: by 2002:a17:902:ce08:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22db2089754mr1046825ad.0.1745442015838; Wed, 23 Apr 2025
 14:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421222827.283737-1-kuba@kernel.org> <20250421222827.283737-9-kuba@kernel.org>
In-Reply-To: <20250421222827.283737-9-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 14:00:01 -0700
X-Gm-Features: ATxdqUH9icw9U-qCtzHFhz_VFgIhz45SjwQhY0HjStzcpVzmTPsFJKLWBYgBJa4
Message-ID: <CAHS8izMH55e9hD3dC7zy_eTVf+PRgOGunsuidtY+yW3-2jO-jw@mail.gmail.com>
Subject: Re: [RFC net-next 08/22] eth: bnxt: support setting size of agg
 buffers via ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, dw@davidwei.uk, 
	asml.silence@gmail.com, ap420073@gmail.com, jdamato@fastly.com, 
	dtatulea@nvidia.com, michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> bnxt seems to be able to aggregate data up to 32kB without any issue.
> The driver is already capable of doing this for systems with higher
> order pages. While for systems with 4k pages we historically preferred
> to stick to small buffers because they are easier to allocate, the
> zero-copy APIs remove the allocation problem. The ZC mem is
> pre-allocated and fixed size.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 ++++++++++++++++++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 158b8f96f50c..1723909bde77 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -758,7 +758,8 @@ struct nqe_cn {
>  #define BNXT_RX_PAGE_SHIFT PAGE_SHIFT
>  #endif
>
> -#define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
> +#define BNXT_MAX_RX_PAGE_SIZE  (1 << 15)
> +#define BNXT_RX_PAGE_SIZE      (1 << BNXT_RX_PAGE_SHIFT)
>
>  #define BNXT_MAX_MTU           9500
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 48dd5922e4dd..956f51449709 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -835,6 +835,8 @@ static void bnxt_get_ringparam(struct net_device *dev=
,
>         ering->rx_jumbo_pending =3D bp->rx_agg_ring_size;
>         ering->tx_pending =3D bp->tx_ring_size;
>
> +       kernel_ering->rx_buf_len_max =3D BNXT_MAX_RX_PAGE_SIZE;
> +       kernel_ering->rx_buf_len =3D bp->rx_page_size;
>         kernel_ering->hds_thresh_max =3D BNXT_HDS_THRESHOLD_MAX;
>  }
>
> @@ -862,6 +864,21 @@ static int bnxt_set_ringparam(struct net_device *dev=
,
>                 return -EINVAL;
>         }
>
> +       if (!kernel_ering->rx_buf_len)  /* Zero means restore default */
> +               kernel_ering->rx_buf_len =3D BNXT_RX_PAGE_SIZE;
> +
> +       if (kernel_ering->rx_buf_len !=3D bp->rx_page_size &&
> +           !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
> +               NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not suppo=
rted");
> +               return -EINVAL;
> +       }
> +       if (!is_power_of_2(kernel_ering->rx_buf_len) ||
> +           kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
> +           kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
> +               NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or n=
ot power of 2");

Where does the power of 2 limitation come from? bnxt itself? Or some mp iss=
ue?

dmabuf mp can do non-power of 2 rx_buf_len, I think. I haven't tested
recently. It may be good to only validate here what bnxt can't do at
all, and let a later check in the pp/mp let us know if the mp doesn't
like the size.


--=20
Thanks,
Mina

