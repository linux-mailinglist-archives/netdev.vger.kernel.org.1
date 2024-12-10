Return-Path: <netdev+bounces-150571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11099EAB1E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FB11889563
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E635230D08;
	Tue, 10 Dec 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMJimCVw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A062309A7;
	Tue, 10 Dec 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820950; cv=none; b=JaDTwNWQWCJ709XsfVoGr3QLEXu3z8ARQkvuLt44tERMFlOhoYM7lOw+1PzudPD9vQDZ7oFUvTqzOAP5/vefinDa3iAw74X8tbpkXnJgV2mLMkQxIfyHO1S8S1qGWEPPEv0FwdJyxsGMuvCck8TgIA6alaX2kojfn2KklQmnM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820950; c=relaxed/simple;
	bh=gw1Ki9tOSz/6K2XiNToVAsaBw9K+65jKOt8YfYBIqes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmIjKk6+YlO9cYoZTiph0ryUOsJxIoVl3Ro7lvO6bK5d/42GQM77v12NwkaLTCFc/pdDUL2uCw+vnb3qYR7iVt+m8wfyjgxnk8kYzig/WtX/8ecvlgdUc52f4bgG0PCBJ2YwD6gzFdjeeECCXzzAC8p8UVxUV7JjnMVKP+DMadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMJimCVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8418C4CED6;
	Tue, 10 Dec 2024 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733820949;
	bh=gw1Ki9tOSz/6K2XiNToVAsaBw9K+65jKOt8YfYBIqes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMJimCVwxwJn65lxmQON5iGxkTGy2uI85uJRw2p2XnPuwU2bkmNOc9jExbwtRph5m
	 88Sik+uW3O/2sGHlVzs/NVhOpcB6xgjVR1zNRQYdrsvxiGBqywRIB8cFasQpRF7z4Y
	 iEyEjDjGezRNr5nrpca9JgBhMHqOmZfg85RtQrruYZvtN6zpkvgtvIk96dU/Y32yGV
	 ZAcYuQoo18nDsYGt2Kc2cQ2VEGLMoaTP67Clsx9rSsOoeXmkMTZDYZ22icPpDh6icC
	 JxgCxMOcwParI+8sEAB30l6N216+vHA3svxSVHFvuHMQvF4GRqDGU2WL/VebrXoFsX
	 uodrAJywpma8A==
Date: Tue, 10 Dec 2024 09:55:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: stm32: Add Priva E-Measuringbox
 board
Message-ID: <kybhaanlgznymzbqw3dhykt7rhdr3dehyib7l6lghsbhsnsvtr@rlsvk3zdzbks>
References: <20241209103434.359522-1-o.rempel@pengutronix.de>
 <20241209103434.359522-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209103434.359522-3-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 11:34:32AM +0100, Oleksij Rempel wrote:
> Add support for the Priva E-Measuringbox ('pri,prihmb') board based on
> the ST STM32MP133 SoC to the STM32 devicetree bindings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


