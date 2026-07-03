Return-Path: <netdev+bounces-304480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /uMgGTaNR2pKbAAAu9opvQ
	(envelope-from <netdev+bounces-304480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:21:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EDB70122B
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:21:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HKxugvqm;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304480-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304480-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E718230011BC
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648673B19B0;
	Fri,  3 Jul 2026 10:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906737E2F9
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073444; cv=none; b=ccNe2PIyblIzUgMy/A5SLjvZLaTbuzwJ80ACfBKaHMJY799BFfP32FVjZ/waJi+MNHXaTBme/a5tKrI2AG+6BwpytD804oM2rSWgnk180vpuR62YmCMy5Z+4BlRjosimc0IQc7BDTEp9TvzX36tlReBTfibeDOKd/9Xl9ii9lHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073444; c=relaxed/simple;
	bh=KUxpJqYYa0VhNofPWE55WEfT0pzSsC+tc3Iw1yJfJ80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgalOGqzCGKPhRoVCRyHsEU5fu9btq6lQjbp01IAqDV4LJ2ppOONGVd5unruShzenVimrxwT11TAtEbCfnxbCFyOvirK5wbivl/uYrkGRzXnlrFtzNwlPYO8alJ+kE1lpTpyXmTogq5xcEd0ppTTt0kC4F+4X8k4+HLuq08IBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HKxugvqm; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30A8BC79ABE;
	Fri,  3 Jul 2026 10:10:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50ABA60300;
	Fri,  3 Jul 2026 10:10:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAB20104C8399;
	Fri,  3 Jul 2026 12:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783073438; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KUxpJqYYa0VhNofPWE55WEfT0pzSsC+tc3Iw1yJfJ80=;
	b=HKxugvqmlXpYp00MdUMi8LdjB/ut+8I3zFW6xoA9fpxouy34H7l4QeEH1BXYeBOE7FxOE9
	NjQNxmrt6ulvJwxDl30gHKLWJVYbXabaScEloreVGrP+rikqz0/W84cCWMSgkEV6pEPH35
	YSkiOVtvZQmbC5WBMXXMIgbrS71E0PZqMzeP+NCrWcFcX93tadIRVjAQ8A9tfIXM1jxKaI
	SuX6hqE52+3qO6W2bu5QjqYnXPsI0GwvUwtlbNS6AaqWB2b7Uy3ZgKjnQYUoT9jbq9quM1
	lf/0rDB21QVeASXPQ/PTNk8FNmD5by4w2OLHa48KLXakvZE970v99pA5YSpuJg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Manikandan.M@microchip.com,  krzk@kernel.org,  pratyush@kernel.org,
  mwalle@kernel.org,  takahiro.kuwano@infineon.com,  richard@nod.at,
  vigneshr@ti.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  srini@kernel.org,  Nicolas.Ferre@microchip.com,
  alexandre.belloni@bootlin.com,  claudiu.beznea@tuxon.dev,
  linux@armlinux.org.uk,  richardcochran@gmail.com,  linusw@kernel.org,
  arnd@arndb.de,  michael@walle.cc,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
In-Reply-To: <20260702163723.GA227454-robh@kernel.org> (Rob Herring's message
	of "Thu, 2 Jul 2026 11:37:23 -0500")
References: <20260630092406.150587-1-manikandan.m@microchip.com>
	<20260630092406.150587-2-manikandan.m@microchip.com>
	<20260702-utopian-termite-of-perfection-f1f3ec@quoll>
	<860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
	<20260702163723.GA227454-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 03 Jul 2026 12:10:32 +0200
Message-ID: <8733y0penb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304480-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:Manikandan.M@microchip.com,m:krzk@kernel.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:richard@nod.at,m:vigneshr@ti.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:Nicolas.Ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:linusw@kernel.org,m:arnd@arndb.de,m:michael@walle.cc,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,infineon.com,nod.at,ti.com,bootlin.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,walle.cc,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59EDB70122B

On 02/07/2026 at 11:37:23 -05, Rob Herring <robh@kernel.org> wrote:

> On Thu, Jul 02, 2026 at 06:55:15AM +0000, Manikandan.M@microchip.com wrot=
e:
>> Hi Krzysztof,
>>=20
>> On 7/2/26 11:46 AM, Krzysztof Kozlowski wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know=
 the content is safe
>> >=20
>> > On Tue, Jun 30, 2026 at 02:54:00PM +0530, Manikandan Muralidharan wrot=
e:
>> >> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
>> >> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so i=
ts
>> >=20
>> > What is SFDP?
>> >=20
>> SFDP is the Serial Flash Discoverable Parameters -- a JEDEC-standardised
>> (JESD216) read-only parameter table present in most SPI NOR flashes, the=
=20
>> table contents provide basic information about the flash. There are=20
>> standard tables which are specified by the JEDEC standard and there are=
=20
>> vendor tables.
>
> Is SFDP present or not discoverable? Or we have a table of discoverable=20
> parameters that itself is not discoverable.

SFDP is almost always there. I don't think there are any non SFDP chips
manufactured today (?). The thing is, even if we don't need to define it
in DT, we might need to point to it in order to extract eg. a unique ID
or a MAC address through the NVMEM interface.

SFDP is split into several sub-tables, the first one is mandatory, but
then there are optional tables which can be discovered dynamically.

Thanks,
Miqu=C3=A8l

