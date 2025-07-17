Return-Path: <netdev+bounces-207876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEDB08E0F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BAE17FCA0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024682E542A;
	Thu, 17 Jul 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S90jG4g0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CD2E5407
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758605; cv=none; b=hswH5LjU/kjrHllTbFsWU/IDryVrsFC6M31bEdz1dvVc2YVlPcgitIKH8+fGrHM6RiFRjVYuRnTzdmhH7h1M15A8AEqHskyqwSr6yeUfbPoY+y7hI0AmE/xZ10rMuiFGqSPiBGdg7fXVU4g1gZVk84UDxEW6uCVg0zRRB++QCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758605; c=relaxed/simple;
	bh=BPpYfnAnCBtMNCr7igg9bf2UIP7DI/13dxgs/9mKxm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plvo0I2TPmWFZdUJjvhCVs44TTz4VP7lrwZv/pfLVD5Nyms4E3cZJYq1rYKwhOeOp/ndUWlMNuTyJcB1/BGZLKM6OYwzQ3WgeZE2YfqhDJLwrn3FoaV+85W0/LzenjB749jvIzhBtZXpkzjExzsJgZqHxbHHixML72VXLp3t8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S90jG4g0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752758603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qbOEl2PGxjAtCWeSF7R2ApFJ7Tug20O9G4azMGM+2M=;
	b=S90jG4g0n7NFvab2XWx6U2u8F2nphk8xwJ/fB0wp5akrMgqv53WYXmRD4+OMT5R0V5tOHU
	yvZuBI6P4VAsVUU4cogzF5HUiNvSFRRXIoVgwyHKDSoH8Awq77rqytg6tJIPrZ/FbbTm23
	u4dMcefEcbIBJ+V7LKkrgWxiHs2k0xY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-mA3Cc7xMPiWHuJkm_fjzsA-1; Thu, 17 Jul 2025 09:23:19 -0400
X-MC-Unique: mA3Cc7xMPiWHuJkm_fjzsA-1
X-Mimecast-MFC-AGG-ID: mA3Cc7xMPiWHuJkm_fjzsA_1752758599
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so5146235e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758598; x=1753363398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qbOEl2PGxjAtCWeSF7R2ApFJ7Tug20O9G4azMGM+2M=;
        b=cijC3Ol4PRdftDnbDBXsw0eKEiOCbgOBf/usvBFNFFBrnFqfXqT+Su397oSEPWwMxk
         nKTA/MKPLhOUX4O6yFAnbKxgpdvACG0paphSul7VtLeqBHvo2g4KQsvaIkDJW+X6TWye
         JarU8isWE1SH0+ql0JdgXumc12zdMTL2uP0fDriPz22wxQqV3NgWJ/+5a6nB0cX2PB4D
         JU+WCvGEuKH3JIawQlV+cnW3bd80+T/XVry/oSxAeNh29Fb2oTP0gxmoQsaGWA+8hrgZ
         0UzrwQf50L5PanGEH8TdPSzPxbZ4JvV3fp4ONGdJalzx3NXBK4f7DdmkmAB4TrhyZSmV
         WBog==
X-Forwarded-Encrypted: i=1; AJvYcCVz3252MdSXz4pgpADFuPeAFBxK9bZCbbaRJwdOwdNq+FzbEoEo6eReKsUaE5ednBm6YLB8FyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfZgRR8QODCN6VNv5xBhgijJ6Y5h3PNysxphpQwA6xde7ajpg
	vy99fSMNQP7UYZswvFbz8eUeNLGKDMjkVshx+Pz1u4As2DG+c/ZJLmYApZqx1W5IRINtJs1J9vV
	1hxTtW28GKyfzh/9y0g7RSrHaW0lNAIzIi4hnzEx2ShC4uqWMnZyYXtuZLA==
X-Gm-Gg: ASbGncveWIu/rU29pPocA76rF9sGnhMc1kRkxXMXxCP65ClS3ctES0LIx78pcuNB+jn
	FOIfat/+j6XPnUfjK8muu+ROpggORBqSUqg0QDJTheKaHRHZdtF1xc/DIVB6lRbBlLwCyqSoUzF
	89xr9bFJXwEe9Nm0T6ygZf9jexldtWheq6CrTUkhrNJMYJyXSlkdhwzEmb2g6VObHNNmuFR+QTs
	lB3NHV4yzv7PZTb1U8lwRjq2RYhBqZqIjxVSMNaon7bH24jEUC93o0hOnovnDnt3rHhoy+f6utk
	yq8eh4Mg02iNapFA7BqPYUQiZvM4cseIyy4VfPCqTwAJBMFM7BS4azR4EoHNdwdGycBaJos7UkW
	vfESiAJVMagA=
X-Received: by 2002:a05:600c:3b88:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-4562e355c9bmr68525975e9.14.1752758598477;
        Thu, 17 Jul 2025 06:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXUaojOCvzBHn+KqDc2+2N5HsM1E5SZahUBXJwd1vHENhmXkX/VYLgSv3x8wTcAP/8nL4eJQ==
X-Received: by 2002:a05:600c:3b88:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-4562e355c9bmr68525635e9.14.1752758598001;
        Thu, 17 Jul 2025 06:23:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm50578175e9.33.2025.07.17.06.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:23:17 -0700 (PDT)
Message-ID: <87cace03-dd5e-4624-9615-15f3babd1848@redhat.com>
Date: Thu, 17 Jul 2025 15:23:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net: phy: qcom: Add PHY counter support
To: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715-qcom_phy_counter-v3-0-8b0e460a527b@quicinc.com>
 <20250715-qcom_phy_counter-v3-1-8b0e460a527b@quicinc.com>
 <e4b01f45-c282-4cc9-8b31-0869bdd1aae1@lunn.ch>
 <23ab18e6-517a-48da-926a-acfcaa76a4e7@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <23ab18e6-517a-48da-926a-acfcaa76a4e7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 12:15 PM, Luo Jie wrote:
> On 7/16/2025 12:11 AM, Andrew Lunn wrote:
>>> +int qcom_phy_update_stats(struct phy_device *phydev,
>>> +			  struct qcom_phy_hw_stats *hw_stats)
>>> +{
>>> +	int ret;
>>> +	u32 cnt;
>>> +
>>> +	/* PHY 32-bit counter for RX packets. */
>>> +	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_CNT_RX_PKT_15_0);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	cnt = ret;
>>> +
>>> +	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_CNT_RX_PKT_31_16);
>>> +	if (ret < 0)
>>> +		return ret;
>>
>> Does reading QCA808X_MMD7_CNT_RX_PKT_15_0 cause
>> QCA808X_MMD7_CNT_RX_PKT_31_16 to latch?
> 
> Checked with the hardware design team: The high 16-bit counter register
> does not latch when reading the low 16 bits.
> 
>>
>> Sometimes you need to read the high part, the low part, and then
>> reread the high part to ensure it has not incremented. But this is
>> only needed if the hardware does not latch.
>>
>> 	Andrew
> 
> Since the counter is configured to clear after reading, the clear action
> takes priority over latching the count. This means that when reading the
> low 16 bits, the high 16-bit counter value cannot increment, any new
> packet events occurring during the read will be recorded after the
> 16-bit counter is cleared.

Out of sheer ignorance and language bias on my side, based on the above
I would have assumed that the registers do latch ;)

> Therefore, the current sequence for reading the counter is correct and
> will not result in missed increments.

Andrew, looks good?

/P


