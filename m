Return-Path: <netdev+bounces-176023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF0A68623
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ADD19C0A50
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A56212FBE;
	Wed, 19 Mar 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLHPWiFZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCD20897A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370652; cv=none; b=GT3cMOtkvZwORdks7TfTr89SDZy6b2kTsVXhQTu0na3pbZBAC/ekZNRfj3jClnBaH/VKfG0yz7r/crgQe1Lw8GY74/H1Mg4CVYg7ub5BR6kC3ERQN61E856uX+fOA/PqSEjzoExzzKgWUR6ifQhniLqNnDHx9c8UQonstsAiid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370652; c=relaxed/simple;
	bh=h+x0tr1pxK84LrWDolVeOR8GbfJTngNgQS7TUrbrjSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klnnp/ftCQM7e0R36vz4VgNHXRo1eRsr2nDjAkeFCBINTCMIZoaO1L33STycmtNWNUOHYfck3BEaB0G6hgXPCg6KlEwUAJry+iIq9qRXvYeWJ05MoT/5YNHDLNSibdFNZVTYME+b1HlFlx1GqzP9j1HSZzPAxeaNWbTZwfttW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLHPWiFZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742370649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHifQtzg3A5YJXAWp520dHPdmaHnVV2CCN8+Bq5mcbA=;
	b=jLHPWiFZEQpoiXczfKhZ5w9u5qM0dQwDrSeisXK6egGLCGQZ1qF6ADlcKZiZQCviesxQxf
	GjepSOKpT/9vnSN7RNO5jnfoQDXCL+XRF3a836NsqBsP19un/lMKFDlh5qfF6U6xISedIV
	3Gj0sbA5TKSqX8io4tTLJVHPTNjDKbQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-K1y6HmR2P1islyNNYoU0vw-1; Wed, 19 Mar 2025 03:50:47 -0400
X-MC-Unique: K1y6HmR2P1islyNNYoU0vw-1
X-Mimecast-MFC-AGG-ID: K1y6HmR2P1islyNNYoU0vw_1742370646
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947979ce8so20907075e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742370646; x=1742975446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHifQtzg3A5YJXAWp520dHPdmaHnVV2CCN8+Bq5mcbA=;
        b=dXFve+1jPu1x7rYTw55HnHfziEbX4cTR2zCem3jkXFmspkgs805Pku+Z/oOxQtfRn1
         hpoDkUiGRw84coTS/FwRsoCerJSw3wNqqdn0sZm5sASCUnn/NJpJyYQZjOWZ8l4HvWi1
         i3B+GT71Zl2K/VVqoUNTLNRYAdRBv1eYb68GI4vIRKrOCl87ojJCa8hiwx8QpRUHVL34
         rLswqc1viq1nXjSyCZwfMSkA1hO2EwQ+95Yyg9bA+vcpENFxieBN+H3BLYTdGppDuee/
         Dsuw9SVR1YtkbeBPL0Xem83S0s/sD0vUQqp4jQ/ohFX+qTshUBgySq/eg1iOLXkLa5JX
         OE5g==
X-Forwarded-Encrypted: i=1; AJvYcCX8nn8mIRo2DYKghaxncjql+J+hxByaqxhJSFICV0/9NAllSfXvSJqGfoGkn5jPm3zwAvvPdAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWUNm4y1fST44lJC0UqEVLX0xVUK7UOmYYHVqzMYyE0eQXOog
	qJmejU1/RGyqCkEnAAkFyRcbYlpGyezDWMRsYJUFrMOSRFndtzEvxNntRPzqUvblSwWT/JMyauI
	qMatl/3GLWufLSspQKdz6hPnquWwuXdTCsVMKSV+LSLdAM+hAwToh9Q==
X-Gm-Gg: ASbGncuFuFHukeLlb+G+4yY5atbelRCAP6O9RJJFUZNfvFdFUsw4C4tGrM4A7BGSrST
	jSyrZuNA0mMyag2JR+qCT7tNSawv29kMPL8WOiZfS8x+dMvsP1sYG9+WlmUJel/Q17p0bPTJbNV
	HkIrXHqRTXpnY9fLtO8gkBbyIU7XX/Vbz7kvf5WQISB0i/EPCeRSA0UqtejJJH1MEvZvG5YBAid
	zaaDeBNkobHe9XOIsQ9TsrYeSByndYsf+RCgqIL1PIYjrHAXMQjasKTiY+FW4WauuuS0C4ObTvF
	LU9jPYnSuhjIA4VM/WGY+obgg0YaR3aCS4bI1Wbejq3PPg==
X-Received: by 2002:a05:600c:cc7:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-43d4381697cmr15639825e9.29.1742370646271;
        Wed, 19 Mar 2025 00:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPKHaakHl9f+i3snGAJfUTC/F7kILHuV5qL2P15QBV9TcfXUQBl87ChCXAkjzubDJK0pdt4w==
X-Received: by 2002:a05:600c:cc7:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-43d4381697cmr15639495e9.29.1742370645840;
        Wed, 19 Mar 2025 00:50:45 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb93csm19922812f8f.86.2025.03.19.00.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 00:50:45 -0700 (PDT)
Message-ID: <df4c25ac-8929-434a-9363-2d3761f8fafa@redhat.com>
Date: Wed, 19 Mar 2025 08:50:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] sfc: support X4 devlink flash
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
References: <cover.1742223233.git.ecree.xilinx@gmail.com>
 <6309a6a1b81e7d6251197c8c00b8622e6b17e965.1742223233.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6309a6a1b81e7d6251197c8c00b8622e6b17e965.1742223233.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 4:00 PM, edward.cree@amd.com wrote:
> diff --git a/drivers/net/ethernet/sfc/efx_reflash.c b/drivers/net/ethernet/sfc/efx_reflash.c
> index ddc53740f098..bc96dd29b675 100644
> --- a/drivers/net/ethernet/sfc/efx_reflash.c
> +++ b/drivers/net/ethernet/sfc/efx_reflash.c
> @@ -407,31 +407,40 @@ int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	devlink_flash_update_status_notify(devlink, "Checking update", NULL, 0, 0);
> +	mutex_lock(&efx->reflash_mutex);
>  
> -	rc = efx_reflash_parse_firmware_data(fw, &type, &data_subtype, &data,
> -					     &data_size);
> -	if (rc) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "Firmware image validation check failed");
> -		goto out;
> -	}
> +	devlink_flash_update_status_notify(devlink, "Checking update", NULL, 0, 0);
>  
> -	mutex_lock(&efx->reflash_mutex);
> +	if (efx->type->flash_auto_partition) {
> +		/* NIC wants entire FW file including headers;
> +		 * FW will validate 'subtype' if there is one
> +		 */
> +		type = NVRAM_PARTITION_TYPE_AUTO;
> +		data = fw->data;
> +		data_size = fw->size;
> +	} else {
> +		rc = efx_reflash_parse_firmware_data(fw, &type, &data_subtype, &data,
> +						     &data_size);
> +		if (rc) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Firmware image validation check failed");

Not a full code review, but on this error path the reflash_mutex is
apparently not released.

/P


