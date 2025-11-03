Return-Path: <netdev+bounces-234977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C7C2A8C1
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 09:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C253346712
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06832DC33B;
	Mon,  3 Nov 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjU589i6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A102D9EF3;
	Mon,  3 Nov 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158211; cv=none; b=No+nuFcWtF8jHC4zZsZHEx4+eLyqJXCxHhHZjBq0UkOmgltMHHWFPJft+EgDZiY6G0iINnaH7e6bQt6MEq7/iQZ1UaK7EmUNJ6qhMu7rEOYJJkngGd5rynNUGDChQAkn1vl7POfjuhu8+lMQzIU68eXGBbS8/5ADnCV2PQB0CPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158211; c=relaxed/simple;
	bh=hbEkMfhTE5CQphEJf2mmVqxhPtwuAEPllQjgAdAoN48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHKHUOpUbE5WmtOh1K1ALUD/DzOAz58las4XwqO6RvEXZjUDY9sNMUkxShY8XBqHirBfGaDumqdbFGRbpZIWtXQP91G0PfT1HFwBNPHJOXb9Rb4JPsoecOSj0JhCPVbdyiLoTcetJ0c2Rf/W56CEGELG0g6pG4W1mXuzmrv0n34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjU589i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98BDC4CEE7;
	Mon,  3 Nov 2025 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762158211;
	bh=hbEkMfhTE5CQphEJf2mmVqxhPtwuAEPllQjgAdAoN48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjU589i6UUgkyoNhkHaLWcls2GlCJtwcMh20FuZO2vjdks7jF3XgsHTA4aazeK2Ma
	 6vUngPX9V1EZ9dVbTfRICMabdNXPLiagCuHFpu1WfcJfAP/200PsVIleHdt/OYhZzc
	 2TmptyKd9cImvSo1/f0uLByz/s4rjCYaGNo0jpEIkX8JOoG65CfZU/6GT+xJIbZ6vE
	 SlJeeHG5DBi9dyYqHv9BGwmpfLfqyY6JTPXUJ1brmEyGLoiUSe6UU4XtoKVUBgLwGu
	 SpJ87dGuehTDlA6ma6KVXag9oUvGvnbdLpRkHXlmFwpGrzrAemPD8eKWnlWr79f9y7
	 1qCS75YLrAicg==
Date: Mon, 3 Nov 2025 09:23:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Schirm <andreas.schirm@siemens.com>, Lukas Stockmann <lukas.stockmann@siemens.com>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Peter Christen <peter.christen@siemens.com>, 
	Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>, 
	Juraj Povazanec <jpovazanec@maxlinear.com>, "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>, 
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, "Livia M. Rosu" <lrosu@maxlinear.com>, 
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v6 08/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
Message-ID: <20251103-rousing-auburn-barracuda-d8491f@kuoka>
References: <cover.1761938079.git.daniel@makrotopia.org>
 <3c8dc0bab72de05ce5b5a7960b6596009287fa8e.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c8dc0bab72de05ce5b5a7960b6596009287fa8e.1761938079.git.daniel@makrotopia.org>

On Fri, Oct 31, 2025 at 07:22:09PM +0000, Daniel Golle wrote:
> Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> properties on port nodes to allow fine-tuning of RGMII clock delays.
> 
> The GSWIP switch hardware supports delay values in 500 picosecond
> increments from 0 to 3500 picoseconds, with a post-reset default of 2000
> picoseconds for both TX and RX delays. The driver currently sets the
> delay to 0 in case the PHY is setup to carry out the delay by the
> corresponding interface modes ("rgmii-id", "rgmii-rxid", "rgmii-txid").
> 
> This corresponds to the driver changes that allow adjusting MII delays
> using Device Tree properties instead of relying solely on the PHY
> interface mode.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


