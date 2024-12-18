Return-Path: <netdev+bounces-153123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE79F6E78
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E17161D68
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817A17BEB8;
	Wed, 18 Dec 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wyNf7Sqi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5C1FC104
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551260; cv=none; b=OSzYmmlmPWawUiDMRxa0ipkjTutuvm1nbtBN/qF/PyAy5aak0ppzasKbM5cD/wH2In894ES3wJtjOMcz+eXTEh5H1s7Y358aR3kr1Lf4VLkMg2ZQGsYZvD4rniZbizQ1nvgBmVK/nfw3Bc78ALPssRn5ZIU/1RyF0y02xLefL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551260; c=relaxed/simple;
	bh=tVaIlxZaM9bCUnjN/Uz9QKpfO7fJsQ4/v4+PYmxYcy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkYXSOLoJ7aMm5JC9Jm9ZRvmFya7sDbZ20XlcQUSyZFUufkaRFwcZRrtNZv/IdBebMVj5iSEsR+oOQr31cAQ3Er76fB9b0/jgajGdcWwzRnx0bMPbGZUz9+i8/WKO442rgpTpEYGE4KnkOpOscZiYsymwxUwR7sUoDyhNnfmjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wyNf7Sqi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ONx2Rb9VYWQ+spWVgDokXmThgytRZO5nSbBjMgaV3WA=; b=wyNf7Sqi02om2z5rw03B6sDaSF
	V0NrCNPdCpr3fj1yFA1EGvoOKvfN8p9Z07yU96uziBlgUGvp+KY5d1w6S1HxY+Y4aj6fljEiP4DzV
	64GXJjkiinOyKoxd31zlESE7T5/Hi9/ciGONFCOiOYNlmVHTIAtPI/3eHKH7iJtnQyFY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tO015-001NYX-PB; Wed, 18 Dec 2024 20:47:31 +0100
Date: Wed, 18 Dec 2024 20:47:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com
Subject: Re: [PATCH v1 13/16] net-next/yunsilicon: Add eth rx
Message-ID: <a965aadc-6e82-4d2d-8cf9-fc8da0f2817d@lunn.ch>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105051.2237645-14-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218105051.2237645-14-tianx@yunsilicon.com>

> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
> @@ -33,10 +33,572 @@
>   * SOFTWARE.
>   */
>  
> +#include <linux/net_tstamp.h>
> +#include "xsc_eth.h"
>  #include "xsc_eth_txrx.h"
> +#include "xsc_eth_common.h"
> +#include <linux/device.h>
> +#include "common/xsc_pp.h"
> +#include "xsc_pph.h"
> +
> +#define PAGE_REF_ELEV  (U16_MAX)
> +/* Upper bound on number of packets that share a single page */
> +#define PAGE_REF_THRSD (PAGE_SIZE / 64)
> +
> +static inline void xsc_rq_notify_hw(struct xsc_rq *rq)
> +{

Please don't use inline functions in .c files. Let the compiler
decide.

	Andrew

