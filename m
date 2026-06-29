Return-Path: <netdev+bounces-302665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oChWHRF7QmoA8QkAu9opvQ
	(envelope-from <netdev+bounces-302665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:02:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD196DBB02
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZV67NvVm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302665-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BE453067AC8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA684370AC3;
	Mon, 29 Jun 2026 13:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD92349AEA;
	Mon, 29 Jun 2026 13:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741430; cv=none; b=mxNd92w9FpIs0BhmcI4oGT0As1i4AXuzcnyJaS7+5brdaEBoq/eTk0I8P8Bv4BYfZTM5OZ5C2QmI3V0O3e+gR/FqSvLoBH/bBfkrZGCQrCXkssz241jRSWidaJv2p6ut+i3fCmQBC8h0K/Y4yEPOH473OjQMpnBhaMdzlx1Yba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741430; c=relaxed/simple;
	bh=k2RAual5RExbpgU3yONGpYrHBnc1PK00PfReWIqesJI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S02PznHy+WY6/OPAq4SpnUiS7yx8cug1QYFN7xWkp4RGndCwMAAIlylG9Xa0BlP5rjIKE+UESp21ul3rFxPHEj5ZX7cUHUa5bbcxQKC2ZneQdVSqVXZEBd+9Gc6jG33rRAOQcApxCCjL7Ay8IKo0dTKpPF8hDVN6XCRdlSQmvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZV67NvVm; arc=none smtp.client-ip=80.241.56.151
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gpnrx3wkLz8tm1;
	Mon, 29 Jun 2026 15:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782741425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2T5lIC0N2DNAj94CFuryAPABdom/cYG9c/Z6EqAhSs8=;
	b=ZV67NvVmEyddW+vlfizayrWZnpvf2PKtAUE2COXk5PcOvcnsjpf3nQuvH4p8IGXUbqfvsi
	vCe3zHWHkE8xQnLiNoqogP6hLGnztMw55+9NUkp0oPNJqBTjZ1QX2+2TOn0deUmi8aOlfg
	b4xA6dgiYgr3QJRZfiJdJGXPOaQhu+Et8iCFp8yal7vVlxDJEODMlj0hHlXkCXYvHlSw+5
	qxKwzTk5yR0vh47TamtRVRr3yr+e8b1C7boz27LqZGnrzkUpNWIAt9WFMAcw8jGgUZpzW8
	HdXojlYwl5xGGsxbSc+fEfiSr3173ilAdtyZryMgDCf9l/EHXTBrGEvFgA9fHg==
Message-ID: <22965a255a0cd4d698c561691257948c2a425d54.camel@mailbox.org>
Subject: Re: [PATCH] dt-bindings: Fix bracket
From: Manuel Ebner <manuelebner@mailbox.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel	
 <o.rempel@pengutronix.de>, "open list:NETWORKING DRIVERS"	
 <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Randy Dunlap	 <rdunlap@infradead.org>
Date: Mon, 29 Jun 2026 15:56:59 +0200
In-Reply-To: <20260627091936.29809-1-manuelebner@mailbox.org>
References: <20260627091936.29809-1-manuelebner@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: hgwkwujg9mk5hcfg7ph7oqi5sf3zrjsu
X-MBO-RS-ID: c6ee981cd2eb2c5ca80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-302665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:o.rempel@pengutronix.de,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rdunlap@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CD196DBB02

I'll admit I don't know exactly whats the issue

On Sat, 2026-06-27 at 11:19 +0200, Manuel Ebner wrote:
> Add "(Alternate" to "ID)"
>=20
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
> =C2=A0Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> index accff93d38f8..62bf982aff2b 100644
> --- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> @@ -33,7 +33,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,990=
6=C2=A0=C2=A0 # SMSC9505A USB Ethernet Device (HAL)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,990=
7=C2=A0=C2=A0 # SMSC9500 USB Ethernet Device (Alternate ID)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,990=
8=C2=A0=C2=A0 # SMSC9500A USB Ethernet Device (Alternate ID)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,9909=C2=
=A0=C2=A0 # SMSC9512/9514 USB Hub & Ethernet Device=C2=A0 ID)

There's an issue in this line with the brace and maybe with the text as wel=
l.
I couldn't figure out what usb424,9909 is. Can somebody help me?
Below are some possible fixes.

> +          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device
> +          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device (Alt=
ernate ID)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,9909=C2=
=A0=C2=A0 # SMSC9512/9514 USB Hub & Ethernet Device (SAL10)

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,9e0=
0=C2=A0=C2=A0 # SMSC9500A USB Ethernet Device
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,9e0=
1=C2=A0=C2=A0 # SMSC9505A USB Ethernet Device
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb424,9e0=
8=C2=A0=C2=A0 # SMSC LAN89530 USB Ethernet Device

Thanks
 Manuel

