Return-Path: <netdev+bounces-307769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u1VVGKCaV2ouXwAAu9opvQ
	(envelope-from <netdev+bounces-307769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:35:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1A75F740
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=o+sR6kY1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307769-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307769-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22BAC31605F0
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE736F413;
	Wed, 15 Jul 2026 14:13:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50AC31B130;
	Wed, 15 Jul 2026 14:13:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124794; cv=none; b=hqt3L3CzMR87IFT1adPLog0PKrubCAlKj1zfH6DkMsuD1laR0oeRBPZstjVjh9bsPtlisl6UtNeK4Jx+b9UuiL/No28fsDd42V1WzeboHygFagdMU6ifogzw4bS48cHjrs10XQh9cLFqVvftOaWazldNLu/H7Ulofq0iVwAVdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124794; c=relaxed/simple;
	bh=7RcPmoCf9XH1oY2JDlvttQRnKxT/yye3zSHLT4O7nKo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=A9SrD6uWSK8tpkngMFVj4ySlKKDupgxexjIplCkAAPmH6B1RehYIn1dqmaVCUc6oydQIR5lVzOPAMaWVgNguP70+iOZAepR1BXwvy1/4lPVwm/Nc8NIig1uaVuDOgo5aR6rUPOKmPJIcpW3S7UL2Cg7plpDVuVA3cbTCXRt/BvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=o+sR6kY1; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 994DEA5188;
	Wed, 15 Jul 2026 16:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784124786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dFP4b15ezb3GF5jTFRUAT5mkZf73hGVmktkG09Chtz4=;
	b=o+sR6kY1zL+PXpOBhrUNtcfOJTm4DrEI7n6/ck5tEE80xSt1149HFX8XMEfrSv14Xy9gzc
	fmbiNmmlcomjAjInGPGYye7YzmmO6LVlMfm32WsHvtJU23PlQVtuKp648Z3+pabEALQaQw
	ozCJIhMRbN26wlVYvczKbnDSp0hZ+VrJD3D7tKowdae4W+XgpJi479lVm6l1cvrqp8/mtr
	G6n0bgBCuh054sHgKyfKuWKSkaF8ojZgvc2zFwTUddArrw9LEOyPUe7zbDys6szVKdj5jt
	3dzX7utX4zHbhxEJLLkrtCm3NnUmtmNHyH1B7UwpSJx2Yp9qBf3HxmcB/ZLnSw==
Date: Wed, 15 Jul 2026 16:12:58 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?ISO-8859-1?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
CC: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Paolo Valerio <pvalerio@redhat.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?ISO-8859-1?Q?Beno=EEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v3_06/15=5D_net=3A_macb=3A_alloca?=
 =?US-ASCII?Q?te_tieoff_descriptor_once_across_device_lifetime?=
User-Agent: Thunderbird for Android
In-Reply-To: <DJZ6XCJDMFE8.PPNN42W2TGSQ@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com> <20260701-macb-context-v3-6-00268d5b1502@bootlin.com> <6e449ee7d40ec885e8a53fa18fe70e86@tipi-net.de> <DJXFDPIB17FW.2BN105BPCBSKB@bootlin.com> <DJZ6XCJDMFE8.PPNN42W2TGSQ@bootlin.com>
Message-ID: <DB3DD915-341A-4995-B438-1613363C3205@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307769-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime,bootlin.com:url,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90D1A75F740
X-Rspamd-Action: no action

Hi Th=C3=A9o

On July 15, 2026 3:48:18 PM GMT+02:00, "Th=C3=A9o Lebrun" <theo=2Elebrun@b=
ootlin=2Ecom> wrote:
>On Mon Jul 13, 2026 at 2:00 PM CEST, Th=C3=A9o Lebrun wrote:
>> On Thu Jul 2, 2026 at 12:54 PM CEST, Nicolai Buchwitz wrote:
>>> On 1=2E7=2E2026 17:59, Th=C3=A9o Lebrun wrote:
>>>> The tieoff descriptor is a RX DMA descriptor ring of size one=2E It g=
ets
>>>> configured onto queues for Wake-on-LAN during system-wide suspend whe=
n
>>>> hardware does not support disabling individual queues
>>>> (MACB_CAPS_QUEUE_DISABLE)=2E
>>>>=20
>>>> MACB/GEM driver allocates it alongside the main RX ring
>>>> inside macb_alloc() at open=2E Free is done by macb_free() at close=
=2E
>>>>=20
>>>> Change to allocate once at probe and free on probe failure or device
>>>> removal=2E This makes the tieoff descriptor lifetime much longer,
>>>> avoiding repeating coherent buffer allocation on each open/close cycl=
e=2E
>>>>=20
>>>> Main benefit: we dissociate its lifetime from the main ring's lifetim=
e=2E
>>>> That way there is less work to be doing on resources (re)alloc=2E Thi=
s
>>>> currently happens on close/open, but will soon also happen on context
>>>> swap operations (set_ringparam, change_mtu, set_channels, etc)=2E
>>>>=20
>>>> Signed-off-by: Th=C3=A9o Lebrun <theo=2Elebrun@bootlin=2Ecom>
>>>> ---
>>>>  drivers/net/ethernet/cadence/macb_main=2Ec | 75=20
>>>> +++++++++++++++++---------------
>>>>  1 file changed, 41 insertions(+), 34 deletions(-)
>>>>=20
>>>> diff --git a/drivers/net/ethernet/cadence/macb_main=2Ec=20
>>>> b/drivers/net/ethernet/cadence/macb_main=2Ec
>>>> index 8b52122bc134=2E=2E951a7f080225 100644
>>>> --- a/drivers/net/ethernet/cadence/macb_main=2Ec
>>>> +++ b/drivers/net/ethernet/cadence/macb_main=2Ec
>>>
>>>> [=2E=2E=2E]
>>>
>>>>  static void macb_init_rings(struct macb *bp)
>>>> @@ -2832,8 +2801,6 @@ static void macb_init_rings(struct macb *bp)
>>>>  	bp->queues[0]=2Etx_head =3D 0;
>>>>  	bp->queues[0]=2Etx_tail =3D 0;
>>>>  	desc->ctrl |=3D MACB_BIT(TX_WRAP);
>>>> -
>>>> -	macb_init_tieoff(bp);
>>>>  }
>>>>=20
>>>>  static void macb_reset_hw(struct macb *bp)
>>>> @@ -5518,6 +5485,38 @@ static int eyeq5_init(struct platform_device=
=20
>>>> *pdev)
>>>>  	return ret;
>>>>  }
>>>>=20
>>>> +static int macb_alloc_tieoff(struct macb *bp)
>>>> +{
>>>> +	/* Tieoff is a workaround in case HW cannot disable queues, for PM=
=2E=20
>>>> */
>>>> +	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
>>>> +		return 0;
>>>
>>> Before, the tieoff was allocated in macb_alloc(), which the at91ether=
=20
>>> path
>>> never called=2E Now it's allocated from macb_probe() for all variants,=
=20
>>> gated only
>>> on MACB_CAPS_QUEUE_DISABLE, so EMAC gets a coherent descriptor it neve=
r=20
>>> uses=2E
>>>
>>> Add MACB_CAPS_MACB_IS_EMAC to the if statement?
>>
>> Clearly=2E That EMAC distinction keeps being annoying=2E
>
>Well well well=2E Under AT91 with WOL active there is nothing preventing
>the tieoff from being used in macb_suspend()=2E Meaning the tieoff is
>being used zero-initialised=2E Not advisable=2E
>
>So I withdraw my previous comment: we won't shield macb_alloc_tieoff()
>from IS_EMAC and maybe it will fix a bug=2E

Sounds reasonable=2E

Reviewed-by: Nicolai Buchwitz <nb@tipi-net=2Ede>

Thanks,
Nicolai

>
>Thanks,
>
>--
>Th=C3=A9o Lebrun, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin=2Ecom
>

