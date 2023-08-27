Return-Path: <netdev+bounces-30896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE85789C07
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 10:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E3F1C20914
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD10ED4;
	Sun, 27 Aug 2023 08:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615FEBC
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 08:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3795C433C7;
	Sun, 27 Aug 2023 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693123538;
	bh=bgFpKrbb5BKBRFqPi18KpBHYxGjE5puzerlvZWDQ17A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7jI+fyHyygOeBw/iXHQqZiebINK9a96l2XPhsAEELxL4UkNEO9tkjgME8vP3XD57
	 sIpYru6738QMDZ+U7bv/xiIjM5KIko/XysZm55n0cU/rwWFF7W8IWArU98ivQR6oGa
	 83tRPKA2pQHZLwI56xo8h+RjMupTGwo4Up7oYYH2lW8nvpnsMLzfb3tIUIpHjkg21r
	 TqxHwLYe8ZLFT7dNclJXnAdF1b9d2lZ0b0FugX99aypAEGXpz//i/KAW+eyGaE2WJo
	 IKjvUksVNTV6HzeDxpDPeGJIag50Ogv8NvLI7B1Jna/jdLuCeRZp203u0SjsDu47io
	 aRPIperAhApvA==
Date: Sun, 27 Aug 2023 10:05:31 +0200
From: Simon Horman <horms@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
	sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <20230827080531.GR3523530@kernel.org>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>

On Thu, Aug 24, 2023 at 12:16:15PM +0300, Radu Pirea (NXP OSS) wrote:
> Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
> frame.
> 
> If extscs parameter is set to 1, then the TLV header will contain the
> TX SC that will be used to encrypt the frame, otherwise the TX SC will
> be selected using the MAC source address.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx-macsec.c | 66 ++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c

...

> @@ -167,6 +171,18 @@
>  #define MACSEC_INPBTS			0x0638
>  #define MACSEC_IPSNFS			0x063C
>  
> +#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
> +#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
> +
> +#define MACSEC_TLV_CP			BIT(0)
> +#define MACSEC_TLV_SC_ID_OFF		(2)
> +
> +#define ETH_P_TJA11XX_TLV		(0x4e58)
> +
> +bool extscs;

Hi Radu,

Sparse suggests that extscs should be static.

> +module_param(extscs, bool, 0);
> +MODULE_PARM_DESC(extscs, "Select the TX SC using TLV header information.");

...

