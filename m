Return-Path: <netdev+bounces-240016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BBC6F400
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 396BF367F57
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318C366576;
	Wed, 19 Nov 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d3GuY4lV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373D364E89
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561597; cv=none; b=EEAmx2ZQUcu1T3LxXNdVCu5BWh905X6Np3Z9qLr2A1QtmKCb8H1S3G1pGBpLjRvbUZCev0+X3ZH1mh788YWbfRKV14wFMrXwipHLRqv7kXx83kKZYOpij94udWLUndWMYL0MQ1j5Dfix5x63EtukSzGmoXRZmza1Ts/v96+Kdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561597; c=relaxed/simple;
	bh=DBTQE9RuN52PfXofXuceUttvDQ0l1pb946oCi2Ei340=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmp92VchRAaGEB1PJURxHcySIl4udxw2nkkr9JX4aOf7I7f/4EGnnVY0TWTAK8zQx5+i4VNlNOoOYcCXkExYjzOsARercCuDyKXiZGBT4dBERDhvRjVnWbG+cR9VvSKkFmG0RNWb9iP4JGoWHsQ74bdPmVmRsuFKe7EhqqnPJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d3GuY4lV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ADF451A1BE2;
	Wed, 19 Nov 2025 14:13:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 821C060699;
	Wed, 19 Nov 2025 14:13:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C23010371815;
	Wed, 19 Nov 2025 15:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763561592; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DBTQE9RuN52PfXofXuceUttvDQ0l1pb946oCi2Ei340=;
	b=d3GuY4lVnjM7AjwJmH/86FzLfaPVN0h9f6s2jkiN7gfNVJjWI0avyse9uONVp17ikLIedN
	OWLDAMFDhifve/OCTqPibFNd9KdW2OBBkSKLBTRiSS+GHWqbKu95OKMHk3uPAd5prLeFcg
	oOEG/xmJn95qZtqCpCN1o/i6RB7f/z1ZODDDBd5YEJ/uN9160eXWzvKH7vEBYib4LJaRv/
	jNJ8mw41IjOZRgKQstMir2M9Hhczee4ygMHO+NQpAACeKY2wT2w5rmHD5/pkswpFHsUI4o
	rCBvA/4C4nZxZr92uVOl+8qsfLxSQiOMucOHrEv2NuJHyfZKXNFYsHlQKD6gkQ==
Date: Wed, 19 Nov 2025 15:13:09 +0100
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
Subject: Re: [PATCH net-next v3 4/9] net: phy: dp83640: add HW timestamp
 configuration reporting
Message-ID: <20251119151309.282abf0a@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-5-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-5-vadim.fedorenko@linux.dev>
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

On Wed, 19 Nov 2025 12:47:20 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores configuration of TX timestamping and can technically
> report it. Patch RX timestamp configuration storage to be more precise
> on reporting and add callback to actually report it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

