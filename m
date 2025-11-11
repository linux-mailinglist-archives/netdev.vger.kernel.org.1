Return-Path: <netdev+bounces-237421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54795C4B366
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F97C4E2DF8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5A347BA7;
	Tue, 11 Nov 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4RdiADJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DB32E6A6;
	Tue, 11 Nov 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828121; cv=none; b=VjjiwUj/U+rOycle3saCypKTZE5e+lItMDraIqG45kYYDceFaGYcTi3aINNH11BfC7nHhS5g6QDswFBsAT9KzAhlpFWJDB1G6OlRvYzoMzk+XX8UtvV/Fj9G+td4g7oNfRPnX7q4bwKQyeeGXDGhCuRhZpx9wWWRJOlqyNaF44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828121; c=relaxed/simple;
	bh=4bxxtNfvFtf2kuusWfaBT0tTTl9BsCBqjmM9OzoUpVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX27t/Ld5cfxbqUB6O3teW6ezroJkPvQePTeit/0M4JgHQAwE8f63Au8NrTP8abxPLYeycCO1OlewuG0Nu3JiMNESZuThApE3xZrnKtl3MeFUjVXCgteIDjYf6TAa4G4IOrW+K4owH3RBb5/kt3xII9LJiArTSmQnqW3gxTP17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4RdiADJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5803BC16AAE;
	Tue, 11 Nov 2025 02:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828121;
	bh=4bxxtNfvFtf2kuusWfaBT0tTTl9BsCBqjmM9OzoUpVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4RdiADJtkg5A8SpLb3XYsWG8upCWva80A9sqkRGMVFM3b9cfH6cJ3y/jHm4eFlXa
	 HaiLEF3kem3ojtD8q/+ofNZtp1Gq2kUO3k7uxYF8zw8vaZRrCaNlj2k8Vwm0rlZwAk
	 BA8aPYzNyp4wN4ovvwopWqXEwxzZ5WHc+Zb5fDzEr8L0BosGOhKRQ6Wa1LEkWiiVBt
	 KvJWmXEsAO6QwpDnaVioUbc3nGninPTLbUtyeSvIBChqT0YJUCfkxq53l2OopGYvsr
	 5fJ3C2XKrDh2lIri1LkPlmr0VI3ZNjYOB+2CXwznbnZsKbry+bdUuTUbJSN0wYUZpH
	 K5cTyOaNM1E2A==
Date: Mon, 10 Nov 2025 18:28:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Arun
 Ramadoss <arun.ramadoss@microchip.com>, Pascal Eberhard
 <pascal.eberhard@se.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
Message-ID: <20251110182839.3dfb68bf@kernel.org>
In-Reply-To: <20251106-ksz-fix-v2-3-07188f608873@bootlin.com>
References: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
	<20251106-ksz-fix-v2-3-07188f608873@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Nov 2025 13:53:10 +0100 Bastien Curutchet (Schneider
Electric) wrote:
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 3a4516d32aa5f99109853ed400e64f8f7e2d8016..4f5e2024442692adefc69d47e82381a3c3bda184 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2858,14 +2858,16 @@ static void ksz_irq_free(struct ksz_irq *kirq)
>  {
>  	int irq, virq;
>  
> -	free_irq(kirq->irq_num, kirq);
> +	if (kirq->irq_num)
> +		free_irq(kirq->irq_num, kirq);
>  
>  	for (irq = 0; irq < kirq->nirqs; irq++) {

if the domain may not be registered is it okay to try to find mappings
in it? From the init path it seems that kirq->nirqs is set to the port
count before registration so it will not be 0 if domain is NULL.

>  		virq = irq_find_mapping(kirq->domain, irq);
>  		irq_dispose_mapping(virq);
>  	}
>  
> -	irq_domain_remove(kirq->domain);
> +	if (kirq->domain)
> +		irq_domain_remove(kirq->domain);

