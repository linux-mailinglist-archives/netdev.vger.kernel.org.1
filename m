Return-Path: <netdev+bounces-249599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B6D1B65F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA99730869F3
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8432BF25;
	Tue, 13 Jan 2026 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="AshCL1EQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CIDvEYI/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5E342CB1
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339682; cv=none; b=XZDOyOXKSENNutIwH3VMa1Yf06sWRFUtOo75JhfQD+AX14dRddFSVkrPx2qTjeJD9vFsxNNajXsw6CtsLgP0hn4LU5ljSqXLB4glgYIbmKqlRK3uVGdhTHmwTiId4tr8NbWBJURN5x5J6QUdZfNMYCVYZ5Fh80l6hmMq1GUArsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339682; c=relaxed/simple;
	bh=HjLjhaJKkbXmp4qhpgNObO6BQarwFZvkVTASVO+JGl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfyG++dkT/6+jUfuKBwG2WMuJDP04hHeH8L5d8F2dLg/3inW6ENXMIWNcfuQpxmAsTfvH2U6tVK19lcYi0kMIjJLCiRHz5cBfsnBPZmfue+qL7lztNiSE6RviNKrAiipV1GGenIa8rPeolqdlPgrdCMQr+XPHqjfOkUbNIS9XQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=AshCL1EQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CIDvEYI/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95586140010F;
	Tue, 13 Jan 2026 16:28:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 16:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339680; x=
	1768426080; bh=cH1RSvbMkQkgTgE2aeetFbpL+HHM+bjVapOSrZLU2Mw=; b=A
	shCL1EQw2KX9Ojl18aomso6HHNR2YXqeG2dCqfsRZXcyZXNDsk6/AR1TA/jJlOTt
	MjH8hQXKIDBUjlVInf9++MQHMuE6yMfgifO0cTa3S4wZrfzCSAMIh4TF7o2IfJKs
	3fLUIo2OS+60zbgCgOJjSWkdPZmtthCXNUVbjtFnkJKbB7/ZYN/WlqANJBZLpbdj
	72WFv2BvhyfQJiyT2ZReRdc4QLevP8aJ+cCI7qFgpnzJfmOCXRd/vE6nJn6ygEVb
	QqqdpToK8YxkbJQqAouNj7PfOslwSJEYgL2EZr0KMSXub7YGYaobwTYjzyPXifJF
	ayRsAeT6P06H2tGe+RLOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339680; x=1768426080; bh=c
	H1RSvbMkQkgTgE2aeetFbpL+HHM+bjVapOSrZLU2Mw=; b=CIDvEYI/Jf1eH6YTE
	a6SQ3G2onUWO8Sb+L1p+aiuiUzr1nZkahlwr8jcRDTXU+P3ebeXB9somRXaC0Q+B
	dzA+6fxgjG7qEASTD/y5MQ06ns7sHZk+h8Ug4KhslCA5sBzMgo2EXoAGn4KKuetm
	Ly7ovGPRoqYuJeyyENM27tcPAuGIRdZu0NpwZD9GbmFawIaauY2GbhKgdTFNHRFF
	ftD0R60rW09w7AQusZ2tsop8xIm20iKZ1FPyGZr1yKW1qc2oxYr/UfsjlKEmf8Up
	CNM5u0E52lINhwA6XCJh6b/TlTvycBhnn6PmP1i61aS7Xhure4WGp4VpQ8b1Hts2
	oZGkw==
X-ME-Sender: <xms:4LhmaVTQNket-ytQ6TkMgpD7WAwUMbviOYIO9qbBH9MO0tx_Uy6DBA>
    <xme:4LhmaVKqXMmFfEbCMSS0wLIszVSbpMPE3DZPXN58UWW1UUnifQlBMBcBtLv9Nq0zJ
    6zMq2rT_48qSNm4DIeGTanHlFRKLSwe3FJP9keOizm7AZIwrmrJzw>
X-ME-Received: <xmr:4LhmaXFSApoOCtVHjiTWZDCIn-vtKFm-Ut6l9EKEqL_It55ibwbK6hMH8Oht31cQ2xuDc0fkVIA_EMlEdPjwROw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:4Lhmaa0_qAyooi_dY6Ku2rhPjFqs_B01YPEe4u6RORxxtFgXA4v5cQ>
    <xmx:4LhmaXKVPt8Yc1U0N5fHk9otLqDQ886EoxO8JbGCMWwrmQShOdx4Hw>
    <xmx:4LhmaX1ZrPbX98ecGCdb3fVS1fIoo_hQ9lZ1vKNbf_gFs7WYavTnAA>
    <xmx:4LhmaTlL8j7Jc9Mwks6T9z6c6oFTp2AnUFQL1KU_z5W55oMtfXMrfA>
    <xmx:4LhmaTP6WA8rwKwpUqE-ctqrdgdnGdvlr4pcFIrAaUlC2skllxy64PrG>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:59 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 10/11] net: mana: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:54 +0200
Message-ID: <20260113212655.116122-11-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mana TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..443beac73a06 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -322,9 +322,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_cow_head(skb, MANA_HEADROOM))
 		goto tx_drop_count;
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_drop_count;
-
 	txq = &apc->tx_qp[txq_idx].txq;
 	gdma_sq = txq->gdma_sq;
 	cq = &apc->tx_qp[txq_idx].tx_cq;
-- 
2.52.0


