Return-Path: <netdev+bounces-256205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHTXEgq6gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:04:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C0D68BE
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32FBE30B069E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADAC2E03E4;
	Tue,  3 Feb 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Z1tQ38ZR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inI7vlJu"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6F299A8A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109265; cv=none; b=t1eRtda56J8EQZcoP6ErUG5K2Yx7ZiW1Hl+M2+XOBf7zNwR8YG9sbgCzDB9Vus4Tw61mwySpJGKSTQEn1kemGzp2whOofar48WWyfn79ytc7ZJMpBWY/iRows85oxp9IuSAXNGcNa6ajgoHYziV7hEFe1C/BGDSTMtm5lBNM2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109265; c=relaxed/simple;
	bh=n4P4bFZLuXeKA6Tgmi4f7AYufDE8EcMpO4bkBxAWTKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oro5UQvfs2EJ3sEBOZFZtDIQXfZwafmfDpb34cuvsgRGh9kdz3o/+RGx4k32k3i2v5dI2R792BGefQT6pGZpjXp+gvrDrGnDsRycWxX9gnieHsPCxHygWj6frM8S6WCAOfR+u6SoIG06OoUtz0lIDuMr7tylNJfcxyLKXzblyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Z1tQ38ZR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inI7vlJu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C17021D000E9;
	Tue,  3 Feb 2026 04:01:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 03 Feb 2026 04:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770109263; x=
	1770195663; bh=9iarM3llzJge+E0yT60dSHkUvLP0s0WYl1/IGgkwqN4=; b=Z
	1tQ38ZRkPmp60eZkOAD0ZSYie01KPJQ+9jkoi8QqAB98CC+uQ0N7isPUKAaOjh4k
	awPwzTZMyM+xugVG8tmJuZmupWhE91st1eroK+n61jgBqiLwP91FPi7FKQbvZq9Q
	lOMF9KPuekfwq+oK+HvPnNLsnlPlHZF+Rhn4lA4nRsr79AcN0w76kmeB2r3Ek1+U
	gMfmS8k3UJhljlkVQ9PgQzyMai5fmf1UAg9Upn3z9AD2jBUFzlcBLql2/eNw67vx
	rqpkONS3FxgDxuBsmZV+Vbdy2S1ltzYcNXGkd7JCHObLXPkzDoaMZJhTxMFKPt1c
	xBPSb8vNzOZg9dHve9P0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770109263; x=1770195663; bh=9
	iarM3llzJge+E0yT60dSHkUvLP0s0WYl1/IGgkwqN4=; b=inI7vlJue9Vo7vwic
	ZvOpZ2NPke8UGfiwWbVgI0q2YXjJCfEu9nk641Jcyu+dghM51/k/i09hzmt5fKvr
	LAWFLtpyI/OzBhh2uH+F3Ah1dux2bTeAuuF8xB73Y43Cet4hWWroPfUNOScPXxxo
	bMmWv+CpwoebMdeVhn1rs2aBNUVrV35qqMLlU2SIFeM+JFDAWxcqM2Mwy46yiP1P
	w6PjiJYu+D06OKUiqV4sDmAqW8OMUcFEA6apYFAMunJD7NxE4I5+uG3yyoRjk1+Y
	CasGT3/Q+AHaVy+efFuDyeuelE980Zl6dXBac44yw+GJkyfjV9oCCA9jQb4UfDK8
	4U1Ig==
X-ME-Sender: <xms:T7mBafTcYzQvtuN3GIOzK6pD3ZRRKmqRwoT5lRVSAINEmMOgWcpZsA>
    <xme:T7mBaXLKYqLtitMSfxTYltUon5tO5B9exjl6Ykjh4c9vDaQh_swtzrjI1PxXnOvo8
    ezW65Ff90g3GrW7-Yit8Ej5D9l6Pq_csAOMdGMwSRxY6EGA4j0sehU>
X-ME-Received: <xmr:T7mBaRHA-t8spMoOC0J7yEFKJPMhX6DBA5YDGS0ghx-hhjELBZpJ7ZHR0K2T>
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
X-ME-Proxy: <xmx:T7mBac2sbNn-7CKkz2D8UVrqi1FDN6EhNPbTcMK3w26QWOwPt-mz2g>
    <xmx:T7mBaRLMa-Km8tKGjXPAdn_2gCkhMKW6wLMWC6b7ybBXU-miofqncw>
    <xmx:T7mBaZ1bgAuBgUjoqSJ5Ps1EK31Un1Jd0_UIRm4ubEwLmwGX1_N2KA>
    <xmx:T7mBadnyn0zPphQW0SMttsgfJwKyZXL-cfb0YqwOZbasgGY6HQUXIQ>
    <xmx:T7mBaVPwUm-L-Klm2FsULUNmVzWAUdCAY3Hmgo3BKvThFt1j1jeW6Ivd>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 04:01:02 -0500 (EST)
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
Subject: [PATCH net-next v4 09/12] gve: Remove jumbo_remove step from TX path
Date: Tue,  3 Feb 2026 10:59:39 +0200
Message-ID: <20260203085942.2477583-10-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-256205-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,fastmail.im:mid,fastmail.im:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: A15C0D68BE
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the gve TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 40b89b3e5a31..28e85730f785 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -963,9 +963,6 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	int num_buffer_descs;
 	int total_num_descs;
 
-	if (skb_is_gso(skb) && unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto drop;
-
 	if (tx->dqo.qpl) {
 		/* We do not need to verify the number of buffers used per
 		 * packet or per segment in case of TSO as with 2K size buffers
-- 
2.52.0


