Return-Path: <netdev+bounces-158295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC2A1156E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAA1659AA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3E20AF6D;
	Tue, 14 Jan 2025 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KnHW8luu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200611D63DE
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897470; cv=none; b=nVX2qra0EpXFjRrkO/hRmSs/tY6KcaPa6kLSpFEPCfEHWxzBXRnXH+uZqQh5wmRR8leqs9/ntUyecno0aLeX6/b6sX+NC7upL5KHCi6F/aF/GfycZhj2GZL4ygRuua0JLqb8ikxOQsfHluZulZ4hvkj4y+z3HyK/lHLtUQ1CAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897470; c=relaxed/simple;
	bh=7njtDU+cbFEo7DWmybdpzgKaGHQxVB9WlDBRFXzaM6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dom86G2svrQEzEH2BzO6FzNh9C2qSoEgS52JSlxqlaqknWBKttjvnXAvqqGn32h+O5QvQvQO0rq+mCJay+F5dObAmVcpOKh+9H4rOZmeoOm3eIT9Ph/1XVTwuUEeoSJ5UQOIpl2mudOQABm1GSJWB3HGCb1WtvA5+dJRpEjxpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KnHW8luu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b1f05caso108371815ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736897468; x=1737502268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB7Gju0RIgr9jLJ+t5Q7M0pre/bo/tmwE6J1WO4l68M=;
        b=KnHW8luu/gtGA037zc4CG/94FiPbPdCgfw/qKl/VmJpJh6Al3GpBSG1vy2xxhGONBg
         gt+L0QA0dmIIe1TUiNZ2ErtCdEu4M3M+KGJEXfrbbLRDDh0DwDVeMBXCQ8he99raATot
         z5ZGArbAywAsJBZ8AZjWrMAmaCtBdPsb+FcHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736897468; x=1737502268;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB7Gju0RIgr9jLJ+t5Q7M0pre/bo/tmwE6J1WO4l68M=;
        b=KIuCdy0sCWhEncT2fzIi+fKVuuBjI+VuwPVLvB+WcvccKdagbH6a/915WaR2rudI3J
         iTlVCRpLUxtFgMrj75b5bt0lbjKVMmNEfUz895FtKbFvuxXSJ/rm2CNRbYkxB1E2QtBD
         VqoCxPAppLJCnoXYjovKBa3KRvh24AsKaHQ9VwLI4TUznhTSJtRyikiACBXr0PXtK/bb
         ARHpSnmn8EYS3zkhUzxUdh+NtOWi0+fBzW9WzP4YT83Kg0RTkd3cJLT/B534oUmz2k7+
         GGnR4rLput+75TahLt9Zw05EzLAPnOc4nAi2RaO3YaoaIgtY1PBVwTvPBDqF0EaLa6aM
         EHZg==
X-Gm-Message-State: AOJu0YwA6KXFggXBd1KJa/U08UZ6wxYeJ2Mz11gJ0rLusgx0lD2T9zkf
	ydBmVHEP0YQ3vXHD1ZHdpLIUfmvrQTf4K9qjceJtiFjueg78ljhAMqgyPY8VAWA=
X-Gm-Gg: ASbGncvHkAqSEgwLtCbQ3jTgp1tdgII9YAZtteM4U3yNCrgegeoMhUGtk8NxGHpZCvy
	DkOIKYn17aOqVmT3GuvUW4+nAxdhCfAUmQWGTLAq59x98L8xij/n/jcGxWaheLxaJJMaES+rr2m
	7u/0V49PhtTJvFAzDtJIHhI5qY+A5v2wHvkhbxrsY/Vwrr2M+ZUG2vd3w/kNgeizJhKKYWWzSue
	JdOeybGTN8FseDaC4/XCDM9ve/rB274WuzsPY6K/EGNrJt/n/o9qB3Cm+Eb7bK4thffT1Wtu0CT
	9E9Htj/BJwgqW+bHkJRNtS4=
X-Google-Smtp-Source: AGHT+IHovqEE/ZGS2FK/ULFvVF1bTBtDYpXgDWtKvoluSSVf7ExMHwXGJ8cq8SZ8vVf7DFdkQBZM8A==
X-Received: by 2002:a05:6a00:4f88:b0:729:a31:892d with SMTP id d2e1a72fcca58-72d21fa5cecmr42495186b3a.8.1736897468403;
        Tue, 14 Jan 2025 15:31:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405943fcsm7955165b3a.78.2025.01.14.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:31:07 -0800 (PST)
Date: Tue, 14 Jan 2025 15:31:05 -0800
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
Message-ID: <Z4bzuToquRAMfvvu@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668cfa117e41a0f1325593c94f6bb739c3bb38da.1736777576.git.0x1207@gmail.com>

On Mon, Jan 13, 2025 at 10:20:31PM +0800, Furong Xu wrote:
> Current code prefetches cache lines for the received frame first, and
> then dma_sync_single_for_cpu() against this frame, this is wrong.
> Cache prefetch should be triggered after dma_sync_single_for_cpu().
> 
> This patch brings ~2.8% driver performance improvement in a TCP RX
> throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> core, 2.84 Gbits/sec increased to 2.92 Gbits/sec.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ca340fd8c937..b60f2f27140c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5500,10 +5500,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		/* Buffer is good. Go on. */
>  
> -		prefetch(page_address(buf->page) + buf->page_offset);
> -		if (buf->sec_page)
> -			prefetch(page_address(buf->sec_page));
> -
>  		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
>  		len += buf1_len;
>  		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
> @@ -5525,6 +5521,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
> +			prefetch(page_address(buf->page) + buf->page_offset);

Minor nit: I've seen in other drivers authors using net_prefetch.
Probably not worth a re-roll just for something this minor.

