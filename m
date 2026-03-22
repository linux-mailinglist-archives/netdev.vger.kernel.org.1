Return-Path: <netdev+bounces-270310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOqYNWD/v2lpCwQAu9opvQ
	(envelope-from <netdev+bounces-270310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 15:40:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D72E9B35
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453C93009B29
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE936405E;
	Sun, 22 Mar 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yQjf+4KH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039521F03D2;
	Sun, 22 Mar 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774190428; cv=none; b=IKm66SWVoY25yV0uiZfjT8NmJllBsTsaJbFMVkBsHvvIgZNmY+ZmYC0iIsAoxVo7/ZSNrX8T5n1IpxFczPhryWyhSL0bRJGqwg5A9Z0mofs+scAvS3438EdvWdOPJBz8d9gpDhQUJ8nVq2gGXUXqIlbYsxnCHx0vCiCjtGvtOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774190428; c=relaxed/simple;
	bh=pG1GaXqXdRepwp8m5rgZzHiIIXYsp832iVl9ZhQ5OsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgIACPX4rVBjVUK0st1zxUrsVRvFWh0gQt3G7gVCOUxUouVcZ8pcfaZCqI8g4UFn7szRLYB3Xp74WkiPkCbJpR05AFih3thHbKAo5C7vFeBtsfvJRRHusGGEfhL+Xjnc7KZg4gfAkIDlbsgZD0JM/ofmKH5J4FiJqbn1FQ/GbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yQjf+4KH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9+efNICYa6Qt0cdjCzn/QXdb/0qRox6mNmwXvwb5OQk=; b=yQjf+4KHEA0wt1g7TRX5mfVL77
	GCVvnZFYKvbFiqc2z3ViNX8K6HIMv6wIp7K98OGSNksuImFqgzrOEhTXcH0eUI/t6gngXXRhJ7+hK
	gMuxFCnYabb3HDy+vdy/HJvqvkio3zU/XKpqh5Yp5SwKM3YQUUZK0+d15PkAZdaM1Xck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4JyB-00CovP-NJ; Sun, 22 Mar 2026 15:39:59 +0100
Date: Sun, 22 Mar 2026 15:39:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Popov <alex.popov@linux.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	notify@kernel.org
Subject: Re: [PATCH] ethtool: don't touch the parent device of a net device
 being unregistered
Message-ID: <3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
References: <20260322075917.254874-1-alex.popov@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322075917.254874-1-alex.popov@linux.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 863D72E9B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 10:59:15AM +0300, Alexander Popov wrote:
> The ethtool operations may be performed on a net device that is currently
> being unregistered. This is also described in the commit dde91ccfa25fd58f
> ("ethtool: do not perform operations on net devices being unregistered").
> Moreover, such a device may have a parent that has already been freed.

I don't know the device core too well, but can you explain in the
example stack trace you gave how the parent can already be free? I
would of expected devices are arranged in a tree, and free happens
from the leaves towards the root? In order to do a clean shutdown, you
might need to perform operations on the parent.

I just want to make sure this is not a broken parent device which
should be fixed...

       Andrew

