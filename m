Return-Path: <netdev+bounces-139406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F569B2151
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 00:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62E1B20CC8
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 23:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4041891A8;
	Sun, 27 Oct 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDGN8qGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23C13D297;
	Sun, 27 Oct 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730070384; cv=none; b=R6McIqvBGH+5kLoXQkyvRD6UeqIzYB/7aJKqAu33fvBhttUqm7pvqfOyywaWoiZCV/+XOP1QRxJg9CUHn8HarOKrxVnSAJ9e3AAoKy9Af10R+EilBtRVcLaB7tzHAO2nf15duTUMwgEligYbVlSX9XyG9KefIHHThiMY9sTUvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730070384; c=relaxed/simple;
	bh=k+itR6a4fehC9AapuLt8sMTMaRbxcBj9JLpRURPUyWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIAMNFMi/tva3f5XC97AKpBiwDFFumwFjBkpgphjO6lrCio9bzvWcYh87uZnf2fOSkoLXtt5qYbpvP16s8fCQEWCUBWeU8oYjAilAgRZI+zp8ue56XPegyDw53XNgW4sV63RrpekZiD3xN/vnBlU0LUB63qo3M0MY6ClfD5XxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDGN8qGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0216C4CEC3;
	Sun, 27 Oct 2024 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730070384;
	bh=k+itR6a4fehC9AapuLt8sMTMaRbxcBj9JLpRURPUyWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDGN8qGeqw7k1uG6exl7xg+qcsPNWAkeTXw/CVGF3w62SwiruromTWbyMSPO7Zc4J
	 3KLxtPWUHhai8sT9yInwfi5AAlcgMq/sV3S3yvv2esJ+58DLTkWnDd6fAt1C0gr4UN
	 Z+I0zRSuZQ2n5vxL6nSHq0tryrNWEzDdddaUf4e32PxwFTRMR+qi42Dc5XMLMkZDUn
	 GitBVNaRudG94kRP8ApUpoTtI0TfLVixvft7xBkrPp7Pwo/X7bepXWUdCDGbaXvFRy
	 RfbopWr5KcdvnscW6h6ZAc6rWjk5ze8IOx683kc24PcEC3gBD/nKLzxqutdBRGfeZN
	 oLlm+GE9hr3XQ==
Date: Sun, 27 Oct 2024 18:06:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v1 2/5] dt-bindings: net: dsa: ksz: add
 mdio-parent-bus property for internal MDIO
Message-ID: <173007038174.211419.15098396970217241846.robh@kernel.org>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-3-o.rempel@pengutronix.de>


On Sat, 26 Oct 2024 08:35:35 +0200, Oleksij Rempel wrote:
> Introduce `mdio-parent-bus` property in the ksz DSA bindings to
> reference the parent MDIO bus when the internal MDIO bus is attached to
> it, bypassing the main management interface.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


