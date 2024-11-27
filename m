Return-Path: <netdev+bounces-147665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D067D9DAF74
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A8B20C60
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159C204F71;
	Wed, 27 Nov 2024 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="EUyj5+HQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YyLTcLel"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F952036ED;
	Wed, 27 Nov 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748329; cv=none; b=PxZGx7yWIoQw8i66oBY6gQ/5r7706KDDmsHsjhlReCBY3q52b91IJZjp/6VnajD+7k1I2CvMI93PV/9F2ap5QqJ5xQBu42dJhoo/S4o0UZxthsT0W799IrIgeSieHtUu3i8SHZngrpua6N4Ot2D8SQ3bj+Mv9GZ4g0Be6Ns4UiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748329; c=relaxed/simple;
	bh=vj5enPpd/XiXqTwZ4ZKIHjG+vVXbJeGqCFyVQC+B5t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/m/Bdn97n3CIWO3oi0e9B0siaG3mGdhLdde0eLjb0+Dqe/6C4EbetYJTe0agLQRTL6HEKUWJKB+6roQjMYIHVsjoZQw45MkbEIaTrT+T3fUaPrDF3CtmycME68NhrNqJ5+//xYandrsr06ERzS4qslhrkYlkMbsfy8/+YEcut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=EUyj5+HQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YyLTcLel; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 96C031380439;
	Wed, 27 Nov 2024 17:58:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 27 Nov 2024 17:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1732748326; x=
	1732834726; bh=kmaKp+gO5Ni6M6T4MZ2C6qRQyeNlE74ySZwdK112b60=; b=E
	Uyj5+HQ4thpnpnFlJ8tycfWTctLRr+HhcvW+1uZhXRlruL3kRPbq5uQpgEUIrkB9
	lvZHyLVD3ZKfRuJjMmZy9fTnN8UWQ9x9929av29Af/OjJtQmNNnB776J9SjHV2oo
	MI2/fGV1VmfYDgpcVgQkmI1i3m3xBVoiqrW+NJ40kOHfer0O7VLCH6nnHYtEEQyq
	P+HXZ+W5mWXka2UId1U1j+/43yUn9PkRxa7oBVpFeOmLNsSBPbbgJNcPFLpRmWq6
	+j3HvhoaaAOPoaQfSSU6URauWyZrqxnuG0qL604IyyK6fJTGc6kRw9YELlb4L6Y+
	eu5OvlHre2l7nI23F2KsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1732748326; x=1732834726; bh=k
	maKp+gO5Ni6M6T4MZ2C6qRQyeNlE74ySZwdK112b60=; b=YyLTcLelHuqvMv6EZ
	EFayjK3T5YXbZNiciJ0Ywg/Gb9SynOqlvc9cvQdWQgF8MZz2jf/xeVx/XxNSqtBE
	anjfDHLF73aV6wgb9gXpE8BljoKy05dAq/whG9MhU9+8ad0kcsRV4k+ZUqBHZzGl
	soLcfZ+u9U3xfIvo+I/OCkAZLVvKJNMkbZab+0BrVkBzqinT3/cvYvUOAAYTo9U9
	g8dvrkAubiojE31PoZgsiG4XrTkzGCfLmOTWEhRh1vR+lEP1sP139imN00qY1icc
	ZHHoZmCWOIibECJPq+oGXt1SKP5X1T972CeBped/dokLi5FxZxGXefpYYhu0NJ1a
	wIANA==
X-ME-Sender: <xms:JaRHZ0PJScmAMk4CKa1E1qThYe8-9I5393gNSLYr5k-1e66CHJ91rQ>
    <xme:JaRHZ6__9up1zrUbERW5ZDVyPp8XSDrDYncWAwMQRcj2e-xu_YVu3p4ti037Ca8aZ
    HcJPGIM105SglcZHA>
X-ME-Received: <xmr:JaRHZ7RvlmPjiJzxIKd6ImvznOVcfZGd804yXaqH-U8WbgTnjy4oSgQI05BNr1tN-HLMrzDDW_S1x3FOyyy9sEITCD1Z9pCDEa77fxil7QBKwX0Cw0cX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrvhgrnhdrtghhvggs
    sghisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehkrghlvghshhdqrghnrghkkh
    hurhdrphhurhgrhihilhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggrvhgv
    mhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmihgthhgrvghlrdgthhgrnh
    essghrohgruggtohhmrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:JaRHZ8uzPObqw5Z6V2Usogu8pG_J6RMciTLp99fFn9jdYz36nftxDA>
    <xmx:JaRHZ8ezyJZgxIkC--ZDqHGoTWrmmpKtSy770y7EgWxGbCtZO0baOg>
    <xmx:JaRHZw3yU1P-dHcHpdMFfhKqQ9WUrqDOC6KCBeIRhstyeJ4PmsoFcw>
    <xmx:JaRHZw9Pz8IUMmHGk0S40gpNDC87smNINnSBvmm7XDD56ibOMRU4iQ>
    <xmx:JqRHZ7_Z5QyWKIzb0KTFtAW_V2qXZG8GP6bvg0ToR_9eEpdX5fLZy__8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 17:58:44 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	edumazet@google.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	ecree.xilinx@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net v3 1/2] bnxt_en: ethtool: Supply ntuple rss context action
Date: Wed, 27 Nov 2024 15:58:29 -0700
Message-ID: <2e884ae39e08dc5123be7c170a6089cefe6a78f7.1732748253.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1732748253.git.dxu@dxuuu.xyz>
References: <cover.1732748253.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS
contexts") added support for redirecting to an RSS context as an ntuple
rule action. However, it forgot to update the ETHTOOL_GRXCLSRULE
codepath. This caused `ethtool -n` to always report the action as
"Action: Direct to queue 0" which is wrong.

Fix by teaching bnxt driver to report the RSS context when applicable.

Fixes: 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS contexts")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f1f6bb328a55..d87681d71106 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1187,10 +1187,14 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		}
 	}
 
-	if (fltr->base.flags & BNXT_ACT_DROP)
+	if (fltr->base.flags & BNXT_ACT_DROP) {
 		fs->ring_cookie = RX_CLS_FLOW_DISC;
-	else
+	} else if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
+		fs->flow_type |= FLOW_RSS;
+		cmd->rss_context = fltr->base.fw_vnic_id;
+	} else {
 		fs->ring_cookie = fltr->base.rxq;
+	}
 	rc = 0;
 
 fltr_err:
-- 
2.46.0


