Return-Path: <netdev+bounces-193640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1FAC4EC4
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51E23BD597
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AB240604;
	Tue, 27 May 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="Pqm2pbop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8loteoO"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433D253F15
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349383; cv=none; b=pAqUHYd0cPLu23QEYj+30AP4DLMuxf4mQs9sl7e3EtyE7BAPNvjb8rQBqW75yxtqbX754HNo88giiFz79sG6/5aYNdlDFYb6ews7/HM3VLtPuE6L+5V0541/UQUgl8fTNdbk4ecc/CBx7vjjLAcQG+v78bwcHN/HhO5PYVwMLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349383; c=relaxed/simple;
	bh=ajb11xB5zks91BeF2ArEQvcmXFHGIbGiDFh81zLKwmo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nfKV8ugxznbmN9e9Pfd/3MRjESMij+5/z8zAV3GrXq57OU2WGVTUesp6YnKMkQfOFK4oKThhzDUqokXA0s16fRCLxsnVakcF5Ug1JNdEuE/rkSo/29eHsQP1oGRjvxQiqAGY57sZpwlRDY6/EGH1whfNEnR0yUq7E1iWKRud/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=Pqm2pbop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8loteoO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3870625400FE;
	Tue, 27 May 2025 08:36:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 08:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748349376;
	 x=1748435776; bh=4iu8tnBLDqmWy5BFWmDpmiRA9LgWWCouESmceipbBNE=; b=
	Pqm2pbopPHIKZYp6aKfqs9PWg3k9BS9ZVc7RGgc9c4kfuYZF2tb1gFA89hJ+sGXV
	5bhT0xiSi3bEFIbNc32PFbNpQiewFIkpnriQPRf3UPS2iiB1JKEuThExf5k3r4GD
	Ud6Cmkl4ilbJnrLSAmT53zDrzam4BCDxqHrpI97v+QswSKrUOqMxf8AEnS2bmm+K
	MLfoDe81Q5wac2spW7B1kyPYZcelYXFA4aYjM/Kez7zQ++7W9V83qF9PA8uOL6tM
	lfH/duZkrwTTLhQvglJkc5ilacEifTGx5PjbbaUPJEojxGA3RCgV3zIv5ojrNyTd
	rpDl4T/JPRD2MxBFlvFlbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748349376; x=
	1748435776; bh=4iu8tnBLDqmWy5BFWmDpmiRA9LgWWCouESmceipbBNE=; b=P
	8loteoOx5d/eyb0UMBBVPTD/t+4ABaKCoh0ZCklyvofRCymSabP0onQ6gbpOGnJO
	bO2RIm0xhmpLrFYnbSQ5QZTnHGrdMd1NsSl/y7wtVDMqUcV7EgGmVZ+JaxcDEPbR
	UB3bqF55tcACbo5eWtYB1MkOl0yYPRfE4mDYRm1kBo5T1XTS2XHEJPcSzrLilaNS
	bXM0P122Swnv6o64GHSGS3lGKOjUSX1hiQAhbwg85Mb2PvZvqFlcbDzjWNxq3+Ug
	JL+wz5ySp7W3hi9L5sx2A7gJj991HXY65ci+Llg7eb6u1NsV1ME3bssuO75DC7a3
	aGhTinQHkLJ/lzXppDvrw==
X-ME-Sender: <xms:v7E1aKfg49DXtl-n325-n0pN5xJYo4oGja7sumtubi-xeQG2bmIpoA>
    <xme:v7E1aEPNxuDwkWC_qh5vzikw0fd0_mnDUNi1M8eRfZk7fHk8GyV_SWKhvQD-mHdg9
    82aSpMywT2jnGyf-LY>
