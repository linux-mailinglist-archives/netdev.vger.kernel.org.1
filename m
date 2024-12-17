Return-Path: <netdev+bounces-152601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFCC9F4C5E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56DB1895C22
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3B1F3D45;
	Tue, 17 Dec 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyi0Dl5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DB16ABC6;
	Tue, 17 Dec 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442114; cv=none; b=q+w/zpcr4suDnlgoBxvCF3Em8TTh0o7S4GNFSWjcHYW1JqaVOOiBh9cfN3pJxwPJNQRqHw5DKzGDFFsILWeXtg4J7qsmX1cG6EHHLYsva2gutqMVMmnleqmDUWpypx4kJgxz7iUWN7PhbFul1/FgHte1DwlBJNzrVbk0cMkUDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442114; c=relaxed/simple;
	bh=soBEwUKp/TZ/473ZrdtHyQgtSVUCeX0FYO1MpzpREcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvimk0uVSqU4rH9U8PZjxe8KVUIiViAgIfCEJkZUHSI/nUqu7KUqy/Vg0jJQoOII/8mYa/tGQURC2GSuCkZtHLS/1QGSDFCVmA9mG9zRZzQIHzVADOaaKeW+KdQwWs7pl2DclzjX44Cmd8Owhej1AmZ8wsgkyEOYviZ5mO6aCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyi0Dl5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E987C4CED4;
	Tue, 17 Dec 2024 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734442114;
	bh=soBEwUKp/TZ/473ZrdtHyQgtSVUCeX0FYO1MpzpREcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyi0Dl5bg4YLGUgPvCnQwA1Obu/Zx5FvkT/OvNER7yr+lDynNdVytwWprQF8YWUVT
	 t+f+OANp2f1mOniOhEmLvLeT9Z7PDmeSkdZutOTayk6wIM6HNTsCHi3LV/EUDsNsfM
	 O6dbG/TONO/l5cdwcqVufr/GWPQWxQScnNX8sJubsWGjq41fhswFbtk0wt0XEme5eL
	 2KFNZFgG17iq4ywH+hDfy9Cx1zVgFnnpV8YoXTjMAVdeEu4T/ICfvWIa08QMROajiK
	 0vFVWkdINm8BkJO+DaVWgk5tD5RfyLBIuNOp1V+NsMhtc057qd0wwcjVfsw7xEYL4g
	 acjfey0V6nz9w==
Date: Tue, 17 Dec 2024 07:28:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Lee Jones <lee@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>, upstream@airoha.com,
	devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-mediatek@lists.infradead.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [net-next PATCH v11 2/9] dt-bindings: net: Document support for
 Airoha AN8855 Switch Virtual MDIO
Message-ID: <173444211136.1418557.12469782801691992405.robh@kernel.org>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-3-ansuelsmth@gmail.com>


On Mon, 09 Dec 2024 14:44:19 +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Virtual MDIO Passtrough. This is needed
> as AN8855 require special handling as the same address on the MDIO bus is
> shared for both Switch and PHY and special handling for the page
> configuration is needed to switch accessing to Switch address space
> or PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/airoha,an8855-mdio.yaml      | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


