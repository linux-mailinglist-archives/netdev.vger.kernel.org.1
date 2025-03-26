Return-Path: <netdev+bounces-177741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC7A71811
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644BA3BB8FD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4D1EE032;
	Wed, 26 Mar 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrdA58Rl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF18EB0;
	Wed, 26 Mar 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997932; cv=none; b=akb8+asKePgh2YrWXH+VzUlJ5QvAtK7cw4e/h3FgO9FgCCcwjR/YW1V4cLLoe83YtL6eHcqYWRg7iGT7r7o0wzIpz23jrybPEi+gWd94yfWPoBAqtFWAPQH3nn8oYLoPqt8OVGS0gFom/CYWNVp1LhbpUHvlRMmhcbCOB74AnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997932; c=relaxed/simple;
	bh=kMYN978mk+pPPm9GlHwciifdm/N4aIoXpSMxqJLqzLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8+9kZeRZukqjCQhC5luCPx1ZFF/hP5VYP2BtJXCOd5LQ2wIEI7qBG+Jpo24W7+uN3m5OPKNsEa1S4tjMSp7SryhmF3qgTSOcGRAZDTX72xc0efY54u3uUpv19Kp9A0b4CucbaG4pjOWs6vTFo68k5OtjuVDbSwSvcK11tAyieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrdA58Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D7C4CEE2;
	Wed, 26 Mar 2025 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742997931;
	bh=kMYN978mk+pPPm9GlHwciifdm/N4aIoXpSMxqJLqzLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrdA58RlAK3peuhLitCwgnfoDanKZx9OBZ4zw7pXtgVyjg2sf3bNitnoM8dH3bIdd
	 KwUfWpX5kWV96Dj6uMP+ShtaflyvO7MS7VbBeSf3WMVCgXdOd/Jd+nH354ttmCh0j6
	 QgfaVuB0gfz3ks9lAg26BEUeELYOB3vv+eT45Wi09z0K+B4wzZH2GhJ7Q9vH4T/R2n
	 e6jcRFQxeE8GH+RIUgQ/2ABFDl/5kmwj+9veltu3QFdUVlk5sGbmpPSvga8KQJzBSf
	 AwMf0Y8EyMnK+oPXsyrIgRbMThX1QGzrA+QiE9WJf3TlvfGTmpHmBMmg8/AryPxb2F
	 IZVVe7u6C5urA==
Date: Wed, 26 Mar 2025 14:05:26 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <20250326140526.GE892515@horms.kernel.org>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <20250326140015.GD892515@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326140015.GD892515@horms.kernel.org>

On Wed, Mar 26, 2025 at 02:00:15PM +0000, Simon Horman wrote:

...

> Please note that net-next is currently closed for the merge-window.
> So please wait for it to re-open before posting patches for it.
> 
> RFCs are welcome any time.

I'm very sorry that I missed that this is an RFC,
so my comment above is just noise.

-- 
pw-bot: RFC

