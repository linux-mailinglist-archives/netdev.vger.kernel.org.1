Return-Path: <netdev+bounces-89826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34808ABC5E
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808CF2815D8
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2123987C;
	Sat, 20 Apr 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tuSQdkmk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FD29D0B;
	Sat, 20 Apr 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713629448; cv=none; b=HDa8no1Iu9mUfcn8I94wbaCjOI++Ciam57b9q6g7YKzV4XW9ECuQbYTIkQVqbSI7aRXMQ+9w/jNszw3ExaVrAkotsVJyu6ZkXGpcdjw36yL/kfZtksZTB7tV+d5U6sruEkuLDQBToWlNM5NIj3qX13NIzMPbseK+8wM4GnyB5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713629448; c=relaxed/simple;
	bh=jEWyu3XkB02DkmJXH3xXUI8vVc3DHzw2Jm4ntNuGkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiAY3xmgyqs6DFRSRiJNCPO3jHET+tLV43PG2wryvvthOg4RDc0YAI7bK+nMwMV3NMLtWuF/wOtlwua5rkz1odmeNIxFtaX4G85ILBvrx0tYY0R0QuDzsaRxVh4+91EQuOqx1pjCg+B88JD3bZzW9R7u0bChUs4PL4u0CXuaZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tuSQdkmk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zq8Ooeyqqqkv4wRztWtQYG4Rnz6X58GLq+dZ5DsKaJw=; b=tuSQdkmkoh2R7Her/4k3nEkC6r
	jDenwQxgfNg+an4ePRvIR+gZfYrZz9GV70FTZxpOKfNC705nIiBCgOYKW7CUkZ4q/RGhE6xU72jk4
	Y1ptmj0pzjsR5cv/NbgijE/Tx/RtZDY9iYFpvXp+gu/NKRsPeJZQDlPWxqIzTkS8uc8Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryDIR-00DWA8-UC; Sat, 20 Apr 2024 18:10:35 +0200
Date: Sat, 20 Apr 2024 18:10:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Message-ID: <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
 <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>

> +  adi,link-st-polarity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      LINK_ST pin polarity.
> +    enum:
> +      - 0 # active high
> +      - 1 # active low
> +    default: 0
> +

How does this differ from:

Documentation/devicetree/bindings/leds/common.yaml

+  active-low:
+    type: boolean
+    description:
+      Makes LED active low. To turn the LED ON, line needs to be
+      set to low voltage instead of high.


Why do we need a vendor property when there is a generic property?

	Andrew

