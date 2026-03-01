Return-Path: <netdev+bounces-262425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WTvMIR92pGlthwUAu9opvQ
	(envelope-from <netdev+bounces-262425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:23:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D781D0D16
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF9C300362F
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C599175A89;
	Sun,  1 Mar 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="mXXzal7t";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="sPPdRhDk"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA52846F
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772385820; cv=none; b=WGjCryTQDApHRaZxgyaAehcCWtBkGs8f5KaKiig12uZtfDBDDmaapluyxUzrGQ1AJScZtmdPhMWRuHsY9WQ6zPHRHJiqn0jE2xPrHmTLU3/XhSaqvupT/YKBG+8684NGLPwCyy1jqqVEt+fwlX5/7qfVqkKG7Z6Uvg/TYZIP7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772385820; c=relaxed/simple;
	bh=2lKu2j7CXpAUpE5XIkjASXz9e1rZF3OzjLESkP9noMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb3xQk9pZO2fyHhhLyCROkMpOJ8mlfyNKAO9lgdgRndgN11AewquHnbKmPKZF59RGpEjP7zCCK8Z8DjNNyM3dItaqzRJKv0HB8C72tXWTa/ZscM09OgXYoPF/gNSkZuYYvbEVCiGWNwSKEqz/7XfQjH/+0p0PrRvmFATZP8rAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=mXXzal7t; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=sPPdRhDk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=mXXzal7taVs4T2txckiH4L/V35i9X49uxmKKmat/o7eDcGiN2ysrIBoeVWmql4xkQ79YBhhh3t+sQUvuTcvQW4+Mt+ZxklXcdhb8RbzwKvVzfxbWyTXHb6k9MYkU/kMBxJuIfkmOPi9Z/3NEboemt9b6H15XcGJXFCb8J7HkiK3P9tnaQCpuyGpR0dUzbikXId1HhoJc2tuBXCPMert1wyyar6dqO/ZFu8mPBa2pORE8NckbQ8gK810qrD1Yb7IMhSRlY+vc8trxSh48W2pmsx4MP8ntuq/Lk4YyppmBRxFP1mR3Q4cyExUxMr4xfdKwhGdpS28Ah6dnBfob16nsRw==; s=purelymail3; d=tinyisr.com; v=1; bh=2lKu2j7CXpAUpE5XIkjASXz9e1rZF3OzjLESkP9noMA=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=sPPdRhDkonxRzonUNcPnUVGOjMW44Xx8zylO7w/s0BeOPI82QUYCAgSfBgDOs3f2pk3xXA91hB/9FkO3wZxkNZ6qcLk6fdbQMHoP6Efro38+T8j//qkIUSmF1tN/GkMW/NRrJAKzr89GNLDHc96N4kknAK70hcZ+vFA/pX+0+MrnWimhpN5agBqJCW8I1q8ybR4B0Qom0A7TvHFdTcOBngixmjBdBNMPaGkFCwlo2BNPoOjdpkWHzZyjQwEY5X9rAaBGSXhZ44LFlotW29ZBtEXzjXntockxJy5MNDxVII0kIEbMoXw9+NvPVjSNlMOhTbzXjQDaSK0rG3kk0f6u2g==; s=purelymail3; d=purelymail.com; v=1; bh=2lKu2j7CXpAUpE5XIkjASXz9e1rZF3OzjLESkP9noMA=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1568104948;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 01 Mar 2026 17:23:32 +0000 (UTC)
Date: Sun, 1 Mar 2026 19:23:25 +0200
From: Joris =?utf-8?B?VmFpxaF2aWxh?= <joey@tinyisr.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2 net-next] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <aaRwcIwW9wIKkXDD@archlinux>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228185242.800836-4-joey@tinyisr.com>
 <62e825cd-7b5d-4839-a8d7-ae936dfa03fe@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e825cd-7b5d-4839-a8d7-ae936dfa03fe@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: D2D781D0D16
X-Rspamd-Action: no action

Hi Andrew,
Thank you for the review.

> Does "special" actually add anything useful to the naming? If there a
> "normal" tag as well? If you where to see a stack trace with
> dsa_user_special_xmit() i would think it was some sort of generic
> code. dsa_user_mt7628_xmit() is more meaningful. Especially when some
> other vendor thinks their silicon is special and want to use that name
> as well.

The "special tag" is just vendor naming. Will update the patches to
consistently refer to it as the MT7628 tag in v2.

> Although phy_read/phy_write still works, all recent DSA drivers have
> declared where own MDIO bus, and called of_mdiobus_register(). That
> would be the preferred solution.

Will fix in v2. 

> Do you have any idea what this is actually doing?
>
> Normally, a MAC driver would not touch the PHY. It would be the PHY
> driver which enables workarounds for erratas etc. 
> 
> Does this PHY support C45 over C22? Can EEE be disabled in the normal
> way, writing to the standard EEE registers?
> 
> I would try to put this code into the probe function of a PHY driver.

The PHY init was inherited from OpenWRT, I am yet to figure out the
specifics of what this is doing. I will investigate further and rework
this into a proper PHY driver for v2.


