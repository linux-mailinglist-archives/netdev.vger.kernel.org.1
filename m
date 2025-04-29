Return-Path: <netdev+bounces-186737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79594AA0BA7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56DA1A855A2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF472C257F;
	Tue, 29 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MfWx5slO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A0524F;
	Tue, 29 Apr 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929730; cv=none; b=F1ORXhwTecoJDdSK6o7FULu1uKnx9sXrY4tMiBqeITgqpLTAqZdUojdb9K4jAsIBBgxwy+QzoSOLzpIC2mItRuzF5lVCdlRMsFaWSQfdDHfYt3O6emIAZGjFhF8NovZqu+EriZdjfG3ZfxGnHZ59QJkKXyiWNjvWGi8GvjMxnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929730; c=relaxed/simple;
	bh=jqowjZvlBiorAne8OamkMAWE/1Sis1GBvUHwc1czNHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFv52zA2W1p51GCNNWqy9OscL59a8CMyYnyEnLNkhaE/EftPSU1Z8j17dOv7krwGCG3yane9twmZC3owr63FMjxhj6sarPPxp2w6zMoNeq9EAHf5OcLrJ6neNctB35urODxSIX93Cvqa2SO//7CeK9hbWTVaUg4Ju5fvU4Xx/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MfWx5slO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=po7aA4vJqUXSpskhIE3e8lkgayysJvhbX54JD8OfIHE=; b=MfWx5slOJV/JFEGXhaiZ0ejvmp
	lkS0+oUoMEnwnDObgtOP6U21T8gOnEzi6Wsj/WHxmYfUGPl78I9nDd5JtDLzT3wlkn6WPPPPX5riX
	nmHP41hxeQUea9vk0Ibf6qCx5K4ZdUiWMnXYCgS/+Iec5yqxVm/nMq00BCR8ixwVsbH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9k4l-00Aw6Q-AI; Tue, 29 Apr 2025 14:28:39 +0200
Date: Tue, 29 Apr 2025 14:28:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: daniel.braunwarth@kuka.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: realtek: Add support for WOL magic
 packet on RTL8211F
Message-ID: <fefb3642-b741-483d-beaa-bba557306d68@lunn.ch>
References: <20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com>

On Tue, Apr 29, 2025 at 01:33:37PM +0200, Daniel Braunwarth via B4 Relay wrote:
> From: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> 
> The RTL8211F supports multiple WOL modes. This patch adds support for
> magic packets.
> 
> The PHY notifies the system via the INTB/PMEB pin when a WOL event
> occurs.
> 
> Signed-off-by: Daniel Braunwarth <daniel.braunwarth@kuka.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

