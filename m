Return-Path: <netdev+bounces-221068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3EB4A141
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538AD4E763E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E342264A3;
	Tue,  9 Sep 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq7wjSgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643781DF738;
	Tue,  9 Sep 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396063; cv=none; b=OwqwS+dH/5nOLbO6Tw2dtsDl50XwvKsbJtX5lqiR1ZVylD/gQRqbThO5PfB6OFvJTpGLd+4s5E7dFdY7XyHbp1ceTEC535PmfID+CR9wagDTjTPCOoVMAphlKEzt7RugjkLgr7SNkWyB8+8LWAXrS3NqHGEUxqTU8P4L6QIRC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396063; c=relaxed/simple;
	bh=7L3Kwcvnd7kUCdkPXU70YXj1QbDevHKc2/sNeOjfBiA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SMATlMCujp9TQOw/+rIlKXfB5K0HU7jHYWvjPCjP29tD6M8LbydtRSSDjX6AEWQjpxpcNCu02txPLDkV45QoJ2grdGEwHSNsSB2mPthrGYI40XlZGlv5t2ddnxrHmuzXVgeca/pVexx0ame0I6oRNxGrDxmEbofGVy6kIAZwOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq7wjSgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1E7C4CEF4;
	Tue,  9 Sep 2025 05:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757396063;
	bh=7L3Kwcvnd7kUCdkPXU70YXj1QbDevHKc2/sNeOjfBiA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iq7wjSgHT19iuUUhClv6rXJU8O9nWpBt6pRiTw38JoT7CuSYjBRk3tTNeh/j7kQhm
	 s/hy82cdglOlaZ2eYRZCQTGxzyCM96Adx2cOQrTE1Nsx/Doo9f0/BbpAllh+hBfa0H
	 JbklCqFNgTag/HcJCj6Yb/o78MV3h2s+xUgL5LJWYuu0dtx+J4pe9kJW9P6JbaTDBF
	 zDcTJtTMci1CElTFLhzSorVf7RkTNGRQYc+rZ4EK3ZzjmfDFGvG3NS0OukvbJ37SFb
	 az6LZAo7BD7nsJ547/Zfy5TnoxUezKzN0o3iCnccr7070NUeW5MVkIeBeRLavdmFUk
	 TmPbvAtJ0+58A==
From: Srinivas Kandagatla <srini@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
Subject: Re: (subset) [net-next PATCH v16 00/10] net: dsa: Add Airoha
 AN8855 support
Message-Id: <175739605846.61348.16310568813041047278.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 06:34:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 09 Sep 2025 02:43:31 +0200, Christian Marangi wrote:
> This series add the initial support for the Airoha AN8855 Switch.
> 
> It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.
> 
> This is starting to get in the wild and there are already some router
> having this switch chip.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
        commit: 04b74f665961599e807b24af28099a29d691b18c
[05/10] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
        commit: 1c633b4b15aafbc8ffb2458b236d204c835cff39

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


