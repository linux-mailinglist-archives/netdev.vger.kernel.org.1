Return-Path: <netdev+bounces-117774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2894F21E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5541F225ED
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E418756E;
	Mon, 12 Aug 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgn3P0Qt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121416F0FE;
	Mon, 12 Aug 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477871; cv=none; b=H69ZDhi6kTOZKXuquoEUDupB9kBbslIrmmP2C8rb8OkZsX/zLv8kX4YOkLMKaprDy76R3R3TWaz8yrKoPqt6RbVGo/q8ogd2qQihspxkBWyu46frQGcKKlhz+c4Oa0wW1U5T2hbcXZbrSN6Dyyd6KPxYcVYyeHGwSELlrM4L7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477871; c=relaxed/simple;
	bh=Zz2O1E2RE4zrYAOxOl8477P4o/vm8t4OyENrerlYoqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0ZXtuBzeh/zbb+Sk+ycH9rBR5Zh6cOXDhVjnpC7POfu3uiwJWNjYR5Tip/lN5Rw++9/w96NfD82il44ocAigUXvsYhDSOVS/6CKmH9X1kUtHgMUYjWVz5ko1f6lNlWi8BLqKxyyU3M7+ltDyZIYrf6dn3wbIwAVBHqvtqgwsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgn3P0Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB2FC32782;
	Mon, 12 Aug 2024 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477870;
	bh=Zz2O1E2RE4zrYAOxOl8477P4o/vm8t4OyENrerlYoqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgn3P0QtomjUmnOXXzcSkj1Eba5S7OjS9PQRy674tFxBM6/RAchY2voNyhbuLuJ/3
	 ezekgwIxTREXbKghXCQInxiZ8ld5yYMK2aedrjX1bxYludVtjyGh8zSwZN8+W3k103
	 dleWqbV3xRhc+S+LqcRVwuh7KzFoRQnuAODlU5CMhJkTk7RnAEWZQj3u9k/zoBGZXZ
	 v8AnqOSU2ofv8gWv+Of4xCnGkGvGUGQ7mNF2JXtUobAo/d4Y4dYjs/VW7GAUS9MhLY
	 OBdqse9wTtPtw1CqnpUGBkD+tx4xmPsjcDcgpHvIVmZiuhJNEb1Swvj1egMOXAIsiQ
	 X84xng9vWc8hA==
Date: Mon, 12 Aug 2024 16:51:03 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: mdio: Add negative patten match
 for child node
Message-ID: <20240812155103.GA44433@kernel.org>
References: <20240812031114.3798487-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812031114.3798487-1-Frank.Li@nxp.com>

On Sun, Aug 11, 2024 at 11:11:14PM -0400, Frank Li wrote:
> mdio.yaml wrong parser mdio controller's address instead phy's address when
> mdio-mux exist.
> 
> For example:
> mdio-mux-emi1@54 {
> 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> 
>         mdio@20 {
> 		reg = <0x20>;
> 		       ^^^ This is mdio controller register
> 
> 		ethernet-phy@2 {
> 			reg = <0x2>;
>                               ^^^ This phy's address
> 		};
> 	};
> };
> 
> Only phy's address is limited to 31 because MDIO bus defination.

nit: definition

Also, in subject: patten -> pattern

Flagged by checkpatch.pl --codespell

> But CHECK_DTBS report below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> 
> The reason is that "mdio@20" match "patternProperties: '@[0-9a-f]+$'" in
> mdio.yaml.
> 
> Change to '^(?!mdio@).*@[0-9a-f]+$' to avoid match parent's mdio
> controller's address.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

...

