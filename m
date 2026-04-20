Return-Path: <netdev+bounces-279829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHxVGpBS5mmcuwEAu9opvQ
	(envelope-from <netdev+bounces-279829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:21:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341B42F5C8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BFB23361B81
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7793D75D0;
	Mon, 20 Apr 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUQr//4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06D3D75AB;
	Mon, 20 Apr 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692373; cv=none; b=ZQYAfJMORLJyEyS0AueC4mnpvj62zP2wGUq5owxnyyvOMmWG4SVlwJm0yQ1cnCj12m1T+ghkoy+y0nERUjbVzeAfWl1jrh0WVzt8ThlIKbnG2+ocJ39j55dn96mGcHk9T2JfK8EEHLU26T/kKZ1ol/TeDd/81/3JAXbxTWqDcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692373; c=relaxed/simple;
	bh=QV3/kRtnuqUUDprxbWR5pkNW+yWztIYB+VtpAMRuffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcBHUi4WDYg9qBm59Lt7CmWJGPlJvGDa4jFgulCdClI7IkMNhoN+ACoIdR+hDvCnZM5oLzaBR1aS0ebo+j2Hra4ZzsHgoO0Ieno5Xz/irJPOdUY6QtBzvvhtdPfdyAWpcwJlcrE+F9hI/q7izO2nvA7KvIUUeO/evFn8UmriGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUQr//4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E39AC19425;
	Mon, 20 Apr 2026 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776692372;
	bh=QV3/kRtnuqUUDprxbWR5pkNW+yWztIYB+VtpAMRuffE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUQr//4xkxx3D3yKvPfqTimlbnn7kNSAHnCzfaA+MVn7i9x6JhtUGCIjUw+HuWcmt
	 h6aAvjvD0mPG/N0e+PzQhtGppPOt1KmckMqNEY0BeyGZlcRD+G0sR54cBx8bWgFHTB
	 Gawo27UIsUnhcFc1F0hDdyNHTzAbvEMI2wHTasyUALFhkJvHOEZk5pMi54TRLGu80O
	 jTZEk0Fh5YgOdFwJZO+kBBXlMwD8aAhY7jog5Um60tHiHROvLj20imQ6ihSEfBZmP6
	 ahYRbbtDPMuwsPmYCnZFdDf/ne3NQZECgijAQQPgP4qEBrR8zBU/9G/uebmMcmQ+HA
	 bvtEWK4t6yU1Q==
Date: Mon, 20 Apr 2026 08:39:30 -0500
From: Rob Herring <robh@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v2 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 sgmii rx clk
Message-ID: <20260420133930.GA2322456-robh@kernel.org>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-4-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417024523.107786-4-minda.chen@starfivetech.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	TAGGED_FROM(0.00)[bounces-279829-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8341B42F5C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:45:21AM +0800, Minda Chen wrote:
> JHB100 SGMII interface tx/rx mac clock is split and require to
> set clock rate in 10M/100M/1000M speed. So dts need to add a
> new rx clock in code, dts and dt binding doc.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index edc246a71ce3..3802cdbf1848 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -39,20 +39,26 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 5
>      items:
>        - description: GMAC main clock
>        - description: GMAC AHB clock
>        - description: PTP clock
>        - description: TX clock
>        - description: GTX clock
> +      - description: SGMII RX clock
>  
>    clock-names:
> -    items:
> -      - const: stmmaceth
> -      - const: pclk
> -      - const: ptp_ref
> -      - const: tx
> -      - const: gtx
> +    minItems: 5
> +    maxItems: 6
> +    contains:
> +      enum:
> +       - stmmaceth
> +       - pclk
> +       - ptp_ref
> +       - tx
> +       - gtx
> +       - sgmii_rx

No, this allows any of the above strings plus any other random strings.

Rob

