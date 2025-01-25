Return-Path: <netdev+bounces-160926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2598A1C3E2
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 16:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7001888C25
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49F2D05E;
	Sat, 25 Jan 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTLm1zKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76B22612;
	Sat, 25 Jan 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737817446; cv=none; b=H2SebE9P/jf0Iyc16nk4OKt5BLElQ9wsSjkjjx/3SZc91amYumiO6wmHRrbGaGL6GhXXraBTrszhDJ/qVPL2ZkkJY0D77kxW6qlRvyxjE51EECMpNlszTunDonzcQkerMaMVPjkT1GyhTuSpiwf5ZDYzTwZrRqAnYlVSds3brM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737817446; c=relaxed/simple;
	bh=AUZHHQiX/Po84Lb23FG3UCqp+jxDLfGskEQ5UaKHys8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lh+SLEE3v28Q3IIEMMrq2GIN1uTupOJlQT4nMhV2y4Ep/dmIxwNTKuZBbjky0pNOK4RaJFVK/TwQ4G7CNZ9p1WtTRNyLMZsTLHJjZ/iV0nhVH69cKaDW/is4XhPSM7HyNusqSnmTayumJY69GAi7vtFnFULAlgXEAWRQQtFbRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTLm1zKU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21c2f1b610dso69624865ad.0;
        Sat, 25 Jan 2025 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737817444; x=1738422244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKw2SOCMf2JGxTXIqSAP0tOzr6+c+Tge86dZCU0DFh8=;
        b=OTLm1zKUjnLP4ez3YqJKVJUn8EtqKyVd90cEgNzb/8xhnBLZBveW1eictsih1YzNJp
         3G/1n2FR057pJ49/JAEYwRZEXBGhJYODDIIEvfTVaAj36PNxSomGpMZOeClfo/smWefe
         5jKC8lDeKkM5mOMdxHTXYpK6m0jMpAqUgUr/IhSn40bNamBZ4hIIGnLQLXa0BuX/1Alk
         AQpLpGDBIG/HRjeHuL4JkZuDsNNk81cxMPsaLxyRIUGRiZuS/mTYvQIi07p24A3XhRNv
         y/tb/K2Ze8O/hoJ5CqQdwsZq5bvutge5BYPk3PeTuwMvZZMdOO+DFqUlppMhF9erXzwP
         pn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737817444; x=1738422244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKw2SOCMf2JGxTXIqSAP0tOzr6+c+Tge86dZCU0DFh8=;
        b=eXWaGcO+bwIKQHyKleB/iJleZoKHeMpBqtJL4bwdkgmiwe9GM2/x7NXuUoyVtqEX2Y
         rmyvQQbfA+ob7cpQrELnPYpYI1YHLZSo2mxgA4Woc0zO2HfXQTXeRtzA80iveqwlbMAR
         dmVZ9e7vq+ItSQlsQbmimlNCvpBKeTFjM4Lgu0zxEVsOKbIPwQsrPLWMwlceU1GGmFQ9
         SNEK2vE9SPHydhnhwaMA19SoOFSjzxfUGjgc74zoccd81yww1cKX+0AAmfOnw+pIDsY6
         WSsOE7rhaR2kXiMrmkz0QnepAR2aJv3P6y1jVfCuQfWQYSb6JZT3PFlC4JoOw6WdX3S9
         0SlA==
X-Forwarded-Encrypted: i=1; AJvYcCVtH+Xs6QHkUsDAnyEkEIqIcLjJRwKwlo4YD3hZL1R2aFaT/nODGRoMXAK2JlHdDb+gPvcSfKup@vger.kernel.org, AJvYcCX2GN60ftmoRgx1g4GunP53+XwlnMPjVeHFMXrRRk2GOUKvPgzF6V0NOtXEeFk+LxTUbR3iM8eNnDGJJNg=@vger.kernel.org, AJvYcCXJk/3KaxoH6gARJxaYpYf/VQScWbA8k4A93deLQt28hISWljGFZ8Qgn70SjEpLiVAHQH0PeahKkkEida4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRasu2Hg6TN93u23jA+slSkDKZvDtwYLEkg/FOK7c3q+Rtp/g7
	bFIDk6qVt9mCXB9QQzXlrgmHd1TcKK9pgLa0O92b8mk4jAYQ11z2
