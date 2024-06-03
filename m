Return-Path: <netdev+bounces-100376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8818FA390
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73326B24FA0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A813C693;
	Mon,  3 Jun 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCYQ+nHb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7280603
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450760; cv=none; b=Upv+MuZZOHw542FklszwBTO7X5ZoccTb7Y6x04rpuAzMU+71SinsJ4n5aVNerViUvxjwR5uft1gum+HB/+kcSfNXZwPQ7tyHQuypv/uxugAugWiJnG+6a/fmy1P7jXuiineJtMUHeBwFAzkxC8JpQWAeF98zFrHFcjQa21tcVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450760; c=relaxed/simple;
	bh=pAMuOKHLSKkVmer1pkthrJ1jf8sw7MaNVjVlfzCWgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciUCrRa3sJI5satwT6lBQztln7ysnH9AjCgD5shU/2AuvYfANiEfWx0d32GIZxLPsNy8MEMLuncnAjBm7TDqaOSca469aQml9PwzRfbTOLQWsKuenynmeihtPxAFQLXDpwRHb+NnhTkDSYq7HnCaaQXU8Qmb7Z4SteTStm2LKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCYQ+nHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717450757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rW72wPodY1wqzDmVcaAF9S5heqN9gcWtpGc5h9hRyuM=;
	b=jCYQ+nHb34pJDXqfy0wqCXsg1Jsx+cr7RoOFYm7ZabbbU1MFpsTJaohUuqFckTB0f1UVvv
	QISYM4UYPWgHq081XON0T4BosGD7LVDEtt4Rci5zHiLUWsaD+jjEKErXU6K1aF6xwqm9sF
	PNDUsmPvv72ySgKL1mNla+8EaWlSfvY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-cW_CxkcXMD-y19475kL1xA-1; Mon, 03 Jun 2024 17:39:15 -0400
X-MC-Unique: cW_CxkcXMD-y19475kL1xA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d1c9fcce4bso4337636b6e.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 14:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450755; x=1718055555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW72wPodY1wqzDmVcaAF9S5heqN9gcWtpGc5h9hRyuM=;
        b=ID1+H5QKLaV/RT/FibQpWwgAsv8pbcKKCGxZpN0GKq5ky1tm9zCLtfgSiGAP/pRIKX
         jRxLFdZ0kh+NEMc9qlwgmcU7LFcH3Hz35CgHSzjIvqmkq1oVbYEEsZ6xi1hD2QZO89AM
         0PpCrL5OH7Fd4ceKaLH6nHd+mzkXWmr1Wqh+tS8SWWYbTlA8cm6He0EVkhwkU4fD4q4r
         Df3pxvQ9/33+HiJV/dQGxd/7TqaVUtUVhEV4isVnl8/eFtcJtCNZ5cwXxykwSYJX+6Kt
         jMHoIbHEjyDjU3Rrs6BCZLLYB7/dEPSQBV/hRoxFLJEi8BEDQN4+5r2LMBPVVaRGwOpY
         AC0A==
X-Forwarded-Encrypted: i=1; AJvYcCWIVJe5ZbdAOuq0895IItGsDX2KTOrk0FF/6XmkSZ590OhTnRTdUtHaXD8xFksvKptMQWMf09/zoEByAevTJ93Wr7AygHRV
X-Gm-Message-State: AOJu0YxJ84kQu0T6y1Kyh8gj0KSVKMvQqUMCHG35U154IHkuQ//i0fse
	eDoXeeMKbC2etOToCCpbO+ckXlozCNCbvIVAxCwhFtTx4xIHGFyBccaJzQ2j3+BQutUGKFKE4L+
	+xWstQ1PIChdHfKtoJaY8WqYXZT42oiERtjRmLCOrJL+drCGFaGGP2A==
X-Received: by 2002:a05:6808:1415:b0:3c9:9404:6c99 with SMTP id 5614622812f47-3d1e35b9151mr13207019b6e.42.1717450755004;
        Mon, 03 Jun 2024 14:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0ANFMBW6FTFEVnKixIfi5ytjIlsmW/YQ1Vrkemo+hu+JY0Vxa8xEcTgWh83KSdzdWL3Pt3Q==
X-Received: by 2002:a05:6808:1415:b0:3c9:9404:6c99 with SMTP id 5614622812f47-3d1e35b9151mr13206977b6e.42.1717450753926;
        Mon, 03 Jun 2024 14:39:13 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a74dee1sm33877926d6.56.2024.06.03.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:39:13 -0700 (PDT)
Date: Mon, 3 Jun 2024 16:39:11 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC v2 0/8] net: stmmac: convert stmmac "pcs" to phylink
Message-ID: <tukyfritbypmq3cf2mkasoaqq7lbjf6owaltghosx37df4cg3b@4mpglxfda25a>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>

