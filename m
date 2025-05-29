Return-Path: <netdev+bounces-194169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEFCAC7A4C
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6561BC4E87
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8884C217722;
	Thu, 29 May 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="ZfoA4+TX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLXobMza"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0E21ABB4
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748507906; cv=none; b=O32ZSUZabBUVh3H++oY9gGrus6w9ilp/aLfr0Gdfl+J61mFlvwv5nb9VjAHuWGtYxJW4hCUa6H6JHHxduIKIvLfre/4ItG8cSF8ar4389CqTD/g9ysaOB3EFq0bUOzFCgqnSS9fOLUvp5gl/6Z9RiSawMUnJHulJwaMOMT6Kogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748507906; c=relaxed/simple;
	bh=ozMl+Mw/EdGA0GLQXZF2ephaOPbJcG3lJ6h9Z+6J8mo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M7rfeOI1CBoT0Gqg2CyUMmRuAckKUywoakCqb/89MfWM+gELMR8RBoPPIR5TAYqoJgUyAZoEtGCa5UvaU+URYQK1IkXSt2/Y0TwFWHxwthhPlBNG2iBdzs3Ma7EKF3MIkP7Exbz26erSoesuUD+rJGKADfxnA++uoWU+2aLY2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=ZfoA4+TX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLXobMza; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A6E5A11400D3;
	Thu, 29 May 2025 04:38:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 May 2025 04:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748507902;
	 x=1748594302; bh=/Dsp2zqq6PdJdh0xEXGsNbkmU4aPykRpxGwlWaOb7LE=; b=
	ZfoA4+TXcyzWtC68Ffol4nN4kd+My27m98ec9DaLi1jn/7i4gt3w/dra1AgT5ny1
	4D1h7dcR+Yfp6wtM+spoc7FaXB98TYnqZjuLh8X8kBfOd0VaX9duW603gJJID2CG
	2L1cDg12ZusFmiK0Xst1x/y9XwZ/m3N0EXcRPhIaENsFoaXCnAQlzRODOvdK4C0b
	9F/EUlzseoPZXBVKBYAtayxi8usU2pNxADFUt91p6z2Sp7h0yybLCuzSLEShNkI1
	eBr8I+j1sqpBLABIpabxguULknjehqNFZ+CWOP9stQjd/k4q8u++/u1v/XLpTKX2
	Jlm+ZMuKGrYk+/xgSE+51w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748507902; x=
	1748594302; bh=/Dsp2zqq6PdJdh0xEXGsNbkmU4aPykRpxGwlWaOb7LE=; b=N
	LXobMza+O1qRh5nEGPijr+yHwgBlCgUjdB8A2Ga0EGzt4QqtjCANStuP215dY/6S
	EKVUw+vACB3Opy2iDdggDTt6vmqDCnnZoFp7HPjQXiOI6/y1PvUtdwBDRPJb0Uyu
	k+FXoSrMg4QT6Qbye11EQPXbPM+xVj3cf6gCNpYu0gaYahMiT0fqrYHRBkRuKPkA
	0zArfznYzRTmq47+mZoCKJ1lZ6cshYAuznB5TLs5Z27UtgBWbIbLaA6Lgbd6vpP9
	zL7tJRBWaVdIQ9whiCTHGNY2o+ml7nXMdR9kFLG1R8G2mDlQUD0EP9T7hwWB/1rm
	MadsVwzjE/fE2MlxkrHOA==
X-ME-Sender: <xms:_Rw4aDRpuplUpRhhV8Pu5Q5URwFxKtNjMObzzA_yNcsLhKCrKFndrw>
    <xme:_Rw4aEyfyUphf1lofLzT3PEzLK_iUfU0r6hSXCCwNVVBRxjXa6vzG-jyLpPYfhFMk
    ivTZhNI1wnYlFJpHmk>
X-ME-Received: <xmr:_Rw4aI1zZ7aMjl0lBdNAHiigdj6N6O9RtrQsN6MaFBwFXghebZasz8SKJJm_3embC2p7rlkiWggiS7cJfFHAhY_8xTCCC46QJefFd4ZVqXdotQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheeijeculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:_Rw4aDBNvKzs1f94XpFVb2tl1NaU9CaSM9L3LDX_LK5Dxy7QepvAbA>
    <xmx:_Rw4aMjBCb7mIoltcf2UtGbsw6vUbtd8OU3Jw1F4MytF5ln8Ye7KIw>
    <xmx:_Rw4aHrOh0NWnBSBISdWA07-y9k9AfdwXcC7SPgNL6rYiGCPs4xJKw>
    <xmx:_Rw4aHgXaluxxDlaJKMYzqf4Uau-RbDNJ-emVRBm4Z6SZ8XOhcZOtQ>
    <xmx:_hw4aKosmMJg8y-GG-wXNftTNrSEFX0kbIUCa8mp7Q1wXAf8BNhY7Dir>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 04:38:19 -0400 (EDT)
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
Date: Thu, 29 May 2025 10:38:17 +0200
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
Message-Id: <048AD01E-BCB0-447D-A0BB-A1D9074B9D2D@bejarano.io>
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

