Return-Path: <netdev+bounces-224444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C909CB85315
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B1560CAC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2230C355;
	Thu, 18 Sep 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="skKv/2mO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833F31FEFC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204535; cv=none; b=cdAwNPBhmuBz0c50rOsEh80a2x6F/Caeb02vf7Ci3rvNXlINpidufbxB7PnZ64DHchLKunRQ3ugvU6sDj8C9EDyvqAM8GN8KgR6PYQMR87j7Xp2ZbFs/eXm3/FoepdD/n4p4DQ2up7I6OYzxMcVPCTKFIOxqRRVAb8NeJrOXNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204535; c=relaxed/simple;
	bh=W5SB0N2oROFg1DqgZ0lvtzpvfFKhAyK7+1FnSfG9dB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCrKCBGTZ3/7fu6UKgUhHvA1hb/XI56rmCK0ankWueo5mXYAqWF4X3wSyrTZOVKn9BcXVYBjwBhdo26vw2070KsQapIEnPupe20m3diTLTuRdLqzgc6QDMqos89fTUqr+r3vsTTAPKo8Q7UsK4azzuMNmVYyLratTAL0oVHgICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=skKv/2mO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 450D74E40D20;
	Thu, 18 Sep 2025 14:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A2A96062C;
	Thu, 18 Sep 2025 14:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 058BB102F1964;
	Thu, 18 Sep 2025 16:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758204527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g2IM1wPL02xKgY8BOdX4g5cIV5ISYT5+mA1HDuflN4w=;
	b=skKv/2mO9/fjmaeKJecBdYZyVtdbaFQU1yASjzQaTI5xMIVAAdezEA00v3OI6b3fkE1kon
	OPlk3/ZL2YZkRmW2+dwIdLeVLx8Y19MceEUrB+0HUt9bBEdf2uhwF4d+JVcZnMwzay4uKh
	GNC3c/rKOhui4SqMtjeMBOVHTaG0+PYHXoLnCLnCaI3uE3RhdzXDNXvTFXNBsPfycPU12G
	zNXHb9rEv68NDmp+e/WdU8qNcvyIvFoyQpyMYuRD0laGg60W/Yn9404/IaLfJUiaibwQGO
	rZ+6mUOHsQ3j5GowntWodgZ3jbgQtf0xOEZ9ggB2mENAsmXWUsot/2Nq25LvsA==
Date: Thu, 18 Sep 2025 16:08:34 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next] wan: framer: pef2256: use %pe in print format
Message-ID: <20250918160834.47f746b9@bootlin.com>
In-Reply-To: <20250918134637.2226614-1-kuba@kernel.org>
References: <20250918134637.2226614-1-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On Thu, 18 Sep 2025 06:46:37 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> New cocci check complains:
> 
>   drivers/net/wan/framer/pef2256/pef2256.c:733:3-10: WARNING: Consider using %pe to print PTR_ERR()
> 
> Link: https://lore.kernel.org/1758192227-701925-1-git-send-email-tariqt@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: herve.codina@bootlin.com
> ---
>  drivers/net/wan/framer/pef2256/pef2256.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
> index 1e4c8e85d598..2a25cbd3f13b 100644
> --- a/drivers/net/wan/framer/pef2256/pef2256.c
> +++ b/drivers/net/wan/framer/pef2256/pef2256.c
> @@ -719,8 +719,8 @@ static int pef2256_probe(struct platform_device *pdev)
>  	pef2256->regmap = devm_regmap_init_mmio(&pdev->dev, iomem,
>  						&pef2256_regmap_config);
>  	if (IS_ERR(pef2256->regmap)) {
> -		dev_err(&pdev->dev, "Failed to initialise Regmap (%ld)\n",
> -			PTR_ERR(pef2256->regmap));
> +		dev_err(&pdev->dev, "Failed to initialise Regmap (%pe)\n",
> +			pef2256->regmap);
>  		return PTR_ERR(pef2256->regmap);
>  	}
>  

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

