Return-Path: <netdev+bounces-215847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA642B30A36
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8E17C703
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A04A04;
	Fri, 22 Aug 2025 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z3PdCQzI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8207639;
	Fri, 22 Aug 2025 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821864; cv=none; b=Bqga7qqEUB4fxNJuQrCrm9IveJtDeRlhJyRkuVx6ZfGtYmd1Mp3jnbPSIJfc8YGaZTpc+1XF8q9G4S19f1qL8JyNtEIs5UxDcfuBlRjRg9bFZ72DTYVJ5zSf4RqNVBl3GNNW1j6SHQ9UGuRabqu34yal5nMroCF0I4tL0kGsUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821864; c=relaxed/simple;
	bh=hh8gcYhwlaEWnPDFNdJvGqnIG632yfoyJIcPyVR+ASQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThTNvgh8f9OBC0pH0TWT7HYgP/fBbRo3xj3uLGh2dLXTc7WqsXiUlU0HX1McXsCyDUcmSmlHkG0FGNhp9ObPtZ1ys+el3jvlV1i6vUsT3NpKaSTRxlMjgByfsYVR7dpGzSziTTfXs7lJev1ML5sKvIp7UeApfTJ0jnLyaGz3ZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z3PdCQzI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UKTkvhuaX5AjY/CwajqVAeW6a1xq+h5mDmoM8nkw4D4=; b=z3PdCQzINoQrl58dMkTuszVAqa
	el2KyUJHAdmmqrgg4xzeC55jlqVuzAijhtGsKWQVzMxlz5PR+fW+vUHebWBBUmp4vx61UJD+S4V/K
	H/i3gIRMXQU2SS6kw/EthBX/ARujuRC4xw4uVUbT/A7ghASqrnEzqEAG0KJ1U4ILn/Co=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upFTI-005W5i-34; Fri, 22 Aug 2025 02:17:32 +0200
Date: Fri, 22 Aug 2025 02:17:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl
 handler to support PHY ioctl
Message-ID: <204b8b3d-e981-41fa-b65c-46b012742bfe@lunn.ch>
References: <20250821082832.62943-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821082832.62943-1-parthiban.veerasooran@microchip.com>

On Thu, Aug 21, 2025 at 01:58:32PM +0530, Parthiban Veerasooran wrote:
> The LAN865x Ethernet driver is missing an .ndo_eth_ioctl implementation,
> which is required to handle standard MII ioctl commands such as
> SIOCGMIIREG and SIOCSMIIREG. These commands are used by userspace tools
> (e.g., ethtool, mii-tool) to access and configure PHY registers.
> 
> This patch adds the lan865x_eth_ioctl() function to pass ioctl calls to
> the PHY layer via phy_mii_ioctl() when the interface is up.
> 
> Without this handler, MII ioctl operations return -EINVAL, breaking PHY
> diagnostics and configuration from userspace.

I'm not sure this classes as a fix. This IOCTL is optional, not
mandatory. Returning EINVAL is valid behaviour. So for me, this is
just ongoing development work, adding more features to the driver.

Please submit to net-next.

    Andrew

---
pw-bot: cr

