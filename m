Return-Path: <netdev+bounces-184221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FDA93EDB
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E764A074F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EBE2397B9;
	Fri, 18 Apr 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eXr9MTqd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4B1C2324;
	Fri, 18 Apr 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008034; cv=none; b=UA13YIQ8+Jil3xWJA5FXnK/6cXpYEO//d1cWBQS6D+6kymY59rbbBX2MfZnojBZUpniVHqh03Ixr+62fbIKKWae27p/3G3I63nrHRrLcakCyPx+5Xmjdn1Xd1F0QhSeDH3KflYuABpMymuY4otbxXf5JlQGxjTtbi4kpuydkVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008034; c=relaxed/simple;
	bh=CrhsFFq5IyqJkiDJlv+lg+3v62q3lDf7I+FQDCU5DC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmBIONihiZ6CnG1IwFE2SiVFirV5YITcr3KsN2TZHDmdV6IyP5EHcZrs1JvFagVcOqxt1ogQoU18aDx4R3TXIKTfym2AOkSASAul6ZIvKbXtgkpmaKaVl3hPwHeaFtPPIJiexO1vTfHf3xmAvibMuU3TDqTGlK6td6jywNPespA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eXr9MTqd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O79Q8up6Gy2hEMjnQITer5PbKSEwN1Pzj/8/BV+JwL4=; b=eXr9MTqdlq9ohs6A/9h4SUfc9g
	URu7Pe6Rtniim9/50hbZjCEspUSIRrZO5c9vO9opoZKrVynLKH9QDhASi6zX8s/JuB2EXl8pSjeFd
	4uRDz54ZFiqqTWqM6a9mWuCLl3uFlJ1Ac970YA9oSySo6C68axjiaA/PpkNPO9mijY90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5sIZ-009wCP-5d; Fri, 18 Apr 2025 22:26:55 +0200
Date: Fri, 18 Apr 2025 22:26:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <94075f0a-6e17-4106-879e-3aa5193f9ef2@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>

On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> As discussed [1], the comments for the different rgmii(-*id) modes do not
> accurately describe what these values mean.
> 
> As the Device Tree is primarily supposed to describe the hardware and not
> its configuration, the different modes need to distinguish board designs
> (if a delay is built into the PCB using different trace lengths); whether
> a delay is added on the MAC or the PHY side when needed should not matter.
> 
> Unfortunately, implementation in MAC drivers is somewhat inconsistent
> where a delay is fixed or configurable on the MAC side. As a first step
> towards sorting this out, improve the documentation.
> 
> Link: https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/ [1]
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../bindings/net/ethernet-controller.yaml        | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 45819b2358002..2ddc1ce2439a6 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -74,19 +74,21 @@ properties:
>        - rev-rmii
>        - moca
>  
> -      # RX and TX delays are added by the MAC when required
> +      # RX and TX delays are part of the board design (through PCB traces). MAC
> +      # and PHY must not add delays.
>        - rgmii
>  
> -      # RGMII with internal RX and TX delays provided by the PHY,
> -      # the MAC should not add the RX or TX delays in this case
> +      # RGMII with internal RX and TX delays provided by the MAC or PHY. No
> +      # delays are included in the board design; this is the most common case
> +      # in modern designs.
>        - rgmii-id
>  
> -      # RGMII with internal RX delay provided by the PHY, the MAC
> -      # should not add an RX delay in this case
> +      # RGMII with internal RX delay provided by the MAC or PHY. TX delay is
> +      # part of the board design.
>        - rgmii-rxid
>  
> -      # RGMII with internal TX delay provided by the PHY, the MAC
> -      # should not add an TX delay in this case
> +      # RGMII with internal TX delay provided by the MAC or PHY. RX delay is
> +      # part of the board design.

This looks good to me. There is nothing here which is Linux specific.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

