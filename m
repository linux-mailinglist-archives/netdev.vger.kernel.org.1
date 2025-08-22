Return-Path: <netdev+bounces-216137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC94B3231E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64E3B216B7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0827510E;
	Fri, 22 Aug 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k03kluIL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F803288CB5;
	Fri, 22 Aug 2025 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891943; cv=none; b=KQHWIwHrlxtgyCTfE6PM6HeW2GiyTKbxbL+cw/uLKIhyeTxFLu0vOglbwTMqbIVV+M0APsnQcaP2Ja+smk3+PIkDvW3/OvLtpL+8yjMPK0DdJkwRtBB1+JgAkGTYG++o4TpZrsoL3ZBI9tWZEx4P2wmVvzU5dQLTBiYts1yx1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891943; c=relaxed/simple;
	bh=sLzzSmnTh6OCiEamMbZhd2lbEMBDp16+rMPNr/WElh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kImGc+36uKDPVUvm7e9R7Jo1MsxsIrjS8GF8hdvCITtcINsR01dMDvObz3G/A0s+XhMj5XmRy18z9eWFgO6m+2hi6nLcN9bJDkm04x4RyTajuGpBtOecs+R/bMPFtBfV7sQnWwN6gO0eFmbCwAKgPnADSwyRS9dYL8Lm+cyfYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k03kluIL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o+1D6/1hsAtqZdeY36Qt1J8d/n07JE90cuRUiDYWwBA=; b=k03kluILPi66Z0/l2DhNRfTtMq
	FEriznnwaBH/ktDulQoPyPI2BhFH81SC8frmkf/b+ZfwfMuYP2xTfcEI0h6F+lNtkPbC34Uz/cU2o
	A43erpDCsMhH7MsGOhOAOFxLust9bkefPxgBqaLHaav+TMfiLi5gFEEUNxWwqauvEzls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upXhS-005bkd-Ib; Fri, 22 Aug 2025 21:45:22 +0200
Date: Fri, 22 Aug 2025 21:45:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] net: phy: mxl-86110: add basic support for
 led_brightness_set op
Message-ID: <b3995276-2eb0-434c-b5c6-ba0cd7085171@lunn.ch>
References: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>

On Fri, Aug 22, 2025 at 06:38:27PM +0100, Daniel Golle wrote:
> Add support for forcing each connected LED to be always on or always off
> by implementing the led_brightness_set() op.
> This is done by modifying the COM_EXT_LED_GEN_CFG register to enable
> force-mode and forcing the LED either on or off.
> When calling the led_hw_control_set() force-mode is again disabled for
> that LED.
> Implement mxl86110_modify_extended_reg() locked helper instead of
> manually acquiring and releasing the MDIO bus lock for single
> __mxl86110_modify_extended_reg() calls.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

