Return-Path: <netdev+bounces-296406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SupHDER2JmpVWwIAu9opvQ
	(envelope-from <netdev+bounces-296406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F311653C24
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hT/m1biD";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296406-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296406-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0673004D09
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA6399365;
	Mon,  8 Jun 2026 07:58:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AE3955C6;
	Mon,  8 Jun 2026 07:58:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905483; cv=none; b=a5ijSn0cKbF0kM3qaoRC7hvneQSf7oNEwxLmAq47teBc7eW4iS+fCIHKgpFFPQc5v4hTis2jXANBfryqXS9zdkSW1Y8VnmnQp/1XzclhJAYyojz03fyCJxs1HnbuqtSO8dac5An/F3As/OZBn7Z/DWB0CEzsfJcCu22VlD9GpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905483; c=relaxed/simple;
	bh=rTqCYyaCkrZimhRY3+r90HkswJnvOuNoCop1+yjfzTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5o/7wYboBBm5UvF0TZMpSXUh5b3gbWnuRoneLQLErSSXoccw/omDYYJ/hoCrJzWiyZmypoWUX4VPKODxzthZgJ5ad4MSYO2Jeo6vbtwVZ2s1eYwI0nQnuiAV5AOh3tVWlsQYt9TjQw4csFgKfwbE/DojaAmwy9ZtTdvIVlK75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT/m1biD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BDF1F00893;
	Mon,  8 Jun 2026 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780905482;
	bh=2c67zNsS0HvgzZNh71DbxgcmS8tcATdydWycpSmMb/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hT/m1biDqcx4HHvNJoG2hykcnOUtT84VJfuAbUwLAIKu4Hnk+ZXo5P2QkdZjY2wXJ
	 LdNNSwOMzQPatplpQzEha26AG7OPbQVz3klo+T5aEl0HwCxAddaCbz5ZRIfKNxWzWz
	 0vFCGwQAfOg8jMP1XJXLNMehOB7TVWR2I+ND/wvs8voq9X0rTemT/UcfmaEzCpggbT
	 ke4FGNYQv+Slne1BYStrCVIXlSI/HB0utqa8HXEaYSjB8gMD0B52zJEKzgRj9Lrrvr
	 CvB3tA/oX8qHrsCCqC/hu4kEihVSQ4qi0YlZmRTVFoGqGs0eZ8i73O1P83/zNi0U/q
	 hlCpcmnqLyiDA==
Date: Mon, 8 Jun 2026 09:57:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ricardo Pardini <ricardo@pardini.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: net: add Realtek r8169 family PCIe
 Ethernet
Message-ID: <20260608-armored-ultra-uakari-ef1d77@quoll>
References: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
 <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296406-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ricardo@pardini.net,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,sntech.de,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F311653C24

On Fri, Jun 05, 2026 at 01:49:08PM +0200, Ricardo Pardini wrote:
> Add a binding for fixed/soldered Realtek PCIe Ethernet controllers
> driven by the r8169 driver (RTL8125/8126/8127/8168 and variants).
> 
> The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
> spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
> need a binding when used in a board DT - analogous to "usbVVVV,PPPP"
> compatibles documented in their own bindings (e.g. microchip,lan95xx)
> so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
> these PCI function nodes can be validated.
> 
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> ---
>  .../devicetree/bindings/net/realtek,r8169.yaml     | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,r8169.yaml b/Documentation/devicetree/bindings/net/realtek,r8169.yaml
> new file mode 100644
> index 0000000000000..6923211ff4c93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek,r8169.yaml

r8169 but no r8169 devices at all. This must match the device name, so
most likely:

realtek,rtl8168.yaml


> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/realtek,r8169.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek r8169 family PCIe Ethernet Controllers

rtl8169? 8168? There is no r8169, is there?

> +
> +maintainers:
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +description:
> +  PCI function node properties for fixed/soldered Realtek Ethernet
> +  controllers driven by the r8169 driver.

Describe hardware, not drivers.


> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci10ec,8125  # RTL8125 2.5GbE
> +      - pci10ec,8126  # RTL8126 5GbE
> +      - pci10ec,8127  # RTL8127
> +      - pci10ec,8161  # RTL8168 variant
> +      - pci10ec,8162  # RTL8168 variant
> +      - pci10ec,8168  # RTL8168/8111 GbE
> +
> +  reg:
> +    maxItems: 1
> +
> +  local-mac-address: true
> +  mac-address: true
> +  nvmem-cells: true
> +  nvmem-cell-names: true

Drop all above

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

uneavaluatedProperties instead

Best regards,
Krzysztof


