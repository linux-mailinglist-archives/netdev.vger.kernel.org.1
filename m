Return-Path: <netdev+bounces-256206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO3gJmq5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7015FD6859
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00C4A30257A4
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26682FFDEC;
	Tue,  3 Feb 2026 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="htaFapCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVmDL2lU"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94131299A8A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109268; cv=none; b=FePcF+r8zaibrvvE309SdNATjym09znDNsHHq/raRbtso/3F2owAsGc3VR/ZWT8CL9sF5CEuz/hjKu1Cctqm+NT5lO0EJ55k3g47DL+owMw3EPRG4wg7B8oJEJV37hZj3R+50/X09HaRje2yKTvmGd1vH/tXWCOyDANtLkpaYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109268; c=relaxed/simple;
	bh=+M0uIWmIaOLzsz2a0Z0LCK/CxcqaOdljlzLO2KueOgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0S5GOfsaRk25YJyEf04uMgeMyUZjpfUqB7dV7cOinIb3alah8AgKDNd+u5zMh2+22FtE8bcEIieOc1OOoHTFWsPBy8bZCwrZIS3ZsbnNsCjHhgrhyWcqfstackkTKo8TH7gcl2kagj3a99Bljdsa6u4rODAgIGAcMHuhHiv2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=htaFapCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVmDL2lU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1ED87A0172;
	Tue,  3 Feb 2026 04:01:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 04:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109266; x=
	1770195666; bh=tIrZ2L4CG+F5eNIl1HIGJqVYMfLHw9SFXQ5JLsM3x9Q=; b=h
	taFapCSwDOIOzJa4vonElwkBkt5bVFW5T2gvgXjWiw77uwu/SaiqnyKhMVxaU6ds
	Ops6nahJnGTLCUP0NgRDtM0+iU4255GT8y8UbmszbUYXe6newhbhVnQtwZ2j6VgC
	XZ+Jo09f2H7qFfZayOQx2rrcVwCxem4D9o+rOo43VrPDOIKkX57q+VOYact/ZYjm
	316cZpzH3lDRUMS9nRwAiTo4xUpDZHJ+4PMrcy20f4kE8iyOTpIoYLsuG59lVKk1
	OuCJanzgIuEJ+VRkRl6arzEM1tDQZpmDT3796G+AlW2LirUsHE/hW5+1bfTzaKxk
	1U31SXgnWJGqgHLCeePpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109266; x=1770195666; bh=t
	IrZ2L4CG+F5eNIl1HIGJqVYMfLHw9SFXQ5JLsM3x9Q=; b=JVmDL2lU6yDePyW1w
	ZInnlsPADj0FUka47yR00nRlg5DEim6gTfr2NlVhFix0hLkM0nnSHDVuqnQtVIZw
	hsFoVxsZio48E2wVm0c8UH1MahqJ7Q5z4hQ/rBV8IAVBtDJ6Zw4BGvfQpwXW2X0g
	ZWzD+0EQqSnygkXw8vxeLgulh8k1ilJh2CBs2vbRObKWSa3thM2VU1ggTE3bBPHx
	3it2YPySCjAo0hDYtQ7C93rHYTTMdSNrDV/6bVNmSjVNjyW0A1yRnh4hi3UHW/Ro
	Jj48TJs4ExHkfbYsR3q1pjIFIvNRxzBlD93WxzZ8MgN1JDdswwUwwEp84Gwg5mtV
	uTGfA==
X-ME-Sender: <xms:UrmBaSU0JxFWAKkKKcCqSTJEWEvC_70D9vbJCsKfFC7NmtIboBxQ-A>
    <xme:UrmBaUiTlisoJP-tz_H09tvYgiW4MgiUC_IIRCde0y6Lug0qykX2YHDfB4Bg3X6Af
    dJ7uE0qyEDEd4_gT4c9IPvpPyaCTJz_79L_yv4W83MKaAnt9BFhR4M>
X-ME-Received: <xmr:UrmBaTgFPXM7XvxRhhK7DgukqKINRI2YCmxlj-xoUym23E2bX7cATdPI7Jht>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:UrmBaaGTNdzWwzRkW-YnyAYajUvax4WskIBIrDz8Tg4NpQo1lCn1_A>
    <xmx:UrmBaYDNiKmKuNcWvAO67wjkvjwPuapTNkFPIgAbnXb9cqcY4MBSRg>
    <xmx:UrmBaYBizgPdm0H_oftI3U6iyOgOIGwE11CpNq1PMvjt4g2jitavsA>
    <xmx:UrmBaePjJHeoQoWBQ0ZxlhVRllVbH1WwJW-O9UuyiGUmq7QVuypjEA>
    <xmx:UrmBaRyimkKRw-kAII4dA2q-lgRVVTb8ON-ZI8vgwqfWXguhpYnAP0YY>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:01:05 -0500 (EST)
From: Alice Mikityanska <alice.projects@fastmail.im>
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
Subject: [PATCH net-next v4 10/12] net: mana: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:40 +0200
Message-ID: <20260203085942.2477583-11-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203085942.2477583-1-alice.projects@fastmail.im>
References: <20260203085942.2477583-1-alice.projects@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-256206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:server fail];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.im:mid,fastmail.im:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 7015FD6859
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mana TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 91c418097284..9b5a72ada5c4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -355,9 +355,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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


