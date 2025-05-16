Return-Path: <netdev+bounces-190966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6068AB984D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF90A20168
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A11D6DBB;
	Fri, 16 May 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkNE5gvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E641DFE8
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386158; cv=none; b=UmBk7sEH7KSoo/Bs+Ei9hTUQFWl7A8SgFm4bxx4Ybh4xQvM0X4gV7MzSAkc8emE69Eo4nrsrWEx3ZTS1nXnV/a+9S2mJ0ZvwL9o2ScMnRq89f6qp3XA9mPwbi1TPvum3eM6Age7eir5MWaP6tca3Al/jvyOvEArXuD7IeVOuTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386158; c=relaxed/simple;
	bh=ToaiqUQC7wPPT5md+Z2ox6pr7GllCWLM1JPpGSY8rRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwkMerlYe0uprkgnFnVTkhqQA6Id8eOsWxhgf6qVTzhWzZg56vyAuNNyjfzFdv3YQHQUIrhetHYlzRS+n4YABl9Yf05MjQ+B5R6MVbgQy77vb8Z9Z8etTFy2W822zzwThcZKWMQSFh/Fr4zBoBnVn4TGj4GBhzAwxWbdjpT7Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkNE5gvq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47ae894e9b7so35383951cf.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747386155; x=1747990955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in60ugGemjVltqB0vsq8GkvN3HfzICH3JQbCmYrTXHA=;
        b=FkNE5gvqN/rsbRFwhWJIUSAusuNZfdzCBA07Yb8u02qzTD057CTHgTsmM4Zj37hyMT
         +Y5RxuukI+FvUIPQwgrLEmN1y9w8KKh3UC/D9HaX3FmljITLvX5+lv89WJ533UHBNDu7
         q9NhorGM3UtWlH6G0Tvs/HlE9hPn9n1hCEdniQQnJfMtd6WqjJmWSxRtWn/1lGg/NabK
         Hfq0ggaOL878y5ZPlITQF/QQoc/IR+J3EFrmRiHr6FtU/yjfBc8XKv6ZmlIMSNL6fpbx
         Ct6ZNKxwn1VnAGjSb/ncBaVHYqq6G7hK8VLQxrGSUB7f2ea19Ea2HKjCxEnaRPhjG4Jz
         VYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747386155; x=1747990955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in60ugGemjVltqB0vsq8GkvN3HfzICH3JQbCmYrTXHA=;
        b=lEYINUXca1r43XISUGbaq3/iq1Tr3o/cbaDuA2woOXIHUvkSa/aVMb/wAEIphdjfvf
         5JnistiE0wl9RVJF3jnQYWCvZzUGUC0oe4ENlCfCPwFuQNiPxzybWSu3D0TjFXmeu1BI
         uN21G0U5CoxwvSbdyYFpBM+Ijric++paYqBkOYzVpasWcG0EzDAsJfjQ8Dvsa1fP8E2e
         puwyaVL3Ko2QnKjwsS8JBaymNPSW28EkQJPJzGDIBdgrKMz1Q6Xs1Z0kTMusEDuZDzF1
         DrKQ4+KhIW1fgQYlD4Bwwlg76mDLPNDr+IToql3MnyNYiR7TzMmk2qxUnSDC/kuOZ+KL
         1h7A==
X-Gm-Message-State: AOJu0Yxj7BvG0W83mMyv11g/ci/PcwOm3xyUlePbtAkC9FPNn4c3T7dG
	7ONCKUqQAgSajjp48LbkT4xMT+kJOzIwJg2MIPl3fCC+0veGadPC6JNvABtbscgNhmp6qdjPMCr
	H7SfXZ5aVfcJwm5ZO4yhk07hRFt5SbJxAnfB0qcfE
X-Gm-Gg: ASbGncuzbPSS9setafZbnN1g7VRUGTJoSu6wWX9VP+dgfaPF5bW6tt1S9fLxirkMZte
	chVFtUaWNxZxXSZwr2e1Uq4G1R+x5dT70LzYHvn7S97WCFeC9vdqLvPB/cMH1+NnbS4VqJrapf4
	UUsuj6u8drQKO4lxuqkMQNc3HCjqznqwT/3HiHgZjJ0Q==
