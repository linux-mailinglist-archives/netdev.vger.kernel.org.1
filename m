Return-Path: <netdev+bounces-208951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57575B0DAAE
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C486C641B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70D2E06DC;
	Tue, 22 Jul 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBgZ/k+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67621578D;
	Tue, 22 Jul 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190763; cv=none; b=Dtb87VcU7iCJ2fCVb2+cQJXndOBo8o05GM0CGb8vTjk4tYmyocHrQWdZS7MXOlcOkLiL2EyY+1vtsornCRd0AxcFOH+Ref5JyjSuC5zpB6ZybU2YBpAi2YuwdeJZ/njPVhUHf2iyg4NUTZzZ3GSHs+o8oPWIz8nkFLiZ/UvuNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190763; c=relaxed/simple;
	bh=2G9bddbZwoNTFhA6KUgUm/NpGwiqTQB1LkofRP3WhPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwBHC86t8oJ/VmBc1msB6xdvZtB/VuJOqnVwcQSi+6dZZAW2wuoTJPzSP/7x30YyTBm1qSms1Q/awoUd9/v55CEQ1ieEJ1M0ErExkwBQojdhIQhMnGaWJ1fUGl4t50g0t0Rp2U+2xZSKGO2Q8XTUKpO7DiWwUZ4NhThdLBk74L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBgZ/k+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBC5C4CEEB;
	Tue, 22 Jul 2025 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753190763;
	bh=2G9bddbZwoNTFhA6KUgUm/NpGwiqTQB1LkofRP3WhPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBgZ/k+yfidNfQtpXzHjF1lDHbQsdOrB8h+CwEf2wRgQon48wLAHVlvoDSaBSwCes
	 IWEzM0cSopnVptO+RO2XaLLBV8T4VxmXjmyGvQEm7kuviv/ONTB75WHrDo11zCPKvT
	 HiUHUPPwcyaJejejSwUVRODuEmSh+eO4CMPIwRMJNP6RSBGNGYlsySsciSNSbCq6zn
	 mYqhVKnL3f30GLdwF8JFWCTrLPCzETJiw++vPdhclDhFqnCrzHNcPH2OA/qGfGcYJd
	 nFDPTVDQC/aO/adKfL/okBqDQLULAEI7xBDRYQSSv3GhiF/TeFljBIIhIkHf3/MKYs
	 w6/MqJjJ/EagQ==
Date: Tue, 22 Jul 2025 14:25:57 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] net: rnpgbe: Add irq support
Message-ID: <20250722132557.GI2459@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-9-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-9-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:31PM +0800, Dong Yibo wrote:
> Initialize irq functions for driver use.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

...

> +/**
> + * rnpgbe_acquire_msix_vectors - Allocate msix vectors
> + * @mucse: pointer to private structure
> + * @vectors: number of msix vectors

Please also document the return value for functions
that have one and a kernel doc.

Flagged by ./scripts/kernel-doc --none -Wall

> + **/
> +static int rnpgbe_acquire_msix_vectors(struct mucse *mucse,
> +				       int vectors)

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

...

> +/**
> + * rnpgbe_msix_other - Other irq handler
> + * @irq: irq num
> + * @data: private data
> + *
> + * @return: IRQ_HANDLED
> + **/
> +static irqreturn_t rnpgbe_msix_other(int irq, void *data)
> +{
> +	struct mucse *mucse = (struct mucse *)data;
> +
> +	set_bit(__MUCSE_IN_IRQ, &mucse->state);
> +	clear_bit(__MUCSE_IN_IRQ, &mucse->state);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * register_mbx_irq - Regist mbx Routine

Register

> + * @mucse: pointer to private structure
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int register_mbx_irq(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	struct net_device *netdev = mucse->netdev;
> +	int err = 0;

Nit, unlike most of this patch(set) the above doesn't follow
reverse xmas tree order - longest line to shortest - for variable
declarations.

Edward Cree's tool can be useful here.
https://github.com/ecree-solarflare/xmastree/


> +
> +	/* for mbx:vector0 */
> +	if (mucse->num_other_vectors == 0)
> +		return err;
> +	/* only do this in msix mode */
> +	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
> +		err = request_irq(mucse->msix_entries[0].vector,
> +				  rnpgbe_msix_other, 0, netdev->name,
> +				  mucse);
> +		if (err)
> +			goto err_mbx;
> +		hw->mbx.ops.configure(hw,
> +				      mucse->msix_entries[0].entry,
> +				      true);
> +		hw->mbx.irq_enabled = true;
> +	}
> +err_mbx:
> +	return err;
> +}

...

