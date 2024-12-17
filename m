Return-Path: <netdev+bounces-152526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16C9F478F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44703188246F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30316F858;
	Tue, 17 Dec 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWHJ/Ox+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB113D276
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427834; cv=none; b=lBLY1s8BJ4Z8XyFGvDNHt+1/PK9viAUdO68Q4NLr24TGNv6mqOR0xmW7ABh0NSBQH70zfJNSGkHIwyzyOEySyTujPHfRu2jVkoIuwW1PicTeUH+0LjO4tf9J7SQVw8dgt3RsFMv8VQx8DHADbU6zvWe/tZZP3cQqkLUnTD1Meic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427834; c=relaxed/simple;
	bh=hTrcB06ROVLWkiWKP9EGt8merZ0Vmsr2aoLLJZ0qYro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TViTVBlgIPgERqr9g1KiXM1AAaSVzrumG2uzvYFdygWcJPfzvw1hyFhxRL8BQKvcvVcQmCaYujDj9gqcavjrM8SyKP6A/CLYGsDyA17eQi6H3M5w+MhfrKKoosY40gCzSW28bKEEw2O5X0NK+SU0l1W48CPf0Fgd/6C9+5rlR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWHJ/Ox+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734427831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsZWLwNN3Dj8vY9Jgz0ZZvXQlClGHa97ZSTKANn10HM=;
	b=SWHJ/Ox+4B3pNll7+Yj8KTQoQ4uDiUCINokXmXCTvUhzjDip2Oio9gnTHH5Lim1DafcbwY
	8NxE3j6PVxZtybV+eI942RldL2k+lo72IjMszwPfcw7dLTdWzlL6i8B3uTi52XML3luo4o
	In9iatf156Izl07n9uKRbc84xBdcyUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-fhtU5kqyPfmEB4YMllvbBw-1; Tue, 17 Dec 2024 04:30:29 -0500
X-MC-Unique: fhtU5kqyPfmEB4YMllvbBw-1
X-Mimecast-MFC-AGG-ID: fhtU5kqyPfmEB4YMllvbBw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so2559617f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427828; x=1735032628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsZWLwNN3Dj8vY9Jgz0ZZvXQlClGHa97ZSTKANn10HM=;
        b=qf3/e/i7cQiQDTd40y+0hG7JVxaai5CDnfNPheMzyZ/K1izH9EFM5EtuSmSSlKLaDL
         JutdIU+ywTR/1k3KF32kQm/Aqwk8bds49VvT7tPBhOsRcteMMRS21JCR0qp1KjNCVMSz
         GWwS2L/CKAOHs40DzrwGTBNP5cAoG8aLl7h5Ws/SUV4Z+zSs81LmwqoW3/ROhHPQW7Zi
         HydEEqdA09TXzhNfjHekNZ002/Iav2FPXEMG1fet/gpcj1X1xQg39XptBWFJ1DOOWa+C
         vwkOurlPwsVXxAcs+qCqWSWdAqkrA9y4pI8rLFsZUknkyp/eu3WTRsOt7rcg06uMD6lM
         p+hA==
X-Forwarded-Encrypted: i=1; AJvYcCX14fEA5TWI5siOxGaO18c/tFULsaxIVt2jHoWeIuaLAnxtz6BGFrxx7Se3fRkmj43gxm8v4hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykzh/DzdmDI4m+nni9tMCsJTkWoO1p8qEi112HKOtWZMbr+psD
	16cqLx4cSfX7VTPcu5ScKEIavuIpYG4Qt8vIjPfRcTxjguA0hRsrZz8xSlx98Xj9SAz4q97OGKl
	MLIaC5L99Xbvip2YSUPhoiMkGt1OiwhGekarhwvEFUwjEtjep2IOgDw==
X-Gm-Gg: ASbGncunFS1LO14eldExnrIEX/JnYl1W0LgpHvKVeyYU8FW1OitkjegUgC7FNB5M5Cn
	kwQr9C5vZ+yqEZtfayGEBB15bNrzxyfGRqKfeTdivkSdEyH8mDxFdqohWja+f9StMBp1Q72aZIa
	/6jsNTTWSf4MG6t1oJcdNalOUKUOXzrPKaydCGXK6Kb348nwrC46eI39cV9UwI0d5/Bvj0MTPS2
	uVFqOX0Bgt9fxjFErlBNcuegdMKBLdKt4E5w1NqHUfGoT4nyD4ywlBgA1LGUXGCBAAAMewogA6K
	KCipdMK9pA==
X-Received: by 2002:a5d:6d8e:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-388db23b794mr2025553f8f.7.1734427828120;
        Tue, 17 Dec 2024 01:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGfqm8yOmdd4TkH9Nm5un+/9BqyR43RiXrtTTnaPexsrsZBcqLS0wyDa2ydDNBgCgdLmOg5Q==
X-Received: by 2002:a5d:6d8e:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-388db23b794mr2025421f8f.7.1734427826252;
        Tue, 17 Dec 2024 01:30:26 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c805d489sm10688171f8f.88.2024.12.17.01.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:30:25 -0800 (PST)
Message-ID: <9d0722fe-1547-4b44-8a4a-69a8756bdb39@redhat.com>
Date: Tue, 17 Dec 2024 10:30:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: TSO: Simplify the code flow of
 DMA descriptor allocations
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, xfr@outlook.com
References: <20241213030006.337695-1-0x1207@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241213030006.337695-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 04:00, Furong Xu wrote:
> The DMA AXI address width of DWMAC cores can be configured to
> 32-bit/40-bit/48-bit, then the format of DMA transmit descriptors
> get a little different between 32-bit and 40-bit/48-bit.
> Current driver code checks priv->dma_cap.addr64 to use certain format
> with certain configuration.
> 
> This patch converts the format of DMA transmit descriptors on platforms
> that the DMA AXI address width is configured to 32-bit (as described by
> function comments of stmmac_tso_xmit() in current code) to a more generic
> format (see the updated function comments after this patch) which is
> actually already used on 40-bit/48-bit platforms to provide better
> compatibility and make code flow cleaner.
> 
> Tested and verified on:
> DWMAC CORE 5.10a with 32-bit DMA AXI address width
> DWXGMAC CORE 3.20a with 40-bit DMA AXI address width
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Makes sense to me.

Since this could potentially impact multiple versions, it would be great
if we could have a little more 3rd parties testing.

Thanks,

Paolo


