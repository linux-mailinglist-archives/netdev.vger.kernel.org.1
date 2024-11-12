Return-Path: <netdev+bounces-144013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B59C51F7
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548081F25729
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13720D4E3;
	Tue, 12 Nov 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9pdjrZE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F520A5C7
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403711; cv=none; b=ULlZ1szUZMi2sb0g2MxPovbkIl3QmQ9Gqx7dgmoN2Wu0KjMsvjAcn/1uOnsQna/BodYaYAEcse72zAhVvhBFuu/hkiT/aAfvDPdIVdmiHd5pbfUj+M5IJ2VWfZg2zIAKye8Onm33MeVzLfyW3s1FynV1qoGv+yqE4nTppMC7EzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403711; c=relaxed/simple;
	bh=jpa4XcrWIAvgM08KBz3NroeJWbKeIawyJRNcEeL2+9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENSuhcuLW4Lp+bvq6+M68K16KQ+GhO3KfRQwIiRpRrWs0Ck0csRR7WtWDhFc6sd4PhZGyiOP4048R1snypfmzBqVeZJqTTzYxOkeLCp4tcM64ws4fPCNe1uqoWJWJK8yr0j2W1NykDwiA7TUX7CpPVPFECzN6sNNHI4wk2lOnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9pdjrZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731403708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LRFE7o764/lq/KwAISV7bJ6SwNHRnb2w6OTp6CEmqg=;
	b=E9pdjrZEa+lXfgulWNVr3UF/GEzV2QSqoh5dYx8naO7LTSlZfRRsBLNO6wIzev101uPcTR
	VtF7Q2NEjuE+9pULzhiBou6xcV2tzVGDfcFeQNcPw8gmupKYnkwY4orePaHprz8K9Pm9aN
	ecdorWXqqRzapWWgXkC8HPNNBndgXqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-RylBt2keP5yebJhEOH8ClQ-1; Tue, 12 Nov 2024 04:28:26 -0500
X-MC-Unique: RylBt2keP5yebJhEOH8ClQ-1
X-Mimecast-MFC-AGG-ID: RylBt2keP5yebJhEOH8ClQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d458087c0so3866094f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403706; x=1732008506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LRFE7o764/lq/KwAISV7bJ6SwNHRnb2w6OTp6CEmqg=;
        b=LV8FgGazk7Q5KqugHl1L787TXSKHFhWQPjffJDFOqRNK3xfAzs/UZZl3FzzQNvtLLM
         lQEjsiadLkhVPxPiM5AV91NGuDQPkZ+GxBk0ZpvDCGlTSvIXFz/Iu18TL2qsj9ofkIaz
         o8AIfDW/qCqpHMqko4P2zl4+vmO18cYlojl/UCE/v48goFbJ6xgjpjmzpaIgzxRI8aRl
         59ljNFccu1TAidCBGg8H8re3AC+VMVsN+UkbsHtEmJOGkW+gVcv+yrKJc1iYHHbvXSXI
         2V1r1mwuUDgPt4sYy5OxVjOCd5ctKDByXT4CXJXrNLoQlU/ix9MaxH8pVJanZSv5EXd3
         CzsA==
X-Forwarded-Encrypted: i=1; AJvYcCX1d4gC9U2dlzzXi4MJurhB6Syoe8SRsrSATVsFTS+8v0kdezD9mgR06ll+Xs4XqdcF9hpbWPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZj2f0lGSwxii9xFLkHMHg0RTn3Qpa4g60qbZbTdw6qb1YDPQ
	28PnpiW5TSQ34xk2WXcBH2umCdOu/lirzNUASbMJF9xencfJD38UzWJUX53asGvWkH4cgZ8+QwO
	pxZTa7CHdoN4JGhz3WfFJCSAjQcAoPf0isd/Y+HLLWk+iiXLLFt9B2A==
X-Received: by 2002:a05:6000:18af:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381f0f58473mr15019449f8f.9.1731403705771;
        Tue, 12 Nov 2024 01:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeFow1WF3RCdO19wHgFR4siQkWFoCuOojrbHUtDMVrlBsQ3slzVULhivX2xSddNA9hsGCcXA==
X-Received: by 2002:a05:6000:18af:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381f0f58473mr15019417f8f.9.1731403705441;
        Tue, 12 Nov 2024 01:28:25 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm206187215e9.38.2024.11.12.01.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 01:28:25 -0800 (PST)
Message-ID: <1b335330-900e-4620-8aaf-a27424f44321@redhat.com>
Date: Tue, 12 Nov 2024 10:28:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: Introduce dwmac1000
 ptp_clock_info and operations
To: Jakub Kicinski <kuba@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
 <20241106090331.56519-5-maxime.chevallier@bootlin.com>
 <20241111161205.25c53c62@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241111161205.25c53c62@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 01:12, Jakub Kicinski wrote:
> On Wed,  6 Nov 2024 10:03:25 +0100 Maxime Chevallier wrote:
>> +		mutex_unlock(&priv->aux_ts_lock);
>> +
>> +		/* wait for auxts fifo clear to finish */
>> +		ret = readl_poll_timeout(ptpaddr + PTP_TCR, tcr_val,
>> +					 !(tcr_val & GMAC_PTP_TCR_ATSFC),
>> +					 10, 10000);
> 
> Is there a good reason to wait for the flush to complete outside of 
> the mutex? 

Indeed looking at other `ptpaddr` access use-case, it looks like the
mutex protects both read and write accesses.

@Maxime: is the above intentional? looks race-prone

Thanks,

Paolo


