Return-Path: <netdev+bounces-110070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2992AE16
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9560F28368B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC63A1DB;
	Tue,  9 Jul 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPfEtZMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE614374D1;
	Tue,  9 Jul 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491262; cv=none; b=O+3pZintubGxfSXMRM70NbeBQnLKHsXLwfG/4AiGc7fmZdR1oTijCqHQ/ocmRwzFseXXWu5Ny0Mk9qiQiqE6Z6cUMQGjQam6qdOjqT3TX9wueVm45Wqurt1ANOJGHKupRpLryk1vdhrM9IMgLyi9tKR3unYcUWfJQIBDIu+Dnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491262; c=relaxed/simple;
	bh=FdXTK0THHsvhpjXs9r6YyhUW9uJJx01iIJW/9WrgvwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVOIGyS+UYDBUeB2rjGJ7/Bd4KUL5bDnEkutL5H0QNLAS9G3jEUzwaRrHoRC7oiPhpZXo1xekRgwKXCCDGRrX7l8cPwo2eBR4GAFKaAM0EGAGQhSysqmMMntB7/Wn7jbSK8Mu+nBddBEH0hvQUNnYI3SqDvTvF8d2qkznGqXu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPfEtZMy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so22497835ad.2;
        Mon, 08 Jul 2024 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720491260; x=1721096060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUJk5cdd3SYgBT6mXktVY0iylI5j6aUAHw71DNobdU8=;
        b=GPfEtZMyeneS3RX0u90pcPuT7If+3xB44c8AaFDh3LWpsVKCm2zandhVRnq2Bu1xrN
         DinEHfV2r8DuGm1yG2j8GKnq/KkVtISHnRs/zZW2JK+tPH3l9ZlMgTdBQbAEjLJnKYAw
         BUnb+o+lBNHwuD7fR2F1n0S/90LcuwbISD9QLCZ85QuDxdHj0AEV9+LuK7VYkzhj+gRA
         K+xNjqHI0bYYUM8mC1XvDsxWUC+gz8OyYqOo5sUaAUgYtrBbWsCYXR7h14nSTRLbIr4z
         SbZ68134/BhBFgRTB9ytdGxRZZ+mHrq4djdE5KZ1Fsg3eAjJHySHn8VJmy/1+Ft6UL/O
         8v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720491260; x=1721096060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUJk5cdd3SYgBT6mXktVY0iylI5j6aUAHw71DNobdU8=;
        b=oqfkRbcV50mr5AvUq17yey72oxTAGiFb5dd9mcVHbFLfU224SZMDqCAP8GUsWZho8Y
         kafI5L1wJPVA3IdxVFB2SmG2avqN2q2lOa0uZHFZ521+IiG9vQasRTGrG/+yeKwQPc7j
         kDN07PJNrx2GXoMAqmYEzcevgMEao3xdS8+UPtXL6rUjUzZU+G4kHHu5dYuVIZd2aVGJ
         4KGolcZvTfwOIAHn3B3dH5fMy3frFa6NrJcS7WZg2v+I+266UUE4B4y0xnzxsA5Nsecq
         YM00SXzYO0/TUm5q4swmBqOoGSIjYPqwSYlt8GSCK5vxwBfXQBYNZQUPL4YSru4TPdmB
         ojoA==
X-Forwarded-Encrypted: i=1; AJvYcCVYvp0fHZ0IaOhTG0coRP8Ct7qaeM7gVhxoP0U/DAl0JN20ZFnVQ822m7XMS0wAyPmREO+bpgqbwwAnxCCpherNmYhOjpk0yeRjPzsW0jNzF32bcMVfEp/9FTyE/3sM2tAYEM6I
X-Gm-Message-State: AOJu0YwXdwr3Wq5x2+cl5UQD/2CfYik4gIjM1506jh1Qti8X7OLnIjia
	1DDrLfcei/H2RPiC3qSGEALBv80onJ689ZbjiHHLfC/6RbFAh9Gi
X-Google-Smtp-Source: AGHT+IGifYCUjDlpdABP2FmVQ9Uu47bpzw+e6ONUof7UeA6cbyy75OUBvdWUMp43MfpzKyh1ULJeBQ==
X-Received: by 2002:a17:903:2308:b0:1fb:8c35:6036 with SMTP id d9443c01a7336-1fbb6cda8e5mr9793955ad.5.1720491259723;
        Mon, 08 Jul 2024 19:14:19 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a28f8esm5179775ad.64.2024.07.08.19.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 19:14:19 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:14:07 +0800
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: Refactor Frame Preemption(FPE)
 implementation
Message-ID: <20240709101407.00005199@gmail.com>
In-Reply-To: <7cde7743-2a8c-4d12-aecb-d1e50d5099ea@lunn.ch>
References: <20240708082220.877141-1-0x1207@gmail.com>
	<7cde7743-2a8c-4d12-aecb-d1e50d5099ea@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 20:44:31 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static void fpe_configure(struct stmmac_priv *priv, struct stmmac_fpe_cfg *cfg,
> > +			  u32 num_txq, u32 num_rxq, bool enable)
> > +{
> > +	u32 value;
> > +
> > +	if (enable) {
> > +		cfg->fpe_csr = FPE_CTRL_STS_EFPE;
> > +		if (priv->plat->has_xgmac) {
> > +			value = readl(priv->ioaddr + XGMAC_RXQ_CTRL1);
> > +			value &= ~XGMAC_FPRQ;
> > +			value |= (num_rxq - 1) << XGMAC_FPRQ_SHIFT;
> > +			writel(value, priv->ioaddr + XGMAC_RXQ_CTRL1);
> > +		} else if (priv->plat->has_gmac4) {
> > +			value = readl(priv->ioaddr + GMAC_RXQ_CTRL1);
> > +			value &= ~GMAC_RXQCTRL_FPRQ;
> > +			value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > +			writel(value, priv->ioaddr + GMAC_RXQ_CTRL1);
> > +		}  
> 
> Since you are using a structure of function pointers, it would seem
> more logical to have a fpe_xgmac_configure() and a
> fpe_gmac4_configure(), and then xgmac_fpe_ops and gmac4_fpe_ops.
> 
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -974,8 +974,7 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
> >  	bool *hs_enable = &fpe_cfg->hs_enable;
> >  
> >  	if (is_up && *hs_enable) {
> > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > -					MPACKET_VERIFY);
> > +		stmmac_fpe_send_mpacket(priv, priv, fpe_cfg, MPACKET_VERIFY);  
> 
> passing priv twice looks very odd! It makes me think the API is
> designed wrong. This could be because of the refactoring changes you
> made? Maybe add another patch cleaning this up?

Hi Andrew

Thanks for your comments.
This patch is almost a clone of "net: stmmac: Refactor EST implementation"
https://github.com/torvalds/linux/commit/c3f3b97238f6fd87b9d90b9a995ee5e69f751a74
Many decisions were made based on that patch.

I will submit a new patchset with splited patches and make function callbacks more logical.

