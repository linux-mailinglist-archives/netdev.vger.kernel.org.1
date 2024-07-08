Return-Path: <netdev+bounces-109821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D392A054
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EED1F21714
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F5757FD;
	Mon,  8 Jul 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="FSIKw65O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19378C65
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435042; cv=none; b=IHRvaNrbMxvxsjfnMkfqhsONLYuGaZ1BiTDc6ySC39+WesHSVLFDNGI6EcgkaF6iZMK8CkOco9bHe6/OP29bccnCifF/MthTWXB0927B//Xsdx5Z4bAuUW6EMVISLafNqMTjYI0ZM4KD12zqZ+AGkCqgOpNg6T6Anjy7TyFsxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435042; c=relaxed/simple;
	bh=N2WHA+JyafefC7T3U9sVeROH+yTHZgwAlOUi7SBBypA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txltgN4odiu61Ue1ZcImvfM+siJ2U+DwIB9oK04LQ7Rh31cbawIiXDcMQ1iTlOtZfWPgNSMaYgX1iIrhX+bpz2pNDkppvtYeqo9ebNhbXIDl9466VZoNKzRmqAyMavgCykRWah3DTWSK87gBIRH0QuCTEWzScMm4RzNcODPH9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=FSIKw65O; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so4113107e87.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1720435039; x=1721039839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I+6+md5AvZiZMglgF+6qDikTNKGK1lYpVvgJljGblCg=;
        b=FSIKw65Okurs8fR85p5yy7mhpdutzWQuX/RlTEddUX3z7zEVS0h5bIzWWIoOXsJ7oi
         cvNE5tsgOP98pmX9i7DHAPu3md5nwFzUJ8bqnOIgzt8zWxjO4xjQeslaaKK4QDC83GKf
         N8j6UdttfiAez/YBXAhZi0oxmcEeD0QbkJClZtgBP/vZb2BI8dYOoa4hVNrksWiEWXNp
         pkK/e0767iMSQwAxitHAayhqe0/GZGcQUF3wkytn8j21jOAfMSCm/s2Wn3RG05CNCrmr
         ST2oOgq+VTR3I8EHhbmawHi3hKMuHvFcVEq4DJ99Dz1vIvUYBl4uYSefC/c6ClruVB7r
         zf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435039; x=1721039839;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+6+md5AvZiZMglgF+6qDikTNKGK1lYpVvgJljGblCg=;
        b=mTvW8r0jL7q+4t4YmO6rX+v13My9XczeTqQtwF2e9FrF6BUwx7u/GEIrRrmpQeRPSj
         b0kW10adhQdiUiT7IotLhZ9hD9jUVmAND7jhujtz2DD5/xpfB3J7L4r9r8VsckdcWGBB
         N1CcbRT+Fwllc8O5jq/nn577QvWZfhPz/J1vQwDQjDZeS4ZcmPGTinYzyZ6msfT8/2wU
         jJ0bwDr0iJmE9/CUS6GcNTydG0r6/M+vylWh0f1EvmeMrIJ3rYY5QOBzZrAgYKxF3iX3
         VliastvkcHG20NNh7Rf/fxLpLGrJpf/Z/+8qwz+oZLocvl/JdQyjd8BJHI9/FUd+Qd6L
         NvgQ==
X-Gm-Message-State: AOJu0YzkdmO5Ly7UvKsaHSNHYZvCcODsMUTVmC1isdggr3naMepRUAf5
	yhAlXIGJxMmawo91k/q2n8DJ5tW4/qnKMeFHRBsOaoc3L2OWSKBcUVXUamLGAg==
X-Google-Smtp-Source: AGHT+IELSQE9UuAZvPmNq52w7dMN7ppDjMxZ8m74ZoLMpbTW2RQbbQ5dBRoSLYsunPnfcrtwRLPgGg==
X-Received: by 2002:ac2:59c2:0:b0:52e:9b5c:1c6f with SMTP id 2adb3069b0e04-52ea0636832mr7949400e87.10.1720435037561;
        Mon, 08 Jul 2024 03:37:17 -0700 (PDT)
