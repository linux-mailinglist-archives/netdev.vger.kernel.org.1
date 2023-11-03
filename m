Return-Path: <netdev+bounces-45922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727227E06FB
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D3F1C21058
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4F1CF88;
	Fri,  3 Nov 2023 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imMWQOD9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF41C2A2
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F4CC433C8;
	Fri,  3 Nov 2023 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699030123;
	bh=7Ih4odCRaefU12RaYZiOnOpNLIUANhMxlXFENUxtaxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imMWQOD9bogm99VgUKiYSIrLlDGzZLxEJt6a1qEXWkCt5vg2kO/FVn2qbUG3AoAhc
	 BrnChn+vvhc0qJQDgmI1CO2ROMTR+Ucxc/93c/5hkG1dTC5GVooiqaSi1d+beazNr5
	 LOvUCcZL5ImQbVefaIU5Qwsrj15KCrSI1x3Q77Q13VXiaM5cMWT6Pdl6ZmyS45sDM9
	 TnvHg9mtX411C9eSphbojOXibjsHqHR4t0gWmeqyLp3X8cpHJ8K61+tRGYiEKkjsKO
	 fOO9pgLm1gUV3zKcQGMCbnfxkNUAHdiuYxtiJ50CDHVjG3IAjYb5XnMt1tgq2PMPFx
	 qN7vQNXb7pvsw==
Date: Fri, 3 Nov 2023 16:48:39 +0000
From: Simon Horman <horms@kernel.org>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v8 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
Message-ID: <20231103164839.GA714036@kernel.org>
References: <20231025141635.1459606-1-stefan.maetje@esd.eu>
 <20231025141635.1459606-3-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025141635.1459606-3-stefan.maetje@esd.eu>

On Wed, Oct 25, 2023 at 04:16:35PM +0200, Stefan Mätje wrote:
> This patch adds support for the PCI based PCIe/402 CAN interface family
> from esd GmbH that is available with various form factors
> (https://esd.eu/en/products/402-series-can-interfaces).
> 
> All boards utilize a FPGA based CAN controller solution developed
> by esd (esdACC). For more information on the esdACC see
> https://esd.eu/en/products/esdacc.
> 
> This driver detects all available CAN interface board variants of
> the family but atm. operates the CAN-FD capable devices in
> Classic-CAN mode only! A later patch will introduce the CAN-FD
> functionality in this driver.
> 
> Co-developed-by: Thomas Körper <thomas.koerper@esd.eu>
> Signed-off-by: Thomas Körper <thomas.koerper@esd.eu>
> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>

...

> +static int pci402_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct pci402_card *card = NULL;
> +	int err;
> +
> +	err = pci_enable_device(pdev);
> +	if (err)
> +		return err;
> +
> +	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
> +	if (!card)

Hi Thomas and Stefan,

If this condition is met then the function will return err,
but err is set to 0. Perhaps it should be set to an error value here?

Flagged by Smatch.

> +		goto failure_disable_pci;
> +
> +	pci_set_drvdata(pdev, card);
> +
> +	err = pci_request_regions(pdev, pci_name(pdev));
> +	if (err)
> +		goto failure_disable_pci;
> +
> +	card->addr = pci_iomap(pdev, PCI402_BAR, PCI402_IO_LEN_TOTAL);
> +	if (!card->addr) {
> +		err = -ENOMEM;
> +		goto failure_release_regions;
> +	}
> +
> +	err = pci402_init_card(pdev);
> +	if (err)
> +		goto failure_unmap;
> +
> +	err = pci402_init_dma(pdev);
> +	if (err)
> +		goto failure_unmap;
> +
> +	err = pci402_init_interrupt(pdev);
> +	if (err)
> +		goto failure_finish_dma;
> +
> +	err = pci402_init_cores(pdev);
> +	if (err)
> +		goto failure_finish_interrupt;
> +
> +	return 0;
> +
> +failure_finish_interrupt:
> +	pci402_finish_interrupt(pdev);
> +
> +failure_finish_dma:
> +	pci402_finish_dma(pdev);
> +
> +failure_unmap:
> +	pci_iounmap(pdev, card->addr);
> +
> +failure_release_regions:
> +	pci_release_regions(pdev);
> +
> +failure_disable_pci:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}

...

