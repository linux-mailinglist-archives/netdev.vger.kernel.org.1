Return-Path: <netdev+bounces-291686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLX3IZyUFWpSWgcAu9opvQ
	(envelope-from <netdev+bounces-291686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3F5D5AC4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE1E30305E9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2733FA5C2;
	Tue, 26 May 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Zl5C97iH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfRF8GIY"
X-Original-To: netdev@vger.kernel.org
Received: from fout-c8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87153DA7EE;
	Tue, 26 May 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799165; cv=none; b=JiIFWzQElHkH6UX/lFZOuN5GBLYOEg5/L/SOC5lpz9pudb7tO0om7moNtNZv7moSxuif8pTlQxLmUhGOxa00wtGe9zRzFpfXE7igMqlEypGcWbLk5ztHwyTFapl4fYQm/+hFUSvk7fst7YXOmtLDH/sSQJLroZ1wzcQQHLpjz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799165; c=relaxed/simple;
	bh=WmIHI5tESt8dD2Tux9qjsGuHNble5RZI7u8t9Dv0vxY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QGz/03NRC0BRGkFFQbCNw9o8hE3vPEM0/u1LLd+BiM8uHMLjAqSFEvIM6K19yIAWCJRV+p8xnol7vK1/ig7sum2tNveR7MreXbM3jJ3qHPmuq4UpSgQUxMu5lgbwPq16VXNn6inxCo3WfUkRG85I4aQgVUtcvrcG5Kr1sTWZL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Zl5C97iH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfRF8GIY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C6CC1D000FB;
	Tue, 26 May 2026 08:39:22 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 08:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779799162;
	 x=1779885562; bh=2DdhusNN+vFuzB0PmOPfndHbDWMKZxSYmfD1KK2/m2E=; b=
	Zl5C97iHWwzX+s65iHmz4A7cBN0fMHPEaOtqEkDv/450rxtnCqAzaF40910/sCx4
	XsRkbYxxcRcJTVoVS+Rj3CPRkoTR9FAbkbgVlrTgwnH+fLNR3yKvTxYz6ozFJzD9
	5yuPXhM+YyiHfrD1U1I94zpXS0nRa7zJJbPfxDZB83OlxXFH7Sx7iMdObzT4nZ/9
	QyTXQ3GmYNukhtaTlyjn9nLG+6lJtoSVkxHPKo73M27e6ePO6zH7IWFSBDvwofzZ
	JEKmEpOKHioFh4cFGmWvg9g1WoRdoeyJvLE+MfZMXBSlr8H3FjsSj/lZTUDr3DAI
	5ctlqw67K0myRrIqnqoL/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779799162; x=
	1779885562; bh=2DdhusNN+vFuzB0PmOPfndHbDWMKZxSYmfD1KK2/m2E=; b=W
	fRF8GIYRCMPR3lZ7dpGkTUoJuGKwURAj+8OZAfKcst2nL0NeRhZT3yRPm2KmRbOP
	Pg2f9wF6MPHE03aMTf0a4d/Ez2Et0VujQWssWiz1GQy00aCIhYmFBFo/oj4IWcRZ
	6fZuNjhGAfqa9tybpKAplceAM02TwxPiB2CUU2zcHQ4X/GkAemgOG9eEalZRme3e
	KNlZieVVgZrtaN0Tw1PBc2OeZKKNGjtL5+BnrwDBK0IoDhIqItOe3DQ/MU7GUM8c
	iBcnhtkmLvQ6JqQcXaqxQcTUzi1RBhT1HCSq2Oxf2OZJbw9rhxJE7ok8jECbXBaz
	iME8iqB/zw59FnQTo+h7g==
X-ME-Sender: <xms:eZQVanw1i65sp2LVimLDuabU3-yASNQPQj7As5LwwpnV27NmqNloJQ>
    <xme:eZQVaqEBMhWCcmZ-9c-O9nLEdjSvBHkK3jdYjOZX7s3T0_F0CZ8OQyrNy5dRMKv94
    iSaWwPDo1IurVvRVrTjAMWSxL1NCj1cwauc77ehoF1T9q1m6kpjqEg>
X-ME-Proxy-Cause: dmFkZTEywkXow3xdYkQ2bDUtuiNbW7HPTteV8VzeERFNC0X3krSq4Ztmxvfvo6lBC3mfHk
    nIOsh5OPxI5m9OkJYF5SpKXCL0JPa1nAwM4dHAgWRKmM5SD1y0YU3ZEds98AJZO2aNgC8j
    zzzgjv6EQVgcIXDfju67LcVJpmmJa1u5qE2m+i8WyxOoLatK9rZaqTmq+Chxph1tcZy6Rl
    gTzCoeLg4agwUggTSBIMIuJWS9zV2ihi7fFBfzxQBNcZLHVyYWYmrgQVAarNy80TcBgYrM
    I5F11ACojSxd2njeimht6MiOouBM0c7tWRJlPYuirsqeO1C1G2wz8aGh7V0B9KYOs+fuf0
    QWibBSswoX2aPbe5RpZ/T5/5VyXZ6ici5TcgaxQRbckIofh1dZ3vi2LHFvxvVf/zw1grSy
    TiFbYmEapVu+EvbVggQzeocyApFx0GmICq1JbLoPZtt68MV/RHZYiHjz082yl3d4xSRIe3
    7q3Tn3RFm9uDbM+GhABvyKx2DcAodSaFPYbYOTYSg1zpgNzA8elKSiy+uaifiZX3GNtC/x
    AsDSiCan2W+1fKFlBxfg2RjxvJVGiNVr5S/0feP5fMpdG4S09OQObqy87wJ/x/QEUA7guh
    WSBRWIsFhVA0TbqVIC33cj+SAHLUdeRWMUKNoj7e2Uj6A1+McumjsS9Oz1fw
X-ME-Proxy: <xmx:eZQVah4bs_xWeiDDQibLl1aBwgYGX1cCRJ38kh4WBqDH10_9gDDYfw>
    <xmx:eZQVav39f8LPj7xgJP3MvokKe5igghtVltfyKfZezSrQvzrup_8Fiw>
    <xmx:eZQVaox4mTj8r5t8eDA1jZs5joqKPISo1WMYqZGbZsYhT5UMPMhqTQ>
    <xmx:eZQVaonlNzLHp4EPnefWPUG_OJkRaPdx-UyE3T94ThcfHiWSuoKH_w>
    <xmx:epQVakkNsMABvUsRVbAnepaf_1q-zRd7bKVxZUmYdvNcFqijiIjGZK2h>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89ED7182007A; Tue, 26 May 2026 08:39:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuWQEIBBqPC7
Date: Tue, 26 May 2026 14:39:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Wei Fang" <wei.fang@nxp.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Claudiu Manoil" <claudiu.manoil@nxp.com>,
 "Clark Wang" <xiaoning.wang@nxp.com>, "Christophe Leroy" <chleroy@kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-Id: <ef1435b1-0cce-4f15-9e4c-0e9d50a9e1ea@app.fastmail.com>
In-Reply-To: 
 <DBBPR04MB7500D92831D793CDD1D562E2880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260526102708.2837129-1-arnd@kernel.org>
 <DBBPR04MB7500D92831D793CDD1D562E2880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
Subject: Re: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-291686-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,lists.infradead.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,arndb.de:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: E4A3F5D5AC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026, at 13:03, Wei Fang wrote:
>
> Thanks for fix this issue, I have sent a patch last Sunday.
> Link: https://lore.kernel.org/netdev/20260524070310.2429819-1-wei.fang@nxp.com/
>
> I think the solution should simply be to add
> "depends on NET_VENDOR_FREESCALE", right? The changes in
> enetc_mdio.h seem more like improvements to me.

Yes, the added dependency is sufficient. I removed the other
change only because that was intended as a workaround
for the same problem but was incorrect.

      Arnd

