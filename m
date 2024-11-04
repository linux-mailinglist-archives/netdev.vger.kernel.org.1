Return-Path: <netdev+bounces-141673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C989BBFDD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6C9B210E2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5331FCC65;
	Mon,  4 Nov 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxm6eUqC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE681FCC4B;
	Mon,  4 Nov 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754955; cv=none; b=l8caEn5sOHZhczt87eM6Lcb0qcog0+wjQPw22PS0gke60Nufw+bb8vG8PEP+xSoJZPkq71T5LcuNbbFmIsXknXLwp8M++syZDN2sv5NlAiZ6TlIOXRGW1DTNuKGZFhAqZHUdWut8W1o2V2UcI7sQ2bxZQPjOwiSF7OfeB+E/tvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754955; c=relaxed/simple;
	bh=G724cTYSxP4miHIIyEFDyCy7z3lHBjLNE65y3n6EGR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9gW3IFKysHemVrRm4xjSCNW8fiNGhOzBMQn9iR9ymZn7El/g9lQhVVu6oBQBlNHxc0+fpGVteroL0VyetEou9F1aCpCiq6NzsK2jXoiRAn5iV8zw74+1V/Whvr8vnSRzQLqS1JqflwXdVjS1547WmGJY1WAwvG0v5FluI2CY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxm6eUqC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43169902057so36518355e9.0;
        Mon, 04 Nov 2024 13:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730754952; x=1731359752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXDa4pJRXXSF53bW6sg5r+RrA4H/A0V2XZTYAKAhegw=;
        b=Fxm6eUqCmMQfpDbbCGcy+LeyfyZ8QLj4b9MeEFxkGgbNJdYw7Rcp8B8DRmXgK91XbT
         /aEYv9/5e6fTUFOVlqVMzzDqdmU5UoRvv+1UpbM1d3aVd3ueC7dHv6Fm4bQlgICsuFCn
         Nbx6JyOWrxC41g4ufm1j75WxbPM2mHXRUcxHJAVaxO7g1jkbGC2VvkanT4OsXc8O4DWW
         3yjUPl7E4o+Gwpxtl5clE+ixGY1xHAmYTBmKbMAvVij5AYjIO+Awy64BtwFrFlcdufx1
         wyEVZL6CN7PC3BhBvRNUGe1hh1X5c+NsWRZjQTCTH7y3o6mWv+gKLKMDAWLFLmrRnrE1
         Xucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754952; x=1731359752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXDa4pJRXXSF53bW6sg5r+RrA4H/A0V2XZTYAKAhegw=;
        b=XAnfsF/MmI/vaOZxc8oGkG/Y42z8TgLPKqH7yrMTsXmtJQK+LrUIygHkejph8LSg/w
         FVyh3ET7yoEheD9+5rcvoK5mkB2iQ3UiOFO1keT32YsUqu1/sBLsY4Q/RzF/lpMTkbay
         b45D2CdLKOn8MfevXhjqiwG5XxjzeeVdB+wSiBZwxfogFMnz/RqBrG/iGzxjqbFmpfP7
         bBfNoPuNSPrssDkGcbKStChzjoP31ArHAI62/dwX30kbLUAB5aMqVUuFXnP4s3ZHdqig
         8fhhMgSUSeABjJ7fT4ZEum8c+vxjD2pXw+Ecesx0cX9MvOPW/jbho1bPPUTc/1cIOLm0
         N5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVRUrqWydTW4z9VaLauZcDAaSE2f+LZi3S0xb2VZ+k30g+wAOxmv/VRQetxVbBkGXRQEvP5GS3d@vger.kernel.org, AJvYcCWMdolbBLQwrJKIM36t4CM6Jp0em3wlFi7Z16UCi0GIw9zxhYV5XrN5ttnFL58G1UdiQ03dzZZKVJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGF0aPPbbosaqlzpKvaNGPI+m3YuMZ6+NDS/McUQQ+5h1nz5Sl
	AFxHabShdr+2TePRSqn8ytNzVLzAwCA405f9CK7hSdVEZ30PWwQU
X-Google-Smtp-Source: AGHT+IEFhX8r7t2wnhakUur8cbvnOFOryn45oEMeOTW1QXqNNbQOndMdabsi1v2egkHAs2YMkWfzwQ==
X-Received: by 2002:a05:600c:1c29:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-431bb985df9mr186940475e9.14.1730754952179;
        Mon, 04 Nov 2024 13:15:52 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e7c9asm169928695e9.21.2024.11.04.13.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 13:15:50 -0800 (PST)
Message-ID: <8d7b1c5b-346f-4d81-a06a-809690dd4c87@gmail.com>
Date: Mon, 4 Nov 2024 23:16:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v8 0/3] net: wwan: t7xx: Add t7xx debug ports
To: Jinjian Song <jinjian.song@fibocom.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 corbet@lwn.net, linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org
References: <20241104094436.466861-1-jinjian.song@fibocom.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241104094436.466861-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.2024 11:44, Jinjian Song wrote:
> Add support for t7xx WWAN device to debug by ADB (Android Debug Bridge)
> port and MTK MIPCi (Modem Information Process Center) port.
> 
> Application can use ADB (Android Debug Bridge) port to implement
> functions (shell, pull, push ...) by ADB protocol commands.
> 
> Application can use MIPC (Modem Information Process Center) port
> to debug antenna tuner or noise profiling through this MTK modem
> diagnostic interface.

Well done, Jinjian! For the whole series:

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

