Return-Path: <netdev+bounces-289454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJHcBDtaDGpxgAUAu9opvQ
	(envelope-from <netdev+bounces-289454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A257EDF4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D26F30010EF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7694DD6CB;
	Tue, 19 May 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YtOL7+Tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LODq2MTL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230A4A340B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194424; cv=none; b=p7vYZo0o8rjmHuiyUezsWCvDa4sNbufvLWvqM+c/DimMGPWs/Juuu9H5RukaM47Nq7Xlj1ZwWJqsDLMcZn2+V2SrUqWdPYO2TdBSdWzFVnY2KE+Mm6UvYK6G3CmpociTt0g/2Cxjj58G9nCMSU5yCTc/yMZnHzY8+N+weuFQfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194424; c=relaxed/simple;
	bh=FD5JKsw4/Ypa6KLwNXQEszGXgWNnMikuWJIsdX0dWR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3Q3NHGmb490RKFNvbs5Kp17j+f16MevYKxqXjFne7m5K7nImtfSuzDDhSs0O8WyWiRp2TGc0UEnIoN4a3RExbFlbpofQgJndblnQgEgB1fN8USdxKTsvvSwLokKzTzzNqrop5l2K57SlWgQhEsBnSWgNuRQmeDtL2qcbhAFomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YtOL7+Tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LODq2MTL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A237314000FA;
	Tue, 19 May 2026 08:40:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 08:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1779194416; x=1779280816; bh=mBhfrvE24E
	UpY+x8fycbbiO2J+Y3UC2JSp1Xnx7ZG10=; b=YtOL7+TtdVH+zKVw5xXORmDCNQ
	+2XEb0StygNAjF3uZeMXx43L6mYvKcrHPy6tq9zTjE9GeOoREzcA9nVQYjkM8Hvg
	RJ6UvwUatZMExc1ecNuE9mGp5ajaPLj7ufzUNn2NMVcEg8mXq3yq8xt99aycMLg0
	Qfu5iG4+Ary54gU1Acm5VxRPzrxZviRCj2h7D0Y7diYm+6SgjgJtUR7k8jThQ7eA
	4nUkM2dTIIhsIsMpkKqvHuhvdKy36D87lQl1LeQ+tYsjG1Y8yVTnEMIZsxKzbZY7
	i09DxmkJHQoVtvgBkDxlEobHMYqhn17xNqswWkSI1TTuCAsRcGQLxkdBpjIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779194416; x=1779280816; bh=mBhfrvE24EUpY+x8fycbbiO2J+Y3UC2JSp1
	Xnx7ZG10=; b=LODq2MTLUtRXFrgDaq4izwrKniTElGLKa7shE5Eb5+WHd/bIBJu
	bxNGVj3TfITfW/EKKmR65bHucL873M3rkLHgM1W+3wZyubR90o9txEEuTT3yVqWC
	9RzIDDhhRGcl/gtFHn0EZ+xyDeqWY2FN6iUFkqoCo7KS+RTRLRLY3EiaXRgRpY28
	5SZSRDIz/Zp6+CI5saT6+IrJcr1uog5ZV1gK1S0VLZIBbmgSLRkpPJoYpnL0Efew
	PHZK72VnVWTn6ElAxpFzNXQFM8kmH8oS3gw7r4d11afpXG0wKIQpCNUey7LezOj8
	LSW3hNuHeXimcnRxNTtGQg5Vc3vcGSxOHKg==
X-ME-Sender: <xms:MFoMasPMIHe9c3ptKiFh-uHloqZyM9_mugaYByDsv2YkVuBPPVsUSg>
    <xme:MFoMalhBZkEcaD8C-8dmjsL5LVek67s0QAgV_mQhUmzbBZzsptDYbd0K0epQ7MptT
    DMYE7zaMVYApc8XvSgOBNuaJR5pKBO4lqPBuaWFasstncDUyHBrxS0>
X-ME-Received: <xmr:MFoMam63fMuZnxvAN7liLqfCHuCK_jdtyaGcVpR-uAIYyQMt1q20yxf768TiQpHYjhaaMSeuUCqBoihEBQmK1z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pehhuhiirghifhgrshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghsmhhlrdhsihhlvghntggvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:MFoMak2j2zstDFf2JOPp6kcLjeuG7Zi4nR86tGjhNUZnAbEpMuuphQ>
    <xmx:MFoMapvlt6OvcTi2Kw7oiZnPj_b3XdLXCJgQ7AKFYlSDeQAPuMipvw>
    <xmx:MFoMai67GxQr7D8wdGM0KcnxJjZjc6WTDljRdaTRc4BD3qDm-R-H0A>
    <xmx:MFoMatcCabURF4gQPqZPMNljUp85q9IFre1ooxz63w_oh4_tfwP0-Q>
    <xmx:MFoMaloXMV7UPh20qmmx0-9wSbG8V5Ar2y1l64YF9fvnwxjege67SCnx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 08:40:15 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH net] net: gro: don't copy frags between mixed zcopy skbs
Date: Tue, 19 May 2026 14:40:04 +0200
Message-ID: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[queasysnail.net,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289454-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,queasysnail.net:email,queasysnail.net:mid,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 975A257EDF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skb_gro_receive() can currently copy frags between the source and GRO
skb, without checking the zerocopy status, and in particular the
SKBFL_MANAGED_FRAG_REFS flag.

When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
on the pages in shinfo->frags. Appending those frags to another skb's
frags without fixing up the page refcount can lead to UAF.

When either the last skb in the GRO chain (the one we would append
frags to) or the source skb is zerocopy, skip the frags copy, and just
append the new skb to the frag_list.

This is probably a bit less efficient than calling
skb_zcopy_downgrade_managed(), but then we'd also have to handle the
rest of the zerocopy flags/machinery. This can be improved in
net-next.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
Assisted-by: Claude:claude-mythos-preview
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

Huzaifa has found this to be exploitable to overwrite the page cache

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a..cae0a0dbfa69 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -123,6 +123,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	lp = NAPI_GRO_CB(p)->last;
 	pinfo = skb_shinfo(lp);
 
+	if (skb_zcopy(skb) || skb_zcopy(lp))
+		goto merge;
+
 	if (headlen <= offset) {
 		skb_frag_t *frag;
 		skb_frag_t *frag2;
-- 
2.54.0


