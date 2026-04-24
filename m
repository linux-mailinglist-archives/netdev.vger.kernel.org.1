Return-Path: <netdev+bounces-280902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHqjGYHB6mkVDQAAu9opvQ
	(envelope-from <netdev+bounces-280902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A9458A48
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A36300916B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269E21D3F4;
	Fri, 24 Apr 2026 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkkSk2sZ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BE64;
	Fri, 24 Apr 2026 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992638; cv=none; b=QrW9YSKZ8b7qxV+NsG0BBG9gLdA6NBonr0BRjsB/8YtXVmQLqs3sb7YqRplZEfCLOvEGnzQyeM0xTamsGmTNlDABIQ8YOPvf30stRaAGlZ54JvDGCGeVxWnpTZ2zvmG3XHRMY7zGVbGNFGtPXQFIRQAfnFX2AK/3+ETagslIx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992638; c=relaxed/simple;
	bh=uT7gY4BRtjgaPX9PaajJO75AEADj3vGoYf34NRUkepE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jRAbaIutzR3B0KLS/U3hT1RlfCJC1jusqc0MVqHZmSSOTMUVocwrNzUZi9LF5D+J89kha/8MYoMo22vSNbZC4zXgKciZAIJHePUff7aDBw4Z9cewA8cKeYyIXKYrlwWYQ8y5tQBaIPr0m2sU/ajosjqjwf/Y/Sc7pBIdaEuRzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkkSk2sZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23B767A0184;
	Thu, 23 Apr 2026 21:03:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 23 Apr 2026 21:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776992634; x=1777079034; bh=rXMg7ku8R+JFnmla+6SGcWBeA0b7hTg/AD+
	QEyM9OnE=; b=DkkSk2sZMghdgvHOCh2vJqPFixGiQYiF/pPQBAIBhyDG/jCucsB
	lq7BJofCWG0pYPqhzIt4NP54Q0owled+gydYNhb+IPkFrxh1D2x7I/hcNTUWHCip
	sj97mQSBxopfg74854n+KEuzPhM5Fn7Rzc+UT0R+R264Ai4n3Tc/wHVXKmTlhNZ6
	eLBdD/JaiwjHQ2zp8qR9GukdmSzujQpCK+t/03QVk67/i6YCRipuwiNmRDLGBxrn
	dT7W443tTovkKwQY+nUSyEVqXak8aBQIUzAKw7OpWc73fFEo5Nbdcnx7DuXAcIq5
	wNSmp5+oQav6nZgAPQE+6YML0n+Oo0RHg0w==
X-ME-Sender: <xms:eMHqaQQObEnmHyjxO9SmcFPARqnDhlNSje4pWmaBRcEzCEmkyxt8dg>
    <xme:eMHqafImZB2uOsfTRJv4iBIernwUSSibtdQ5FgVQb4v_6_Rv8TamjvPljZdA5Jx7V
    lzpx7wkhs6vOps7L8nZxirjt102Fs96s75XyCe8TEmGKffqVr_jUng>
X-ME-Received: <xmr:eMHqaXHAcN2-R24bCe4acyhvj_ieBX1Nda-6-qIST52PaquMRtplNqdO0LEgMezE3IMU737EumstSD8EmefzuG6A-uPMK5Sdp1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhr
    tghpthhtohepuggrnhhivghlsedtgidtfhdrtghomhdprhgtphhtthhopehgvggvrhhtse
    hlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgt
    hhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomh
X-ME-Proxy: <xmx:eMHqacQsCgDgUpkdMpJ7lRjIDDACgZ4OqRerysW9vkEYisKXaRCvTw>
    <xmx:ecHqaQUx43qxvgiwPWL9Y139sZ98TQrP5aAwvvoIUe7McFxGpR3sGA>
    <xmx:ecHqabi6RQxL0-iHr-8xqmA0SiYO2obMIXVcG9IfDaaMIXEUpMROTw>
    <xmx:ecHqaZciAUM081Ydoa2dPBMCTN0_hLONMIL3_b01EXuoiF2p5IQEzg>
    <xmx:esHqaSk2g-35ngOG1BQQKF3w17i9wTrZeZ3lSrneWIqz2g5wtBEVSH5B>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 21:03:50 -0400 (EDT)
Date: Fri, 24 Apr 2026 11:04:02 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Jakub Kicinski <kuba@kernel.org>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Daniel Palmer <daniel@0x0f.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    Michael Fritscher <michael@fritscher.net>, 
    Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org, 
    netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH net v2 10/15] drivers: net: cirrus: mac89x0: Remove this
 driver
In-Reply-To: <20260423150240.07c350a2@kernel.org>
Message-ID: <31926a28-658a-1df9-d5bc-2b010891e7e7@linux-m68k.org>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch> <20260422-v7-0-0-net-next-driver-removal-v1-v2-10-08a5b59784d5@lunn.ch> <CAMuHMdV-vF6sTvAi8kKzxGwZ9YUSBO1Qta5PDCRbA0zr-LEp_w@mail.gmail.com>
 <c0c80113af470b265650405fa24deefe2d82ea24.camel@physik.fu-berlin.de> <CAFr9PXnECog56b+Jq9TBohhQ4oBB3hGV1pHj6OstOSLqkOpcTQ@mail.gmail.com> <aee0393e2a2bd5a5d0bf8aee758122633e54aa06.camel@physik.fu-berlin.de> <20260423150240.07c350a2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Queue-Id: B87A9458A48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On Thu, 23 Apr 2026, Jakub Kicinski wrote:

> We want to be welcoming in the community. But being a part of the 
> community means participating in _work_.
> 

The work of testing drivers requires that maintainers have ready access to 
actual hardware. Behavioural simulation like QEMU does not cut it.  
Therefore, it sounds like you're going to need someone with actual clout 
to mandate that drivers must have maintainers and those maintainers must 
have access to working hardware, or those drivers get placed on a removal 
schedule along with _every_ other orphaned module across the entire tree.

That way, you get to chase _all_ freeloaders regardless of whether they 
are unpaid enthusiasts or foundation sponsors. Surely you'd find out what 
"welcoming" really means -- but you would get to remove a _lot_ of code.

Far more likely, you'd find out that the typical Linux user is actually a 
retro computing enthusiast because he's using some device that's over 5 
years old, and the employer of the maintainer of the relevant driver got 
assigned to something more profitable years ago and all their old hardware 
got tossed out in the last office move. (What was that saying about those 
who live in silica houses?)

Anyway, I think there is a better way. Let's score every module based on 
cost/benefit to the "community". We can use retail sales volume as a proxy 
for the former quantity (in unadjusted dollars) and use module size (in 
lines of code) as proxy for the latter. If nothing else, that would show 
us which modules are more or less valuable to the community, relative to 
the average module.

