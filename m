Return-Path: <netdev+bounces-203493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC3AF6211
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947497AF8E4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F32BE630;
	Wed,  2 Jul 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTv40vFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B04248F54
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482680; cv=none; b=MDNBOHKJdRx5NOGjZZQZGJWNfVwBXm7hY310stOPOfpI1pe/+Xuy+RCBaC+BlGPkkry2vnjxIw4LxMmhpa8VccCK74Qjvf77eyvaQmUJWCQlryNg/KEzwn68hZIZmWlozGkrEKRr0XSaByhsFKf1LJBbzD5pGq1FPjYiUWsZ/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482680; c=relaxed/simple;
	bh=YOy9dYklOOi4NqPwD/tdGPr59Q/ZLgkUfj6Gkhh+mbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVceMhzHmO/NRc2s3jrGMFPp/8ghPRNPUhnZYhfr+Z2M/EWWvUGDuCnzERO5yAye+xAHz7zRWj51onf5qwsXKdTFB6Lz/NTPM+v09NqYcR43XqMcXHKQKsI0uuBc4ReCD4c5iXiDmpvBDQf4ZiAnTydzl8zuimLDsZ9dEm6vEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTv40vFh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso46035875e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482677; x=1752087477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVXxVN+j4acOYXNJGE4TYsu0eo0UWgEj7WHyqs9riRI=;
        b=MTv40vFh/j5oA5Ze2aUUyiMbdArKiiSzFFpHnQAa1jwOOnZyPYvh+gCFoTiBMk+BDO
         ZJMwdojtNpwygmkNRY0uviqrxfhNP7ETuWoZU4pm6QqQglrV3MGSiTUpnZmIXYfrH2iD
         31kQ1FIYVEktb/KhRiSY8hNJNEdCbFe802Mt7vgu/m97cb+egHbu9MEkMuo2YPWfUhsE
         adAV8gSRU3F2p+5TIQXJmwoRugTG/6S+GEq0viQAGszAPb1GPqZTy7S3jXsY6O/D3o7g
         3N4XmMuiekixb3Zy2FnrWEtxLIO1ZKCiajNpjvLE3Y6vP7Cjexhwi4k11cBwv/DERQLh
         R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482677; x=1752087477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVXxVN+j4acOYXNJGE4TYsu0eo0UWgEj7WHyqs9riRI=;
        b=tbohUxJNEYdkprhukmhd4n+FuUJfZikm8TqjSrRyEeDw+t0cr0rqJyIcUGxlS9lobP
         NSksIzF6nDt2G5k9qDDC4p8DWiLIB7qiBiip1ijdzZnXbik9W/cn78gY0i/3LCG/RP4z
         iyQkCYBrA7hD6IwTdDk92+HzxYKF9mzbdMmFjt6TBBmebDFlRxlxWXFUonERaQAJLQEI
         FsTGAuvpv4xEWWR3+fHWfh3tz65/CS9KWsuZJHKIXnzfQ33lvnoP2IFstF2RekS7OFzn
         EtAfabYXUFKDQJfZyOyoCtwh6G0HCoMB9Q1b6mXd12I3xiq0Gz7vYG8HzXCWU4fF5LLM
         FFsg==
X-Gm-Message-State: AOJu0Yw8s4zGdMTjCrGsX0M02t8LSNOa5GVgn6svfnej2ioeC0oep3D3
	rVJS8baiXi6Yxig8/VAZFd7qmBry1/0RkgyUeDRZJ0XfxduNrJzvpelA
X-Gm-Gg: ASbGncuf7xaoKvyqzggCKV0Kf4C5ot+I8O6xoiLG6FtH72lWBAZ6MwJVaqAau9Lyfj7
	HSms5Be6AmUONO1tXyVxgWthD/KHiOJr+tNbu5shASBhSg2ftUErjltVZbzHjbKSjkQmDmBRT4D
	V2nJBshQOz7y4alSDJ2XQAEFDcsGRsXkj4bWc0uZish/VWBHZmpRzi5cEY75w+Il6iXz5Pmffqp
	UY1dp9UEEaRw2l4ZNN7Jk2PAFp68xEMDKd8v8SPUa4/QRN3lVqJvB4HRLuGEH9viTJGJmp3yffC
	EpjZA718/7L1yDwLDYLzLbMWWR9sfXi3Ve05LJGG9Rn9snTJLFCjI8n64Ia8IknAOecrVYp452v
	0ukYaCdUsN2Y4aurmp/d6jXn6egLD5THgV6ROagxCYrAduWvuJQ==
X-Google-Smtp-Source: AGHT+IFwFiQtJ6a9A4uioNj3Bz6ux9VsQKnJgaLiiDXgJE9PpN2CaQAS5UGxDCJJlTQfYDwypDfrGQ==
X-Received: by 2002:a05:600c:3b24:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-454a371d3eemr42461665e9.27.1751482676460;
        Wed, 02 Jul 2025 11:57:56 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99bc81esm5604675e9.33.2025.07.02.11.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 11:57:56 -0700 (PDT)
Message-ID: <06ad8469-56c0-4558-b214-232050143148@gmail.com>
Date: Wed, 2 Jul 2025 19:57:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: ethtool: reduce indent for
 _rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, gal@nvidia.com
References: <20250702030606.1776293-1-kuba@kernel.org>
 <20250702030606.1776293-6-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250702030606.1776293-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2025 04:06, Jakub Kicinski wrote:
> Now that we don't have the compat code we can reduce the indent
> a little. No functional changes.
> 
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

...
> +	} else if (create) {
> +		ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev, extack);
> +		/* Make sure driver populates defaults */
> +		WARN_ON_ONCE(!ret && !rxfh_dev.key &&
> +			     ops->rxfh_per_ctx_key &&
> +			     !memchr_inv(ethtool_rxfh_context_key(ctx),
> +					 0, ctx->key_size));

While we're here can we unsplit any of these lines without going over 80?

