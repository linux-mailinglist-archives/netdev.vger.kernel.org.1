Return-Path: <netdev+bounces-102572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC922903BD5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 14:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EE61F216DC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99617B437;
	Tue, 11 Jun 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVIpAUku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1317623D
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108721; cv=none; b=Szq/3z2oTY5Cr4fcse8huoXxh401F0s9TmKJxcGLH5FvuJjG1HisNh2LvN3rOnu77gaqMPpt+vS9ARBtQ/11tclFbN/MGkLVXrfZ0gGHhAFJ4NF6TEHpgSC0u56CHRsJ9++WoZoahcYa3xuNW5qrYgefuBtlLllKHS+6UglNRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108721; c=relaxed/simple;
	bh=dR3QiWHukei7B7Bq+z2kILcJQxthV6ffOwEiLyg8WLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYIdkDCdU+Mfkv7CxiVnF5YUR1tWsc/8lHvv7Z8duibGhclRzMH5s76E4Pxyq2GlCm6cJvPlFQaR0bo8sGMmAQnhGnzUDmu83COljFX/vHfX68RRcrUydkzcxYC7tOuCV1+qnO1EPx5ANtxGU7wRLk//aCLxR20cGy70IVeOARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVIpAUku; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso4292934e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718108718; x=1718713518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ouUDY8YSEz1j3+98PcGq5EBB+OR8gX6mhTmbMAzRrc=;
        b=BVIpAUkuVfppjFbiYn0m6x9A+bz/aTK/3YYY85yrlitHkBjfeKWlRJKTSmvMLudiHu
         FONycrD48Nem0R8KitSZFIoPXE6kZVr0nQq5iVD0OP6rsodENK+xFZkonkS7qm9DRx7s
         NaDCU9JW9vSm7lM9H/XPrfFSFW8D3X+REtUQlVytXZoHjxqR+Muq1Ca0YmgpWlJyvNOu
         Vp8ucFU+gtcdMX/yxK2Tx0GINegZmOPLGs4uoFuRZYfWeB/HMvdwPj94JTzry+T0qTEy
         OuJEjont0qd0CW36Fa4CHnulSb4dJ2XD6Kp6IEmnU5gkYbv0aKHdbv94OVCFRMQLYwV0
         D3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718108718; x=1718713518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ouUDY8YSEz1j3+98PcGq5EBB+OR8gX6mhTmbMAzRrc=;
        b=m6epc70Bwng3MmI4ii40v40IDcBvEgsCgEYMV4V1UNj65qX2kpUR4vzlIbFcKLFXy9
         B5UnWxmmBg1Wqv4eDwObzakqJI0pjm1gY772XFB18iPrmeD9qGnO7V0+PdKpfhatgg4I
         fNfDL1iU1DBNhQgAHQWQJudFG+LKZa64oQqzUZ/aWhHgtcNmoQqOm6apepkTqjNvJsV6
         Ske6xq9noo3TDclSx5SWeMJ/e05QK+ScHqfAfv1a0SfyNyq9O2P00TcyYrKvu2ZtQ7Zm
         obHPpeXdiRF6aIQzx/w/6Ysf3mIi7fpBFLp0lM0PEjolixBlILgESmLFaS3rCLqjpVcr
         zOlA==
X-Forwarded-Encrypted: i=1; AJvYcCWd9EBiShS5Dhvlqdg4hqoMKLhXb1c1/yyilreOo5SIVDIsOKJ94/T7NZ04uturYd5wYWZVDbvsabUdSQTn6YWXNjg9x94G
X-Gm-Message-State: AOJu0YyV7Jea6T3KZU1LL9w4FXawxZpyqqPUSyO4xAjxE1QCm0IpOpwS
	w1hyJXfvMtZBGFKloQ08toPeHK7tyuD8G8H5VF/iKMy2MM4DqSP9
