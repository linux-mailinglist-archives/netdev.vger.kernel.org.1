Return-Path: <netdev+bounces-168126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D708EA3D97A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB85E178AF4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2071F471D;
	Thu, 20 Feb 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPWwdPZ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFC1F4626
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053179; cv=none; b=NcXrBELkW2RXjTELBZ0RnimHMwqmK523gNLZPUz1h6icjVdEt0ReGWvdNIwsMOH346gMPXeDDC+rjpNMf/t6RLL+CO18dOaIl/qNogpUpBwsWkSbnrHYosdUky/thq8rWQRLqlTUDbIOKgvSoKM6ka8TNN7j4Pxoe5VCj4KBAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053179; c=relaxed/simple;
	bh=1g9+1cZqge8rnomoAmd54b5eLonL6/ZnUBtX4cRQtmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kXb/guzAUtPUyve85qDrizZ6jrB+xMk8yATJcdrF/7CiJXjeKCdEQNmtzV4rOGs9ZabedxFCRN2IQBoXqPByKJkuUPp/z5Od1KIfhbpel9HZ8E+vC8qZgx7H0/C/nuthCkWaeus64ttZC/4Zf0ryCT0FLgTBU0H5N6WYRMjHc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPWwdPZ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740053177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ho/1UvI95B5CQStQMwkcH2O7mPFLu1K1yaiiqa4yxE=;
	b=YPWwdPZ9FiWoBJjjFrOr9c0sk2uaPus8nmnBoEXYSwhL1Rzc9iAiEqJ8eI2OiCpSI9LEkA
	DsQk8kYHe9zaW2Ipsnvta9ZwADKyeOJj13OdCDDaFtHETPhtqn3kXEKR0/IH78h5N51YXV
	ZZPkvVVwOA56FgNylhBuUv7bQgwKxPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-SC9yfZvSObGMs5pSqdx-YA-1; Thu, 20 Feb 2025 07:06:15 -0500
X-MC-Unique: SC9yfZvSObGMs5pSqdx-YA-1
X-Mimecast-MFC-AGG-ID: SC9yfZvSObGMs5pSqdx-YA_1740053174
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43995bff469so5622715e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 04:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053174; x=1740657974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ho/1UvI95B5CQStQMwkcH2O7mPFLu1K1yaiiqa4yxE=;
        b=E5LtN/5Rslowtps2R9spdiShsMhw3GZFXjzS+b88QSh8vMn5HNZAZ8O7uMrnMEmPLB
         UZKRPTbB7E6XFXW1SW1GfQDiIpqz5Xf6I9dd7d4AneAlQID+1q2InYqw16KCYk5Yjvvs
         Olty9rqyL4lEGlXUQN/UhqEQ0rSsScvPO2JmGpki1d0wmA6MqG+XB3LcWRAl+w4+Q708
         rDYvqL9SI1Sm16lr6girFccvDiXZei/8N/eiw5MnNIoJoRHmnl8D+lAhDjVtu9ENfGlu
         SnqCabqHwm6CFg5obDnLQSVK0n0yfcTmbEFkaalQLXf2Of0G+g4pLS83Yf4w4FVQ6WoM
         ZWNA==
X-Forwarded-Encrypted: i=1; AJvYcCXu/p0QsG+GR4WUAzuh0IoI7Vq91n8MGy1BWHsC4hQSDB6MOA233rU/zkKQwag9p3KAZhqsae8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGInqNpsCtC3jAmRxLdhbSb0el/Tx7RwGi6N22iTuZmWmRHASq
	oOsqi1gmIub8sVIETR3cngHf72IobwUdsciKIdb0cJHJ+hFmnpGNrrOQmMmxV53vQShOiIr9dSA
	vqK4sIPnjhmMOUo3y+sinlcPvbQyFQidAnsWulIePOsSpdqT+CBzlOw==
X-Gm-Gg: ASbGncvo2A6YQK7EcKTmEum/I2zenTZWWjXUSU+k0O8IoDVgD3xa63sGRDphF0u3Rjy
	4puNWKQDKcAFRtChjL0lok/ePxIrIkX54X/2u14CjvPG2lohMCJ8ANx0rOgFAmkfeFPNCHM63IY
	5f2sICGlwhjgDvNiq6ny+XFr1/if7lh4P2BkBcnWov7rB2V+KjeInp4+llYyHNHncerdC18/9Xx
	u/eHg6M7HYgbzZdrh+TukzC/BdSBcHdWIMA/QQFxd4qY6EgWp3GgZ+viVzhxbNadvmEYL1qfVJE
	hzstojBee2z6i+7427/Hb7EbrRstZOe4t7U=
X-Received: by 2002:a05:600c:5246:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-4399e132fe2mr54814985e9.2.1740053174464;
        Thu, 20 Feb 2025 04:06:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd6GsM8jbxZduW4qm186TbxSW/IS1olT9UzqrdZI2rJSblVbeQhFUlIcSSzG9+n31CSQZzaA==
X-Received: by 2002:a05:600c:5246:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-4399e132fe2mr54814715e9.2.1740053174115;
        Thu, 20 Feb 2025 04:06:14 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43999e5beebsm54710255e9.22.2025.02.20.04.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:06:13 -0800 (PST)
Message-ID: <d35d5b44-e0a4-4d07-8199-dfc916962c39@redhat.com>
Date: Thu, 20 Feb 2025 13:06:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 5/6] octeontx2-af: CN20K mbox implementation
 for AF's VF
To: Sai Krishna <saikrishnag@marvell.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch,
 kalesh-anakkur.purayil@broadcom.com
References: <20250217085257.173652-1-saikrishnag@marvell.com>
 <20250217085257.173652-6-saikrishnag@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250217085257.173652-6-saikrishnag@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 9:52 AM, Sai Krishna wrote:
> @@ -61,3 +62,49 @@ irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq)
>  
>  	return IRQ_HANDLED;
>  }
> +
> +irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq)
> +{
> +	struct otx2_nic *vf = vf_irq;
> +	struct otx2_mbox_dev *mdev;
> +	struct otx2_mbox *mbox;
> +	struct mbox_hdr *hdr;
> +	int vf_trig_val;
> +
> +	vf_trig_val = otx2_read64(vf, RVU_VF_INT) & 0x3;
> +	/* Clear the IRQ */
> +	otx2_write64(vf, RVU_VF_INT, vf_trig_val);
> +
> +	/* Read latest mbox data */
> +	smp_rmb();
> +
> +	if (vf_trig_val & BIT_ULL(1)) {

`vf_trig_val` has `int` type, why are casting the mask to unsigned long
long? A similar thing below.

/P


