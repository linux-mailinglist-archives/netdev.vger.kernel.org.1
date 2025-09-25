Return-Path: <netdev+bounces-226146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9059B9CFAF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFFE1891948
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C52DCF61;
	Thu, 25 Sep 2025 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7KInrpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F633C01;
	Thu, 25 Sep 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762650; cv=none; b=YhmvZTCy8agaE0n1w3gyeNwXc3mOKP9ip9FBlO5aGWt1T1zFfMGxiQ0t43ikadlegEDwDjOsqu2BPWUphGayW8NFxcGcqv/8Yih90mWYVLXbRVCGL85JiX8TLKX9IB6mlPr1iogbexKK5NU12VY1PTxOArPxQxlOrstSi/meKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762650; c=relaxed/simple;
	bh=+YRCX0Im4JXXmFeEz7AT5h201nBv0DiObZSjc3IzbBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXx65lqqvxOngp6DdcV7uigMw0sCUW4929IxREo2DN56HCrKyL1+uOOSRNnNUSaWYKpbz7lJArJx4zKfhBhqIqILdd89Aad6sVeO3zb68pbY83+xIgrOmJGBrJw9cdRj+6gK9SwtyryHT7mCQzNlLeRBMeN/UIEltrywwzzlcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7KInrpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362D2C4CEE7;
	Thu, 25 Sep 2025 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758762650;
	bh=+YRCX0Im4JXXmFeEz7AT5h201nBv0DiObZSjc3IzbBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y7KInrpcytY/4JWTreLsSJP26y9pDb9J4gGT7ofLOzCQarlpb9Lb6yOufHOXLUk14
	 erxlpQVpvWuUuzvkWVxDIkq4D+jVovoxgW2IYyif1WVpTVjlg5h2ENQhRR2Qb1+bXr
	 fBl5iidArPKWScOAcXR4uM6zJNy0J9/qWeFobz3xitY6fU61a7xP959NKhJ9aaNp3X
	 hfLJCuaBAAdBu0mWkHfdsDejj1y/uPf/gERlfwoGI/T7B/CxJ8IUPcH2MB2gJDSr0U
	 qAsIe4sLQtBQDHbb3lV/ri+0Ingl3DScMaxkaNEj8xU7IZEe1JGbCNit6lH94/AEsZ
	 m2koEPnmz44zQ==
Date: Wed, 24 Sep 2025 18:10:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
 <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
 <andrew@lunn.ch>, <srasheed@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v1 1/2 RESEND] octeon_ep: Add support to
 retrieve hardware channel information
Message-ID: <20250924181049.1ab2dc56@kernel.org>
In-Reply-To: <20250923094120.13133-2-sedara@marvell.com>
References: <20250923094120.13133-1-sedara@marvell.com>
	<20250923094120.13133-2-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 02:41:18 -0700 Sathesh B Edara wrote:
> +	channel->max_rx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
> +	channel->max_tx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
> +	channel->rx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
> +	channel->tx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);

AFAICT you're using one IRQ for both Rx and Tx. The channel is
basically an IRQ. So if you're using one for Rx+Tx you should be
reporting the combined channel counts.
-- 
pw-bot: cr

