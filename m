Return-Path: <netdev+bounces-111259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2B930713
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DB1F228E7
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3AF13D8B5;
	Sat, 13 Jul 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z1bsVl+U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760F1B28D
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720896612; cv=none; b=P4oy1OeHdDLzW7Hx/PleTlKJmsMcWAO11Nf9sPyraxT2tOFqbC4kfCU0Y+s1kcXl1kLMAVr22lXE2DCwRap+t7YCygosE/bFHwNT1SFUCjG5fAkEa4n4YbeONBmk8BPv8cy/Aq02aY/oiu4diJZp+JFF//TTX4eOWy3tKOeYijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720896612; c=relaxed/simple;
	bh=yE9YHoxgrWcBTKsNcw4yrXqhxNdVVWjvI97p+mOF8rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHrdCECYgU6dc1qV+hJtIRxXzDAWxE5u/b8uIfMYRjGWIDpCeHFtSw29vKmCsnPqkGvK3rqTTFrO8eIDE4vzTTCP42IOzKjGeXLpk5j2wGDnU0DibbSsiHuJ1h9s2DHV152WEamneY/tbw4N0Mv77HJ7jzV+yKTSnRToaFB3RWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z1bsVl+U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nac84ig0oaRcbYmSxZQlRwtHpCCiVKboY3fHx0HLV3s=; b=Z1bsVl+UPkxok9FMCxdk4+0QzJ
	75dKYEMZT/1KnLNdaIA/UGKPXElEqDYKRr0CZT1uiOsHtvr5zN+KiboSM3WBSq2Idj/DwDyoA1SL9
	JOKTzsaNNxSQBWH7vZfrkjCK6iPu0ozLp40S+vDn4XUsaTFWDAF+bPNp3Z0mSYHqOwvw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sShot-002TGv-2n; Sat, 13 Jul 2024 20:50:07 +0200
Date: Sat, 13 Jul 2024 20:50:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, kernel-team@meta.com
Subject: Re: [net-next PATCH v5 03/15] eth: fbnic: Allocate core device
 specific structures and devlink interface
Message-ID: <24ac80b6-ee09-4aee-b9f7-162a3377baa3@lunn.ch>
References: <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
 <172079936012.1778861.4670986685222676467.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172079936012.1778861.4670986685222676467.stgit@ahduyck-xeon-server.home.arpa>

> +int fbnic_alloc_irqs(struct fbnic_dev *fbd)
> +{
> +	unsigned int wanted_irqs = FBNIC_NON_NAPI_VECTORS;
> +	struct pci_dev *pdev = to_pci_dev(fbd->dev);
> +	int num_irqs;
> +
> +	wanted_irqs += 1;
> +	num_irqs = pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS + 1,
> +					 wanted_irqs, PCI_IRQ_MSIX);

nit picking, but this is a bit odd. Why not:

> +	unsigned int wanted_irqs = FBNIC_NON_NAPI_VECTORS + 1;
> +	num_irqs = pci_alloc_irq_vectors(pdev, wanted_irqs,
> +					 wanted_irqs, PCI_IRQ_MSIX);


> +	if (num_irqs < 0) {
> +		dev_err(fbd->dev, "Failed to allocate MSI-X entries\n");
> +		return num_irqs;
> +	}
> +
> +	if (num_irqs < wanted_irqs)
> +		dev_warn(fbd->dev, "Allocated %d IRQs, expected %d\n",
> +			 num_irqs, wanted_irqs);

https://elixir.bootlin.com/linux/latest/source/drivers/pci/msi/api.c#L206

 * Return: number of allocated vectors (which might be smaller than
 * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
 * available, other errnos otherwise.

So i don't think this is possible.

	Andrew

