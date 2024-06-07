Return-Path: <netdev+bounces-101957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B4900BDB
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 20:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD131C214AD
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E113C694;
	Fri,  7 Jun 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM3uyI6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389A481A3;
	Fri,  7 Jun 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784661; cv=none; b=KT2T67AY287my7Xmnk7/mkyb1GSSFoc0TvujsWsiUQzyYT0I5QvLP4UmRF8po7mklHGgDTB3PAPaCM9B8Is1Q3xP7yiLpR4hXxQGjZ0mvB6440pJrN8LPzOxuHWiGD3RN89PLdkglZWCMVB5tafYojpUua69IyeMoSIhW7hI0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784661; c=relaxed/simple;
	bh=jXS45UQrPnM99RQ0JyTFd4KZqPVi2vCjrSX/9pcHsAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrZH92IiqDjCIjXt8p3iLGpjkKEf/U/vT/SsTTR+ow3HIH38VmxnbRj7LzpB/OAHnipABGkACArVe5aNoURFbtHbJgmUbdC9hnf7xhtSW1RBiHQtlfmMRtRM+EPkmg0ki+nPqKTewURVD9dHVYt1KFW0lJJMEESLTJzWbQ+0pyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM3uyI6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7075C2BBFC;
	Fri,  7 Jun 2024 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717784660;
	bh=jXS45UQrPnM99RQ0JyTFd4KZqPVi2vCjrSX/9pcHsAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LM3uyI6HPiy6Y91PHyCpqMy1KohN4r2IHsdimU3+zCMGAaPl39CljmvqtPCB5Vc8O
	 r2E5ewjYXjvTHpcb8J43FE0D1bruxW89Clj6mqGVBvaLhv1luzY5gM9FHVg5fnMrGx
	 +lp6H1dgTd1A23QOXdvC9183UNMCBfFvNZAGgMNYTZbuUFCBupQO8R5k7mw999spRa
	 oRzfv2GWTfHhp+ve6dntKUVFqxXdptQMundG6GDvbBBLQoPFepsKUzXoxWNRd7S4gv
	 ZvzpiKvNzfQYG7ZfJSunbnJ39ZqC6JGl8CKHsSTrM9j9gkUBTcq1olNaCiWLrY0sBT
	 eMaa6Ow2hFuyg==
Date: Fri, 7 Jun 2024 19:24:14 +0100
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] net: ti: icss-iep: Remove spinlock-based
 synchronization
Message-ID: <20240607182414.GH27689@kernel.org>
References: <20240607-iep-v3-0-4824224105bc@siemens.com>
 <20240607-iep-v3-2-4824224105bc@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-iep-v3-2-4824224105bc@siemens.com>

On Fri, Jun 07, 2024 at 02:02:43PM +0100, Diogo Ivo wrote:
> As all sources of concurrency in hardware register access occur in
> non-interrupt context eliminate spinlock-based synchronization and
> rely on the mutex-based synchronization that is already present.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index 3025e9c18970..1d6ccdf2583f 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -110,7 +110,6 @@ struct icss_iep {
>  	struct ptp_clock_info ptp_info;
>  	struct ptp_clock *ptp_clock;
>  	struct mutex ptp_clk_mutex;	/* PHC access serializer */
> -	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
>  	u32 def_inc;
>  	s16 slow_cmp_inc;
>  	u32 slow_cmp_count;
> @@ -199,7 +198,6 @@ static void icss_iep_settime(struct icss_iep *iep, u64 ns)
>  		return;
>  	}
>  
> -	spin_lock_irqsave(&iep->irq_lock, flags);
>  	if (iep->pps_enabled || iep->perout_enabled)
>  		writel(0, iep->base + iep->plat_data->reg_offs[ICSS_IEP_SYNC_CTRL_REG]);
>  
> @@ -210,7 +208,6 @@ static void icss_iep_settime(struct icss_iep *iep, u64 ns)
>  		writel(IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN,
>  		       iep->base + iep->plat_data->reg_offs[ICSS_IEP_SYNC_CTRL_REG]);
>  	}
> -	spin_unlock_irqrestore(&iep->irq_lock, flags);
>  }
>  
>  /**

Hi Diogo,

This is not a full review, but flags is now unused in icss_iep_settime()
and should be removed.  Likewise in icss_iep_perout_enable() and
icss_iep_pps_enable().

Flagged by W=1 builds with gcc-13 and clang-18.

...

-- 
pw-bot: changes-requested

