Return-Path: <netdev+bounces-239999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 518F8C6F173
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A4B0349C05
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94135FF6C;
	Wed, 19 Nov 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a8a4xmrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988C3557FE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560233; cv=none; b=IRiaAgo9iNgFP5bH3/Z0MoRmNecPgulAwjZBf8DQQzrKVoYsHD3p0Qnde188oJo3KU/tsn92bye0zHcb+/D2sWYW41o/5ETR2flvc7tEOdzshlooBq+uhNHTSEos6SicSCFruW0JlEt1Al8Rua9jFXJwYqDUBcDkyS50dUMh0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560233; c=relaxed/simple;
	bh=rC4b9BwnLMbuU6/Bt66vkcwMTBq+TjDi1dDyp3cEDWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKZILHnkD/Jto452C5VSi9kNAcJLsx1wlwtHQZkTpPD8g8e7wC6QBuHNDHt99tWL1WjM9DU+FrKxUgTei/OAwTgVyz2A1k0vpvV3nPw9Ry8xVNc9H9C2n6q0czsA+XlGKk0kw9b1TUCQ8nxez7jxlWmELXos4xkKtBdT5oWetnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a8a4xmrQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D470EC11188;
	Wed, 19 Nov 2025 13:50:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1009560699;
	Wed, 19 Nov 2025 13:50:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17D011037165D;
	Wed, 19 Nov 2025 14:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763560227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rC4b9BwnLMbuU6/Bt66vkcwMTBq+TjDi1dDyp3cEDWo=;
	b=a8a4xmrQ/O74uqrDByWv9onj9aRteHrV2naKEWLR3MgGiR46WZ9YiTRYKYxk3zDEHwKw1u
	fSoTPh0M+ToNGU0zVdT9UHWSChhda/5EFv4tFb8OY/xwYIOv7o3zkTi5hrdVVTSZTvQvYk
	vj4lcBpqm0DOIyFJrwHMEAZ5JW/MS4KCYApU7e9SjCJcyLIdprGZDBzQ1MfEXiSqfvZhSU
	JBwBVUD/7T5DaiBT0hyPbTnmfn8PInIc/T2zAk/D+aFHSA2tgBGGJVuv9SbnmHWHLn2Hek
	1sKr5qqV9CtVW8j5jMU4Z6ZdZCKd/HuX4oMs2bCdOQ2cqGH20EXzQPb4uqyk1Q==
Date: Wed, 19 Nov 2025 14:50:21 +0100
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
Subject: Re: [PATCH net-next v3 1/9] phy: rename hwtstamp callback to
 hwtstamp_set
Message-ID: <20251119145021.762b57df@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-2-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-2-vadim.fedorenko@linux.dev>
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

On Wed, 19 Nov 2025 12:47:17 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> PHY devices has hwtstamp callback which actually performs set operation.
> Rename it to better reflect the action.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!=20
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

