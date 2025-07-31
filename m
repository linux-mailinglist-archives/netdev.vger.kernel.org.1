Return-Path: <netdev+bounces-211273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D57B17712
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 22:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ED85618B8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D811C7013;
	Thu, 31 Jul 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEg8S2Bq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292171DFFC;
	Thu, 31 Jul 2025 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993271; cv=none; b=FvM1YeK0f1jF10CV4oLx5jTB/34rQtRfiKBlzMhnb6PWMlB+Ie9o6sQ8s3ufAX8r/Eurj+xJRmah7+/uQPc6QLho8Go87EQ2LrPXNInx2IBIy4lgtZEqbveaPXKnn2qTPeMzSJlI1+zMHmEUcNqko4475pue4ZVrwp9+ntEF5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993271; c=relaxed/simple;
	bh=pkj3F6MX7xyahYz+N3j4eQGlY216yfai4OjiWJU+osI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ7wj+tVy3nSEtK8jIhdqRLTYQrYJgWtheGxlsypfIs3z3FIn7pP0MOyPjCSZSDhThgaGzgKejQExcLCb6tuBW5PI65WGOIpKiwRDeCm85Suk0qkOjfpVUwWfwORvA3WIw4f6gMlsIHuU0Wewdvh+TlK1UYgNxDOG1m1YMfKars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEg8S2Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19286C4CEEF;
	Thu, 31 Jul 2025 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753993270;
	bh=pkj3F6MX7xyahYz+N3j4eQGlY216yfai4OjiWJU+osI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEg8S2BqXLrqJIPhdGSam3Umz84kRz8buXaTCtFVeNircIwI1p/95o2aOYhpgmafP
	 4zHV0zvKynsoRO19YRgUk1r/L9jPkYGcGzGgSv7VJjhZxXiF7cmlw2rsz9kB7ToDP6
	 LIfhJo9BbuOoQvpaDT8wCMWddLwrD01G/DcPwEXRWb0ShT2b3xYpfZ14+y9FGPQaY4
	 sXzlXGLjzZvpNz9xyUw+3wl4wKOnWZAP0PVb3Izcv5KJxzsJN9j5G33mQP2NM18dFm
	 zY+/wfH3wJutWKJerXJNwAzEJacIphEe0HA7L5RxqKIpFboLJ2phvEoiqCAMOuHKI1
	 hBiwSmXjX6LlQ==
Date: Thu, 31 Jul 2025 21:21:05 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
Message-ID: <20250731202105.GH8494@horms.kernel.org>
References: <20250730202533.3463529-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730202533.3463529-1-florian.fainelli@broadcom.com>

On Wed, Jul 30, 2025 at 01:25:33PM -0700, Florian Fainelli wrote:
> When the parent clock is a gated clock which has multiple parents, the
> clock provider (clk-scmi typically) might return a rate of 0 since there
> is not one of those particular parent clocks that should be chosen for
> returning a rate. Prior to ee975351cf0c ("net: mdio: mdio-bcm-unimac:
> Manage clock around I/O accesses"), we would not always be passing a
> clock reference depending upon how mdio-bcm-unimac was instantiated. In
> that case, we would take the fallback path where the rate is hard coded
> to 250MHz.
> 
> Make sure that we still fallback to using a fixed rate for the divider
> calculation, otherwise we simply ignore the desired MDIO bus clock
> frequency which can prevent us from interfacing with Ethernet PHYs
> properly.
> 
> Fixes: ee975351cf0c ("net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
> 
> - provide additional details as to how a parent clock can have a rate of
>   0 (Andrew)
> 
> - incorporate Simon's feedback that an optional clock is NULL and
>   therefore returns a rate of 0 as well

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


