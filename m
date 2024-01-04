Return-Path: <netdev+bounces-61608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE96824650
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800DDB22655
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCC24B4A;
	Thu,  4 Jan 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="FTyUdv28"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6025569
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from dellmb (unknown [IPv6:2001:1488:fffe:6:77e6:9a62:bbd6:737f])
	by mail.nic.cz (Postfix) with ESMTPSA id DE9561C192C;
	Thu,  4 Jan 2024 17:27:09 +0100 (CET)
Authentication-Results: mail.nic.cz;
	auth=pass smtp.auth=marek.behun@nic.cz smtp.mailfrom=marek.behun@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
	t=1704385630; bh=vGuC8fgzQXJqD3mm0d1shrJjIFAnRJitIuTfRNQneQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Reply-To:
	 Subject:To:Cc;
	b=FTyUdv28LLcxp8uESmJ5BEXUHZf8Et8plKHxMkjL0GyBz2mY2ImPQ8DtAyyZNUsMk
	 AoaAyUXCAXV/jQyO7ihsPmUEjxtOpk8TGGl3LuC29KMfFuR9PIEtBnEoJ5NSWlCOz1
	 USHkg9DGuO3yzz39StrhOIKITF+HYJhR5mRvw7yk=
Date: Thu, 4 Jan 2024 17:27:08 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and
 extend struct ethtool_eee
Message-ID: <20240104172708.2db5ddaa@dellmb>
In-Reply-To: <a044621e-07f3-4387-9573-015f255db895@gmail.com>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
	<a044621e-07f3-4387-9573-015f255db895@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.10 at mail
X-Virus-Status: Clean
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: DE9561C192C
X-Spamd-Result: default: False [-0.10 / 20.00];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	WHITELISTED_IP(0.00)[2001:1488:fffe:6:77e6:9a62:bbd6:737f];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com]
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Spamd-Bar: /
X-Rspamd-Action: no action

On Mon, 1 Jan 2024 22:23:15 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> + * @is_member_of_keee: struct is member of a struct ethtool_keee

I don't like how the name of a field in a UAPI structure refers to
kernel internals.

Can we rename it somehow?

Marek

