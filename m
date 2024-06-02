Return-Path: <netdev+bounces-99968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD48D73FF
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 08:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512A71F2139E
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE318AEA;
	Sun,  2 Jun 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps9mufqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC5171AB;
	Sun,  2 Jun 2024 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717311091; cv=none; b=g/Kzs7tEcbI5dpQgfe8qYfJaoOhlouMoZSMdO4lMZU7NiTwPH8xS3j4feO0eoXInqqgsbhh4ZgB98p3hD7vhP7b4aM6iFh936YyVkBemZdqMEC0G5CiTFSNk8ghFJ4X12jbYTvLu8xR+Ryj8xZr1o/HV0F6+00KPOfy7Q+T1MIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717311091; c=relaxed/simple;
	bh=vzcCoFuwMDbQyS/b582VM/ry7a4lbIwUTDMZef2tY9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4NBRF2sjieuC5XIN1lAaX0C76K/GBWEZejEYWqslLELOACRdSzZ4xJqH3cDyaNSSP2JpRrLCmV4IzAySGbCSWwaOYRFcVVwwvCJi36XFyrC9Gy4kmpSJZh25l+eVqkHRSx1U10zhBydgjJ50y4XNGiTQuLf83SoAo5SSk/WAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps9mufqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE4AC2BBFC;
	Sun,  2 Jun 2024 06:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717311090;
	bh=vzcCoFuwMDbQyS/b582VM/ry7a4lbIwUTDMZef2tY9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ps9mufqzHLpBah6Gyo8TmqPvZ0IlX/pHuz4XIeBI0YU97ImY4chBqrw4NR24vKApi
	 K6yqszCjo8H0hua2SVYoI51F4QIznSZ3TecDLDbnqgpqGsjTo0OsheDJ4X8ua+cOWJ
	 OTtDofvk6C5BGmrpuuR/bBBY47qd0M8oeSsD7BpAOy+yI+3rh27bFsQW0oFGMJgGkt
	 x+sg5eBdjYIKaLimAwrELZV1N2uvL2zD42bdURXz+zClXd6FM+We+w419gqtWN+9fV
	 SNDMXGnTT1v4FRkdOYlY+aMhctHSMAwO36O/RNlyiwIFetroMs07+V47HV8xAk6dLw
	 Ut5ey65umX3Pw==
Date: Sun, 2 Jun 2024 09:51:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next,v3 6/8] cn10k-ipsec: Process inline ipsec transmit
 offload
Message-ID: <20240602065125.GH3884@unreal>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-7-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528135349.932669-7-bbhushan2@marvell.com>

On Tue, May 28, 2024 at 07:23:47PM +0530, Bharat Bhushan wrote:
> Prepare and submit crypto hardware (CPT) instruction for
> outbound inline ipsec crypto mode offload. The CPT instruction
> have authentication offset, IV offset and encapsulation offset
> in input packet. Also provide SA context pointer which have
> details about algo, keys, salt etc. Crypto hardware encrypt,
> authenticate and provide the ESP packet to networking hardware.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 224 ++++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       |  40 ++++
>  .../marvell/octeontx2/nic/otx2_common.c       |  23 ++
>  .../marvell/octeontx2/nic/otx2_common.h       |   3 +
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   2 +
>  .../marvell/octeontx2/nic/otx2_txrx.c         |  33 ++-
>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +
>  7 files changed, 325 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> index 136aebe2a007..1974fda2e0d3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -7,8 +7,11 @@
>  #include <net/xfrm.h>
>  #include <linux/netdevice.h>
>  #include <linux/bitfield.h>
> +#include <crypto/aead.h>
> +#include <crypto/gcm.h>
>  
>  #include "otx2_common.h"
> +#include "otx2_struct.h"
>  #include "cn10k_ipsec.h"
>  
>  static bool is_dev_support_inline_ipsec(struct pci_dev *pdev)
> @@ -843,3 +846,224 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
>  	cn10k_outb_cpt_clean(pf);
>  }
>  EXPORT_SYMBOL(cn10k_ipsec_clean);

<...>

> +bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
> +			  struct otx2_snd_queue *sq, struct sk_buff *skb,
> +			  int num_segs, int size)
> +{
> +	struct cpt_ctx_info_s *sa_info;
> +	struct cpt_inst_s inst;
> +	struct cpt_res_s *res;
> +	struct xfrm_state *x;
> +	dma_addr_t dptr_iova;
> +	struct sec_path *sp;
> +	u8 encap_offset;
> +	u8 auth_offset;
> +	u8 gthr_size;
> +	u8 iv_offset;
> +	u16 dlen;
> +
> +	/* Check for Inline IPSEC enabled */
> +	if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
> +		netdev_err(pf->netdev, "Ipsec not enabled, drop packet\n");

<...>

> +		netdev_err(pf->netdev, "%s: no xfrm state len = %d\n",
> +			   __func__, sp->len);

<...>

> +		netdev_err(pf->netdev, "no xfrm_input_state()\n");

<...>

> +		netdev_err(pf->netdev, "un supported offload mode %d\n",
> +			   x->props.mode);

<...>

> +		netdev_err(pf->netdev, "Invalid IP header, ip-length zero\n");

<...>

> +		netdev_err(pf->netdev, "Invalid SA conext\n");

All these prints are in datapath and can be triggered by network
packets. These and RX prints need to be deleted.

Thanks

