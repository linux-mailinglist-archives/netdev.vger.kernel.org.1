Return-Path: <netdev+bounces-294526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RPLtNGKUH2qTnQAAu9opvQ
	(envelope-from <netdev+bounces-294526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:41:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A8633AE9
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:41:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Wi4ymjTG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294526-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E0C4301A2ED
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD93DC4B1;
	Wed,  3 Jun 2026 02:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD563822AA;
	Wed,  3 Jun 2026 02:41:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454491; cv=none; b=D4w1uu6QkJzuc9ZhHJL1nfuSYUHKc32fmsyNi2JVWx95sfxl3AShvfuOWtV2ZxTyNKjRyvDf6xgzzJOBBQhKt64NUmXSHsiU83tFVVzXNG8gLBXnBNIpSTjBHM0erIFhBsmpGc7lQdwOeNzksnqrr7TjEoGogILxXr86pbbJpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454491; c=relaxed/simple;
	bh=SvFxDoSmTme3bag0LC+3wu3y0fsNiyyEDYrRWLDqLMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdg6qjk1YQKkM0sxnoAK9jgIktcJ3/fLVgCA45Qlqljgg5eKfeXSOZWS6PQZjCPvE/2tuBDdI71tnDFBW+iw32nrvjH8P+fK2sGXbwJvmmKbz+w2b0nxr1bFSPJsGyUQfMNFi9LBEbwW+LhqSXNOwBnKj9Ve1BmaSCHHbZMd7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wi4ymjTG; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D37xiTtxF0fUm4ed9JLFHPGoRO7k+Z17+W07ncHTMTA=; b=Wi4ymjTGgcL6Ix7S3gtL1OKlPx
	KA4C5pr9335Z6phBWyyaPL+5LzUJIMLp0xmFaSPnX04ukvu2fkHfNjv6jzf2/kqJZ8wNJQBTWsxyL
	Hna0AAGbu9fJYTdWFbtXtOLTEbOcHSnmQvnudP8Wtu91I9a1jJADImoMs+XhBCaNewvY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUbXd-005oLe-LW; Wed, 03 Jun 2026 04:41:13 +0200
Date: Wed, 3 Jun 2026 04:41:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
	Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <72af0cfc-9011-4713-9862-710eea5f1cb0@lunn.ch>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
 <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
 <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294526-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedricjehasse@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D53A8633AE9

> We could add (e.g.) bridge_setup_tc to dsa_switch_ops, which (in the
> mv88e6xxx implementation) could validate the bridge contained all
> user ports. But it would not be possible to block a port from
> leaving as port_bridge_leave cannot return an error, and tearing
> MQPRIO config down silently would be a different sort of bad.

There can be multiple bridges, even as far as one bridge per port.

For switch wide properties, you basically have to allow the first user
to configure it, refcount additional users get added and removed, and
only allow the last user to change it.

The alternative is return -EOPNOTSUPP, and let the kernel do it in
software, if a user wants something different to the global
setting. The hardware is only there to accelerate what Linux can
already do in software. That is the model we use.

     Andrew

