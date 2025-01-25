Return-Path: <netdev+bounces-160925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C86A1C3CD
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 15:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AAA7A1821
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571626ACC;
	Sat, 25 Jan 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lASgsfJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BB182B4;
	Sat, 25 Jan 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816245; cv=none; b=Si7CT0C/c13KuMc3Io7192U++H4LJcudPN7qxUzJ0tmmpyJnILDpuMrZZBh/UYeaWUsQG2xU9WS9SPrUEW2zP9HsW0E3p0bJ2g+7oXpK3HTc9OrVjUiRdIWbZUdGGVOz4keXEjMcpz4TFKsaIWumPwQf1ZA0SwwOZzWAIPMGR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816245; c=relaxed/simple;
	bh=+58+5hxKBn4yoH5m5yJqyQM4CwShpiBHnutilbAW9tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8oPPkZBrPfhhZpQOFI/v56wDJPn/Ov4k8XTUBC6wydOI23jNxKWkPeHwgnclbsXTdhrmNLcEv8RTQkBEDCzloCkmI/yglNJB9IbJHA+70iKCpIWNu5LAXK/OasiZa8Zcsv9Vl+l2As0FKEkUyVvJhXWd7Zx8IPChKBVxdedz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lASgsfJV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so43273615ad.2;
        Sat, 25 Jan 2025 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737816243; x=1738421043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgdWUzewQLGutGWm0yU3b4mLrNsMLQvksBxEqgoq+88=;
        b=lASgsfJVAHJEsBHVdP0te1x55n4mvOqA4XaUZzSSSXuwxxz4T2FZPSo90JAEVuIYlA
         fqjhssA0Ak2NqVNQXR6ep5J5LJbKlpyzAGOIJASGCRRQEjmUtJ7sa0DgR8RIlkTmuHg7
         3rzMmEVZvRYoQj91UXkaGR6XxYwJX+vr6mZLJJDwP+6HpgpzyCOHOSEXy1t5IaLvD3rk
         K9dvxlBb15apvzXYgH9MJNnvyUq8TAP7ZZtFnRqCQdIvoAHuEBLGFkZcpJY8omBVwGDw
         OSmbCcUoNV/UBwbQ8nNhITDk/cC32UUpXn+b1gXodKMhv9HP+GPJNmEF8xuCFAzEVjc9
         7tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737816243; x=1738421043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgdWUzewQLGutGWm0yU3b4mLrNsMLQvksBxEqgoq+88=;
        b=sRFauiiO7tRAmoXUyA5w6SpGAZgQeL817V8GzPQaSgMppFUOVT3Q6uYhwAWh/zVO+O
         exls54jhJq0IFykowR2sqWE5XBr1mMUqYAmKGXRS8iupjakyg2kaJW6D0U5b9qeoOuXu
         3JVNZOO3KyIHvu0f8Ha2hSFeqfaj4qitrwtpF3iN37cB+ugp2XZf+dE1HaHsS0R5DTj2
         wLtfqYAw/chvcI8Odz+nYF6sykrO+1qw6KHDBqDaTDMkBKtPV0Kym1L30E94vrPrW+lO
         pPJExkUwenHJCQavCpcaWPBMQZi5fqxmRL0UzM31lL4v3uaTYAiJhS6q1KsXnlezb0J3
         XW7A==
X-Forwarded-Encrypted: i=1; AJvYcCUn+GUqkT+xiv4XNvkw9/jqIsjpjmFsvHLsspKrsXB6Wq/M5dgiCPzyktZXTR37bgCq3ocQJWB5@vger.kernel.org, AJvYcCV0cKjlh86qMZ/GFxbZKcaYrx2kjJfp+mecblIZWgXH1ymgQeLyn7X7xiabvDSMRivqqkwetaH6HiTESE8=@vger.kernel.org, AJvYcCWrEqhrSK8lJPwqtz7cJQbBFGLlsdj9a82gyLCLopvwsYniWL3FvwwRYKEReHwRTJP0CyCWNHZR/ClXL2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQs1+QuUnmabqaejw2tI7GgXCzaqGn1KEuyrGwQ4JeBUcJdrKA
	EQJBk4ozsOB/95cJHbpdl7k4ZDIIhb73HrVUhNoNKZ/ch20bEwRD
X-Gm-Gg: ASbGncv3SSYkvgvVxMoktDKLTxyM2LJjqA0Q2NMlTivyhYBTTEuwhmF/b+qrCo6af3Z
	4TTEM3uxeYklyPtYJ1QbfH8BL6wV8wU1Kmej/e3jHM1HQWot9akgf06XDog3rUB5AAiUbBa6+J2
	LgaURa9+ekaIpxJmnGaD6Rse4bkR8293HU90e6JnKVWyOXnsgyh5pd5qgt1RTLfI2Thef650T3P
	lUNiW2LYxeFio/pbj9wpvy5GrvEPyAxTg0LiAYQyWJHiSY0RC+sp1OMiZGdn/3rA7pbxhoVm/Nn
	VQ==
X-Google-Smtp-Source: AGHT+IHA+4rV48inAhpZB8n1PkLhWTEJWQ25mbCFZqNsfRh6vVjT5iQKXj9RhiGTNIQSvXLlnOGvHQ==
X-Received: by 2002:a17:902:c943:b0:215:5bd8:9f92 with SMTP id d9443c01a7336-21c351d328amr566604515ad.5.1737816242783;
        Sat, 25 Jan 2025 06:44:02 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea332esm33441735ad.87.2025.01.25.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 06:44:02 -0800 (PST)
Date: Sat, 25 Jan 2025 22:43:42 +0800
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
Message-ID: <20250125224342.00006ced@gmail.com>
In-Reply-To: <Z5S69kb7Qz_QZqOh@shredder>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	<20250124104256.00007d23@gmail.com>
	<Z5S69kb7Qz_QZqOh@shredder>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ido

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
> BTW, the commit that added split header support (67afd6d1cfdf0) says
> that it "reduces CPU usage because without the feature all the entire
> packet is memcpy'ed, while that with the feature only the header is".
> This is no longer correct after your patch, so is there still value in
> the split header feature? With two large buffers being allocated from

Thanks for these great insights!

Yes, when "SPH feature enabled", it is not correct after my patch,
pp_params.offset should be updated to match the offset of split payload.

But I would like to let pp_params.max_len remains to
dma_conf->dma_buf_sz since the sizes of both header and payload are
limited to dma_conf->dma_buf_sz by DMA engine, no more than
dma_conf->dma_buf_sz bytes will be written into a page buffer.
So my patch would be like [2]:

BTW, the split header feature will be very useful on some certain
cases, stmmac driver should support this feature always.

[2]
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index edbf8994455d..def0d893efbb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2091,7 +2091,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
        pp_params.nid = dev_to_node(priv->device);
        pp_params.dev = priv->device;
        pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
-       pp_params.offset = stmmac_rx_offset(priv);
+       pp_params.offset = priv->sph ? 0 : stmmac_rx_offset(priv);
        pp_params.max_len = dma_conf->dma_buf_sz;

        rx_q->page_pool = page_pool_create(&pp_params);

