Return-Path: <netdev+bounces-270761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNr4BS+6wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:09:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907752FE16F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29F33032766
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2237F8A6;
	Mon, 23 Mar 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyGPX9A4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3F37D115;
	Mon, 23 Mar 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303711; cv=none; b=hIH/FibBhNSclW1NlVIkl9x2HIEwl1Aw+/6vWn6pOuJiP/ZMTOmgg4jcRWVfJkCaRX7Qu2na/sdbGj3negUv6h7+88VryE96uT+lSpdJBExkwQ2eXfZz96w6DeXWUEUHen+BkL6aAm2xOSSnCUMszOSKAShuUE4AdYJsygddriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303711; c=relaxed/simple;
	bh=c0p2QEe2Sq61Pz2ATNi+TTJiEefdADCE/IB9BOiSM88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfMwA7wHG2W6KeDezUdTf4U+8DkjWlKWbx0pBFnSI+MaKcl9F4158FDYsjSyEXXPZYIKnbaZLAh+6pwUAsVyUcll3KHIBQw+ohDDcXD6UaTO+fANUfQNR0rM05pc47jalNn6IczB67gBmEbAMqzAAdziUCaLVARx6tRVtnUR2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyGPX9A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85908C4CEF7;
	Mon, 23 Mar 2026 22:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774303711;
	bh=c0p2QEe2Sq61Pz2ATNi+TTJiEefdADCE/IB9BOiSM88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WyGPX9A4r0fWp45da0FJFFNScJkMBfVIAyaApNH3wxUQwp9uHNZp35xA9iz1JimoV
	 uzxkM0Kiwqc0r3OEqy0utC518acfeyTO3XrUaUHpniTvEcJhEd4D+/IOymJcuwmF+5
	 4lQhcjAksj5GC1r9UEdTsEHI55NokNYr93tjyRJqUfFkd1wHzeX9fZJNYoTb6SgvRY
	 zkj8IzeI+u3TnkMGMZSUYEmZVrxLk7Hua5tRowtPPM2y1xnrrBxOCPHoDyltKPOKcS
	 W2VPs/6hnM0wu0fFN5xgp5wHZcVy6e5WkC+XlV/tpnlFxylq0JIAqng7Xq7uTWQJ16
	 rX4803LA0pWWQ==
Date: Mon, 23 Mar 2026 15:08:27 -0700
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
Message-ID: <20260323150827.24a6259c@kernel.org>
In-Reply-To: <eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com>
References: <20260322075917.254874-1-alex.popov@linux.com>
	<3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
	<eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270761-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 907752FE16F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 02:08:53 +0300 Alexander Popov wrote:
> Hello Andrew, let me describe the scenario that I see:
> 
>   - The netdev_run_todo() function handles the net devices in net_todo_list
>     in a loop and moves each of them into the NETREG_UNREGISTERED state:
>       netdev_lock(dev);
>       WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
>       netdev_unlock(dev);
> 
>   - Then netdev_run_todo() frees these net devices in another loop.
>     On each iteration, it chooses a device for freeing:
>       dev = netdev_wait_allrefs_any(&list);
> 
>   - At the same time, the ethnl_set_features() function calls
>     ethnl_parse_header_dev_get() for the child net device.
> 
>   - If the race condition succeeds, ethnl_set_features() takes the reference
>     to the child net device being unregistered. That makes netdev_run_todo()
>     free the parent first.

That's not sufficient detail. ethnl_parse_header_dev_get() is under RCU
and unregistration does an RCU sync after delisting the device. Also
not sure you're distinguishing struct net_device and struct device.

How did you hit this issue? What are the net devices involved?

