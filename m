Return-Path: <netdev+bounces-170157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D3A4782E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ECB188ED9E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184822259F;
	Thu, 27 Feb 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R0edNGQV"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413F1DFD89
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646086; cv=none; b=Qo0vAZhN221qHu4Tvo3pC2I1ghnp+EFCr8CysJgPw3M8cXjvwnR42C/acXU5RC2mcHXtRnhJKX4vxj2TQCBsE5OEWVz1mmc+ibVUgL4TrQd6UNd0qMx7omNaOwitKpGJQH+iYjqvrXbaMCfzzoRuQ7SmhPeC9pUmi+zm7MzZfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646086; c=relaxed/simple;
	bh=zo9eTvQJqKk4YngFI7fy0wFdMOwgkMTRCF1XrKOIRkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/wi2UymBspQ2oP8x25/V3pON4ftMithflUv7AhSKeY9Z8iGAXeEjvePocGVUS9dUUh3cptTd2YhM4WIdkV17kMWfZbq7TuyMpW8raML8UoxbBmG8SOQEYOQxkLaQrdCSWjyxX/7NmOdap1D5ay5Xke2dV/olnJfm+v5bT4DHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R0edNGQV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6099F20574;
	Thu, 27 Feb 2025 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740646082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlMiU8R4q8noHhgTQE/LGM7xtK8nq2FGAAil4AoS9M8=;
	b=R0edNGQVzHQ8jXNZ8hskgKPGE+i64wp/Sp1RItnww8es7Kz8rreOum9iHEjhFAAD55/DiF
	Hi+58u4WhFMu3Kcu65TxecS+/AirHQbZulKtbBEPc1/0zxDFszCF9oN7Y9V8UIeMs4qRge
	XBVoQOR5u5WD1fGGXxKlAjjED2PR89PmtBkHtOpEHq6uBuj0bZyTVaOTxeY20yNqveEj4M
	9Qv7eu4nAAu3lLOP1tRCKJE86WPsfkWhudG5zyjyYpOzgWNBB4KOgwT0ii0X0P69XJ34eu
	ZTzHFodJjcxIMtNMGjpu8peapKyGrJe5i+nDx/6et+05pZxCTlUp5Ev2ZZy53Q==
Date: Thu, 27 Feb 2025 09:48:00 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v8 08/12] net: ethtool: try to protect all
 callback with netdev instance lock
Message-ID: <20250227094800.7ff48a71@fedora.home>
In-Reply-To: <20250226211108.387727-9-sdf@fomichev.me>
References: <20250226211108.387727-1-sdf@fomichev.me>
	<20250226211108.387727-9-sdf@fomichev.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpt
 hhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrggvvggusehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Wed, 26 Feb 2025 13:11:04 -0800
Stanislav Fomichev <sdf@fomichev.me> wrote:

> From: Jakub Kicinski <kuba@kernel.org>
> 
> Protect all ethtool callbacks and PHY related state with the netdev
> instance lock, for drivers which want / need to have their ops
> instance-locked. Basically take the lock everywhere we take rtnl_lock.
> It was tempting to take the lock in ethnl_ops_begin(), but turns
> out we actually nest those calls (when generating notifications).
> 
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/netdevsim/ethtool.c |  2 --
>  net/dsa/conduit.c               | 16 +++++++++++++++-
>  net/ethtool/cabletest.c         | 20 ++++++++++++--------
>  net/ethtool/cmis_fw_update.c    |  7 ++++++-
>  net/ethtool/features.c          |  6 ++++--
>  net/ethtool/ioctl.c             |  6 ++++++
>  net/ethtool/module.c            |  8 +++++---
>  net/ethtool/netlink.c           | 12 ++++++++++++
>  net/ethtool/phy.c               | 20 ++++++++++++++------
>  net/ethtool/rss.c               |  2 ++
>  net/ethtool/tsinfo.c            |  9 ++++++---
>  net/sched/sch_taprio.c          |  5 ++++-
>  12 files changed, 86 insertions(+), 27 deletions(-)

FWIW I've tested that patchset with various PHY-related ethtool ops as
well as the module ops and didn't notice any issue or strangeness.

So to some extent,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

