Return-Path: <netdev+bounces-187753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522EAA9799
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE33B3B9218
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180DC25C838;
	Mon,  5 May 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+gkJ3jq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6D4204E
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459424; cv=none; b=e7SoulYb/8aUkAX8dxddqksG8nfrniJFDVv1l4lRgB1T6QCyihZrrojcminCA9JijAttC83IIAqSZXy9F0OnXDW+ZkLhrG2TA7m2ZOGZJ0XkwPHX5lSSyr38X/PL/zc5a8vutxXKKjjj8ywYQIBizwlkn+i7fszbObt6BA741Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459424; c=relaxed/simple;
	bh=7Mf5IUL67c6yKGlbToWCBOjA+ImEfq4gXTXicf69ACM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCLyPI/gDfKuKo3LUCJzXGvEA1xZleCJKIZFFfyvTFrd6+PBMq/xPLzuEYcPEexppNdpS7bLMtq/spq711L1mXmEm5iDPLDzYnwXGEfUHds8HB4HVYbgkwhd+MlG//SJXmnXIMUoKMMLYZ8m6D8Tnkw2QertTQ6QqYWYQWydMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+gkJ3jq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47688ae873fso56009891cf.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746459421; x=1747064221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vOHKs8/cN1RrGMvUL1wJCB6wIpXIrDD37Tw0Z6hLcA=;
        b=L+gkJ3jqUsG8uN8dxoRfdTcVCDuWszDPOBK0T9x90v8dLOdRNdPhIPvS2cBVgbFzdn
         SlRyei+VEkNkO8tt+xK1SJa1aJUMEXMvOziIi0JZwC+2fOKtQUr29uE4ISj2ujHOKP7N
         UQax4pBZ4qcXpeKDz5gMgv+6rZe8eAt0+rQquOPZHQYumu1CRBmsWJYmVDqhlF/vy2ST
         hQ6kKg4dvc7C/1tfR7f609fEJIXjfgnVZYioORfaESCVQqS9t9npJizcsA7HODdigv1l
         3GhD/D3PyNRx9pIlfvHNrJWhImPSqfNrQJih27i7jGEyAzlwBCsjjqNZItkPEO3AieI3
         Yyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746459421; x=1747064221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vOHKs8/cN1RrGMvUL1wJCB6wIpXIrDD37Tw0Z6hLcA=;
        b=QxqRB0EB2lMW3CHoHcdQzxds6GouiaipXgMVgjcWvw93bVRkmu80Q79Fbj2SrebHG+
         rvEs5M1aPDpq+MDPjK6+pRp6kbSL1rG0HR5jXkF639lyWAYQvBHfZn2WfbinhlH7qeji
         3izHaXsJ2Gl5igygmpKmyi3VG/wR0kputipSz5OPUziCqCsKzSIRPb8A8OEWMtj7wyWA
         kTvd1TZO44q2KJcWlwvjIk7+11LGmWpFwSmK15LIMyefcYJ09+VofmMOZ32J+k0USXuR
         2/dkjc5NVNgp1UcvIIGTe5+1sR36DrWzYv3n/CAx5SahSwonKEUKvwhwentoE6WjCuMn
         PWsA==
X-Forwarded-Encrypted: i=1; AJvYcCWB6wRniHgw6+dx2xeFA/bSbxmxXpDIhFzJLIfmsy0MGU9pQ0a2dzDYB3UoWbQe+FJb9El5bsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcv8aNiJF+ioEu1kdzvMJhFBiUpDGHv+ZkS/cI63dIBbnZ/EUJ
	0Bt6J5Wbt7IdLZkNILsSRwBjeJ9cko88qV8Po96Xe85bFIh+djXw5QJG7Rf0KWCCh6z4HQ4+5Op
	3u95Tb2uhIxkXZu//jEhuGYwAVEhOqc64IjWA
X-Gm-Gg: ASbGncszzi+kOGAOKX07gcrlAUt18dOVTuZSYHMkpj3aezxFE1Gj04uuFVCR+S2q4qi
	itg3qLSoH/LYybmEgPeFbx7MdSLNVKYKPonLhCXB240f/OtKpeD97nOg2uv/9A+S+7Bjc/Vk6nT
	TlmS4H0wgKPh+roeJv/y8=
X-Google-Smtp-Source: AGHT+IG8JARwIwzB7KZX2tZwmQIzn/qx+7TyXTl0YfmsaU8vL0Aya+8W2XSTMpAudwMjCO2iMji/G4RL/5ywuMiuySo=
X-Received: by 2002:ac8:5d52:0:b0:48c:c121:7e27 with SMTP id
 d75a77b69052e-48d5da66910mr155013651cf.50.1746459420935; Mon, 05 May 2025
 08:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321211639.3812992-1-michael.chan@broadcom.com> <20250321211639.3812992-3-michael.chan@broadcom.com>
In-Reply-To: <20250321211639.3812992-3-michael.chan@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 May 2025 08:36:50 -0700
X-Gm-Features: ATxdqUHDv9A0ORGKi16rEQi0CXcgei2a_BqvUw3kgdMtOhJ8UBqjriGU8yizvBI
Message-ID: <CANn89i+ps_CozfOyRnKav0_LUmSekJ9ExB5JkDbTAVf_ss_98g@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Linearize TX SKB if the fragments exceed
 the max
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, osk@google.com, 
	Somnath Kotur <somnath.kotur@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:17=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> If skb_shinfo(skb)->nr_frags excceds what the chip can support,
> linearize the SKB and warn once to let the user know.
> net.core.max_skb_frags can be lowered, for example, to avoid the
> issue.
>
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
GS")
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 158e9789c1f4..2cd79b59cf00 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -485,6 +485,17 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>         txr =3D &bp->tx_ring[bp->tx_ring_map[i]];
>         prod =3D txr->tx_prod;
>
> +#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
> +       if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
> +               netdev_warn_once(dev, "SKB has too many (%d) fragments, m=
ax supported is %d.  SKB will be linearized.\n",
> +                                skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS)=
;
> +               if (skb_linearize(skb)) {
> +                       dev_kfree_skb_any(skb);
> +                       dev_core_stats_tx_dropped_inc(dev);
> +                       return NETDEV_TX_OK;
> +               }
> +       }
> +#endif

Hi Michael

Sorry for the delay. I just saw your patch.

GSO would be more efficient and less likely to fail under memory pressure.

Could you test the following patch for me ?

Thanks !

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3a9ffaaf60ae810bf8772b0cad0da45bc4ec9a05..c2a831efa969742711f5afdc7b2=
4ba2c450cc595
100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13787,6 +13787,10 @@ static netdev_features_t
bnxt_features_check(struct sk_buff *skb,
        u8 *l4_proto;

        features =3D vlan_features_check(skb, features);
+#if MAX_SKB_FRAGS > TX_MAX_FRAGS
+       if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS)
+               features &=3D ~NETIF_F_GSO_MASK;
+#endif
        switch (vlan_get_protocol(skb)) {
        case htons(ETH_P_IP):
                if (!skb->encapsulation)

