Return-Path: <netdev+bounces-45625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733E7DEA8E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620BC1C20BC6
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00E15BA;
	Thu,  2 Nov 2023 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiH49h4f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757910F9
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 02:12:17 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6FE4
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:12:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A10545C00C2;
	Wed,  1 Nov 2023 22:12:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 22:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698891131; x=1698977531; bh=HHqX/8hxM76B+
	FqUHCdvEUxPTggyvwjZCDtqqtb1Dmk=; b=eiH49h4fK8FgGVQFFnNNGTJhWiB43
	xyANQlcmzwv9NVB25UXh3hJmBAWwYRaQunD9fsARH6wraWUnpENLcJm3o4y56dU9
	rsTUelmLqFthTDfYc30m3iwwjlrBnDKmwQNUaEH/vgoZWAlcGecKUUS/D3PfxDfG
	tDC28EMRknqawOWeZ7iWoI7iWwKUqeOZsk14yQj24gmOTuUum8+j755RsgcZU06R
	NzHadTFQsN+IzfHQyH3hnieua9xsknprKhL3o9sY9YAzFYqUQR4gGJ8Kin8B/4Ms
	ht3Ud56x9Jtb9FiZ24Gour2jcmxmBWLQ+3Nq/pTqvK2fxNnHYcOlcDP+w==
X-ME-Sender: <xms:egVDZTzFIP-Qo8i7_JvveW15OEMzZ-g-pr11xyS9qX18JXgMv-5Ocw>
    <xme:egVDZbT-bTW05EomEIpQYveltj8MXTrS5zTCrTjzf600Gtedn2u-T92Jn34Q0Xg6p
    t0cES3IIQ7uY2LGceU>
X-ME-Received: <xmr:egVDZdWC-29u3_EMD6_JRSFmN19uPjlmOoY_R-bmVJYDj0dfaq2v3_4q8eZdGBhGbYUoxMrsMTr28O0m-avV0SJP6Adzzj7_oq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:egVDZdh-4TxXUUqnfocIihCEu8Iz3vRrCbo423kk58ioPj3FQKZAaA>
    <xmx:egVDZVDWXP98CTzh3m4Cwxp8MJNzCgh3D_XReaKJ4ct86XO1MUyxhg>
    <xmx:egVDZWK8uZVnzb9SehVJ959hGy9fsosnXWqvFO8lBj0pR4JLIEXzWA>
    <xmx:ewVDZY44ENfjR8drYZ9Xh7CEnmmnKfoM984o5NyQcaADL6Sm26yzTw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 22:12:07 -0400 (EDT)
Date: Thu, 2 Nov 2023 13:13:49 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Dan Williams <dcbw@redhat.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    linux-m68k <linux-m68k@lists.linux-m68k.org>, 
    Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: Does anyone use Appletalk?
In-Reply-To: <d40cd45a-e7e3-49c4-931b-c5ec75a6bf56@app.fastmail.com>
Message-ID: <973278b8-c9e5-b1cf-2e08-2ff8fd8e9aa4@linux-m68k.org>
References: <CAMuHMdWL2TnYmkt2W6=ohBuKmyof8kR3p7ZPzmXmWSGnKj9c3g@mail.gmail.com> <594446aaf91b282ff3cbd95953576ffd29f38dab.camel@physik.fu-berlin.de> <CAMuHMdWv=A6MiVwUuOp8zOCcf21HxKb8cdrndzdbAZik3VRXiw@mail.gmail.com> <5e3e52a48ba9cc0109a98cf4c5371c3f80c4b4cc.camel@physik.fu-berlin.de>
 <79b7f88e3dd6536fe69c63ed3b4cc1f2c551ce8d.camel@redhat.com> <d40cd45a-e7e3-49c4-931b-c5ec75a6bf56@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Nov 2023, Arnd Bergmann wrote:

> 
> If we had not removed all localtalk support already, ipddp might have 
> been used to bridge between a pre-ethernet mac running macip and an IP 
> based AFP server (netatalk or time machine). Without localtalk support, 
> that is not all that interesting of course.
> 

That line of reasoning misunderstands the value of the localtalk code (and 
conveniently neglects the actual cost of keeping it in-tree).

The existing zilog driver works on all 68k and powerpc Macs with built-in 
serial ports. If we were to complete that driver by adding the missing 
localtalk support, it would create new opportunities for creative 
users/developers who already run Linux on those systems.

Those users/developers would surely derive value from that functionality 
in ways we cannot anticipate, as happens over and over again in the 
(retrocomputing) community.

So the value of the missing zilog localtalk functionality would be 
proportional to the number of Linux systems out there with the necessary 
serial hardware. It's value is not a function of the potential business 
opportunities for your sponsors, despite the prevailing incentives.

It was the potential value of the missing code for localtalk (Zilog SCC) 
and Apple Sound Chip that caused me to place that work near the top of my 
to-do list. But that was several years ago. Unfortunately, with bug fixing 
and recapping, I still can't find time to write the necessary code.

So I can't object to the removal of the localtalk code. But I do object to 
the underhand manner in which it is done.

