Return-Path: <netdev+bounces-234708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275AC2649F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1DC188FD6E
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B1B2F1FF3;
	Fri, 31 Oct 2025 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MWh0JOwh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAF2F1FCB
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930476; cv=none; b=UNraDkTiiTac7Mbsj9BQWE+6w3bh1Kr/JiQeOBTcbyWe6IxBwb0fIBplfoI0YZwmTbg2iFrhu8FwyORKcRBRfPQga22eEwB+5dZObqW0Pneg79EUmVKov1/Yw2JCuANEctabR9cXcoJlLG51+Vjfq7hYYxT1r/2mbeDXe8kVHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930476; c=relaxed/simple;
	bh=C01l+MJujWzA+l5ACmj/G+LOCIeE0x+IRw6tpegJqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU8MC/EMf9vi71Iwa+2PSvIt4FyoR+O3UqslFKypG/x5eicbx9kL1MxJLrtdgWR5p2nczzSX0g9r542bxmgAWL1xotB2aTShgj2m6MRMMdCWC8Doneq6zA5eErkvt06Q3d5te+eFk4MGeYNDU3yFN+ABmX+hIsBEhqYIcKE9f8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MWh0JOwh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F347AC0E958;
	Fri, 31 Oct 2025 17:07:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F95C60704;
	Fri, 31 Oct 2025 17:07:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC8F511818091;
	Fri, 31 Oct 2025 18:07:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761930466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C01l+MJujWzA+l5ACmj/G+LOCIeE0x+IRw6tpegJqFs=;
	b=MWh0JOwh4S53kkAb5piFTuPod9/R+DKNC0/oycGja0ehBcEGb1fpSHCuQrIuJKxQJ3CxO9
	0NdRKuXltvwk+HqjjqUjjepCDcN7dsHVkHWyPfmy/xDFsv8hRMTshCxwtaIAdHsr+Fl6u1
	cKZJeATxF4yiDKYOp5EZqAfNIWtaDn1zT7MCHfTM+qOaHiqBDhr752eb+EUetabMSaK/Xg
	NMnnLENMLfcFCZoeBFyMWlWnZEe1emMyydoDbDLebrPValUTuE3vhBIYAajVkFPeU0NgWl
	qqNsd1KfOg6YPqLqdxCA0aYOeqkK2yKj6D/GrLTV4LO42zNOrL8pFM5MEvw3CQ==
Date: Fri, 31 Oct 2025 18:07:40 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Marco Crivellari <marco.crivellari@suse.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: liquidio: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251031180740.188a6134@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-3-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-3-vadim.fedorenko@linux.dev>
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

On Fri, 31 Oct 2025 00:46:02 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only, but there is a
> way to get configured status. Implement both ndo_hwtstamp_set and
> ndo_hwtstamp_get callbacks.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

