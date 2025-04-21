Return-Path: <netdev+bounces-184428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F7A95616
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3F51895B9B
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0731E9B08;
	Mon, 21 Apr 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfYpWkIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929F17BB6;
	Mon, 21 Apr 2025 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261051; cv=none; b=LhMsvA/0eWRRAsOnsJYx+eqTyqCXDzbrTZPiY+47/E3NJMs6CMkPlEsDr8VTFBQKbnH4vYzbdab5ew8VmaHXMhBxyQGAKeCM2lFEpgcpoeti/o2fkacHK+HXDYciuC4lNGouVdPoQy59KaHB+x9LZ+wuX4N2vilTVBioYXoyr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261051; c=relaxed/simple;
	bh=glKxkR8m972JoWcWuCrVHoKgArMLNJLU61ANVLN9g74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OinaEO4yieBBy6Ny6S5uXh2Onz3Pu9zhsbcflJ/JqDBpAYt1VkNbyXn3IHAKblkS4/jQUmqeBYFdBw6HYpqLigP6axiY9uN+fE1HigGgIKaXi5DB2jDe6+O7eaZU4pTc5dfHL9D5zdlViC5SY3P81JEOy6a9Zu4ln5VAqOsjQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfYpWkIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCC4C4CEE4;
	Mon, 21 Apr 2025 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261048;
	bh=glKxkR8m972JoWcWuCrVHoKgArMLNJLU61ANVLN9g74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfYpWkIVu1Cn7rJAIR75DsqAt70re7nvWNCC1UutlV+of/OqT0NhP7NN8/p3LYIPb
	 7GDOd2NuEGYVHM1+EEzo1ZwyI2jWX2OS9GjBi4QUFqHCAWIEyUYvwyjJetzdpU09Jz
	 P2H2RH7jCzSDOVIDTqQRRvr0TSbHty5Pru6ujpvQ6a0aKufg9hVLcEmai7lVmtRN4c
	 ojHv9wAXD1V59pRpJPNlssYaH2JIz2niS28r0PjAVarNsx2yb8Mh1SoR4k9YSPxDt9
	 gUKaNsQxoKHLkxIt1x6GyMTnmpaxl9yxed04TjSFppxU+xX24Io7LnJdZICi5YYbPN
	 eFG7/MfLOGxTA==
Date: Mon, 21 Apr 2025 13:44:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Nishanth Menon <nm@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-doc@vger.kernel.org,
	linux@ew.tq-group.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: ti: k3-am654-cpsw-nuss:
 update phy-mode in example
Message-ID: <174526104584.2601961.15778919146661291408.robh@kernel.org>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>


On Tue, 15 Apr 2025 12:18:02 +0200, Matthias Schiffer wrote:
> k3-am65-cpsw-nuss controllers have a fixed internal TX delay, so RXID
> mode is not actually possible and will result in a warning from the
> driver going forward.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


