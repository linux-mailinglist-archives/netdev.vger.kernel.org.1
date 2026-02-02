Return-Path: <netdev+bounces-255991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN/tMgv6gGn9DQMAu9opvQ
	(envelope-from <netdev+bounces-255991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F66D07E5
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AF823023016
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEDC30149E;
	Mon,  2 Feb 2026 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="IMrcLm7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9WVUl/7"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9E2F2918
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060261; cv=none; b=LuzoSqoN2DO8i6hVhF/RoU5H/GLCyLsBl22a2CBnKcrmnnkmQItabX+Zpw2AuRpvWxMvy+FP++37nipWHiksPWHXqipg1H243jTd0Qo9kKMkhKxSoGM4WVhgFIUGxU9Aim5rFLBPQL6mFgOMh0Y5RsX/9psfRLnoDp7gQDzlgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060261; c=relaxed/simple;
	bh=0PM9BXwrHl/KctfwpWdJIFjeDL2FnxD15RFLOn+7FqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAv9eb4ZOachdJizpzU2y5xijW5R/p3p69+eWi2SZ5XDNc6Gvih1M8KLDew/FR/F2VtjZ+IAo5qLPTnC50L4tmwKSzzAbcSrDbKl12Uy1vHZvBkO2OjDAgTbJWsWu2KjWT8/in3Ch2n/KgFuAxggnkNeijxeKH66u3j5yVtemGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=IMrcLm7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9WVUl/7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28B377A0085;
	Mon,  2 Feb 2026 14:24:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Feb 2026 14:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770060259; x=
	1770146659; bh=yXMcTvyrptlmBz18hitheJBNbtsh1xZI43YBYiBMIp0=; b=I
	MrcLm7ocfs3dnOxN2c0zhdWRofpRt8IdgJKigIr+WtwF1tOied8y7lOp4RlSlRXP
	hLRNTDiM3Ixb1kjlhqlz48Ahv60Z+W0xNq/tCb7QowDLVBoGewPrIQudPP++7qsd
	4hkZUSFRSsPVNbR7mAnAMfvPSA8OMcuDFHb2LMFhgS3ZeMFLuhgWv+ZheytW5MPh
	GrZBJarz9tRyBxibq/aHnxTrhOAgOWrRe0WqpYedo5X5/C3mB3aHIo2wWfj81SsL
	wK0NPY4JckeqePMW+xooaBwCed7GQx+guOHD6C/EEsPo5q/j0CbMA1y8Ty5hO3yZ
	3gh7xSItDlJMS0IwILMSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770060259; x=1770146659; bh=y
	XMcTvyrptlmBz18hitheJBNbtsh1xZI43YBYiBMIp0=; b=L9WVUl/79204dYJqL
	8xdOhPNG/kGcemWyaKBMif9z53N9Z7j/jE1y7Mf+4Sg65SuTtyCq5ZKS2gOoid5S
	0FzL2N+eJyH0FVmvWf7smvgSVBSgyzTiAqNiJG5FJflNgzk7KzWvK24XkWZO0fEN
	23Bdhu3LLLBs5NmalY+ovAgyORsEXzu43koQHz0sOLjBbH2QEEHwndF5vkp2UprS
	rGuAfRucJn/VTRtOst64XlYJBjIN5pcnp9HxzAS+HfM+VwDeK7RP3tW8DkzeNm9i
	fTaq1Kt4BEF55iEOA+5N6OLEklajmyRgixsR9axn2CbiVnw6Vh0SrfANodfEC6Ls
	EkNvA==
X-ME-Sender: <xms:4vmAae83RjQuyoPweYf2YHheuzzBTxtnxHpdOTHSNyi_YNcS5Ht2uw>
    <xme:4vmAaVEJ5XxXdZt5eYq2RnIPFroP19hqLVUtrCNL_81PhkUxz9mJDzovtya7LfCL1
    4vFGHRaI2cAI5QcvgMd3LBkAVgTra6BgmyWBZE_psrnVR5MA1uZtps>
X-ME-Received: <xmr:4vmAaQTff0UmPkLC4H97I11TfN9i0xLBE3H2neolj70wS2iWEnGNgqUGOgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4vmAaUQs7e5EtrPwEkW5gsr09AKe7A9IvmRANfWNvYB_eG7RdtQ6oQ>
    <xmx:4vmAab37WjBBipX7PfVzjbwndEVJfwx8twv3lOPRiJEdryFOAC6iyg>
    <xmx:4vmAaWxJz1ommSE5p1twmA1RAgMZDM3SuXEpukZFYXh73KUc7xNK-w>
    <xmx:4vmAafwtt7crP1Cu5uCc8DRw3kcM-GGQd0gYc4aLc7WQ-JuMbXKzZQ>
    <xmx:4_mAaYK67ENmLtmj9O6M2Squ2Y9pPZ7xUYzOjpiJuH4aLCqztbizz3y3>
Feedback-ID: i1ede4ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:24:18 -0500 (EST)
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
Subject: [PATCH net-next v3 09/11] gve: Remove jumbo_remove step from TX path
Date: Mon,  2 Feb 2026 21:23:36 +0200
Message-ID: <20260202192338.2373930-10-alice.projects@fastmail.im>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-255991-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,isovalent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Queue-Id: 71F66D07E5
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the gve TX path, that used to check and remove
HBH.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
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


