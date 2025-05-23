Return-Path: <netdev+bounces-193068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB1AC2611
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D01C05ED6
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D54296D04;
	Fri, 23 May 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dIlhPvgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tLWpRj01"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FB5D8F0
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013095; cv=none; b=fO3pmhrGjTNHxs29lpXYNuWHwlDuNLH7zH8MNQkbysXUArpo3IfsxwYb9jEYAh3zct37I9G+ZznEX6TUuPn6WtH4m7OoMIcqB0jjxpU1khIXIIdfZh6UUR0pMzFny+ACuv/2sXl241h7oxi9o3fRQslkwU/I2g0DrxqijXfj4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013095; c=relaxed/simple;
	bh=pHYeu/gTVuumzENjTRRzH7WzsCE9Pw4/81XFQNcgFe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYg8TR6ya6eOOpZWQw8abt1d1TSlWgywRPJi79fqGBsDrvmjKZsOquuzQ8/2vINEyZXnzbj+vSaZshmhgJzzS/bWlFGXK0amtdV5VRIDzKClsQVi90m4jtcaUrIQBA85xLFvp3GTNaaEJAy2U2cfjloAdCqX5z+4TUpRnMzNH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dIlhPvgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tLWpRj01; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A59E02540146;
	Fri, 23 May 2025 11:11:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 11:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1748013091; x=
	1748099491; bh=FXf8xcFI3jgnObroI1izbCp/X7RPs1lVPmaP+t2VXBY=; b=d
	IlhPvgqPzz0+vYxeyPqw/1/Z5fEk6+Q22YkAlHnNhBiwult+Nore09DhfvmTpz3E
	WUGCEyvhKjLGIMAA0ZaIaOuXHhOWlvhXDDxo9QU525ok7p0Kg+OLNvnzeLJR4B1b
	fiyrGjdkjFh+kg835cbPT4v0g8JeteR2N/VAvyu9SPQigHt52Z2ZZYkOEzcbbEmU
	yzRyYYs4XyI88z5rIDctaQKvwO6yA0ibWSht1ImLRYJcsUZMx8UaGZi5PMut9N4F
	f7L1ILWoMaMTufXLgV+nDhmiZCY7c5B0occ5O1v33vNrc27yMV9Q5ta4nB2DHI6b
	DJEcE0bi61PSBJAqUbHOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1748013091; x=1748099491; bh=F
	Xf8xcFI3jgnObroI1izbCp/X7RPs1lVPmaP+t2VXBY=; b=tLWpRj01mQpEgYj1a
	wtTsRfejdCpVb1MTBMTACC8CLM9lck+Uomg2ap4w5fO8qsv6+5dqcdbLlEiURu4V
	gG4VBBCEi0Ng+FwaxlFenNpvHyYekNz5CJHAI9WT4MyPYMpU70mZn8RzCJUvSQmW
	Wo6/NqMHfGfE9KCkZ+Qe9guNPZnYkQ7xPNIe+ojhQ3AFHPRBUWaom8UVxC3H72d8
	fQyGCZNhRxztWgGcZlUNFmf1XiU4ILoAABBZIdVk8zS4wr8aSO0QAG7wqdQh4IuI
	VpcCSOjfcFRv3i/sSNXjsymXvqIAvZtVCu8NZsOq5udqnrIZiMbpcuIMjX84cbtO
	1ZzjA==
X-ME-Sender: <xms:I5AwaMG5zPnQGT0C81J-PlxRM8ef8sL6V6Vyhnf_C9UP8domQcek_w>
    <xme:I5AwaFWZ8C7dIHuxGVKsPXVN42gqUpJMyQSzVqnKK1eLAsxcBp69aoDAuq-xweZzK
    lTmf_HMyiiXyDoJIOo>
X-ME-Received: <xmr:I5AwaGL_7y1c5WoXrDBstT5vBPsm-5ZXxoGR-GG1N9epd5LSXOkZbUSXTGPR2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoe
    hsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepieeiueei
    teehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfehudfghefgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihs
    nhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopehsthgvfhhfvghnrd
    hklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehffiesshhtrhhl
    vghnrdguvgdprhgtphhtthhopehshiiisghothdojegvugelugegjegvudehvgekkeehke
    duuggthegssehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:I5AwaOE03d2RKChsIDji0xSOkzDsiTW-7mBGoyb7qbQ-EWWnlLjckA>
    <xmx:I5AwaCVuYU5Wp42mUln7KppCb5FHlR4InORA1uGS-J5yihOWsybN1A>
    <xmx:I5AwaBPAcwmggYZsW41aMYL3bE3Yf3w4OMNTHcxxPowv7lAmBVzzzg>
    <xmx:I5AwaJ1r-wI4_JqUgIyViFN1xfHbXNfJUOR2XIC-jdJxBLr5IbW-ZA>
    <xmx:I5AwaBq5j98iD7s7ikSlq6WuavS82qpuZSYXRlj0vKkh4b_OWnndHGgy>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:11:30 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>,
	syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com
Subject: [PATCH ipsec 1/2] xfrm: state: initialize state_ptrs earlier in xfrm_state_find
Date: Fri, 23 May 2025 17:11:17 +0200
Message-ID: <73c9e0ad005210c0813316008ec69fe3da1bd4ba.1748001837.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748001837.git.sd@queasysnail.net>
References: <cover.1748001837.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of preemption, xfrm_state_look_at will find a different
pcpu_id and look up states for that other CPU. If we matched a state
for CPU2 in the state_cache while the lookup started on CPU1, we will
jump to "found", but the "best" state that we got will be ignored and
we will enter the "acquire" block. This block uses state_ptrs, which
isn't initialized at this point.

Let's initialize state_ptrs just after taking rcu_read_lock. This will
also prevent a possible misuse in the future, if someone adjusts this
function.

Reported-by: syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com
Fixes: e952837f3ddb ("xfrm: state: fix out-of-bounds read during lookup")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 07fe8e5daa32..ff6813ecc6df 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1389,6 +1389,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
 
 	rcu_read_lock();
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
 	hlist_for_each_entry_rcu(x, &pol->state_cache_list, state_cache) {
 		if (x->props.family == encap_family &&
 		    x->props.reqid == tmpl->reqid &&
@@ -1429,8 +1431,6 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
 		WARN_ON(1);
 
-	xfrm_hash_ptrs_get(net, &state_ptrs);
-
 	h = __xfrm_dst_hash(daddr, saddr, tmpl->reqid, encap_family, state_ptrs.hmask);
 	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
-- 
2.49.0


