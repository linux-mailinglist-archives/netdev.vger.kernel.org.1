Return-Path: <netdev+bounces-149886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C69E7E71
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870042834E4
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468525FB8D;
	Sat,  7 Dec 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUgnodQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8912D758;
	Sat,  7 Dec 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733550755; cv=none; b=qjBWE+1csNPEqlb6bbTWP6QBT78fj2pW52QuhVkQTiCBukCgGdLH9U3YdsFWbDL4unPGBHKwQU9R2EQji5pnaoTTe5wWrYBp+CuTccGGG+A6jrfc7Qd95GzUDxzScahmIqHKKDwuIY41dncBdNk+LNqYt+JIkHFKRUMArtqq7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733550755; c=relaxed/simple;
	bh=t2YjQfD3ZRA6ui1N8vxdn05TPEpVzLwJX1WME5Zlby0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOab5s/361vnRE/x79lTKQU6cm1ZQp59DAbh9uqkvaHu7qA07r0xbXf/AthJcs6xdb3BkZEPuMCMGUOsEDwQeZ2qHQnFgosbie+YxmUQf11P2g6Ov2RfrcheVzouXuFGQjggSaElQ2a61TrXEulE0Oh/JIvD/oKTuuwxOhS1R+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUgnodQG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1827506a12.3;
        Fri, 06 Dec 2024 21:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733550753; x=1734155553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+IwYaynpcQ+9RTCAJedrXXepYT48CIPEoJXkJRmDR8=;
        b=CUgnodQGoguSf07Kgmi5Cik3y2Mn6w0WcHMaZOpsv1qKvfNFXozYM4HWOvtXiIA96k
         Kd3pU+7+4+CeZIjtqrN9wKLgyMizC6vTvdyYulhy/sWw6WDDuTujVNoPmzVd0iGrFQZ4
         nKTeEftUUvMYi+rxTPNqA6KDedRpOazCknktT98jZjozZdeTcrXOmJrd/3x2T2f57AxK
         TalLmLCr/N2xSLaSlc4jDWmaMurG4MU+9gZ/3cr6dkmu69N7eJQHw0Nb8LQDCSuMoGsh
         ZwSARRIPbd5BWL6u7pYAJTi22qqL8S4B5+jV2KnuWzHhdnhE1Y4xHzaJO1Oyes+eGpv+
         IGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733550753; x=1734155553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+IwYaynpcQ+9RTCAJedrXXepYT48CIPEoJXkJRmDR8=;
        b=lW9kg18NygWAKBexQiZKUihGz4dI7jS7o37JcRtweccVPiDQ8Cxj6co/8xFzlrymn0
         2Z0aeHcj4kIV/PTdKA1SNAlA0fP+CoIDJlThBO6apI+82zXqgw7eDU4DeRFioirbwSAy
         oCwwBwbBK+zYiua9uPiSL45RdPD3gJdrptaXb/YpLlHkzQU4qYV6JSv5OfrPloRhfqi1
         AY4DJ1r8cpvR528/VVJvxLzGDm4r/vBXfNDJKrUFtyKNdiDnzFJUDLAYEr2LxxQ+fhAB
         9Pf+qliL17u4CPkTrOKvRFSF3NarsAPkmJY9cgOuGZgylUIT5Fsg4RLa4MbUMfBsWp/l
         l6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXGL3unPxWCesQp3wUb0aQXoC8c7LNXi5frNAJG2tqQYFp3K+cV9+4/eDrNzUFADCB8wO+Ko/Tmei7a+YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywir7RVRZmqH9X0+Bk0Po86WN//Z5V+6VPLhpi3uR5DUweJk7lr
	fxD0qLiA7FTvAhL0hoawfX8+WkmVWkfE21dpiMx2nC7FbmWFvAU6
X-Gm-Gg: ASbGncuTyTl8NdYxRU/VI0EA0c7CL/5IWhKKPhFLHXGylSh551fGXQR/ZVcBGMCVI12
	53jhTtyEVnJS+mV1AAoTOO8HNkQrFaNuDJ+/dh4AUNpp60h1TAopHmpiewW0Vx6oJ87BHyiTRxX
	uf3FYgM9X7L8YUSJ1/s0qQDCz8K5qB4z1pKUno5EHD/aVkyH/WQWL7QK+C/rbR9QBUU67xfKyJQ
	jyRRpdu9g7BsPiGFywcsH01tSRIkaoKiILceqvNfHpkNZM=
X-Google-Smtp-Source: AGHT+IFd+wuygMRSPeO8wa52NvVHAGLuFfQ5jfbHspHxQMyW7jzkp1weeY7rmM4U0gg8Uv3suuUZQA==
X-Received: by 2002:a05:6a21:3e04:b0:1e0:c3bf:7909 with SMTP id adf61e73a8af0-1e187132cf7mr8429490637.41.1733550752776;
        Fri, 06 Dec 2024 21:52:32 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a903a3sm3811288b3a.116.2024.12.06.21.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 21:52:32 -0800 (PST)
Date: Sat, 7 Dec 2024 13:52:17 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, MaximeCoquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Simon Horman <horms@kernel.org>, Hariprasad
 Kelam <hkelam@marvell.com>
Subject: Re: [PATCH net] net: stmmac: fix TSO DMA API usage causing oops
Message-ID: <20241207135217.00000f0f@gmail.com>
In-Reply-To: <E1tJXcx-006N4Z-PC@rmk-PC.armlinux.org.uk>
References: <E1tJXcx-006N4Z-PC@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Dec 2024 12:40:11 +0000, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Commit 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap
> for non-paged SKB data") moved the assignment of tx_skbuff_dma[]'s
> members to be later in stmmac_tso_xmit().
> 
> The buf (dma cookie) and len stored in this structure are passed to
> dma_unmap_single() by stmmac_tx_clean(). The DMA API requires that
> the dma cookie passed to dma_unmap_single() is the same as the value
> returned from dma_map_single(). However, by moving the assignment
> later, this is not the case when priv->dma_cap.addr64 > 32 as "des"
> is offset by proto_hdr_len.
> 
> This causes problems such as:
> 
>   dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> 
> and with DMA_API_DEBUG enabled:
> 
>   DMA-API: dwc-eth-dwmac 2490000.ethernet: device driver tries to +free DMA memory it has not allocated [device address=0x000000ffffcf65c0] [size=66 bytes]
> 
> Fix this by maintaining "des" as the original DMA cookie, and use
> tso_des to pass the offset DMA cookie to stmmac_tso_allocator().
> 
> Full details of the crashes can be found at:
> https://lore.kernel.org/all/d8112193-0386-4e14-b516-37c2d838171a@nvidia.com/
> https://lore.kernel.org/all/klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw/
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Fixes: 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data")

Much appreciated for this fix.

Reviewed-by: Furong Xu <0x1207@gmail.com>


