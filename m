Return-Path: <netdev+bounces-164272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A19A2D302
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD63AC2AA
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB21465AB;
	Sat,  8 Feb 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/ziB83/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD9522F
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981132; cv=none; b=su13hLVrn9QPlTMaGRRDy6mYkN325W9gRx1gNu6oFM+T4F5nVxsL1JnMWEycpFVIl+fpAxo8nnhDh0zVSyXucNdzG4OdKAE1Ko3b5aA0fx45twcPzr3HbDrBgf+RanAw+X6suaWzbx4F8LZjej66hQpMmLJw3Hb+7fU0td3Valc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981132; c=relaxed/simple;
	bh=9nvDh+G5Dgqc5oE3152DaXeBYJ3LczX3hO8S0OatEy8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S0fB8w6ai+/ZMEJTdkRgRFkyMdiiId/EvyW2DdOOCDYNUcxo8+qF6DxYm3bmzAqHhOGNXrTekdApSX8mEAbSmZAcTvRYyXneGTgWabwjxRUkj7VJxuAET2c4c6y/fgdaLxwLkNqmLBK3XpQjnstKJ0tdg0c36kM8WX2X2sk9I0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/ziB83/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so17841585e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738981129; x=1739585929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nvDh+G5Dgqc5oE3152DaXeBYJ3LczX3hO8S0OatEy8=;
        b=g/ziB83/oGYgg2lcYB32vJLOmnnv1yYfj7fQ80UMdXfhglQIqIHk1n9uwir1/wLpmO
         fqWVDj6KPcR4yKYq/1H+QCsREkyax8roXGDs25TgD09QAm2VKnMyozy6AQ/ovfLZV3x2
         TatnxFstxpZ2L7C3EUEnHkjX5ctJTb1mHi3+GcutqshQI2PaUUPh4Fx/m3ToRnFRt+1r
         wml9mqC4yDVADt/kyI1Ls3RU7VvnCQJhERpFjM/GPJ2E6nY045cFekjgIPvT8CxDywEG
         CbXunIASEhHpZzbj/3Bg/q8NXAS8TGgInRayEi7XqXWT0K64+BirQpXe/htijlqaA36D
         ezAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738981129; x=1739585929;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nvDh+G5Dgqc5oE3152DaXeBYJ3LczX3hO8S0OatEy8=;
        b=sImdUVAJWyQnjWYkyTkXC/GQjy7crtuHy1iAXq/E+BQUT6Ys/vYbr8uucByeebVmuS
         r2UrIIW1Z4pPTKDPVyB8HLirU4Gh3m7VObzoQLUVCS5Jbr2NhDyMi+WzLPkNm4eZQHql
         Y6jjJhnN1C6d8TfcrBfbDIIZXFUg7w0/hSGVx92HY2EVQVOLrm4Hb6GpJxnL79KoOfcz
         zw7461C0LnHTVJfogBKFAYhyaP8PhEbmKn6ybuk/KH/jJWdfVbXFuvwLe4EWrwktNVjv
         d2Lo9IhrNEF0IzIRZi1wTDX5X5FKlQAKH109DBmQS/5O69sDhZK6QsqOhmnXLiaisajI
         lDEg==
X-Forwarded-Encrypted: i=1; AJvYcCV6h4VVIC7w/7ehE0+xIHzR6BLHjj7P2TGGMB4gv1tyDuoYXrz+LzDYGlgmMPcxyjQh+kpb27w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHt6sQVAPqFSGPM4TpWDDtroJzR1B0Mt+W/n+QKhzfgOna/T5
	hYvUiPmVYsYppi5fPg7EXg+7+YmDAgf+tRFV6ipODS/p8ENAeahKUFgL7A==
X-Gm-Gg: ASbGncvDwyNVmsoOyAVSxVuRZSE/m92aSjQQzp4E/ohUB0/qcCkUWa9kgLO7UKOM5GW
	qvEYM1dYKrFlq3AotOw34Qsw0IPSl/+YPVjuXjUBcQGCPKQ1fZQvNcd3Mt2sMrINJ/t0qoyKH5/
	fdAw4tUuWYmaMFxGL9+L5PveUuWjR+eL2uUSCIcs1dE7vEZm2ajrO3zBBuaUVCNkjVWNqDBFVoF
	LiBaEBxPYOy7+kHVOXujj7eMCfDRCp3XkpM/+GJnSDhWaeDMPaxUE3kz3YOXtskd0jfuwKTAd8p
	B3mVYKFVtSmzBbxajNTLuF2pCqjqEcteqAPNq0BlvEDnEX3ZSImXXXNOu9S68mZJ84mMmCmHFc1
	sekc=
X-Google-Smtp-Source: AGHT+IEGg8nBpbGY6sZ26Mfm0vA4MJ+3Xa3y31rQrUihjrjn3tJTV+yiYIOw6PikN3A4s/06NDYM5A==
X-Received: by 2002:a05:600c:3485:b0:434:a7b6:10e9 with SMTP id 5b1f17b1804b1-43924994529mr43628425e9.17.1738981129003;
        Fri, 07 Feb 2025 18:18:49 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd5e3cddasm19932f8f.22.2025.02.07.18.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 18:18:48 -0800 (PST)
Subject: Re: [PATCH net-next 2/4] sfc: extend NVRAM MCDI handlers
To: kernel test robot <lkp@intel.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, habetsm.xilinx@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org
References: <6ad7f4af17c2566ddc53fd247a0d0a790eff02ae.1738881614.git.ecree.xilinx@gmail.com>
 <202502080054.s619TTmK-lkp@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <8233a271-5f16-30da-708f-0ca2746d74ac@gmail.com>
Date: Sat, 8 Feb 2025 02:18:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202502080054.s619TTmK-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 07/02/2025 16:50, kernel test robot wrote:
>>> drivers/net/ethernet/sfc/mcdi.c:2195:12: warning: 'efx_mcdi_nvram_read' defined but not used [-Wunused-function]

Looks like the caller of this fn is only built #ifdef CONFIG_SFC_MTD,
 so this fn should be under the same guard.
Will fix in v2.

