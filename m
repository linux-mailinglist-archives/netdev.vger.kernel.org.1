Return-Path: <netdev+bounces-241738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B9C87DB7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D3444E1E6F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E8530AD05;
	Wed, 26 Nov 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFv84XcV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D722339;
	Wed, 26 Nov 2025 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125017; cv=none; b=r4zGSpUwIvQi4swDf4j46JWH06yRrb2P3+UOM6Q7kUMR+Yz7yTdwKtfcO+66U6yeM0dqy1ieGW8w8UkO+FiAUtfubYCsy8xp2BiRgZcP2r/b1h9/8NgtOeoKcXDkOxUhsUfN8cGkNLgC84mZJs253R/rw1a8dmuTQXn2ymMfX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125017; c=relaxed/simple;
	bh=+FMkMP9YZSzBOEBewlWn/akecndzrde6rgtdkYm5p00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPjkaXpIV9o/zhnJJX5CFFRdRW/2KA9OT7l9xgTlHmw45k60GsQFAAGUaf51ncu9ijuuQHuQHIH6zPpiQItFKwZ7gVffk3aJYTncIVgIBZXwyGJMNEj30gZ4dfkgEuTt8FtMK/Z1bKdFn1Wyxwgx51YgjV2EKXU468gyYcaSrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFv84XcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F5EC4CEF1;
	Wed, 26 Nov 2025 02:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764125016;
	bh=+FMkMP9YZSzBOEBewlWn/akecndzrde6rgtdkYm5p00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFv84XcVDz3HUczfoDn3j3wzmZyr/x6Ad1BhvzqD9Z/dKaSsRmf8IPXkAsPJW2xuE
	 RUhvJQBDEXh1AYkqlQmfjDqJ8kvL6+7HZrbLcRSNsRzzdEPC+EyiHohH9tN5Pa7oBB
	 j23ndLA6TGOIg/H5jtydGu1P3ora8QXoFnRYjSkMylSm4+80z0zmtLA/+Oixg+N6m4
	 9WXgbL3PJvN6WA28axAuBtnvP1Ea3juI6pBK8HrBATflVNXYDo8azydocmTsPbUahf
	 8s18Ab7LqjC12V8uCXUG71NrEbQm7BXBXHmJpZXVLmfQKYXHANeoaAWC7YbdwQZEpJ
	 1MHVWQsi9Ozww==
Date: Tue, 25 Nov 2025 18:43:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to
 access ID register
Message-ID: <20251125184335.040f015e@kernel.org>
In-Reply-To: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
References: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 12:15:51 +0100 Buday Csaba wrote:
> When the ID of an Ethernet PHY is not provided by the 'compatible'
> string in the device tree, its actual ID is read via the MDIO bus.
> For some PHYs this could be unsafe, since a hard reset may be
> necessary to safely access the MDIO registers.

You may be missing exports because it doesn't build with allmodconfig:

ERROR: modpost: "mdio_device_register_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
ERROR: modpost: "mdio_device_unregister_reset" [drivers/net/mdio/fwnode_mdio.ko] undefined!
-- 
pw-bot: cr

