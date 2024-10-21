Return-Path: <netdev+bounces-137593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E449A7167
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90991C2201C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA831F4FA1;
	Mon, 21 Oct 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CSNYIcgR"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EE1F4713;
	Mon, 21 Oct 2024 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533108; cv=none; b=XObttCq9aULoArB43rVhhFBx6QHPkec7dojHc8X8eVWyQ/Hv4WFjkSvZ6CBpVnzsHZCf3W+DRYfraZBvjAoSVDog3jjhD6lVQsTY+s2gT3CfFaeJMKofBNqLxcJRmV9OYW8kUfsdUsKjgl3pxdxuz8Gb8SffQuNLo1OTERBE7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533108; c=relaxed/simple;
	bh=NN+bH9881EA8sg1SujZZ3hBU9bZvRpN4021uMbPuSFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZphWpBiHKEQEmYXfUlSL22qW2tEATGP32A4V+WRJd3KVyoqJUzUbU+UpLw2EUnc04kP/huRcWWcy9bbFNd94ubLpm118fugW8dJH1FZaTF2bTe5NPcfN7wDT48oyHB1BaeMffFQouj+ra8dp5y0DLN83xinJfKZPR4ThAzcyQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CSNYIcgR; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFD1C60002;
	Mon, 21 Oct 2024 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729533103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84FFr9VQLa1SJol6stO39srQY57ZOMWmg6GfF4bl0Us=;
	b=CSNYIcgRmuuf08U+jaMLL6qq0AiUL/Z4S1vC02DdI1FXjOR64SayRr+x7k9BC9lcFlK/km
	hsl+yo3Nwh+uRbatrh3kzZi2uoeajKSASH4MFRfolP+K8qlczqY4yOtmEMTVoSoxnKS4vW
	tC+vkXIeKPBKV2IXi86CvQl7IWDmF49EZJMce4g4/fa8yUFP1H4kvEPUzgEn+klaGTqtKG
	PHxVmg/QJpc2tGb32YR8mcbmyCO3XS9xxrebS9xwEuS94gu2j77OHj/3o1AS3uyUfzM0r7
	3/CUqn3C/gbKdm8ytb88wU/9TbRz2YyDiKhQ300627px+w0yPYL0ylcq1x5Tiw==
Date: Mon, 21 Oct 2024 19:51:40 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>,
 <Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
 <ast@fiberby.net>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 11/15] net: lan969x: add function for
 calculating the DSM calendar
Message-ID: <20241021195140.442c0a4f@device-21.home>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-11-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
	<20241021-sparx5-lan969x-switch-driver-2-v1-11-c8c49ef21e0f@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Daniel,

On Mon, 21 Oct 2024 15:58:48 +0200
Daniel Machon <daniel.machon@microchip.com> wrote:

> Lan969x has support for RedBox / HSR / PRP (not implemented yet). In
> order to accommodate for this in the future, we need to give lan969x it's
> own function for calculating the DSM calendar.
> 
> The function calculates the calendar for each taxi bus. The calendar is
> used for bandwidth allocation towards the ports attached to the taxi
> bus. A calendar configuration consists of up-to 64 slots, which may be
> allocated to ports or left unused. Each slot accounts for 1 clock cycle.
> 
> Also expose sparx5_cal_speed_to_value(), sparx5_get_port_cal_speed,
> sparx5_cal_bw and SPX5_DSM_CAL_EMPTY for use by lan969x.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

[...]

> +	/* Place the remaining devices */
> +	for (u32 i = 0; i < DSM_CAL_DEV_MAX; i++) {
> +		speed = &dev_speeds[i];
> +		for (u32 dev = 0; dev < speed->n_devs; dev++) {
> +			u32 idx = 0;
> +
> +			for (n_slots = 0; n_slots < speed->n_slots; n_slots++) {
> +				lan969x_dsm_cal_idx_find_next_free(data->schedule,
> +								   cal_len,
> +								   &idx);

You're not checking the return of lan969x_dsm_cal_idx_find_next_free(),
can this be a problem ?

Thanks,

Maxime

