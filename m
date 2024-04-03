Return-Path: <netdev+bounces-84425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBFD896EA1
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FF0B23096
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52257145B2A;
	Wed,  3 Apr 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU3zeFGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E6143891
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145843; cv=none; b=rYZah9owt4GcgID6mbPov0v1ZIW5cBYVrhIEDd9YErrTKHEWxVjgng/5faf1+Xv40vCJKiejQbTeEjLYJfN+zP04ih0mTjs0eFQaNAPPr4copuZ1xeMhzVLgBHGF1B0uqj3E6pm1ntwyXULDgGgmE1GLnXsR0u6vb9Ca1eEro8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145843; c=relaxed/simple;
	bh=p2QvsVlb5dDKU3rvnS3xF7xwbQTZQ+LkdjO1doc1L/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK0sZnDZz9PY1vrXaR2EednVvH4wQiSzRIEXhs1lIdBqtnJxC5WxIoD4XWfHoLmeDH/HPa9exzWdd5v4COuz99ZSPf1QqSvjP4y+KNVOAhnmPWJJpvTpG5M8JdZTAi0q6ec39ZZHMMa3epBDTnlLKV/aj2gHP3cCs0NafztEAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU3zeFGk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d718efedb2so96559891fa.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712145840; x=1712750640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQuR+ZWvALKY2pv0aAp/bCUuAX3STUaEGBYLUe2AHu0=;
        b=UU3zeFGk2UE69ZQkmC/+5o2xlRV99+TTa/SKus2AallV02QH2d7aNeCWaHI3jMzJY5
         FPn8WcUqMUHTgEWtDSBJkMIYifMrzV0m0pANrEZovaCVuDBOAf51baOoD3vx0d3Nn9Ax
         3JIEiBJZZLu24YJit3RcqTpU2qc28OCO3gD0qOqJoThBAUj/AKEZIpFqt8cuZKTpa2kv
         NbbPuu1ayinOIYeJ11qCLuQ02QZXdnhflZIOE20WYLAgO4ZVEjb1hfGwhOy/PPmDXoE5
         oDI8D4xC1rpEEj3jkl5z2SnB4AzFK0X5+9akaNyIVl8pfwEngWt0xZjSfMIrSwZWn+/+
         LSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145840; x=1712750640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQuR+ZWvALKY2pv0aAp/bCUuAX3STUaEGBYLUe2AHu0=;
        b=rJhe5RrPXDA2P1YNiY2xN1N7xRvOKkPrV8SFhfK5ISRyQ/RPbyOvK+v6DisYuPZ4ay
         Q75tzkxDVz5sx2DA+lZ63CLDiM2kgoFXHgDtJ53ju8bjTdsAF3Pn20EjP6sABdp29zKT
         B1hvFh+6d+azUWrKd3MyDh00Hcr4PLJNSiBgd8dg4hjWKMaTzMBG6zNqDa0n6SzofhyU
         vZkw0m1IVj8x05ksO0hRTCd7ZLzkXDTZ3kh/+lRfJcdtDI2a7YYcqerFf7/9XLRHqjNK
         U5EY1xRVi8LKdcSmb7FJSH00PcG9687+oGc60weP6A7nMQDwrA6Ab2Qa0JAU1B5KvTLL
         glzg==
X-Forwarded-Encrypted: i=1; AJvYcCUDtu3a0lTG4hReDyu0gYL3N47MElaNM5lvaXZ7Q8Mi2CPVHNYg5dO5+9hHArxHh3V1aNlt/OS//nRngua+4rKRHI7YoHh/
X-Gm-Message-State: AOJu0YwDMvhHd9BQK2Oc+WYKK8zZX7kiupfCbD1DCOOnwu8RLd5JrPXT
	Hw5LbqHOJmGBgNxkt39VZ//d1tPiRkse35q6XL4C0GASndnqGvj0
X-Google-Smtp-Source: AGHT+IGteZJRS6M5tPakVDO5j9Xyuv1qCjE9Vb1dpLh8OsqV2bCnxvS38TLuzETdo5Rovt50Uiqtmw==
X-Received: by 2002:a05:6512:3152:b0:516:7de8:335a with SMTP id s18-20020a056512315200b005167de8335amr3970576lfi.59.1712145839535;
        Wed, 03 Apr 2024 05:03:59 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v21-20020a05651203b500b00513ed62b64dsm2016144lfp.301.2024.04.03.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:03:59 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:03:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
Message-ID: <7myfmz72mdp74k3pjtv6gmturdtm7pkghcwpom62hl52eafval@wmbtdwm5kitp>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
 <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
 <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
 <e57a6501-c9ae-4fed-8b8f-b05f0d50e118@loongson.cn>
 <tr65rdtph43gtccnwymjfkaoumzuwc574cbzxfh2q3ipoip2eo@rzzrwtbp5m6v>
 <e6122e3f-d221-4d95-a6b8-92e67aa51a5a@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6122e3f-d221-4d95-a6b8-92e67aa51a5a@loongson.cn>

On Wed, Apr 03, 2024 at 04:09:21PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/23 02:47, Serge Semin 写道:
> > +static int loongson_dwmac_config_multi_msi(struct pci_dev *pdev,
> > +					   struct plat_stmmacenet_data *plat,
> > +					   struct stmmac_resources *res)
> > +{
> > +	int i, ret, vecs;
> > +
> > +	/* INT NAME | MAC | CH7 rx | CH7 tx | ... | CH0 rx | CH0 tx |
> > +	 * --------- ----- -------- --------  ...  -------- --------
> > +	 * IRQ NUM  |  0  |   1    |   2    | ... |   15   |   16   |
> > +	 */
> > +	vecs = plat->rx_queues_to_use + plat->tx_queues_to_use + 1;
> > +	ret = pci_alloc_irq_vectors(pdev, 1, vecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "Failed to allocate PCI IRQs\n");
> > +		return ret;
> > +	} else if (ret >= vecs) {
> > +		for (i = 0; i < plat->rx_queues_to_use; i++) {
> > +			res->rx_irq[CHANNELS_NUM - 1 - i] =
> > +				pci_irq_vector(pdev, 1 + i * 2);
> > +		}
> > +		for (i = 0; i < plat->tx_queues_to_use; i++) {
> > +			res->tx_irq[CHANNELS_NUM - 1 - i] =
> > +				pci_irq_vector(pdev, 2 + i * 2);
> > +		}
> > +
> > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > +	}
> > +
> > +	res->irq = pci_irq_vector(pdev, 0);
> > +
> > +	return 0;
> > +}
> > 
> > Thus in case if for some reason you were able to allocate less MSI
> > IRQs than required you'll still be able to use them. The legacy IRQ
> > will be also available in case if MSI failed to be allocated.
> 
> Great, we will consider doing this in the future, but at this stage, we
> don't want to add too much complexity.

This comment isn't about complexity. Moreover the code in my comment
is simpler since the function is more coherent and doesn't have the
redundant dependencies from the node-pointer and the
loongson_dwmac_config_legacy() function. In addition it provides more
flexible solution in case if there were less MSI vectors allocated
then required.

-Serge(y)

> 
> 
> Thanks,
> 
> Yanteng
> 

