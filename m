Return-Path: <netdev+bounces-307136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEwUApfUVGrOfQAAu9opvQ
	(envelope-from <netdev+bounces-307136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586C74AB23
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:05:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=c2Vrxy6o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307136-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A860B304BDB7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D63FF8BD;
	Mon, 13 Jul 2026 12:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AA3FC5AB;
	Mon, 13 Jul 2026 12:00:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944041; cv=none; b=qK8GRKKA6LQDPyLRdFpuoz/Cw3Om2Hy9ikL8S/nA8GxJXEoUVdT6oePdA07KrOCbFv2CM/EFX6LH9vLiY/yRCSRHn9CAQXwe4uZwIMcNO6YYWX17d/3Rvs5Iodb9GVzb5o4K1f/WFxy4Z0dcp1wMNz6KHGTupfi7Y/NAgZ7FCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944041; c=relaxed/simple;
	bh=qm3xUzh4E0ywYBwCFEH/i8xmIC0wMJQmeILIW6rSEP8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=QBFyuk8SBmW+HL40MS5qTIziLT/0MMdiznTVcSr2/cmB04r2zhOkDwEJorO2jfENHhD5dy0YXLricw3x8k+l0aUr200gQ6h7gdTuhBtHovf1YoHSB0lICAOZ2dGq0I1W+0bnCWo/pDar+eFVZTuXBY6/EoKHE/YOFsHymY+AA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c2Vrxy6o; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 078E64E40D87;
	Mon, 13 Jul 2026 12:00:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6F9460341;
	Mon, 13 Jul 2026 12:00:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 875BF11BD2EA8;
	Mon, 13 Jul 2026 14:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783944035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5Z60738iah/NhBHLA0grqgv2G2DvvCyo3+0QyK5b82Y=;
	b=c2Vrxy6oBYBaaN0IVFd3ZlwoSo3uw4YmRQE81dpQW95RW0nIaj/teJDrUgPu3y85MUmTFT
	kcwx32knfeqTdoFpQ0j3At7D2nHkMbql3QT+rZ2M+uiRULJFfkqQJtl/iDG3jtnIoCS88z
	B+WSruSB9u9QvjZHMHnEvv7tUJs9YnwV5UfpNg3i+ASzDkASKx8KuJ6tPFaTeyJvaCzOwY
	cyeAGiQ6zpIO9FmjBeOaw8MdzWGxznH9feYswDtll3yr9tT6mIaIhwTukBeyltBtkucuSQ
	a58Gtka2P0ZD0GbJxrbb+slHSq5HPzwfnVYVz3LyjDGqdLALvroleEeeXP8cMw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 14:00:29 +0200
Message-Id: <DJXFDPIB17FW.2BN105BPCBSKB@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 06/15] net: macb: allocate tieoff descriptor
 once across device lifetime
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-6-00268d5b1502@bootlin.com>
 <6e449ee7d40ec885e8a53fa18fe70e86@tipi-net.de>
In-Reply-To: <6e449ee7d40ec885e8a53fa18fe70e86@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307136-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:url,bootlin.com:from_mime,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5586C74AB23

On Thu Jul 2, 2026 at 12:54 PM CEST, Nicolai Buchwitz wrote:
> On 1.7.2026 17:59, Th=C3=A9o Lebrun wrote:
>> The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
>> configured onto queues for Wake-on-LAN during system-wide suspend when
>> hardware does not support disabling individual queues
>> (MACB_CAPS_QUEUE_DISABLE).
>>=20
>> MACB/GEM driver allocates it alongside the main RX ring
>> inside macb_alloc() at open. Free is done by macb_free() at close.
>>=20
>> Change to allocate once at probe and free on probe failure or device
>> removal. This makes the tieoff descriptor lifetime much longer,
>> avoiding repeating coherent buffer allocation on each open/close cycle.
>>=20
>> Main benefit: we dissociate its lifetime from the main ring's lifetime.
>> That way there is less work to be doing on resources (re)alloc. This
>> currently happens on close/open, but will soon also happen on context
>> swap operations (set_ringparam, change_mtu, set_channels, etc).
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 75=20
>> +++++++++++++++++---------------
>>  1 file changed, 41 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 8b52122bc134..951a7f080225 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
>> [...]
>
>>  static void macb_init_rings(struct macb *bp)
>> @@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
>>  	bp->queues[0].tx_head =3D 0;
>>  	bp->queues[0].tx_tail =3D 0;
>>  	desc->ctrl |=3D MACB_BIT(TX_WRAP);
>> -
>> -	macb_init_tieoff(bp);
>>  }
>>=20
>>  static void macb_reset_hw(struct macb *bp)
>> @@ -5518,6 +5485,38 @@ static int eyeq5_init(struct platform_device=20
>> *pdev)
>>  	return ret;
>>  }
>>=20
>> +static int macb_alloc_tieoff(struct macb *bp)
>> +{
>> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM.=20
>> */
>> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
>> +		return 0;
>
> Before, the tieoff was allocated in macb_alloc(), which the at91ether=20
> path
> never called. Now it's allocated from macb_probe() for all variants,=20
> gated only
> on MACB_CAPS_QUEUE_DISABLE, so EMAC gets a coherent descriptor it never=
=20
> uses.
>
> Add MACB_CAPS_MACB_IS_EMAC to the if statement?

Clearly. That EMAC distinction keeps being annoying.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


