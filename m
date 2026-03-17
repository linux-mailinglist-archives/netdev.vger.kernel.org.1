Return-Path: <netdev+bounces-268658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOqCGfJ0uWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:36:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 846682AD21C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A30E3022D37
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805513E277D;
	Tue, 17 Mar 2026 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hjDPpb2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134C2D3A7B
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761537; cv=none; b=cOkM5iQ++U0xtuSrnDGzaF37D6wrU9qFtxVzvDKXD/Wd/25EhTGGVjW4WmSOWkCoOGD4CWjPfjWu90OFtQB7cYhCdX589LQJ7xGsuMGmtG2czCK7n71r5mUgDJ9JnsBrfXSFINHDE8hC7/yveQ0AUsfiynfWTc7UjO4VOyXTyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761537; c=relaxed/simple;
	bh=W8pPNUzRo8sFH7dK7edui6HP47WZHf4cU5A+rsoapao=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=uqhS2qhDf4XUwJ05bBT/X/D2QlY4dQgtsXUrX0Hcu3maXNOcqQG/9R+SIdkGZv/9Dly5kD/unSwXluyEB6xsYWMkvnieipWeg1LmjADDBS1VaQBW8ag+aE502boDiBTJXluwe9ONkkBqPpWnsxvFmTCwxtttAauIZTmomsrTapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hjDPpb2H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A7C984E42656;
	Tue, 17 Mar 2026 15:32:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73C9A5FC9A;
	Tue, 17 Mar 2026 15:32:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 901E7104504DD;
	Tue, 17 Mar 2026 16:32:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773761532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MYPPseJQcXScytZgqEeRImE9zwvWNb/QPu+DahypQg0=;
	b=hjDPpb2He+svpR3KEQtqI5ZCS8YaUxN1gXF+kTcuLqdBfS9omVI3j+myukFb7Yfvkr8Qd8
	MMavzN1s5dzze0s97ikJqpR3K0JdTd2AwrtM3KaYsECCekpHi344WVzLM5TL/wbYhoBhpv
	GiYmx6LPppFHQcpaibut7mzoX9Go/942alD1aNTgk36ibgBcQEbGvel8rQCam28l6x+vs/
	ffQ7R2e9UETX9W44sN6NKdEvns6a0N4/2Rqw6906nsTP4QisQdeDIYyFm5R2Te1zZhVkso
	2hWAUnSzeI5MeC+eX/zSp/qzE11NstsRMmDfGzIBeZGXByya/SweKqZygtlLQA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:32:10 +0100
Message-Id: <DH55ZHTD35E2.37QYMVRD6KWZ7@bootlin.com>
To: "Paolo Abeni" <pabeni@redhat.com>, "Charles Perry"
 <charles.perry@microchip.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v3 2/3] net: macb: add safeguards for jumbo
 frame larger than 10240
Cc: <netdev@vger.kernel.org>, "Simon Horman" <horms@kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <20260313140610.3681752-3-charles.perry@microchip.com>
 <DH4DORKIV5RB.3P7Z2RTRNCXH7@bootlin.com>
 <abhLO8fna/ioyd6O@bby-cbu-swbuild03.eng.microchip.com>
 <fb33e9ec-d93c-45f2-aacb-7633beca7805@redhat.com>
In-Reply-To: <fb33e9ec-d93c-45f2-aacb-7633beca7805@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 846682AD21C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 17, 2026 at 1:29 PM CET, Paolo Abeni wrote:
> On 3/16/26 7:26 PM, Charles Perry wrote:
>> On Mon, Mar 16, 2026 at 06:21:38PM +0100, Th=C3=A9o Lebrun wrote:
>>> Hello Charles,
>>>
>>> On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
>>>> The RX buffers for GEM can have a maximum size of 16320 bytes
>>>> (0xff in the RXBS field of the DMACFG register means 255*64 =3D
>>>> 16320 bytes).
>>>>
>>>> The GEM IP has configurable maximum jumbo frame length that can go up =
to
>>>> 16383. The actual value for this limit can be found in the
>>>>        "jumbo_max_length" field (bits 0..13) of the DCFG2 register.
>>>> Currently, the macb driver doesn't use the DCFG2 register when
>>>> determining the max MTU, instead an hardcoded value (jumbo_max_len in
>>>> struct macb_config) is used for each platform. Right now the maximum
>>>> value for jumbo_max_len is 10240 (0x2800).
>>>
>>> If DCFG2 contains the value then we can runtime detect it. With that, w=
e
>>> could make the macb_config->jumbo_max_len attribute optional. Then
>>> start dropping it from platforms where we know we can trust the DCFG2
>>> value.
>>>
>>=20
>> Hello Th=C3=A9o,
>>=20
>> That would be a good idea. We could use "jumbo_max_len =3D=3D 0" as a wa=
y to
>> signal that the DCFG2 register should be used for determining the max MT=
U.
>>=20
>> However, that's a new feature and it doesn't belong in this patch. All I
>> want to do in this patchset is put the real value of jumbo_max_length in
>> the PIC64-HPSC macb_config and make sure the driver doesn't overflow whe=
n
>> that's used.
>
> FWIW, I agree that is better suited for a follow-up than for the initial
> bring-up.

then:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