On Fri, May 31, 2024 at 12:25:47PM GMT, Russell King (Oracle) wrote:
> Hi,
> 
> This is version 2 of the series switching stmmac to use phylink PCS
> instead of going behind phylink's back.
> 
> Changes since version 1:
> - Addition of patches from Serge Semin to allow RGMII to use the
>   "PCS" code even if priv->dma_cap.pcs is not set (including tweaks
>   by me.)
> - Restructuring of the patch set to be a more logical split.
> - Leave the pcs_ctrl_ane methods until we've worked out what to do
>   with the qcom-ethqos driver (this series may still end up breaking
>   it, but at least we will now successfully compile.)
> 
> A reminder that what I want to hear from this patch set are the results
> of testing - and thanks to Serge, the RGMII paths were exercised, but
> I have not had any results for the SGMII side of this.

I took this for a brief spin on the sa8775p-ride eval board from
Qualcomm, as a reminder here's the dts to show the setup:

    https://elixir.bootlin.com/linux/v6.9-rc3/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts#L288

I didn't notice any issues with traffic on either interface (there's two
stmmac device instances, both using SGMII to a marvell 88ea1512 phy).
Did some basic link up / down tests, iperf3, etc.

If there's anything in specific you'd like exercised, please let me
know. I'll try and find time to look over the patches more carefully
tomorrow for review purposes, but I only know what I know from reading
the driver some, so I can't answer any of the open questions with any
official documentation.

Tested-by: Andrew Halaney <ahalaney@redhat.com>

> 
> There are still a bunch of outstanding questions:
> 
> - whether we should be using two separate PCS instances, one for
>   RGMII and another for SGMII. If the PCS hardware is not present,
>   but are using RGMII mode, then we probably don't want to be
>   accessing the registers that would've been there for SGMII.
> - what the three interrupts associated with the PCS code actually
>   mean when they fire.
> - which block's status we're reading in the pcs_get_state() method,
>   and whether we should be reading that for both RGMII and SGMII.
> - whether we need to activate phylink's inband mode in more cases
>   (so that the PCS/MAC status gets read and used for the link.)
> 
> There's probably more questions to be asked... but really the critical
> thing is to shake out any breakage from making this conversion. Bear
> in mind that I have little knowledge of this hardware, so this
> conversion has been done somewhat blind using only what I can observe
> from the current driver.
> 
> Original blurb below.
> 
> As I noted recently in a thread (and was ignored) stmmac sucks. (I
> won't hide my distain for drivers that make my life as phylink
> maintainer more difficult!)
> 
> One of the contract conditions for using phylink is that the driver
> will _not_ mess with the netif carrier. stmmac developers/maintainers
> clearly didn't read that, because stmmac messes with the netif
> carrier, which destroys phylink's guarantee that it'll make certain
> calls in a particular order (e.g. it won't call mac_link_up() twice
> in a row without an intervening mac_link_down().) This is clearly
> stated in the phylink documentation.
> 
> Thus, this patch set attempts to fix this. Why does it mess with the
> netif carrier? It has its own independent PCS implementation that
> completely bypasses phylink _while_ phylink is still being used.
> This is not acceptable. Either the driver uses phylink, or it doesn't
> use phylink. There is no half-way house about this. Therefore, this
> driver needs to either be fixed, or needs to stop using phylink.
> 
> Since I was ignored when I brought this up, I've hacked together the
> following patch set - and it is hacky at the moment. It's also broken
> because of recentl changes involving dwmac-qcom-ethqos.c - but there
> isn't sufficient information in the driver for me to fix this. The
> driver appears to use SGMII at 2500Mbps, which simply does not exist.
> What interface mode (and neg_mode) does phylink pass to pcs_config()
> in each of the speeds that dwmac-qcom-ethqos.c is interested in.
> Without this information, I can't do that conversion. So for the
> purposes of this, I've just ignored dwmac-qcom-ethqos.c (which means
> it will fail to build.)
> 
> The patch splitup is not ideal, but that's not what I'm interested in
> here. What I want to hear is the results of testing - does this switch
> of the RGMII/SGMII "pcs" stuff to a phylink_pcs work for this driver?
> 
> Please don't review the patches, but you are welcome to send fixes to
> them. Once we know that the overall implementation works, then I'll
> look at how best to split the patches. In the mean time, the present
> form is more convenient for making changes and fixing things.
> 
> There is still more improvement that's needed here.
> 
> Thanks.
> 
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  12 +-
>  .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 146 ++++++++++++++-------
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 131 +++++++++++++-----
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  19 ++-
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 111 +---------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  33 ++---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |  58 ++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  34 +----
>  9 files changed, 298 insertions(+), 248 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 


