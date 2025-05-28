Return-Path: <netdev+bounces-193958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB90AC6A00
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A16A3B5E72
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065A2857E6;
	Wed, 28 May 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="P1ntpBmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lX0N1t+W"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6A28540B
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437701; cv=none; b=AnjDj4m6igBLB3FbAbzI7Sh+GUp4wlcNkWEgwLiDEBNcYFOWzPfodTz1bTpJt40YdPs/4XSymFrtqBwMOxirp/8JaND9vlPcgxhdPBRP5r+gZ12EM0IbEZ4434pN0RSBdDpo6B7rT92qvLNPytCNchi7ZhW9p0G/7L+uN5iW5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437701; c=relaxed/simple;
	bh=rnsgtl+6En7l9FXSdKsKDMcpyToI/pRozDI707SaGM0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y83sF0WTZGbG78Dc4cE0L78PRH1MkiB/AFgUryPosSJlNVFJmXJqdGAi+dbsVzTh4KAo7Wm8bitH+efKaO9fhs0YdFTzvGgHiWMo93RQbGQJ96Tlmex1r4n/s7EQ1HYHzWYnPdCKNvDU+b7sQUEqfFNCuHlJ7HrdgUuVBTGhXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=P1ntpBmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lX0N1t+W; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 988742540138;
	Wed, 28 May 2025 09:08:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 28 May 2025 09:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748437698;
	 x=1748524098; bh=hMedc1Zc+k7/rjLSpbVYzOtOw/X+uoI1KrqaQAXFYk8=; b=
	P1ntpBmULprNjELhPKh/15l728/8G8PS9WJYA9N6ijH4/DAQTUmhHedzKf+rVRW8
	W0OQhpBs9q8xecDo36j9TqAFUJvHEF9fNfGquFLGu5IXFPzRVh3hNiSTLeV2bQ/n
	yM2uYUp25scWtWyuAwn5aULCef0gFQi2K6QLo0qNoZt7uhpdlGE8P6Kk1L3MqAxZ
	ig4ttU6M4rmoxPXFm7n49IpVz7otD33fvLrZSXjf4o8ltRodX1M3jl4y+3vfu9xi
	BXS54pvbDPkl3wz0ZxJ6zSZa3dz6ptlvyjvQndQ+L26K4hoMWXG3nRdkxKIQ6hUM
	rUlE8BzOvtH0idgbHfDrhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748437698; x=
	1748524098; bh=hMedc1Zc+k7/rjLSpbVYzOtOw/X+uoI1KrqaQAXFYk8=; b=l
	X0N1t+WwzwYbBSIyrs1PAHh2dnlyFfObOibHi/wh2UPaxk3WDqauzKNA6VphNRgU
	tzcl7N7tJuKacVa3xEpR1HjltDrVXXtlkDtLtAw2VEpjgmO/gUVJA2TC/RvUEZr5
	Stq9lMFDIoDoXgt9jSiv0VhCJfHmku2n6+woaY6vMLFcIulFvDModUxMdKj2Jtn6
	nU0y5Yz+IZpzV1D97H8xaVqlk4b5m6topFEsNbP4t15PNvEfnng/Qj5FIib/Lc1m
	AGC1DqsYRGmIk1VBoFjAqTl/+ikcWR9yPa/I/xQ3VHPIEo6HHH3opIJ1pAVtz3ha
	QLPmSaqcEJYJpxQzLasFg==
X-ME-Sender: <xms:wQo3aLU1zDvwVU28QJ_bwIxh1MsXP9sTPNjzjuS-Ya8NS6PLh3V_RQ>
    <xme:wQo3aDmYBa-Zz1630mIbFJmO7mZr4o26S-xO3S140rxaZA-v-7XP-unKDJRln2KpV
    lPDJd0RZefuWEfdadM>
X-ME-Received: <xmr:wQo3aHZeEUbwMnYAJSW-0x-E9l5z8x5nwQnnOGyJLYCJVBg2FupEGQjFZcsAxfxyDLWS0aSEcKJAiNeLNwThpCYS5lFH9G5Ma_rszXhksw4-jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeefgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgr
    rdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgr
    vghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlsh
    hhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wQo3aGWo7h3c13KhZwYDJiwWB5vapj1IR6G0P5hfGLzSgvfi1lu7bg>
    <xmx:wQo3aFk1SDlpQqCEWs0Zs7tJvqG5mO3r3QX59BZkxTDH8sVVynBLWw>
    <xmx:wQo3aDdJnyB2SPP6-tfK2MpFo13C969WDSy5kwZpOZHPI34E1XPxrg>
    <xmx:wQo3aPEn66Lhfj9Ir30yJS2XxpgyUuKCBZqmy4qvAlmf-r9Iy0dQwg>
    <xmx:wgo3aGtt0YzXFukQCvsBD0yxSgaezqHAHj5OsIS5mU-05chWKRxdlFB3>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 09:08:16 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
Date: Wed, 28 May 2025 15:08:14 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
References: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> That is something else. The slightly larger than 1000ms, means ping #2
> is kicking ping #1 onto the wire. The transmit is not starting for
> some reason until the next packet is queued for transmission.

You were right once again, sir.

I've not been able to replicate the 1000ms delays after starting from a =
clean
6.14.8 install. Ping is fast again.

However, there's still a performance problem.

The iperf3 client (red) hangs forever.

The server (blue) throws this error:
iperf3: error - unable to receive cookie at server:

And red's dmesg shows:
[  399.534149] workqueue: output_poll_execute hogged CPU for >10000us 19 =
times, consider switching to WQ_UNBOUND
[  399.572109] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for =
>10000us 19 times, consider switching to WQ_UNBOUND

Anything else I might be missing?

RB=

