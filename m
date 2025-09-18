Return-Path: <netdev+bounces-224649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F2B87555
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D311899E06
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4B289340;
	Thu, 18 Sep 2025 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuDPi4Yz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DF28643F;
	Thu, 18 Sep 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236985; cv=none; b=akdDbboAr9LVBfuMp3hEUnmB2gtZ7beL+IZ+hHrRf1ly2Wnw5xPouFDrpuFYhhwvk2KUj5yELskVKmTQIATXs4e0EhAuzjOGofDrXNDmU5zRoOEXrAGgGDXAQr8gzUDuGOFie16rosZtq0EW/SKI5niIL7EFh5Kj9P/nXYVXBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236985; c=relaxed/simple;
	bh=EWYox5tLLE4ckRZTY2TRD6jl6RPyS1FG/NmSLbm3/BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGlmbmqkpxUtTmBATr7k4HquEMuMtvuK4+S/mQNGxmQA+BThV+4Ws3AHnWmySTxAM4SjJtu2U3Kcn3AVqocwBDgGKwl4/v+/T+Fel4RrvLMcRLgdT+pFS14shbrU+u4tKXAW8K+nrL0YYnBJFGQDYiR1Ohus12AOJuLtBlTLycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuDPi4Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF57EC4CEE7;
	Thu, 18 Sep 2025 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236984;
	bh=EWYox5tLLE4ckRZTY2TRD6jl6RPyS1FG/NmSLbm3/BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LuDPi4Yz+tbXd7umJcX3mApNgg9lCqQjn00WnCLmcf5+qae9BE2jVtS93c2lg5/S3
	 le2j/5YOPJ65lIp/e4qANQok0ALXaquuGekVl9mAMBbTsYI2gpieVLx3qI/ONHqyaY
	 1/edHb8m3zR6kdMac11bPQ0rOMP5y3xPKU9vahXhjAKX00RpdOd+oO/cjZR+EXdk2v
	 i4lVf7sXYQn/OuHZL/HVqUvJWxl6gOOWneKG5WNC+39z5qkucRr2BD+j2vHE/CPcaK
	 i55SH7P9bg8BRurDfWsTsOk9n8xcGN+IrkU+W5cr4yL5IkfOFY0hn5qsmufrR4m67T
	 CpDZVOnGCqdtQ==
Date: Thu, 18 Sep 2025 16:09:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
 <vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
 <christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
 <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250918160942.3dc54e9a@kernel.org>
In-Reply-To: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 13:33:16 +0200 Horatiu Vultur wrote:
> When trying to enable PTP on vsc8574 and vsc8572 it is not working even
> if the function vsc8584_ptp_init it says that it has support for PHY
> timestamping. It is not working because there is no PTP device.
> So, to fix this make sure to create a PTP device also for this PHYs as
> they have the same PTP IP as the other vsc PHYs.

May be useful to proof read your commit message, or run it thru 
a grammar checker. Copy & paste into a Google Doc would be enough..

Regarding the patch the new function looks like a spitting image 
of vsc8584_probe(), minus the revision check.
-- 
pw-bot: cr

