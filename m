Return-Path: <netdev+bounces-256207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLbpJ1S6gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:05:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206CD68EA
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC4B830F18F5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B4396B97;
	Tue,  3 Feb 2026 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Ry8ILgnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTp6tYwx"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC7393DCA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109271; cv=none; b=a/Px4zAl24MmNHO3t+kE0JiFiXO9F+aOGu2cq9lwFSi0/19xXrLC6ACSZJ7DLH1viRdpZFhErQWv0KkvFLz/RItqB6cbV3CSPhGh1EZySfQF5C1BOhP8u6Xl0eZdGGkpM1bz83knsvIqAYvp+D/y+9Ric27q5o4z3nijuIKZr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109271; c=relaxed/simple;
	bh=QFRQb11o0XFDPR/PQJ/uu2PEe9eb5zE9ySiY/mDfyd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O39zLxMhLpCsfZXVJ16Q573fpiZqMLGLS7not+XeF1jNxbiNwO4maHOzQUdfGrxh6UqbR1xN60DW204sUsMNl+9mpirdMQ3yJ1XA3vHoqR53VqDeC+hMiGCW0ARvyiOXQs5dOmBTmJR76tHzEr3NFk9Ll2k5xdkH9JM80ofy8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Ry8ILgnb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTp6tYwx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 87CD21D00166;
	Tue,  3 Feb 2026 04:01:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 03 Feb 2026 04:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109269; x=
	1770195669; bh=tsn18fRdOrnBrUFnNwrKV2aWB32KgbGqs5xVBpJm/9o=; b=R
	y8ILgnb6O+zXkUREjWZB3IZSgUmyEYVOCYt1DUCvSdwj6qe9HTkEtzMwCdrR4qbl
	EjplEUUaFUCOrIlqqXy+Y6M10+na/DvM/HmnIUYZ5RZAMZ+diGb1qxh+H+Z1MPcC
	XBXdn0lanmHTfg8iQEsoe2hMxXM7JRATRuwf6DFclSK5VtWzqCtJqzPSIu+Z5+3u
	pa75l7H72b9oKI3QWF9tfttD3FOpnwDjA5DO8sUYIabgE2i/zynU41ymucoc497m
	Qr4LWIiufx2PgyIhVqAUDN6j/0xh2K3UgBDmW4yIXojFvikpgXaK41QDKNeVtleh
	9vmwmCaI7ax06d1Qf2/Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109269; x=1770195669; bh=t
	sn18fRdOrnBrUFnNwrKV2aWB32KgbGqs5xVBpJm/9o=; b=aTp6tYwxbcGaz3zzr
	Z+SIBN+g5MI3OFIjGvsFKgolahtToDt12xujLkRFRFIToUbliUmqiVeOj4bNba7O
	0z8K009IS8IZG+/nuK2KOwUO8vbuH7keyd5393KnEYX5VIdp33Ju7CnpQfU+hptK
	TiosiLNJdCyw7RJOVCpGiHg0Mi95/SZY9s7vS7TqJl2Ghua3s86UVqMc+SvYMpgu
	GcYah6Jl+Ehh5UQN2xOh+HfXV0goAlTeVSNlRoqBNyoeKtmsxv3G3HcG2n2R8TrI
	t/U42/59AqG4pAIp+CuP/mgZY6NIRvDO85zTDdXZk5vNocb3heMcgwGZSbKzMaSM
	b53Qg==
X-ME-Sender: <xms:VbmBaVC7cXu0g5O5ojYHrQkDvVtFFgY7HBFu0goMelONOk00DDYNEw>
    <xme:VbmBaZ4f4R3vAvtLcFTgiLHlVIe5lwzkUoViPpc0EBQ2GwZzwrbip0JCrl8zUKWec
    lwlb_EBzJOmqsSGtIBqiQAvhNpTdkX0-N001AP12KEh71eWyAXBNw>
X-ME-Received: <xmr:VbmBac2L2qH0JFCghj1MfW6UaP4ThLZDXMPKI1tpWj6kdSbuBGdCam0glknG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhprhhojhgvtghtshesfhgrshhtmhgrih
    hlrdhimheqnecuggftrfgrthhtvghrnhepkeefudffgfejjeejhfdttddvvdelgeelhfdv
    iedtteegueejlefgjeekuedthfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihgtvgdrphhrohhjvggtthhssehfrghsthhmrghilhdr
    ihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhk
    vghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:VbmBadlTEVDt0OUPW5ig-cv7w5uD71rojQGoYcFJ_zJ4lwvgn3KBZA>
    <xmx:VbmBaS60q7tfGqt-41E5ZFilBCozL7BGqaQ4mkEMOl9K_Coyz0Zk0g>
    <xmx:VbmBaYlXDzi4bwvJBlLpqQH7tiakPIDyKmiwQAKRDcYWn6IWJlrcWA>
    <xmx:VbmBaVU-Z6HEkpCE4efOQ4UcnVxineLv-yk_eQfuCw2rceH75M43BA>
    <xmx:VbmBaREcSIrHHFogO33Jp9bgSWgLMPphlVYMEHjuIKEpNtiv4gQuwtjt>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:01:08 -0500 (EST)
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
Subject: [PATCH net-next v4 11/12] bng_en: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:41 +0200
Message-ID: <20260203085942.2477583-12-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-256207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.projects@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email,fastmail.im:mid,fastmail.im:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0206CD68EA
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the bnxt_en TX path, that used to check and
remove HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index de26ef9b5641..a2616f037557 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1463,9 +1463,6 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_free;
-
 	last_frag = skb_shinfo(skb)->nr_frags;
 
 	txbd = &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
-- 
2.52.0


