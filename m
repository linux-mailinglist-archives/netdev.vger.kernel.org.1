Return-Path: <netdev+bounces-166800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5901CA3759F
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27810161E56
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355F19A28D;
	Sun, 16 Feb 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RKazNKOP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9081B808;
	Sun, 16 Feb 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722644; cv=none; b=miLf03hk1vM10hgPIt3TE9KQtRUuJNFzbnF9BjHeWyXrwxjg7TVyEu14rZMfOB36/72Sz67VcfMmu/g9IeRB/wZcXvWuZ88f6zRymY32WGUHnPErVGCfVcJ+38xhIC1GketHGbbjo+wxrHrLeoHMgGGWlc7Kq9JrK+ePAk5NuQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722644; c=relaxed/simple;
	bh=7xhhfB2c5CN9vWOSbk+0aAtHHvR/6Y0Ye2cs4tagP+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFjV44OB0iikxQXzQpZgsQ0n4LlRP4LoXcIDkvgziMve5QG3uu7i5uOOLxa+J/EgS3OHwHsdCB9Y8ptWt4r7zaxS0rAL+J6zfpFKeY+S174Cu0nDYu7rHRRKgYjTjaZVzbMsYZPJhg/kA9TxlZmpNicj8T/FEKVac+HHImBLu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RKazNKOP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FzDhmYkPBX2r4w4yW76IMnXZ3t1dVA8aaIH6pMojOqE=; b=RKazNKOPBPzNyczjpgKUfO4Aei
	sapidYUMyTBHzfJJheZ3sjJ8R+YhYxAS1qRMZFkdREF1QVmIJ3y0zUcHZvBPw5Agg3t20eBJmamQc
	s9ij6uWk6v/tQaMETIUOeUEI5DMl1p8m6pu1m75xCw1Ng0995Fp5JCeXA5Wls3Oxlnvg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhKR-00EhKz-HS; Sun, 16 Feb 2025 17:17:11 +0100
Date: Sun, 16 Feb 2025 17:17:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v5 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <d3bb81cd-72a5-45a5-93f3-56dfac23f6db@lunn.ch>
References: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
 <20250214-dp83822-tx-swing-v5-1-02ca72620599@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-dp83822-tx-swing-v5-1-02ca72620599@liebherr.com>

On Fri, Feb 14, 2025 at 03:14:09PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Add property tx-amplitude-100base-tx-percent in the device tree bindings
> for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> necessary to compensate losses on the PCB and connector, so the voltages
> measured on the RJ45 pins are conforming.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

