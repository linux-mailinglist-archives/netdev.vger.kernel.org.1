Return-Path: <netdev+bounces-194727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB3AACC264
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57418188DB50
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9997E1917ED;
	Tue,  3 Jun 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUMOAaTg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5971E4A4;
	Tue,  3 Jun 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940538; cv=none; b=RoAVDZU0vs1v9kmI/Ts66WG4qqc0gl8eWFe6WB3408ncsNSkz+uXwCYXMF5reW8ZA5b5INHHNoAZozi6XCyrQnyg4HN3dKqxOZBVqjK0GxQcD25+cM2fsKHOmsS12oS9cn19YnPY1tox7Q3Yt7eRALOshWSOnY2lteap1g9R0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940538; c=relaxed/simple;
	bh=crXBxEfrAeAfnyPDFWKziQ8DjQCy0DIGNxBcMZtL0ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj/R7wphvr7ITXax9XhRdG9oMqpOHydn38Kp+BGeNZ0gZspkKAXdj86DbpAJGRwiScSiharzaam7dTsroc9puOmtrIZe+LH/ONaYr2ebnakpfl6emHs2y0Sw15T1F2/RTUGbJH/4Jnct5DhBSS9ZsByXSHD+I7/8gsn4MfJkwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUMOAaTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDBCC4CEF0;
	Tue,  3 Jun 2025 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748940538;
	bh=crXBxEfrAeAfnyPDFWKziQ8DjQCy0DIGNxBcMZtL0ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUMOAaTgHkyLrKfPjroL28tyP0YjJqLQ+OOyPSowGPOKFDFpqT5f1sYGucX4m0f3r
	 yuc08Yx5PDxE3qDrbMYn9auvfKM9idU4amw6d1Il/bgxZ0C7DFzz+8DOraAfyos0Ji
	 /oTGclwuSc6+4Fr79aadMvv+hc3ucgsDF0i1K/bL31WDQ9wQZD7DBLaANGXes7jSTn
	 6WVSW4WmIOCR1DvK0sOZupcS0D/wFQTZGr8Yzr9MQb7AXlEpyMKGoxe1NyswjTKR99
	 pNkjrJaloKLKvG181cMxcJnpeywH/6aNDrWnOHMzdvnbLSuyHA1mWQzZouj656Gki0
	 cESDb6NcOGc/Q==
Date: Tue, 3 Jun 2025 09:48:53 +0100
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix swapped TX stats for
 MII interfaces.
Message-ID: <20250603084853.GD1484967@horms.kernel.org>
References: <20250603052904.431203-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603052904.431203-1-m-malladi@ti.com>

On Tue, Jun 03, 2025 at 10:59:04AM +0530, Meghana Malladi wrote:
> In MII mode, Tx lines are swapped for port0 and port1, which means
> Tx port0 receives data from PRU1 and the Tx port1 receives data from
> PRU0. This is an expected hardware behavior and reading the Tx stats
> needs to be handled accordingly in the driver. Update the driver to
> read Tx stats from the PRU1 for port0 and PRU0 for port1.
> 
> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> v2-v1:
> - Include a comment along with the bug fix as suggested by Simon Horman <horms@kernel.org>
> 
> v1: https://lore.kernel.org/all/20250527121325.479334-1-m-malladi@ti.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


