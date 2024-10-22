Return-Path: <netdev+bounces-137795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF19A9DA8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC61DB22952
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A1198E6F;
	Tue, 22 Oct 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP/vevSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B4193092;
	Tue, 22 Oct 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587440; cv=none; b=KvcOiKqFyrr4rnxcu+LnmUzaMVL0Uz6YdYuU2okCITl+RNfz4OC3Ek0b02Ue0rPdNBZh8uMItjXtVnaPRbsx6eopQc043IB/zkUs0HOpNOkzaLRjIEwI8UBZpmQ/Z7C+GqOezIABSTJQDuoHqBeFE+HeKkhjArhL4OgNihCO7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587440; c=relaxed/simple;
	bh=htdXVuBg3rUPy01vK1UMoH1g0fkJC7jNj9EenNcP2hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq9i2khZe/cnsiUv1ZFWjgDsk9n1ph8eOzox3pm8fZ9wTxWcB1Jioxsc3J9W7108/aTMYhIAzkBy+iFqaDkf01+aJBd7QNhgpuRNrvXLgj391YIBWV6IVfKqplG3p7by35qQOLEOax0joPYhrUjBg1/mE8fkggEYMQAZPhp79qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP/vevSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEA8C4CEC3;
	Tue, 22 Oct 2024 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729587440;
	bh=htdXVuBg3rUPy01vK1UMoH1g0fkJC7jNj9EenNcP2hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JP/vevSM6dZ5CjZgbF+JPWInBBZi7QxSxJQTeGlIWg4akANwQIckgvexhbnWL4uPy
	 9ZzayKAMqBVoWK+ABAtNcRmIJfYlXCSU+XEbMvramqx7wYKW2/Jj3veRaNCIWXrVJ1
	 oMzmfx7lge3QWaBBImJajqh2XMT95tj9lT/UGVvDFlCmWFFYPl0ffhdevYA+2exIQh
	 LktrII0F290bHJXSnwI9GsMOyJ/VFwqGtZarQ2Z0rfXQ5orovIHK/QDRWKgStsBCy4
	 S9M9HVb78xbTglVJx5FOlqFDQ5ZKG+FZwVkDy34SDkEz0WPkrmqtCjeKcjS+WveQ25
	 9D9nvKQzc2rFg==
Date: Tue, 22 Oct 2024 09:57:13 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	horatiu.vultur@microchip.com,
	jensemil.schulzostergaard@microchip.com,
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
	ast@fiberby.net, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 01/15] net: sparx5: add support for lan969x
 SKU's and core clock
Message-ID: <20241022085713.GR402847@kernel.org>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-1-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-1-c8c49ef21e0f@microchip.com>

On Mon, Oct 21, 2024 at 03:58:38PM +0200, Daniel Machon wrote:
> In preparation for lan969x, add lan969x SKU's (Stock Keeping Unit) to
> sparx5_target_chiptype and set the core clock frequency for these
> throughout. Lan969x only supports a core clock frequency of 328MHz.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

...

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index d1e9bc030c80..f48b5769e1b3 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -475,6 +475,20 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
>  		else if (sparx5->coreclock == SPX5_CORE_CLOCK_250MHZ)
>  			freq = 0; /* Not supported */
>  		break;
> +	case SPX5_TARGET_CT_LAN9694:
> +	case SPX5_TARGET_CT_LAN9691VAO:
> +	case SPX5_TARGET_CT_LAN9694TSN:
> +	case SPX5_TARGET_CT_LAN9694RED:
> +	case SPX5_TARGET_CT_LAN9696:
> +	case SPX5_TARGET_CT_LAN9692VAO:
> +	case SPX5_TARGET_CT_LAN9696TSN:
> +	case SPX5_TARGET_CT_LAN9696RED:
> +	case SPX5_TARGET_CT_LAN9698:
> +	case SPX5_TARGET_CT_LAN9693VAO:
> +	case SPX5_TARGET_CT_LAN9698TSN:
> +	case SPX5_TARGET_CT_LAN9698RED:
> +		freq = SPX5_CORE_CLOCK_328MHZ;
> +		break;

Hi Daniel,

It is addressed in patch 12/15, but until then pol_upd_int will
be used uninitialised later on in this function when this case it hit.

Flagged by Smatch.

>  	default:
>  		dev_err(sparx5->dev, "Target (%#04x) not supported\n",
>  			sparx5->target_ct);

...

