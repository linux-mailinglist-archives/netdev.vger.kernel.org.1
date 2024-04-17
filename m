Return-Path: <netdev+bounces-88718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE678A855F
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724921F21146
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D014037E;
	Wed, 17 Apr 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yur3tek9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1512DDB2
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362203; cv=none; b=nY8IwZDp2WjmGlExySDO1ufRRKA1TQpGwX2rE/e44nxW7VKtpGFokkBrAci0/H3w9lfb4uRHuDegt3kpPQrGC/iO+MsLmBpShfR0TUn2hF3ZJHpIThQw3KQdbTtkwkBIW0u/NCRBhACArquguNCp4fkD+hIio7d1MYj1Na7h09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362203; c=relaxed/simple;
	bh=FXg/Uu2IwZr/gSE0CEljQGLOtLMinNkOtX53Po3LN00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8LMKSNAERZDJvRXWH8vQDGl1eHSAo/pOgZIL8MXXXGlDiztdNvrH/WbnIN9OvzwV9GVLPVu3Y7Ir0aH1L0hU92Zu5ZzrNQX45pXAXh/uPtEhbI1+tvrtZMPfSyt0Hl2JXTb+CQfdrf1JR6co8udAj4qTDPIt5N3RDLaKDNaAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yur3tek9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w4YtBb9sFfjS4/Awkyd6Yyr9s8RX3IVCrPWE/OMBDVc=; b=yur3tek9+AzjbeASPoZzwB2gF6
	NyigAUvOQ8KrJkq/BWmAQm7MB85/XxUwwtaaVxdAujlBGovfsaxhoA2g8VR9TDx6TX1bQI934mvNl
	EpGDKviE61ZeSaW/+TpN1jKWvA1U3OLaZBhtHvg/b3FNXAD2PM+KHdaSTelTS/QTrRsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rx5m3-00DFVN-OG; Wed, 17 Apr 2024 15:56:31 +0200
Date: Wed, 17 Apr 2024 15:56:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Fabio Estevam <festevam@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Krummsdorf <michael.krummsdorf@tq-group.com>,
	netdev@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: Regression: Commit "net: dsa: mv88e6xxx: Avoid EEPROM timeout
 when EEPROM is absent" *causing* timeouts after kernel update
Message-ID: <b3f72f80-e41d-4abd-bb6f-10f3b58e65c1@lunn.ch>
References: <1f22520948180e55125fdc686a0de8a93c317e5f.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f22520948180e55125fdc686a0de8a93c317e5f.camel@ew.tq-group.com>

> Any suggestions what the best way to handle this is?
> 
> The 88E6520/6020 "Functional Spec" seems to suggest that the old behaviour (waiting for the EEInt
> flag) is more appropriate on these models, but I guess we should only do that *after* the hardware
> reset, as something else may already have read and cleared the EEInt flag before the kernel probes
> the switch otherwise... Maybe something can be done with an explicit EEPROM reload (Global1 Control
> register flag RL)?

By the time mv88e6xxx_g2_eeprom_wait() is called, we have detected the
chip, and know what it is. We have the chip->info->ops structure. So
maybe add an op to be used in mv88e6xxx_hardware_reset() to wait for
the EEPROM to be idle? You can then have the family 6250 use a
different mechanism to all the other devices.

	  Andrew

