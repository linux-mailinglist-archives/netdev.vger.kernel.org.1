Return-Path: <netdev+bounces-117048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809694C80E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25721F22074
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42768C1A;
	Fri,  9 Aug 2024 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz2Nwnvs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772148F49;
	Fri,  9 Aug 2024 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166991; cv=none; b=qi0+IJ4mrK7wAIjRU/m+mw0E/ja/FlyAuWo1XzZMGM9SSKvD9XDk+6cT3YSHFHTET6ycvwq4O4WJCoiyQj3hDUKZD2Psm/qN9qh1xwYPjPPPUwZosJVUzquxa08o7LoSZ4XB4p2IqS6UE1aYgAK00buV8M7U21167amwr0DynYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166991; c=relaxed/simple;
	bh=WpZAolvuAbbkHmlwrfLzGI6UGMpXjvkIIJmACSdZHOc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=OlzbFOXQ4k8zvHFpz/66tMHp04YqOCEAjDar8kE8DbL1yqHbTdGc58hQKp+gsPo8UUDbrAJ4yfOQ753JQWrjwJ1o6fivAOXi2v1AjdohB7RY1oPmyZhHmITCWOLdKMlKjNSB6ox7p6NoWzUb87rjne9zQX7cqdUIKZgDWa2a0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz2Nwnvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5B7C32782;
	Fri,  9 Aug 2024 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723166991;
	bh=WpZAolvuAbbkHmlwrfLzGI6UGMpXjvkIIJmACSdZHOc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uz2NwnvsTc3GcEEH02TxnR/VvdC/+ee5YneYtMZRmy+qx6nw+kDgqCwviy6SmxeNu
	 uqTV1R0olusPy11IbExGDKdN50247XHhrO7tNyuz85Wz0xLYWtOT62v66FP30i7JOS
	 H+LHChNTRA5qr6RL0I7z+BFFRv0CNSCKDF1jjp3vmb3P7xreUTlPsRVrhxGUIYz3G0
	 qZr0B0sARFyCRh82JyMnOOEUBeQKS+jLu47bGkiGALSraGtDqQUcjqiwb9FwgR0jr7
	 C4fxN3zJWqt13jCNRz8gsREftIiaICjaPxnsDWylCf2wprfAbfMSNVbt88e/J1Ub+1
	 cgoJi4Zp+ZEsw==
Date: Thu, 08 Aug 2024 19:29:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tristram.Ha@microchip.com
Cc: "David S. Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Woojung Huh <woojung.huh@microchip.com>, 
 Tristram Ha <tristram.ha@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
 netdev@vger.kernel.org, Marek Vasut <marex@denx.de>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com, 
 Florian Fainelli <f.fainelli@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <20240809004310.239242-2-Tristram.Ha@microchip.com>
References: <20240809004310.239242-1-Tristram.Ha@microchip.com>
 <20240809004310.239242-2-Tristram.Ha@microchip.com>
Message-Id: <172316698916.2542023.14755989610157748245.robh@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support


On Thu, 08 Aug 2024 17:43:09 -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
> KSZ8863, so it shares some registers and functions in those switches.
> KSZ8895 has 5 ports and so is more similar to KSZ8795.
> 
> KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
> while port 5 remains as a host port.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:24:26: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240809004310.239242-2-Tristram.Ha@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


