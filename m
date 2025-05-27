Return-Path: <netdev+bounces-193735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA60BAC5A53
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616733B63BB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A89280036;
	Tue, 27 May 2025 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="t5AAIkbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWe9HJ4F"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5919882B
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748372276; cv=none; b=fLoIjpxcf8OuOfIzGmmVV2ITQ3X2zcATlP8lw5Paf+DlhbQRZK7RdEM+g8RAkucmfhSUp+PQ9JFD1Eo5a39d71xFImDTsNRdSb9PE2X2HpH8khS9BOqWQQ/izE1BQLJbQ/EyJ1EytsCTVZRDnSGYz+v3ZHxj8pZy37ghI2IhyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748372276; c=relaxed/simple;
	bh=ReMaeufoW0IOCJFt/dwLLvwFELmxBmkbWh1Dh6JlYk0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XuMMV+Nh+fssn3VkW8bdogWfb+L02JtxnTBZRSLQtcM8ZUQ5d3rbsFz+54KyX/zs1YUFGJTSzieDzl8u9ugqrednNB/cQJ2wUowT4mDiqooi6HAZT+7vNgL9bHG84aDcSmiQkRVg3OxCJxwOl9Co2RPmfrh3/haQ728ndhrARc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=t5AAIkbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWe9HJ4F; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F93A1140175;
	Tue, 27 May 2025 14:57:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 14:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748372273;
	 x=1748458673; bh=Oz6r1zOPyxqk36s1Umrc+PFfiiT7D8/L1YhaA7Oe59I=; b=
	t5AAIkbbwQK3t44dY1HIH+OW185wdN7MAjiH70gkCGwNyJzIF6MrkdC3u/M155v3
	44WIOZR7+5aEwPlgLiCDG8+jTFg0uQc4qBFcD2/BW1qum3/gGPI3hd+BIVLZK8oV
	Mlzz7OP6gCq2/kgeOpIynFW3nTvdWeaOZCG6a23odXR+S0Y7WRUxfd0fwloFpNV2
	u9lT+ScoWI/5Ta2Fpb/bBYzlccG4WELc+jXiHfzD6mx1+XUW7IYIEx5OCBZdcJgA
	B7x7ljWaVguYEqlbyHJF78jJd+pQQ9+VxRUA1chLoD5HrUv/VPkqkq2EVVaJLbel
	fxniqVKjGPGANWQIT+MKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748372273; x=
	1748458673; bh=Oz6r1zOPyxqk36s1Umrc+PFfiiT7D8/L1YhaA7Oe59I=; b=V
	We9HJ4FqPQ/QkIPfg3diLxOM5ktrAwvy+nUwja7UUFs8GJIJVU0DVFTjZImnj+FT
	CEn89lUT1VtgWXSQOaqFHYTI6mZz5bdV6DJ6XCBtSO/bm7DzGTKzZ/yVH09SEYJi
	Ugo8ioxUZ17dX/55z90y/hA4Ikmbha+GfHHwU/Xix2boBKw2BUuTtlhHKjonhX7n
	D4bLb4IvzIb4YnyjVHplNDuL6IbBHJmaPVsbiNxOHFiNsVZdiM4NFMfD9y4e1ta2
	UbeQ8M1S4VFQe7oSbLZv7mmS26yJswB/oEjwwjdwgKQFmL8TJZMLNcHvVibTkG4T
	S5jtFXwDqFRu5f34FxDtw==
X-ME-Sender: <xms:MAs2aPzYlqmzxbYTacJSODlyvTN07Hh_8x0Buysb-jTa8RvoZVABhw>
    <xme:MAs2aHTncpT9W-dOz1tkDEXNOTTFusgpqSvWBJN1KwKS7DbrXCswHN1IwJPKGv92v
    rG6JF6yrT2ZmuKQDJU>
X-ME-Received: <xmr:MAs2aJUcL1925J4QJ2CGKGv2WszmsnCbgvgif77hNI1YMByVyO8k8SUBnj37DHL5ox2DzfpeilJvMlXQhnrkHW5V4YMyd_a0ZVMp7_2WsRx7Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudduieculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:MAs2aJh1_K70kQsn2mnnMHNWgAjyUC4-XcemzpiXCes02RzsO24B1w>
    <xmx:MAs2aBBmiMd2EV8b19qrNJJLM-Dt0ylgQ2GGdfnXWXHuECgg3ojnVw>
    <xmx:MAs2aCJxbPgYAEaISvBl_kUseqeG4NYXvH5f9DUY73zkcZAK6pHf0A>
    <xmx:MAs2aABJxm3f94zLP_en-jEku4RMa_-Lq16axMyzgvGU9NpzU_Z5gA>
    <xmx:MQs2aHIujtTtOEBDP0QaLS2VGWItZfUdrfAIw9IKWuj-3IMoKoswmphN>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 14:57:51 -0400 (EDT)
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
In-Reply-To: <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
Date: Tue, 27 May 2025 20:57:49 +0200
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
Message-Id: <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
References: <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> Maybe hack out this test, and allow the corrupt frame to be
> received. Then look at it with Wireshark and see if you can figure out
> what is wrong with it. Knowing what is wrong with it might allow you
> to backtrack to where it gets mangled.

I've done this:

diff --git a/drivers/net/thunderbolt/main.c =
b/drivers/net/thunderbolt/main.c
index 0a53ec2..8db0301 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -736,7 +736,7 @@ static bool tbnet_check_frame(struct tbnet *net, =
const struct tbnet_frame *tf,
=20
        if (tf->frame.flags & RING_DESC_CRC_ERROR) {
                net->stats.rx_crc_errors++;
-               return false;
+               return true;
        } else if (tf->frame.flags & RING_DESC_BUFFER_OVERRUN) {
                net->stats.rx_over_errors++;
                return false;

Then set up iperf3 and tcpdump, but kernel panics:

May 27 18:30:32 blue kernel: skbuff: skb_over_panic: =
text:ffffffffc0c1b9e7 len:1545195755 put:1545195755 =
head:ffff9c9dcc652000 data:ffff9c9dcc65200c tail:0x5c19d0f7 end:0x1ec0 =
dev:<NULL>

This is the last and only line I see in journalctl.

This only happens in tests with loss. 1/10/100Mbps doesn't panic. But as =
soon as
I get near the ~250-300Mbps inflection point I mentioned earlier, it =
hangs
forever (panics). tcpdump doesn't write anything to disk when that =
happens, so
how could we capture this?

Is there a way I can tcpdump or similar before the driver reads the =
packet?

Perhaps modify the driver so it writes the skb's somewhere itself?
Would the performance hit affect the measurement?

Thanks again,
RB=

