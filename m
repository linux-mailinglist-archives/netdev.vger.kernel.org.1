Return-Path: <netdev+bounces-284751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPrzDND6+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:24:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BDA4D7CF4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9604307AE45
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146263E274C;
	Wed,  6 May 2026 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESpEGV3s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363B36C5BB;
	Wed,  6 May 2026 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055662; cv=none; b=j4EIHPT3UGOORip8g8fBwyABGetvV6u55ZAiGWHm68jcTOWg/ilkNFNTS/iXCzSG6wcYDCGjkN5QCynn4cdgdo3R1vpz6f0e1kEsbea7M4Cip8KPr7va0E08gPvmF0FgKvP/lDlmtve/f7A/3l8SKpfATirjLVg+Xp4NVpcAmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055662; c=relaxed/simple;
	bh=G1nVPYRfl6s8rD9Wrm6hHq/1ImKn9a5LDjyEKm+0qkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsTO2ZU3ANc3JojKCXxSUICgjBoFYaCThnz4GonLkPMh/McJyFFmezpQF+YBJtJDuanLMWxaS0XDzAkcS8a1KZWq0aaL8VPulAb3YD52kJFk+Hf05rW34eCvbHiy9+FHccNUWTDlrsQqxRdpwcnuOjNd6vApR/OyLXP63i1SYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESpEGV3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B1EC2BCB8;
	Wed,  6 May 2026 08:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778055661;
	bh=G1nVPYRfl6s8rD9Wrm6hHq/1ImKn9a5LDjyEKm+0qkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESpEGV3sw6prPOvy2VWzP2bLdVwqTlr5OWx8qdIwByo7yhbxrrsvCCjmqkTbU5db9
	 CZlKMy7AcOBMw5QcTF+9XgT8ITvbXb+72MvRd69deR16tnWGRYHHbcrDPdeALjveGV
	 VJauU8nkLmsSMZMO03dHZZ2QFWZNoUnPK4cg56DEgyofaEezyXTlriqu8zD41rKIsZ
	 K/HRm+pI6FepSutdc21blOfSf47T8SO1WDavdxp8G8z4E7ZKbuBgbaCmmXYRiusdo/
	 7+jml5OFxEn13NSrenxNNBQv63/XpaUHUow8oI3Ss8KNJRgjPE927GREcY2M4r7mrD
	 YsO17ezTXEOFw==
Date: Wed, 6 May 2026 10:20:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
 ADIN1140
Message-ID: <20260506-important-simple-crayfish-6897fd@quoll>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
X-Rspamd-Queue-Id: 96BDA4D7CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,bootlin.com:url]

On Sun, May 03, 2026 at 02:24:54AM +0300, Ciprian Regus wrote:
> Add DT bindings for the ADIN1140 10BASE-T1S MACPHY. Update the
> MAINTAINERS entry to include the bindings file as well.

Beside other review, two things since I expect a v2 anyway:

A nit, subject: drop second/last, redundant "bindings for the". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>  .../devicetree/bindings/net/adi,adin1140.yaml      | 69 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin1140.yaml b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
> new file mode 100644
> index 000000000000..26cd40d36f9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/adi,adin1140.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADI ADIN1140 10BASE-T1S MAC-PHY
> +
> +maintainers:
> +  - Ciprian Regus <ciprian.regus@analog.com>
> +
> +description: |
> +  The ADIN1140 (also called AD3306) is a low power single port
> +  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
> +  and all the associated analog circuitry.
> +  The device implements the Open Alliance TC6 10BASE-T1x MAC-PHY
> +  Serial Interface specification and is compliant with the
> +  IEEE 802.3cg-2019 Ethernet standard for 10 Mbps single pair
> +  Ethernet (SPE). The device has a 4-wire SPI interface for
> +  communication between the MAC and host processor.
> +
> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adin1140
> +      - adi,ad3306

I guess reversed order as numbers are before letters in most sorting.


Best regards,
Krzysztof


