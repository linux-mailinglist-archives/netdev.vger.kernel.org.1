Return-Path: <netdev+bounces-59709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC981BDA6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098041C248FE
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B4634E2;
	Thu, 21 Dec 2023 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMKAtZYn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DABA2F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41850C433C7;
	Thu, 21 Dec 2023 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703181226;
	bh=otq+51sDpwuu6FdVfb96T5VYHgIqRfkiIi00Cq4xl9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMKAtZYn7RXsk9D4FCAKPmbWPs0JgyV8JvO1iDvieiXgvM59HvqaSQq9HFe/SPEh4
	 15tcp632Gr21i1Vizbyw/Al5sTGvwW3UZ9etsuQH8G0LPExkwGnF+yrSWixhFnfrap
	 xzl0C+oDRgmkRiq18vxCnabVxykSMiLyqYtPvnI+GKLsx5TIQQztClmDEL8/jowZuM
	 ebb+YQ5yKgRFVb4xxpnqVkrPO3Lf0SC8As6Eh97GbjIuu2rRn41AirsnPh/A8PkAx2
	 G1BkOKsUlbcpUWU/zEdJ0kW4gwaubnKRoxk0upd2WtgmczONJQy54c14tGEIEyGb8D
	 2fgymRwc0J81g==
Date: Thu, 21 Dec 2023 18:53:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.com,
	vsankar@lenovo.com, danielwinkler@google.com, nmarupaka@google.com,
	joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [PATCH v1] net: wwan: t7xx: Add fastboot interface
Message-ID: <20231221175332.GD1202958@kernel.org>
References: <MEYP282MB26975911A05EB464E9548BA8BB95A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB26975911A05EB464E9548BA8BB95A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

On Thu, Dec 21, 2023 at 03:09:51PM +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> To support cases such as firmware update or core dump, the t7xx
> device is capable of signaling the host that a special port needs
> to be created before the handshake phase.
> 
> Adds the infrastructure required to create the early ports which
> also requires a different configuration of CLDMA queues.
> 
> On early detection of wwan device in fastboot mode, driver sets
> up CLDMA0 HW tx/rx queues for raw data transfer and then create
> fastboot port to user space.
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

...

> @@ -729,8 +792,17 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
>  
> +	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
> +				 &t7xx_mode_attribute_group);
> +	if (ret) {
> +		t7xx_md_exit(t7xx_dev);
> +		return ret;
> +	}

Hi Jinjian,

Please consider using goto labels for unwind on error in this function.
Something like this (completely untested!):

	if (ret)
		goto err_md_exit;

	...
	if (ret)
		goto err_remove_group;

	...
	return 0;

err_remove_group:
	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
			   &t7xx_mode_attribute_group);
err_md_exit:
	t7xx_md_exit(t7xx_dev);
	return ret;

The reason that I as for this more idiomatic form is that,
in my experience, it is less error prone and easier
to maintain.

> +
>  	ret = t7xx_interrupt_init(t7xx_dev);
>  	if (ret) {
> +		sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
> +				   &t7xx_mode_attribute_group);
>  		t7xx_md_exit(t7xx_dev);
>  		return ret;
>  	}

