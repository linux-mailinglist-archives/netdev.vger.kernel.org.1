Return-Path: <netdev+bounces-198141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8EADB603
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05353188DD1B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D61FFC59;
	Mon, 16 Jun 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGoyOaNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA72CA9;
	Mon, 16 Jun 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089654; cv=none; b=EDNKsvszoxuvRynDnK/itBVZ/7bfmCNzrY0fcWZp9fnILI2o+o5/Zh40YqcbFq8lvZ7jz8MvlT2omq6XraI9ixEnZDG2CDxw+B5KBtT6VFKXoR+t033/9/6BaE867rUw3yfmy6NcubHrXAUU/PCk9yuMI0ani6En3onnMiDhB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089654; c=relaxed/simple;
	bh=AGgS9xG+XXtQyt/GqvZ5d2Bo7FUBHRlUWYBdw/v1s6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klw8C0ee3gQ9/BhSTlsqlcx23G/FH8Qsb0lGFhMQOHc9GVp2TDrHLmwcc3AJJ7UrlaC5aV6vuHJX9gmSavr8okLYQYPEbPPV+1YpFoNuV5gwBEDi8tvyHh2M+XXUvpIdDHLExl+qKMCu1CSLG2TVoh/aH1ftoWNJw5AMFEADCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGoyOaNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9775C4CEEA;
	Mon, 16 Jun 2025 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750089653;
	bh=AGgS9xG+XXtQyt/GqvZ5d2Bo7FUBHRlUWYBdw/v1s6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGoyOaNsHXLG/dyPjvdpKthHE6Yn0f0W7B7fIe0+RDg3s6I6zHdMC2LxzoBMgfKRx
	 5lHzF18eHFJMwRvJ/9adL3kYDTTQ2fu7fskIIJmHkj1vMjmaNVdu4/sj+tyy/e/o4k
	 3tucyYGxsTdjIkuJS+vMf7GZiNA05lu3Oq7t3qM6WVlyVd7LFYYItTrJCIaYMDxl5o
	 M5dWWU1Trgr1XOJtQdoh6c5TGV1cP4VxIMMSDbM3nJojg5+yHIdtQyLRCxonerPwjr
	 lWFeVkiSV4nW4nAGYpmQPNDqX2btNAtFGLjDKstFATjaeVtiLzJm7FTlu19U4iucnI
	 EydrqqKmbkVew==
Date: Mon, 16 Jun 2025 17:00:47 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v10 09/14] dpll: zl3073x: Register DPLL devices
 and pins
Message-ID: <20250616160047.GG6918@horms.kernel.org>
References: <20250615201223.1209235-1-ivecera@redhat.com>
 <20250615201223.1209235-10-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615201223.1209235-10-ivecera@redhat.com>

On Sun, Jun 15, 2025 at 10:12:18PM +0200, Ivan Vecera wrote:
> Enumerate all available DPLL channels and registers a DPLL device for
> each of them. Check all input references and outputs and register
> DPLL pins for them.
> 
> Number of registered DPLL pins depends on configuration of references
> and outputs. If the reference or output is configured as differential
> one then only one DPLL pin is registered. Both references and outputs
> can be also disabled from firmware configuration and in this case
> no DPLL pins are registered.
> 
> All registrable references are registered to all available DPLL devices
> with exception of DPLLs that are configured in NCO (numerically
> controlled oscillator) mode. In this mode DPLL channel acts as PHC and
> cannot be locked to any reference.
> 
> Device outputs are connected to one of synthesizers and each synthesizer
> is driven by some DPLL channel. So output pins belonging to given output
> are registered to DPLL device that drives associated synthesizer.
> 
> Finally add kworker task to monitor async changes on all DPLL channels
> and input pins and to notify about them DPLL core. Output pins are not
> monitored as their parameters are not changed asynchronously by the
> device.
> 
> Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

...

> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c

...

> +static int
> +zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
> +{
> +	struct kthread_worker *kworker;
> +	struct zl3073x_dpll *zldpll;
> +	unsigned int i;
> +	int rc;
> +
> +	INIT_LIST_HEAD(&zldev->dplls);
> +
> +	/* Initialize all DPLLs */
> +	for (i = 0; i < num_dplls; i++) {
> +		zldpll = zl3073x_dpll_alloc(zldev, i);
> +		if (IS_ERR(zldpll)) {
> +			dev_err_probe(zldev->dev, PTR_ERR(zldpll),
> +				      "Failed to alloc DPLL%u\n", i);

Hi Ivan,

Jumping to the error label will return rc.
But rc may not be initialised here.

Flagged by Smatch.

> +			goto error;
> +		}
> +
> +		rc = zl3073x_dpll_register(zldpll);
> +		if (rc) {
> +			dev_err_probe(zldev->dev, rc,
> +				      "Failed to register DPLL%u\n", i);
> +			zl3073x_dpll_free(zldpll);
> +			goto error;
> +		}
> +
> +		list_add(&zldpll->list, &zldev->dplls);
> +	}
> +
> +	/* Perform initial firmware fine phase correction */
> +	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
> +	if (rc) {
> +		dev_err_probe(zldev->dev, rc,
> +			      "Failed to init fine phase correction\n");
> +		goto error;
> +	}
> +
> +	/* Initialize monitoring thread */
> +	kthread_init_delayed_work(&zldev->work, zl3073x_dev_periodic_work);
> +	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldev->dev));
> +	if (IS_ERR(kworker)) {
> +		rc = PTR_ERR(kworker);
> +		goto error;
> +	}
> +
> +	zldev->kworker = kworker;
> +	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
> +
> +	/* Add devres action to release DPLL related resources */
> +	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
> +	if (rc)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	zl3073x_dev_dpll_fini(zldev);
> +
> +	return rc;
> +}
> +

...

-- 
pw-bot: cr

