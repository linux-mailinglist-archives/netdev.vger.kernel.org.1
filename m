Return-Path: <netdev+bounces-157340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F7A0A02F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5064616AF7A
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812012AE7F;
	Sat, 11 Jan 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS9BDdTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A63D299;
	Sat, 11 Jan 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736560659; cv=none; b=HrwaATiN3Om9Uc7Ps7Klp4hXb0kDjhZ6er/UXURt9r2HJrmLDXeuqc7Xk1fscXt5UJK4Ui+jUEgZiDWe/6E1LxqCRQ7JZnS+2p5ANoKbuIAvgARpwtGMMEyP3oQZ3YXCZifaS7nW+zpHgwpJ3NXBvPCIjcZS/kjxZBDn5hBR+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736560659; c=relaxed/simple;
	bh=gN66c9rpq9pVmOOCJWTgFOMCMXy+ejR3B0FWs5hyBaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7wERTYASxFnm1YQO2e/rKDb/DHoQQnTNy+K51ams8zBwsZasaBZs7AqJP/wX42D9bixXsZGkegseYJBZGfAJlKtQn0sumlZb/TSVsHJGvDh5tJjU71eQhUTpw2q88rrxe5k2fYofBntaIOpNap++qxXwJ2vlZDPPrOALu+DRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS9BDdTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C19BC4CED6;
	Sat, 11 Jan 2025 01:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736560658;
	bh=gN66c9rpq9pVmOOCJWTgFOMCMXy+ejR3B0FWs5hyBaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WS9BDdTmkh/VEUqow47k/j8OMzXUUP+X4fnjkwKITT9QtgMODwmp36Mt3aB1Cg4eT
	 3nDoUI0CJltIZbhtQ9+cl9Xs+t48gdzCmo/2Ynl0+RVZ9uiza+vhsMjmbn0P2WZE7A
	 wVBkyLTOVTuqwLTncUdf4YoePOFGSexwjDBWnwS9TGopatIHZsWezLpL33cl91bHlW
	 Ygy8XQ4OXaTc1H9pqcI4PHKxdeIbUkhUGe+t25wPlGrZJw5qNZRRBaSuonpax1iqKh
	 58sgHAtBvqT7l/tPUijEaPMZM30GPAl1G7Pmbxpv3QZeIDEBvh4CS9uAgD85QcFHg9
	 sdwnJIYNajoFQ==
Date: Fri, 10 Jan 2025 17:57:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeking@Red54.com
Cc: netdev@vger.kernel.org, Wells Lu <wellslutw@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Message-ID: <20250110175737.7535f4e7@kernel.org>
In-Reply-To: <tencent_BDD603E969ED7B30ACFBFFBA9EA3DA3D7E09@qq.com>
References: <tencent_BDD603E969ED7B30ACFBFFBA9EA3DA3D7E09@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 13:29:21 +0000 Yeking@Red54.com wrote:
> Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
> Fixes: a76053707dbf ("dev_ioctl: split out ndo_eth_ioctl")

I see your point with the ordering of the commits, please drop 
the second Fixes tag, then :) I'd slightly modify your commit 
message to make this clearer:

The device ioctl handler no longer calls ndo_do_ioctl, but calls
ndo_eth_ioctl to handle mii ioctls. However, even though sunplus
was introduced after commit a76053707dbf ("dev_ioctl: split out 
ndo_eth_ioctl"), it still tried to use ndo_do_ioctl.
Switch to ndo_eth_ioctl. (found by code inspection)

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
-- 
pw-bot: cr

