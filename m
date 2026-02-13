Return-Path: <netdev+bounces-258653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePfuGDNZj2lxQgEAu9opvQ
	(envelope-from <netdev+bounces-258653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:02:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE7138742
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 913A63023E1F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B682E11A6;
	Fri, 13 Feb 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oCn7Opcd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA42286A9
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002158; cv=none; b=qF7wA0Xk6lSyF212/0IR138gGfeoQoEwin5DHjkD0a5nBYzKLavX11fotNAO+LbQFILxfU6luN4MNqp0eZpZPNTvNKzQuytPXC8ydF50pUF/YM6sFXZLnM2Au0oHh8N4kXbP1QdDFVEU6S6bQJmwvFNF6pIHlJYLlYd2KATeL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002158; c=relaxed/simple;
	bh=0o09gqHf6Kt4/xJ5vSwX+VtvE9XnTacvGWxmm2JpxGo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IdbcPTmrk+ae/WPdISRQ+ifQTLBYIl2Ec4rEgdHs6JLjHzdedZ9OochqwjEGhbwFEzv0jeT3cltPe+IusGFDdxFjjyysn2CBADqLeBwqzhAeF5akJwBUJAtV9Y6H8WfI4HUYp8L4IMpwCszPUf4SaECj+SnYIyQ4/Q6amkQ+aQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oCn7Opcd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 88D171A0EC0;
	Fri, 13 Feb 2026 17:02:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FC9F606BE;
	Fri, 13 Feb 2026 17:02:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C305010368F15;
	Fri, 13 Feb 2026 18:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771002154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0o09gqHf6Kt4/xJ5vSwX+VtvE9XnTacvGWxmm2JpxGo=;
	b=oCn7OpcdH/1DiNbPJn8McJaT1Ju8snGJg4UxUMthUaay9bmBwVx7HKR8dvXBXdl101NheZ
	NwgO2sydLNb+P9yjF8RSILMoKmnvyHegIfthhVYG6YzotwUukDw3n5IrwIlF83fvTYf1c5
	w1QeemY9iEZnJVzRl5Paq07Ea0XJPjJxtyLqFJxQy/hifi6+cNmdG4E1oNDPkM/LKX6Gd3
	CgJoZDnmHRCQtc2GdU2q+cQJS8/2+ZBpizwYxg+3Xf8osmqgopapp3RhuWBaO1iUaYvmKs
	Q73QEq24pITsH/tCBB/70Et6El0oyxkfQ8ZbViBAbVA5H2Zw3yrbi5deSgGxbw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 18:02:32 +0100
Message-Id: <DGDZV94A0UWE.A2JXDGRBZMKK@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com>
In-Reply-To: <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258653-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0BAE7138742
X-Rspamd-Action: no action

On Fri Feb 13, 2026 at 5:57 PM CET, Th=C3=A9o Lebrun wrote:
> I'll send them as reply to this email.

Not using b4, I had to make a mistake.
Patches have been sent as a reply to the wrong email in this thread.

https://lore.kernel.org/netdev/20260213165759.225449-1-theo.lebrun@bootlin.=
com/

Have a nice week-end,
Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


