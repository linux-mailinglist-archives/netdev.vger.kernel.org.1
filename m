Return-Path: <netdev+bounces-256640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNuOO1ERg2kPhQMAu9opvQ
	(envelope-from <netdev+bounces-256640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:28:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59037E3D55
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66E43031CE3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CA3A4F2A;
	Wed,  4 Feb 2026 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HYMbVBcX"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B22F49F0;
	Wed,  4 Feb 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197106; cv=none; b=C7jXDoWHuXbP8Pk9fijadbjjVkWuEqCJACwAHw//NAIf0Bnn7Bv0sT4KXmHkTf4kXbaV1f4/IU202cj30d0Y0s2G7o/jy+Ap3JpiwwZ7vf2fUrYslBkO2SBS9vGc3Wkls5KPlzhKuc6cB+lQH9Q7PWVvXX1Rx3pkJja93vKDE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197106; c=relaxed/simple;
	bh=vc2yGibGO/7S61xBjDTD6pcJ+5GAGFalUXGaw7PivYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox1o2MpwcL8lBZJv9iyGuQZM4oVpKDUVQ/EbA1dQPxk/vyXQtF2k4N3LBXV7yk6xPHJav9eVZH2PrXIlRf9lsUq+bpIkCdDPWg3Zq33ggWhlWG2KALFltduUz4WxhpAJuX7h1eE/aSA94DLv0imSxOeIqN8J4vUHtp3HeZ71SjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HYMbVBcX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f5Zgx6QSkz9vDh;
	Wed,  4 Feb 2026 10:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770197101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxOlQodzm6R/baEVz+4rB5Qqmmbl46tAihAFv68RzaQ=;
	b=HYMbVBcXXbeEQ4H++CWAHqOs5ataMLQ2PTg3Bvi+vNroVt18LkGQWRAqhNmZMEC+krl4J3
	U0RMxaPMVa3AE39/jfcM0Ei6W4MGVDm8vxdVosxYjahgWXGjR+ucKapetnuAhMcjZvbhzJ
	NBQ26z9ZTnAc8T90PLs0jkcUrGVB5nMfnaRS4c2pDA98Eiw2YtY0gmHUIf+oNl/nSIsnXx
	RfNcWTfwfHhjCgHw2ZQYcCtSR7oejxTE/rKd4PmPMHrh0Xu47rdqn0w0myyCvEr49G4k16
	h1xsGhgjY5b1mRpFyAlLM1yLncdvx1dBpZ9w6t07QD4ZOpLCOkggJoR4flaTow==
Date: Wed, 4 Feb 2026 10:24:52 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, shawnguo@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 conor+dt@kernel.org, horms@kernel.org, richardcochran@gmail.com,
 robh@kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, wahrenst@gmx.net, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [net-next,v22,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260204102452.180eb416@wsk>
In-Reply-To: <20260203174714.79388301@kernel.org>
References: <20260131233459.1625279-3-lukasz.majewski@mailbox.org>
	<20260203013909.822898-2-kuba@kernel.org>
	<20260203211955.23ef4355@wsk>
	<20260203174714.79388301@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: a37455c1274356fa2fd
X-MBO-RS-META: 9srgwun7amh3ixsdai6ym39433cis3wc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256640-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59037E3D55
X-Rspamd-Action: no action

Hi Jakub,

> On Tue, 3 Feb 2026 21:19:55 +0100 =C5=81ukasz Majewski wrote:
> > > > +static void mtip_write_atable(struct switch_enet_private *fep,
> > > > int index,
> > > > +			      u32 write_lo, u32 write_hi)
> > > > +{
> > > > +	struct addr_table64b_entry __iomem *atable_base =3D
> > > > +		fep->hwentry->mtip_table64b_entry;
> > > > +
> > > > +	writel(write_lo, &atable_base[index].lo);
> > > > +	writel(write_hi, &atable_base[index].hi);
> > > > +}     =20
> > >=20
> > > Can these functions race with concurrent access? Looking at the
> > > callers, mtip_write_atable is called from two different paths:
> > >=20
> > > 1. Static entry updates: mtip_config_switch ->
> > > esw_mac_addr_static -> mtip_update_atable_static ->
> > > mtip_write_atable (no lock held)
> > >=20
> > > 2. Dynamic entry updates: timer callback -> mtip_mgnt_timer ->
> > >    mtip_atable_dynamicms_learn_migration ->
> > > mtip_update_atable_dynamic1 -> mtip_write_atable (learn_lock held)
> > >=20
> > > The learn_lock only protects the dynamic entry path. The static
> > > entry path runs during link changes (mtip_switch_restart called
> > > from mtip_adjust_link) without lock protection.
> > >=20
> > > Both paths can access the same hash block in the address table
> > > (determined by GET_BLOCK_PTR(hash)). If the timer fires during a
> > > link change callback, both can concurrently access the table,
> > > potentially causing torn reads (reading .lo from one entry
> > > version and .hi from another) or torn writes (the entry is in an
> > > inconsistent state between the two writel calls).
> > >=20
> > > Would extending learn_lock to protect all address table access
> > > work, or is a separate hw_lock needed for hardware register
> > > access?=20
> >=20
> > This is handled in another way:
> >=20
> > 1. Partial write is not possible as this IP block handles it in
> > order (with some kind of 'latch' registers):
> >=20
> > "VFxxx Controller Reference Manual, Rev. 0, 10/2016"
> > 11.5.4 MAC address lookup table
> >=20
> > "Each entry must be written or read with the low address accessed
> > first followed by the high address"
> >=20
> > 2. The code for dynamic IP writing will not "touch" the entries for
> > "static" MAC addresses - Figure 11-70 - bit 49 is "Record Type":
> > 	1 - static entry
> > 	0 - dynamic entry
> >=20
> > IMHO, we are "safe" here. =20
>=20
> My reading of the AI's comment was that there is no lock in SW so two
> SW threads can write:
>=20
>    Thread A   Thread B
>    write_lo
>               write_lo
>               write_hi
>    write_hi

Ok. Then I can add "atable_access" spin lock to prevent from this
situation.

--=20
Best regards,

=C5=81ukasz Majewski

