Return-Path: <netdev+bounces-134850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843999B510
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3730C1C20DA6
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1CA184540;
	Sat, 12 Oct 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEPkotP5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F6152166;
	Sat, 12 Oct 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728739421; cv=none; b=kQcuISXLXS132EaXvKlcx9EeAd6A7iBg99jMysD9c0cp7woztX1WN+ePlvcLAmj0wjhw/qEHCC3PhgcnSgX9GsbB04DVR9ff7voJVSSCBhn0S/XQ1qPnXP7vZ1pvVQtfHyf9lK4BDflITLqHYg4bE7JYJgkSAKVBF3Qji3F3wI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728739421; c=relaxed/simple;
	bh=HfOjDaEoL0iJp7Exuv215R22pn0SbxJ+qhQlHHzWmyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqxh8hRxnDDVz5tEBrS/Z46vI6Mrc8coLcFxDcWIdmsdGdZkOfeuVw7C9bZmtZYZ0RwSEfbLrqydpeaSPfbRDKJdlZzcFvL1SElXwaigsaNcmM8oxXIm+6oez3a2KDZXnY78b2tMU5aPeT2+eNlzrcWNCTJAQq74nt9g+Lk6tU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEPkotP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700CDC4CEC6;
	Sat, 12 Oct 2024 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728739420;
	bh=HfOjDaEoL0iJp7Exuv215R22pn0SbxJ+qhQlHHzWmyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEPkotP5QIA7Rq+I7Hi7KvCgGVQ80rovFsM2mq5vx+tD/APHgfO9hyoKeKOooGqCZ
	 +o6n+NS89Kre1/B72tunRJAovSL/S8FPIQZn/QFjs10XtwhlGkfgZ5buFQTs13l5jn
	 WWRT/oDUvjLKQQ9YXLi21rPI+EkIIjFytD3zZbO2QG3LJjRta/CZnMK86AvRFEN8QX
	 1hYW3joYy8Uar/AzsX8zfZVmlSC9yvO2TXW92GWHuWBz2ehpoY8QZPQuQYvzINEUmZ
	 dnES9ysN30oZSTqh1gdD8Zjqnwrak2xCrazHyT+C5CwxYkLNxyeFlY7dUFB6VO7HXR
	 /4IXdjXI7YiLg==
Date: Sat, 12 Oct 2024 14:23:36 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 4/7] net: ibm: emac: use platform_get_irq
Message-ID: <20241012132336.GI77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-5-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-5-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:19PM -0700, Rosen Penev wrote:
> No need for irq_of_parse_and_map since we have platform_device.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


