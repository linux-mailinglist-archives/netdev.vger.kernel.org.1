Return-Path: <netdev+bounces-160981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2060A1C7C6
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 13:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE13A7072
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1723746BF;
	Sun, 26 Jan 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRy+5J0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3345383;
	Sun, 26 Jan 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896206; cv=none; b=pL0iAgTEc8m+qBHa/PBpwVHK0bRn4htVmbZyhHHP1Lulq0Gx6+bSYB3TwftSpV0Sk10HF0IcfFyIuwGVVJtIBMcLfQN3B+Z4RqRhAPi+tgwndY8bWUjtWG8cMMSH014BsyfgTqqpuboWnYLCsGHZyK5S8//AwxV/LJlJ7myJs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896206; c=relaxed/simple;
	bh=Uf3DfaHFP2+89fbQq7IL1XG33t/w8iPDEXkGa3CzpWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvyS0s9ujv5BXju3P7lxCJOH+wafRnf8BvL+EtdiYNxbUrWkPLx5sQiy9aAoifkdYaq3N2t3C5z4XpRPV9Tkg+snHJ/OyZt5onOMLRjSl9Klz/c1J1/JoFJ6An5GL02OWasqb/1elh032ASUXjBcuAbA7jK8qiS+1x/LzsJtAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRy+5J0n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21636268e43so76907445ad.2;
        Sun, 26 Jan 2025 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737896204; x=1738501004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KGHfLuP3yfCvrd6niU02daJ3MN3GQPttYCq64ynsaU=;
        b=XRy+5J0n3gaRtNCMu/kiCtbVSEfgQVTI2M0wBxmGwTcEwxXssnvJ6syzR1+H1SX+dj
         RbofLQcQseEpGpTjlUZrddwR7HAzHBReFavpgBVEmVbH/Qek+oehuQeOnZRnTHtwkX+e
         w3cT6qWtnHmY7x9CW0zhfgfAnsrY9ubu02qnqUMO/q+0eG1Gr0WsDMmFpJEUpcyqJ3Y7
         cFPC34cvc40774ygsVQVR2WJrQTOlhyQsJDSIwiC/MUz5VBVbVg6GOdbXHsNf3y7R6Ia
         e2vBemJy6PmGlZOgPjlmqwz+2mldDKD3aBrXSdHFx6NMlwv1gDJUN2cUcDXiwKbCZ5OH
         2jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737896204; x=1738501004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KGHfLuP3yfCvrd6niU02daJ3MN3GQPttYCq64ynsaU=;
        b=cpKw24nMuOUo74RbmXFXDeiZVAdYz39LXggyHBACq1YsDgRG8C5jke5ERU90xtguy4
         I8u20xZVtYZuAzeQdvvHILF0dfiVFSDkIkeMgsWEjE4NjpB2dtyi3EJq3bx+/DaTeCWx
         RMChQnj0oWBU/FVwyxUubNn7QOf6xx5vlAhRcS5CH1RHFPGOp75LcK5sUUFUR0HD/pDu
         s8Dobw5sO1RmO87FdozgaR4CJFQAiZKLUlxvMNxBQ3OvYl5Y3R9mxzVTd9jPJvuyCPRP
         s82it6MPaP1Mddqyal5kWksgmsN2GwrCWiQJu28o2jn7KvCI+acppEXYepJle/PipzmP
         IlHw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGHgSvxsnOlfZH1SWidQ30e2wLOARKPftzn3VVmVujgOvXEagQfsFIdhQyf/bnLsPTAEiwby+C6e0wyI=@vger.kernel.org, AJvYcCWtXQpxOyNTiUn4nNjT+R7hQyiCVgSQXaG+S/MRVjMGnJzxBGF59I0LuIsFsryXjITWDIm1IqOy@vger.kernel.org, AJvYcCXqcglR9bB7OoZxwD1XyZsWxOZIg41KIGpohNB7MbkJc7dr7Zwi/WFazJX+0SLrhBZebjsIpTftB4nfoJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiD37Ipsdn7CEeDiwUT6GNgBRKwxDEXV9nkSQV0EZ0KeeaKBK
	b2h8HLYbJ/2iDDudmsrO7RX/MS/3iR+7xJDhP68/huqwxnpgmrcr
X-Gm-Gg: ASbGnctLboB4z9XVpAsGF25gUe+JHiHNFTjrLJJcIopDehGYS/3igNSFDhvCDxan0Bw
	8cMMo3psq8LsEwwUOORBNApr/K+Juqrt7rhAcrVHzKGBgNdbsLS/cfE37XMz+AfHP+OssX6NnyR
	qOYbZs+6/WIuabhgjxnLZ81MrfpmynE6s4Za6go0pdn+zeB3hztil7cG4P92kaHpvT2zIOpTrur
	lm91cf0juBBzSWGoTac+yED1R3fi9OJ0AS/g21myqLJz88ny5E7XZl7hgRKe6dgmqb4eTN1SckT
	WA==
X-Google-Smtp-Source: AGHT+IGYKczzJcB4xAPfGWm8estAlez/srV9f9KVlzRCuc8f9pkMAG6+IqGmDY3HU1400WQhVY/Cuw==
X-Received: by 2002:a05:6a00:330b:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-72dafba2625mr53847801b3a.20.1737896203562;
        Sun, 26 Jan 2025 04:56:43 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c7casm5263334b3a.139.2025.01.26.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 04:56:43 -0800 (PST)
Date: Sun, 26 Jan 2025 20:56:25 +0800
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
Message-ID: <20250126205625.00006d64@gmail.com>
In-Reply-To: <Z5YeEVrI3zx4VOtF@shredder>
References: <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	<20250124104256.00007d23@gmail.com>
	<Z5S69kb7Qz_QZqOh@shredder>
	<20250125224342.00006ced@gmail.com>
	<Z5X1M0Fs-K6FkSAl@shredder>
	<20250126183714.00005068@gmail.com>
	<Z5YeEVrI3zx4VOtF@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jan 2025 13:35:45 +0200, Ido Schimmel wrote:

> On Sun, Jan 26, 2025 at 06:37:14PM +0800, Furong Xu wrote:
> > The "SPH feature" splits header into buf->page (non-zero offset) and
> > splits payload into buf->sec_page (zero offset).
> > 
> > For buf->page, pp_params.max_len should be the size of L3/L4 header,
> > and with a offset of NET_SKB_PAD.
> > 
> > For buf->sec_page, pp_params.max_len should be dma_conf->dma_buf_sz,
> > and with a offset of 0.
> > 
> > This is always true:
> > sizeof(L3/L4 header) + NET_SKB_PAD < dma_conf->dma_buf_sz + 0  
> 
> Thanks, understood, but are there situations where the device is
> unable to split a packet? For example, a large L2 packet. I am trying
> to understand if there are situations where the device will write
> more than "dma_conf->dma_buf_sz - NET_SKB_PAD" to the head buffer.

Nice catch!
When receiving a large L2/non-IP packet, more than "dma_conf->dma_buf_sz
- NET_SKB_PAD" will be written.

So we should:
pp_params.max_len = dma_conf->dma_buf_sz + stmmac_rx_offset(priv);

Thanks a lot, Ido
Have a nice weekend :)