Okay, so in my ignorance of better ways to keep pulling this thread, =
I've been
sprinkling net->stats increases (of error types we know aren't =
happening) all
over tbnet_start_xmit on the tx side (red), to figure out what pieces of =
it
execute during various tests.

And after various tests, I've found:

1. Both lossy and lossless tests follow the same execution patterns, =
which rules
   out any specific branch of tbnet_start_xmit that might've only =
executed in
   lossy tests. In other words, it must be something wrong with logic =
common to
   both lossy and lossless scenarios.

2. We never run out of buffers, so we never execute L1123-L1124.

3. tbnet_get_tx_buffer never fails, so we never execute L1129.

4. data_len is never > TBNET_MAX_PAYLOAD_SIZE, so we never execute the =
while
   loop at L1135-L1183.

5. In 7 sk_buffs per iperf3 test (out of tens of thousands), I've =
observed the
   following three differences:
     4.1. skb->data_len is > 0, so len is < data_len, so we go into the =
loop at
          L1192-L1208, which we only execute once, so len must be >=3D =
data_len at
          the end of its first iteration.
     4.2. frag is < skb_shinfo(skb)->nr_frags, so we execute =
L1203-L1204.
     4.3. unmap is true after L1204, so we also execute L1213 when that =
runs.
   Yes, seven. In both 10Mbps (0/4316 lost packets) and 1.1Gbps =
(43715/474724
   lost packets). Also, from other tests, I'm somewhat sure the very =
first
   sk_buff in each iperf3 is non-linear.

6. tbnet_xmit_csum_and_map never fails, meaning we never execute L1216.

7. frame_index is never > 0, meaning we only execute L1219 once, we only =
put one
   frame on the Tx ring per tbnet_start_xmit invocation.

8. net->svc->prtcstns & TBNET_MATCH_FRAGS_ID is always true, meaning we =
always
   execute L1222. Makes sense, the Rx end also supports =
TBNET_MATCH_FRAGS_ID.


I'm slightly confused about the following:

skb has three lengths we care about:
  - skb->len is the total length of the payload (linear + non-linear).
  - skb_headlen(skb) is the length of the linear portion of the payload.
  - skb->data_len is the length of the non-linear portion of the =
payload.

At the beginning of tbnet_start_xmit, we define the following 2 local =
variables:
  - len =3D skb_headlen(skb)  // which is skb->len - skb->data_len
  - data_len =3D skb->len
As a side note, this is confusing in and of itself because we're =
renaming skb's
headlen to len and len to data_len, both of which mean something else =
outside of
this function. I'm missing the "why", but it makes the code harder to =
read.

data_len and len are only modified at L1194 and L1203, respetively, in =
those few
occasions when skb is non-linear, otherwise they remain untouched =
throughout
tbnet_start_xmit's execution. And since we see non-linear skb's in both =
lossy
and lossless tests, I doubt data_len miscalculations or tbnet_kmap_frag =
are to
blame for an unaligned memcpy later in L1210, though I'm not discarding =
it.


I also found this confusing in main.c:L1316:

>    /* ThunderboltIP takes advantage of TSO packets but instead of
>     * segmenting them we just split the packet into Thunderbolt
>     * frames (maximum payload size of each frame is 4084 bytes) and
>     * calculate checksum over the whole packet here.
>     *
>     * The receiving side does the opposite if the host OS supports
>     * LRO, otherwise it needs to split the large packet into MTU
>     * sized smaller packets.
>     *
>     * In order to receive large packets from the networking stack,
>     * we need to announce support for most of the offloading
>     * features here.
>     */

This looks weird to me. This driver does not support LRO, why would we =
rely on
having it? For peers running other operating systems?


So my next best candidate is tbnet_xmit_csum_and_map, but not for any =
particular
reason, I just haven't had time to understand it yet. =46rom the looks =
of it, it's
the one place where checksums are calculated right before we put the =
frames on
the Tx ring, so if there is something wrong with checksums it should be =
there.


Any ideas?

RB


