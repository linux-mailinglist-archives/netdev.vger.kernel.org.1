Return-Path: <netdev+bounces-249596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF1D1B65C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16BA930693DA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF12B329E7E;
	Tue, 13 Jan 2026 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Cb5siFWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s2q5NOq1"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE50338F5E
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339675; cv=none; b=irRnVhq0tZ5Om1TesRpIpwFTTksFU7MMyo4TLng2oxZZR/lZeLldrGkahjBQaR3QuHLYjhdOusVBJ4zwP7XReE1Ivy3EAjn0mKFkZGnI4wrGKk8XVgRwwtSUZwE5PyX6jHD2mVIludiWK2EZY0jf4AGnFPgFMiGvXmd608AArPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339675; c=relaxed/simple;
	bh=A4phXPcjvbPFJIPjpOsrx4HYkeAI145I6474fOLu7RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr1Madqvj1maJLnhngh1v9sPjUTe/RfpeKBG3Th6WAreYE2nL1FEfF9/l+KJvF7p8fhAvTGlH9F9zEGEBl5CVR9DzstlscpFJeK49ZqtNbrhQHEZzSCGHk39yleuw7BTmr+HvjtH0OSoRtx93yHD1qO6enXdMhq+gqL7wyXsioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Cb5siFWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s2q5NOq1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CAD381400102;
	Tue, 13 Jan 2026 16:27:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Jan 2026 16:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339673; x=
	1768426073; bh=l6yUk4ZkiRz/tjwp78nlxIvQR1vRrPTN4+L5Voe/6s4=; b=C
	b5siFWaX6eS7leQQXaurudWR9qpLPa2L97VeCp/Ueih4ZrTVDrSHOdJ4wvKq8C+o
	Ue8tuZGiuo3WjTI4oYB/8y/V+OykuwV+WKxQGV98Rp+xd4x7Pu5hMbPnQePeiV5e
	d9D6tNLnKiCTlzoq7emrqJrF8TSOCRqOivljIktrZnNi0ZCAqIYQIA/x8ZUcfeJQ
	OAY1jiJcszUOVG2bu3dmTbT4OVxK/IiZt5dwqSKDBWKrYUw8HADtiFoA1kMhg32A
	uIzyqjpMUOtqohMin8daqC/LZED1W9SndjnzYGN2gHfeU082Y5QiDuMYt0xUNXD9
	ACmR0OjhxqHzJWqXZ1q3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339673; x=1768426073; bh=l
	6yUk4ZkiRz/tjwp78nlxIvQR1vRrPTN4+L5Voe/6s4=; b=s2q5NOq1jCJ0Nc/qz
	HNuJLJs9yeRETIJgIqNQwrc3HRxQdKBvtWTWhWF61eEeuOtAck9NfXlwZoaAgD/g
	xk0p5DRnf1FWLpoxa3HUPraf1rK0EGg+vB60TC1Jjs1IxotvV+fJXJUi3CEEe+my
	oMuhP6u/9pGEYIJhgjfsrhvjCDWFE8H/iDERG6Kxp2Zv4AsFgo6u5L9Eu5PP2rrL
	niN1ENpFjVokpj1QKWybw2y1kfWaMN6FLX3yzodapCkMtuZfnhYltDN2Rdqamdto
	qewpPZNmYaxB2BQRZhMM6d243a217V1nc/5EMLlsicR0DuA6AYZ1iZzPb31uQqo1
	r5sWw==
X-ME-Sender: <xms:2bhmae2TqiGdFL6iRgCm_XpjC0jl_D8_GNli5MTROgM08OpyjQFA0g>
    <xme:2bhmaXdobs2T_XG71QEvy1RZLt4_cvMWHPV7SGryzFgxrdB-XwRsahF0JoeOlChFG
    I0bCzDcXuLDakTCcnIwIp5q83KfEj0SBriTz1vIfJgtzNBTw5s0SLk>
X-ME-Received: <xmr:2bhmaTKGgaaKrwlCneKikUKFUfQJLpm5MmEk_GMJT8YxslftIBluC6Z_ff3DQEpfGr-IorHZEpCV3R7UBsgszP7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:2bhmadquPLulAc_U3cnLOCqbvptuXdsfYE9xi6WsnBwJbVhg4RqwFw>
    <xmx:2bhmaZtZ0BPbPlVnz8BCw4Pz2gxeoCeEt__NUuFrO7OLiV3ZgcNXiA>
    <xmx:2bhmafK0xbLKh_TwePmaR_tH855nPs0q9ZkiupuE5zhqVeLHHm_smQ>
    <xmx:2bhmaQpaxeP1FeE7HcC76GdPkxYYHsqEYRMFOtpVwmFuVBHlm2pZ0A>
    <xmx:2bhmaeYhSJ0mRiSvOQ1huM0Wfv_3winYVv1jWClxa-aZECF3oxEygsg_>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:53 -0500 (EST)
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
Subject: [PATCH net-next v2 07/11] ice: Remove jumbo_remove step from TX path
Date: Tue, 13 Jan 2026 23:26:51 +0200
Message-ID: <20260113212655.116122-8-alice.kernel@fastmail.im>
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
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index ad76768a4232..97576eab63ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2156,9 +2156,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto out_drop;
-
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
-- 
2.52.0


