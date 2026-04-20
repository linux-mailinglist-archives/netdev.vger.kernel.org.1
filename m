Return-Path: <netdev+bounces-279853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IEXJ1hf5mkWvgEAu9opvQ
	(envelope-from <netdev+bounces-279853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:16:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A61430D84
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864683187124
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C4329C71;
	Mon, 20 Apr 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J11F5QCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF022A817;
	Mon, 20 Apr 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699217; cv=none; b=f65RuExYNbQoXKIvtyb7O0S9AOnb8Qr8zyFnLLvDnrOHzeLo3DgWCUAaewCrHOQ52IsG3yMfIR8ZZbR/UopJah5ll6S1O4hYw5OFomaGRg1MxruDiphAsQqLHfUB//sRC62YwBQcA9PIv84SgUo9jVly49xzQqs0GSyJBKuP2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699217; c=relaxed/simple;
	bh=Kjn532amPlaxRPE+ZdGcJATDJi/VPSFQUdv5WzNh3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyYxSVzSmXBeX+AEfSSmtFWDUoXBl4+XMdI2yH9w+SgzRR4AyH+fqxm83+qdLmHccSziQ5zQ38sHGH/3ls9CLU0qGPdWL6T1usISvRRZXcAw3Uh6HJxBALOOCfnCoQQLTNajlp8NEI3EzJfSaWcdIF4+vY0x026gEMlURJKkkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J11F5QCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB776C2BCB6;
	Mon, 20 Apr 2026 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699217;
	bh=Kjn532amPlaxRPE+ZdGcJATDJi/VPSFQUdv5WzNh3iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J11F5QCYiqW9f+FhXzUDFhRkgicfaczvTTTau4KaRSn4neTbdcCd30wvVz/YZ1xCe
	 oqPzbdI7kX/dtrKjpsCniam/m5IYQjV9mnNscDlUPk1jxAJf+XG2db3Q3W0JLWMigt
	 tCfZHRso3vpYoNYVcPdfu2ZWNzQfmRpdjfabXCibgYFVndLyK+D49fJhW9hd6qbbzn
	 LZtYOXco0BhQ2tuyTBhBreacs4LEtyimjQIUSdpkiNbl1uQb+WFncUtq/cm78GpJ8L
	 orroCGJd+BUumTBtViNQ/EByhVV4NsxbKCyR5kzZywq3H5uWtys5+FDxtqotCSOmuk
	 PquIH7zpKJr8g==
Date: Mon, 20 Apr 2026 17:33:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	devicetree@vger.kernel.org
Subject: Re: [net-next v2 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 support
Message-ID: <20260420-messy-elite-panther-a7ffbc@quoll>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-3-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417024523.107786-3-minda.chen@starfivetech.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1A61430D84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:45:20AM +0800, Minda Chen wrote:
> Add StarFive JHB100 dwmac support and compatible.
> The JHB100 dwmac shares the same driver code as the JH7110 dwmac,

Please describe the hardware or programming interface, not driver code.

> which contains 2 SGMII interfaces, 1 RGMII/RMII interface and
> 1 RMII interface.
> JHB100 dwmac has only one reset signal and one main interrupt
> line.


Drop all below, not relevant.

> 
> Please refer to below:
> 
> JHB100: reset-names = "stmmaceth";
> 
> Example usage of JHB100 in the device tree:
> 
> gmac0: ethernet@11b80000 {
>         compatible = "starfive,jhb100-dwmac",
>                      "snps,dwmac-5.20";
>         interrupts = <225>;
>         interrupt-names = "macirq";
>         ...
> };
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 23 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 38bc34dc4f09..85cd3252e8b1 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -115,6 +115,7 @@ properties:
>          - sophgo,sg2044-dwmac
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
> +        - starfive,jhb100-dwmac
>          - tesla,fsd-ethqos
>          - thead,th1520-gmac
>  
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index 0d1962980f57..edc246a71ce3 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -18,6 +18,7 @@ select:
>          enum:
>            - starfive,jh7100-dwmac
>            - starfive,jh7110-dwmac
> +          - starfive,jhb100-dwmac
>    required:
>      - compatible
>  
> @@ -30,6 +31,9 @@ properties:
>        - items:
>            - const: starfive,jh7110-dwmac
>            - const: snps,dwmac-5.20
> +      - items:
> +          - const: starfive,jhb100-dwmac

So that's an enum in previous "items" list.... but your commit msg said
your devices are compatible, so confusing.

Best regards,
Krzysztof


