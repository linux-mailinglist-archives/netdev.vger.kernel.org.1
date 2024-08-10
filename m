Return-Path: <netdev+bounces-117327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D09B94D95E
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 02:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1796283309
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB9DF49;
	Sat, 10 Aug 2024 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMHOAiaW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03D441F;
	Sat, 10 Aug 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249223; cv=none; b=IsULPL/fEcL1VsyWXfHAp526GAXp5+FJ/efQ6FciDxaYeJ54wSlOSN2kg4h8HL8xmDd7HzZzkg6YaJCZdUZZbNfLQb0XTt962Br52WB31I/HgMMvgUzDPM4IiUT7o0UemHMUnmWJ+4Mh2Uub9S0/+yx6oMt06qe/yuIFcYj3648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249223; c=relaxed/simple;
	bh=QO3u2CGmjXPMln6wADcUqf90kgfAOUK87AMIW5V9i4Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ij/QW7x1Mnsgm+QAx039s37DTX8VPwt/eRUCN2/6/qZoiXT2f9OVj2tYKbR9xSMJNE4qavrs6jsdwb2k9tv6R7fueS/+UWqTUcUMgoSjrGE3ecdPfjrGG7o6Q23Diwz2eNHWWD6bQGHF8B3z/GWzGUHGUo7y3lbhqhbRZQSAIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMHOAiaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46CAC32782;
	Sat, 10 Aug 2024 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723249222;
	bh=QO3u2CGmjXPMln6wADcUqf90kgfAOUK87AMIW5V9i4Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uMHOAiaWm0jvw3WTfHVgmMTLu6fMqoM8lXDpSoiD8u1Moiva1r0soIMfeht8TkOIo
	 CMIeOIoUVyhkY4S8+vHqlbZ+GTJikJpmyEbkeOxqjBB14KWcK7aXSl1pz5rMLHJd2a
	 cV7cdyv1CgvxlIOv78sd7dqnqEh3kH/GABbIJged5GD1BSK1aHepIso04DEgWJQSKn
	 sn1woWoiJR0saSm5zYGZkNMKTzpC6HsoV0x6L+WmV0BWTn9FJEb1q8XbhEphSQ+ARi
	 /V0ozJlSUCqG506ijhsUYoGifvhObFCFb+qhspwhIMmXN1qYQH3zlWfWIs0dvI17st
	 YSImK2t2+oDNw==
Date: Fri, 09 Aug 2024 18:20:21 -0600
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
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
 UNGLinuxDriver@microchip.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
 Jakub Kicinski <kuba@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240809233840.59953-2-Tristram.Ha@microchip.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
Message-Id: <172324922165.2057557.834820350130126130.robh@kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add
 SGMII port support to KSZ9477 switch


On Fri, 09 Aug 2024 16:38:37 -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> 
> SFP is typically used so the default is 1.  The driver can detect
> 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> has to be explicitly set to 0 as driver cannot detect that
> configuration.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/microchip,ksz.example.dtb: switch@0: Unevaluated properties are not allowed ('sgmii-mode' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240809233840.59953-2-Tristram.Ha@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