X-Google-Smtp-Source: AGHT+IFKFpZ4mx7Ab6FBiCu2VumXKtdpAlGDqqg8Aj8q1gzbtDvdx2Ql++WSEromWm41RhpIINOkMLSPD9lHuaS6/qU=
X-Received: by 2002:a05:622a:986:b0:48d:7c95:4878 with SMTP id
 d75a77b69052e-494b07f782bmr30946581cf.29.1747386147888; Fri, 16 May 2025
 02:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509104755.46464-1-ayberkdemir@gmail.com> <20250516084334.2463-1-ayberkdemir@gmail.com>
In-Reply-To: <20250516084334.2463-1-ayberkdemir@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 May 2025 02:02:16 -0700
X-Gm-Features: AX0GCFvBaGcVFtA7dJExvGgGKSE3KqWHsolC66wfst2hICjQRgoMunWZPUzYXDk
Message-ID: <CANn89iJ9iAP0GXk_qmzu+2MjWHi_NDOjG1QdLAiY1YSj+RjZQw@mail.gmail.com>
Subject: Re: [PATCH net v4] net: axienet: safely drop oversized RX frames
To: Can Ayberk Demir <ayberkdemir@gmail.com>
Cc: netdev@vger.kernel.org, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Suraj Gupta <suraj.gupta2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:44=E2=80=AFAM Can Ayberk Demir <ayberkdemir@gmail=
.com> wrote:
>
> From: Can Ayberk DEMIR <ayberkdemir@gmail.com>
>
> In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger
> than the allocated skb buffer may cause memory corruption or kernel panic=
,
> especially when the interface MTU is small and a jumbo frame is received.
>
> This bug was discovered during testing on a Kria K26 platform. When an
> oversized frame is received and `skb_put()` is called without checking
> the tailroom, the following kernel panic occurs:
>
>   skb_panic+0x58/0x5c
>   skb_put+0x90/0xb0
>   axienet_rx_poll+0x130/0x4ec
>   ...
>   Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt
>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ether=
net driver")
>
> Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
> Tested-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
> Changes in v4:
> - Moved Fixes: tag before SOB as requested
> - Added Tested-by tag from Suraj Gupta
>
> Changes in v3:
> - Fixed 'ndev' undeclared error =E2=86=92 replaced with 'lp->ndev'
> - Added rx_dropped++ for statistics
> - Added Fixes: tag
>
> Changes in v2:
> - This patch addresses style issues pointed out in v1.
> ---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 47 +++++++++++--------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/=
net/ethernet/xilinx/xilinx_axienet_main.c
> index 1b7a653c1f4e..7a12132e2b7c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1223,28 +1223,37 @@ static int axienet_rx_poll(struct napi_struct *na=
pi, int budget)
>                         dma_unmap_single(lp->dev, phys, lp->max_frm_size,
>                                          DMA_FROM_DEVICE);
>
> -                       skb_put(skb, length);
> -                       skb->protocol =3D eth_type_trans(skb, lp->ndev);
> -                       /*skb_checksum_none_assert(skb);*/
> -                       skb->ip_summed =3D CHECKSUM_NONE;
> -
> -                       /* if we're doing Rx csum offload, set it up */
> -                       if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
> -                               csumstatus =3D (cur_p->app2 &
> -                                             XAE_FULL_CSUM_STATUS_MASK) =
>> 3;
> -                               if (csumstatus =3D=3D XAE_IP_TCP_CSUM_VAL=
IDATED ||
> -                                   csumstatus =3D=3D XAE_IP_UDP_CSUM_VAL=
IDATED) {
> -                                       skb->ip_summed =3D CHECKSUM_UNNEC=
ESSARY;
> +                       if (unlikely(length > skb_tailroom(skb))) {

If really the NIC copied more data than allowed, we already have
corruption of kernel memory.

Dropping the packet here has undetermined behavior.

If the NIC only reports the big length but has not performed any DMA,
then the skb can be recycled.
No point freeing it, and re-allocate a new one.

