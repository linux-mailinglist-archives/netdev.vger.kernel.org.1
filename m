Return-Path: <netdev+bounces-263715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ecY7HgEGqGmEnQAAu9opvQ
	(envelope-from <netdev+bounces-263715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:14:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CE1FE269
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25578301C5AB
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055F39D6CC;
	Wed,  4 Mar 2026 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/fv+zkY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21352372674
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619262; cv=none; b=LKRUTt1AwF3/mZBfjzfe6B3OEGQg5i8lP4C5hm2D1NSDJns6vezjQDKnvMg9Sd9lDoWwit2AMtQvrKV46tPlrRvMJ6iY8W/zuZGo3ETDvIZsLlI94T0gfAuBSmPQfqjhrbXFScSnWAgQmeO2MDTLeuK93QZUKDVYEStw7FkWvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619262; c=relaxed/simple;
	bh=7OLsM46dILzIKFo7Cs0Sje7dLaNFHpEAJy3wRh2pdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G05fC2zwD8jh40aG5+Zp2bolnQQhPlS8Zn9IY6hJOarKmKsROIN1hIO/4PbtSBTdroIma2v7zxwLud2o/H69L0Zd2i6k/WqB5kUq8JJBtc6+dLi7cUJbKHhh4bsIXpKBG+QbjJXUgBm8ywYgqx52RaLKshYedYI8PMoQXkS5VA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/fv+zkY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9BEEA4E42539;
	Wed,  4 Mar 2026 10:14:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F0655FF5C;
	Wed,  4 Mar 2026 10:14:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C169103685F1;
	Wed,  4 Mar 2026 11:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4UJB5Tef4Xa9EPz7ddJaJCyEjLF4LufxiJyl/vDD5jg=;
	b=B/fv+zkYhgUMX/YSdxnpxySN1eY9IVSqPBwvk+7Jk/y4L89Diiyi2gNmuiuUXZF8oG3ABu
	leSag3vgWeKHqqglNWPEKXKEg9IH5fvb2/msgpQpFXrLJ8ovugh7lSPdR+K+0p5iTBQgJb
	eCzNrv5jp7cWDwefB+fsTevUgg6VCM91lIzD0AnmDzXQaQ3myCErTR9oF0kDmMO1N3NFOD
	MKowduDmUe3FsOat4B0Z1uB6evRtNc3y2JcqKXA0IbP3rVUMdr27mRABfMnQzdb1AxKbVm
	CadNpF57ZMKmEwa0MvO/Z+pPe6kJyIK6ufJFtAJe2lD4vj2PvsUfPYVAM1M5Bg==
Message-ID: <4a073736-9caf-4973-b7ad-a482d63bb672@bootlin.com>
Date: Wed, 4 Mar 2026 11:14:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add support for Airoha
 AN8801/R GbE PHY
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
 <20260304-add-airoha-an8801-support-v1-1-0ae4ee5a2f9d@collabora.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260304-add-airoha-an8801-support-v1-1-0ae4ee5a2f9d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C79CE1FE269
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

Hi Louis-Alexis,

On 04/03/2026 10:35, Louis-Alexis Eyraud wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a new binding to support the Airoha AN8801R Series Gigabit
> Ethernet PHY.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../devicetree/bindings/net/airoha,an8801.yaml     | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,an8801.yaml b/Documentation/devicetree/bindings/net/airoha,an8801.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f251c9d2fbbed3675c9fd7ff22174049a13a7b5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,an8801.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,an8801.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8801R Series PHY
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The Airoha AN8801R is a low power single-port Ethernet PHY Transceiver
> +  with Single-port serdes interface for 1000Base-X/RGMII; this chip is
> +  compliant with 10Base-T, 100Base-TX and 1000Base-T IEEE 802.3(u,ab)
> +  and supports Energy Efficient Ethernet (802.3az), Full Duplex Control
> +  Flow (802.3x), auto-negotiation, crossover detect and autocorrection,
> +  Wake-on-LAN with Magic Packet, and Jumbo Frame up to 9 Kilobytes.
> +  This PHY also supports up to three user-configurable LEDs, which are
> +  usually used for LAN Activity, 100M, 1000M indication.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-idc0ff.0421
> +
> +  reg:
> +    maxItems: 1
> +
> +  leds: true
> +
> +required:
> +  - reg
> +  - leds

Seems odd to me that leds are required. Any reason for that ?

Maxime


