Return-Path: <netdev+bounces-274405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOmULqQczml7lAYAu9opvQ
	(envelope-from <netdev+bounces-274405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:37:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C724385480
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC60304E713
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC5390C9E;
	Thu,  2 Apr 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S14FL0JZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EB3909A9;
	Thu,  2 Apr 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114789; cv=none; b=syIuEnOjlsqRo0Td24Chc5zuB1P7vpAIrt+4M8olHL2dynWbm4GJ4zFbm4AhN4s8s5Tl3MtiXDzYNzX6L/zFCTw4bOgwWEGo+m4tQX6wRLv/HEpk5tSxIC7q7d2mHERdSaGjfo8d+3rRgsTClmRVGhM0l24L+7ZCMMCkxVggwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114789; c=relaxed/simple;
	bh=blzi+T4vd5l4tALbxLrPzAlbbRECYcrNpOOCXZdxEDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7o6FaMn0hsSUIadvAuUGengl9wlfLqrdY1dx3lpysvGYDvU9xjSqFdFvrekZo/glwe9mxYaKsUG7F/r7Ftr2qfamLy1lbyytnKDDbofNv3bbgPPX+7hR/lMFwGVZrqU19zVGNgj+y4m/SfnUeGUp3fwNjBUDysBQowm7U2VWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S14FL0JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6963AC2BCB3;
	Thu,  2 Apr 2026 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775114789;
	bh=blzi+T4vd5l4tALbxLrPzAlbbRECYcrNpOOCXZdxEDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S14FL0JZWL6qg7m8F40cl5pAxVUDbN2pm/RXu3fvuAMv9tyD3fhtUCYvt7qEiXMGY
	 Iqx9FYReEemJcRhxPyw26Z1lNNVqiMNxiUysxMlEUfyZ7yRNndLuQqfnPr1QKrYKVQ
	 d31qPl/5MRUQDrZicnF49mCooe2xh/Hn/T8DQYBbIuqR+6afg5fr6oIucm2+GIITpI
	 qihyv8ZtiHzCbYfkf+Vr1xs4n83GGIXAjb29GAeOSKcGhLWhsx7FDbwx6fASpuk7X2
	 zUgTWcVv/Y8kHk4lNVCxFQAYqBdVvnzK4rB/VFnIA8VRILFMlraHy+39GJsoipr+DT
	 5bjF3dwhQqJEQ==
Date: Thu, 2 Apr 2026 09:26:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: ti:
 k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
Message-ID: <20260402-discreet-sparkling-turkey-ce23e9@quoll>
References: <e7ec1b928357d1240a962a88dc6ac67fd2c92357.1774958552.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7ec1b928357d1240a962a88dc6ac67fd2c92357.1774958552.git.nora.schiffer@ew.tq-group.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274405-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email]
X-Rspamd-Queue-Id: 4C724385480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 02:05:42PM +0200, Nora Schiffer wrote:
> The J722S CPSW3G is mostly identical to the AM64's, but additionally
> supports SGMII. The AM64 compatible ti,am642-cpsw-nuss is used as a
> fallback.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
> 
> v2: keep ti,am642-cpsw-nuss as a fallback
> v3: resubmission for net-next, no changes
> 
>  .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> index a959c1d7e643a..70d25f5ff1cfe 100644
> --- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> @@ -53,13 +53,19 @@ properties:
>    "#size-cells": true
>  
>    compatible:
> -    enum:
> -      - ti,am642-cpsw-nuss
> -      - ti,am654-cpsw-nuss
> -      - ti,j7200-cpswxg-nuss
> -      - ti,j721e-cpsw-nuss
> -      - ti,j721e-cpswxg-nuss
> -      - ti,j784s4-cpswxg-nuss
> +    oneOf:
> +      - items:

s/items/enum/. No need to make it a list, wasn't list before. It is not
making code more readable.

> +          - enum:
> +              - ti,am642-cpsw-nuss
> +              - ti,am654-cpsw-nuss
> +              - ti,j7200-cpswxg-nuss
> +              - ti,j721e-cpsw-nuss
> +              - ti,j721e-cpswxg-nuss

Best regards,
Krzysztof


