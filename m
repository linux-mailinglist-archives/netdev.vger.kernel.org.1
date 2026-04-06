Return-Path: <netdev+bounces-275603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eChBMti702mslAcAu9opvQ
	(envelope-from <netdev+bounces-275603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52A3A3BEF
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E932F3022604
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C8370D4E;
	Mon,  6 Apr 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SMgI942G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4E372667;
	Mon,  6 Apr 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483822; cv=none; b=k9kvZxEEUV2BN2j+cHzCZd5QEX54fg32cC2FE66LFcuJ8FRIIY+KwlyZbRY4FqPtuxgsmdcIBwhnLBsMIhIhDlmjUT4vizkOZhDx7jSRJotAcG0AH6EjKKzsWovY1YiDqPi67+BJyZGct65O4qQiSaYLDb8GJ5En7BQ/3ejVBhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483822; c=relaxed/simple;
	bh=xjHwG5Y+1E1d2HwBhZsmGySfm5K7EBG11H8zaiaM9cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDaa5acfAbfs6b87zsSqyaY9304jEcDRjEZhWSn0NTUuhYTfLcGV/esr7lgZZzbTjrjuYB5rdn1W9cKQiWVO0HIw4PCtTAChOjgEJqaEZenH/Oi0trH7H51/jdtvJ7Nlf7jCN8//zQGnFFXkTF911Kd2d+7PkaUddJBoFj+xYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SMgI942G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P6+ExAEXw9GKGXkRDQY+ltkonNVErp1cHtCmBK5GetU=; b=SMgI942GxUKcjBVCjiy7h8WiWZ
	DnYPldEHZ0kb0VLRTe1Xg1IXhCsxpRnHtRzvXh5Wdx99ITNIQcUivXAAkj8bSpvRmRvvFcmEI5Isz
	RF+DQOE9C0ijARr6bqxGhwDBGiFwb/ksIYaZQ8DxkxWW463uOLlJZEMe0pY3v1YU2XiI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9kRd-00Ezh8-PC; Mon, 06 Apr 2026 15:56:49 +0200
Date: Mon, 6 Apr 2026 15:56:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Message-ID: <5298959c-12de-4992-a896-3d1371cba111@lunn.ch>
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
 <a1cf8f6a-b338-4dd7-aced-7e19e4d0fdb7@lunn.ch>
 <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9272c5dd653039b3def8caaea3e631c5@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275603-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 2E52A3A3BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> "Autonomous EEE" works for me (obviously). It kinda describes what
> happens (the PHY acts autonomously) without being tied to a specific
> vendor's marketing name.
> 
> That said, I feel Russell's argument that it doesn't type well. But
> even after some walks in the woods I wasn't able to come up with a
> better name yet.

Yes, naming is hard.

> I don't think there's a meaningful use case for letting users choose
> between the two. Or is there?

This has come up before, in other context. PTP is one example, where
both the MAC and the PHY can implement it. Ideally, you want it to
happen at the PHY, it gives higher accuracy. But there are systems
where the PHY implementation is somewhat broken, and the MAC PTP gives
better results. So defaulting to PHY PTP is not always the best
option.

I would expect IEEE 802.3 EEE, with both the MAC and PHY cooperating
is better than just PHY level EEE, the system as a whole has a better
picture of what is going on, so using 802.3 EEE should be the
preference/default. But are we going to run into oddball systems where
autonomous EEE is actually better than using a somewhat broke MAC?

	Andrew

