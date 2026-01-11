Return-Path: <netdev+bounces-248854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3853D0FE49
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 22:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3753043110
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1224886E;
	Sun, 11 Jan 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/4BEopE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1123D7CD
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165564; cv=none; b=FAlZXuF6xgnJInRj77RrPdY2xZPKC6UcCIWswJMe1YLur1eQcAm7HEX7QEIWa4bcIExlmDR03UHPQyO0C9n8f6VHyDFy9sY2LrmjtWuXLtJM2UE3D9Zgg8HgXO+b13lw/0CDttKLsSVnZymQdGLCmFCiMUj+bBIyrj/6WdOidRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165564; c=relaxed/simple;
	bh=u1Jkpw8NjtbE9Z4sIubffTJqLQzvKHtO8V8ejMIuAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peR6BdVvliTexBK8/ePrYP7gRS8eA/9LiFazk09b7UjjqIyltaXhMORikF3Jxsv0aunTmZjxDsLcOrFu/s+4F6fCCipHWEYgd/A/qRhw/L4c1+gRAiO5oCMp+p9vP3h3IdUKnMKdc/CWFKoiCTiJNV8A6XEfZSi1UI0PkTgoOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/4BEopE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47796a837c7so40177245e9.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 13:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768165561; x=1768770361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09OQOrO3GhfKvMA1ou0hkENJeEYVaIdNncnbvvzVVAI=;
        b=a/4BEopEzakthQdb1XqkBjkNOApFIMZwFPs5h8YhfYF3Cmp2dhflOoshASU8i/PQ6m
         SE+topLLZJdy7c9wSwAzS+2mHIl4BPTJMBa8EEwQNxoT6ULGGrSDhK26gVbwO2cJ4T+f
         FS++UiCToF3nFdG6yLArjRckvSbWes39hGHpdZcUHF0/Wd2xoH1I7QABy7UXausQcS2q
         kZsKE/JENid+a4SfNcxuNF+LzS4LEkT3TT4q0j1dNg8J1y3PWvT6O7FYbTlygspHHM8Q
         FmwOlh2bpItiVywLJ61VUh7uBGPuO3RP0KrUKbxGAcaJjPQ1AWEIuuUlMGjbkX9Wjso1
         7/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768165561; x=1768770361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09OQOrO3GhfKvMA1ou0hkENJeEYVaIdNncnbvvzVVAI=;
        b=ZFpHisig5ikzHknYzRdUKz6hxDCNw44+/r9awMwYBlYN3chYbM3x2FSDlpQEtLaUxT
         TNB/wLvWmYTj8AJJkJzrt+5ZQzhZUMv+1zW8+lOddVHt4FBt3C1wZBip0+1YZ0gkN9MX
         TAnvXZ2pXuNnGqeDe2/Z9ltjjmV7jZQBHUZxsqz3ClAbUAbh0DXVk1aSwB5hh5bqNS/N
         5nqL8hKDyw1FU5IGyXp4EwiTIGwX2LWIiEjM/10tg1keMoMVL9Zurit+Lkt5Tkr34ND6
         DH26tauEja8yg41ayPY0wcaYIcOncPPWQKqawQUqwvf4rO5+PtoQzoJ2y4/udlRBcy8c
         HyrA==
X-Forwarded-Encrypted: i=1; AJvYcCXUsh5+vszyz2NfKZuyROu9Jc7Zini14na/17uI4YgXVPo5wQQi6mCaFgfmQD+dtUw3ktiMOBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGJD6zt2cIgQq4Ntqj5ihru4CYVmAc9cXk2kVAcTamsKPuj+J
	HRT/zL59/PuNH2xh48uWtMANb/3ZnOFAQfutKA2WevcC7FsTEI9vMKWI/NPn8Q==
X-Gm-Gg: AY/fxX5fa9F8Uq47c1ygsWyd+vy/Zv3Rs7PLg3oHokeIBoRs06d6g7PY+Qvze2J0Z5y
	mZTG0pA0XyeikjJPny4zwL0Eaju7hYklL961kX/lVmSzQN/ci7lgFIUFTkJsF/msYjDFWdt7ndU
	kvydd06Z2AOHcjK+37QsXETMaCblLocnE0xclxHpModezw3Vq8jiPluTE4dsua+YJCMiEN5sq9S
	3QFiXiuIcUIHx+gHl1RfJvPVKA78pAMMBDYyqwh+kJP7LKP0fRh7jkAda1o9o7hnmLCElmwA85p
	1kYgwBC/DXepVqcqRTcdSQdkvEx6lbf27mldvtbS4UiviZCbrVCMIfKx6TmGWxSocngO6YRpAXQ
	1NVOJO61+7c4m1PMXy4pgIWFvjJ23qC1QUozQp7iHcIbshiEw+CTIP83MSDq0t1Duq5DRE/TZkg
	hLC6hcDTiYH/t4mVY=
X-Google-Smtp-Source: AGHT+IHekT0JGfFdxaYLnpuijyPTatbI4Dy0bZH56fvbuVTlauw9jEYsNIe8ZzeDpfLNNxQjNydPXQ==
X-Received: by 2002:a05:600c:1d0e:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-47d84b54c31mr171924585e9.23.1768165561015;
        Sun, 11 Jan 2026 13:06:01 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d78fsm115098425e9.9.2026.01.11.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 13:06:00 -0800 (PST)
Date: Sun, 11 Jan 2026 21:05:58 +0000
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] r8169: add support for RTL8127ATF (Fiber
 SFP)
Message-ID: <aWQQti6G-b87xvxh@google.com>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
 <5c390273-458f-4d92-896b-3d85f2998d7d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c390273-458f-4d92-896b-3d85f2998d7d@gmail.com>

On Sat, Jan 10, 2026 at 04:15:32PM +0100, Heiner Kallweit wrote:
> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> DAC). The list of supported modes was provided by Realtek. According to the
> r8127 vendor driver also 1G modules are supported, but this needs some more
> complexity in the driver, and only 10G mode has been tested so far.
> Therefore mainline support will be limited to 10G for now.
> The SFP port signals are hidden in the chip IP and driven by firmware.
> Therefore mainline SFP support can't be used here.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Pulled and tested again, just in case

Tested-by: Fabio Baltieri <fabio.baltieri@gmail.com>

Cheers,
Fabio

