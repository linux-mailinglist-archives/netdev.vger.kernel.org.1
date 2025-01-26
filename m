Return-Path: <netdev+bounces-160960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A897A1C768
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CDE3A624F
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD8524B0;
	Sun, 26 Jan 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeOL3Uk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298425A641;
	Sun, 26 Jan 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737887854; cv=none; b=uSBK0YKHF6J1tuF/gi6GX3/kvl3gzSJ8xmZYTiPRwZYE2OZnZsVDq/ZiHv72V6K3zq5IZKLouf8A7FOM+ALAD01cSoMtmXXWGXHHLkmwIXN8jHJhJxdYBRyNddbzfWL+rARUB4qGA/jojQM0ik7/XAxsIZCDdzcluIHXB9IruI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737887854; c=relaxed/simple;
	bh=wB8DuOZ4vkOHDr31IxzyO1m7nCDdkDjbt7I6NkSOfk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7rnxo62CTJS3i4TuoLia1KJTc76Xb1bEmQSdAe9ZlBLlQGGPg2U9S3XyhOGjAKysTl5IlS6dKeuPI4UwFT6x8u/j6u9XU2DbGv2XEH70FBiD1obWNzhpD+Sq+aHmMZ5L8DjPB79fqUbPNAuE7FOZt+gUE3kADLg30Hhq2Eneb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeOL3Uk5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166f1e589cso90684845ad.3;
        Sun, 26 Jan 2025 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737887852; x=1738492652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ecirtyp08OWG3CnMrgQHnomqjmrMG04Uo5mPDcC4TFM=;
        b=TeOL3Uk5v39220zb+ShHodF68WMbRXuEO+U+om5yREhoSy4aAUqs6wEgZyqdias8l8
         AbxyvHPt7Mo5sXbwa3kRuoch5urhLb/RL1PNGZekQXO2a+NKZzsuxisFyoft0s+ZkTYv
         XHS6OOnInGW5P7Tr8nH5WYdO8xciPziMOAaCNp8S7QCACJ3XvfEfNPRtve9gq28OZK8/
         TGLl0thBWMeaSruIG8zIyJUz6+0iRDKJPKzCfAfoxR4IeN1CuyPIPFyjR0tXKVYvgGym
         pOAVMB8X8UID0FmhXmHa/C22UnQZIKnAs6dmpbmVdngQCW6/k7UPcJJLOTuCuCc0Ip4E
         nrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737887852; x=1738492652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ecirtyp08OWG3CnMrgQHnomqjmrMG04Uo5mPDcC4TFM=;
        b=ib13OcdaTHGOXdi5lp7e7oRlFWZRyJCToZQ/KjcYQx5yNntnAKblZDcWuWPL7beAxg
         ekpZUHhpi+In1wmCdMjNXosU6BgkWoCj+ZXUd3PMEAtggMMdHEBYagTbkbrEToipYGMX
         5LW4ph7mf2lBQhSFcbD33hjcYhK2VRBMdAzPnufJS+WRXOpIPFpm+K6kUs6J7M4z5rZZ
         0VDlnYtIcM3aOD/fmSCKciJzPBxGMRVnXscCkPPYfTRjN60W4lX67btybFY/3p8lJHD6
         p8tylQ/1M3XEV+aGL0hs4QxrVsb80R+PRdUSNer3gt6t5Oj0jl/uBeDa8Qlo8kb1PFnp
         EsKw==
X-Forwarded-Encrypted: i=1; AJvYcCV5V/kcSNQxCAk0NmKDIDMcpn3aTDWHTSfV6shlpeH6tr+2W4BxC4L3cRDhdFVNsUgBGYpGhoJY93VotNw=@vger.kernel.org, AJvYcCX2uucgUrY0i8V/LZDL6tFRNlHPuXv4b3TWOcpOaDSweAsay2+BKGs7UcWmMpc/gmomU7CIjaCm@vger.kernel.org, AJvYcCXATFrr3t49yHI4ntDSAUeCu8TnYUshRnw+l9uFeyNpdGGnIh/XdlN0b+aLcUMiaEZ0feedj6btph8hzGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mlhDIPOzgaXgaSTaoPZPXj7Y45S+T0nw2IfXoO/EG+SwZY2k
	6i0xVZJuSsInHTqIcjdZFLJJfevyiIfte2pIRxB9zUQVLHSYjcC3
X-Gm-Gg: ASbGncv9ZKjFB2tNHjdO8KJ2tjk4gCATiBF20DFzZSoJjFhZKEGjvt6Y8xDnMv6Rfxq
	F7F+w1uMReXziF+tD9Tw+BPd2IISmKrJtCD2N66064jX8mAwX+hKd3FjAu/PZVeWJmpeEkPF7hB
	UlipDQZGZKEF3g2tZ6YmeH5UVDTjJ3MM/+XdTKIJC8/56AFhu5ixpxf6ykZOug4Qm/1W3gJCs8H
	QOWfZbo4LubQo7JAchZofrx7ba7ptzZWy5E/S+vH7uZIEgPbhYEmUg5Xr6+n0msKAprZsKMQcq1
	wA==
X-Google-Smtp-Source: AGHT+IFgaTg1pL07xIfW9KbW3VjCnfQqBoPnEBRDQmsyx+On2i68wqvPnp3VcevKh/0hXbChCB3geg==
X-Received: by 2002:a17:903:32cf:b0:216:5af7:5a8e with SMTP id d9443c01a7336-21c355ec9c0mr536393545ad.26.1737887851920;
        Sun, 26 Jan 2025 02:37:31 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141175sm44375105ad.117.2025.01.26.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 02:37:31 -0800 (PST)
Date: Sun, 26 Jan 2025 18:37:14 +0800
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
Message-ID: <20250126183714.00005068@gmail.com>
In-Reply-To: <Z5X1M0Fs-K6FkSAl@shredder>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	<20250124104256.00007d23@gmail.com>
	<Z5S69kb7Qz_QZqOh@shredder>
	<20250125224342.00006ced@gmail.com>
	<Z5X1M0Fs-K6FkSAl@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jan 2025 10:41:23 +0200, Ido Schimmel wrote:
 
> SPH is the only scenario in which the driver uses multiple buffers per
> packet?

Yes.

Jumbo mode may use multiple buffers per packet too, but they are
high order pages, just like a single page in a page pool when using
a standard MTU.

> >         pp_params.max_len = dma_conf->dma_buf_sz;  
> 
> Are you sure this is correct? Page pool documentation says that "For
> pages recycled on the XDP xmit and skb paths the page pool will use
> the max_len member of struct page_pool_params to decide how much of
> the page needs to be synced (starting at offset)" [1].

Page pool must sync an area of the buffer because both DMA and CPU may
touch this area, other areas are CPU exclusive, so no sync for them
seems better.

> While "no more than dma_conf->dma_buf_sz bytes will be written into a
> page buffer", for the head buffer they will be written starting at a
> non-zero offset unlike buffers used for the data, no?

Correct, they have different offsets.

The "SPH feature" splits header into buf->page (non-zero offset) and
splits payload into buf->sec_page (zero offset).

For buf->page, pp_params.max_len should be the size of L3/L4 header,
and with a offset of NET_SKB_PAD.

For buf->sec_page, pp_params.max_len should be dma_conf->dma_buf_sz,
and with a offset of 0.

This is always true:
sizeof(L3/L4 header) + NET_SKB_PAD < dma_conf->dma_buf_sz + 0

pp_params.max_len = dma_conf->dma_buf_sz;
make things simpler :)

