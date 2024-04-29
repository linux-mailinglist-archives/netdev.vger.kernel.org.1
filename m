Return-Path: <netdev+bounces-92167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84768B5AAB
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838DF284E81
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4574BE2;
	Mon, 29 Apr 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dJ9CCFty"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1A6A8DC
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399148; cv=none; b=KMORQ+vyU05zZJOTp9YZZWwNevJnBbHBWwGdcpJ5Eo08uR1686eD36de1pNKUMFJSBfnGII9RxARwo61jM/mfo4AkTpMwdW9DtDHXJpfhYPj9D8lsVVBmn9lifUH4+A0y/r1dWp5XSkmE+f+Wu4kg3wn88iT96PsbCeI7a64Xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399148; c=relaxed/simple;
	bh=xKmFzyTaSmAFHFgtLHld8q+kDRVCDBTM4gtSLiLjIFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqPTnzoWyyEnrxlBW4WX7JX9nXX+rs7d9Ov6MV8gyvmdrdeMAmzfWez51Lx8oWsC9aqxheoLw4/0simsMzwFVryf903/xGD7d8tHy7wh1mT5d3TB/Be8wF1of6ncSbNFi3zZ1yJ3TM5hpdJV8bUQRbtm3VWyHcYI4oxWxHwFcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dJ9CCFty; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Y9tzfkVtoipUstEG1JdIl7pVaxzdqKqaQUkU3nRhzfo=; b=dJ
	9CCFtyqWOfN7wZOtN7ItAdeFihemMlWUwe+VfbD+dCLSIK5afE9VKgK/XJ9XXUfvJcW+/D22ikHqx
	9IoxeqgvxXR3pW4px/4wxeqOpFT3tC5eN5qwh+64aSGEpYJlytn9GohwL+ezONlmkHiu6yG/gm3A/
	o6FNgxqBHiyU77k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1RX4-00EFy7-Jd; Mon, 29 Apr 2024 15:59:02 +0200
Date: Mon, 29 Apr 2024 15:59:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix number of databases for
 88E6141 / 88E6341
Message-ID: <e93eb0f7-4ecb-4aab-936e-58af88d9c855@lunn.ch>
References: <20240429133832.9547-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429133832.9547-1-kabel@kernel.org>

On Mon, Apr 29, 2024 at 03:38:32PM +0200, Marek Behún wrote:
> The Topaz family (88E6141 and 88E6341) only support 256 Forwarding
> Information Tables.
> 
> Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
> Fixes: 1558727a1c1b ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6141")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

