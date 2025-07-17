Return-Path: <netdev+bounces-207750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B0B0871F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655071A647A9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB189253F18;
	Thu, 17 Jul 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBXJe8xd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75192215077;
	Thu, 17 Jul 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738022; cv=none; b=QKYEEJ1YsC0y6GAz5LKaGs8vc/a1B+SFXAFJOomZZyOwXMR9AYDdaUi2zJK2E6xkJmmdEs5BpH9+cNK5UJ8veBknZDd8p2HJtWkzXJ7+J+auIiXHGRjVOz1VhvXENn2MzgyZHwHGAnQJ6WFkUB02GOO8QyFh/TJ5tlFJNJJ8yV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738022; c=relaxed/simple;
	bh=4lcM9h9lDrOLXAxtOBFPf6qDURXrVO/LIlAk6Bi0pR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiNySlKsJ9JdPofU3isEt77y7cUlAQYoIMk5aKB+0iISmqs3a9oAHOWxQgLXDpdzACTpUCNiYutW/kxyr9X8X7h1BWJzdi3gytwo7hkwWKkWW03WJ3dk6Vwwb3Tr5uqJTXkW78JKai6bD+nLjNrPdlCWd4tskCxAUhd/bPPeXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBXJe8xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D28C4CEEB;
	Thu, 17 Jul 2025 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752738021;
	bh=4lcM9h9lDrOLXAxtOBFPf6qDURXrVO/LIlAk6Bi0pR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBXJe8xdlHKEbbEtXeXnQ2AHFN/1R16Ha5IvjKPonYyD8mM9Dr6Gcc2mk6tkviIJK
	 PCDN/Qe3aqRKI2m94R1SmqFTWmCDeEGiO0WOiUmkcn9FUaXoSMXPBOiV5hNDW6OZyQ
	 xwKoJSVdYSOZHdrpgBsDpOr9idUMzJy9PrQOmUJsPNfJ6I99zcynDla4ZSTM6yF0Yl
	 5vEcY9vGZU2gZVK6PrKFZ90F36B4T+3Dh7USet7cD6vXk4yUl8gPa8mmw5rnugzZph
	 8gdn4HNloTG2u6uus+/wi+Hc4fKtZuO3gnrxuuhoXpLn8mbGMKLAewM7O50+dj/+1s
	 q80U9XTZnmx7A==
Date: Thu, 17 Jul 2025 09:40:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	richardcochran@gmail.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, 
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev, Frank.Li@nxp.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-2-wei.fang@nxp.com>

On Wed, Jul 16, 2025 at 03:30:58PM +0800, Wei Fang wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,ee02
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The reference clock of NETC Timer, if not present, indicates that
> +      the system clock of NETC IP is selected as the reference clock.

If not present...

> +
> +  clock-names:

... this also is not present...

> +    description:
> +      NETC Timer has three reference clock sources, set TMR_CTRL[CK_SEL]
> +      by parsing clock name to select one of them as the reference clock.
> +      The "system" means that the system clock of NETC IP is used as the
> +      reference clock.
> +      The "ccm_timer" means another clock from CCM as the reference clock.
> +      The "ext_1588" means the reference clock comes from external IO pins.
> +    enum:
> +      - system

So what does system mean?

Best regards,
Krzysztof


