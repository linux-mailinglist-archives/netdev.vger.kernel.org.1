Return-Path: <netdev+bounces-143825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EE9C458D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB3D1F21FE9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F201AA1CA;
	Mon, 11 Nov 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BjKCSNDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJZ9pqmy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673FA14B965
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351967; cv=none; b=q02tYGdTXimJI64BsEreL68Gb9cuYt6zFhpsE7kvdMJLGoYYYRpr6KRbycrsmHymW3hcCW/KEFpOjZomaO1aVyhpzT9XljFQqp1UU6Y4ishujUSJrzWoUFQo2Uy/BFRuvlo6saZ110PMYV8aWG6Edhd1IvopVz2tcZ7/bY7g0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351967; c=relaxed/simple;
	bh=VQ4ZxEXbGgoLtvCOhb1sNjvZV111QNJltKLwrYlfD4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAgtQIdeN9Pqw3sqeIBh0GKk5taTb1c+F1h/uuefxbcwA5BSmhTlOPAN9KpyYZ2fDOSNYLqf4Yl6/lFGcpBI42Rd5mR0ONp7bC1G0GZr3+iqhhKSeF5Y7clo42SVN9qQRiQle4obbyV9jg9dLovtwox7EN1rUhACTIp9rgmTeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=BjKCSNDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJZ9pqmy; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5186311401F8;
	Mon, 11 Nov 2024 14:06:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 14:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1731351961; x=1731438361; bh=NowMIBhrT+fk+c506UiX2
	x55qCW1GeVMDLVld8oYMW8=; b=BjKCSNDjuWWAxrQsdXpZ0mKr9q7JpTaOvQNyy
	PLFPRSx3a93Qi5aRVbibrOpk7VWT7aFJmkps1owlDeTS5h4cP+yyclzCGbE5/ltX
	/4A71r12wF2B+eZoo/CdReanQPQK5BNG79vFUtSsZ+4FtXcbGysfJC80C+TaApAO
	/62+MtAzQz+VRn52LRqHf13NuGlb+dQj1xBqG5vOZ8aYX4fSBJX4xyuz9rbFAZrZ
	dAdbzPwSbJ/X3fkqyAOxiabVPRf4QNjYtuFF9m3tzgeYqbgFCY4o4Bdxwp+1+bWG
	DvHQoRLdGi+4sC5jyZa/IiHE8KTygolMRr7bbUaeOaOpBeZaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731351961; x=1731438361; bh=NowMIBhrT+fk+c506UiX2x55qCW1GeVMDLV
	ld8oYMW8=; b=TJZ9pqmyqJKb9uVmQR3HZ/wqVopDNHpiD9umlBeSch8LrwY1XpP
	ztH1+8mtrsNtVzq0jNL0hBq7ERwASjm5HtJxElDsMiezPcOi/kGHenvYZrwwLp7O
	SC8xriiU5+gOrxJyduRBfzULJd8JZNfFCcnvhaoKUUuxXFMmPXCH6kZUMRLGSUWV
	O4EGjQcNNXDHzfGgRqVfHJb7kMYBbLZ/cJxcOZCApURvqhqTFgT+WnLIqp2LM7pf
	8iGxfh3vn4AN5iHslV9z4i4K2iVJIixNP742TpryNujOeNv/euQo9KfelZeka1Mj
	N4siHvhiEwflzul/FRibxYHkYZpIlJVZnKw==
X-ME-Sender: <xms:mFUyZxVUmJWU7KLIxDVq5Vxej6qM2y_BjOU_tu-QD8K6XfXBBu4pEw>
    <xme:mFUyZxnHuI5FJ3fVw0q0foHiitfUWj2QgyT0h_TY4AqCM0pGRdR-WK261hshQRWr4
    olbyRpqSI2LqRZ8kQ>
X-ME-Received: <xmr:mFUyZ9aT-fexccx7gQYEa8LUU0rp9FZu4nIJg7zcRga-ZIECpwngkFtlemUJxdilFS0kHkD-kXz1IgwxilYzDhvTuuTNZfqhuVcSri78dWOE2LKg8Qa3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepvggtrhgvvgdrgihilhhinhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    gurghmrghtohesfhgrshhtlhihrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhn
    rdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgt
    ohhm
X-ME-Proxy: <xmx:mFUyZ0WiQfLMueCIeIdL8pZoW2liWUJDH0JqXc5UXKZWhDBBUo-KyA>
    <xmx:mFUyZ7nZm8fQQ6z8w27tUdoo_lY-RMdAt6YIHgc1ndw-rn1TfU2ZwA>
    <xmx:mFUyZxeGaqiwAGFl6TwFgd9U00S81oczEXabtx0H4-6Xe1pvK8xfKQ>
    <xmx:mFUyZ1FTpWsYr2CTeLMz-EpVE5aAwsJFtWbIiZ7Cpj6hbZdJR2NvgA>
    <xmx:mVUyZ94dLV6TUzKfs84VhzGziU35zkE0uQHfCViaf9CP-hF_1tlAQ-vX>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 14:05:59 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ecree.xilinx@gmail.com,
	jdamato@fastly.com,
	davem@davemloft.net,
	mkubecek@suse.cz
Cc: kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH ethtool-next v2] rxclass: Make output for RSS context action explicit
Date: Mon, 11 Nov 2024 12:05:38 -0700
Message-ID: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
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
            Action: Direct to RSS context id 1

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
Changes from v1:
* Reword to support queue base offset API
* Fix compile error
* Improve wording (also a transcription error)

 rxclass.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rxclass.c b/rxclass.c
index f17e3a5..ac9b529 100644
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
+		fprintf(stdout, "\tAction: Direct to RSS context id %u", rss_context);
+		if (queue)
+			fprintf(stdout, " (queue base offset: %llu)", queue);
+		fprintf(stdout, "\n");
 	} else {
 		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
 		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
-- 
2.46.0


