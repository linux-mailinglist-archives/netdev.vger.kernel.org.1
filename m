Return-Path: <netdev+bounces-158593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B85A129D4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8653A0F9E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B0719DF5B;
	Wed, 15 Jan 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WMRWc7am"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2591791F4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962079; cv=none; b=VaHCnqudzAtp54920zNLjcH/RI7VRqwqGZ+w3ucN/KYGKkWC4VflVobTAaFNaFzfbrYJCweb22DGmClOTb4xVQrwOFo3gRFkAksXYX9oN/B2vr8VvGMwdgLlbF2wF6P6jutg5cfL7r88NSZRYYcxMl7NG4aQ+0DnSYt7EkjZbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962079; c=relaxed/simple;
	bh=f/xxnvYf1WfyPjbaimC3LeW5A2HjNMbGHsQX1VteAd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhcvfMkK2WzOmDiRphTcJbZS9PfAbr4+64fbdmoMORcdp+jU7NPDoVdgWBX204ssI3p2YSbJigdTN0Apc6QaPgIoSSKUn59jmNymo09lBG1Fx+0DJd5gVJeY0abW0eg3z23sLGHumO3lyi+yLUBpr00C6nZqg8rIi0xJSgrTS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WMRWc7am; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166651f752so159516455ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736962077; x=1737566877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/tOyA1p7QjHDsifRN5k+/Gb8kyRYOVF0Azt3OIzzyw=;
        b=WMRWc7am3w1CVgd1NdD3Sta5iNOY7Loi4qude8FMJaR5Tv8wvH0GaEgEcLKisNTylV
         c7yKpoIjiL1H63qjUANHmkvCehMeH8ChvgWZ5CicRO5StS+50KunHNqz9GpaAhbkz1ww
         QkhiN5IbawLZlyFaSaXuhtSIuKOuNUgqZc9aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962077; x=1737566877;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/tOyA1p7QjHDsifRN5k+/Gb8kyRYOVF0Azt3OIzzyw=;
        b=mI9HwlQ/b/ss/6/pQbJ2SjHpw+dR5vdstcB8AXBlP0Vnmh47ZMn9JUGSCqDsgm8nrK
         DRJlGr31VNBdRuIDgFK8dkC8wJsiMhVLqPDYQBUm9WcLSUZIE8SifZPIvgQgQGQ5SYRF
         851H/3LL8MceZRs3J1tO6w6A0n9OyUZYZil1CXi1/xmGZJCU1+DfPwVLSqho8mhkUm7i
         fz+I3W74rcNWx0jDBIH+2VqjUb95tRy2ddsP/jFKklg//8Y6ijhm4ZrAHSyvWp9ukpE+
         TWr9BVWJoy4jVWVkC72Dx3m2GbmYpp++Kcq3FR6xzzVIF298SQFoQUFiAl1hTpxVQZj7
         9ilw==
X-Gm-Message-State: AOJu0YxZWsTeh/E1JDD7hoviXrJXHGJDyJ0BYpi7zuxjofvmuVFtNVVY
	nzFBThlQrIw7MbYDQXrLoq0oGuj+FwgJEI+Zi/Op4XQhjngXxaTeztyKdccUimw=
X-Gm-Gg: ASbGncvKSrJrHrTaNGhXxeWNcGfkmPyh8RLoRtqfL2bgeMtS6ntsqidaln1afZ6SIql
	RbMzeIzbh5f/0uRbrIhUX75KjZNf8VE6c64pBb7SHvCyn3BVqA0R5Cy/Y+0jPdPtx9STdcWL5kX
	zKJbrccatSBG/8EVttoFchM9YfXEAaEHIwT/1IhJoVAbxBunCx6GSKIwXZadrIXlitgLST6Xonm
	Dkv4nnA8zUp1JiO90EsQqAGp//9TXdk2i1qEXGmFduhnchWVRfGh6FOdadVeXEBmXfJ/uS+j6wH
	77YfjwJ8eAlxyrHPzLHuYd0=
X-Google-Smtp-Source: AGHT+IGksVKSylJkV0LbwF+RW3gakMaxvSakIRb83Rj9Zk5r6cV3J0tIrcgSWtS1CavXnppBEpmgAQ==
X-Received: by 2002:a05:6a00:1906:b0:72a:bc6a:3a85 with SMTP id d2e1a72fcca58-72d22007a0emr30575531b3a.22.1736962076898;
        Wed, 15 Jan 2025 09:27:56 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405485b7sm9320991b3a.2.2025.01.15.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:27:56 -0800 (PST)
Date: Wed, 15 Jan 2025 09:27:53 -0800
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
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Optimize cache prefetch in
 RX path
Message-ID: <Z4fwGc50mAfrMmYJ@LQ3V64L9R2>
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
References: <cover.1736777576.git.0x1207@gmail.com>
 <668cfa117e41a0f1325593c94f6bb739c3bb38da.1736777576.git.0x1207@gmail.com>
 <Z4bzuToquRAMfvvu@LQ3V64L9R2>
 <20250115103358.00005b57@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115103358.00005b57@gmail.com>

On Wed, Jan 15, 2025 at 10:33:58AM +0800, Furong Xu wrote:
> On Tue, 14 Jan 2025 15:31:05 -0800, Joe Damato <jdamato@fastly.com> wrote:
> 
> > On Mon, Jan 13, 2025 at 10:20:31PM +0800, Furong Xu wrote:
> > > Current code prefetches cache lines for the received frame first, and
> > > then dma_sync_single_for_cpu() against this frame, this is wrong.
> > > Cache prefetch should be triggered after dma_sync_single_for_cpu().
> > > 
> > > This patch brings ~2.8% driver performance improvement in a TCP RX
> > > throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> > > core, 2.84 Gbits/sec increased to 2.92 Gbits/sec.
> > > 
> > > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index ca340fd8c937..b60f2f27140c 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -5500,10 +5500,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> > >  
> > >  		/* Buffer is good. Go on. */
> > >  
> > > -		prefetch(page_address(buf->page) + buf->page_offset);
> > > -		if (buf->sec_page)
> > > -			prefetch(page_address(buf->sec_page));
> > > -
> > >  		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
> > >  		len += buf1_len;
> > >  		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
> > > @@ -5525,6 +5521,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> > >  
> > >  			dma_sync_single_for_cpu(priv->device, buf->addr,
> > >  						buf1_len, dma_dir);
> > > +			prefetch(page_address(buf->page) + buf->page_offset);  
> > 
> > Minor nit: I've seen in other drivers authors using net_prefetch.
> > Probably not worth a re-roll just for something this minor.
> 
> After switch to net_prefetch(), I get another 4.5% throughput improvement :)
> Thanks! This definitely worth a v3 of this series.q

No worries. For what it's worth, it looks like there are a few other
instances in this driver where net_prefetch or net_prefetchw can be
used instead. That might be better as a followup / cleanup and
separate from this series though.

Just thought I'd mention it as you have a way to test the
improvements and I, unfortunately, do not have one of these devices.

