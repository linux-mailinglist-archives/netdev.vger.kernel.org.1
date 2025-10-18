Return-Path: <netdev+bounces-230638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489EBEC2F0
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D2D1AA59E1
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7C19995E;
	Sat, 18 Oct 2025 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQxJ6I25"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAC7082D
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748180; cv=none; b=nQHb4Bx1vY0lSbJx9w3VMzYWv+iFk2Q+iPIJ0gaXLHPKlwcx86PfVpuq8Lr3eRLKmaoI8bk5FSUplm8NX6pfMbMwgxGkpSWPkbgpcp+93M586Y7Xwa98dhlJdZ1w8kLVi/+ooUNf29dWUU5JRvKVRF6MTMIYkaZQjOl3ftRlffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748180; c=relaxed/simple;
	bh=s243szStB9pBK3RcKWUDI2cHVqPoJDVQfeeUTlKRVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4pze+jFYB1i9I/gKPAc2e9VyiDDFd6FOErFFSA0sR/JPg2EkaNUeaif19GhpQZ3UoDb2xaAD0QFr4RESRaAI/WmJhHwO0KdCcjEtWSVsl1WMzZDiSlQg6Y5ALxM4Fes9jOGxMYLkgM9sZQB/OW2PQMTKk4u/CrMYMp3FLc8PqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQxJ6I25; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-269639879c3so23420975ad.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760748178; x=1761352978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PWNtFrwP/oSzLfkwsnt+/gfiH1RiWv5c2UepBm6CR8=;
        b=WQxJ6I25DGOUh4V+b3IPhLQX6bTDH3fpPiasJd58lEW8xM8Jk34p24qEKeMFoV9h/e
         3pgXqTSUKAWaMX69fAMhIk+g3yGfTAQI1VZCwnjUmXbmWAMnTpTbk9Kb7wNrYEFRCXLa
         6kcobJX25r4NJOEh14MUCpViMUOJd1tWpCEDxHoCoCUhN79swf5ylKWOkEzhkXCNsPfP
         J4lYWoF1v1AnqpDZT0rIqHZRt2ZWcM4L/PLtTTKJyG9pA02dbO6J8sIUXv8XxlRGFHbJ
         R/mZKkE37mLMxx7U99z/D5BQsO11pkUCUMp9plBUD6FHnHGIHfxbe2VXyCRndKwU7/Tx
         3Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748178; x=1761352978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PWNtFrwP/oSzLfkwsnt+/gfiH1RiWv5c2UepBm6CR8=;
        b=YhUyT+qW4hHiLA2wCsMGkSE2Yi63MCraG/fYaO+EG2LyfQhGVAKcjiw4M4SGKdDHFU
         /5Kc7R3Tg2ZC77eEtibvXyLWS4CgIRB5G1Ot3QuLiF6bOqLzYWbCorcq7/mF8zK5qri5
         Kj3a7i0wgXLvM/qEUrGCYbBwnHIs+MlZJXAESR9Iwkmht63YGGxdnpT2C+Qhu4QAUuRO
         OQ/o49YmZjdFr6OSMV/NvOsYJCUqCwoN8t9xFkY6blwfT7aw5jORIomWrufLJWNOSz8N
         jTKHq5pDsKWtD8RbEBBgdBjVHwsYwlO7jOfnO0KsNIegF7DhYqwYb2dLMbzWuXq6icnx
         ZXGA==
X-Forwarded-Encrypted: i=1; AJvYcCXn5gDbafOX6WXIWEvlJeEb58iuncQzBr465sFK85tOHzH/AsMwBUcZ6IDdyCB/xLtvRj1A0CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBA5Kd8yPA3s9cO6uxoP0zH0D3dWhl/2Bsrc5Xefm+3AoarguT
	2KRkJ9jIFdPRoVgR0LJfQAmU5azMy4Iu6VWLHpqJa20acEgCA7fGP4Pc
X-Gm-Gg: ASbGncs3dXNsAeZztv0thklUahIgffPvh3l9eeWv8foSLLUB0lww7ueRFpt2gt8PMLL
	eAGsif7MoTBb7aWPQMqvrEnjaiFlIFQ2aH4F8+yXjaRCo5CcXTjiJmIhi2kwMaVKqns5GLzyGpW
	2PtxzAWk+ZRVjXS78RTIp5hs7d5OOX+wevls7CUoA05JLANJzReiiUZPLpxyK69QZOe27lUydip
	c47Ko6iZejW44BPjBkGPymycGC43q3onSZze0oS19ab9qMYOet3/r/yw6HhwLAevZCpCUsxU9et
	4uAv5g8dd3oUYseUH86dwUAKMhT6e8lp/UOCR6MVaNGRGuMSIbXjcxDOA+OW9jhx2eaehTvh4AI
	hwHv20yRDJS6bQyyUG3npEFGFOK+LCc8pwzaO4g8FJ3Uc5ijMf5pDbSUnCf2ccnLOmm2O/oMUFm
	A=
X-Google-Smtp-Source: AGHT+IHk6GRhreHj//S6E+ILpNLEY2kapbyNg9O/WZnXJ0JV/NPB8zjD9Ghulw354rOmUlzfDrJAcA==
X-Received: by 2002:a17:903:1746:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290caf85146mr63860745ad.30.1760748177829;
        Fri, 17 Oct 2025 17:42:57 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm7975275ad.54.2025.10.17.17.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 17:42:57 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:42:07 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, netdev@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>

On Fri, Oct 17, 2025 at 08:16:17PM +0200, Andrew Lunn wrote:
> On Fri, Oct 17, 2025 at 09:18:01AM +0800, Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be remove
> > when init the mac, otherwise the phy will be misconfigurated.
> 
> Are there any in tree DT blobs using invalid phy-modes? In theory,
> they should not work, but sometimes there is other magic going on. I
> just want to make sure this is not going to cause a regression.
> 

I see no SG2042 board using invalid phy-modes. Only rgmii-id is used,
which is vaild.

> Also, does the DT binding document list the valid phy-modes?
> 

It does not list. Is it better for me to add a list for it?

Regards,
Inochi

