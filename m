Return-Path: <netdev+bounces-31474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F017578E41B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDD8280D96
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C5610EB;
	Thu, 31 Aug 2023 01:04:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DBB10E1
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B2C433C8;
	Thu, 31 Aug 2023 01:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693443879;
	bh=GrHBq04S/lIWLz0lb2weVGApErFJkY2SCflqNO6ELp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtYEdZwWjRzAjI55nw6N5ODNtC7UOWcvANUpeGpRvBUuT+Xi88xfo/zAYiuUmcAoZ
	 ibPnkbckIFBhLHl8FNMqmBXq5RC4UrpWTaP6A2Z4rVB4MKNv3dhxQKm2Mk/dfgeEDt
	 EuDqJFE9YsyHA0WW4DHTEwyEoCOWuiA+Mhf9PeJMqpJaO45EHGFkMa4RnUPibitbmE
	 7otElFa9ZRY3w321ox5RYCzGYAgZhQ8f2csGz3Ywg6dDJCPGfFtcTLyz/SBMUxrfeZ
	 4MfmeshjGbM244e/vS9xZsVIQ7z9wQySzUuUHqeyYAXQhvfw8j59buaBZco65iM95Y
	 rcP++fU8fSzOw==
Date: Wed, 30 Aug 2023 18:04:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
 netdev@vger.kernel.org, simonebortolin@hack-gpon.org,
 nanomad@hack-gpon.org, Federico Cappon <dududede371@gmail.com>,
 daniel@makrotopia.org, lorenzo@kernel.org, ftp21@ftp21.eu,
 pierto88@hack-gpon.org, hitech95@hack-gpon.org, davem@davemloft.net,
 andrew@lunn.ch, edumazet@google.com, hkallweit1@gmail.com,
 pabeni@redhat.com, nbd@nbd.name
Subject: Re: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed
 single-mac devices (XOR RJ/SFP)
Message-ID: <20230830180437.583e6383@kernel.org>
In-Reply-To: <ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
References: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
	<ZO4RAtaoNX6d66mb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Aug 2023 16:38:42 +0100 Russell King (Oracle) wrote:
> So technically it's possible. However, there is no notification to
> userspace when such a change may occur. There's also the issue that
> userspace may be in the process of issuing ethtool commands that are
> affecting one of the PHYs. While holding the rtnl lock will block
> those calls, a change between the PHY and e.g. a PHY on the SFP
> would cause the ethtool command to target a different PHY from what
> was the original target.
> 
> To solve that sanely, every PHY-based ethtool probably needs a way
> to specify which PHY the command is intended for, but then there's
> the question of how userspace users react to that - because it's
> likely more than just modifying the ethtool utility, ethtool
> commands are probably used from many programs.

Would it simplify anything if we only did the selection from ndo_open?
We can send a notification to user space that the SFP got plugged in,
but its up to user space to down / up the interface to use it?

