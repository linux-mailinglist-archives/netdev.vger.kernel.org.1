Return-Path: <netdev+bounces-149010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42F09E3C7E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9623F163FEC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5401F7567;
	Wed,  4 Dec 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hc4rhXAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B51EACE
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321823; cv=none; b=lch0dgy7vuAwxzRYBq9wQIIedVM0j8JxWJcpWvPsPmeowZJHvyP1b7KfhH2kGsUADIZUbxaxjSwHhJ3Vb+83KDKUyNBxkLXVGf0oJKiEB+wfEvLEQ+BVDojIZsuDO+UWBgHm93KxrsWHB988WAhs89UwWI5UxiMr7b6KbIvwe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321823; c=relaxed/simple;
	bh=Q+0qHAQ4tVm+S9fkknskn5mMF3pzV5TxUClKphx6ZZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SU8vwaONNeiNA1/lY4C0apSQIh5j0VmMCKO4Jd3a1M3a+dSfr5FEvw3mL8V381tGDkG/NHJs4jazOon58IL35n/leqQ5Pm6i8JMWxUpIAZ8Li4G0cPCSS1ysfw06e+SrfZtgsQzhonZD86ov/P9YfEqsq7fMXbiu/uOgGcdVzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hc4rhXAo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e2880606so4712288f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733321820; x=1733926620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAGmLeapP5ljNlHB/vYl7c/faBJN5rD60j7K/83FJFI=;
        b=Hc4rhXAoIe0KtPdw0tJyhhc8FwZhY799+0fH2TRGvR0mFXupzsA8K4onmFU7xXDCCt
         Wa6tJ9dzAdKtjH88sm7cA+Lkrw8GZuzTfRVEB24udJnIETpZt+PrQ4GVo8bPolnnGedX
         09w4DtUsaYU6R5125ykbHz17HVA3t7f7wAA4dqKD9yWDqoB8NgnFMyDDCJfG33zJEjsF
         IPgabkzaUG3Nu0Q01PAfYkt2PgVFrBEj5SoLqMJQR6jpxXtChNOiFf4yXG/C8VyHDTnJ
         gEgZffKIgfM+pxbr7AGN682uPyF73psjAV4RTRcPBJi7og1wQSBMhwjheah8lb6AakGX
         PLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321820; x=1733926620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAGmLeapP5ljNlHB/vYl7c/faBJN5rD60j7K/83FJFI=;
        b=cElsuJjWgrf/gTAzV58QVUN4rLaW+LB7AOKXpf6LCpULQJ+/wOgrPGO6t4YvloN30l
         ZsT0hWrOi4SPfy0is6xKaTQ6thiVqp54F8gkjDuUPtrEUg+jNVOlb4jEhMvZ5fdOEQzu
         d970bm4W4ZiBlQD7LuU1d3xN0RxoS9QDyEABcf9yjKM4EXfqMRYOKGiMEOxM24xCfEwZ
         +bmLRU1YqgJI8cL89CP+DakC/qMzxljpY7UVv0AZ4eRs/DA60nnVYQlUBw178/CEf2vz
         CiUjL9C8TEOf9hcGebkzRvnBLA5PAGKD5xbDet4fZUff6/E5MwV2C2Ry9aDNCcVQ1xGm
         tNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU+rQqT9WmHmu7WibSOD492hEWqeTO2UEA5efeHSgjB2ueHEUz72vJDD/sOpeufWnXEIOWilM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49a5X0vglX12xHWTiwttniOZkYGeCWcRktEXPR/an/Tl+OFEN
	OLoiACAku6XQaB9R9NGenK4JmDmTEEb5imtyosigalgwhVuRkDzhLhEZxzcXbzHZK+XN7wbpWCK
	uSrom3bCp+u62HBv9qFL/LDzkVGT5WKTJb/PZ
X-Gm-Gg: ASbGncsa+ilvr/j3of5/fQXtji6MtDW669FglE/RROWsZHVpt5DDog2coJ7Vnb9zjHT
	/arPs0bn4/0bfSGO0ppsxrF+ROigjzovm
X-Google-Smtp-Source: AGHT+IEkb/fZwwLg5fOlViYZI/hLyUIUpzP4Eu63D0QP/uwnJ5+2gJidSJ2/4kqSrBfRhLaptcOSzQuwVAAmPdY850A=
X-Received: by 2002:a05:6000:1f85:b0:385:d143:138b with SMTP id
 ffacd0b85a97d-385fd43bb65mr6880598f8f.51.1733321820020; Wed, 04 Dec 2024
 06:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140230.23858-1-wintera@linux.ibm.com>
