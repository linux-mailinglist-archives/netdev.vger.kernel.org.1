Return-Path: <netdev+bounces-171959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F7A4FA1F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1FF18929F5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827FC204F91;
	Wed,  5 Mar 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWkEo5Vb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A21FC7CA
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167093; cv=none; b=HWG58FkRFFPX9aKjJPs6VQ7wyfc+hBlT/9mF3vcoRqtOGRggRLjgEh/Q4xxPHvmeTNeSVdgD5t2lgs7iGHjr/Zolfa25E7qcvUu0jgU0uKZuUq/GxInbEbGcVOZ7ZnOVk/S3BjzQc9jyt312z85sUADNPNSlx5s+6wq5zUDGSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167093; c=relaxed/simple;
	bh=k0wiGyIgP1X375nTP6KgieVfEGHC5iiA/tF0wfZSE0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKjKSadyYAZBPxAF9r2hHmsO3xxw1k04KzEY1Ny8tiu44ycS5ptXDPB2ViapqcKwNx/HYDjExQnwmMs7ZpQxAYE4+zf68kcQnwccDPXQpaIlKVM5QBZRlf3jC9QB62mJTbUrJDtOKK1H8GqAO8BEN9NAm0jpYU89QYVoT7xrCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWkEo5Vb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so3485637f8f.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741167089; x=1741771889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGHqSgga9ZWqhfiXbeTFLx+tMRtdQJt+JKetm5hHuhA=;
        b=oWkEo5Vb20pRDdMqdX3bZprxk0t/SQtfvw0K/EE4zLnhVo+SjO/oHsX+X7YgvT9aC3
         NFEiMz2U1rWwbZdPUrNnC/vwqdwG9r0BYI0R2VttNx3BEu4B5YTLti84iSTDAHMhITv/
         A8ilEQCMDnfxV2Bht9XGz8KQGn3lyz1Z5H3h9O15faFRtL0dwhG9zYfkck0yxAJhHNMn
         LDRgVEa2bc69dEvwZiuSUDBPQ/57OYjHqecYrItmWmaW2Kv33vhgbJFi/87rcR3E+am/
         GyMhlFFjqQof8J6XBTjawi/iQHd7COQfzmyGF7q6UIFphmoro3oujw/uETjUaSE4JW5f
         cN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167089; x=1741771889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGHqSgga9ZWqhfiXbeTFLx+tMRtdQJt+JKetm5hHuhA=;
        b=vcWkJoEkF7IAfLaGDsklRqS2lAXRmEJosqOtUwoHQYtOymC0ObWN0wqpqujhA0anGP
         DM+egYY2Hlv9esywgBGzita3ThADrGqA/D7HopumECBjyQO0x03xprq/GBfXc/kD+yhn
         wEK4Rb84lNiWwAXzZcufELtstXktrUbe1DrsCd9HY8ekj75HoJvIVNodgPHxJ7aamoi+
         sqkF05uWlZxyA5R+H29z/WnZ7mwEczEwNzYntP24NngT0L1cIBNnGNcFaKuo7vs9HNSH
         iRNPtEZhcfLCpTQc3H5HnH2O0L/DznUKOI9xKCwG/Y9O2fXIhA7WQTyUQGlZX7kk8dfB
         y6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXJc94HAhukB1eYSTs+X9Mu9F4+jN/K17HWSAN2wn0kcV4ef4eNjd33dDcwAwEPRcwC61xjXFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKHosDhKF7p0wKJD5qAXwz+WyUkP5gv+iLOTZHZ/5g2Qmk0io
	mzXoajlPgDweYY5iBDTHkT4shK95SOIfzphsxNCJefN+OG0dSSWQGW+AaJNFJp8=
