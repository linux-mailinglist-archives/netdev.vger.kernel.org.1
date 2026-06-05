Return-Path: <netdev+bounces-295842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uRKCBgHjImpIewEAu9opvQ
	(envelope-from <netdev+bounces-295842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:53:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1608649052
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:53:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=qrrbZZkI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 601BD30F2CEE
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C53FB05D;
	Fri,  5 Jun 2026 14:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBE3F484F;
	Fri,  5 Jun 2026 14:44:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670667; cv=none; b=OX66Y8xf98ZQkwc5lBTGq9TzoBI2QuWi/q0rbv/Lq4f1WgeZ7Lca6NRAX/mZUrfRjwaQyB4UwBLNLJcagmXAWETgezWFz1zwFA21bLc3dd2QCQMgaqyN45I7dwLkPpCNtsJExFCyln0KnnLTnfc4v3/6+sv0qrpXI349QWrLQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670667; c=relaxed/simple;
	bh=LLk8lAmCSxgIzY9HoplppWLM8UXBZjCgLxPFWBKuVHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piQG9KzlyUZ9FdRulayvS+utVcjmBHwA34Geuea68FRhxb8yE+c4IF32TTICNZ4ZclykbNr5j4l2VepVLYi27dmgGiffxLU2cF90MZguoJm8cB83jkvVfO3oNnM9ti4yXeJ9l1gclFqLHcKZWE8+dX815br7bbq5pzYwLXmMx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qrrbZZkI; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fWHx7+MVsgzwFnsle7wi9uaks6IqoR68tVaYykBpZqY=; b=qrrbZZkIw1cUqdPOjnuUFYjWxO
	zFxfADIZ7HOvb2D9LMoYPmpXGP3W6IoeiIeNo0OOgkeXMMFgDHEbfLyXDAapOyr7NuZGxV3z2EKCg
	nJI5vRe4NpWZxadtqZJLlOtzV+EsO1r9thI7DzruRQI603A40et0F9mDKxvcc1B/ZVQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVVmL-006FK0-6g; Fri, 05 Jun 2026 16:44:09 +0200
Date: Fri, 5 Jun 2026 16:44:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
Cc: Luke Howard <lukeh@padl.com>, Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
	Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Message-ID: <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:lukeh@padl.com,m:razor@blackwall.org,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedricjehasse@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[padl.com,blackwall.org,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1608649052

> The issue here is the Marvell switch has an implementation where we need to
> know if an entry is a Dynamic Reservation Entry. But the linux bridge has a
> simplified version of the FDB described in 802.1Q.
> By adding a way to distinguish between the type of FDB entries, it's possible
> to program a Marvell which has this distinction between Dynamic Reservation
> Entries (or AVB entries) and other entries.

So it sounds like you first need to work on the software
implementation and expand the simplified version with the features you
need. You can then add support to accelerate this by offloading it to
the hardware.

    Andrew