X-ME-Received: <xmr:v7E1aLjvM5zWAr0j3rP7Xx12bEngcsGxugVRZ_KnLnXEOzjZo-fjwrOU8ND5oZTS8e0wKTLjcZetsYbRY1pqdxcJg-1WnKxSFq852n3jBFgIXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdegtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghl
    rdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlhdrtghomhdprhgtphht
    thhopeihvghhvgiikhgvlhhshhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnug
    hrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghv
    vghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:v7E1aH_N__2j7krFmDOcCdT69DllYf0AjsoaHMv9nYWmS94-0DQJ9w>
    <xmx:v7E1aGtd4scukj3hON_HkxYUeyQOjUVMNCaKW-gGnd6d1rxJCOS36g>
    <xmx:v7E1aOGE2uS73HnreSrd9plmAm0mjpsWOL5CD6NB_8d2D4eOKqjl2Q>
    <xmx:v7E1aFNLdtQq83VY0yWjsPoiwhWSifqu3Phk5QJtH42X9gBJtJ_9eg>
    <xmx:wLE1aCenxvVDup8kvMw7I8lKOxDb9ph4KOiL6J67Ad9RDHdFIxx-SPHQ>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 08:36:13 -0400 (EDT)
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
In-Reply-To: <20250527103356.GS88033@black.fi.intel.com>
Date: Tue, 27 May 2025 14:36:11 +0200
Cc: netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <69080E6E-C5EF-436B-92F0-610183C5ABC0@bejarano.io>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <20250526120413.GQ88033@black.fi.intel.com>
 <55F20E80-6382-43EA-91E0-C3B2237D79B7@bejarano.io>
 <20250527103356.GS88033@black.fi.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Thanks for the hint.

I've made a test with end-to-end flow control disabled, just in case:

root@red:~# dmesg | grep Command
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.14.7 =
root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro thunderbolt.dyndbg=3D+p =
thunderbolt_net.e2e=3D0
root@red:~#

root@blue:~# dmesg | grep Command
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.14.7 =
root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro thunderbolt.dyndbg=3D+p =
thunderbolt_net.e2e=3D0
root@blue:~#

Here's iperf3:

root@red:~# iperf3 -c 10.0.0.2 -u -b 1100M -t 5  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 60610 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   131 MBytes  1.10 Gbits/sec  94896
[  5]   1.00-2.00   sec   131 MBytes  1.10 Gbits/sec  94958
[  5]   2.00-3.00   sec   131 MBytes  1.10 Gbits/sec  94960
[  5]   3.00-4.00   sec   131 MBytes  1.10 Gbits/sec  94958
[  5]   4.00-5.00   sec   131 MBytes  1.10 Gbits/sec  94958
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   656 MBytes  1.10 Gbits/sec  0.000 ms  0/474730 =
(0%)  sender
[  5]   0.00-5.00   sec   601 MBytes  1.01 Gbits/sec  0.005 ms  =
39672/474730 (8.4%)  receiver
root@red:~#

And here are the interface stat diffs:

1) red's br0 (10.0.0.1)
    RX:  bytes packets errors dropped  missed   mcast
         +1080     +15      -       -       -       -
    TX:  bytes packets errors dropped carrier collsns
    +707349348 +474748      -       -       -       -

2) red's tb0
    RX:  bytes packets errors dropped  missed   mcast
         +1290     +15      -       -       -       -
    TX:  bytes packets errors dropped carrier collsns
    +707349348 +474748      -       -       -       -

3) blue's tb0
    RX:  bytes packets errors dropped  missed   mcast
    +701384878 +470745  +1088       -       -       -
    TX:  bytes packets errors dropped carrier collsns
         +1290     +15      -       -       -       -

4) blue's br0 (10.0.0.2)
    RX:  bytes packets errors dropped  missed   mcast
    +694794448 +470745      -       -       -       -
    TX:  bytes packets errors dropped carrier collsns
         +1290     +15      -       -       -       -

We have lost 4003 packets and have 1088 errors at blue's tb0 rx side.
I still don't know why iperf3 reports 39672 lost datagrams.

In any case, from rerunning the various tests, it doesn't seem like =
disabling
end-to-end flow control has much of an impact on overall loss and =
throughput.

Thanks,
Ricard Bejarano


