Return-Path: <netdev+bounces-130433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D231D98A7CA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA131F247B4
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47B192B7A;
	Mon, 30 Sep 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ISLgR2V5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEF23D2
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707870; cv=none; b=IAbM18yHqKflB+2tE9EyNKIf3y9d62nhmdK8Hea33n1ifsIFbs6TYA93YQo0dT+iNuwnZ6926cnmaFX/XsHvnRbYJwz1IqTipzxs9AEBDzTjxZ4gIA8aogbeWw7GHkt+JO1AOLB+0gj5i3Dl87zwRbB563tMGdZvucarKp/YJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707870; c=relaxed/simple;
	bh=SI+2KXzG9ocXcs8B/P6Lwx+RXKjc8P5F/1EgU8LxBFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt/Mcio3Cq2SvZwBZL6AnFGMwyWGvSrsYEJszZZTcRju0vVz8g7Nbdf0NG3qsy3jGWBfm4kWAnVvGpZu0qWbSFkn9bQJvRyD4Fe5Q9//87SnFE4ieGfm76z2wIOgheWJt32o0nGAgUKI/Oc3KB+wlzxFLz9898EIbQPelKFVmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ISLgR2V5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xK0/f32VgbSAHaxYTwiLp4tpPwQGenWwu2VFvCDg/JI=; b=ISLgR2V5rTeyDAKyxSlT/HrvCH
	K5UQp/V7VrL95LoMrlWNcBekUquzoENP3ACXb2rj8os8HactFzWiVcr0HGCxF4EGWIuoXZjn+1//o
	55E/lrrxOXKUOu5JBwEvrP+pzDy9radwScyy5UGH6seoLfZfHA6/L/H4cbcuYr/TpPlM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svHjv-008dLj-6n; Mon, 30 Sep 2024 16:51:07 +0200
Date: Mon, 30 Sep 2024 16:51:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net 0/3] net: dsa: mv88e6xxx: fix MV88E6393X PHC
 frequency on internal clock
Message-ID: <2a6ecc1b-7e77-4808-8b5c-b1a905f21411@lunn.ch>
References: <20240929101949.723658-1-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929101949.723658-1-me@shenghaoyang.info>

On Sun, Sep 29, 2024 at 06:19:44PM +0800, Shenghao Yang wrote:
> The MV88E6393X family of switches can additionally run their cycle
> counters using a 250MHz internal clock instead of the usual 125MHz
> externa clock [1].

external

	Andrew

