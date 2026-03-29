Return-Path: <netdev+bounces-272957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAyPD3dnyWm4xwUAu9opvQ
	(envelope-from <netdev+bounces-272957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAD353731
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E58300D44A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE337CD24;
	Sun, 29 Mar 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaUZWD7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75C36EAB8;
	Sun, 29 Mar 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806899; cv=none; b=RFUbAxOHS4qYoLa8fWnBvY/YbUNJcd+4ygtY+Mh9OHeH4Vvbx9JSGSNyR+nKgDvoJDbKIm9Nqs/Z/VRGQvz/J9heeWoN2FrTuzxlr4gurs010ljeRNhmhUiizl8vAX2eYy+DrHnPLmpRUozddPHr2376dvfBvGwuZq7RmAn9TJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806899; c=relaxed/simple;
	bh=CUCwW1kG8ogpWIE+AfGsgiXtuwkjW8AZz/CC2jYthRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgeDVTF7Rm4GSytCuVFuf6r6lVvhi12SK3qnr8+PvTZlHduXHz22zQHikmMWnoc4ZJim0OvPrmU1WxQaU7bQHnUgu+hLljKtFxIEO0oC1XlPZjyvUgibATTrtjIa2Jx+f+MnZtwuDbXKoSr0PoaPkL9GHqvXmFXVLqKiiAiU15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaUZWD7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC0EC116C6;
	Sun, 29 Mar 2026 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774806899;
	bh=CUCwW1kG8ogpWIE+AfGsgiXtuwkjW8AZz/CC2jYthRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZaUZWD7dUi4Rq/mf8IAaDPCaLkQ3RQs82DWpS8J6MXZd9ZLYOUzK3856TDPaU6mae
	 UtEWSKsPw1KWqbvEI09PTZmnV/pAJGODHbM5sB7RFmhImLEoyj4eH23g9NjL8Yl20s
	 85K8qqSfCvqbWwIL+/oytyGA2A1f0Soq2xmMA2flHPvrVQZ1qUoiU9FS/0Fd7krqvP
	 U5cm830hQzIq2NsfwruPy+f5feOzVcC4U67J6r2iagvvb2XmQ7Tfg3OHSs+GPQ+gxi
	 Vmqr7EKYSrlnU29Z4AZ/ZK087HNh1A+MKXZfri6F405QAXMx5EgZ0QfJ6y9QtngY81
	 CQYWEaVaEowBg==
Date: Sun, 29 Mar 2026 10:54:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Michal Kubecek <mkubecek@suse.cz>, Gal
 Pressman <gal@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Ido Schimmel <idosch@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Greg KH
 <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, notify@kernel.org
Subject: Re: [PATCH] ethtool: don't touch the parent device of a net device
 being unregistered
Message-ID: <20260329105457.04cad5cd@kernel.org>
In-Reply-To: <676733D7-814A-4B66-9E49-93DD1259ED48@linux.com>
References: <20260322075917.254874-1-alex.popov@linux.com>
	<3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
	<eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com>
	<20260323150827.24a6259c@kernel.org>
	<1c41e408-15f2-4c83-8a0f-24b46b1ec1c1@linux.com>
	<676733D7-814A-4B66-9E49-93DD1259ED48@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90EAD353731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 17:47:30 +0900 Alexander Popov wrote:
> >I've provided additional details about the reproducer of this vulnerability to Jakub and to security@kernel.org.  
> 
> Hello! May I ask about the decision on this patch?
> 
> At patchwork.kernel.org, it is marked as "Changes Requested":
> <https://patchwork.kernel.org/project/netdevbpf/patch/20260322075917.254874-1-alex.popov@linux.com/>
> 
> However, I don't have any instructions on what to change in it.

The change was to fix the wifi driver.
Please try not to waste more maintainer time than necessary.

