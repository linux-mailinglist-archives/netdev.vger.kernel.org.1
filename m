Return-Path: <netdev+bounces-146177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE59D2303
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AF41F2268E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871691C173C;
	Tue, 19 Nov 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6ijbOvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA43198A35;
	Tue, 19 Nov 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010903; cv=none; b=e8FsJLrvjWY5RQDq/+VVP5l8BMLjZ71K1aapATlESib52EzazPq1AeJmnuYZmS8edM9Xl0CWIBsdyuydDye12ZpAn4qjShigGdvMi4N4UwCxgWmyhgjejKX/xWihAvvOYSZnjGWbHA767PoOYAlEmBYt4FJxZjw648FEJmeLgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010903; c=relaxed/simple;
	bh=PogykseyHMpD1kL58yPFmqjdSWAipjFhH6mGQqJL3oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsdFf2xnivO+WEwzPyNx8D9f690MK4zchC42tSSXZJmv8hmdXAGqSSBlZ2yRvJ+4frFKMJdfMUWd6ir7xVMG/0Vdec6WPu/bED/XW03z6B95NtmLUhUQ6Fxw8gsk9fP4ha3WKgZY4MnD+672tJnPJpLKqrbGu9BmHl+OENJdQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6ijbOvw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c9978a221so6659115ad.1;
        Tue, 19 Nov 2024 02:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732010901; x=1732615701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWTYfL2NcNvtJ7hT2DfleWj2jSJLFnsNcjBnW0uewCg=;
        b=Q6ijbOvwxQCWC80FgHylOW2x1o89L+xFwnSgL5ILJUBUBcEzfBVB/NyJiPBK2lISOB
         LopRQNAvMUoyAseaa7+wqkukv+mzuYTrnn1zM7f9JLO07Yub2oT37BiTp2+Ddwo+v/93
         8oJhnAYgFfPRKEmqQPvnMtuBQb7QcyXp49zTnj3z4cumauhoqY4wfqtvcnU0c3OiWw8q
         y9hr1c0Y+tQJuQ5Uw0r1rqpvcG5Sa26xt2COIjTgONnTb3U55QGbb6710/ask0ScNFas
         TeTqrGff1IojIRS9EbaRMlAh2M9QKjrJGRSB55BjraL/ELEGzSamWr58vVGS1cPFJ/eN
         Y0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732010901; x=1732615701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWTYfL2NcNvtJ7hT2DfleWj2jSJLFnsNcjBnW0uewCg=;
        b=DZBa4JqhdW2nnRHnS8gYT8DdhjaypumLs+bhXB1r2Wq30o7Fq5LN0z/rO6FRNZ/F2j
         FrdHXFWBwBiv3mwXyRwkepqwkK6FoqH+n14u4v5AQp+BEDcAgp8SNOYclnNvHyiMgFul
         moSEO3AgW00IHMLAdiCDLWfMQqsLIeN6WWlBx2QR164bORhGgs1I5vQ5D0AQX6bnG9Ej
         az54LzovFJVr36lMzh1hI0SdkIZfUteAnEtQ7XlEY2IXaLPAwcyYafAJOnUZhQio4JS7
         fDcvFZ/Nm/6n3iPAEYcCxQt2x7d670AKOvIvS2csboASRqLQrCSWFtg0Tc63wxxM5kd7
         cs3A==
X-Forwarded-Encrypted: i=1; AJvYcCWiaEoERo2hbLOXgIzHHf1rxujkQ55sheyDlQglKILrZGKFN/Bt7lWx6SI76oXkTcfZupWBi8wbweoTLXK+@vger.kernel.org, AJvYcCWwO11Kf9XDXb2E8IBsmg8Cx9vO+kuyYS3ActfGcehuXfc/fUuvQDfaCzbTcY1MS+Cga8VrnqB9KT+g@vger.kernel.org, AJvYcCX+jYTenPlefrO4tIvmw78Nh3MAMpQpDkpecyY/mpT/IM94RHE4WwtCVbRAplLhcHiyiE/yCxw/@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtnXj//aOAH9boB+0jaamn3SQaJWvfiFxBxpfcdVU1s+VxcM6
	sHAGWF2CxeKYUcCc7GNCNx2+7hlO+Ra7HKojwpNYrlFsJW0JzH6j
X-Google-Smtp-Source: AGHT+IEAjyQGdRHNm7PwkX2khYpceIhQ92EAPL/Ia7j4slTtR5ja4Ryry5i8z7VVQ8n6txgqIQJr+w==
X-Received: by 2002:a17:903:1d1:b0:20c:9983:27ae with SMTP id d9443c01a7336-211d0ecdac7mr237798475ad.48.1732010900702;
        Tue, 19 Nov 2024 02:08:20 -0800 (PST)
Received: from [192.168.0.102] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120ac39585sm41966965ad.261.2024.11.19.02.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:08:20 -0800 (PST)
Message-ID: <191ebf4b-231d-4ebc-9ff2-4916ef718970@gmail.com>
Date: Tue, 19 Nov 2024 18:08:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-4-a0987203069@gmail.com>
 <4d44bc93-6a81-4dc8-9f22-a103882f25e1@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <4d44bc93-6a81-4dc8-9f22-a103882f25e1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Andrew Lunn 於 11/19/2024 9:48 AM 寫道:
>> +	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
>> +		tx_delay = 0; /* Default value is 0 */
>> +	} else {
>> +		if (arg <= 2000) {
>> +			tx_delay = (arg == 2000) ? 0xF : (arg / PATH_DELAY_DEC);
>> +			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay);
> The device tree binding says:
>
> +  tx-internal-delay-ps:
> +    enum: [0, 2000]
>
>
> So only two values are allowed. Yet the C code is
>
> arg / PATH_DELAY_DEC
>
> which seems to allow 16 values?
>
> Please make this consistent.
>
>
>      Andrew

Oops. That was my misuse; I will change it to minimum and maximum.

Thanks!

BR,

Joey

>
> ---
> pw-bot: cr

