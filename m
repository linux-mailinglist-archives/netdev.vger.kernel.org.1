Return-Path: <netdev+bounces-295884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l33sHbLzImqpfgEAu9opvQ
	(envelope-from <netdev+bounces-295884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:05:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9764994A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:05:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RreD1ojS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295884-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295884-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB162306402A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320D39C63D;
	Fri,  5 Jun 2026 15:48:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D13806C0
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674489; cv=none; b=cCbB8YrUtRhIUITM7O1Uz7FyGIxeDRsekGVnGUomHhrcSsoPru+OipmPAaPAmOzE60nFtw9evjvgLr3fZ4TjEItGadAr6TzYbTW2ZW8SuOpCK6oL4CNycSpHD6s5m7vZNS+xqOU3PQF1Bz721m1TYPoZwJTFO29y6OxvszVcoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674489; c=relaxed/simple;
	bh=+Zytpm9FXTTuYrQ6mlBrz/G+YKHNBxOZR5sKcsiQPHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMh7r6XHiJL1iwaSm4X1sg39YHJH0H7/L1IxKuRKSGoxnsg52yKEYT17A+uASRd++HhcmO1OO1pvJ1JNgeD7ulYr4Zp1PbLmkRhStFMdJSlZE4XU+/2f4f1FANl8+dOkTtI/UDNPNjw7BATFhAFM0mH7FE2qUA1Jr3CEEMVU02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RreD1ojS; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4601949975dso352936f8f.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674486; x=1781279286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YIe9PJTXxBHQ0XX31cWOxKtFhK/4Vta8bzAs10DDqbM=;
        b=RreD1ojSSvFRxLANmDwpf73LEaNmskuGnORFmXWq/K39Nqhn4H5NLwHHhyg/NGgwCE
         8kioymVffyFHJssUZVmaGG1B5gWHuvzdiOKfnk/wLXhib9QIxnnUAhVesvSGBbp32oiG
         jtMeDVlm91hQ8i0+wmoN5EtcqvDUcrmFHuMqEFP95HvHAY6g276aZPnIx/Kr47vICIss
         7kp5QPj/EndCJHfR3xtqWJw+1Y3GpoBouOXFHzG+p9sdklzt2V/696G8kso71WeziGvg
         +Vl0DfqTzA/8Mc7msouSI0Cgf0xs9YvFXoxlK3IlsjVQueewCOL8vnPGg13FS6DNu+kT
         wzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674486; x=1781279286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIe9PJTXxBHQ0XX31cWOxKtFhK/4Vta8bzAs10DDqbM=;
        b=kR0oVdGkOVBEl/AZfJ5x1ICd6qpZaIXj+Y9ls37DriUvjBMnmLE8FxWOvMWDMrsix/
         uP5p+lQCpCkuFw3BZ9cxDxhh04IU8zhIzmws600j/yOJF2ETPp1pxHMih5plwWKuo5b0
         eOySNTUA0WV1tOdKOPpVEiMVyd7ERD0TVmq/QQTx+mCK2tAcKW0iqtrT14vA7DJzV0nt
         OAun4khS0P/wvD05D85H44lG8+HAicmAQcwk3JUfEAkB7A71PQ0CMpr33+g9vStxEqHQ
         ypr2SJb9x/wumhC6O5LrTfOonnum0RcWYHgjFPEx6bPiROgCuTkCkFIvGjjR1PCLeIrn
         FEcw==
X-Forwarded-Encrypted: i=1; AFNElJ8Kl8BiGvPZcNBA4QMtjed4hxz3aX4ABlf89LqJ/mDuSdoBDYibvTw494NTcUaimFLUmGkZbFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKLZwBsi5tJwzSAicpPEf9iMJCQcyeOwhvbBfdDFeomRzYbi8
	YsDTXjjwrqSLcNUsrRWQXG0T8fXICkVobL7Gsv7CHKFcb5mLWd5Z9KIk
X-Gm-Gg: Acq92OHYxGNIucUuOUVfP4eFNJOeBlMirajUlVsE+yb7KE6baK+3rltWk3d8KaPSn5h
	ohvi4KBlVg8TGx8RwOg+IP5/1HGTRD+vCqXqtFRns0j04UK5kE2B/5a1s+RMadMqGc2b70XhsGp
	m43wGl6q0cqpaT9tL27GvjwNCpVwujt4lqnspnw+0jDwBL8NLQzIbEYiPz4GlvROuttNUYo/DVg
	GhRaK92BpX7HTQv1ZQ8wDxyuN7NcQkEcghHGBuuBnqrlslZCPnfwsa/mx3+7dqk9uPTpGxYZJ0d
	Wp/JYOu5nJtK+M9rF00hVBWOj2+EYFrkSS+ce+sup1IJtqQ9wm9YtZJmVCKrLim6F1NeGYRBNSu
	NsJx2R5RTmuKlPMtuMjC+URMTZEf+2IQ6xsQJK3PO3RL/6uKVZ3tBUMoqfJmiZt9I67hSlyC6Yy
	qc5B7hcD3KHo6+NQzsM8fFTEBsAS9iIcMGZ56/DHtZh3WmoYVXOWj+Yat7iKbuniTgLEHrce2tz
	lIVtYkMhMBaCe7EubkXlKd+xALqtLyB19hJaO3XH9NaA9SSBniVokWQ5qRhRrTmfVXhDa9Wel9d
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id ffacd0b85a97d-46030631ba3mr5236539f8f.35.1780674485919;
        Fri, 05 Jun 2026 08:48:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f14:5400:d967:4840:e11f:4ad4? (p200300ea8f145400d9674840e11f4ad4.dip0.t-ipconnect.de. [2003:ea:8f14:5400:d967:4840:e11f:4ad4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm27730653f8f.4.2026.06.05.08.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:48:05 -0700 (PDT)
Message-ID: <b7cc8eba-ff6e-417d-8e74-b3bb24e08a26@gmail.com>
Date: Fri, 5 Jun 2026 17:48:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: add Realtek r8169 family PCIe
 Ethernet
To: ricardo@pardini.net, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
 <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-295884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ricardo@pardini.net,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,collabora.com:email,pardini.net:email,realtek.com:email,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EF9764994A

On 05.06.2026 13:49, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
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

The of node seems to be created by of_pci_make_dev_node(). But this
function is called for bridges only in pci_bus_add_device().
So where is the node created in your case? Did you test node creation?

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
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/realtek,r8169.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek r8169 family PCIe Ethernet Controllers
> +
> +maintainers:
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +description:
> +  PCI function node properties for fixed/soldered Realtek Ethernet
> +  controllers driven by the r8169 driver.
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

This list reflects just some of the PCI id's handled by r8169.
Any specific reason for this exact selection?

> +
> +  reg:
> +    maxItems: 1
> +
> +  local-mac-address: true
> +  mac-address: true
> +  nvmem-cells: true
> +  nvmem-cell-names: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet@0,0 {
> +            compatible = "pci10ec,8125";
> +            reg = <0x10000 0 0 0 0>;
> +            local-mac-address = [00 00 00 00 00 00];
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b539be153f6a4..6341de4fadb6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -134,6 +134,7 @@ M:	Heiner Kallweit <hkallweit1@gmail.com>
>  M:	nic_swsd@realtek.com
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/realtek,r8169.yaml
>  F:	drivers/net/ethernet/realtek/r8169*
>  
>  8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
> 


