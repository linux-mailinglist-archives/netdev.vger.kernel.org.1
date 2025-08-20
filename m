Return-Path: <netdev+bounces-215412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746CB2E863
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 00:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACB4686686
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6762D8DB9;
	Wed, 20 Aug 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2Jfy/w8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320A27E7EB
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730668; cv=none; b=m0/j/6ihY4zWs24s/A+mEKlXttnrhsrbvEM1gM1G/kEbA+ei1i/1/kBIEK1hiM44kE1QukTQcyWMLqJ+A4DMVsJTuHtYJMX2bq1gHK/IFlHsSYypaqaa6MOFx8HlqGLUdXpKxdhcsEVE2mhHbDCLLW+0p8Rdcb+1cSt76z/ptqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730668; c=relaxed/simple;
	bh=n9Bd8IEkV/IRTwOdU9uX1p5y4MveMsGf5jHJ/dTc0ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMw1leAzjEZy+hcgjihpDqJHmqhVsnWIfyql6NuIoGcNTJaqHbqG0c+dBcWERmuzCm6M5vahmRqV5jMUmFlQhrtNVZrBp5AUG7MVa/EcBhA6KrJll66U39kX8SKdJ9y/f6FFQtuFpIj51eqC0h/yaWXy6LYuadfzcmpBuADLP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2Jfy/w8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55cdfd57585so1632e87.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755730664; x=1756335464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv92BsJeoSyMQyBVXvEV2fBjtlWdhSVa/KfUUa75TSc=;
        b=C2Jfy/w8cFKiE9LoKa4yqhOz96P1D4UW5CEY+d6XbJ/2S2MTUFsLH+y2wfNZUO+FDY
         yjTTJsDyuCk0xRvDaRiSdfEe5uwT9ezU7sV0YhEFVr5mOqIubmckYyL/PndwlIT+oISw
         XWyS/JNzSjCbg7zDsdVTS8r9bnzq+YeHRYTwsXXNcYkPEqiovIqsAQcFF/CSROmCpN5g
         FrES3gSPWBLeIA8MQoVtvTFmVZ1rJR53AldBuisk28cbDJxGdn6El6ccwbJBINqb1h/O
         dXwIk1AptXG/L8tqfHGfV2Hpkns0exqhRzDGFH10uIwM16OzudKBbFqftRRTuycrp0mL
         Dg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730664; x=1756335464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv92BsJeoSyMQyBVXvEV2fBjtlWdhSVa/KfUUa75TSc=;
        b=vxdbDdjVK0ctG6DPM24FexgEl6f+SFXFWlqxPj53K8D1INwALGZ/qshXljKoCVkfPI
         34yrogtjzKDH0BOs8CaVExV046SBCOqvVpRaTCzpbr6x72zcx3th3xTAksgORAwDlybw
         PdXQ2Z4QtidWHmF7gzEh3sEce8tXlUOtBYjRVsOxIkJ42TIGBmQxv5VDh5vpYcwAmEdv
         sxjSEbTs1WakPf1gpLvHOUzdwOj4SXyT0uSmg145L6d81aULpSFzhDgzrajHZjpQIo7U
         C1+LawikC04U9o8SudfsKlNoRINsjNTNamrkXgqNPmeNyGjzmv8GCuj8WgsX7rt7FEYS
         skcw==
X-Forwarded-Encrypted: i=1; AJvYcCUf1QM9UV9Ps0adtdsvk/BgzXvMdmE4KUbncjYpdXwbOOq3vzjKtf+VrwFb4h+ET1+8Llmm7Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kUMjyz8KrQwrHcWhtVP1tFha+7UMwWK+EhalcXNxABt3ag/W
	QEZbLzZlD/eV/5pmFZeysfoRLvtTctwIbNosHDieodjSdCa9FPWC86JcPzSQiafj/7RC6JAToga
	CtPcsaXCBSMKuz6LiwhiCLHmT0nuQSTZY67uNfGU+
