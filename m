Return-Path: <netdev+bounces-160928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E0A1C481
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5621D7A3AF5
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C65FDA7;
	Sat, 25 Jan 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="m00eUs0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBIjrZrd"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6115D1;
	Sat, 25 Jan 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737824711; cv=none; b=HQWR5FkkMfRVJe5eX2NI0tMD4NRc7vA5GzkqFgDWF2zvNAmCujXOxiqP8lTntbXO7p3g6QuLmIqSisDS2EYV+L7xuA1luwrNEClohZFGXYCRO1EFeF1KxCni5j6MJgqMCWtnODHRvbUIUR3xZlexZFhQSSjbu0YBeyCMwgUx/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737824711; c=relaxed/simple;
	bh=C+fW/3Zth+heOn0tSGq5wJ1o33Kc4q4SNZi8jBNr+FY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o+GN8ow2JSdEr4IN6doupPBsVyKnHPa+hatcyLq/4y2KwyIvLbq2sJpbaWQ35H3sHKxFSUGPNy2lHC8Onl735MIDMyCT3Lnb6iQIJbQ46io7eT4aH3vmcfi/qu8ZJdJBEFURrtTkZnAu4PxxWfcZ6jFzOiRijMcF+fMZwxgGgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=m00eUs0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBIjrZrd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 60C0D1380221;
	Sat, 25 Jan 2025 12:05:07 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 25 Jan 2025 12:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737824707;
	 x=1737911107; bh=C+fW/3Zth+heOn0tSGq5wJ1o33Kc4q4SNZi8jBNr+FY=; b=
	m00eUs0idf2ByVzkoqIEpJ9F4UItuuiSENAm4liEJZWT/tp4xKwZG/mA5gsbdXfB
	eY9fMhnC5ZClgaMIb49Pkxonj3LItQqjWZi4oAFg/ptTDb1/8Pz9csZN8EJ/vszB
	uHhahVTOhC+n/lGC0oTJXwcPPwRx41lTmt9RuS0+svn88jFqorkJvXWoi9X5Y/oK
	CdN5RZHHKXue+gWt3fLObiSp5dwNEIvFEW6P4jpbkuPKVefvSEZDYqm9+VM8+fcf
	YMHWn6jDYLU+UGQGL9vr4qy0MZA6wtAb0EvVZx1gLfEB8wvZGTh3xFudp4b3KM7G
	seDmKWtCbMFymaMt3WoX2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737824707; x=
	1737911107; bh=C+fW/3Zth+heOn0tSGq5wJ1o33Kc4q4SNZi8jBNr+FY=; b=d
	BIjrZrdsEy9BZehGkwR+Seju5/80Gn+E7iosFXfS00nHb8vWKOHVbOWyra8AU5bR
	aPeEhW/zk431hF3x9+8RxxCLdlwDhpYr+8rfuNw2L1QxYS7iy2iT2hfmOPoPYyE8
	XI0C6jfIxpzMmY7dXxA95s4eENBNWQ2gOqLb9Lo3owsjv2oSWnF4n4Rzfz0S7RSz
	VVjkIPW9V0KcnvTSs/z078ZU6L32oahSIrwjtOBX3Sv91N6ETB5V5JO1k8cw52IN
	atf7NBC9AlWUDUtgtg72gH3IWYt5aNpNQaHGEp3/bOO8xUAqPSCCleg8HDDpitsL
	zDUuzZIhDQnnsiJejkJKQ==
X-ME-Sender: <xms:whmVZ7WDcwSeBv70y-J-I1hB-zFrmL2Z1_MHco8xgCSJPg8BrH_fbg>
    <xme:whmVZznOVVaTkvjmFdatz80g2atspZJS36C-W2uzIg9kTjTJX05NZGx_GAA86a7NI
    PcPef5TriNz23rWBKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgjeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekvdeuhfeitdeuieejvedtieeijeefleevffef
    leekieetjeffvdekgfetuefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepghho
    rhgtuhhnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghhrghruggtohgthh
    hrrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvgdrtghomhdprhgtph
    htthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrshhtuhhlthiisehlihhnrg
    hrohdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihig
    rdguvg
X-ME-Proxy: <xmx:whmVZ3ZcvFs-KJoDc_KNwWfVKwMC5xbjdmmiqsnzXTWfPI9_oOlZuA>
    <xmx:whmVZ2XO8B-f-ysGTUyriQKidPI3q5hqNYWOkA7Ce5739wvLECRB-w>
    <xmx:whmVZ1ljVgrI0eSQ_223JCpbca6k4IWOfsUpQwUhbTHvePC0m1ZTyQ>
    <xmx:whmVZzff_Egl2_bbsxhdUCZaytFvI_TCfz6StkhscfAkYkAkaY4Nnw>
    <xmx:wxmVZ6-4F_asWWqtpBJ8TEg9jisR8D28OvacFOSvpYQ-nMdA1Ce9TH_R>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 215002220072; Sat, 25 Jan 2025 12:05:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jan 2025 18:04:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "John Stultz" <jstultz@google.com>,
 "John Stultz" <john.stultz@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Cyrill Gorcunov" <gorcunov@gmail.com>
Message-Id: <4b4188d3-3ac9-465b-9e74-703a5d70588e@app.fastmail.com>
In-Reply-To: 
 <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
References: 
 <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
Subject: Re: [PATCH net v2] ptp: Properly handle compat ioctls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025, at 10:28, Thomas Wei=C3=9Fschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl=
.rst.
> Detect compat mode at runtime and call compat_ptr() for those commands
> which do take pointer arguments.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link:=20
> https://lore.kernel.org/lkml/1ba5d3a4-7931-455b-a3ce-85a968a7cb10@app.=
fastmail.com/
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp=20
> clocks.")
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

