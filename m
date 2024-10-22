Return-Path: <netdev+bounces-137749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49309A9972
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E321C244CE
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA1142900;
	Tue, 22 Oct 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbo32d1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1C13DDA7;
	Tue, 22 Oct 2024 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577381; cv=none; b=Ny1oXGeJF2BaS5i6nAeSsFFqFNJW9kyJTZNL82RkiN7bi/sjp4K70sf5vGtaAAfwhhGNOyQqn3j86XmEnEXzSlZWipY56Q2gvdkiL/UrxGKjmgfhSW9MytFKr7WcYGthk4d/lCItJkmL/EbyTvZeZuPqQI7h3NzpX/8Z1W4zL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577381; c=relaxed/simple;
	bh=0bYs5KsWInCKhJPdKjxQ5yGyKQuFi/ibYTzYDSnrgxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoE9CjJ2bb6m6S4FYlDmeztXcT3oVLIIB4kx2P3U9bNRjqMP6CmgusesljSORlC4aU2TtLA8h2Gc1ymTPqJ3Uq/dDnHJKlIlIW29p4z1M957ay9m3umFXrUsdLntn6hTmVQUvjSBvurBRa/e6bj1DjsMIRGGaOF2DisnRN/dPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbo32d1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95659C4CEC3;
	Tue, 22 Oct 2024 06:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729577381;
	bh=0bYs5KsWInCKhJPdKjxQ5yGyKQuFi/ibYTzYDSnrgxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jbo32d1Q7udrMFsB9dZA20NVkykIOOabHEcgO8+ZP//vLHL7ZBLrRl6lvAV7VYYyk
	 z6cjTsQ2kZzO5bm5Im91b40xdbLg0zVPL2qMhL6H45t3gtGGWV4Q3GDOqTw1CfYoVI
	 08OFlLT/sgi+Ssy/yPkFDk2+ADIl0KFoaTpDB5EQTikt9J5TQkknpL2iaZl7rqWCX1
	 58a/kg0IkffdpLv+FnzqVxNMIb4qZbAJjFsBAXXtfEi9q1qhyZv9WB8igGQFVNGW+c
	 pht+oYQWI4UVrqEawdBU7v2Bnx16Ln/fQH3dEXkCil2mLwDcvwiY4j3S8miHTDsDMY
	 i75lliBHs9BJQ==
Date: Tue, 22 Oct 2024 08:09:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, horatiu.vultur@microchip.com, 
	jensemil.schulzostergaard@microchip.com, Parthiban.Veerasooran@microchip.com, 
	Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com, 
	ast@fiberby.net, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <dj6vmcezdfrrhdofhzt4gs42pzqyd5fntdy66z76oajxvc44p4@k7fd7dhtwqos>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>

On Mon, Oct 21, 2024 at 03:58:51PM +0200, Daniel Machon wrote:
> @@ -227,6 +229,168 @@ bool is_sparx5(struct sparx5 *sparx5)
>  	}
>  }
>  
> +/* Set the devicetree target based on the compatible string */
> +static int sparx5_set_target_dt(struct sparx5 *sparx5)
> +{
> +	struct device_node *node = sparx5->pdev->dev.of_node;
> +
> +	if (is_sparx5(sparx5))
> +		/* For Sparx5 the devicetree target is always the chip target */
> +		sparx5->target_dt = sparx5->target_ct;
> +	else if (of_device_is_compatible(node, "microchip,lan9691-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9691VAO;
> +	else if (of_device_is_compatible(node, "microchip,lan9692-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9692VAO;
> +	else if (of_device_is_compatible(node, "microchip,lan9693-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9693VAO;
> +	else if (of_device_is_compatible(node, "microchip,lan9694-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9694;
> +	else if (of_device_is_compatible(node, "microchip,lan9695-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9694TSN;
> +	else if (of_device_is_compatible(node, "microchip,lan9696-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9696;
> +	else if (of_device_is_compatible(node, "microchip,lan9697-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9696TSN;
> +	else if (of_device_is_compatible(node, "microchip,lan9698-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9698;
> +	else if (of_device_is_compatible(node, "microchip,lan9699-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9698TSN;
> +	else if (of_device_is_compatible(node, "microchip,lan969a-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9694RED;
> +	else if (of_device_is_compatible(node, "microchip,lan969b-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9696RED;
> +	else if (of_device_is_compatible(node, "microchip,lan969c-switch"))
> +		sparx5->target_dt = SPX5_TARGET_CT_LAN9698RED;

Do not re-implement match data.

> 

