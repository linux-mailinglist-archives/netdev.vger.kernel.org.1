Return-Path: <netdev+bounces-174239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEEFA5DF36
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62B27ADC51
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2F24DFE5;
	Wed, 12 Mar 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LON/BQBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B92033A
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790379; cv=none; b=hwqApL1+pEu6Gvq5l4Tj6RXqhW19nKIELheJHjHiKTAVDsKHSpyE7Y9ZjSxgpCTVrbyBmyZoyOB350q5djZUYKBp+4ZpsZraiNwki9JW+nIBL3OBYV2i06XpoOoHFKQbXvd4gVeHKa5c4tIC/sDuqUxkH4TMinPjxJsVV7kICpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790379; c=relaxed/simple;
	bh=wzOyZ1WbUkIIxejE/IiAmBfdyz501e4aCYCg2nwhqwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkWn/uGfIRcwFNI83fpocsv0oR8qtp9jRYGSq7s9U7bzCgtWjZg9qAZJE/Dt3JEKTCmvM+a8ieRInWXFpNX3eVWKoohq8t3t07Rvu6N9tMLrQJlmgzwEznKumnfdelPDLXhxCtY7UrUrnRE71oNI4hAy71bdydBfJHwp6nt2snM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LON/BQBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C8BC4CEDD;
	Wed, 12 Mar 2025 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741790379;
	bh=wzOyZ1WbUkIIxejE/IiAmBfdyz501e4aCYCg2nwhqwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LON/BQBAzj45lcsfCwMIGEgvC1u5Dsx1E7nSWFqQdX4peLPf8XlYqnigAKfOm0vYh
	 6zOcxZjTL2a2CCfbs5edinus5jQoHp3/o+4opwHqTmvSuGABKor7uMDqOYbpwz2Yqb
	 iO6OpNpyiMeShnfy7I/5Qsv7ihPc8mwgv9E3IJeBEi1EnBjkzMatet0aqU5bCrjYb7
	 enbnMY72mmRmlfGDICQpw8tK4VbZa26EtXH328B1Y1Gb/aUwmsfoPPGj8o3nH9QPJH
	 QQ6yiXiPfaTQou2yIe4ZiHSnLSeujd1FpSHyDX+O3O4QJLWYbUoBNehJRCXGB4xXE/
	 SAYPm1afwYtjQ==
Date: Wed, 12 Mar 2025 15:39:29 +0100
From: Simon Horman <horms@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Ahmed Zaki <ahmed.zaki@intel.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH net-next] net: ena: resolve WARN_ON when freeing IRQs
Message-ID: <20250312143929.GT4159220@kernel.org>
References: <20250310080149.757-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310080149.757-1-darinzon@amazon.com>

On Mon, Mar 10, 2025 at 10:01:48AM +0200, David Arinzon wrote:
> When IRQs are freed, a WARN_ON is triggered as the
> affinity notifier is not released.
> This results in the below stack trace:
> 
> [  484.544586]  ? __warn+0x84/0x130
> [  484.544843]  ? free_irq+0x5c/0x70
> [  484.545105]  ? report_bug+0x18a/0x1a0
> [  484.545390]  ? handle_bug+0x53/0x90
> [  484.545664]  ? exc_invalid_op+0x14/0x70
> [  484.545959]  ? asm_exc_invalid_op+0x16/0x20
> [  484.546279]  ? free_irq+0x5c/0x70
> [  484.546545]  ? free_irq+0x10/0x70
> [  484.546807]  ena_free_io_irq+0x5f/0x70 [ena]
> [  484.547138]  ena_down+0x250/0x3e0 [ena]
> [  484.547435]  ena_destroy_device+0x118/0x150 [ena]
> [  484.547796]  __ena_shutoff+0x5a/0xe0 [ena]
> [  484.548110]  pci_device_remove+0x3b/0xb0
> [  484.548412]  device_release_driver_internal+0x193/0x200
> [  484.548804]  driver_detach+0x44/0x90
> [  484.549084]  bus_remove_driver+0x69/0xf0
> [  484.549386]  pci_unregister_driver+0x2a/0xb0
> [  484.549717]  ena_cleanup+0xc/0x130 [ena]
> [  484.550021]  __do_sys_delete_module.constprop.0+0x176/0x310
> [  484.550438]  ? syscall_trace_enter+0xfb/0x1c0
> [  484.550782]  do_syscall_64+0x5b/0x170
> [  484.551067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Adding a call to `netif_napi_set_irq` with -1 as the IRQ index,
> which frees the notifier.
> 
> Fixes: de340d8206bf ("net: ena: use napi's aRFS rmap notifers")
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Thanks David,

I agree that having a notifier set should result in a WARN_ON,
and that your patch addresses this problem.

So, the nit below not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 6aab85a7..9e007c60 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1716,8 +1716,12 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
>  	int i;
>  
>  	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
> +		struct ena_napi *ena_napi;
> +
>  		irq = &adapter->irq_tbl[i];
>  		irq_set_affinity_hint(irq->vector, NULL);
> +		ena_napi = (struct ena_napi *)irq->data;

nit: I don't think it is necessary to explicitly cast irq->data
     to the pointer type of ena_napi because irq->data is a void *.

> +		netif_napi_set_irq(&ena_napi->napi, -1);
>  		free_irq(irq->vector, irq->data);
>  	}
>  }
> -- 
> 2.47.1
> 

