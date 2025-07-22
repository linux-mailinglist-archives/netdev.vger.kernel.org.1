Return-Path: <netdev+bounces-208969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A30DB0DCBE
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A6B188E311
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E803A32;
	Tue, 22 Jul 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPdOBtGx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E11A255C;
	Tue, 22 Jul 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193012; cv=none; b=LX7twg0uNiXjQOkbei3+PA8TLCVzqf/mLndHuGHPenSIvFZ9jwDosaFI9Ns9aWSyJOv0z/td1/8qeNYxXiJr+y+M2NZ77bn39a9b46Vn4LOtCjNQIhlBTlrickVnwtmgEx8Q8yuXEXbfkhZ5C7ny1I3oSEgowwO6G6zzufdeaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193012; c=relaxed/simple;
	bh=OIhJT9qB4odJKDzQ05OJtu5Oq7f7NSRQ22vsVg7V6hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU30pMtJ+z+Qu/moLnbXordeCCaIVphKXiEGrm+dMjcteUEyVODIkQIW4W7yLPlpfqeYkQVRDu+zYwtBlWm+4hwnvXNFFK1sOu724PMW6Q+PVdUq3QXwIWNZdXuumNsfThrepXu/wgX++pL51pcDNUahuw8z7mMH+xP1PHM4ZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPdOBtGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829EC4CEEB;
	Tue, 22 Jul 2025 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753193012;
	bh=OIhJT9qB4odJKDzQ05OJtu5Oq7f7NSRQ22vsVg7V6hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPdOBtGx3RpdDNa0PyBrTiXWHyr8V3H106YhdqtxzagIUw/hWj0zVKijWdYEPEvtU
	 4VwBvg3U+BlKaILat2fMeJ+7bvUct00xticXiWaTZKBcGf5qUsv5RoSZ8Vijha1B6u
	 fbZQlIjkgQnR5cySRc3ZsXfK8/drnE2EVRMkfSy34hWFnGuI6nEEoE8mGtAreQH8C9
	 50Ft/lsZNYJz/vLo5GhMC0XH5yPA5iXljkccMPSoNhs4k0hU8eL5ZgY5ze/qnYEUre
	 YvG7Q6fyM0RPNjQJU7J7v1LeF9U9vGgxYyRjddmpFzAKC61I0aeOtYg+4TStMaFgjf
	 XN1aC3ea8h1bA==
Date: Tue, 22 Jul 2025 15:03:26 +0100
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
Subject: Re: [PATCH v2 10/15] net: rnpgbe: Add netdev irq in open
Message-ID: <20250722140326.GJ2459@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-11-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-11-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:33PM +0800, Dong Yibo wrote:
> Initialize irq for tx/rx in open func.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c

...

> +/**
> + * rnpgbe_set_mac_hw_ops_n500 - Setup mac address to hw
> + * @hw: pointer to hw structure
> + * @mac: pointer to mac addr
> + *
> + * Setup a mac address to hw.
> + **/
> +static void rnpgbe_set_mac_hw_ops_n500(struct mucse_hw *hw, u8 *mac)
> +{
> +	struct mucse_eth_info *eth = &hw->eth;
> +	struct mucse_mac_info *mac_info = &hw->mac;

Reverse xmas tree here please.

> +
> +	/* use idx 0 */
> +	eth->ops.set_rar(eth, 0, mac);
> +	mac_info->ops.set_mac(mac_info, mac, 0);
> +}

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

...

> +/**
> + * rnpgbe_msix_clean_rings - msix irq handler for ring irq
> + * @irq: irq num
> + * @data: private data
> + *
> + * rnpgbe_msix_clean_rings handle irq from ring, start napi

Please also document the return value of this function.
Likewise for rnpgbe_request_msix_irqs(), rnpgbe_intr() and
rnpgbe_request_irq().

> + **/
> +static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
> +{
> +	return IRQ_HANDLED;
> +}

...

> +/**
> + * rnpgbe_request_msix_irqs - Initialize MSI-X interrupts
> + * @mucse: pointer to private structure
> + *
> + * rnpgbe_request_msix_irqs allocates MSI-X vectors and requests
> + * interrupts from the kernel.
> + **/
> +static int rnpgbe_request_msix_irqs(struct mucse *mucse)
> +{
> +	struct net_device *netdev = mucse->netdev;
> +	int q_off = mucse->q_vector_off;
> +	struct msix_entry *entry;
> +	int i = 0;
> +	int err;
> +
> +	for (i = 0; i < mucse->num_q_vectors; i++) {
> +		struct mucse_q_vector *q_vector = mucse->q_vector[i];
> +
> +		entry = &mucse->msix_entries[i + q_off];
> +		if (q_vector->tx.ring && q_vector->rx.ring) {
> +			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
> +				 "%s-%s-%d", netdev->name, "TxRx", i);

Probably the full range of i is not used, in particular I assume
it is never negative, and thus i and mucse->num_q_vectors
could be unsigned int rather than int.

But as it stands q_vector->name is once character too short to
fit the maximum possible string formatted by snprintf().

I was able to address the warning flagged by GCC 15.0.0 about this by
increasing the size of q_vector->name by one byte.

  .../rnpgbe_lib.c: In function 'rnpgbe_request_irq':
  .../rnpgbe_lib.c:1015:43: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
   1015 |                                  "%s-%s-%d", netdev->name, "TxRx", i);
        |                                           ^
  In function 'rnpgbe_request_msix_irqs',
      inlined from 'rnpgbe_request_irq' at drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c:1069:9:
  .../rnpgbe_lib.c:1014:25: note: 'snprintf' output between 8 and 33 bytes into a destination of size 32
   1014 |                         snprintf(q_vector->name, sizeof(q_vector->name) - 1,
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1015 |                                  "%s-%s-%d", netdev->name, "TxRx", i);
        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


> +		} else {
> +			/* skip this unused q_vector */
> +			continue;
> +		}
> +		err = request_irq(entry->vector, &rnpgbe_msix_clean_rings, 0,
> +				  q_vector->name, q_vector);
> +		if (err)
> +			goto free_queue_irqs;
> +		/* register for affinity change notifications */
> +		q_vector->affinity_notify.notify = rnpgbe_irq_affinity_notify;
> +		q_vector->affinity_notify.release = rnpgbe_irq_affinity_release;
> +		irq_set_affinity_notifier(entry->vector,
> +					  &q_vector->affinity_notify);
> +		irq_set_affinity_hint(entry->vector, &q_vector->affinity_mask);
> +	}
> +
> +	return 0;
> +
> +free_queue_irqs:
> +	while (i) {
> +		i--;
> +		entry = &mucse->msix_entries[i + q_off];
> +		irq_set_affinity_hint(entry->vector, NULL);
> +		free_irq(entry->vector, mucse->q_vector[i]);
> +		irq_set_affinity_notifier(entry->vector, NULL);
> +		irq_set_affinity_hint(entry->vector, NULL);
> +	}
> +	return err;
> +}

...

