Return-Path: <netdev+bounces-180661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E2A820F0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D741BA2C49
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20B25C703;
	Wed,  9 Apr 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5IgcAlR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36825A64E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190661; cv=none; b=KvZTTNnsCtdi7V3Fs3G+TvFqhIEE0IMEjRX+r71ZeWlBZvaPZPgR8RnsPxJrhvnkw7u1LhUztIbtStzJlkjLqEWHMH0tb9Z4Ty+Lb9meiv/H3OpxnZmlHu386FkeB+2Xl676yA5+yoCcKZwNxGXu6+sxzZttbbdCQnO/DiNm9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190661; c=relaxed/simple;
	bh=DwGnLL6yRkvpHKgsWq2KLkFsuAMpxTUYys1PXFd8l/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfUsbOtrsG+nE0c6mKqbdBs3cWMXpxmj5k8BH7NIUtdOpg0sJNe0ihtZ6WK/lolnuNSNC+uTWva8My4tDkjzm5Dll0R+NgXSEw3lKyU9B7bUCbTV6hsRXaSHRuxNjo2J4a/WCNKt0CbQx2XoOI28VxaD5hvJMzfkMlhpRGMZg9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5IgcAlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F195BC4CEE3;
	Wed,  9 Apr 2025 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744190660;
	bh=DwGnLL6yRkvpHKgsWq2KLkFsuAMpxTUYys1PXFd8l/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5IgcAlRk1EgDie6uaxayYtmeWyKVS9fIZR/1/0nWhopGT1klDsqsAR7EEvpioDBA
	 fT+AelYZcJx98j9ircBrA/HFfrqqKxbfjSa6MQrT5xWwUW8xPgSSMzDlert4absJ6f
	 bN0q1tjepncf6SDptO1blqFqaz/am//rlMjDmRAeUp/jdX/eN4wmAAvTDvgkNHDN+x
	 Hr06pPWxCq93goCnSt6PUrlzRR3E2sHbGERKzE+hRoSqOzeWpPubGNxQuyfeVRghR+
	 HKyRoY10GR+tr2P6I3RsaFu6Nnz2Hc+vRvi4fdIdM6Yo0Gw7CvaddfZs/7/qYPcVXK
	 RSmto31DVfR+Q==
Date: Wed, 9 Apr 2025 10:24:15 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: stm32: simplify clock handling
Message-ID: <20250409092415.GI395307@horms.kernel.org>
References: <E1u1rwV-0013jc-Ez@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rwV-0013jc-Ez@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 08:15:35PM +0100, Russell King (Oracle) wrote:
> Some stm32 implementations need the receive clock running in suspend,
> as indicated by dwmac->ops->clk_rx_enable_in_suspend. The existing
> code achieved this in a rather complex way, by passing a flag around.
> 
> However, the clk API prepare/enables are counted - which means that a
> clock won't be stopped as long as there are more prepare and enables
> than disables and unprepares, just like a reference count.
> 
> Therefore, we can simplify this logic by calling clk_prepare_enable()
> an additional time in the probe function if this flag is set, and then
> balancing that at remove time.
> 
> With this, we can avoid passing a "are we suspending" and "are we
> resuming" flag to various functions in the driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> This patch has been only build tested, so I would be grateful if
> someone with the hardware could run-test this change please.

Yes, agreed that would be nice.
But this is a very nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>

