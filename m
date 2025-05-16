Return-Path: <netdev+bounces-191160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A5ABA4A0
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C183504C98
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455227AC22;
	Fri, 16 May 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mff0oXGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE41F956;
	Fri, 16 May 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426913; cv=none; b=sqh1bydgbvAburS+7nt0y0RuDpk6Ry9O3FH/axl0rnfX5Yswq/Eh9J9vrohxAEhKkEn3m9dUjCgeyato4crGr+BTpqMjiC0xVpfWSfcJrwyFWNtXhtuVwBjhG7yc1evSjKXaN2UJrklGj8b1rspnB2n3Evrhth7qi4Q5Qd0MLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426913; c=relaxed/simple;
	bh=0eZbYvSMOyz0txO7McOUt7WBCXP3fLg51sadhpP/XeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/V7DJgWMopi/Zxw4b9DDfgD5hGMnFf5OTHxM/cpqL1TpgddvTSAgKOnmKcHzTAYDUoStOvTjEnEsp3BIdMilKlYtG5DW16lAMlA6DGCbORuaSqLHeyxYY1jKTpVOUImX1Hn4h4xfrBk8GRfi+g5PgcGdyvWMxoFGXjevP58sys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mff0oXGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24984C4CEE4;
	Fri, 16 May 2025 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426913;
	bh=0eZbYvSMOyz0txO7McOUt7WBCXP3fLg51sadhpP/XeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mff0oXGCBELo0hzgvl1WaEJjdXKZ7PB2yucYnPxgvfRfJtsyfndb2MF2nqpMWRNd6
	 6QSwslLlHkotLfTgLKNJDZHKas5G61PIZ/7a43kJkNtGjgaIc8kTZS7vUdaNF6VwlI
	 4HEg/c7NAuCUCMiawrmi2SVkxEVnd8Tkok6WC8ytZqBAw3HWVws7GIwYuklMxNJe2D
	 RbBYKJALQSY4+ByUVtcQNY+Os6YPOLpagZk37B529LWkEru4lU5HBNRiNL+5zJEkcd
	 e6OVlAMc47gBuo8m5D+6j5sVAzDeDPn1nm1dvDPlhVPLU/RZXeGoh1YtJZ+wGyAX+0
	 HSJbIwqpTSQvQ==
Date: Fri, 16 May 2025 21:21:49 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
Message-ID: <20250516202149.GL3339421@horms.kernel.org>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <20250516201606.GH3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516201606.GH3339421@horms.kernel.org>

On Fri, May 16, 2025 at 09:16:13PM +0100, Simon Horman wrote:
> On Thu, May 15, 2025 at 09:59:35PM +0200, Christophe JAILLET wrote:
> > If register_netdev() fails, the error handling path of the probe will not
> > free the memory allocated by the previous airoha_metadata_dst_alloc() call
> > because port->dev->reg_state will not be NETREG_REGISTERED.
> > 
> > So, an explicit airoha_metadata_dst_free() call is needed in this case to
> > avoid a memory leak.
> > 
> > Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Changes in v3:
> >   - None
> > 
> > Changes in v2:
> >   - New patch
> > v2: https://lore.kernel.org/all/5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr/
> > 
> > Compile tested only.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I was a little too hasty.

This patch looks good to me, but as this is a fix for change
present in net it should be targeted at net.

  Subject: [PATCH v4 net] ...

And it should be split out from the patchset comprising the remaining
patches in this series, which appear to be clean-ups (or at least not
but fixes). This rump patch-set should be targeted at net-next.
And ideally, IMHO, have a cover letter.

  Subject: [PATCH v4 net-next 0/3] ...

Thanks!

-- 
pw-bot: changes-requested

