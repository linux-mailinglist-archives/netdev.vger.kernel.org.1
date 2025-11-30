Return-Path: <netdev+bounces-242817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E1C95149
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 227643433D3
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7993265632;
	Sun, 30 Nov 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqonyrm1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47F18A6B0;
	Sun, 30 Nov 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516128; cv=none; b=XqAFQBv4OmvPvD6GExGH9VkWiEisHQKCcDzpibtSZpcd/ma6cT4Pv/OVGEykx4deZNyBjS/AOKOn4hSIaFhNMI7x4PjyBK7HK+nbOT4fGSwo/CYsAtkuqGuDQKDQb24uZlXfQoUmLZlNzMdFm3Eq53TCK5IPMfPxWj09/tT8k7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516128; c=relaxed/simple;
	bh=ECMHcarTuHLRAlyk0zqOiHBNOtrjUQ06zcOtuYYJ6jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5USJ0g3QihmvZ11Qb1m7D7iidxQWkWqFpUXNPCJdU4kvK3F2pE/g/lvTiazqG48wyQJAtzbFlGSPcVq5ZFvSID8klUP+8LsQfEPV337p3YZ6LI6r0IypOvkwXXiVlbHIitKlVKNZmkf6eL/jE+0DvHyikV86m+UTQsaDYrX2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqonyrm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E21C4CEF8;
	Sun, 30 Nov 2025 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516128;
	bh=ECMHcarTuHLRAlyk0zqOiHBNOtrjUQ06zcOtuYYJ6jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqonyrm1Duqyz/+NOYj+XKxKdV7LKgYKxNyI72bIoPBBUpDz18qpqQuGDhSIHFaou
	 D8Dzcj2kK/+YWa9sOxaNIK6SyMLKClK/E6EI4gYD5yr6juNQfGCxF8lmtDLUmghY6K
	 Fe0S95wucOgWBmx1suwp0vDG1LoMvvJOhC2bvESG7vAC2yn3iRTPaGuO3AZjLsBHWI
	 fIAHq+W06lgxmlxFAzaCloGkl722GBOLMoipt2KCmYstmB9L04p8vP9uPusPz1DBww
	 aCxrbyjTgvIvoLHAJxyGDt8v5AyFu26NhkzcJBbRD0fLwKu9RunQMlDPsNtlcIcD29
	 xppmaT9VfY0Sg==
Date: Sun, 30 Nov 2025 15:22:03 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] net: enetc: convert to use
 .get_rx_ring_count
Message-ID: <aSxhG-WcSMv9DbLn@horms.kernel.org>
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
 <20251128-gxring_freescale-v1-3-22a978abf29e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-gxring_freescale-v1-3-22a978abf29e@debian.org>

On Fri, Nov 28, 2025 at 05:11:47AM -0800, Breno Leitao wrote:
> Convert the enetc driver to use the new .get_rx_ring_count
> ethtool operation instead of implementing .get_rxnfc for handling
> ETHTOOL_GRXRINGS command. This simplifies the code in two ways:
> 
> 1. For enetc_get_rxnfc(): Remove the ETHTOOL_GRXRINGS case from the
>    switch statement while keeping other cases for classifier rules.
> 
> 2. For enetc4_get_rxnfc(): Remove it completely and use
>    enetc_get_rxnfc() instead.
> 
> Now on, enetc_get_rx_ring_count() is the callback that returns the
> number of RX rings for enetc driver.
> 
> Also, remove the documentation around enetc4_get_rxnfc(), which was not
> matching what the function did(?!).
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


