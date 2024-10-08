Return-Path: <netdev+bounces-133002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA3994394
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C41F236C2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9CE1DEFFE;
	Tue,  8 Oct 2024 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Kum/5HWy"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA871144D21;
	Tue,  8 Oct 2024 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378156; cv=none; b=r20CP8jtxC/6Nn2XPJxMQgSZ4xsgaJpaL2rhoNUfKqABr82gGNxPuIahxqQN2or4Wdj47ke4ATQuTeSuR9rYRlCXjDxgKxkSpZ+iVYRDC+/F4RqNDTSYvGVm42Ii70M9ZjmPNW2NqDmFSiMTKQm4UI7F3Oe8uY0uFkOIz2FeiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378156; c=relaxed/simple;
	bh=Z+xX2hO+f6E9zNQiPiOWxzg4gaZDgAqj12yTVOPS7wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ttZbquQEkxBz2AqEOpiw4r9X5NsftcLONZdZ8cQIQ3xvdLsL/OVj4VQUvm/p1mUu+SQAisCwUxVYOS5Qe8nwLn/hts6JQ/Z8I11sGUVReBF/dSrSfcxz3A3TXNwQkrO+RCJcgAIjohyFgNxtTJ70VO0pExt73XKTsX2xciNt50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Kum/5HWy; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EEA04A0365;
	Tue,  8 Oct 2024 11:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=3OUMxFnYySkHZFxMjl63
	3WdFfTbIPbjkXbDMeFM8SHw=; b=Kum/5HWyjLJ8XrhOgPSD6ADADRCE0EKaaDv7
	XRpa4oinShiKCufUn0FiedkBb8pVW8PnX6qkppg8WoOhYOKw/JP4/ZzvQDnnyLF9
	oP2hRxJjWuMDJu/tiD3fHmQN8jEY/ttf4z/v+4IoieyuSsKNznXKzZ6EBr2uooI+
	k0tKFqNc4asesFyec6vGBnZrufkc4Q6n2lXrFBiyblLrEBly99LVPPMm73oKdGBP
	eqytXrvtCRUmQkU2VgWfqIC74+mKU9mQmVxT31/WmVyVd/8acTgTo0Uep1mEJ1Or
	HB5q2TCmakRitfxTa8mXrVHPL6S5K130pMMnIUpM4bEL9PWtQgHASXKR/Z95eWiC
	CDT4xuEwJYM9Lggt2iyh5smfroDLCfYobYHUbSeT3JmF/GhrjdzWUcZ1umD0JrQS
	sxAHwAwPWhWMtrw/v9spUs/yaduwO05z4vai/5n0Gtq98NZZwANK61iGKf0NQhz/
	JNzPRzkY5dC3mESYsmD+3J+X+B40fsmkCBTR8nu+NLXzMgzpInjTrWWHMbZz/l2o
	8pJkN2lYiu0K3HOYWGtStdT6ozRVTb0IwdN/Wwz7xjeS4PsvU30D0n/dugY7lNK7
	3v28kj4wOPtuQZK0njYM80p/nZOJ77hSl0KNQIsnF1Cf/uWfwDcK1KF5WaFGWN56
	o6rB8WE=
Message-ID: <da9833c7-ad3d-48f5-b846-add3e57433a0@prolan.hu>
Date: Tue, 8 Oct 2024 11:02:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
To: Wei Fang <wei.fang@nxp.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>
CC: <linux@roeck-us.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241008061153.1977930-1-wei.fang@nxp.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241008061153.1977930-1-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855657D63

On 2024. 10. 08. 8:11, Wei Fang wrote:
> Some platforms (such as i.MX25 and i.MX27) do not support PTP, so on
> these platforms fec_ptp_init() is not called and the related members
> in fep are not initialized. However, fec_ptp_save_state() is called
> unconditionally, which causes the kernel to panic. Therefore, add a
> condition so that fec_ptp_save_state() is not called if PTP is not
> supported.
> 
> Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net/
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 60fb54231ead..1b55047c0237 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1077,7 +1077,8 @@ fec_restart(struct net_device *ndev)
>   	u32 rcntl = OPT_FRAME_SIZE | 0x04;
>   	u32 ecntl = FEC_ECR_ETHEREN;
>   
> -	fec_ptp_save_state(fep);
> +	if (fep->bufdesc_ex)
> +		fec_ptp_save_state(fep);
>   
>   	/* Whack a reset.  We should wait for this.
>   	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> @@ -1340,7 +1341,8 @@ fec_stop(struct net_device *ndev)
>   			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
>   	}
>   
> -	fec_ptp_save_state(fep);
> +	if (fep->bufdesc_ex)
> +		fec_ptp_save_state(fep);
>   
>   	/* Whack a reset.  We should wait for this.
>   	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC

Thanks, it seems fec_ptp_restore_state() was properly guarded, but 
save_state() was not. Sorry for that.

Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>


