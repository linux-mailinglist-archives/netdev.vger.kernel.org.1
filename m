Return-Path: <netdev+bounces-249849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC766D1F49B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24E573040206
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79E2C027A;
	Wed, 14 Jan 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8EystbP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7682BDC02;
	Wed, 14 Jan 2026 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399326; cv=none; b=j4xFVdbb0hAq6/Qdq482C0GxbvMQCjrd8zDEG9E4hjddi8Ns50jfWbG04BGrtsqTaaX+LthEpqyHTArkERwFtKebOKWwmA4xhXZ/aM2o7RKfCfi4COatTSaV1QYfA99RVOP4nLavqoJKOKT4YM9eFFEFckuAqFIxQz84dRvR1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399326; c=relaxed/simple;
	bh=haCM6T+YzB8uXZZd8uUQUcECd5pePHN87zdScN5Eg9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SDlrKt31Kca3xnP4XFbw7uHgxhJy0VvWwdszG0QoyZp+O8UfHFXqzKG2OKcolmSgjq8VqS+t/0Sy/cSmu55EflLlllY8O6+wipKB1mAxf6ALMuP6YLjBmE9fgVddkKLgEknqskWCWLBilxSVIl22+ZnBVZx0v375/A3cIKF4G7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8EystbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1352C2BC86;
	Wed, 14 Jan 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768399325;
	bh=haCM6T+YzB8uXZZd8uUQUcECd5pePHN87zdScN5Eg9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M8EystbPzjf3hIbat0l79Q5+uB24T3/rSm58fwr9j9jsIzZ6HHh1yxy06+ycFdWzA
	 kCQ/MsWRHRVcN9TXxklMfR/x8Gk1woAJjz6RiF50A5XDghuMMg7BczGpkZ01mlMkeB
	 g5um/0dqrqfSquRa4qmC5hiqJhsuVU9WMvitJ2M1N6PNGw1Un8+te/jW4S3aatLO8Z
	 kkE/AwbTuxO/UzQVfVgNXt56CiAQLxiqLQfvk/vFy/Bid+4YUXdVf3S6I9vRQCiADp
	 FNOY60maEkzw6Ms0vCj/ulWN2D6c4GcZWL99ODS+so9OJciWAK+JmthSByE0ctjfYo
	 WvWwYUk6P2leQ==
From: Vinod Koul <vkoul@kernel.org>
To: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-phy@lists.infradead.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eric Woudstra <ericwouds@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Lee Jones <lee@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Subject: Re: (subset) [PATCH v3 net-next 00/10] PHY polarity inversion via
 generic device tree properties
Message-Id: <176839931828.937923.5236613118963138163.b4-ty@kernel.org>
Date: Wed, 14 Jan 2026 19:31:58 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 11 Jan 2026 11:39:29 +0200, Vladimir Oltean wrote:
> Introduce "rx-polarity" and "tx-polarity" device tree properties.
> Convert two existing networking use cases - the EN8811H Ethernet PHY and
> the Mediatek LynxI PCS.
> 
> Requested merge strategy:
> Patches 1-5 through linux-phy
> linux-phy provides stable branch or tag to netdev
> patches 6-10 through netdev
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: phy: rename transmit-amplitude.yaml to phy-common-props.yaml
        commit: b7b4dcd96e3dfbb955d152c9ce4b490498b0f4b4
[02/10] dt-bindings: phy-common-props: create a reusable "protocol-names" definition
        commit: 33c79865c7d3cc84705ed133c101794902e60269
[03/10] dt-bindings: phy-common-props: ensure protocol-names are unique
        commit: 01fc2215940c20bbb22fa196a331ec9d50e45452
[04/10] dt-bindings: phy-common-props: RX and TX lane polarity inversion
        commit: fceb17ac05e772ffc82f1f008e876bf7752f0576
[05/10] phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
        commit: e7556b59ba65179612bce3fa56bb53d1b4fb20db

Best regards,
-- 
~Vinod



