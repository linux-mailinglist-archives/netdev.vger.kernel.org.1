Return-Path: <netdev+bounces-158595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948DCA129F8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B963A3DEB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C919922A;
	Wed, 15 Jan 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FkTn2oD8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2624A7ED
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962532; cv=none; b=szcb4C+Dx8ycVAVoe4Z77/FCGXutRgWutlGnXB/ljCqgcCUXLbNrafecLcsa/r0rPqlQe/6Gi4X1mKE3Zq9pUMUvE7BgMEOgMK/3+MELT+Yv+8oEwvhpe7DbjE5VGK67U2nhCB+j3a1/XZOhBDb14IbCWYPRxQQhGb0tUjj8H34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962532; c=relaxed/simple;
	bh=Jo8aL5VG2iaQGf1RgZwXxeIOleNjhAR4oR8U3AskrE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZYEchkC2r3+P6YAqqCqcrgei/4gZ7NXls5MeeuhyKk0ibyn8fy9jTgWTcsEQnPjSZBVQcMIWGVw1p3E/pHLgHY6IWlwy8yL4coEuy75Gg9eEfiF1YUSPOH5zRv9WxZCiFJ5o/Qho01WGO6ENUh4trF32ITdOa9M+KN35ohGteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FkTn2oD8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2165448243fso156210705ad.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736962530; x=1737567330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drwGg6Ggv7y2iA4MXzxrkwRrSRb14xgzjKtqkAwh0hM=;
        b=FkTn2oD8tpPZJ/iHdDEr6GiOsMIhKCfSRFcL6IVftisNZUAtTTxSpCdCCkmZn3XRwR
         pXwMbL2RQ0Ou2RYDKdS/tvDi+GsnV7rQmDE8qmwoMJ42RUl8HE203KBy2JSF0tu8Sa4N
         wrpsYzlLiRO815eQftBN/t/RCTdmtQl9MXASg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962530; x=1737567330;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drwGg6Ggv7y2iA4MXzxrkwRrSRb14xgzjKtqkAwh0hM=;
        b=iU0EPBmKevnHw3R8GMOeTQIHDySaFCyCrelACVt4h1kZGN7wnLbrNegeR0dmuvPQXQ
         HCC5MABUZV0JfvPMJ3cbdF8Tn/bTR/XAt1IfQrEfDdanK7NCjikf1XGaQy3yqlOQ35Ag
         ahv64nh+EtIXIzZ8OMeeZDfLJ7h8/AmNR2mU+lRg0m41RWSeE4V2NOs0uKwx9rj2kAnM
         LWAl+AKAWKbRGEOLPGgFTHSfG6QGujSyFPs7iCnkmKvxlmqVR20MhyVZbQQML2rcoVSa
         czl1UVV8e0YA73SLEQxbYz6fPVxifOt98GicevzghlnWRxLys5U0zcsb4r66Qgf4vNAk
         RY5Q==
X-Gm-Message-State: AOJu0YwfTXdQPRkAp4D9ZSfgriAe9SxuJ4JWiaUUAwzdcPBE7TdnWwY9
	vZ6nVvZ6YRcofyIognUO4D38Q5R+A3oeCUSblA8wKe2aCHWboar6M+kzOR8BVEw=
X-Gm-Gg: ASbGncsHyY8Sp7JhZuywoLq2PchYoRvWuJrFFnH4h4wBszAOBQFv9+Sua5UAYNRxflC
	A0QJtuX3bOhp4MvtZKZHoVJtv3U74hYFF6B4BmTwTCP6gvI6iazCI0RNjBqTd/LJzqCTKYmoa+w
	HpMMi4NEW3Eb1gE0dTKPnCC3b4e2MeAf0n0SZKWU3pBwXMVWJewuY0Uix0WEF/9ohyE829zE5Qo
	UL2FZ9lhsOTQXmhSaTs4hjlxJsBuRnOhRb+mDGBOE4ptDmz4UyruWXOmMvW35jY3Mwp/rPwuY7t
	U2vThodO0dRjd2MCo/jGnNs=
X-Google-Smtp-Source: AGHT+IHh9H8PaJ6cgjJiGUCjtnIBHOrMsIR66gZMMMrlpxbHphZLN5joIg1CaCDzyN8qA1Kz6Fewvg==
X-Received: by 2002:a05:6a00:2406:b0:72d:8fa2:9999 with SMTP id d2e1a72fcca58-72d8fa29fbdmr3989071b3a.11.1736962530490;
        Wed, 15 Jan 2025 09:35:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067ede1sm9361054b3a.124.2025.01.15.09.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:35:30 -0800 (PST)
Date: Wed, 15 Jan 2025 09:35:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v3 4/4] net: stmmac: Convert prefetch() to
 net_prefetch() for received frames
Message-ID: <Z4fx32HuqJk-0cQS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
References: <cover.1736910454.git.0x1207@gmail.com>
 <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>

On Wed, Jan 15, 2025 at 11:27:05AM +0800, Furong Xu wrote:
> The size of DMA descriptors is 32 bytes at most.
> net_prefetch() for received frames, and keep prefetch() for descriptors.
> 
> This patch brings ~4.8% driver performance improvement in a TCP RX
> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> core, 2.92 Gbits/sec increased to 3.06 Gbits/sec.
> 
> Suggested-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

