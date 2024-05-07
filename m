Return-Path: <netdev+bounces-94112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382908BE267
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C59C1C20F31
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C315B13C;
	Tue,  7 May 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="AY4ses1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336515AAD7
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085858; cv=none; b=Lh/N/f/JNnE14cAXq24J0J+IUKbxY55/WyZ1gXtkHHt5Q+/Xc6++3YUJbHKmt1Ixo0QK/eZ288oflwN+WFWTGd5/m4H0IAJWP06M17a+1S+A09FyCLItFx38ATKarhwnXjl7uxSB4VblmL+37D7vI+ywzqdNqOY57Fq0lXDuGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085858; c=relaxed/simple;
	bh=rCURwd3Q1o74GfLAdxVB46w7pakgsA9iZZCIcyWzyh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbPe/Q+/PnzqyKYezO8+HBxcpVMJc7L//KuuPKx6gW8HSp37ZCzvFujt/S8hZuAX9diMZ6bXtN12Y8MbWeR5WDcXNoiBolYWol5wtfgmoj4qz+05oqqUvfBDdVt6WUwCTNQwyk/g1yJDxucp9MZTj7xFYm89oKyMFv1IUSsAiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=AY4ses1p; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db101c11beso38923451fa.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1715085855; x=1715690655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tsbjHZ4oF6OzYZ4G7o73ocZKjoIDcyU7RA+CqEB12r4=;
        b=AY4ses1pQjZwUg7l43RFNggWigu5Dx2Wtk2wYh0IyR4EFY0CzCUp7ZCE8Ql14EtK1U
         hGfXqhHmkSnrTh9yduh/RTNksFl7bxERIBxhz+C0Zdnw0RTfh9ERO5ykFch9t4IJJne+
         +rRNRvVtOBJxn+Hs9uQJwzgH6DXHtKSbsNC8ACM2/Sw6UlvFI6NAwMhDzZbpnvOUyaAs
         B3ohhHCFjEihel6LwD+5M9nuLRLj0XWt82G+NvK66AOtFHzXZB647qaPvuKXm9rVlsE6
         ZlSzWopc8uQxX/TcpTBJyxvKck/nBxykAL3vcz4poA/7lKBIH+RZmwLICBvCRF8Gnp0E
         7xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085855; x=1715690655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsbjHZ4oF6OzYZ4G7o73ocZKjoIDcyU7RA+CqEB12r4=;
        b=QLFtOCmsauJjQeXIrdcmSi9fnx1zFwO2rfoObzvuw0X2QsuuaQlEJUwfoU8MPlHp7G
         U1Bg7vFFpm6aUGobClFRfrdniP7j6qvbv3sHWirxMhPJE4PT7xynbR1teKAywjzCSvHR
         tpuvT/NTDxGfGpaxC8G2kYVXZXBrOsr5bF9a0RXjfm1GfsRDwLwLgNx+Zp4q26QJxydK
         pisN/vqPGjpatxMdRg204Uvt35trJWtEnHG1EDTplFoD8qfU6yErPPy6UC7mYpWh+Bdi
         5wVmoX8XOeDN6TF+Cvtf7WcADxF1IWMXU0TUUFe3KfrQqgKbakQ3e1AuA/xDVrjSL2e3
         2Vqg==
X-Forwarded-Encrypted: i=1; AJvYcCVA66apeL3j6gTXy5MLX5bSAsQ+L2VUGt8jcsD8kdwdzIXEDKoUOb4jwkRjXzc+K8d9HwktObDj3599oKFm/tioQkGZVsur
X-Gm-Message-State: AOJu0YzcsPNK1YMgNzZhGp0St80Ff8E6X1YytY1YJDPTcTBXr0ZUsSB9
	ZjOnfpb7Yp9/2pTfMLwxHlRLX6f2xZzpcnRAcTmJ5Tm5XfY+VcNhsc7E8e2HQLk=
X-Google-Smtp-Source: AGHT+IECSYuhAFIO5Qpfm6EZY5kJxIESLcNoWa94sLoB+G7RdKTYP0/Ql0zcfk7jpD9ZOhmF48szIA==
X-Received: by 2002:a2e:a173:0:b0:2d2:869a:55af with SMTP id u19-20020a2ea173000000b002d2869a55afmr8185336ljl.17.1715085854832;
        Tue, 07 May 2024 05:44:14 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b002e33be202e8sm965384ljn.72.2024.05.07.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:44:14 -0700 (PDT)
Date: Tue, 7 May 2024 14:44:12 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <ZjoiHMeKkab4XR-1@builder>
References: <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>

> The RXBOE is basically a warning, indicating that for some reason the SPI host is not fast enough in retrieving frames from the device.
> In my experience, this is typically caused by excessive latency of the SPI driver, or if you have an unoptimized network driver for the MACPHY.

Definetly tracks with what I'm seeing, got two macphys, one is sharing
the bus with a can transiever, getting more RX overflows on that
interface.

> Thanks,
> Piergiorgio
> 
> Which is a bit ambiguous. I would hope it means the receiver has dropped the packet. It will not be passed to the host. But other than maybe count it, i don't think there is anything to do. But Ramón was suggesting you actually drop the frame currently be transferred over the SPI bus?
> 
> 	Andrew

This was misscommunicated on my part. In my happy-hacking adventures I
got better throughput when dropping more chunks in the driver code.

--

Suddenly I can't reproduce the hang, I'll give it one more attempt today
though. Did some measurements with a better oscilloscope, I'm seeing a
periodic latency of ~500us for clearing the irq, typically it's
considerably shorter, and a periodic ~1ms silence on the wire.

But since I can't reproduce the hang this is just performance related.

R

