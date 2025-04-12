Return-Path: <netdev+bounces-181860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DFA86A4D
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E58C61B4
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119BA14A62A;
	Sat, 12 Apr 2025 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTsKhQKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEA2367D9;
	Sat, 12 Apr 2025 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422761; cv=none; b=goSAqwrTvFI3iPoBduuwigKQVu+V4L9hx2Eq7LrJwXNOLehiF0uCs0H71m4KGPQPihlgOgeaPMJCZ2YUJsU1Fy3K16oHytEzu+OVRGLVDiIYvc+uFX5QXxhrg9EIlUu6I0DOxtklribuUx4BXblB0nUJyiKjuEEfsWVxvinbT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422761; c=relaxed/simple;
	bh=CRE+SY7bJNk+uYBL0kKrvVkutDrMpSNs63eSfb8DWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9dFRnIg/QR7sJdE/NJjBijiLGwvJwv1plEZgUPXTxHagpR8Eov6E9tnAP6x00hVGrqbEBQa2rhO+2dUajCyyYQdkag4QLBDPDIie/6xCk7jM3w7Z1FQJjL3sYailspcqsWslDoIf1TpAQBX7Jox8lrumNgyBcxaZh7H8ijTApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTsKhQKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E88C4CEE2;
	Sat, 12 Apr 2025 01:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744422760;
	bh=CRE+SY7bJNk+uYBL0kKrvVkutDrMpSNs63eSfb8DWaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTsKhQKfNS53TwGA68TBYkM3vurdB5bj1Ko9Gpc+0gpB+MqPUB1bN/seKZlpIgRPD
	 9LkD7Qjws5wnZ3Oj3cWaac/ZmZu0cJlhWsjdkyUR6wy/UdsZzypX7kvgZ4CSUjnIf+
	 dC/fpN2qL+xSQO4WnuFw6LjyjjIAAngtQrA/Ts95FvXciOX6S891KPXyv0P/ucO5im
	 FqC5btjsNAk6Y6TKgWswQ8HaJE70xXrLwNKaYtE1+tTxVM1jraUcDkoO3s803+O7ao
	 CRxI24QIIdzLSCKoMQ9luXAJJ6vjgaMVPmbC1zOsmiCx9851lxC4f0datcZbI/qBxr
	 8pwL5B7ENu0tw==
Date: Fri, 11 Apr 2025 18:52:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v5 1/4] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250411185238.77372b15@kernel.org>
In-Reply-To: <20250411092619.722b7411@fedora.home>
References: <20250410123350.174105-1-maxime.chevallier@bootlin.com>
	<20250410123350.174105-2-maxime.chevallier@bootlin.com>
	<20250410172155.3cd854d8@kernel.org>
	<20250411092619.722b7411@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 09:26:19 +0200 Maxime Chevallier wrote:
> > Transient warnings here that the new functions are not used :(
> > Would it work to squash the 3rd and 4th patches in?
> > Not ideal but better than having a warning.  
> 
> ah damn yes indeed... meh sorry about that, I'll squash the other
> patches in (except for the net/ethtool/phy.c patch). That said are you
> more comfortable with this approach ? I was unsure this was what you
> were expecting from the previous iteration.

I'm not sure if I did expect anything in particular after the idea I had
proved to not be feasible :) This looks good at a quick look.

