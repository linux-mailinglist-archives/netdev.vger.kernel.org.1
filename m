Return-Path: <netdev+bounces-240066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC48C6FF94
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 83F422F550
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F436E56E;
	Wed, 19 Nov 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVVXXqjx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75A327BF0;
	Wed, 19 Nov 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568674; cv=none; b=nusjTgzhwkJQSFcQBNszrSM9KrPUbP9oR1fDa4K5ajsN3FjNlAB/WqTJ6y2AGFtxQUKwuZjL+c49sK0r83vT/chSyywgsYYjcfvh7epAHc3uuvxzfeYNnU9CkxEmihxBDnJqch4BEhZI0inkhLY6NzIjI2V4B+z9p9uPYYtBhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568674; c=relaxed/simple;
	bh=nalrBXLRCj1IXKAJ2EfjsoQkKc4obtYG0Cbt2JrKgBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dANdQUTBdNMKKk/PwJV37J334EB3DVBdyA9U6kZKtb4OpNzBj5f8S2DgPfOgt7Dz8wO5N5d6jrVEnDFNkEvnRVAjcd4ANlWDKDO1TcXL4UHt6uYxawBZI8H5wErUHvmZ/Rdda2x2elv+vgXnfTgCiwe200cqRPeVI7lZlfu2zAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVVXXqjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3367EC113D0;
	Wed, 19 Nov 2025 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763568673;
	bh=nalrBXLRCj1IXKAJ2EfjsoQkKc4obtYG0Cbt2JrKgBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVVXXqjxoA5dPwUyudVvoEEQ5LnSM7ktQCRk/6PhuPG/kKrq85Q1apPB1hVS5hT2D
	 JBFboEq/7oB7eVfDhiWyh1XSbiP2P0thMtvjT19BJGqfabfaS4fJhtcJ/QXgWerfFH
	 Azoi3cFP7PIVZ5NwKPTCJio40Cuw+WKyy7BCrNBTXWbsINt4YzOeu+14Sreal84g0g
	 N7oePqMGUmK3D2vcM6qesLlxD2PjPr/BaxGZksO8tCkB/yOu4uNdal9iqdAZahLPUZ
	 tvcljOz1Mwn5suETX05W3drJlJM3FC2HZ+CtRUAPDMVk3hJNi6oiU/VqcuZkvBTzFe
	 AHL3QoX5e1gIg==
Date: Wed, 19 Nov 2025 08:11:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Serge Semin
 <fancer.lancer@gmail.com>, Herve Codina <herve.codina@bootlin.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251119081112.3bcaf923@kernel.org>
In-Reply-To: <20251119112522.dcfrh6x6msnw4cmi@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
	<20251118190530.580267-15-vladimir.oltean@nxp.com>
	<20251118190530.580267-1-vladimir.oltean@nxp.com>
	<20251118190530.580267-15-vladimir.oltean@nxp.com>
	<20251118164130.4e107c93@kernel.org>
	<20251118164130.4e107c93@kernel.org>
	<20251119095942.bu64kg6whi4gtnwe@skbuf>
	<aR2cf91qdcKMy5PB@smile.fi.intel.com>
	<20251119112522.dcfrh6x6msnw4cmi@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 13:25:22 +0200 Vladimir Oltean wrote:
> I think it's due to the fact that the "contest" checks are fundamentally
> so slow, that they can't be run on individual patch sets, and are run on
> batches of patch sets merged into a single branch (of which there seem
> to be 8 per day).

Correct, looking at the logs AFAICT coccicheck takes 25min on a
relatively beefy machine, and we only run it on path that were actually
modified by pending changes. We get 100+ patches a day, and 40+ series,
and coccicheck fails relatively rarely. So on the NIPA side it's not
worth it.

But, we can certainly integrate it into ingest_mdir.

FTR make htmldocs and of course selftests are also not executed by
ingest_mdir.

