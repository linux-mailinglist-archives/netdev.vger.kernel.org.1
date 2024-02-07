Return-Path: <netdev+bounces-69900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C384CF2D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A67728472C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064281AD8;
	Wed,  7 Feb 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aT96dARX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE681ABF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324095; cv=none; b=U0wR0FxCU2rDKN169Fg5Nau8/DWrR0cW0+jAlxVN9IwkUXVIO0TC+fQaV7qbNHn2ZjFBwsi9vefQzzwxSAzIJz7rwyMbCRH3FlUNvVDBAjqdCIiUPnBjNqha9kBc0ZVNUkTcQPzmNEs8LEDlF6ANBgJy5iuuuaJRBpKlVLY7lC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324095; c=relaxed/simple;
	bh=DBMIehp9nk3GZ78829lImZi9ufOEZMWdGxlE67RCT8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx796L4pPMwLt/a5JPzx356z0BnBes6aBtC5d9caQUPw4LODwcbt+pPsCPbxtW9s4zjAB6elxWonxgBvTUuyRbELeD5zs3ZrGJg80kv8ioNIGv6nkS4WZDbd3oWpnuj+B4PbEDmENSGX5qP7W/J+It5Sjny2q4ow6KxjsFjrvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aT96dARX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G6sTYIOuzJDBbayHtJVT0RTFUpoKC3/F5DfG7tsMv/Y=; b=aT96dARX8Ul9vfMnQxI7PxOtG9
	jf/sAZNTFpGraKp0ONkuqarzDKbCVBPLbp5k4pdJiI23uJ6WHb2XETu5RuuDiQ+WEFK8AX02VZSXl
	cwLSE3rHQ+FiPYSDzVyqREbDSCPxCdFjnC8SnDlnG+/g9emGS97VWN6QrYGm2EeEaEcM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXkzF-007ElQ-0q; Wed, 07 Feb 2024 17:41:25 +0100
Date: Wed, 7 Feb 2024 17:41:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Ariel Elior <aelior@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] bnx2x: convert EEE handling to use linkmode
 bitmaps
Message-ID: <b75f71ee-3050-4f41-a172-cd6944768d5e@lunn.ch>
References: <948562fb-c5d8-4912-8b88-bec56238732a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948562fb-c5d8-4912-8b88-bec56238732a@gmail.com>

On Wed, Feb 07, 2024 at 05:35:28PM +0100, Heiner Kallweit wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for
> removing the legacy bitmaps from struct ethtool_keee.
> No functional change intended.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

