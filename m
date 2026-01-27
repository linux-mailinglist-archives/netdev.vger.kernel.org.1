Return-Path: <netdev+bounces-254006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IChBEsUreWkyvwEAu9opvQ
	(envelope-from <netdev+bounces-254006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:19:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9629E9AA95
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56BB3020A54
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6708526D4DF;
	Tue, 27 Jan 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2erY5aiw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAB1F7569
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548737; cv=none; b=jUenxrCIuaP/mScE/uG3da3gLWKbvAFdQS8ynMh+zx8b8irFvqkTdh/f2PTk49ERPtsjwX5QYyCGWl2Y1VVlWzBqJizCbLXHsz1RIQbz4HyqiR+v8pDhmzKXOUB2+408Cynyi5UNTkjeVOR4e4K+aWsPETBVBjp+NJ4lWQLu4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548737; c=relaxed/simple;
	bh=oKh31WYt9swOFUQjAfpidAN0Z48fGoWwgmeQ+YQQaoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQcXryGEcpWp6LjfH2hji6ih6tyCT1jgpR8qUt+vqf/geNPTYGC9GtxL4y38io7dQsTm4Km/RVrlYTFfhz6DBiHAqrsu2+3BdFWY3nluukTaWFCUi0HLK64RzjY+SAqqnz7WCF9+55BA6k2BNApfzuYd89tEUCTI/l7cK0IzDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2erY5aiw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C791BC211D5;
	Tue, 27 Jan 2026 21:18:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CADA606F5;
	Tue, 27 Jan 2026 21:18:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34FC2119A83F2;
	Tue, 27 Jan 2026 22:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769548727; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AK/StsI+zZ9Z1l24LQrlmwGbOhhKtFpxOyOKT86nKEw=;
	b=2erY5aiwZNJWJH/rKw0o6nmDe9Cjb4E/W7GmLZzmnRd3fjhozE7zai2p+UpBrTl80wZig7
	YBFnlEcPEofUi0+/lX3/1tET/hlRePUZdqbdnQ/YcxvTXD2/cn8JWi25IDg4o4II/UYzPI
	sblwnMCE9Kh721Pi8l3GyBmw4BRS5NSVrmKA/xMNX7RJOuKlmwWHJBeIly+8cqFT9NViBZ
	qPu8YdOzZIBAMLUfn3xmG1EBuPtjA9/p9NWokXrNbvMjrcfZhqnXUcDEWM4j0s/c5GBBId
	gC3TKiCyI85F4zrMzNrw0/BqXddO29odkM9CGgg3HjF8MvvhZwKwxYOAYOBcSQ==
Message-ID: <5ead844d-8c9b-47e1-9950-3ff1428e1572@bootlin.com>
Date: Tue, 27 Jan 2026 22:18:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13] net: phy_port: SFP modules representation
 and phy_port listing
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127130745.5cc65868@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260127130745.5cc65868@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9629E9AA95
X-Rspamd-Action: no action

Hi,

On 27/01/2026 22:07, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 14:41:48 +0100 Maxime Chevallier wrote:
>> This series is another step towards dealing with multi-port interfaces.
>>
>> It build on the recent addition of phy_port representation to enable
>> listing the front-facing ports of an interface. For now, we don't control
>> these ports, we merely list their presence and their capabilities.
>>
>> As the most common use-case of multi-port interfaces is combo-ports that
>> provide both RJ45 and SFP connectors on a single MAC, there's a lot of
>> SFP stuff in this series.
>>
>> This series is in 2 main parts. The first one aims at representing the
>> SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
>> by far the most common cases for multi-connector setups.
>>
>> The second part is the netlink interface to list those ports, now that
>> most use-cases are covered.
> 
> Some config-related build unhappines here (kunit hits this):
> 
> ../include/linux/phy_link_topology.h:110:1: error: return type defaults to ‘int’ [-Wimplicit-int]
>   110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../include/linux/phy_link_topology.h:110:1: warning: no previous prototype for ‘phy_link_topo_get_port’ [-Wmissing-prototypes]
> In file included from ../include/uapi/linux/posix_types.h:5,
>                  from ../include/uapi/linux/types.h:14,
>                  from ../include/linux/types.h:6,
>                  from ../include/linux/kasan-checks.h:5,
>                  from ../include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from ../include/linux/compiler.h:380,
>                  from ../include/linux/build_bug.h:5,
>                  from ../include/linux/bits.h:30,
>                  from ../include/linux/bitops.h:6,
>                  from ../include/linux/bitmap.h:8,
>                  from ../include/linux/ethtool.h:16,
>                  from ../include/uapi/linux/ethtool_netlink.h:12,
>                  from ../include/linux/ethtool_netlink.h:6,
>                  from ../net/ethtool/common.c:3:
> ../include/linux/phy_link_topology.h: In function ‘phy_link_topo_get_port’:
> ../include/linux/stddef.h:8:14: error: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
>     8 | #define NULL ((void *)0)
>       |              ^
> ../include/linux/phy_link_topology.h:112:16: note: in expansion of macro ‘NULL’
>   112 |         return NULL;
>       |                ^~~~

Ah yes indeed, silly mistake from me but wasn't caught by running
./ingest_mdir.py locally, I'll increase my local coverage with a
defconfig that triggers this.

I was so focused making sure the various combinations of phylib et.al.
being built as modules or builtin that I didn't test with PHYLIB=n :/

Thanks for reporting, I'll address that :)

Maxime

