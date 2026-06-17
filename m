Return-Path: <netdev+bounces-300206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /IsvNsbOMmrp5gUAu9opvQ
	(envelope-from <netdev+bounces-300206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA869B764
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j8TUZfJX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300206-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300206-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E610304A67B
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9A480DE0;
	Wed, 17 Jun 2026 16:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55A478E36
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 16:43:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714628; cv=none; b=uVMmwq7HbfmZPJvIoKIqtPNg44gymOVpk/EvBMyZB2uo0iMy8/b/lwuLG8QMoWG2nnuxzZ/AptJJed/1Jz/K3mTMl5NhuCcUA5SH6ki0Db2FdWJnjtuWyMzDz7Tn9DAODKoROJzFiMoSRWxUQOCGlFyCWEi7ziKXFJWDqQxpdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714628; c=relaxed/simple;
	bh=D4YdmYqvXb/Xngj2moqIU1HFb/wEpXGadyA0iAx2G9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/ga2Bl+g7QiUxn0WtdRvNDu3+HEWd54bGDiojL44BllSbI+bzp9V/oIbcPLB4UnUb9S1N1BrRTOUC1JjoQMpWxCyZM5W2QuH7b8Sk0RB9m1qS6ZWl9HBbeMQCn+UWJW+GaPdqZ3gnHCM/pvy48N1Onqj1eUKPr+SWDarTzCX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8TUZfJX; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b7866869so61154905e9.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781714625; x=1782319425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91ni4OHOJEhYMTKX+2kMkaj6csE1qduQg5o/8P82bfQ=;
        b=j8TUZfJX+NeyknFnN7fOELfyvNORzV5Sa9Ymz3rOCf2taVXN3rCywu5llezyo5PYk7
         wzO5r0zHUKTZyXuYPWi3UAOn1jFPQ+bUZmDxeOmkuIYrLXRv4rSMLSGyuFeBMSbz93Uw
         Mtz16+ny3kmKfB4+zB85AQDiCABL8N5LnuhVpEQQBJg4kQobpI0VBrO98IdnFBOKOfT5
         L1E9XVkp9S86FUuFGFNeZSlq7K/t76XfYTo0EsGGtQk3jJQr7B240gx67TIaoljxVOjn
         udSolD/6XrkRYdjCDIweVVLKGRKb4tuzAmny0gBcJW6i5/pBUOTdpWfMl8CPx2lSKcUK
         mKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714625; x=1782319425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91ni4OHOJEhYMTKX+2kMkaj6csE1qduQg5o/8P82bfQ=;
        b=rD34sLpGldjyZ4qBbpcGVwvjtTUaaO/EuVhTMPCmLUjDs9tfJ/MM0dBEt1qs2bP5mM
         3jrSYLtOhh6Lcdyplul+mEYi2LBUpkd6KgmPneW0atWbozs+f/wIEpBCefTI4umDRhbz
         tNbvuWvPzD9ymwRiMt7xeUyBLd6ez5Bl9dZCgrhAuMQgSUr5x183Meuf+ZBq4is9Xn4+
         KU8BIRqxU9V5QnCABIeoDPdZ94RGZpAudsCrdoecl0bm+V7rhjbDG0Iv9EuV+HA4XOYF
         lubOzkioQ1/zUktYgTywvXxUAfytYxZYMoyza6KusJy7qoA3fHFN2JHvEbnvnYGn1B9k
         c0zg==
X-Forwarded-Encrypted: i=1; AFNElJ/rcUnQEHGluUeeALXIyKPNVaoOCeHNfMVml4+/QZlR870HWoySN0oVgNcOPdnBqOzyO/M7cjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sa1Dh0lvbLGW+WZmMSxO61kLkJMYX461hEd95K1waSQirtzh
	kleKcEonuQ85YswtN+fHhxGSYOCTJzuSm0umbBwntYkQm1FGldYhGJNZ
X-Gm-Gg: Acq92OEqzfIdFF9UJr6YRDpiwcAepjaU82qGv4osQ7vG7jJCGk9s48T72GX1GwVEOnE
	JqRUBdLgahw+7kO3vyQhKeXyvDcxcj4UItit19/SeVAbRFABb1KnuCMvqV6siN3anK6c3DB/V4z
	N/DBPJpCfrfkPA1X9GOwTn5O7Hpbi4/ZLtbfghC09IzXKRGre6Nc7ps9KItLBvpnYtXmqtbWQGa
	fGaG35k+bCgs6PlBuAxD+QOZ1iBZJ+VYGSHg/VxPkLsD247b3DuLcfCynqlyItOFX7Ys+H2ie0V
	DHHO60noY4ZwnHslCAQ1rgMZUDRxY4ZmuguArjdpz572OKxcVWmoyTjIMSTU+m8Oi5JuNc+NDqX
	vmq4abc4utX3mMlDUDthRSDbijiFyITs1j6XQN3XE7HgY/DBVLUmysXKAE57uMEVmf7UNRl5JYf
	Xqr1UAIvpBgaD8bROIxLGdO2avZ1Sl/OWbalHCGd0TUemAoho1J4ovwYm2JuiTFDDIDoyoFnLEQ
	ZTowGdZGbgpimXb5LE8UzgjVAPhBxQXd5Kmc+RkSVK8/gDgzIGeYsY=
X-Received: by 2002:a05:600c:a15:b0:491:91cc:d12d with SMTP id 5b1f17b1804b1-49234131f7dmr59507685e9.25.1781714625451;
        Wed, 17 Jun 2026 09:43:45 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:8700:58d1:af07:762f:9d17? (p200300ea8f4a870058d1af07762f9d17.dip0.t-ipconnect.de. [2003:ea:8f4a:8700:58d1:af07:762f:9d17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm156440695e9.9.2026.06.17.09.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:43:44 -0700 (PDT)
Message-ID: <876a38f8-75ea-4b32-bb65-216cb3adb436@gmail.com>
Date: Wed, 17 Jun 2026 18:43:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: net: add Realtek RTL8125 PCIe
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
References: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
 <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-1-2bd38922d129@pardini.net>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-1-2bd38922d129@pardini.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-300206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ricardo@pardini.net,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EFA869B764

On 17.06.2026 14:58, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
> controller.
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
>  .../devicetree/bindings/net/realtek,rtl8125.yaml   | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
> new file mode 100644
> index 0000000000000..eee13fbc1e6a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/realtek,rtl8125.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek RTL8125 2.5 Gigabit PCIe Ethernet Controller
> +
> +maintainers:
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +description:
> +  The Realtek RTL8125 is a 2.5GBASE-T Ethernet controller with a PCIe host
> +  interface.
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: pci10ec,8125

IIRC we came to the conclusion that the compatible string isn't used in the
relevant code path. Then why add it here? Is there an alignment on this?
If it should be added here, then an explaining comment would be helpful.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
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
> index c8d4b913f26c1..e5fbd82946aec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -134,6 +134,7 @@ M:	Heiner Kallweit <hkallweit1@gmail.com>
>  M:	nic_swsd@realtek.com
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
>  F:	drivers/net/ethernet/realtek/r8169*
>  
>  8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
> 


