Return-Path: <netdev+bounces-91771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E98B3D19
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E694E2824A1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B914C5BF;
	Fri, 26 Apr 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FzUKR06f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EC148854
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150143; cv=none; b=sP4lbw9ymCYPOCMHkO+NehRTD3WAzIdgb3QdJ3ilWeihCkEvHCRBcw9HRfxtneV20fgxMlfYaMHymf8LiVakOsNsze3T9bBuObPEb9GPDIG6JAO0iPvKz0tvZcxmTySfbgs8QCkMjBnahYTri4yPCt+PE6GcOIy1Xz6UpdpbeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150143; c=relaxed/simple;
	bh=ceDHuhgb4HHjS0ZJN2dNYB8DNPxb1uu6ARLTxokHHMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvmNwUdwBLrA2/pOTAU6tKNtFDXCIeXY95fyZo6mDfa07GEBcQuCmanlc3KjBcHD+sAs5SoTDzMycX//ejlODzQWPF6sXumW83A36DfBiYipVhLxExpNwwTqjSCiCluI3g/T8FE2S/8gLiMP07AVPcnYreZoVAPoF/1onWCBEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FzUKR06f; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346406a5fb9so1824051f8f.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1714150140; x=1714754940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nK8oPrc10MzYsI6YzX0sWr3Nf7RDGYNv9pEqtd7pqo0=;
        b=FzUKR06fKnwsvBRNBHm8wp2GjOXFkFIlfo1UIb6fUcknLQflFAeQr68U8mSksrk4Kj
         hGS9JzBsSaDmRPthy6BvzXfmyvmFHwUOa2ET6qUeCfvKWX8mCswamT6Wwcpm543s47d2
         8bcHLFGx64VmtrWjHqfN685GEfPaaWp/EFwuj9RP73amRqmU5GHT+OiCjSPJKCKpYUP7
         t5nM9aMtvMTj937m9rNehgHyB2t+rgRGVc+y6jxWcKz/3pQhW5gH23/p0kK1n8XzBiEf
         LAF+OMPNCzhWMh6JpCILd5/tec/e19u3036KDEbCOglvr4c4lQJ1ibgv79GmAWe0cGxA
         li2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150140; x=1714754940;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nK8oPrc10MzYsI6YzX0sWr3Nf7RDGYNv9pEqtd7pqo0=;
        b=u7t0mrDhsL11HoZai6s61jU4RH803dYTf78gyd2Bqv8PSvTC7tekOAP3Y9AlAT4dOh
         n3nKyIyA6mV86F4L4gGQrOk3BtRXJyAuBQeec+SaGx3EmZ5aJfzSc+W7y71bi3/SQSlS
         ZwBxTcVlZZ8E8qX7ELh3IWKpxKWA/4gzXyBMxflxzz2GeO/Ry6DNFMhH/IK41DNreMpH
         K72WnkSmzzmcqdj47wwBDfl3ZbJi/J7xIe2T/wzenwFqFSHQzR22a38viEKNt5gPsRsK
         1Ghxxd+fZtMlXtj/xF2xuzFgOovZjrRFuuiTwJU3pQjXB7X2fwvAv8eSvXJpiwY27nzw
         SaBA==
X-Forwarded-Encrypted: i=1; AJvYcCWn76egk5sSDx17aIrx8dby+WAmtCUO3FNHq/ytbkGYLrS/RUTBCyTZ74aLCBh7gnvKtg6ECOJPIAl3+lGAaLaoln0UnPx5
X-Gm-Message-State: AOJu0YyNXja79QOFGymG5DDXN3usAJkXYusohosACNEXvLU8UOpYN90Y
	OM7ELnSUW2nXjqnsAAUV0fO7UmxuwAL/07nZbecR6lL3uw89/zARyrNHsjZ9pVgiC6HVV1s19Wl
	C
X-Google-Smtp-Source: AGHT+IHPkcTyEexs8s0tVfXw2zVcaafVYdhfxxaD6KxQpxjd4XfyQsSuY2io2l50cNz48pPm+6WM5A==
X-Received: by 2002:a5d:550a:0:b0:349:cc20:2030 with SMTP id b10-20020a5d550a000000b00349cc202030mr2505070wrv.51.1714150140187;
        Fri, 26 Apr 2024 09:49:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7ec0:9b49:16d6:3c30? ([2a01:e0a:b41:c160:7ec0:9b49:16d6:3c30])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm23031751wrw.4.2024.04.26.09.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 09:48:59 -0700 (PDT)
Message-ID: <e5b210be-9a5f-4c61-8723-d7a71fe71a90@6wind.com>
Date: Fri, 26 Apr 2024 18:48:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v13 3/4] xfrm: Add dir validation to "in" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <cover.1714118266.git.antony.antony@secunet.com>
 <0d09e74d7716c1258ba820af2e73e0b721747830.1714118266.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <0d09e74d7716c1258ba820af2e73e0b721747830.1714118266.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/04/2024 à 10:05, Antony Antony a écrit :
> Introduces validation for the x->dir attribute within the XFRM input
> data lookup path. If the configured direction does not match the
> expected direction, input, increment the XfrmInStateDirError counter
> and drop the packet to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmInStateDirError     	1
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

