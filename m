Return-Path: <netdev+bounces-145131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBA9CD546
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A74AB22BE8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B513774D;
	Fri, 15 Nov 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="uWybSv8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMu5XKYv"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532EC291E
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731636746; cv=none; b=FpBdQghP40BGowpBpqpjxWg6mnD7eIpgHjO7XkB/hHzRLBEDFXJ3r0QcDMd7Effv0yXr1JqyRWaaYZ72o+pTp0ju6twyqPcki4BgM4fJCYu+1FsT2JEW6oW9BDS3Rgtbo0u4RxOm2SJcTBXBI8OIUXaHsJ0eQ7dTmFu+fpZPqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731636746; c=relaxed/simple;
	bh=5lbiM83GZNkB+v7CWSZI2xQfVUgvV8U01Akyh63m6vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPe7nYUdU6UaW7HUZ9Y2TvABJYjqrD6JKwOkQ9PNMUUSDzPFjuuqYC3pKwru6QLrsPg62lpOR1DE4Z8bHarMtv7lTdwVBnoux8M8eq/mCNv58B1IOsU/e8iqdAYoPyDV95sy0AyAioR6hVaJ70vCsLePF/56+bw2YBafZ3JBOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=uWybSv8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YMu5XKYv; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CED61140161;
	Thu, 14 Nov 2024 21:12:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Nov 2024 21:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731636742; x=1731723142; bh=3MXALFIPQ8U9cEaGFIFOj
	M6+PoQZ7RDO/pK8wsmNRoE=; b=uWybSv8fphfHrZ1mUQq2P8oNZfN4PfHfkH5nI
	vCIWih7z6/hjnRlbiparxwJgEe3IFu8Iyl6VnbhWyfvowWuRhMdKHCHVWeNQmKzG
	KvFD9KJC9tRmB8ND7a2Pba+R01CfEOh18pHZff8V6S8G+Fhhcqsi3eebROu7xswP
	Jc6nO96pYZ8lgQK9K41cFgwZAwYjUkOdvkV0xsHQwR16xKPX/oIyGPJdQyCLEyIF
	DwwihnRTfkL+6sQSx0sgmgsS0+4EHlNeAUqED/IEFwUGpEpAyl96p4+0ShVpklDT
	kXLA1UyDvM49UP+OQGbkW2ZOsIZKYJXOZU/OAJMx/oV+tQakw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731636742; x=1731723142; bh=3MXALFIPQ8U9cEaGFIFOjM6+PoQZ7RDO/pK
	8wsmNRoE=; b=YMu5XKYvFG8zTi48xtjWq7mWdUipoLzqjLKnxFk2lO/BZ0WYL/Y
	h7XoXHn2nywwPpbl1aGSolv2f19BYP1Dp9uX+qN/YCMhSp43xXY2mAlapyj3eITO
	9gt+j4/ttuefZn9bmGQrLcyyxbiloonjduL32X0AOEqmv/3taAbkQA1TyPy7cBr0
	XRSuig/K8JQj9urts677H5aro/CPtybgKfxmw+jjNiuiZGixdsK0zB2gN84ZHQGu
	QeWLksiemhfsHRI3bRoKpAS3Dc+B0Zydj+O+FqJHhQ/uRNJrVg7J04KOqy1ldgKu
	u7frhxMbu7fU3w7dUoGeRoZcVyVoLmnblBA==
X-ME-Sender: <xms:Bq42Z157kbwvdBXumLE0t6qliaz3xEXa8ZULr5_VN6YUqvmzW54hdw>
    <xme:Bq42Zy4XZoXvvKNixv3p8DOcTzwnm3pTVW2htGtTMkNWS5kTyVHaVTgaMy5pFtK7N
    qudcU8bslieQWJIyg>
X-ME-Received: <xmr:Bq42Z8eKE78ujClu63xvD6t9xVzkfRDpYFvx2dzoUfI-qZpddxQ86Pbb-m05GEaTITlTQNvej_V84mojid9NKoCo4gXMmvFGCnQzfurcQYK1-LYp1Fwr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvge
    fgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuh
    hurdighiiipdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegvtghrvggvrdigihhlihhngiesghhmrghilhdrtghomhdprhgtphhtthhopehjug
    grmhgrthhosehfrghsthhlhidrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepmhhkuhgsvggtvghksehsuhhsvgdrtgiipdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdr
    lhgruheslhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtgho
    mh
X-ME-Proxy: <xmx:Bq42Z-JMWLCKLTkcmtxcwmO0kvrPz0LykzFkeBT8PP8p6G9WWjAPYw>
    <xmx:Bq42Z5KMR4O7fqN3NEDIBCJGmg1RWYbvja2639RGzkYEp2_9A6HAnQ>
    <xmx:Bq42Z3yiQOHh5sdckiQKxONkODnTPyi2gO2eC9rgIE5IK4qT75QYdg>
    <xmx:Bq42Z1Iobr_rNtwJDJFND0hVXSdiRQlojIoLa7Vjiw92t9AI1wKxcg>
    <xmx:Bq42Zw-z5mTAVRGDQHOIUEg4bFMl-Dk92cO9ZNOCRNb0Pjj_H8edb_5z>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 21:12:21 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ecree.xilinx@gmail.com,
	jdamato@fastly.com,
	davem@davemloft.net,
	mkubecek@suse.cz
Cc: kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH ethtool-next v4] rxclass: Make output for RSS context action explicit
Date: Thu, 14 Nov 2024 19:12:08 -0700
Message-ID: <6f294267b30c93707509d742c34461668a0efc68.1731636671.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently `ethtool -n` prints out misleading output if the action for an
ntuple rule is to redirect to an RSS context. For example:

    # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
    New RSS context is 1

    # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
    Added rule with ID 0

    # ethtool -n eth0 rule 0
    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: <redacted> mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            RSS Context ID: 1
            Action: Direct to queue 0

The above output suggests that the HW will direct to queue 0 where in
reality queue 0 is just the base offset from which the redirection table
lookup in the RSS context is added to.

Fix by making output more clear. Also suppress base offset queue for the
common case of 0. Example of new output:

    # ./ethtool -n eth0 rule 0
    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: <redacted> mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            Action: Direct to RSS Context 1

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
Changes from v3:
* Fixup commit message to match changes in v2

Changes from v2:
* Change capitalization and formatting

Changes from v1:
* Fix compile error
* Add queue base offset
 rxclass.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rxclass.c b/rxclass.c
index f17e3a5..1e202cc 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -248,13 +248,17 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp,
 
 	rxclass_print_nfc_spec_ext(fsp);
 
-	if (fsp->flow_type & FLOW_RSS)
-		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
-
 	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
 		fprintf(stdout, "\tAction: Drop\n");
 	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
 		fprintf(stdout, "\tAction: Wake-on-LAN\n");
+	} else if (fsp->flow_type & FLOW_RSS) {
+		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
+
+		fprintf(stdout, "\tAction: Direct to RSS Context %u", rss_context);
+		if (queue)
+			fprintf(stdout, " (queue base offset: %llu)", queue);
+		fprintf(stdout, "\n");
 	} else {
 		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
 		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
-- 
2.46.0