Received: from [192.168.1.34] ([95.161.223.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea9fa20ccsm616902e87.252.2024.07.08.03.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:37:16 -0700 (PDT)
Message-ID: <a669fd2d-f8e2-4dc8-b55b-ccdc10922481@bell-sw.com>
Date: Mon, 8 Jul 2024 13:37:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bna: adjust 'name' buf size of bna_tcb and bna_ccb
 structures
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240625191433.452508-1-aleksei.kodanev@bell-sw.com>
 <20240627141755.GG3104@kernel.org>
Content-Language: en-US
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Autocrypt: addr=aleksei.kodanev@bell-sw.com; keydata=
 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
 SKzhlhbWzHw=
In-Reply-To: <20240627141755.GG3104@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon!
On 27.06.2024 17:17, Simon Horman wrote:
> + Eric Dumazet, Jakub Kicinski, Paolo Abeni
> 
> On Tue, Jun 25, 2024 at 07:14:33PM +0000, Alexey Kodanev wrote:
>> To have enough space to write all possible sprintf() args. Currently
>> 'name' size is 16, but the first '%s' specifier may already need at
>> least 16 characters, since 'bnad->netdev->name' is used there.
>>
>> For '%d' specifiers, assume that they require:
>>  * 1 char for 'tx_id + tx_info->tcb[i]->id' sum, BNAD_MAX_TXQ_PER_TX is 8
>>  * 2 chars for 'rx_id + rx_info->rx_ctrl[i].ccb->id', BNAD_MAX_RXP_PER_RX
>>    is 16
>>
>> And replace sprintf with snprintf.
>>
>> Detected using the static analysis tool - Svace.
>>
>> Fixes: 8b230ed8ec96 ("bna: Brocade 10Gb Ethernet device driver")
>> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> 
> Thanks Alexey,
> 
> I agree that this change is a nice improvement.  And I verified that gcc-13
> W=1 builds on x86_64 report warnings regarding the issues addressed by this
> patch: the warnings are resolved by this patch.
> 
> But I do also wonder if we should consider removing this driver.
> I don't see any non-trivial updates to it since
> commit d667f78514c6 ("bna: Add synchronization for tx ring.")
> a bug fix from November 2016 which was included in v4.9.
> 
> Although, perhaps your patch indicates this driver is being used :)

Not at all :)

Well, I will resend a new version with suggested changes to net-next since
no one has commented on the removal yet.

> 
> On process:
> 
> When posting patches for net or net-next, please generate a CC list using
> ./scripts/get_maintainer.pl your.patch
> 
> This does not seem to be a bug fix in the sense that it doesn't seem
> to resolve a problem that manifests itself. If so, it should be targeted
> at net-next rather than net.
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html
> 
> ...
> 
>> ---
>>  drivers/net/ethernet/brocade/bna/bna_types.h |  2 +-
>>  drivers/net/ethernet/brocade/bna/bnad.c      | 11 ++++++-----
>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/brocade/bna/bna_types.h b/drivers/net/ethernet/brocade/bna/bna_types.h
>> index a5ebd7110e07..986f43d27711 100644
>> --- a/drivers/net/ethernet/brocade/bna/bna_types.h
>> +++ b/drivers/net/ethernet/brocade/bna/bna_types.h
>> @@ -416,7 +416,7 @@ struct bna_ib {
>>  /* Tx object */
>>  
>>  /* Tx datapath control structure */
>> -#define BNA_Q_NAME_SIZE		16
>> +#define BNA_Q_NAME_SIZE		(IFNAMSIZ + 6)
>>  struct bna_tcb {
>>  	/* Fast path */
>>  	void			**sw_qpt;
>> diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
>> index fe121d36112d..3313a0d84466 100644
>> --- a/drivers/net/ethernet/brocade/bna/bnad.c
>> +++ b/drivers/net/ethernet/brocade/bna/bnad.c
>> @@ -1534,8 +1534,9 @@ bnad_tx_msix_register(struct bnad *bnad, struct bnad_tx_info *tx_info,
>>  
>>  	for (i = 0; i < num_txqs; i++) {
>>  		vector_num = tx_info->tcb[i]->intr_vector;
>> -		sprintf(tx_info->tcb[i]->name, "%s TXQ %d", bnad->netdev->name,
>> -				tx_id + tx_info->tcb[i]->id);
>> +		snprintf(tx_info->tcb[i]->name, BNA_Q_NAME_SIZE, "%s TXQ %d",
>> +			 bnad->netdev->name,
>> +			 tx_id + tx_info->tcb[i]->id);
>>  		err = request_irq(bnad->msix_table[vector_num].vector,
>>  				  (irq_handler_t)bnad_msix_tx, 0,
>>  				  tx_info->tcb[i]->name,
>> @@ -1585,9 +1586,9 @@ bnad_rx_msix_register(struct bnad *bnad, struct bnad_rx_info *rx_info,
>>  
>>  	for (i = 0; i < num_rxps; i++) {
>>  		vector_num = rx_info->rx_ctrl[i].ccb->intr_vector;
>> -		sprintf(rx_info->rx_ctrl[i].ccb->name, "%s CQ %d",
>> -			bnad->netdev->name,
>> -			rx_id + rx_info->rx_ctrl[i].ccb->id);
>> +		snprintf(rx_info->rx_ctrl[i].ccb->name, BNA_Q_NAME_SIZE, "%s CQ %d",
> 
> nit: This line could be trivially line wrapped so that it is less than 80
>      columns wide, which is still preferred for Networking code.
> 
>      Flagged by /scripts/checkpatch.pl --max-line-length=80
> 
>> +			 bnad->netdev->name,
>> +			 rx_id + rx_info->rx_ctrl[i].ccb->id);
>>  		err = request_irq(bnad->msix_table[vector_num].vector,
>>  				  (irq_handler_t)bnad_msix_rx, 0,
>>  				  rx_info->rx_ctrl[i].ccb->name,
>> -- 
>> 2.25.1
>>
>>


