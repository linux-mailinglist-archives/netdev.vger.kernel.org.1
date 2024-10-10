Return-Path: <netdev+bounces-134203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229FF998642
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB642821F3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AA1C6895;
	Thu, 10 Oct 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gToKVi6l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3A1BD00B;
	Thu, 10 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563982; cv=none; b=pQH/V6QoLEgyMT2vtwQ/rPanH54tm0A4P8kbcjuVrZw3kx8vRq9apBnbo8JS9W2NDR5TvyoqZpL5sHa4yAzyl2AzmRc/LCXe3qD0HPKsGpkGiddjxFkz1iSpYYsxXC5d/78HMx/w8MZaUbau2Sf1kN6CIhD/GoMorbAX1nETYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563982; c=relaxed/simple;
	bh=LD8P8MlsEVOTw05eZKCVdmZseYjr8X9zmHUiU67aA+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5yBtY91Oj85OYuMJqYQyb2oG8g6hDAfMLCDeLwcMiKOJaHKYynijjAgUBZ2pYLW12/0y2PM67mdqzPpAggjngmpSb99OY22tCTnSf0H5oghsW/BwrzbTXqKVmi2wz2fy753wyOf+vk0zIe71gkTF05oJGqOgXnIIBXORCCCdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gToKVi6l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xkDKvYgG1ZGbE9OZmdmZN6Uddg9Aj6h9bniy5gysQTY=; b=gToKVi6lxzjGuHvyqnPrbGWL1A
	q/jFJjJD6k90RPTo9f0IZqNxVaBVWMXyOiE5whYGLurxFRjDWZwBAVYNGRiARf0VTR1QXH0bGYMg1
	0cRbKKYPyV5t6aSqNlbIul1301twWLLQ7PAndqiULuU6ducugVA1ODRDhpO2PTBtdYkI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sysRu-009boT-SM; Thu, 10 Oct 2024 14:39:22 +0200
Date: Thu, 10 Oct 2024 14:39:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: phy: aquantia: poll status register
Message-ID: <0ab4a294-eaed-4dc6-acd0-391963b1f835@lunn.ch>
References: <20241010004935.1774601-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010004935.1774601-1-aryan.srivastava@alliedtelesis.co.nz>

On Thu, Oct 10, 2024 at 01:49:34PM +1300, Aryan Srivastava wrote:
> The system interface connection status register is not immediately
> correct upon line side link up. This results in the status being read as
> OFF and then transitioning to the correct host side link mode with a
> short delay. This causes the phylink framework passing the OFF status
> down to all MAC config drivers, resulting in the host side link being
> misconfigured, which in turn can lead to link flapping or complete
> packet loss in some cases.
> 
> Mitigate this by periodically polling the register until it not showing
> the OFF state. This will be done every 1ms for 10ms, using the same
> poll/timeout as the processor intensive operation reads.
> 
> If the phy is still expressing the OFF state after the timeout, then set
> the link to false and pass the NA interface mode onto the phylink
> framework.
> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

