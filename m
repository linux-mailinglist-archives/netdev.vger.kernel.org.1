Return-Path: <netdev+bounces-255992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK8ZMuH6gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:28:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B689D0848
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660D0303AB51
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FF302CD5;
	Mon,  2 Feb 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="rpjaJ+Bv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WVtoXjAj"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C03033D8
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060265; cv=none; b=utbp/Z1LgCPV6lGpdPPFr6EKkRW92ToFNO5eV6AFDP5HrYMuZ9RqKQ3LBwfJQAy198ABeOjbNTSkAsOE5kkA1g5kvP/XB03emQLqW3s6tycHYwJ+pW30yKYo7Q9t0KyaCSKK3XuOyH6Ka0Yi0PZGG+TDZFvqbwjY+ecg0Uq7mmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060265; c=relaxed/simple;
	bh=qbbgl8/0P98bJ/pFGdJYocV4wnKr2XcvuNG+8qi/D3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm9xA31/39KgixZLIQVKxgTIYR1gl2W1EVcqumYuGcBzAtFY7brM7abnOHDif+uDgVn31n5nOUJ0od3MhLQByJukchWpyH0Ie4uW2VWv1B8tSP34pZAZtN0LdGt6qSLCWuf0ndexiHcPUc/qXrOm6eC1Zvwqnp29qYSJ7pSxxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=rpjaJ+Bv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WVtoXjAj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 304CA7A0099;
	Mon,  2 Feb 2026 14:24:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 14:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060263; x=
	1770146663; bh=UnB1GS/j3Wt64HhPVoD63HZlrPus3VlrHSUH8XM4Hac=; b=r
	pjaJ+BvItaltoDvgU8PAWR+Ky3hNRTLSIz/0jk+he1hUBLNASvu5YiSFnYxIPf3c
	ezayGX5OKRq3HsFnL4NahR3CmZx5PdOkPbwS+r6jDn0GnOju/MmAmtuJjOoFIFBT
	oIi/hUxjDyWXzRF4tHrOYpG1MSjx/NanA5ECt5GoelifaFPqkdevHmDjX1+yICsh
	ah29isr6dj/l8A9aGzsE/8Ps5Ftb36bvS7oo612Mw8/dipTXcGybZMI4pLmNwvX4
	benCiJdhvx3zPDxYmR6ZZY5AuXlYRmMS1xRcpjgHO7sRxTeLVg6Qj7TlsGC4j2/Q
	/zhlOcnuWUeSUsJFhwmRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060263; x=1770146663; bh=U
	nB1GS/j3Wt64HhPVoD63HZlrPus3VlrHSUH8XM4Hac=; b=WVtoXjAjv2tEelBTw
	weptQbLETqADokdayR7pdBwBNsIavQvy+TycfRqW4+nDpPA9FqvoN5pGVYVMo7Zx
	LtqogAJhXNOYYueiCFDIac2QMPdjWOpAT15NQV4jZMoJvqYK7sMABIcBld9IRh6s
	a1W3g6o8hhViGIdJFWT1GKQEDWa1WNo+c850dtHhL+/MPM1+9vQ6N5Esw+j1uTz5
	xOALLL5mA/ugzz0WcqAkhzOZTvjTiJVLAg06lgkjKeYDMBNFy2t5TqWF75wToKIo
	GS7DonAocVq8GZAnFiN8r5HVVzcJdvstQZF1IdfQOsnh05BQqV5FHH0yROWJeW+C
	6t+Xw==
X-ME-Sender: <xms:5vmAaRCWs9RVvV5GgkqaNnPfwSgRsLie-p387GKNJxE67-cSfuxG1w>
    <xme:5vmAaV7Dc3K7536-8Zv8ZFprTBZ2ezl3t3sHygAtbgsJbAIW_lW88lo13qt2rcK_Y
    JLuF8HVAQKpL8L_m1A8AJXZuewRdUI3TJDB6bRIS-c_SVm4qAb4Pen2>
X-ME-Received: <xmr:5vmAaY3EaNiQA_ldb6v5cZJTXWLM7QucceZHnqSyhf63gzt1ROMuSWsPOFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:5vmAaZn9myIHiZEwNa-XI4Pf7-se3PPrpEOzBM9FTh2eBsOo-LyZ9Q>
    <xmx:5vmAae56OPJAQ_Q9JRdIOGtQ1gw65OZsa_FjBOp_QiLXcMNkecZIjg>
    <xmx:5vmAaUl3kKXa9tegMl42eInfocUZ9TkSeuGxqu5Yi62-4-FIMLY0bg>
    <xmx:5vmAaRVD6AjJO2Zfsj7JqjE8UMnGw08HYhXMt3hlKipw9Y2FYERtoQ>
    <xmx:5_mAaX9z7sjUQ4vUR4ecWsAv2Q1ug-pQqxknF84fk8vfexAkyHlUrZ6R>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:22 -0500 (EST)
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
Subject: [PATCH net-next v3 10/11] net: mana: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:37 +0200
Message-ID: <20260202192338.2373930-11-alice.projects@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255992-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 3B689D0848
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mana TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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


