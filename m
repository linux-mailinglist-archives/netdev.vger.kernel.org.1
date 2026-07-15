Return-Path: <netdev+bounces-307765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8wd1I7SPV2paXAAAu9opvQ
	(envelope-from <netdev+bounces-307765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DB75EF17
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:48:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="DN/vL8kH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307765-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307765-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63B5C3004F12
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982F2BEC5F;
	Wed, 15 Jul 2026 13:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E752FE074
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 13:48:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123311; cv=none; b=kS5oRfNwqEvqPo7DntLKA2PUeM1pICVyHi/hwut6Y1Q37Lub2K+5+hwNckUMrqAFnALgCMXEltuIrOZyFsNILXT4PE1LQ5xLbXs0Uz0MFWjGg6fS6ubDCfT8/r5YrpkhQRqXSLMSUTUihA8HZXcwZcw35Yv3bZDVPwx4AdUCokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123311; c=relaxed/simple;
	bh=RZ7EkwnU1t0nCFFfEcgF+4VnEriUQs3CQWeWMaoHkeo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=F4Xly1ZBmQgENRmeyPWSs6Pgv4g64jGZe3U/SirpOzAyv67UFvP7Hxyn8slgfEMXaGqS2zkMo98t18+V+Hxo5ZBPyM7r9fcLHDdjQKBY0WG3H/0aDyPO0A7vWfC35wyrVI9IM18sABOtDJa3hPR0wfq0y4cdNpNHS1FNMAIzeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DN/vL8kH; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 08F911A1005;
	Wed, 15 Jul 2026 13:48:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCA796035C;
	Wed, 15 Jul 2026 13:48:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83BC111BD1518;
	Wed, 15 Jul 2026 15:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784123304; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IwCcjamJcq8L4fYh5QQI7Pz+wiSR5GVJRvS8yF6VE+4=;
	b=DN/vL8kHROPyXIFPavd4npR5aWLjRO8+4qC7Ypr4Bl1U0I2AMRdZEkEdTJvyD9vDPhdHz5
	ypZBVrw2X4NL2cK5Mfi3KfttCe41c22uEjbxpBejb9Jzb4glCe436bLsU23Z3dKQGVtLDe
	cDOYL2jyNh243pJCHcSp0I//aBqJjpRAyH8ExnFI1emK5kk1oB5Y4n4O8PTXB7In6+wiu0
	5G6L7BeFWNQrv00DnDxm0644Jt+96vU9ntefvhhjLnvRUdvKoAlEp835pHDMWTKw5f1NJP
	Q2afpMzmaHTCIR+KJzd7savZhfmGfcBMIFQ0oFVd3q1y0annLo3dwfbzF3TuzA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 15:48:18 +0200
Message-Id: <DJZ6XCJDMFE8.PPNN42W2TGSQ@bootlin.com>
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
 <DJXFDPIB17FW.2BN105BPCBSKB@bootlin.com>
In-Reply-To: <DJXFDPIB17FW.2BN105BPCBSKB@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307765-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 309DB75EF17
X-Rspamd-Action: no action

On Mon Jul 13, 2026 at 2:00 PM CEST, Th=C3=A9o Lebrun wrote:
> On Thu Jul 2, 2026 at 12:54 PM CEST, Nicolai Buchwitz wrote:
>> On 1.7.2026 17:59, Th=C3=A9o Lebrun wrote:
>>> The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
>>> configured onto queues for Wake-on-LAN during system-wide suspend when
>>> hardware does not support disabling individual queues
>>> (MACB_CAPS_QUEUE_DISABLE).
>>>=20
>>> MACB/GEM driver allocates it alongside the main RX ring
>>> inside macb_alloc() at open. Free is done by macb_free() at close.
>>>=20
>>> Change to allocate once at probe and free on probe failure or device
>>> removal. This makes the tieoff descriptor lifetime much longer,
>>> avoiding repeating coherent buffer allocation on each open/close cycle.
>>>=20
>>> Main benefit: we dissociate its lifetime from the main ring's lifetime.
>>> That way there is less work to be doing on resources (re)alloc. This
>>> currently happens on close/open, but will soon also happen on context
>>> swap operations (set_ringparam, change_mtu, set_channels, etc).
>>>=20
>>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  drivers/net/ethernet/cadence/macb_main.c | 75=20
>>> +++++++++++++++++---------------
>>>  1 file changed, 41 insertions(+), 34 deletions(-)
>>>=20
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>>> b/drivers/net/ethernet/cadence/macb_main.c
>>> index 8b52122bc134..951a7f080225 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>
>>> [...]
>>
>>>  static void macb_init_rings(struct macb *bp)
>>> @@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
>>>  	bp->queues[0].tx_head =3D 0;
>>>  	bp->queues[0].tx_tail =3D 0;
>>>  	desc->ctrl |=3D MACB_BIT(TX_WRAP);
>>> -
>>> -	macb_init_tieoff(bp);
>>>  }
>>>=20
>>>  static void macb_reset_hw(struct macb *bp)
>>> @@ -5518,6 +5485,38 @@ static int eyeq5_init(struct platform_device=20
>>> *pdev)
>>>  	return ret;
>>>  }
>>>=20
>>> +static int macb_alloc_tieoff(struct macb *bp)
>>> +{
>>> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM.=
=20
>>> */
>>> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
>>> +		return 0;
>>
>> Before, the tieoff was allocated in macb_alloc(), which the at91ether=20
>> path
>> never called. Now it's allocated from macb_probe() for all variants,=20
>> gated only
>> on MACB_CAPS_QUEUE_DISABLE, so EMAC gets a coherent descriptor it never=
=20
>> uses.
>>
>> Add MACB_CAPS_MACB_IS_EMAC to the if statement?
>
> Clearly. That EMAC distinction keeps being annoying.

Well well well. Under AT91 with WOL active there is nothing preventing
the tieoff from being used in macb_suspend(). Meaning the tieoff is
being used zero-initialised. Not advisable.

So I withdraw my previous comment: we won't shield macb_alloc_tieoff()
from IS_EMAC and maybe it will fix a bug.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


