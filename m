Return-Path: <netdev+bounces-32379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F7797332
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2AD1C20B4F
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C1C138;
	Thu,  7 Sep 2023 15:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5B7462
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9662C32797;
	Thu,  7 Sep 2023 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694099061;
	bh=WdK8JvU3w5OYNIGaa0wOy4tgpIjNtj7P6a7gO95XcG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUKejfETy2wAwfuiS4Y6C8C8DBMzG0d6rEwsaM41SfymYUnPapd6kZpy0IY4B6+1P
	 Fz401cF5Ct1/bLp2Ej8NWhmusAFht2YiWjozrZbQASo+/vBE1iT88l4vNj5RwXk5j5
	 HICWPBSMm/dAH86aW9sMKAx6W9UD/Mxb9R6fQ2wYHqQidUVSb4Aab/C8JKSaUSCovI
	 XeF1mHhU8LJRSkBq/0tXfUwfior3J9E5dO3kD+Qs3iERxI1H93pE1p63CsurQK6FMc
	 FsE22m+UvWnxSaiy0dlo7FIxQf7iP35LHRYYwtvKncvScT2AePURjDibnf0X6pfr56
	 uJ0T/kmYANTKQ==
Date: Thu, 7 Sep 2023 17:04:16 +0200
From: Simon Horman <horms@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
	sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 6/6] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <20230907150416.GE434333@kernel.org>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
 <20230906160134.311993-7-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906160134.311993-7-radu-nicolae.pirea@oss.nxp.com>

On Wed, Sep 06, 2023 at 07:01:34PM +0300, Radu Pirea (NXP OSS) wrote:
> Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
> frame.
> 
> If extscs parameter is set to 1, then the TLV header will contain the
> TX SC that will be used to encrypt the frame, otherwise the TX SC will
> be selected using the MAC source address.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---

...

> @@ -166,6 +170,18 @@
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
> +static bool macsec_extscs;
> +module_param(macsec_extscs, bool, 0);
> +MODULE_PARM_DESC(macsec_extscs, "Select the TX SC using TLV header information. PTP frames encryption cannot work when this feature is enabled");

Hi Radu,

I hate to be the bearer of bad news, but
I don't think we can accept new module parameters in Networking code.

...

