Return-Path: <netdev+bounces-140583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5149B7178
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEB31C21026
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038438DF9;
	Thu, 31 Oct 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbS/yJfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2A79CF;
	Thu, 31 Oct 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730336865; cv=none; b=KlczGjWslJ8wsVoVc0GaZxugdy+AtOH2kG+yGfiWMgpLtR/05vUSfokqYdYeSDFXfSJhFs034gzWe53exzuonbBTMyWRDK4/8DZZxIvFFRji3+GGHi8RaOGXVKmXlRg+gTND7F8MfUB5VzqF/dsqhdJC2sT4HSJjbKoqxsajn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730336865; c=relaxed/simple;
	bh=KTGoTD83eV6moZ2wNyAKGgj9FRSZTPh8B8ArNRpcHHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibmVFeJogZSjdtS3g/cBecXviu11qlhWci9RLcAMrGXjInqnsK80OqzG/kOD+n5Pc8Ik2Ubfbh6VELFynUZW61+7gSVNVcDx3cn+zm23KNQfTIePV4auX954Ezt9ojaiFO7q7Hn4fnG4t7ggiw+YVgh9JqIr/vkgTwbyY+t1YOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbS/yJfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E503BC4CECE;
	Thu, 31 Oct 2024 01:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730336865;
	bh=KTGoTD83eV6moZ2wNyAKGgj9FRSZTPh8B8ArNRpcHHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbS/yJfJLv6FKaTlKAfRilbi+dKk+EBOGSLc5vkTcBQGe1ojlVlOAooUNsmCeab6e
	 qjHQiXF71ZohogPV80p0GOsRPaKCaDLp3srqTRUjKKvvZhjUTOv3H6Qi9doTUC5Xb4
	 +vta2UONIQpXSwFi2biAzjWU4Xh2F533Owvn+S48utWco0p2C8HhVes8uZkAqDJlPx
	 u5MMq0wiSeIFidmVVpFh1BsHkhdhTzRiSxSY7LgcAk8yuS7zzeRHmIlpBaMHy05WyF
	 19wSRqtWncfDmid03xOBLV1u3qguoAukZy+wCL6ukfT/mtCVES/MGPYKBHvo3WyNlr
	 PMBZOmG+T4s6w==
Date: Wed, 30 Oct 2024 18:07:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>,
 <Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
 <ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 10/15] net: lan969x: add PTP handler
 function
Message-ID: <20241030180742.2143cb59@kernel.org>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
	<20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 00:01:29 +0200 Daniel Machon wrote:
> +		spin_lock_irqsave(&port->tx_skbs.lock, flags);
> +		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
> +			if (SPARX5_SKB_CB(skb)->ts_id != id)
> +				continue;
> +
> +			__skb_unlink(skb, &port->tx_skbs);
> +			skb_match = skb;
> +			break;
> +		}
> +		spin_unlock_irqrestore(&port->tx_skbs.lock, flags);

For a followup for both drivers -- you're mixing irqsave and bare
spin_lock() here. The _irqsave/_irqrestore is not necessary, let's
drop it.

> +		spin_lock(&sparx5->ptp_ts_id_lock);

