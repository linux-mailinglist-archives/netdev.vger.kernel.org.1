Return-Path: <netdev+bounces-256203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNrCGGG5gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45832D683E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35C1D302680B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA4299A8A;
	Tue,  3 Feb 2026 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="OZax5gAD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYSW68gD"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98D2F39C2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109259; cv=none; b=C/b4OFTpFAsMM0vtWqGmVU7ar6vT+v5d7/fXdsoisVhu1ivWO7squ6SnVY05yIlu0q09qa2DOq6V0QCGvdovYnPUiWXFSiZJqByfqlbLiDEb1ptQEj2iZoWerSWMGBqk/4GZeyHCrQhMr8wrouN8Kad0ar23K+JwOR886ntfCxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109259; c=relaxed/simple;
	bh=DiK3AERHYiJWeSipUtYpdQ8NPJTIs1wQ8/VYX9MhsII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUklNhqTAI6YVCIm+tagfZ4ZGoyrR6Zz0wn/UEuOKXj7LSYrmjtIrjhLINpBKWEqN+usPb4j2qLoioXFTQIcBOa3tV8ZrIGsYWOJryfhmamT+m8ToPX9z9X9tsBzMPxhzMmk0udTFzS3wXx6ni95yB9k1yEet1G0JT6t7bpvuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=OZax5gAD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYSW68gD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A8DD11D00113;
	Tue,  3 Feb 2026 04:00:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 04:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109257; x=
	1770195657; bh=5l8zGgcM53WRqArqgDXrrgU1MKDYoqcb+hA8zMlJ/fY=; b=O
	Zax5gAD66aCLDApLOFiWqr9w30ICwROquL9cdp/Z+F3j/+xHujQo9q/MsyourIn+
	SxZRrf6zu0aHUn7X7hb707XpAknRs57Lt4V3vh4UT5qvmuKMyQXzbQWOMsElldcl
	AXBeOPfmWqOfLm8tuJSs+2HhwUg/4ZwuR23gBTryA5CsrW/4G+LbuGh5ZrVPeKpJ
	OYeGbsTHnMKtnR8PAzQSRUlYCsahscy052Fxk9tAe7Hgc0u4IpNV6llbro7u1+qj
	a2UM+euMXgq77OXafwF54V+vtrlF2EdVx4FCfiTaZ8NWR4k22JTsmXLND5EwqWXE
	nZpmGcqhuLz8sJeHmCHoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109257; x=1770195657; bh=5
	l8zGgcM53WRqArqgDXrrgU1MKDYoqcb+hA8zMlJ/fY=; b=gYSW68gDkV72vC+Mr
	rS2vujiuBoGQXkpcJ5rMhcBkR+AkFab65T9Xyyin2WjLv/TuDT/1NCVSypSUQurJ
	U/kmww+ncAoNTMDdjvrTXdtQ7aHNevdyDxKIJqpQ9jWlq/9eu1wPOaqkhlSS02+7
	Xu197xs1B7AX4XlWX7tiXChijFUvQtj9JCSN3r9MUJGat5dtQ7wPBjYYZRIkIIZE
	QPSECZp7j8lvEIFjpZ/NigC9OjEcnJsundLkDMaaOB9tajyafFpqUcoBkN4nDliS
	wGcTRYT3uOeyODbxVk7rCTZYEuOeBir1npp078OcWNtBAKKg/zFMy80FXIU7HMqN
	f8r9w==
X-ME-Sender: <xms:SbmBaXLRq4GVEe97Lgjkh7gnzX5aDu0rIK0QYpYdX059Qz9KMKks0Q>
    <xme:SbmBaRgY19fs3Kw8Kgry9YBt78Lx2f8zArY3eK1vYJSLHfHmsDZLqnA-yoPEC7nDX
    kxhVT67qkuss8WXu5shXb-q1ijyA4r6J88v4s5j2N69mgaLDL7sarI>
X-ME-Received: <xmr:SbmBab_zSqnlkFw3W94f-74DRhnoSfVodKiYE32BLJJ8zqTB-UaQeJfhsvMD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:SbmBaeMBaSesDQXarhBEscaxMqxY3FMHqQ37QORBe18_PO9n98hfxg>
    <xmx:SbmBaXDKlU-9IfNnmpvMSEy7k-zF87arxDgWVSmLPrMyIBNJBBezDQ>
    <xmx:SbmBaaMdkkMZRkDNZYEA2vGvJyJsZQIP0RliMipPrv2uS--rwUbBRg>
    <xmx:SbmBaWfzCDIso68tvgW4TM1QxxnB2pjDAiUqO1ojFSZdDwpdzUzUKw>
    <xmx:SbmBaWP2QMN5INIn9PbQlx7i1Eo_qmwfg7OnjPPi4-ef2UnaLqThr3Ch>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:00:56 -0500 (EST)
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
Subject: [PATCH net-next v4 07/12] ice: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:37 +0200
Message-ID: <20260203085942.2477583-8-alice.projects@fastmail.im>
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
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_URIBL_FAIL(0.00)[messagingengine.com:query timed out,isovalent.com:query timed out,fastmail.im:query timed out];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256203-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out,pabeni.redhat.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 45832D683E
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 396326a6d5be..6fa201a14f51 100644
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


