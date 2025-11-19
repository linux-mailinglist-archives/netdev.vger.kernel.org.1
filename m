Return-Path: <netdev+bounces-240033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21233C6F86D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80A84FDFFD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504652773CB;
	Wed, 19 Nov 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gn61vTvE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8D27CB0A
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563847; cv=none; b=e1uFSgq9Z15LUT3skSx9YO07O8DISoCztkFcdmQnavNrWD7V7NL3RJZFBKlCzDmsA4v1LOkMXss33RJmPL9CnC5M1R/y83+KcF9DBVBRGFI6yjLjvLhmdn+6jo3xhFIslNyhE8ymdFSTW4DsZ3dUXYo+0SqdwEChkHyyHNWjnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563847; c=relaxed/simple;
	bh=qmidgmVmoOpLWFerYaSqb9o6YIpAU5KTbzeAOR6nOZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+ewER15GUMLzoDvfYxNG+S7nIlYr/Lb6Ni8Pg3dUrwqkI40muGAsCVhBm4TXKOd0bDXxAe/E8Ld3rcf5aLK8QpX+RWJn+2j8vT3+BChzpGqLgWE3MmKhnHpzse/44zaYryI3i/DrYJ237/ND+73W4PucIrNMUvLIZillE73w2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gn61vTvE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 20DF64E417A6;
	Wed, 19 Nov 2025 14:50:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB90560699;
	Wed, 19 Nov 2025 14:50:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FD9410371A78;
	Wed, 19 Nov 2025 15:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763563842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qmidgmVmoOpLWFerYaSqb9o6YIpAU5KTbzeAOR6nOZk=;
	b=Gn61vTvEaqpqZlaHlEuSsiZ5ry+cSlvEWYFAbAn9iXo5MmhRPCaIaUNpZtZrqDeurAh8+7
	SVwaghLpNWUlOcV9NoXeZbhmgIdVU0uJxznDEv5AxFnYcjvicNpkNz5akxMgkmV61AM5Kv
	GeihNIAAlUYTii/44tmR8wGRUUvpBwrUiXqiFR23DNzRilinkzCC/bZ9kExVW63obbw1Zv
	iN0iih0UMEzJLNLrnsSjLR/52PIpBdI3iNnKairlzB9BlhTo0/yroVPc3LwLbRBshm1acy
	tzFULQHrnhCo42ifd3iTRWCGjG70I2iAnqzFGiGJ2unskN0J43A7VTPRrNic0Q==
Date: Wed, 19 Nov 2025 15:50:38 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/9] net: phy: nxp-c45-tja11xx: add HW
 timestamp configuration reporting
Message-ID: <20251119155038.03ded922@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-9-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-9-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 19 Nov 2025 12:47:24 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

