Return-Path: <netdev+bounces-216245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D2B32BA1
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350681889861
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A623185E;
	Sat, 23 Aug 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYfZnCFZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD91F5838;
	Sat, 23 Aug 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977151; cv=none; b=FMMBDzF1JZR8jDfXs0PYvyQJUbwBZw9yTZb+iVXX9VW4cSNEl67JK7ri8sWIX+/GjKSIVTEFuSw67Yuv1g1fBXdVIaB8RyTf6zoGOj9XrW+ih+QwgZqB4FAiAXamSmKDe13i3SO9BnoiuVHgkxdx0Ynp4Bas8JIIN1+m1dA8oaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977151; c=relaxed/simple;
	bh=Uapsr8IX2QllNcDkajqgEWIy98NO2HVFmKjdgXYOYT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSuR/XldboDL0zrTrPwOMl3BGpvpXdQP1bUYG49pwXP/aidKK9xL88kDLxJ+hE/uuOWYyko3SCTj2rmnqgcg+s7B0wu5+TSoxCJGR343+uW4b5P3joelaU1XbK6VGe4Nz+VKeLdmdRs6Xq89/TfG8MBMAQX/K4A1TTZUy/Rjgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYfZnCFZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IeS8ye+d+W7JjnVBouNZ/oczgVKJYQHDxAlGtmr2Ra8=; b=tYfZnCFZIyuhrzKECGNyZCQ2iU
	g6R88xKAJDiAqORLTpMHdNB+wWT8x+xZnoyGwDX51VZ2FtF35tKxRN5QGeM/y55RqRl50X+HnMDRs
	83zqOFbnyEYN7KHQ5Eb0znDy9pvKeoSBW7KOzjM0DSFmuRVO8+AgHaS7/glJgyCDblZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uptrv-005mHa-KX; Sat, 23 Aug 2025 21:25:39 +0200
Date: Sat, 23 Aug 2025 21:25:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v3 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Message-ID: <fd9af170-fb59-43fa-9eea-ff147f4a84a7@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-6-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823190110.1186960-6-shenwei.wang@nxp.com>

> @@ -1278,8 +1280,16 @@ fec_restart(struct net_device *ndev)
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>  		/* enable ENET endian swap */
>  		ecntl |= FEC_ECR_BYTESWP;
> -		/* enable ENET store and forward mode */
> -		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
> +
> +		/* When Jumbo Frame is enabled, the FIFO may not be large enough
> +		 * to hold an entire frame. In this case, configure the interface
> +		 * to operate in cut-through mode, triggered by the FIFO threshold.
> +		 * Otherwise, enable the ENET store-and-forward mode.
> +		 */
> +		if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> +			writel(0xF, fep->hwp + FEC_X_WMRK);

The quirk indicates the hardware is capable of jumbo frames, not that
jumbo frames are enabled. Don't you need to compare the mtu with
ETH_FRAME_LEN + ETH_FCS_LEN to say jumbo is enabled?

Is there a counter or other indication that the FIFO experienced an
underflow?

	Andrew

