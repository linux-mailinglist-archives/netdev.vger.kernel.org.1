Return-Path: <netdev+bounces-235076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CBC2BCFD
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131414F710C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CC830FF24;
	Mon,  3 Nov 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="judhg8dw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D130E852;
	Mon,  3 Nov 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173608; cv=none; b=bsZkR4hiGLwxuUMh8uWDqQm8dzxg17k+GaKPAxe28O9qIcvyGBkAULg164fqMQ49B/I45mk5hvvH7pB5Hcw78Rq4ZqGtA1et3KkV8ruKH5ip6SgKizePUxZFOxf/CznTQ0iyxGcvS59Hmo+57zfLDFNHtK5qPKTNA2WDzs4cd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173608; c=relaxed/simple;
	bh=cXS6YqDu1aAIoihYJMx0C5S/EGTY2veO/eUmFpn3vYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhYhLB8K0CM92npeaYgs+VO0nfCAFaCgHtz6q59WD+m0ZGL9oUdw+6scNl2dYg7sdz99JhiyMHg1KhhMuhvytgVS9ratYFeXTSPE/084YsDU12jNZKHNIGR8+UXcgisX+tcZABRNgBdEfOi+2Vy9pdSm/kk9LKgykSH1GeRVKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=judhg8dw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 89A20C0D7AA;
	Mon,  3 Nov 2025 12:39:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B44A60709;
	Mon,  3 Nov 2025 12:40:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65ED610B5005A;
	Mon,  3 Nov 2025 13:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762173602; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6bd3qOFo0naZsfmsk+yctKY223PmdCGeaBNloBYRnoI=;
	b=judhg8dwpBVzZwyMOx3oTg5uonu02y6mYMN3DlwAHPwOByOhxNgydk3PAScGHcIhYzROW7
	alVO1Gkl2+bGCE+VqxZuCmotW6or1UJlDlqHhNUNWf3JTS4F4uLrUuxtFqiPp/q4LC/LEG
	VKbx4WdQRskg5u2g2ejrzdesNvINKQkl6lIDlUSJ2VRE1O0mrKUtpj8fYfis6FaiIdBV6f
	PXF/NViwhj1SZB6n2EAy/+daxfnQhKwu4IZIn9OXr9a2FduUrjuC1zwASj282zMFMAe741
	DT0StxNgi2qABNGo6w9Xkm39VeaScVERhvx1UZuKcfP+DOs0sSbtQaB+wDTUnQ==
Date: Mon, 3 Nov 2025 13:39:58 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: wan: framer: pef2256: Switch to
 devm_mfd_add_devices()
Message-ID: <20251103133958.7c9d5003@bootlin.com>
In-Reply-To: <20251103123741.721-1-vulab@iscas.ac.cn>
References: <20251103111844.271-1-vulab@iscas.ac.cn>
	<20251103123741.721-1-vulab@iscas.ac.cn>
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

Hi Haotian,

On Mon,  3 Nov 2025 20:37:41 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
> in error paths after successful MFD device registration and in the remove
> function. This leads to resource leaks where MFD child devices are not
> properly unregistered.
> 
> Replace mfd_add_devices with devm_mfd_add_devices to automatically
> manage the device resources.
> 
> Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")
> Suggested-by: Herve Codina<herve.codina@bootlin.com>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
>   - Use devm_mfd_add_devices() instead of manual cleanup
> ---
>  drivers/net/wan/framer/pef2256/pef2256.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
> index 1e4c8e85d598..4f4433560964 100644
> --- a/drivers/net/wan/framer/pef2256/pef2256.c
> +++ b/drivers/net/wan/framer/pef2256/pef2256.c
> @@ -812,7 +812,7 @@ static int pef2256_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pef2256);
>  
> -	ret = mfd_add_devices(pef2256->dev, 0, pef2256_devs,
> +	ret = devm_mfd_add_devices(pef2256->dev, 0, pef2256_devs,
>  			      ARRAY_SIZE(pef2256_devs), NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(pef2256->dev, "add devices failed (%d)\n", ret);

Thanks for your update.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

