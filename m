Return-Path: <netdev+bounces-218754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81BB3E4B0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507C27AD7E6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F40200BA1;
	Mon,  1 Sep 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFaTRzXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C51E9B35;
	Mon,  1 Sep 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732957; cv=none; b=kAN/j6GCF7i+Sf9AxmcomeZ25fPQAn6czjSr+Bk1GBxkz1W52qA/7VknS7f3r7Ophp9eRKQA5dWFlPHL1ZK06L2FMldco7Itgmfio75CeUl4b96d1BQNAC6Y9DzUIhtwNWD+PGA9qZbtxu2svuWJqGwuaruQE1BCj0wvY37H8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732957; c=relaxed/simple;
	bh=iZd5nKCxv1w9n3xTk7vgqnUyKdwkDnwEAjscldOdtwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r00astLkgYH2Q8oRxrx864lAUP214jY4QH3hV0MiTfra4UnSkpLgqgZ+P8T9RKyPOFGoIeAlpUbx/r6x6w4MjKd7CRPcv3YAHibmzh8d18rN340W1UJwjST8eouCQ7apCy2AtdpWUBbXHAQX8gjIVbhP87WrndMOiGG2uuAE1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFaTRzXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E902C4CEF4;
	Mon,  1 Sep 2025 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732956;
	bh=iZd5nKCxv1w9n3xTk7vgqnUyKdwkDnwEAjscldOdtwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFaTRzXr0jYaMb/Jiyi5pZuMrDXZfWeoevc92sebn27t0ksWpeQmvS1U4bgjNksKr
	 VlApBHMTDq9gBQ67HnmqOzmjb2mDyRvdREvXexuobFAO+yhV3tbNl8DwffiAxOQHmT
	 58RYWX9yIhxUTdh8Vf8JmXKze2JKgTCRqmj7C8qx7pLHqGxHey7R4roAxe4jPSVuhN
	 DCpBWBJ3wwCLb5zi5frFeZIlHMwZ0iE7uC1Mvn+HwT5qbQz7hyZNw9p4X5W7MnD0Gu
	 EKiCjzCc4oIQEACOs5V9X+XQ8LiJqkIJhMy0wTae2tMX7VvBiq3BzC5Dd5ycpxApJ1
	 6A3PA91aGAOfw==
Date: Mon, 1 Sep 2025 14:22:32 +0100
From: Simon Horman <horms@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Michael Walle <mwalle@kernel.org>, Roger Quadros <rogerq@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nm@ti.com, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix null pointer
 dereference for ndev
Message-ID: <20250901132232.GA15473@horms.kernel.org>
References: <20250829121051.2031832-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829121051.2031832-1-c-vankar@ti.com>

On Fri, Aug 29, 2025 at 05:40:51PM +0530, Chintan Vankar wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> In the TX completion packet stage of TI SoCs with CPSW2G instance, which
> has single external ethernet port, ndev is accessed without being
> initialized if no TX packets have been processed. It results into null
> pointer dereference, causing kernel to crash. Fix this by having a check
> on the number of TX packets which have been processed.
> 
> Fixes: 9a369ae3d143 ("net: ethernet: ti: am65-cpsw: remove am65_cpsw_nuss_tx_compl_packets_2g()")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Thanks,

I see that prior to the cited commit, the code now
in the condition updated by this patch was executed
in the loop that now precedes the conditional. And in
the flow before the cited patch ndev was always set
in the loop before the code in question runs.

Reviewed-by: Simon Horman <horms@kernel.org>

