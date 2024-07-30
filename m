Return-Path: <netdev+bounces-114203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12035941548
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A985B21E4C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490111A2561;
	Tue, 30 Jul 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0fj3dcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530529A2;
	Tue, 30 Jul 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352632; cv=none; b=GoHne5NAxzv8FOd2c89DewFWHrAUGIY/7h4t/UUU3mpJkUIcqQ52a4Q3EKjk6TIt0xRsqNADi7up31SRfNfn+nTRwqiYgPWPmXnPRsyxPvcSMKfefdYmzzNsH3r9hnK1BxakqUWzwGsdw0gT2GBbTk7LXD1QsiVGpQ5wUPCBiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352632; c=relaxed/simple;
	bh=BtDCutXRhwkn1Xbp+V7Y01a1tibZJVklJFePnGti1lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyrIZM6KWWES1kP/KOT4qDvLr4lSNcBCsBPLcnyfj/hIiRrWV6nFUDTwLIqPKE+7zpP6da6P5PtZzFLWqbsfGDxQt/inDEEEmldXUlyhN7Ua6kRVFkiY19qXjVodV2BytWxshoHI+i6vLIfpL+z6nUu1bZi6nkmjfe90S9bKIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0fj3dcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDFEC32782;
	Tue, 30 Jul 2024 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722352631;
	bh=BtDCutXRhwkn1Xbp+V7Y01a1tibZJVklJFePnGti1lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0fj3dcL0876RL6raHuG65znJAwBIUbIkLxOMofSXaWjbUlfivl4YW4+vdBO7VkiW
	 JGyXKhuOw09wzrXBx9UibEH+AXVuY4N0f0zlztMu8H35cOsRdDiOsLCrcu517J7dvL
	 Mhr9mHHitZn0msgDqFCqKdiNGoODv6uCqaT4P2h/RcWyrQ3iZa3EvDjm8Usxq9lZ87
	 oV0G9oTT4hDt5X7Fip2nP2H5IwRkxkbjWfZBQKeLTw/uOmGxSjyvQdC70R9FQl1rq+
	 6FBeu/Bnkd99phpHIfCjRD2KjfHNaR18eb7mpNWb+8y5YdgDnK/J11027OrY6behfN
	 sxz/5LKjY2T+w==
Date: Tue, 30 Jul 2024 09:17:10 -0600
From: Rob Herring <robh@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	horatiu.vultur@microchip.com, ruanjinjie@huawei.com,
	steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
	masahiroy@kernel.org, alexanderduyck@fb.com, krzk+dt@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240730151710.GA1279050-robh@kernel.org>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-15-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-15-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:39:06AM +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> PHY to enable 10BASE-T1S networks. The Ethernet Media Access Controller
> (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> integrated into the LAN8650/1. The communication between the Host and the
> MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> Interface (TC6).
> 
> Reviewed-by: Conor Dooley<conor.dooley@microchip.com>

missing space              ^

> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan8650.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml

