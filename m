Return-Path: <netdev+bounces-178419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EC1A76F7C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E4B165448
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4D21ABBA;
	Mon, 31 Mar 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZnsVzoz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC4214227;
	Mon, 31 Mar 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453653; cv=none; b=pAgWb71oy+W0jLVdqIkB182KPPLrjrhNtFIShj0UBfMq+YejDjUjVSGnW8udsEQktOECmKrY2kcirvls6jA/A7t6I4xkU9hhNeJMQsIY5/vrnlYM7JfN0m/43V0PG8PNxKLQq3otJMZf4IcHVOquPl671dPNYdFXxjVkQ1ii2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453653; c=relaxed/simple;
	bh=I0pww8VqJBHBfu1PWz4L5zWozNIoPBm6Vts7A/QmhsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnY5fAU738v/vT/YzMKODzDfpPaQDlKLmpR1av0xC4ZvXi2a38kYzVz3YIpwE8IaqVqUkIYhr0MTFcH5tHQttXegPZk3V//l4OzJRGzBol0ZuY8iLGxZCIKiNHVOEyfl0756CTMc/aEYfE3tfOY89tWMLhxMTRBROz7NkN6uKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZnsVzoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F4C4CEE3;
	Mon, 31 Mar 2025 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743453653;
	bh=I0pww8VqJBHBfu1PWz4L5zWozNIoPBm6Vts7A/QmhsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZnsVzozdNfu5X8UMeTfgCssrlEL5caMO3Y4haUBvmkL4T0VpNWst9+N+9bWopezF
	 dWQPDBPbtA1QhnUQmYaHQJNHu5SdZRBm+vIDa1kdG5BcsmbPiNgq1TIRpfvEJI/ZnC
	 Wjm7JgV7584sBvEGNVP43cgT3+c1lgb19xo66DyPQJRkgr6JsRbUpsPa0DexBiBaYt
	 KVNsL2G09JBLeYQL98P/VzX8U1iarWdiSGnZHEWenN+7h2L/tZtFbfbLkK03Fosvc9
	 FuQwgdKo8Ya/EEgf2iYJFbIxg3lUTQqowgZhc2QktN++nGejnxT5I66ou80Nnspl5t
	 nqvA7oHo8gXnA==
Date: Mon, 31 Mar 2025 15:40:51 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v4 6/6] dt-bindings: net: Document support
 for Aeonsemi PHYs
Message-ID: <20250331204051.GA2764400-robh@kernel.org>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
 <20250327224529.814-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327224529.814-7-ansuelsmth@gmail.com>

On Thu, Mar 27, 2025 at 11:45:17PM +0100, Christian Marangi wrote:
> Document support for Aeonsemi PHYs and the requirement of a firmware to
> correctly work. Also document the max number of LEDs supported and what
> PHY ID expose when no firmware is loaded.

If you respin, in the subject: s/Document support for/Add/

> 
> Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> AS21210PB1 that all register with the PHY ID 0x7500 0x9410 on C45
> registers before the firmware is loaded.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/aeonsemi,as21xxx.yaml        | 122 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

