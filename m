Return-Path: <netdev+bounces-304255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44nfGFWrRmpIbQsAu9opvQ
	(envelope-from <netdev+bounces-304255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A921F6FBEAD
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jvosburgh.net header.s=fm3 header.b="b c/aG25";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=e+gUvmVO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304255-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304255-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=jvosburgh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BE993023AE4
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA753A4F46;
	Thu,  2 Jul 2026 18:17:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47631C695;
	Thu,  2 Jul 2026 18:17:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016273; cv=none; b=VUUOcRdmA+C6n5pwR15UjI2jthQJu7z/1X2yIHWMZM+xOyYrsU5BNsVz0APZbwhafwy6isg+HFB27XlvP95pEXNTG/gjC68st5/MzfMX4zhmG/7Pfy/An8XCAv9FZHOadrXY9mc8yQ6mUHeriJ++h+1qE6Sq7i5tarqivxXptrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016273; c=relaxed/simple;
	bh=VNiPHKbY+7ZcRzPkrxitR5jeoQEWzsnXA3gR7fEZbtw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=bLNaA1nANmUnpr7gvp4lhj3Cvi0EPODu+Ir7uGIuizmyJQzxHn8rGU16/tBD/GT78bIAJk+4fYHlNHA+zKfryCg1KR/TylnIkud9O8R9MdlnpFudmwlp3220m+E+Xf44DWb88htXThtRWJiqr5avr5zIYCZXlAfTib3q4mq+e4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=bc/aG25I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+gUvmVO; arc=none smtp.client-ip=202.12.124.151
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DFAC91D000F7;
	Thu,  2 Jul 2026 14:17:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 14:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783016270; x=
	1783102670; bh=YVY6BUlsPF9I2q2TM3dbextXrdXPIAas80uysxwDYag=; b=b
	c/aG25I8bGenpnyjG3yxEw1HzF+PGNX1fR772xAbgWkl/mhkhYczBPReDVmEq77S
	/4r+hRGNrdJUAfeEJx1/yrG2nzFTjrWBlxFxPxkq0U5/vgSOfE/OSOvfR/Por3c8
	5DdnPfP8LGbsmTunxtAYWN5vPD01/1qi3ZtA/c8GIZkrYB8eBRRDZo+h4M5Sz5TM
	Rxeiviqeahlua/bNcoEVeFE1Px6B3PpiqM1OGIjaB/S5C+t1a8RXtTv85BJkFtmU
	PVM/Rg8USx1NInd9hYLKuPTj5/OPMYzGSJJWsbLP/lier5CP7Zw0BuF8YN8d06Kt
	1vD334u4NYp/pAnkulBTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783016270; x=1783102670; bh=Y
	VY6BUlsPF9I2q2TM3dbextXrdXPIAas80uysxwDYag=; b=e+gUvmVODkcUoti/w
	u8L+8oePr/zL14v2hEmb8cwoMMK9rEcfvymn72Zr5YykL9nt1Lp7tQ2yyvdsz/Bs
	jQmAdctwDqvHcplhOkTINcv34JKiKS3RkiMwScr1J7kKLzky2p10zujr/GT2bG5B
	G0UHBIzHUONyst+q5sDl+NeIGrkhaFC95hDfrtsLhnpmgQJQuA2OuMCqXUXKFsP9
	0bKYjrIgSz807jGW4d4iWvZ6Y0MpM5PxTOrCE5hGs8VQFFzOnnr0x8ATcsHpznYO
	LLTBKAB6eF8re+rkP+TPGUbiiX1uTegAaixDiGSikUQeHyPy9ut6Dg+hrTP0Jy89
	OWAFw==
X-ME-Sender: <xms:TqtGarYiy1Zy2wfwxRrmWCL5cjDIcQvnfKEihgeMCpE2XRGFsayXNg>
    <xme:TqtGaoNZlSJtWEhHzxly65KDPm7Y8Ax-eEnTyichOd7JZo5LoPqbIIReOwFEqSUHL
    M_u1JebL-pCyaSXMFs72tzDAt5idvunNWVd29REZrcl5T7wShVYbUs>
X-ME-Received: <xmr:TqtGaoYECLR15D0NGNLbfjQ8UH9pUSOfSVKELJsXzOzKhnVvD-QMFFgYsu2g6ytSDZellQ>
X-ME-Proxy-Cause: dmFkZTF4/cIK9Acjb8w71YMkf9mzYkJM0oE6xaNluclDjGLz3QVvcM1Gr7rAdK5Y+x8Zis
    75nnWiPH2lbPXhr4RUJ2RgbbKKwkBa13RFwzAwYd4oaZlzp6rSwvWynstgLQaL36nHyAar
    KcOdhaUuutxHAGDi6JemTTEGaRPOuUMcqJlrPdIE4IgXEo+Y+YO45wZ+ttpjehoPeCFCw1
    VtxKfJdXTiN6DO44SbMCnGsYsdW1GAzl39hk3Nwaxf65sL/D+Y/RfV8gtWlJU0nhSbm4lq
    a5pNufmR9pST4lonDmRlqohmF+nja5SyYnUqynm3fjoZONd1hZ5DsB10YTA3DtNQcw6otX
    IB7muEo2sxdYPBOuxck+bgv8x0MbwMmzmmcWihKZhLFOwboSfPkUhxazZEPfe+ZUEfCiPQ
    3uJigwIi1aH2caZg8AociavbTN4qT0DQ4/kkTAtUixAqhdGEgzywJsAqrsukaPyw1DuNRQ
    jiVV7h7kG0vewTgnTEOR/H6orkdTkberyN2ZnoluaMp5xwbvEocEidK0rgFwpLgKMqZ09+
    feEAS2H15Br2ywNE01+MAlJtjumc+4LF4JZVHNEpdrQuZa2PE95UQXH8DFXv1NBI1KVR0a
    R4PU1WMysod8dN1DPSNo3ePZCfIXUwOgxGJ+ADwWNjUob6EbvZwCoqPmuFMA
X-ME-Proxy: <xmx:TqtGau2emInibYahfStzJqkaXULs-DRExC3EwYaZZrxRANmJr2hqBg>
    <xmx:TqtGamesK0V0cDMwyxxIfiao2yEfO8Zk1gc7nb6fwViYY2ESpMS5rA>
    <xmx:TqtGanHYnQzeGCwHcRCta7-k8W9hFDXKHETW5iPY_207EdIsRUkBlw>
    <xmx:TqtGav1A6Vi3AdJX8PapkCSIRYqRIpbe1t2ot8Za-SRARfoesDf93Q>
    <xmx:TqtGam6IOnETit517iAvUqnACv2etKoYPT05FqOPcfzOaZCXcwpBv2n9>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 14:17:50 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 1EA089FC68; Thu,  2 Jul 2026 11:17:49 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1BD5B9FB76;
	Thu,  2 Jul 2026 11:17:49 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    paritosh.potukuchi@amd.com
Subject: Re: [RFC net-next] bonding: Retry updating slave MAC after a failure
In-reply-to: 
 <CAMfiSebUf6rbHu4bVL-5vCFRs5cafiEeiNDpX3eQRdxKuRgGeQ@mail.gmail.com>
References: <20260630150937.3508222-1-paritosh.potukuchi@amd.com>
 <2001256.1782860341@famine>
 <CAMfiSebUf6rbHu4bVL-5vCFRs5cafiEeiNDpX3eQRdxKuRgGeQ@mail.gmail.com>
Comments: In-reply-to Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
   message dated "Wed, 01 Jul 2026 13:11:53 +0530."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2083935.1783016269.1@famine>
Date: Thu, 02 Jul 2026 11:17:49 -0700
Message-ID: <2083936.1783016269@famine>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304255-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paritoshpotukuchi@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A921F6FBEAD

Paritosh Potukuchi <paritoshpotukuchi@gmail.com> wrote:

>> I think the proper thing to do is remove this comment block and
>make no other changes.
>
>  > This comment dates to sometime before git, when it was common
>for network device drivers to lack the ability to change the MAC while
>the interface is up.  To the best of my knowledge, that isn't a issue
>today.
>
>Sure Jay. That makes sense. Should I go ahead and post a patch 
>removing this comment?

	Yes, please do so.

	-J

>  -Paritosh
>
>On Wed, 1 Jul 2026 at 04:29, Jay Vosburgh <jv@jvosburgh.net> wrote:
>
>    Paritosh Potukuchi <paritoshpotukuchi@gmail.com> wrote:
>
>    >I came across this TODO in bond_set_mac_address() :
>    >
>    >        /* TODO: consider downing the slave
>    >         * and retry ?
>    >         * User should expect communications
>    >         * breakage anyway until ARP finish
>    >         * updating, so...
>    >         */
>    >
>    >Currently, if the dev_set_mac_address() fails on a slave, we go
>    >ahead and unwind the bond and its slaves.
>    >
>    >As the TODO suggests, one possible solution is to try setting
>    >the MAC again, after putting down the interface. This is because some
>    >drivers may reject changing the MAC when the device is UP.
>    >
>    >The solution I am proposing is as follows:
>    >
>    >dev_set_mac_address on the slave
>    >        - If this fails, temporarily stop the slave - ndo_stop
>    >                - If stop fails, unwind
>    >        - call dev_set_mac_address() on the slave
>    >                - If this fails, unwind
>    >        - Bring up the slave by calling ndo_open
>    >                - If this fails, unwind
>    >If dev_set_mac_address on slave passes, we go to the next slave
>    >
>    >
>    >Before working on a patch, I wanted to get feedback on whether
>    >this interpretation of the TODO makes sense and whether there
>    >are concerns with temporarily stopping and restarting a slave
>    >during bond_set_mac_address().
>
>            I think the proper thing to do is remove this comment block
>    and
>    make no other changes.
>
>            This comment dates to sometime before git, when it was common
>    for network device drivers to lack the ability to change the MAC while
>    the interface is up.  To the best of my knowledge, that isn't a issue
>    today.
>
>            -J
>

---
	-Jay Vosburgh, jv@jvosburgh.net

