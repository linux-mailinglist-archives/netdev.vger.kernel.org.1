Return-Path: <netdev+bounces-144945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F49C8D67
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6311F23467
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBDF7DA66;
	Thu, 14 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PQXQiu3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1RSy0E7"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA41E521;
	Thu, 14 Nov 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596164; cv=none; b=O8993veRA1npBTxMwG5yrXd4twudcQ3QVWPUmC0XqJywK/FhAMP1lKbSYrKYds6ajH1LT+Aka9Bumc8k8AjBZiggPBeUGqx20FpNMarusgaEpA/KvG/RAO0rXMkcEQhOYxqtzhWKRc0YHTegFCSDePIy35Wg3K27qlZ6pC/F08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596164; c=relaxed/simple;
	bh=Y8JhZBLvCzMGYzwcIdQ9sxAuB3u+GhQ6FVmNMU0mlN0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G4GjzcWA2A0Dm2m9C1xwiZoREObY+UQtbIdHaq6wmpynALMuAtgyPmfy6CQs51fee5nbDK3clAG6J82zi38Ix/Lp6qITuhxaACPPxfn1at5wDElztcHAfrrVk2Pv0hEg0RaBEjv0bt0bueHR7nB4Mc0ocNA9Jyw6tH53cc7YVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PQXQiu3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1RSy0E7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCEEC1140175;
	Thu, 14 Nov 2024 09:55:59 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 09:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731596159;
	 x=1731682559; bh=LO+dEuBMcGGWi/NcKB15GLyTAiVbiyQlFbT0CMd3c8I=; b=
	PQXQiu3gQXuOTEfAcb0khgBfDDp290Po9XZ7S4536bxiU9W5UZi5PhYM+CHrviJp
	oiuWojN4Ik6VAE6/5GRmBSrJhC/JRFCv2NM/nZBjaySowF9fhnWcSzdFeZNclvrc
	xXvUIm63Zeryu1Cdgqi1TNa0601Vwd7w3o+DTXOdvl/y1MruWN5QkZji0P3IVO7l
	NvdYTFHQCsziUxrnE2ImfjeBCNQMZ3KAwbET567hLwhwHSibGk3/yA+zR9L5xoRI
	KpRziBR605SDzWx25Vshg0/ghJrmz6jgX0KaMaeTIDnq07iINma17RUmdR6OiT3J
	D0uNtHB1DLKfcIZErVlr7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731596159; x=
	1731682559; bh=LO+dEuBMcGGWi/NcKB15GLyTAiVbiyQlFbT0CMd3c8I=; b=N
	1RSy0E70eupxsUEh5AZkeVZnUf94jyKe9HqWAzi99t4aPlM/idVMLr45e7f38pnc
	rKUUyYJyxe4MIUGVDOnX5xLnOgHB4boklSNSRccMrtzBqTpaH/s7AuZq0nmn2AeH
	h22OsZET+fpVeXZvOFkAhlR8i4esBjS6fYGPyCF/TpaquiuPbCbg4qsgXqALTwWf
	ieT4OTOEpBywJthxm+nAsLuzmQu3DJS7EnBZmBCtzLZSE3Ezntpw7CyjHArI0ckn
	BHG0WRXd6mfjcfqjMWUYi5Ga2ETPNxLjLd+dUwQ7u1XiV0IAMw2l3iPhnxqWNgVR
	I6Y0PQv1dK6gJs0a4oDiQ==
X-ME-Sender: <xms:fw82Z-T-L5CbHwYciJkdtJgB61cAjfoWA4dTvVRWohbCwz36iTNEww>
    <xme:fw82Zzx7ln2Xdb4ITTTkJVv-zVI15rl7kFsmPV83SIBc5YuJLspTr6RWL3QB2cS9J
    x-oaDASnnkAh8nFIEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurd
    gruhdprhgtphhtthhopehgvghofhhfsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtph
    htthhopehjkhesohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fw82Z724ekZiOinagGYezie-83_g99xYY_4JM4ua765-xzTHVR0qpw>
    <xmx:fw82Z6DiWb1TGJvb9nbAZfmF-nbqz5ywnVS-mSOhWUTVhkYVFiF9Zw>
    <xmx:fw82Z3gCpUj2KXft-24ve5I6qnC_-pngjavWNh3h0SJEGR8IgP6nTQ>
    <xmx:fw82Z2p5AAbNW0AwIJPTJult45IQfPYyw1Vw4b9AzbxJqFEGMfNFMw>
    <xmx:fw82Z9bR7dJEyScPZb4B3QIwmrZb9_oToLfEmWv-JG9AF9rC-wr_30Pd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 827F62220071; Thu, 14 Nov 2024 09:55:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 15:55:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, "Jeremy Kerr" <jk@ozlabs.org>,
 "Geoff Levand" <geoff@infradead.org>, Netdev <netdev@vger.kernel.org>
Message-Id: <b7a930c8-52da-45bd-a085-7b886e2b2dcc@app.fastmail.com>
In-Reply-To: <20241114125111.599093-17-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
 <20241114125111.599093-17-mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 17/20] net: spider_net: Remove powerpc Cell driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 14, 2024, at 13:51, Michael Ellerman wrote:
> This driver can no longer be built since support for IBM Cell Blades was
> removed, in particular PPC_IBM_CELL_BLADE.
>
> Remove the driver and the documentation.
> Remove the MAINTAINERS entry, and add Ishizaki and Geoff to CREDITS.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

(cc netdev)

This means we can also move drivers/net/sungem_phy.c back
into drivers/net/ethernet/sun/ since it is no longer shared
infrastructure.

This was an early bit of MII/PHY library code that along the
same lines as what turned into drivers/net/phy/, but remains
incompatible with it. Moving it into the sungem driver keeps
it out of view of other drivers.

      Arnd

