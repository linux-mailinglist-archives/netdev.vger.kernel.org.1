Return-Path: <netdev+bounces-222106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A54B53201
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089EE16D905
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D94320CCF;
	Thu, 11 Sep 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iUtj1fUd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FF320A3D;
	Thu, 11 Sep 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593392; cv=none; b=ud5PYkuFfYhkTplwgamKrWOWP75oEYA0TBxlxw61VRRWWIFOZBLLseZEfboi9w3KeaCywFycr56tsqbbGH5rbRAGJS/+JRj1BOQOA7FCJf6fDfDRT42gZPZf+rmHGk7CR3YT2LojCxYjJn9wz16ajPP4NMXlzl6yK0/BHOsMomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593392; c=relaxed/simple;
	bh=R9YWyIzRE57e5iQ58DP3D1Bv44q/n3swKiLnk0qOFow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aObcC0ver6etms8Aa5L9K8iFO/6ZL+52kUeAEqnnbuWrzDMNU3JAk3Epf71ZNIg7lNrJxfg45+Vntzedotvl1BSoXUaatMp2anUuAicn34KbtSD2SgfDQIWK10uBhSOyRR7qzEhZyZhtzLFFxTSzRu16UsueoVY66dZcZxvxsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iUtj1fUd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q/+TRdQQOjc8EYjaftE572NI2az6P7CG9X/fSzKljMY=; b=iUtj1fUdZYQfwG87ZFcRTVjPmu
	pHHb7ps3QUmjzxqAUTyLpEa6bpn7lChUvw87X3534prp9QRaZIxyBq/ugdacwFslMYUYQryvTGxu1
	uDL2ZYimDjFMfyQAYmthvKZMxE3HTeIyyOVTzy2J+6huwpf4UIxBljKVd7r7YuB0bqdQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwgKF-0084ha-UU; Thu, 11 Sep 2025 14:22:55 +0200
Date: Thu, 11 Sep 2025 14:22:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: clear EEE runtime state in
 PHY_HALTED/PHY_ERROR
Message-ID: <b76c7f70-73b1-4d80-9e44-6305fcf0d09d@lunn.ch>
References: <20250909131248.4148301-1-o.rempel@pengutronix.de>
 <5078fdbe-b8ac-430a-ab5d-9fa2d493c7da@lunn.ch>
 <aMEj8vjJY4h6kYbN@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMEj8vjJY4h6kYbN@pengutronix.de>

> As a follow-up I would propose a separate patch which clears additional
> link-resolved state when the PHY enters HALTED, for example:

This is good. Maybe mention in the commit message there will be a
follow up for other state variables.

Thanks
	Andrew

