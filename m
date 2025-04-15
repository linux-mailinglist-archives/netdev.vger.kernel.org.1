Return-Path: <netdev+bounces-182808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB951A89F45
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4103B189FBA2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CE2973D7;
	Tue, 15 Apr 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xlH8rjaF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4231C6FF5;
	Tue, 15 Apr 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723247; cv=none; b=i4jDBQ9tq6RSv4PUUjj/7S3N+YDZ+aWET3oWPqQsa4MsAoVC87MVYaP5J7s+K1iy38w48+fJEdAub3Fsbenoi08iLTztzcuyKKGfmmpiPNkJSuOHtFiHUmbRD1u6gIcOiUgvioO6WyGJGTBPrY+9hINAnD8IvYPYYrUw0lA/gyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723247; c=relaxed/simple;
	bh=0COEkxB+APvNdF+miKKyOTbBKTDK5TdhHuMca6Jb0OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngV3YwHzmFhJskX6m0z24TkP20TkqlYZlCNuJSfPnPi7fqREk+XRRFjSZjzrlRjXeILbI7RSXWwGPPK64vEMn90kEGlD2QjX39oqr8N65vQ0UDJMvhxHDmL+XQyVHkevAmTekUh6+vl0RkyRpIVCIpXWHob2gZ5Mv9pm0rZz5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xlH8rjaF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zwXoAPOSd7TPYyFwNb3wZwJZIOBKCyO+D+dc+pl8JG0=; b=xlH8rjaFC+RAnQBZCoJmZEEd0E
	D24kM63bpE+zT98wgG3mJZJIgEhEmxpiIVkYqIai0Gkuqv+z5hDasP9a7SmjGc5rNDr8V0jh5D81O
	wPKei3YG3MRZttrcOKTXxzyYFNbcxuljK4qjvy2NaKNqo/yDE1FouImJPkQRFRM0Ff5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4gDE-009RsY-Ta; Tue, 15 Apr 2025 15:20:28 +0200
Date: Tue, 15 Apr 2025 15:20:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
Message-ID: <9d73f6ac-9fee-446b-b011-e664a7311eca@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>

> +  **UNCOMMENTED_RGMII_MODE**
> +    Historially, the RGMII PHY modes specified in Device Trees have been
> +    used inconsistently, often referring to the usage of delays on the PHY
> +    side rather than describing the board.
> +
> +    PHY modes "rgmii", "rgmii-rxid" and "rgmii-txid" modes require the clock
> +    signal to be delayed on the PCB; this unusual configuration should be
> +    described in a comment. If they are not (meaning that the delay is realized
> +    internally in the MAC or PHY), "rgmii-id" is the correct PHY mode.

It is unclear to me how much ctx_has_comment() will return. Maybe
include an example here of how it should look. I'm assuming:

/* RGMII delays added via PCB traces */
&enet2 {
    phy-mode = "rgmii";
    status = "okay";

fails, but

&enet2 {
    /* RGMII delays added via PCB traces */
    phy-mode = "rgmii";
    status = "okay";

passes?

>  
>  Commit message
>  --------------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 784912f570e9d..57fcbd4b63ede 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3735,6 +3735,17 @@ sub process {
>  			}
>  		}
>  
> +# Check for RGMII phy-mode with delay on PCB
> +		if ($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*(phy-mode|phy-connection-type)\s*=\s*"/ &&

I don't grok perl. Is this only looking a dtsi files? .dts files
should also be checked.

Thanks for working on this, it will be very useful.

	Andrew

