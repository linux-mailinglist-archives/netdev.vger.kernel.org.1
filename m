Return-Path: <netdev+bounces-128561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C997A5A5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D8F28A0E2
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17F15444E;
	Mon, 16 Sep 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="htgeAxRB"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02017BBE;
	Mon, 16 Sep 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502553; cv=none; b=PzmR5sYpw2c5Y6cc03VlXvADfM72G+bi39Eg5BZyqWv6O9svcjjHVxT7mMHnVhkKL2Rq4fMZBQ56vtRJp7RV/jQwpy+CGFCWVbsQ9pPjisMCzoluPLm968Eg8k44lzB57HJw3V8ZO9kTg1W5q3ASahc5P44WtcUKnItks2qu9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502553; c=relaxed/simple;
	bh=VZlVOuY55Uwha8jbHpFBDh8CI6nnxWJZFJUh3f72mE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaOt+qLhT+bNNPtt5VfQFpIs77jP3DpO0uuef127D9esd1/8tdDOx2JT46oAE/baYPso4uOFLmvfC1ZWPjoyZtdTHWFUCXnWV9LCYKujr1iYORmIaB3+h9dFa7tTPopLlZBNRt5ek/jyk8fzoX0I+s5qKa/rCDwmPqpzX1gpwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=htgeAxRB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD8601C0003;
	Mon, 16 Sep 2024 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726502548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQHeSPJDt1F5HuxussnlWPGoLt9OS1n1VetyeQjzbPQ=;
	b=htgeAxRB74MW6DqqY8w9AcbzOzCx4b3hsxVYuMe5mb1n4Mz2B0RsaaQG5qhQrSfJ3Y+DtB
	JlYTErK5/vB8yX8iRAq1nmawTBt503hODlZ9JciuAsHdWAHMWMDNW0fWkZ3zniIhNLrTdG
	718iZAyXsTc8PRJRf/w0LjGAOqz70nYAYRS5tr62gZr3PBgL4iyPjxlHvWksA0OP/7gkYt
	ukNi97kKBx9Y0w1fOnF+WPvCplDgVxCGZyRrJh3ReYBzQCtyN32xz++/h+OWTHzLUU2C/w
	/ZTWRQHoOY1Ipwr2v7VKaEhItMBTs0CYeGQtD8Y3EULKa/Tq/0HmMfP79Ck4fA==
Date: Mon, 16 Sep 2024 18:02:24 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Edward Cree <ecree.xilinx@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <20240916180224.39a6543c@fedora.home>
In-Reply-To: <ZuhQjx2137ZC_DCz@makrotopia.org>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Daniel,

On Mon, 16 Sep 2024 16:36:47 +0100
Daniel Golle <daniel@makrotopia.org> wrote:

> Hi,
> 
> I'm wondering how (or rahter: when?) one is supposed to apply ethtool
> settings, such as modifying advertisement of speed, duplex, ..., with
> SFP modules containing a PHY.
> 
> My first approach was to try catching the event of the PHY being
> attached and then re-applying ethtool settings[1]. As there isn't a
> dedicated event for that, I found that IFF_UP && !IFF_LOWER_UP is as
> close as it gets.
> 
> However, that doesn't go well with some PHY drivers and the result seems
> to depend on a race condition.
> 
> Simply ignoring the supported link modes and assuming the kernel would
> filter them also doesn't work as also the advertised modes get reset
> every time the SFP module is removed or inserted.
> 
> Do you think it would make sense to keep the user selection of
> advertised modes for each networking device accross removal or insertion
> of an SFP module?
> 
> The user selection would by default select all known link modes, using
> ethtool (ioctl or nl) would modify it, while the actually advertised
> modes would always be the intersection of user-selected modes and
> supported modes.

The problem I see is that the modes can change completely depending on
the SFP module that's inserted. If say, you plug a Copper module,
filter advertising to 100BaseT, unplug it, then plug a Fiber module,
you end-up with nothing in the intersection.

Same goes for speed limitation. You can plug a copper SFP, limit the
speed to 100M, switch it with a Fiber SFP that does 1000BaseX, and here
100Mbps isn't possible, and you have an invalid setting.

> 
> Alternatively we could of course also introduce a dedicated NETLINK_ROUTE
> event which fires exactly one time once a new is PHY attached.

That could be done. We have netlink messages in ethtool that report the
PHYs existing on the link (ETHTOOL_A_PHY_GET), that's new and still in
net-next. There's no notification yet, but this is something doable,
adding a netlink notification to indicate that a new PHY was attached.

While this doesn't exist yet, you can take a look at the recent
phy_link_topology work, that allows you to list the PHYs attached to a
netdev, including the ones in SFP modules [1].

A workaround for you can be to wait until the SFP PHY show up in
ethtool --show-phys ethX (it's parent SFP bus name will be populated,
you can filter on that), then re-apply your settings. You'll need a
recent ethtool [2].

A notification would indeed be better, and is something I can prototype
quickly. I was hesitating to add that, but as you show interest in
this, I'm OK to move forward on that :)

[1]: https://lore.kernel.org/netdev/20240821151009.1681151-1-maxime.chevallier@bootlin.com/
[2]: https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?h=next&id=b3ee7c0fa87032dec614dcc716c08a3b77d80fb0

Thanks,

Maxime

