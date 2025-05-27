Return-Path: <netdev+bounces-193675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2984AC50DC
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EBB1BA189B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015627700B;
	Tue, 27 May 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="a/JbTGWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHxbwaSD"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571419CD16
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355924; cv=none; b=Pb3wzoL/hDxy/BWRRTM+aZDVEzCFav6Eh1hMGMeai2QqAM4G7ye2jCil4aOwl3MIjw74IhfsIPAMaZnR14k4/Y/OqU0fg5EjUH39V+IbPSkUdKTp4Dcpy8FfrvBhpWhh45q/2NdKA/vPhFqx7USIG8vl0TJPmZI1yszNqgkQjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355924; c=relaxed/simple;
	bh=5azk2O4rIieZoEA26VHjIlb1KbIw3a0WOAAWIZQ8IGA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RpUrmT4EAgUDkL7SrCwVd3jLmWu8I6RFc5Qq1/EDcW5DX7jma2kVN5pfEnZ9m7C6dxXk4Sl8KcXfUhL4Ui2i1cJD1M+iRpMdXRrwaDCtpiQPyP3NUODH9ANjrjgWQmeYfv7vvw3PxSifTDlzqWNozQgba4gTuFBgE5NGE/MVLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=a/JbTGWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHxbwaSD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 923311140104;
	Tue, 27 May 2025 10:25:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748355921;
	 x=1748442321; bh=IqXp/VffkKWEbVJWizqAt22KX3AyhqcrasP5fBVrBNM=; b=
	a/JbTGWYHxIX3gmoNj3YFzgEZqiWBNjiSmmJJnelYgUxv+DV2Ogl40GBdQy7NInb
	EhCeP9PB5r5hhVHvZEbRRLGisQWfEi+ScibETx+6nvICtXvqHwzKOz+XZdBT1onO
	BXB3+pkB4OoenExTKOJAzlNb0ulYW1LOfb8bW1z7Z4gMZH8TEKlS3+7RsTH35hiE
	ryhGa9o/on//Fo4uYqYA9eRSgzTgFWImpJ0PXI5CH++bJlbaadXfh+MUc20fpKKv
	auXs9Tj15v1dEeX5t7MGDcioFzoQU5/aiJgdc9N4dGzkMo3ye43MT6TsxnTLBQfS
	Mu11B7J9DDZXSm9tIkjJcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748355921; x=
	1748442321; bh=IqXp/VffkKWEbVJWizqAt22KX3AyhqcrasP5fBVrBNM=; b=i
	HxbwaSD9otLq+avnx2j1XUvgulVL1p0eSygQMcyASa8SOEGaRf5rvVps6xohkDl9
	2eAFrT0RO7uxGkYkU2I5Ql52iNuDmDngOYv+TDFPYX17S4V4as4Vu33Ad7bNUZSJ
	sMg0IEDymXgZ3AAV9nPfEL3n46LZEFjdIwJT3XxjK0Ege5YpPkuRkMvo5Cx91ThJ
	3gJHRvcsWffVB+PZclUkEthIc5ELF1QcrJzloUI800gxl70vqQ8LJPCMhAdAbr+P
	OMKDNqLVeQ9WWqDu0SZWtMYkAF5+hFFsobYydWxQgO6hfLILXBGlu6GxLCrxxmns
	CoMDyvSUErnO28Pimd69w==
X-ME-Sender: <xms:UMs1aKxL7hXy71REMmS_x2g_qd6yeiy8F29LZ7jKGSP06YscweVZTw>
    <xme:UMs1aGTc-KBywKc_iCUtvikekS6IeVc-Q3BTzVrSStKJUug8aC10NFA8VfatDgs6_
    umBakarbYQ6hWmYqOw>
X-ME-Received: <xmr:UMs1aMUGiPshsWff_dpApQ9Sn2wyzHEaCTC70g9xslhtZO3bj7OMzc8qm0vAcwQfgV0q-ldxfDaNauHKEzE2FyQkX-iytj05d6jvRFJ6l1EmoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeiudculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:UMs1aAhMf6eNFJhFQGmA3GyAeMMHFSvVloFq4wtlhCdEwYuKP_J3NQ>
    <xmx:UMs1aMBTJvPpuxR4h-VbG7GlqNyliENfE-LxhQ9cyY7k2itNUftliQ>
    <xmx:UMs1aBLFdixk1LH9aX4kScMBFoZewZEBvDTIWLyymCu2HLhunLZPBw>
    <xmx:UMs1aDCm1V7y42EGN2ZFV3zd_3VuhwzA_95MXt2AgDFHrXpXLpZwwQ>
    <xmx:Ucs1aCINRNayKiKQ0U-nIOZrpGrdzZsp4HG5n0mpSA0WPcEDIPrRswx6>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:25:18 -0400 (EDT)
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
In-Reply-To: <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
Date: Tue, 27 May 2025 16:25:16 +0200
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
Message-Id: <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
References: <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Ok, I was going mad trying to find CRC stats for blue's tb0.

'ethtool -S' returns "no stats available".
'netstat' and 'ss' aren't much better than 'ip -s link show dev'.
CRC verification is done by the driver so 'tcpdump' won't see those (I =
do see loss, however).

But, I do see the thunderbolt-net driver exposes rx_crc_errors.
And then I found 'ip -s -s' (double -s):

root@blue:~# ip -s -s link show dev tb0
5: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP mode DEFAULT group default qlen 1000
    link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast          =20
    9477191497 6360635  16763       0       0       0=20
    RX errors:  length    crc   frame    fifo overrun
                     0  16763       0       0       0=20
    TX:  bytes packets errors dropped carrier collsns          =20
          8861     100      0       0       0       0=20
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       2=20
root@blue:~#=20

Bingo! CRC errors.

How can we proceed?

Thanks,
RB=