X-Google-Smtp-Source: AGHT+IHUeXd4dGJsML6XnF4lPZt0zfn3VqlZQB2A0tzQ+ohLCNYXePxOv2iTbHbu+AlL2/Jv1CHLoQ==
X-Received: by 2002:a05:6512:28a:b0:52c:7a2d:5d5d with SMTP id 2adb3069b0e04-52c7a2d5f56mr5474366e87.3.1718108717840;
        Tue, 11 Jun 2024 05:25:17 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c82c37a25sm1380037e87.149.2024.06.11.05.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:25:17 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:25:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Halaney <ahalaney@redhat.com>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>

Hi Russell, Andrew

On Mon, Jun 10, 2024 at 10:19:39AM +0100, Russell King (Oracle) wrote:
> On Wed, Jun 05, 2024 at 03:05:43PM -0500, Andrew Halaney wrote:
> > On Fri, May 31, 2024 at 12:26:25PM GMT, Russell King (Oracle) wrote:
> > > @@ -335,8 +303,12 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
> > >  

> > >  	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
> > >  
> > > -	if (intr_status & PCS_RGSMIIIS_IRQ)
> > > -		dwmac1000_rgsmii(ioaddr, x);
> > > +	if (intr_status & PCS_RGSMIIIS_IRQ) {
> > > +		/* TODO Dummy-read to clear the IRQ status */
> > > +		readl(ioaddr + GMAC_RGSMIIIS);
> > 
> > This seems to me that you're doing the TODO here? Maybe I'm
> > misunderstanding... maybe not :)
> 
> Please trim your replies.
> 
> These two lines come from Serge - please ask him why it's marked as a
> TODO. I assume he has a reason. Thanks.

The statement below the "TODO..." comment was supposed to be a
quick-fix of the interrupts flood happening due to the uncleared
RGSMIIIS IRQ flag. Of course dummy-reading in the IRQ handler with no
action required to handle the IRQ wouldn't be the best solution
(despite of having the phylink_pcs_change() called), especially seeing there
is the dwmac_pcs_isr() method, which name implies the PCS IRQ
handling. At least we could have incremented the
stmmac_extra_stats::irq_rgmii_n counter in there. So what I meant TODO here was
to move the RGSMIIIS IRQ handling in dwmac_pcs_isr().

I know that the dwmac_pcs_isr() method has been created around the
cross-IP-cores PCS implementation, but as I mentioned several times
the tx_config_reg[15:0] part of the
GMAC_RGSMIIIS/MAC_PHYIF_Control_Status registers is the same on both
DW GMAC and DW QoS Eth:
tx_config_reg[0]:   LNKMOD
tx_config_reg[1:2]: LNKSPEED
tx_config_reg[3]:   LNKSTS
tx_config_reg[4]:   JABTO (Jabber Timeout, specific to SMII)
tx_config_reg[5]:   FALSCARDET (False Carrier Detected, specific to SMII)

Should we have a DW IP-core-specific getter like
stmmac_ops::pcs_get_config_reg() which would return the
tx_config_reg[15:0] field then we could have cleared the IRQ by just
calling it, we could have had the fields generically
parsed in the dwmac_pcs_isr() handler and in the
phylink_pcs_ops::pcs_get_state(). Thus the entire struct
phylink_pcs_ops definition could be moved to the stmmac_pcs.c module
simplifying the DW GMAC and DW QoS Eth hardware-dependent code.

In this regard there is another change which would be required (and
frankly would make the code simpler). Instead of passing the
CSRs-base address to the
dwmac_pcs_isr()/dwmac_pcs_config()/dwmac_pcs_get_state() methods, we
could pre-define the PCS registers base address as it's done for the
PTP/MMC/EST implementation in the driver. Here is the brief change
description:
1. add stmmac_regs_off::pcs_off field (hwif.h)
2. add stmmac_priv::pcsaddr field (stmmac.h)
3. initialize the stmmac_regs_off::pcs_off field for the DW GMAC and
DW QoS Eth IP-cores in the stmmac_hw array (hwif.c)
4. initialize the stmmac_priv::pcsaddr field in the stmmac_hwif_init()
method as it's done for stmmac_priv::{ptpaddr,mmcaddr,estaddr}.
5. use the PCS-base address in the stmmac_pcs.c module.

As a result (unless I've missed something) we'll be able to move
almost the entire internal PCS implementation to the stmmac_pcs.c
module (except the tx_config_reg[] data getter).

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

