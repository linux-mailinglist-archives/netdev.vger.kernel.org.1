Return-Path: <netdev+bounces-150483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FEF9EA682
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8093C168C09
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7E1C5CB4;
	Tue, 10 Dec 2024 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MtMCXKUW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3969D2B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733800920; cv=none; b=aJJK16MJz9dLkLFKd3SIBXCiWmY2KszkTR6xz+O1ewEsZ7ImccoRl447YKAzopZzRfme7YA28grbdMB7gNAYgh0jfIRmCWILhCDSm07nLs3jVOOYgMQvPM9Zyw8iv32Dh6YymGnhg5d5yPVpcIBhRebEvmtlj3VhyK59J5jzujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733800920; c=relaxed/simple;
	bh=8eM3UqID0fzXZEzbxshGZ9ur3mEH4XiOARztFvqyKZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM0hqG9Z+N4zts02pdBKdl4pyptVInyhAPSNEQunWrfFBhs3s31FTtcM+FJpy1Ts70tW1/LOnFCFUbPrG+daWf49nAOgHZcgCW++VjMeAl/7DqKa0yxeQFc72XJkuPfvhhbz72elyusElhjYToTrrDDc4C1hPNekjF+wVnn+Umg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MtMCXKUW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I43THJslsVS4w4jtBEZwxqcw0Y/NnVxoY2O6nbQP4Yg=; b=MtMCXKUWgjyAGBsLmAMzEIJv0D
	GUVbmAkyfNL4TqYSM9t3cECTN/h6iBMeRBCy97jkFk+35zbs4MZoaEfsahlktaagqBGAKSUG/QjmY
	cxoLJ0TyWx5Z+kjyDEGc04gSyTfnwowVMjj4MOXkaFeesdGgZubaPJlzoOfX48pVgZqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqop-00FkYu-Vv; Tue, 10 Dec 2024 04:21:51 +0100
Date: Tue, 10 Dec 2024 04:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 06/10] net: phylink: allow MAC driver to
 validate eee params
Message-ID: <a72db39a-ca78-43bc-a15b-5f1ab39af661@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefn-006SMv-Lg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefn-006SMv-Lg@rmk-PC.armlinux.org.uk>

> +/**
> + * mac_validate_tx_lpi() - validate the LPI parameters in EEE
> + * @config: a pointer to a &struct phylink_config.
> + * @e: EEE configuration to be validated.
> + *
> + * Validate the LPI configuration parameters in @e, returning an appropriate
> + * error. This will be called prior to any changes being made, and must not
> + * make any changes to existing configuration. Returns zero on success.

Maybe suggest -EOPNOTSUPP? We might then get more uniform error codes
from MAC drivers?

	Andrew

