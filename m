Return-Path: <netdev+bounces-106787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08552917A22
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A63CB24227
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B437415DBB9;
	Wed, 26 Jun 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RCY1p6OT"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF613AA3C;
	Wed, 26 Jun 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388345; cv=none; b=Bx4kwSaQWhWQofa0+mawNaXSkdwC2dR+yycKWnP0eXE4palOvaclP4GqiKx3XLsfJ7iJ1wTrSKlkRUqJiG/O6QJO0wHRMc1r6bSJAvU14MScESgIAsXfRGTJA3zV8zaKQYvV4KGXaWWhAwjMadT0iEe1iOrYq3MMp3WJoPs2q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388345; c=relaxed/simple;
	bh=POJ/u/JgXBX8t3iQ4KlfSi1NfhYEUKiZQDAVmdoCB18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8WPRAXXBQum8UdTBuP+JjlY+knlg+cGfsgxuwEgWp03XfqIPCIM0HYMZ7/wfU7NAZb8dBfcUH/r83RVe46JhSWhz1s4Up8VpPLg+hZ/a7dKCJhTh13bwqNb6DYRDLG7iHfDjvdtsaWJiq4eVH5LmE5UIpMV5d4pp+vDE1Vrjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RCY1p6OT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 280D5C0011;
	Wed, 26 Jun 2024 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719388335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hkxAP8PstPJ4kNCzedalLqPf8+A/v76ianDWIczc2U=;
	b=RCY1p6OTYCVjKjMC44vUWJIrbLh36YaCQi12tvgF8yEaLU79b2WI+nNjbk9rvaIBWEKWNI
	rvGPwKO2sqIY6PrdokUx+xio4K3W5S3LncJKcon8hBttSJNcTWien5Dt+8A/mkjLbUc1BO
	U7fA6R18o8kA0qIEg6JhNcS8GvlRQlqOVB4d6SQxdWCgJw6wSIlEWwlBfDjoPtI0WeH2Bf
	iahwRXz835oAGVtm1DFG689eG0BSceC9nvXQmnkaGNVSFfBp/091gLgTOYoZe9acwf9xcQ
	TQPa2IQo4okBlo57bumKD6Uj2QTolJuUfxMc3by4ZzOM312pvhCWAOiJ6PHPbg==
Date: Wed, 26 Jun 2024 09:52:11 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] net: pse-pd: Add new PSE c33 features
Message-ID: <20240626095211.00956faa@kmaincent-XPS-13-7390>
In-Reply-To: <20240625184144.49328de3@kernel.org>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
	<20240625184144.49328de3@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 25 Jun 2024 18:41:44 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 25 Jun 2024 14:33:45 +0200 Kory Maincent wrote:
>  [...] =20
>=20
> Looks like we have a conflict on patch 6 now, please rebase

Ah indeed! In fact it conflicts because it is based on this patch which is
merge mainline in net:
https://lore.kernel.org/netdev/20240621130059.2147307-1-kory.maincent@bootl=
in.com/

Do you know when and how often net-next is rebased on top of net?
Sorry, I should have checked it before sending this version.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

