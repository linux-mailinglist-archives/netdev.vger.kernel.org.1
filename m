Return-Path: <netdev+bounces-233887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D2CC1A22F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EED04201B6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFEE337B92;
	Wed, 29 Oct 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lkje4u8J"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F031E0EF
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739681; cv=none; b=UeW6wYqMCYPxXEyNwOXJkRKC76MdoRwHDeQvPba7E9cUYFz/g2Lfjxx+x9LfYViRG2+G/izRmgdHVjOhLm0tZkkA0HzlTH1Q8JOBit/0yQx47IJNLYoFhsqzBfEFBFal+tfbIgTK2klUBDCAptwZdflt4UeUz5wFH53aPxc7/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739681; c=relaxed/simple;
	bh=YBIjbAkhGGp2DY/DK7FxV7Az/58+uISZFS9I6yvFkgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmHSQgqxVnk3xjRrqpNUzps3R3nXTf6S8V39BBO2Ii3uFsXeDO+GgcyD0cQpHp+D0w/kkXvOQ8Kx7JZeR3wWna4JYWK3JzOHlif6pwdzxHcCKcko7p3nIrFqm6SxNp6pUnUamXFOa2CiGaf7BR1HClF56rRh4gWxVOS/kdF6JV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lkje4u8J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bapFYtojQQH06sqvAiPT2KvyrRhSWdKVCMzfs7j2LOA=; b=lkje4u8Jj5UM2OG3YFh8AWZ29n
	cypiFFrNToeqAB1ICQYK16YRcigNsmXs6XLrGBOnpl4iqsbqpc9kCMqnUlJbLDHn5tpwLJlvYTRuK
	zEcsCTTaWRawYYPNX7xnDIOeV+J01mekxC9utaKAv+SBy69o/SgVF0/D0whpQbeeTto4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE4xj-00COnU-Lh; Wed, 29 Oct 2025 13:07:35 +0100
Date: Wed, 29 Oct 2025 13:07:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yi Cong <cong.yi@linux.dev>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: correct the default rx
 delay config for the rgmii
Message-ID: <94ef8610-dc90-4d4a-a607-17ed2ced06c6@lunn.ch>
References: <20251029030043.39444-1-cong.yi@linux.dev>
 <20251029030043.39444-2-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029030043.39444-2-cong.yi@linux.dev>

On Wed, Oct 29, 2025 at 11:00:42AM +0800, Yi Cong wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> According to the dataSheet, rx delay default value is set to 0.

You need to be careful here, or you will break working boards. Please
add to the commit message why this is safe.

Also, motorcomm,yt8xxx.yaml says:

  rx-internal-delay-ps:
    description: |
      RGMII RX Clock Delay used only when PHY operates in RGMII mode with
      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
    enum: [ 0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500, 1650,
            1800, 1900, 1950, 2050, 2100, 2200, 2250, 2350, 2500, 2650, 2800,
            2950, 3100, 3250, 3400, 3550, 3700, 3850, 4000, 4150 ]
    default: 1950

    Andrew

---
pw-bot: cr

