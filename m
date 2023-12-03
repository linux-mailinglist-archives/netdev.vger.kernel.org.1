Return-Path: <netdev+bounces-53323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140938025D3
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452C21C20950
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE8168DA;
	Sun,  3 Dec 2023 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9M5mfsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5E2F47
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 17:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571AAC433C8;
	Sun,  3 Dec 2023 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701622860;
	bh=IBq5e7Qm+LW9YAeuTlUc2gKVcMbeUUXh3+yS9ucUOFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9M5mfsAxI9P6KoSJ74x6KzdIPxaZVD/yGyJqLyXU5DV1d46fbvniXQcXKh02nVE5
	 XgZZyLeGfB1Zaw66upfe2G/ySXnRNC6G3tUo4Sqqp+7JakCFE/JkY3YYkllyoM9fof
	 IYHDUKN1aP7PcxNB8iVlzmAtO2U81MQ43JYT4SvXtwdnVBKgwYOPJVn2tuwdANaPpS
	 1voftH7dBwsiOwSTZ2tRP0Vzf/tcyBqA7p/2X15Cc6UoYVZ+XHi7Tu2opnNU6BVuUu
	 zV96CmNa79SEY/7hZkpPRfGi3zxFDtuXwFC2eYa/piuhOZzja+fSAB2U/ikntjPvkf
	 Tss/3SJ/RCRAA==
Date: Sun, 3 Dec 2023 17:00:54 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 3/5] octeontx2-af: Fix mcs stats register address
Message-ID: <20231203170054.GL50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-4-gakula@marvell.com>

On Thu, Nov 30, 2023 at 01:28:16PM +0530, Geetha sowjanya wrote:
> This patch adds the miss mcs stats register
> for mcs supported platforms.
> 
> Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mcs.c   |  4 +--
>  .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index d6effbe46208..d4a4e4c837ec 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -117,7 +117,7 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYTAGGEDCTLX(id);
>  	stats->pkt_tagged_ctl_cnt = mcs_reg_read(mcs, reg);
>  
> -	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(id);
> +	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
>  	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
>  
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
> @@ -215,7 +215,7 @@ void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats,
>  		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCNOTVALIDX(id);
>  		stats->pkt_notvalid_cnt = mcs_reg_read(mcs, reg);
>  
> -		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(id);
> +		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(id);
>  		stats->pkt_unchecked_cnt = mcs_reg_read(mcs, reg);
>  
>  		if (mcs->hw->mcs_blks > 1) {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> index f3ab01fc363c..f4c6de89002c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> @@ -810,14 +810,37 @@
>  		offset = 0x9d8ull;			\
>  	offset; })
>  
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(a) ({	\
> +	u64 offset;					\
> +							\
> +	offset = 0xee80ull;				\
> +	if (mcs->hw->mcs_blks > 1)			\
> +		offset = 0xe818ull;			\
> +	offset += (a) * 0x8ull;				\
> +	offset; })

Hi Geetha,

I see this is consistent with existing code in this file,
but I do wonder if there would be value in moving to a more
compact mechanism at some point. F.e. (completely untested!):

#define MCSX_REG(base, a) ((base) + (a) * 0x8ull)
#define MCSX_MB_REG(base_mb, base, a) \
        MCSX_REG((mcs->hw->mcs_blks > 1 ? (base_mb) : (base)), (a))
...
#define MCSX_MCS_TOP_SLAVE_PORT_RESET(a) MCSX_MB_REG(0xa28ull, 0x408ull, (a))
...
#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a) MCSX_REG(0xb680ull, (a))
...

In any case, such a change isn't for this patch, which looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> +
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a) ({	\
> +	u64 offset;					\
> +							\
> +	offset = 0xa680ull;				\
> +	if (mcs->hw->mcs_blks > 1)			\
> +		offset = 0xd018ull;			\
> +	offset += (a) * 0x8ull;				\
> +	offset; })
> +
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)	({	\
> +	u64 offset;						\
> +								\
> +	offset = 0xf680ull;					\
> +	if (mcs->hw->mcs_blks > 1)				\
> +		offset = 0xe018ull;				\
> +	offset += (a) * 0x8ull;					\
> +	offset; })
> +
>  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCDECRYPTEDX(a)	(0xe680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCVALIDATEX(a)	(0xde80ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(a)	(0xa680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(a)	(0xd218 + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a)	(0xd018ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(a)	(0xee80ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)		(0xb680ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a) (0xf680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSAINVALIDX(a)	(0x12680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTUSINGSAERRORX(a) (0x15680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTVALIDX(a)	(0x13680ull + (a) * 0x8ull)
> -- 
> 2.25.1
> 