In-Reply-To: <20241204140230.23858-1-wintera@linux.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 15:16:48 +0100
Message-ID: <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:02=E2=80=AFPM Alexandra Winter <wintera@linux.ibm.=
com> wrote:
>
> Linearize the skb if the device uses IOMMU and the data buffer can fit
> into one page. So messages can be transferred in one transfer to the card
> instead of two.
>
> Performance issue:
> ------------------
> Since commit 472c2e07eef0 ("tcp: add one skb cache for tx")
> tcp skbs are always non-linear. Especially on platforms with IOMMU,
> mapping and unmapping two pages instead of one per transfer can make a
> noticeable difference. On s390 we saw a 13% degradation in throughput,
> when running uperf with a request-response pattern with 1k payload and
> 250 connections parallel. See [0] for a discussion.
>
> This patch mitigates these effects using a work-around in the mlx5 driver=
.
>
> Notes on implementation:
> ------------------------
> TCP skbs never contain any tailroom, so skb_linearize() will allocate a
> new data buffer.
> No need to handle rc of skb_linearize(). If it fails, we continue with th=
e
> unchanged skb.
>
> As mentioned in the discussion, an alternative, but more invasive approac=
h
> would be: premapping a coherent piece of memory in which you can copy
> small skbs.
>
> Measurement results:
> --------------------
> We see an improvement in throughput of up to 16% compared to kernel v6.12=
.
> We measured throughput and CPU consumption of uperf benchmarks with
> ConnectX-6 cards on s390 architecture and compared results of kernel v6.1=
2
> with and without this patch.
>
> +------------------------------------------+
> | Transactions per Second - Deviation in % |
> +-------------------+----------------------+
> | Workload          |                      |
> |  rr1c-1x1--50     |          4.75        |
> |  rr1c-1x1-250     |         14.53        |
> | rr1c-200x1000--50 |          2.22        |
> | rr1c-200x1000-250 |         12.24        |
> +-------------------+----------------------+
> | Server CPU Consumption - Deviation in %  |
> +-------------------+----------------------+
> | Workload          |                      |
> |  rr1c-1x1--50     |         -1.66        |
> |  rr1c-1x1-250     |        -10.00        |
> | rr1c-200x1000--50 |         -0.83        |
> | rr1c-200x1000-250 |         -8.71        |
> +-------------------+----------------------+
>
> Note:
> - CPU consumption: less is better
> - Client CPU consumption is similar
> - Workload:
>   rr1c-<bytes send>x<bytes received>-<parallel connections>
>
>   Highly transactional small data sizes (rr1c-1x1)
>     This is a Request & Response (RR) test that sends a 1-byte request
>     from the client and receives a 1-byte response from the server. This
>     is the smallest possible transactional workload test and is smaller
>     than most customer workloads. This test represents the RR overhead
>     costs.
>   Highly transactional medium data sizes (rr1c-200x1000)
>     Request & Response (RR) test that sends a 200-byte request from the
>     client and receives a 1000-byte response from the server. This test
>     should be representative of a typical user's interaction with a remot=
e
>     web site.
>
> Link: https://lore.kernel.org/netdev/20220907122505.26953-1-wintera@linux=
.ibm.com/#t [0]
> Suggested-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Co-developed-by: Nils Hoppmann <niho@linux.ibm.com>
> Signed-off-by: Nils Hoppmann <niho@linux.ibm.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_tx.c
> index f8c7912abe0e..421ba6798ca7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -32,6 +32,7 @@
>
>  #include <linux/tcp.h>
>  #include <linux/if_vlan.h>
> +#include <linux/iommu-dma.h>
>  #include <net/geneve.h>
>  #include <net/dsfield.h>
>  #include "en.h"
> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq=
 *sq, struct sk_buff *skb,
>  {
>         struct mlx5e_sq_stats *stats =3D sq->stats;
>
> +       /* Don't require 2 IOMMU TLB entries, if one is sufficient */
> +       if (use_dma_iommu(sq->pdev) && skb->truesize <=3D PAGE_SIZE)
> +               skb_linearize(skb);
> +
>         if (skb_is_gso(skb)) {
>                 int hopbyhop;
>                 u16 ihs =3D mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);
> --
> 2.45.2


Was this tested on x86_64 or any other arch than s390, especially ones
with PAGE_SIZE =3D 65536 ?

