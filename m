Return-Path: <netdev+bounces-96526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32C8C6513
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EB6281351
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A165EE80;
	Wed, 15 May 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCOCZHFj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A45A7AB;
	Wed, 15 May 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769990; cv=none; b=cC01iWgmHAhhJ5+scMePEEMd1lrxb2rhBuSLpIPuuK9dhINbjxco3UGZWW8Rr9OLpAj3rViEU2ZZycziDzcAZh5uN9TKvNt9Jf2RjixMEMDN2JKOq+PDvsahu0Fp/7HMrFaKrU0cGxnDNw6wNWCDSCTTmKwFEZ6+ksbLGIyddUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769990; c=relaxed/simple;
	bh=/rLKChhWLP3moBzwPC9iIEN3AWU0pKFpfn1wMMxX0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeTbbZMLck6qAHdv43xmPadb9meWCLawIYxw1PsfgKGNtpr5H7bO2eQgVnk3BSiZkKPWOjzjH8mXwD1rrWBUAhel+TkWRUBvwkNkog0SorpC4ZqmkxlJBTHz1d9/m7bKvkSF2SmrGs6wcpKfc98cM4jW+IBNY4ypgEEwNX5bjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCOCZHFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E89C116B1;
	Wed, 15 May 2024 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715769990;
	bh=/rLKChhWLP3moBzwPC9iIEN3AWU0pKFpfn1wMMxX0S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCOCZHFjGs+4hl9Elm+1KR5bv1Q8AlpOOFTS3ECufjk9GzxCMQyEHDHn0FZSPJq2G
	 BUzhVOxsaNRS4hmgOZCulLJgX+tLj0iJoyFMJnRmS+9SXneipEf0UxTDWGFZy2lQuG
	 ZmfDDUrMkngptubVOXcuCY3qD8/reCh7ItEVPnToWQIdzUhUQvZxbnYcAX00XnYWuJ
	 M6gTivVLmqWrWlEiYS9J3WQskoQC6RT/BLbN69BcTybRuqsXBt3mj8xDku72RS4m9/
	 /HkkSVYFFCsnRA+yRZNNivi/Qy/MY76KOeIYWQgtQUbnfnb6KNmMklZZSQbIhzCK3U
	 U9I/RyD/jiLXg==
Date: Wed, 15 May 2024 11:46:26 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] vmxnet3: add latency measurement support in
 vmxnet3
Message-ID: <20240515104626.GE154012@kernel.org>
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
 <20240514182050.20931-3-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514182050.20931-3-ronak.doshi@broadcom.com>

On Tue, May 14, 2024 at 11:20:47AM -0700, Ronak Doshi wrote:
> This patch enhances vmxnet3 to support latency measurement.
> This support will help to track the latency in packet processing
> between guest virtual nic driver and host. For this purpose, we
> introduce a new timestamp ring in vmxnet3 which will be per Tx/Rx
> queue. This ring will be used to carry timestamp of the packets
> which will be used to calculate the latency.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

...

> index b3f3136cc8be..74cb63e3d311 100644
> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
> @@ -143,6 +143,29 @@ vmxnet3_tq_stop(struct vmxnet3_tx_queue *tq, struct vmxnet3_adapter *adapter)
>  	netif_stop_subqueue(adapter->netdev, (tq - adapter->tx_queue));
>  }
>  
> +static u64
> +vmxnet3_get_cycles(int pmc)
> +{
> +	u32 low, high;
> +
> +	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (pmc));
> +	return (low | ((u_int64_t)high << 32));
> +}

Hi Ronak,

This seems to open-code the rdpmc macro.

And it also seems to exclude compilation of this driver other than for x86.
This seems undesirable as, in general, networking drivers are supposed to
be architecture independent. I'd say, doubly so, for software devices.

Moreover, rdpmc outside of x86 architecture-specific code seems highly
unusual to me. So I wonder if there is a better approach to the problem at
hand.

If not, I would suggest making this feature optional and only compiled
for x86. That might mean factoring it out into a different file. I'm
unsure.

If not, I think the driver's Kconfig needs to be updated to reflect
that it can only be compiled for x86.

...

