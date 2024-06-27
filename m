Return-Path: <netdev+bounces-107397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511BE91AD03
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9C31F2343B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465181993B1;
	Thu, 27 Jun 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B2pBpWEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08071494A1
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506500; cv=none; b=P3b2FIPEsRvnooUvmIvD1gmZTLKoQtEImDczeEZfqDGXzSgFu9usb4r/F+8K0pj8UmZKwaSIdz3qcS5z5uL0//4VJZkGt82bmORbt5ESPcH30zka/nglPqDOOPYkrlBjYXmPsF0EKXoSd9q5VpBZVbh6XlZZXekf//vHmfJaR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506500; c=relaxed/simple;
	bh=u0CA2mnK5GIS2TbTnpjqwa5m9KRjDNpknWvMk92qW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnLM1qhmie7buAEKVTKSWqANiiW9/9CV/KvaSDZjF8rOSpHN7hztUrzog6YxcgsOcBatV4FHmT21kLsHUhTIda/ehjIihuD1QNeACj1a6Q2+nFe0bz2o8KHRvwT7W+l/EWQSbHRZE5wM5SXHxrvG2NGoylVaNSvOmWKzJ7Y0xNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B2pBpWEb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c06a06a8eso184992385a.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1719506497; x=1720111297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+1i7NWNKVTSjYDCvQQ69OikYKqZtAzAKVkT15CSvLQ=;
        b=B2pBpWEbJ6HkRMvAQZPZ12Hd5pBa5jXYHw3MctRQFqxgEXHNuRTgq6axVAaxvKvdex
         QvuVJYMWGx0Dw+X/8cQGeYO8v108O8Xq/3jm6g//Irz1DRQLaJj1vfEIBqeuRm6UHiHp
         U5Odzvk27ti+Q10UJ1ymzB+MTauMHMaJbZfyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506497; x=1720111297;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+1i7NWNKVTSjYDCvQQ69OikYKqZtAzAKVkT15CSvLQ=;
        b=WzAxHohh/IWog+xIX5APfcRylavUy0f52LOECo+ifuBn5Bc/lBgxlGsieuu62LqYYu
         UtNYOMpDYeatfeMvnsvbzpNdn2I3l3y9s2unRt6a0QO9FbMd1IcLhOcVu1b8qFvWgMXd
         vyIr0bleQ+UAC3cHYi9OgO5otFmftZlAVbV0EOy6OJHXGg8JPyHZ0yzoVaRsK4kSWrR/
         FmunQm9sN67Igb4y88kGcm+SErUA17SIyxR7xOZioIDuC8qSMHzobYxaCU8FhWStqyqH
         DVHZqMdqtd/wHBgNX2FTy9GX114/d/UIcwFwaehBTztowKp2of1VDxxntQC0cbNf2SdM
         sP2A==
X-Forwarded-Encrypted: i=1; AJvYcCW3S9G8SDNfaRNVn4TBe3oTH//1jw+OYKc8p3kAtgsUIKTzALcLYeu98Wtv8g+sif0ZklhJCHRaApVskOAJpI9/2dKja70M
X-Gm-Message-State: AOJu0YzK6VCNIKo8slnOYT23nuhdpfYThIMGulDTErCSNmd3Mhx2bzh3
	n0ITxWk9GJXPLnZNO5cCuf/nU2kup/lAbAIKzfufFr0yaqlmWOtdeK1jRyFGTTc=
X-Google-Smtp-Source: AGHT+IEeTnN8ngM5bC7gmArgUEvjJbKIkAR2vmS7pI72qKpgM/ZQgCxZTMR+iGrWbz4yDAn+bW1Ldw==
X-Received: by 2002:a05:620a:2984:b0:79b:e70f:3935 with SMTP id af79cd13be357-79be70f3b12mr1542535385a.62.1719506497610;
        Thu, 27 Jun 2024 09:41:37 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c82e066sm69457585a.57.2024.06.27.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:41:36 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:41:34 -0400
From: Joe Damato <jdamato@fastly.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	horms@kernel.org, rkannoth@marvell.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v21 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <Zn2WPhHOgBZFEvPE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
References: <20240624062821.6840-1-justinlai0215@realtek.com>
 <20240624062821.6840-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624062821.6840-3-justinlai0215@realtek.com>

On Mon, Jun 24, 2024 at 02:28:10PM +0800, Justin Lai wrote:

[...]

> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +	struct rtase_int_vector *ivec;
> +	u16 i = 0, j;
> +	int ret;
> +
> +	ivec = &tp->int_vector[0];
> +	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
> +
> +	ret = rtase_alloc_desc(tp);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtase_init_ring(dev);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
> +
> +	rtase_hw_config(dev);
> +
> +	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> +		ret = request_irq(ivec->irq, rtase_interrupt, 0,
> +				  dev->name, ivec);
> +		if (ret)
> +			goto err_free_all_allocated_irq;
> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i = 1; i < tp->int_nums; i++) {
> +			ivec = &tp->int_vector[i];
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> +				 tp->dev->name, i);
> +			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
> +					  ivec->name, ivec);
> +			if (ret)
> +				goto err_free_all_allocated_irq;
> +		}
> +	} else {
> +		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
> +				  ivec);
> +		if (ret)
> +			goto err_free_all_allocated_mem;
> +	}
> +
> +	rtase_hw_start(dev);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		napi_enable(&ivec->napi);

nit / suggestion for the future (not to hold this back): it'd be
nice to add support for netif_napi_set_irq and netif_queue_set_napi
so that userland can use netdev-genl to get queue/irq/napi mappings.

