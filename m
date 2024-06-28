Return-Path: <netdev+bounces-107706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3791C03E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81D0285534
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B919CCF9;
	Fri, 28 Jun 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gw/Wozem"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E8158218;
	Fri, 28 Jun 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583364; cv=none; b=dikdf4M8zoU5/Fni6S7f51OCoq3uE5OGtpjyPwNaK5uXlCUY9Xoy1WFLCwyCd9bGXLDmQTmEiwSMpOGdgqxlgBBhjNy9ZEcrW4y/nxr/r6W8LT9gQYFyqPwUjpehV58z6PEUtWUdXBYIh6rC9YvCnNVPlFPcEMVo9RfOkquJ5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583364; c=relaxed/simple;
	bh=MEpvSjn91yrrcVqqeGtLRy92zryBEFq/wog26GB5cjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkUHUp4xj+E8s5uWpduz8tQj31AJF++iUoC1V0wqwSRTluS9hvpNjHS61uNGBFpQfQV0HnGy6dN5ePSxtPDYA//2BcnGlWUfYGEpt4/9dhDOsmoPLZjR4/Bkq+iolFNWF7QGnezP5kcm23D/Aft5j/OQrETlWwv7F4lnskZpqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gw/Wozem; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZHmz/xNYO4WH388fi0UlfzGqEy3zNweIjv3ChQBFAO8=; b=gw/Wozemh0HMXzK9TgbLgi1Aff
	Ze8yTOs1NNgt79sjgTQoGEFFPkADa2q2CGDpK5WF3bN1hfoC9C55rWvgeK95BMrWnLgxNOrUKrezT
	n9NfaFG7MMyNaAeVgVWA0RZNAdubGksMy07zlCQDZLkesdMP331BHYLUUBhHWUqQQf78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNCBO-001Hs6-Oj; Fri, 28 Jun 2024 16:02:34 +0200
Date: Fri, 28 Jun 2024 16:02:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: lan937x: force
 RGMII interface into PHY mode
Message-ID: <8a12a13e-e379-4044-b463-f715420d0238@lunn.ch>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
 <20240627123911.227480-3-o.rempel@pengutronix.de>
 <20240627222543.rcx3i5o43toopwcm@skbuf>
 <Zn5hyR1AKV81nulo@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn5hyR1AKV81nulo@pengutronix.de>

> Now, comparing LAN937x documentation with publicly available documentation for
> other switches, for example KSZ9893R, may give some clue on the undocumented
> part in the LAN937x datasheet:
> RGMII Interface:
>  1 = In-Band Status (IBS) enabled (requires IBS-capable PHY)
>  0 = IBS disabled

That explains a lot.

With the updated commit message, this patch should be fine.

     Andrew

