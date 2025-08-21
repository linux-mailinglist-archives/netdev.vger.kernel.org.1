Return-Path: <netdev+bounces-215762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F08B3026F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B9C57BFD62
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17D345758;
	Thu, 21 Aug 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z5W2g4+k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57903451DB;
	Thu, 21 Aug 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802582; cv=none; b=pWnznl1GFGz+sdSlWlLK1xoRI/+y1j6YHxiWylY+U0bw8vPgqx//tsKbTtmRih2MQdvwToOE/LDVd37NzEBNNBOuQGtDZ4a1/wwiAP8ua/RL3cKYBtsTurDhYr4gXzcyEpAZPXiLeoXqQ4nq4fvkaIkCz+cwI73bTHBhggKo2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802582; c=relaxed/simple;
	bh=JrK/VFp315aXgsBk9qH0cn7LmIw+zqz+G6qiQ3+s7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsiZ5h/bWeByDvnS6U0iGs+dPbehVv675HtSEv4VHYk5bjMGAjB1Hfv7kJ7CYnpGbisrTBsxYvqgVNEFrL0W+7dTFRuBhTxyBUD4D0rXmmqNRLpp3QMAcUNd7XuolpSrnRfpEQh1AAypOaan4LUrumyBm7gomWX+Nq3rZAba7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z5W2g4+k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nDHKWPn2kL3h02gq4xTzKlatZAvjyU1/u+Vwu5U1osg=; b=z5W2g4+kXmwcgwTprrbZS4nyJg
	kyQd4ZEXiIZFQOpfAv25hVc30XDmkdsAldHyicJb5DEGo/K/lxcgKL7X0gqDkV8ytgDlmAogmIoTl
	0MP0Fso3jKA94bp8ThG4c/VV1UtMyIGKMaSspuTYJ7IeGnh06geEM5uQAs+wPsSSrQsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upAS6-005UHH-Ux; Thu, 21 Aug 2025 20:55:58 +0200
Date: Thu, 21 Aug 2025 20:55:58 +0200
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
Subject: Re: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Message-ID: <12144026-130a-422a-8280-9e0b25b22562@lunn.ch>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821183336.1063783-2-shenwei.wang@nxp.com>

On Thu, Aug 21, 2025 at 01:33:32PM -0500, Shenwei Wang wrote:
> Refactor code to support Jumbo frame functionality by adding a member
> variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.

This is better, thanks.

> @@ -1145,9 +1145,12 @@ static void
>  fec_restart(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> -	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
> +	u32 rcntl = FEC_RCR_MII;
>  	u32 ecntl = FEC_ECR_ETHEREN;
>  
> +	if (fep->max_buf_size == OPT_FRAME_SIZE)
> +		rcntl |= (fep->max_buf_size << 16);

I was expecting something like s/OPT_FRAME_SIZE/fep->max_buf_size/g

This is introducing extra logic. I think the if (...) belongs in
another patch. The assignment is however what i expected.

    Andrew

---
pw-bot: cr