X-Gm-Gg: ASbGncvhYN1ewPqXMTnMbXIc/Fqi7bzxrbS7xqxGS1ZWe8s2JQBFgB6taypdkZXdeqv
	Bk069/GKUr3pAf+cU4kAK+aHaVus5UXMDl5soVSs88+6JFdf2BiU5iYs59ckAVZr2NrBWx8za+p
	7lirC1t0dkT6Fr1UvZu/6VCd9ar0GpipfppJtYHqxVRi05/kMB4XcSr/DhPFSa97gO/Gjl78VN1
	a8z8OAZjMNQAmvvXImMN9O68JHaN4Cl7fckCsby229aye0ZM/G6Mzw=
X-Google-Smtp-Source: AGHT+IGH9vQ8FVEVTOoInISa4rr0NshjyvtshuJzy0f+Z07svAYwLNshA6CLiESpfx8faYlT1rP3eTaZ3ND++HOOQMw=
X-Received: by 2002:a05:6512:4381:b0:55c:df56:f936 with SMTP id
 2adb3069b0e04-55e0d7fffa8mr48358e87.6.1755730664222; Wed, 20 Aug 2025
 15:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171214.3597901-1-dtatulea@nvidia.com> <20250820171214.3597901-9-dtatulea@nvidia.com>
In-Reply-To: <20250820171214.3597901-9-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 15:57:32 -0700
X-Gm-Features: Ac12FXzWXtwzFd2q8Bx4gRa1je-LCa7G70ijBzEW_fCEnHL5Wi-KdxefJhnUL0Q
Message-ID: <CAHS8izOQ=G-wVo5UXPyof+U=sxB-27Rv8UBfnVkvgtoOTW7Cdw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 7/7] net: devmem: allow binding on rx queues
 with same DMA devices
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, parav@nvidia.com, 
	netdev@vger.kernel.org, sdf@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:14=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Multi-PF netdevs have queues belonging to different PFs which also means
> different DMA devices. This means that the binding on the DMA buffer can
> be done to the incorrect device.
>
> This change allows devmem binding to multiple queues only when the
> queues have the same DMA device. Otherwise an error is returned.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  net/core/netdev-genl.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 0df9c159e515..a8c27f636453 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -906,6 +906,33 @@ static int netdev_nl_read_rxq_bitmap(struct genl_inf=
o *info,
>         return 0;
>  }
>
> +static struct device *netdev_nl_get_dma_dev(struct net_device *netdev,
> +                                           unsigned long *rxq_bitmap,
> +                                           struct netlink_ext_ack *extac=
k)
> +{
> +       struct device *dma_dev =3D NULL;
> +       u32 rxq_idx, prev_rxq_idx;
> +
> +       for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues)=
 {
> +               struct device *rxq_dma_dev;
> +
> +               rxq_dma_dev =3D netdev_queue_get_dma_dev(netdev, rxq_idx)=
;
> +               /* Multi-PF netdev queues can belong to different DMA dev=
oces.
> +                * Block this case.
> +                */
> +               if (dma_dev && rxq_dma_dev !=3D dma_dev) {
> +                       NL_SET_ERR_MSG_FMT(extack, "Queue %u has a differ=
ent dma device than queue %u",
> +                                          rxq_idx, prev_rxq_idx);
> +                       return ERR_PTR(-EOPNOTSUPP);
> +               }
> +
> +               dma_dev =3D rxq_dma_dev;
> +               prev_rxq_idx =3D rxq_idx;
> +       }
> +
> +       return dma_dev;
> +}
> +
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>         struct net_devmem_dmabuf_binding *binding;
> @@ -969,7 +996,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, stru=
ct genl_info *info)
>         if (err)
>                 goto err_rxq_bitmap;
>
> -       dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
> +       dma_dev =3D netdev_nl_get_dma_dev(netdev, rxq_bitmap, info->extac=
k);
> +       if (IS_ERR(dma_dev)) {

Does this need to be IS_ERR_OR_NULL? AFAICT if all the ndos return
NULL, then dma_dev will also be NULL, and NULL is not a valid value to
pass to bind_dmabuf below.


--=20
Thanks,
Mina

