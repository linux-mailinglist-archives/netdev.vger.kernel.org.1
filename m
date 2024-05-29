Return-Path: <netdev+bounces-99074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D48D39F1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE52228A02B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E51802A7;
	Wed, 29 May 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C054Z+UV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4qr6sTU"
X-Original-To: netdev@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0A17DE13;
	Wed, 29 May 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994168; cv=none; b=qss0/dHvzPyzZHcLO9WQFlFfgfPISYazQ0GrLNsKy9cof7fDnRuV+kyOWfMdPorEysD6ICpBXfrMgfBSmJSVNfNkaG78WQg+ZkItTBnb2ittLrdBn0vzQS8cRXs//rNvDt3bUf1kerKl16wTq1waCEnK0ywB5SeX7UriCWSOBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994168; c=relaxed/simple;
	bh=SF0YKlSyYse+0ka5sLh8OROzBOmqMA2huVE3Mlz5x+w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=p6GVCBs+lIWlBE6DRjJWJ632KgeDCSFKlqQlen9ilfb3NYl0KdRQmLGNSwXlBSgEevg2/RZDWOOo17qWbNIrxT5blinepEvbWLZFufXOum+OGq9v+L4iGL/LUwNIVwsQKkC6WveR4acNcmPZDiEaENYp2sy5o3MwqMAjQrqWF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C054Z+UV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4qr6sTU; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id F12AF18000A9;
	Wed, 29 May 2024 10:49:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 10:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716994164; x=1717080564; bh=7IxkuZoVd9
	WiYU/J/P+geKBX2/pqxBTDvhVab7EsJvA=; b=C054Z+UVY9X47doZ54zeBRGGwN
	F9Hvhv8YSAyy0Cs2sfztiaDV5H7ojEk4gnaSjOmW3DA5I3ACV6cprjnkS/BNf6JE
	Fl9wM0xlYGLTiVDtZpbWbxiBHZzX3tE8FNtjqZtSdOE+69e7naViTZ66JuUOHBaA
	tOPikQA6DcOX1fBtY6XJLp1yPsR3xxOegAhsgjg0wfP0dSvYNOJN6TLSvdU60vuK
	vMT82/RjtnYnP8iUB7ePbOBYH9ANmaNb+T5g7H8n2pySjG3+c2f03vDV+6QaYFsd
	KIsa+Ovi4BaSpoHoPNCgWND8/3aEnFxsgRNShsH1T62npJo1NpfvEAYkYJJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716994164; x=1717080564; bh=7IxkuZoVd9WiYU/J/P+geKBX2/pq
	xBTDvhVab7EsJvA=; b=f4qr6sTUdr0YYry+DQ+/asReNKnqa5DLwhJz3yrCcwb/
	dC4W0+okPOV6wCxUPT4vO2sqlXL9a7ynalsVTtJS18lgAuddMM9YytS5d1r8Vsbf
	D9lBcsD6Cub6SYcFDiqAJf7cDfdG2W0LyhC+AvVud8ER5clYCBRO2injczb40UIP
	g1uFgSNT440xgOFOIDhMBk/l3/KmoV2F03z5R6dctz0xCNiPrwYVY/Juz9DBJFpj
	Mg1XN3gSJ67GE1RKOas/UBhirl5dEBZg6+N5yyRNwjSMrQl45mauRgLxmAB3HBVw
	WlcnD6+qxLEBK9iGOoZ2nvom51K7dkxB9fAhCCPz4w==
X-ME-Sender: <xms:c0BXZhyrcGKBxTw9uPy2g390kPYzcP0f-cJUAkqhdd-u0WdsE6T2Jw>
    <xme:c0BXZhQfenGsG1noFYlG50F4t7ktFwmfOfFkyAaVkijo7UbM5otUoYcFdyBPa-n03
    cFWRn32sdCsbhTUDr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dEBXZrWLu_52h7i_Rl10q5JSSHiyw_sBSPurmHtFhP59vrN76XMypQ>
    <xmx:dEBXZjiGHvtN03UFwA_q1v-0dK6SuMlqAwJBNkaGGrN66Yf-iM_wFA>
    <xmx:dEBXZjA6eeA3tQY3dQ-M1spSd8h97nCMvqr1zhEGqcdmgkaM2DUhZQ>
    <xmx:dEBXZsKCC0O7uDWBbP95Pw9m_1CnId7P63gpDc0HdgesPADldK2Z7A>
    <xmx:dEBXZn64Yt88Hu70UASVo2bI4IOJPOIRKAn1JInL-TqW456qTsWfZqWh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E35D4B6008D; Wed, 29 May 2024 10:49:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0aa8873b-d333-4d2a-ba3a-a116623b470a@app.fastmail.com>
In-Reply-To: <20240529143859.108201-4-thorsten.blum@toblux.com>
References: <20240529143859.108201-4-thorsten.blum@toblux.com>
Date: Wed, 29 May 2024 16:49:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@toblux.com>,
 "Nicolas Pitre" <nico@fluxnic.net>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andrew Lunn" <andrew@lunn.ch>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>
Subject: Re: [RESEND PATCH net-next v3] net: smc91x: Fix pointer types
Content-Type: text/plain

On Wed, May 29, 2024, at 16:39, Thorsten Blum wrote:
> Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
> to align with the parameter types of readw() and writew() to fix the
> following warnings reported by kernel test robot:
>
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect 
> type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] 
> __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect 
> type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] 
> __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect 
> type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] 
> __iomem *
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect 
> type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void 
> [noderef] __iomem *
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

