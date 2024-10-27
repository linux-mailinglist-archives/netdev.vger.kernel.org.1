Return-Path: <netdev+bounces-139405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59809B214D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 00:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C7E281219
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E0188A15;
	Sun, 27 Oct 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2k6JmP+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E417C61;
	Sun, 27 Oct 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730070300; cv=none; b=Q6tC/3y4OUbJuaBQ5gQYGdyZt5c2K9Dm3+4nm8jv3U0mXeqyZcC7xYbaOOUKML23QEf0Gg+dhpaHT9VX0y05mqf8vPM34yqgjM2TqweZ9utxlRQCe0D+4IEquP/TF+ozexuGw0hjG4ojm6meelDiFaRHp07F9e44NoSxwkB/Lhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730070300; c=relaxed/simple;
	bh=KowpgPiqRL+54vb3w2Ko0hfBbmI2KvYVknTNhdZHnb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSjxAFqUbQoflI3qiXv30oRszbx8Jdwg8FCKWJ/0ccuI570sK8oRaoxUB2T8HN7jcHPp/0WduQGqtp0u/mFcHW6erPxG2YSbRJaLZLxW1tnY6A9xLeWebnHpcSWkCqpGMJMxCPxCl32ARM4a+XpiZ/grOaikYn49bEJuyW7Ol3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2k6JmP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A476C4CEC3;
	Sun, 27 Oct 2024 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730070299;
	bh=KowpgPiqRL+54vb3w2Ko0hfBbmI2KvYVknTNhdZHnb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2k6JmP+vtZwqlryJO4KLHcOwog7LvL756TQy370REkuEpJfXcFTZ3e5lB4XjeWso
	 0YyTpQYVIA/dr+u55vvbGqf86KjDffzIj9CBWZxqRHOOATo3i0I5O8LKvoYuT3SfqU
	 ZcTAZD33LPosxfgzQDwPYpqAr1joYk4oUzYfW4xjjZYDbVpfZRfXua2Hq/Oisbg4l7
	 PY/bAtk7Yp0OzbnuG9lOjs7SvX3RIySKkyG0NGCDBDAtLm4e/C6Hrgew5qhaKxB7gJ
	 MvkhMo194nztZxXHDHRBWHVaGyCkNkNiNbHbBTwUfSaMDKbUIqk1rz2Fblw3G42nrd
	 Hqmra7gRCCUXw==
Date: Sun, 27 Oct 2024 18:04:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: Re: [PATCH net-next v1 1/5] dt-bindings: net: dsa: ksz: add internal
 MDIO bus description
Message-ID: <173007028407.209560.16468395770101725747.robh@kernel.org>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-2-o.rempel@pengutronix.de>


On Sat, 26 Oct 2024 08:35:34 +0200, Oleksij Rempel wrote:
> Add description for the internal MDIO bus, including integrated PHY
> nodes, to ksz DSA bindings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


