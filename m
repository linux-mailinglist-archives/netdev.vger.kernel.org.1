Return-Path: <netdev+bounces-242534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F7C91854
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A36D63488E7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A430595B;
	Fri, 28 Nov 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yFzIQ0wk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D5221FB4
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323500; cv=none; b=Mj6xvFsA8iiUyFZOLDRmu/1fZj1f5qjOfRIRjBPo6soeVjVwdpm5+V9qz0p/Zy42wa0Mf6vEqj5MOT7byzlIrv+VMgQr/+zKSH4LZcpc1tn6A/XOc3JEWhsN+yGwc5uMsLS+TCApJdyG/xDxiA0RLcfO0wyn9NizwCDwIoWXo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323500; c=relaxed/simple;
	bh=odzTHlijMLG0bJxyfBsRDDehTCUltc0U8WHuZbFqIeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOz55oI3nB0q0q+mosEIuTwkPPk67EcGMM0Fup/wqzJF1bxiXgCe7aG9hvWuXfPrDHJ3ebxu/Kt84O9nR3N0aoonyqq/EfADqDSlCyvsKrGZwNxYFW1KMqhZgU/Eyi4KsURlqWKMxWXLHwGWwetybjYwHEL7gTsfbiGbkp0ypck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yFzIQ0wk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 12EBAC16A38;
	Fri, 28 Nov 2025 09:51:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4C4360706;
	Fri, 28 Nov 2025 09:51:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 572B5103C8F71;
	Fri, 28 Nov 2025 10:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764323496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=odzTHlijMLG0bJxyfBsRDDehTCUltc0U8WHuZbFqIeU=;
	b=yFzIQ0wk3fzmpNY/g31TZl1MsoAmqmaQ2NR5W2wr9PjnY+0x+SefsJKZ8qmIx/JmRgpgxg
	SDX9kXDkSsIiaGt9cYxcvnEvuf0MQ/oay5wjkxBWHIcLtREWMFIjaSFKa9eQtN7bR18rrB
	OdHazDZ5RL24IIiOUhL2HegYWGmmNDs4gw2faxuWGAJxgsV1Eb5Eb+8AO+c7D47BQjWAly
	Y3VBKUoKFfCvXPYTfACAnOzNufLJoBhNvYjqKQoUmswA1O+Eg2QVVE4mxPv81OXyLP181G
	VwljQcPJPAFckDxHpIlc3cEjXHJhB4ABkyLX15UnrRD0vTqhG5tBYDFFGl+H0w==
Date: Fri, 28 Nov 2025 10:51:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: phy: microchip_rds_ptp: add HW
 timestamp configuration reporting
Message-ID: <20251128105132.1607b4d8@kmaincent-XPS-13-7390>
In-Reply-To: <20251127211245.279737-5-vadim.fedorenko@linux.dev>
References: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
	<20251127211245.279737-5-vadim.fedorenko@linux.dev>
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

On Thu, 27 Nov 2025 21:12:45 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

