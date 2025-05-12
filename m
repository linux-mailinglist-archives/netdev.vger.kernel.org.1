Return-Path: <netdev+bounces-189728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20043AB35BB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5E7A4FCC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEE28934D;
	Mon, 12 May 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTCRNk8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF860288C9D;
	Mon, 12 May 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048511; cv=none; b=Ch/Wgm5Y+ZGW9hf2VUJtFoL1Jxsx/6d+mC29ndf3eKI1NXVQSRUHVkzTpxfm8/LGF8KCo1IJpqPPJWDKv33ML5AX+9m5RerQZxet456ypGXJmerYzIIildGkKsL5VO7jPWbLsstIgLxLXY2+d258WSKlfEMtaEw80sOirHMbH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048511; c=relaxed/simple;
	bh=9Kz9KJE8tpe5bVlPCpYwBtoxjEWhKfxlCXnIu8iJOBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMViwl1U6foUbteD0DXuCQuDrt6Srz09ST5yV79otUzQ1e8uBof+MYWF1wI0BokenFD+vWmKpKgPi2bMN8TabiFkqgM8fgKRQJp8Lyeris2Koq7muHvSt8T7s+qr6B8STrHSQXkkx46kHwdgpPaVNffVpO4SXzQx2sJjjmoiDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTCRNk8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF25C4CEE7;
	Mon, 12 May 2025 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747048510;
	bh=9Kz9KJE8tpe5bVlPCpYwBtoxjEWhKfxlCXnIu8iJOBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTCRNk8hvHNufIi5yLxM43/3tdnzQktJtHVwSiOGJfG30B8RYOgHJeYcQiENCNRhZ
	 tj7eKpdz0+2MPctSvU8/V+BQATAXiewKUx/hQKIQG+Hw3GsE4dkOVIKdUD83Vu80Sq
	 UxGkrEhYkMR0eS7IuG3iVw0uJTLbcQyoOMnskLFaC4/W8EC8iowlXxf6MFhuwEfBJC
	 NVmPKPX/5+aVyF0drGcQJ/0mfxopIZbPPk/QxmR7vZOyXMcmqDDxPEI5egc18yRhBa
	 ogj6wZslkQ8ETY1UdPX+ucx1CW2bD3AJv9NawYxuWmo+9LxCHjsrQ1KHTZyn/ddyQc
	 dGS4bRZtaW8dw==
Date: Mon, 12 May 2025 12:15:06 +0100
From: Simon Horman <horms@kernel.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	anton.reding@landisgyr.com
Subject: Re: [PATCH net v2] net: cadence: macb: Fix a possible deadlock in
 macb_halt_tx.
Message-ID: <20250512111506.GA3339421@horms.kernel.org>
References: <20250509121935.16282-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509121935.16282-1-othacehe@gnu.org>

On Fri, May 09, 2025 at 02:19:35PM +0200, Mathieu Othacehe wrote:
> There is a situation where after THALT is set high, TGO stays high as
> well. Because jiffies are never updated, as we are in a context with
> interrupts disabled, we never exit that loop and have a deadlock.
> 
> That deadlock was noticed on a sama5d4 device that stayed locked for days.
> 
> Use retries instead of jiffies so that the timeout really works and we do
> not have a deadlock anymore.
> 
> Fixes: e86cd53afc590 ("net/macb: better manage tx errors")
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
> v2: Use read_poll_timeout_atomic and add a Fixes tag.

Reviewed-by: Simon Horman <horms@kernel.org>


