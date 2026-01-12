Return-Path: <netdev+bounces-249080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB2DD13AAE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541B2303A3DA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376692F39B1;
	Mon, 12 Jan 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMgY08iK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599392F6187;
	Mon, 12 Jan 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231601; cv=none; b=nOrkcXV3jbnCE8/o34ChWmyc78Pb+tBKI5Mjp8KPlWTVEo00rE/CPbrfWdRoSz3heX0ClfsOG3sc0SoX5ijn4KHTlj/s9zzpK0U02FXGxUpa4l/METGoLjACbSc6B/e4F6hc61NMBOz9ba/nzfSfwelu0JrDrZhEZpnzxJv+WTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231601; c=relaxed/simple;
	bh=sl2zm1e8Xq0C8os/T82of2ab0lap0J3S5GZLuulyDb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXIINzQh8NkIt74lmVnOJVMNmrgyz75ptZSoSeeRWRmuA6PRytJ19ePR85kL1+cLseys57aEwzQ/OoAWG15mCRoJXFKkUUfF5Q85CkcNwERP0oiKrU8kWjvEhc3YkCXFX4ogLldVZEyu7zbFf37T+OjnddhD63bcPebcUdxeHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMgY08iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D07C16AAE;
	Mon, 12 Jan 2026 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231600;
	bh=sl2zm1e8Xq0C8os/T82of2ab0lap0J3S5GZLuulyDb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMgY08iKCGvYXO0xquWj3zGWAf1+lPX1wT5sJkOUXKw8wHMLGXXL3pX7OfJurCeuu
	 uhRIcHMuE5FkVFmKePGuC+Rkfw3N/Sc7Uk+Pc4d4TXlFT2NX/XnRtiCExy3lrmmpMv
	 viPo65VWzeR9ElfqRCjsaKEttO7jeR6lrSTeCI7kMaOtqtgimshvazNP9kPk8EPRvT
	 yMZfZjvleM5RwPDgfS5CYbaqf2r6AdP3Jl5y1sEtVr42UYRcBsZQLb0Zcmn7mRqPpC
	 sU7+BckoguXjGIv2CmJPr28c23q1R+QxBK6PQoEMQzYk6ts1+2c9A4RIxWIvj4T07w
	 bfSI8o3QLOA8w==
Date: Mon, 12 Jan 2026 15:26:35 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: convert to use
 .get_rx_ring_count
Message-ID: <aWUSq925KrWXh0Rg@horms.kernel.org>
References: <20260108-gxring_stmicro-v2-1-3dcadc8ed29b@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-gxring_stmicro-v2-1-3dcadc8ed29b@debian.org>

On Thu, Jan 08, 2026 at 03:43:00AM -0800, Breno Leitao wrote:
> Convert the stmmac driver to use the new .get_rx_ring_count
> ethtool operation instead of implementing .get_rxnfc for handling
> ETHTOOL_GRXRINGS command.
> 
> Since stmmac_get_rxnfc() only handled ETHTOOL_GRXRINGS (returning
> -EOPNOTSUPP for all other commands), remove it entirely and replace
> it with the simpler stmmac_get_rx_ring_count() callback.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - no change from v1. Basically resending it now that net-next is open.
> - Link to v1: https://patch.msgid.link/20251222-gxring_stmicro-v1-1-d018a14644a5@debian.org

Reviewed-by: Simon Horman <horms@kernel.org>