X-Gm-Gg: ASbGncvuRhPRXenAtQ5T9UEn6siU/2ZC0X/fGkxPFVCvyDNqJniC3jfT72U6UYuHC2Q
	aUNJ9fOmskOth/N47jswQIrlpCS5lipcY+Rj+F429BddEsL8izQRv50Cgxb5IF5kua2CZKg2AD4
	BxGbDUVXira5VvZlhblE4TWxPQtCrt/oBtq70xtWyK5z0hVueFtIorXQlvNsEG3lKfQMmYx/WCq
	uUEDhn0Uvr+MTur2SsFAC1z7QziPjnLQ/AqteDyYGrrK9+KMdDDS/Ga2AWmlYUoQ8weEwdNDoNX
	VQ==
X-Google-Smtp-Source: AGHT+IFVzWzSGBn66Dc2tB9vnmWyHkByC3/61GF44GlshncBb/NN1MnhhqsxwhJuUAHRXdCbEwQ2Dw==
X-Received: by 2002:a05:6a00:92a0:b0:725:df1a:27c with SMTP id d2e1a72fcca58-72dafa4ce00mr48575267b3a.14.1737817444411;
        Sat, 25 Jan 2025 07:04:04 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fde0sm3933161b3a.18.2025.01.25.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 07:04:04 -0800 (PST)
Date: Sat, 25 Jan 2025 23:03:47 +0800
From: Furong Xu <0x1207@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Brad Griffis <bgriffis@nvidia.com>, Jon
 Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <20250125230347.0000187b@gmail.com>
In-Reply-To: <Z5S69kb7Qz_QZqOh@shredder>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	<20250124104256.00007d23@gmail.com>
	<Z5S69kb7Qz_QZqOh@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Thierry

On Sat, 25 Jan 2025 12:20:38 +0200, Ido Schimmel wrote:

> On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
> > On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch>
> > wrote: 
> > > > Just to clarify, the patch that you had us try was not intended
> > > > as an actual fix, correct? It was only for diagnostic purposes,
> > > > i.e. to see if there is some kind of cache coherence issue,
> > > > which seems to be the case?  So perhaps the only fix needed is
> > > > to add dma-coherent to our device tree?    
> > > 
> > > That sounds quite error prone. How many other DT blobs are
> > > missing the property? If the memory should be coherent, i would
> > > expect the driver to allocate coherent memory. Or the driver
> > > needs to handle non-coherent memory and add the necessary
> > > flush/invalidates etc.  
> > 
> > stmmac driver does the necessary cache flush/invalidates to
> > maintain cache lines explicitly.  
> 
> Given the problem happens when the kernel performs syncing, is it
> possible that there is a problem with how the syncing is performed?
> 
> I am not familiar with this driver, but it seems to allocate multiple
> buffers per packet when split header is enabled and these buffers are
> allocated from the same page pool (see stmmac_init_rx_buffers()).
> Despite that, the driver is creating the page pool with a non-zero
> offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
> headroom, which is only present in the head buffer.
> 
> I asked Thierry to test the following patch [1] and initial testing
> seems OK. He also confirmed that "SPH feature enabled" shows up in the
> kernel log.

It is recommended to disable the "SPH feature" by default unless some
certain cases depend on it. Like Ido said, two large buffers being
allocated from the same page pool for each packet, this is a huge waste
of memory, and brings performance drops for most of general cases.

Our downstream driver and two mainline drivers disable SPH by default:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c#n357
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c#n471

