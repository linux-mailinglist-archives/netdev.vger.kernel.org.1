Return-Path: <netdev+bounces-136692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D60CA9A2A83
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59FAB2D06C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF051E0E1D;
	Thu, 17 Oct 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBkQWzUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3B1E0E00;
	Thu, 17 Oct 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184819; cv=none; b=kU8Hc+QVRzo4iOXZ4FAVnclCJ/OAsxvvkYQ50rXvcWdAfauniGVKRj1XPmfKn09YsTnfAUlxu4ETL1cjSjfZ3jqDAl19yZZBRnGrpTaDvb4NQgHp9+WJqJGasHeHeKQW4MIfhrsPaDI4mgQmSymMzQ64oVBvu2sYrAc36OLJFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184819; c=relaxed/simple;
	bh=s1yMFdVWLOIeiGpPCAR+fqUiMZrwgvFX7vlWTh6Jmr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBWnRqbsLM3wK9XYkKssOHuY42YYsufY1Q1pQZonQj3SfOGzZ5K70spSt8RIma4dGtxbOEFwrkgjYWPjTxnsn4mE0RE6KZuBUvBSOpYj/IfC7ybZdmg98mGzi1unavWc+3nBO1GiNoAxdnSjp8XChW3XZqHJbwvE0WwQlBIVV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBkQWzUE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d6716e200so154772f8f.3;
        Thu, 17 Oct 2024 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729184816; x=1729789616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BklMX6kfbrOCfwq57rgPw+skZZbUrE/VXthIxbMG8vM=;
        b=TBkQWzUE4gytEUyDVd34X8cyw8pu5iOIuNtWO82lkXYS6K+TEvrPCDlUJ2+8YFlSbG
         4HMg9sUy3GORRfWwGEdJVTBGHjg/AnFcTmrk517AzCSIP6Degn/M6Ing0fVw+KBhsoVy
         QdjTstTexByT8l02FkoVmxfPkir7/6GT8f8SCSY4wMNZeNAPcapdduTS+WtHj17yEMzv
         v91XNoXzL0KxnX0yPWzSWNRd6Xiv5LILM0oSnCUBsvwE01uQ7DvCGBJ9AUvibc0emUCP
         aJgUxsJ+DGQ9ZtIf7jYTyX2koVY4rwSI/BUeI5gZA3ut2pVff3gQA2lo0OETUI5dE66m
         1Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184816; x=1729789616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BklMX6kfbrOCfwq57rgPw+skZZbUrE/VXthIxbMG8vM=;
        b=rI25DU1tOPmXbR6lW3R580ET9zhgTozqILvkG8/I3E5Pvov4+FajB20A+xF3aPi+Kh
         ivPdgm5a/ZNDcHldYTSvM6FMlUAfFSoDBQP4bPXq7zF3pLKpvo6a8w3qFiysqTgBwNeZ
         OgFkw6hCmX6ikzMjgYsFJDyZ0hpM+6FJJGJcZkdB8sMtHTmT/f8lhDhfA6uX61LnXjDZ
         xGmtn7WWOXQLvdUi1uhLcVhHzpNx8Q6jf18JQA9rDz4RzfB/bM4DmBRb9Udj5/UGg3Mo
         3ybsC2jtR706EwD55LHetXHAH0iLkMZegPH29N01SJVp5PYHA6InQIHuBODrqggh6pIK
         dEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtLCwIibXNDIpINor6q1L6nxn2oAMeMrzGTGhrS0n8nhacfd+CrIjJwKvk8D3PIBepgpvtdNc247LShJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgG7WsTI6+ofdV1X9OKDxUh3dLZSqEyxgxMiR6gkgZglouYsF
	eqthSiq/kJwtUNF7HSOZZHyQNc8U8dgXH/acCNCKmAZAVI4Ok+ob
X-Google-Smtp-Source: AGHT+IHzJDME5SIjxnynJhIsVC0xEhR+BB69pSxP+FYEqGEafYCH6L/9yl4C79ZfCTY8848O73S+qg==
X-Received: by 2002:a05:600c:3546:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-4315080685amr24541995e9.9.1729184815932;
        Thu, 17 Oct 2024 10:06:55 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316067dc70sm1376025e9.10.2024.10.17.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:06:55 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:06:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>, Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: Refactor FPE as a separate
 module
Message-ID: <20241017170652.jtg2abm532sp4uah@skbuf>
References: <cover.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:21PM +0800, Furong Xu wrote:
> Refactor FPE implementation by moving common code for DWMAC4 and
> DWXGMAC into a separate FPE module.
> 
> FPE implementation for DWMAC4 and DWXGMAC differs only for:
> 1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
> 2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
> 
> Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a
> 
> Furong Xu (5):
>   net: stmmac: Introduce separate files for FPE implementation
>   net: stmmac: Introduce stmmac_fpe_ops for gmac4 and xgmac
>   net: stmmac: Rework marco definitions for gmac4 and xgmac
>   net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
>   net: stmmac: xgmac: Complete FPE support
> 
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  12 -
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 150 ------
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  26 --
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   7 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  28 --
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  54 ++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  10 -
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 442 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  38 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 149 +-----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   4 +-
>  15 files changed, 527 insertions(+), 405 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> 
> -- 
> 2.34.1
> 

Sergey Syomin is the one who originally requested the splitting of FPE
into a separate module.
https://lore.kernel.org/netdev/max7qd6eafatuse22ymmbfhumrctvf2lenwzhn6sxsm5ugebh6@udblqrtlblbf/

I guess you could CC him on next patch revisions, maybe he can take a
look and see if it is what he had in mind. I don't care so much about
internal stmmac organization stuff.