X-Gm-Gg: ASbGncsiL2ic4RCeoFvFinexLPMvPONO+bBcu4yCroHv3OkZ80pjum0QMGtCN2WeQ/r
	1rrZ7xKb9T7p9rn/bKR7wGdrOmQhxwk20WKE9gpC0tbfOs4DH3k1+rBQdvw746s1CWJg6zl9Jw3
	AZQ9PhKaFpMf8iLKa3zQfPX+SHN9XZohwqUZeiU0Y2lCpR3AqF1Fj6XoaEOgJbujVPy/ogM79Ws
	3oLZQcEX9qHt0TdjjPAgjY4EO20VW/x+YBlz5xz39X9U54UXewtv1AeosYub/u2f/m0PqLw/OTE
	G5/9n2gMpGC4A7KsPAy9kRsIdPlrsrgMjgaGc8S/he9lDjIzmw==
X-Google-Smtp-Source: AGHT+IGBjeO6TeQERlVAAv2wJR2v/E9DyRfr/DsoCry1ZVSWVEJcRLW+vugv45aqXSWg1cQhm5oZnw==
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr2203099f8f.16.1741167088987;
        Wed, 05 Mar 2025 01:31:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd42c5b33sm12065705e9.22.2025.03.05.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:31:28 -0800 (PST)
Date: Wed, 5 Mar 2025 12:31:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	matthias.schiffer@ew.tq-group.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, glaroque@baylibre.com, macro@orcam.me.uk,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth:
 Add XDP support
Message-ID: <5f716740-ac45-4881-a27d-91a93de6f8c7@stanley.mountain>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
 <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
 <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
 <40ce8ed3-b36c-4d5f-b75a-7e0409beb713@ti.com>
 <61117a07-35b5-48c0-93d9-f97db8e15503@stanley.mountain>
 <fd989751-e7f6-40bb-a0bf-058c752cc7bc@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd989751-e7f6-40bb-a0bf-058c752cc7bc@ti.com>

On Wed, Mar 05, 2025 at 02:53:07PM +0530, Malladi, Meghana wrote:
> Hi Dan,
> 
> On 3/3/2025 7:38 PM, Dan Carpenter wrote:
> > What I mean is just compile the .o file with and without the unlikely().
> > $ md5sum drivers/net/ethernet/ti/icssg/icssg_common. o*
> > 2de875935222b9ecd8483e61848c4fc9 drivers/net/ethernet/ti/icssg/
> > icssg_common. o. annotation 2de875935222b9ecd8483e61848c4fc9
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source
> > of this email and know the content is safe.
> > Report Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!
> > uldq3TevVoc7KuXEXHnDf- TXtuZ0bON9iO0jTE7PyIS1jjfs_CzpvIiMi93PVt0MVDzjHGQSK__vY_-6rO7q86rFmBMGW4SSqK5pvNE$>
> > ZjQcmQRYFpfptBannerEnd
> > 
> > What I mean is just compile the .o file with and without the unlikely().
> > 
> > $ md5sum drivers/net/ethernet/ti/icssg/icssg_common.o*
> > 2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.annotation
> > 2de875935222b9ecd8483e61848c4fc9  drivers/net/ethernet/ti/icssg/icssg_common.o.no_anotation
> > 
> > Generally the rule is that you should leave likely/unlikely() annotations
> > out unless it's going to make a difference on a benchmark.  I'm not going
> > to jump down people's throat about this, and if you want to leave it,
> > it's fine.  But it just struct me as weird so that's why I commented on
> > it.
> > 
> 
> I have done some performance tests to see if unlikely() is gonna make any
> impact and I see around ~9000 pps and 6Mbps drop without unlikely() for
> small packet sizes (60 Bytes)
> 
> You can see summary of the tests here:
> 
> packet size   with unlikely(pps)  without unlikely(pps)   regression
> 
>       60        462377                453251                 9126
> 
>       80        403020                399372                 3648
> 
>       96        402059                396881                 5178
> 
>      120        392725                391312                 4413
> 
>      140        327706                327099                 607
> 
> packet size  with unlikely(Mbps)  without unlikely(Mbps)  regression
> 
>      60         311                   305                    6
> 
>      80         335                   332                    3
> 
>      96         386                   381                    5
> 
>      120        456                   451                    5
> 
>      140        430                   429                    1
> 
> For more details on the logs, please refer:https://gist.github.com/MeghanaMalladiTI/cc6cc7709791376cb486eb1222de67be
> 

Huh.  That's very interesting.  Fine, then.

regards,
dan carpenter


