Return-Path: <netdev+bounces-160085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A69A1811B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3498D16C07C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E461F4268;
	Tue, 21 Jan 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAhZOTjT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214723A9
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473256; cv=none; b=n0tZurp/rGkqd5FVGTKH3kEsJms4KhbKE8uhxVvofbWVAPeTXe9NEghoQtv8+sbP4ZkbuScaFMTp1YvvhiWvakectv5mt3nEbYsOzFREBY9MqtRz4IywgIGq2pPu0zeVrm0pqXbj4BcV1fBjqCM+Vn0/W7pQuqUjUW/k+4ifm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473256; c=relaxed/simple;
	bh=Fq7COBk7La6FYiKmFf0Xy/LEW8imYsS5KHAF+f+SEcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITp9t7b+9z8YTwXtJZ+LsgUEC5XsgQq/7O+DzpAtqYX4WqX3SZfjqo//eg+FvVOi67E0iCwOK7kviZ2m4GLwXiV2DdBfXXQqm9mXPeiN9PT/a4SC8CCSdkOrvp66qZ0yOZv8+A1zQV6DhCN8DwCy0unpMSpDqzOYHU3uEB02SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAhZOTjT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361815b96cso40656475e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737473252; x=1738078052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVSQQDyKm5h8/4LSPnEGlEvlJYk3E3r8tFabQ1HU724=;
        b=yAhZOTjTvrhtWVg7SpAYffVZKjWiTG8g3P8GeLrfGDF1sGhNRbqnDnchxw4E0k+8AO
         ZmYIfHtosW3Zsh9jrQ3XHtzoaz3p/nxkwCFWrs6QMrmWRzhLCOujPcsGL1uEwSFBfLyQ
         HkV8CtSgfz6q/UChVqovdbGZcaf5eAEeurkH9cyZdk52Ky28D97/RBKc4EvOTw8DIkxD
         8CeHo1YxPsB+wLV2eWA0dPY1C29QYVdAM49k82LeHl6W8DTouETKV9VkoISslVSi/M5h
         rClXwQq54kflpNJkyZAjaqWRemc2nt7p9uk2Pyp8mrNEA3GwF4JCA4XJo4eOYpSB5NKc
         M/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473252; x=1738078052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVSQQDyKm5h8/4LSPnEGlEvlJYk3E3r8tFabQ1HU724=;
        b=OHmAlLT2aY2DLjwqErP89BHWXFZVhAZMxoWFpf4gxiJM0TJQN77XKEFatFRi4WfeOD
         ScDkd6RgXHL5D/+vUB0jWnO1cQzLnq0INPLtmlnhDXaXmJa3H17Xem/sSSM8yzmYOpzH
         fYiibyP1cViObIX2fxQKs8hrm/8y1wFCai5n/gHalo7YfcXaJYw4GHq+Dea5eADf9U/+
         QFMAVNwfQgLqujTNjjWMj2Fp1RQ1RjUDjJq8KbbdOIJb6nDamLRtr+YERg2Iai7DQSjs
         IDRZK0op4xcz9yMTjb90rD/WNkngRhC6LyxOujxWvy1E5QEvIkmc9e7qDcnUbdrgmD7z
         WCsw==
X-Forwarded-Encrypted: i=1; AJvYcCXHS/WVPT1/kGotbmCJYCl04mnnI9W5bMM1km9ZgEx6L+qpjHlb0y45gboXOWCMg2Vxo7q8YzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSn+8Xyio3omvDkE2E5XS7ftKt0W+4J2ZNSsW13cczzAfyUkU
	bRgToVuCUMSDnfc0FFVsJsAvAdXRTQrq1rUbXxsrbW8yqJ+NGOG7IeUnaUgNNR0=
X-Gm-Gg: ASbGncsNi1tko5qHile4AEVuVflJszOsJ/q5M52s+4e122fGYq4ug0LrGbDqEOWFL/b
	/InnskaJFCxsmORQBsp4QtOPbiQsu3ttcpVXvPZZYIToe+6OaRGEdjTdpiAWMw86c7T0tcxNXHW
	ZPANLq7Rv/s2azgKDYqpi3P9TZKfdJhd/tWb+GW/I0WT6rLWFyy4VxMNhD4FNjXIyhX7AC+hqIL
	m8q7aIxfnE5CQERAkEoEPFh3Lr9iruhDsAi6Mn11l4WMKRXIK3IT5jTLDqterN6swYLn2WbGRQ=
X-Google-Smtp-Source: AGHT+IGAkbgWf7RmJZL/xCFj/840jXhu5qaXp9uOClJP66n9ofhx5VtlIfz5t0yA/fl1pfVzSQwMBQ==
X-Received: by 2002:a05:600c:4fd6:b0:434:feb1:adcf with SMTP id 5b1f17b1804b1-43891436690mr136396865e9.25.1737473251584;
        Tue, 21 Jan 2025 07:27:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b1718741sm608635e9.0.2025.01.21.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:27:31 -0800 (PST)
Date: Tue, 21 Jan 2025 18:27:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, Francois Romieu <romieu@fr.zoreil.com>,
	pcnet32@frontier.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com
Subject: Re: [PATCH net-next v2 06/11] net: protect NAPI enablement with
 netdev_lock()
Message-ID: <06800722-abd8-4565-8f6a-5846fa40fbc1@stanley.mountain>
References: <20250115035319.559603-1-kuba@kernel.org>
 <20250115035319.559603-7-kuba@kernel.org>
 <dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain>

There were four more from my arm32 build.

regards,
dan carpenter

===============================================================
drivers/net/ethernet/nvidia/forcedeth.c:1127 nv_napi_enable() warn: sleeping in atomic context
nv_open() <- disables preempt
-> nv_napi_enable()

===============================================================
drivers/net/ethernet/sun/niu.c:6089 niu_enable_napi() warn: sleeping in atomic context
niu_reset_task() <- disables preempt
niu_resume() <- disables preempt
-> niu_netif_start()
   -> niu_enable_napi()

===============================================================
drivers/net/ethernet/sun/niu.c:6444 niu_netif_start() warn: sleeping in atomic context
niu_reset_task() <- disables preempt
niu_resume() <- disables preempt
-> niu_netif_start()

===============================================================
drivers/net/ethernet/via/via-rhine.c:1571 init_registers() warn: sleeping in atomic context
netdev_open() <- disables preempt
tx_timeout() <- disables preempt
w840_resume() <- disables preempt
rhine_reset_task() <- disables preempt
rhine_resume() <- disables preempt
netdev_timer() <- disables preempt
ns_tx_timeout() <- disables preempt
natsemi_resume() <- disables preempt
-> init_registers()


