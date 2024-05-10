Return-Path: <netdev+bounces-95256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CF78C1C23
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD821F23120
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06813AA59;
	Fri, 10 May 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxIKFcmT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BB13A3E3;
	Fri, 10 May 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304664; cv=none; b=aoQ+Td/3KB2uQDD9c7CpKfmOl3uhjmzrQGlbnL/hx70VkHPO0oZprJi/sxFDhDbgbDEMTJA5BDaD9IzZCwm2lsILMGD4NNGVO2jqDAjoTOWjEIqFi7HMZWw7PSiNAOkqz/Ql8QM1Oii7QGumHgv2qhQ81l6CyIoHTpF2nok9azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304664; c=relaxed/simple;
	bh=5dVzQx35gUbAAlIMFfqYviXSk3Ia0Y2lTQJTkV1hVGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBKGy8VLFXmueTxe2rV3qsBqGF+XZ8Cr63dkMXVyXptCGlEo3/r7lun3xp9oEOpckfpMSnohQIy5gDWvVg4GNI8HSPUlXYwjdDvouefM32U2KCRBpGPGkdhgB+RyhULysAvDbK3OeUalKU1AtoEUQFzM2tecX9KikuJpyAoWclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxIKFcmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BEAC116B1;
	Fri, 10 May 2024 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304664;
	bh=5dVzQx35gUbAAlIMFfqYviXSk3Ia0Y2lTQJTkV1hVGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XxIKFcmTAsKdpmrLRvHH+Q83NzQBseEX/Tjhklj+8RPUc00xzy5Qx2qjBTA5iqdfH
	 1gazVBq6razWM8DSWBemiRbWtIQeJZ0hTqZpIV27GFEkHy91tuQqVxfO3tLLE8DJIs
	 378nfD929SDHQ4f1579D9wFfA4GecQEKbsHDQRL8sl+UdkQE1Bmxr7PXS2XN6aEcOj
	 3tes81vRxuvyeNhaiI1kIk8hJey1PJtL/eMn45WR1nFLL7TA/1P8K08TN2u9NPMC5P
	 XAHljLA59cC3lFxo53m7MyzjsSFLpPDyZAR/BEo6B7xcPpL1Nk+DHDii5nvTUu8ff3
	 /Smw3bNXZstsw==
Date: Thu, 9 May 2024 18:31:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
 wake
Message-ID: <20240509183102.7c337c2c@kernel.org>
In-Reply-To: <20240509163216.108665-2-danielj@nvidia.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
	<20240509163216.108665-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 11:32:15 -0500 Daniel Jurgens wrote:
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index cf24f1d9adf8..ccf6976b1693 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -164,7 +164,8 @@ enum {
>  	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
>  	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
>  	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
> -	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,

Looks like an accidental removal?

> +	NETDEV_A_QSTATS_TX_STOP,
> +	NETDEV_A_QSTATS_TX_WAKE,

Since you'll have to respin let me nit pick on the docs, as I'm hoping
that those will be comprehensible to users not only devs.

> +        name: tx-stop
> +        doc: |
> +          Number of times the tx queue was stopped.

How about:

	Number of times driver paused accepting new tx packets
	from the stack to this queue, because the queue was full.
	Note that if BQL is supported and enabled on the device
	the networking stack will avoid queuing a lot of data at once.

> +        name: tx-wake
> +        doc: |
> +          Number of times the tx queue was restarted.

	Number of times driver re-started accepting send
	requests to this queue from the stack.

