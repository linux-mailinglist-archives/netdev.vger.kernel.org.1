Return-Path: <netdev+bounces-132356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A9991656
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BEE1F23786
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E313C3D5;
	Sat,  5 Oct 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="TXHGrA/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D3231C96
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127074; cv=none; b=NCKGbk1OaDhIZ6lzW277xwYIOaqLlhY687s8RE9P2/lJiBA9I29RkaBRk3rUYon9eBOA/wSWZFMXIlRZkJLlIfqndLnPmyKXPMeu9K/Wg3/V6CxuA4yE63Y7tdF1DGk4/DrDlcEtuMbwTuezQ/XWJMRzw7q0SHHhNWul6MTrNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127074; c=relaxed/simple;
	bh=DRo7vHdnjFwQU4nf6CXl9RzF8HWag28ODpl29FYFnJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDaa7Wi+LGXiA8p8S5HBlUQP1q5paYdA+jzCMBTAeSdNdjFegmAp6mfzr1qbCNOXdGu6Jcj95gx8qgyMd0sXzWv1fEvtp2Ab7l6/Xy3eyIjmkzjjSie5O6fRpFvI75Z1IdZRNcvuUmP63+Ogqsp0rn/ET/kBERA1dS9s4SGu8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=TXHGrA/b; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e09a36f54eso224726a91.1
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728127072; x=1728731872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRo7vHdnjFwQU4nf6CXl9RzF8HWag28ODpl29FYFnJg=;
        b=TXHGrA/bf2KSMkLFcEGKrorlAghsiv3mQUL4D35ZkmzEQmyt7m6N6YyMTaEl46Vz4s
         hPfLgpshl1iwhANnzlFH+yeNHcCJwd+KehHatnfN/3zFLs0pkJXbF1qhO3syl6PnfUIf
         n3efhBuFPBtkWCL6xmH0osS2kxEwnIcd4p+PSvb8lLtSFcK75kLUGIwE5YGPsTFDZh9o
         azI1iOxMue5jXJIrnps1YZWbOGtuNO2njwAptnaRD9wWYrh4UcAYz+OHGow3kAXTU/jt
         A1Umx+aHPGCkfH8D8Gyo3fZizzszixE+YIOn+PlzJN2oFfdxNqrHZxlXR6swNyhiClcZ
         EtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728127072; x=1728731872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRo7vHdnjFwQU4nf6CXl9RzF8HWag28ODpl29FYFnJg=;
        b=hxTCsVGIZNS+/X1Ism7ah32h7RNmx3SuuX6kuPSsEVJP5EzAXlBEOHTj/F3jrgmxCy
         iVvbRPh2HZL6u3YIpSMbTwO4oQrliLCQO0ktmWVWFXWEBcEQayLF98IGdKIRkhyRm/j0
         4dxlpv4f9m0euOSlYlcPp9bw0e/3O/gPVfss/Z1MmrWr0V9/1go0eEv6hitgkgyuZbb8
         Wx5qX/ZaFQZLmDFY7KHKVLTsNkXL39KjXW2GxatAav3sR3tneFQ10twCuCFqMh8vMlke
         H1mn9xqv/0MPhcGjllpnWL7431AMMDdsAJyMytfFvTECXXZNNrb53Gna2Jgye4ghWzKX
         ExRQ==
X-Gm-Message-State: AOJu0YxtfI40/LB79qjr/pMjfOqQcWe9GiUoBObwK9qdstDIR82VNr3l
	/zMKtkzZbf66/fiJ8jD6Wiv9a8zQlJMWtrOHNd9H0BBD6aTq0FJsGy/VP7a4LLE=
X-Google-Smtp-Source: AGHT+IGlsnSHLeKczLP/HhY5blIJBKh68MDtFL5t0xmb4hyeE61W39EmYEUnK7Nq/pq3OeRTxLzXMg==
X-Received: by 2002:a17:90a:d147:b0:2db:60b:3669 with SMTP id 98e67ed59e1d1-2e1e63b41b1mr2641766a91.8.1728127072140;
        Sat, 05 Oct 2024 04:17:52 -0700 (PDT)
Received: from [10.0.0.211] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85da3f0sm3309039a91.30.2024.10.05.04.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 04:17:51 -0700 (PDT)
Message-ID: <e0e7444c-60ef-4f7e-a7e6-18ac7580b402@shenghaoyang.info>
Date: Sat, 5 Oct 2024 19:17:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/3] net: dsa: mv88e6xxx: read cycle counter period
 from hardware
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
References: <20240929101949.723658-1-me@shenghaoyang.info>
 <20240929101949.723658-3-me@shenghaoyang.info>
 <36b11f88-f5d2-41a2-877e-e231c2985f30@lunn.ch>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <36b11f88-f5d2-41a2-877e-e231c2985f30@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/9/24 23:31, Andrew Lunn wrote:
> The mv88e6xxx_tai_read() MV88E6XXX_TAI_CLOCK_PERIOD is not going to
> fail, except for the hardware is dead. There is nothing you can do
> about that, so return the error code and let the probe fail.

> What you are more worried about is if the value you get back is not
> what you expect. It is not 8000 or 10000. I would do a dev_err() and
> return -ENODEV, and let the probe fail.

Hi Andrew,

Thanks! I'll sort those and the naming in v2.

Shenghao

