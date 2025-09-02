Return-Path: <netdev+bounces-219105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BCDB3FDC5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7F37A2693
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878A12F6581;
	Tue,  2 Sep 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xCx54zKi"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B02ED870
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812456; cv=none; b=eIOc7feo96mCCWPGbFby603dJS631UYGUoisKlraE0O42JHck8WS61zxXFXjBgMez2Wm9ax/Uf61/NMMyvkPI9i7Vy7tID0qREjURyKrrQkPrDDZ6SNGgKpLX+H16N+AHOiUAib+zFyi0ImQUQpU4jlhvvQHbhNOs47dB+BmDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812456; c=relaxed/simple;
	bh=/JXOjGh4jT/TCQiLeH7evpZHmaOgNXOxW1XjD/YXOxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKot+JnZN8XAlkfRmZWrqmSpPM3OuJCLdTvqhIDOJukc2PwC0pO1uT5/kIW+jIM9zQs8VS6Qo473QdKD2s2ejluf50sIREa2Ut+RjQFT8Rbk/on9o94NZr3yaFH99+nr8JMv3GpFDQBlOtZRyO5tk46bdc1pLYPypm05ITI/Uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xCx54zKi; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26c0cd9c-ad24-4b71-9a1a-d046b94d9333@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756812452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjuMAF6x2C7Y8qlg9yXCuClA+VXqEPKyCJn/KO2TycM=;
	b=xCx54zKiy5JYlY4xA0reccCPyd3bSu+DqnFgijhn3sU3m6TiLAn7WqXLEDj/KMNDnPbQi2
	3Jc4V0EcRGg4a7F+5NdGzv+TxF+Ty7FmVJuPiVwZ025yzb0yNpRv6teShuq+i+4vCzx5c4
	X/QcOQJGrVIoi+WMLcvUj1LPC8skWtg=
Date: Tue, 2 Sep 2025 12:27:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next 2/2] idpf: add direct method for disciplining Tx
 timestamping
To: Anton Nadezhdin <anton.nadezhdin@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
References: <20250902105321.5750-1-anton.nadezhdin@intel.com>
 <20250902105321.5750-3-anton.nadezhdin@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250902105321.5750-3-anton.nadezhdin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2025 11:50, Anton Nadezhdin wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Currently IDPF supports only mailbox access to PHC operations and
> Tx timestamping, however the driver shall also be able to handle direct
> access. The difference is that PHC/timestamps actions are performed
> directly, through BAR registers, instead of sending a virtchnl message to
> CP. Registers offsets are negotiated with the CP during the capabilities
> negotiation.
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

[...]

> -static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
> +static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb,
> +				u32 buf_id)
>   {
>   	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
> -	struct idpf_ptp_tx_tstamp_status *tx_tstamp_status;
> +	struct idpf_ptp_tx_tstamp_status *tx_tstamp_status = NULL;

this breaks reverse x-mass tree aligment...

> +	enum idpf_ptp_access access;
> +	int err;

