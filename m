Return-Path: <netdev+bounces-211518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC6B19EBB
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AC17893A
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3F246779;
	Mon,  4 Aug 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="R/jep08r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZfChBM+m"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9651EEF9
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299602; cv=none; b=d34AyE/PkPBpkA4NHgxk1TAfC2qCX4wMkkSWFFpDdhftCDoG+HbMbYG5nZjqk6BgfgZd99ctarFppNopwQklARFAlD6dWExU+Ln5GAO6UUZQmM+43T1lASLH8CJGXXT58wud+hDMq5lL+ZL8Rh2ZmMeaL/Jpux2QxAfR/mJV5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299602; c=relaxed/simple;
	bh=t6zVkmH2+OGMpevJQLoTqscNUmScOL90fecHjKBOv0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcgWnAv3xWh8jemXqg0VLMnxMKEX/GYo1UexDZxBoUqWy0fMWt/NTrBQXvqLqZLeGgIKYuYsCE6t3S7fULiqdc7bxZz3uUluvbw6Ly7phlG2ZWuUxsG5eTK7I9LR7qckvINZr7rS6Gr9pNfbFl0wWVwVv3LALG+4V+6p0cu4ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=R/jep08r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZfChBM+m; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8FFC01D000C2;
	Mon,  4 Aug 2025 05:26:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 05:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754299599; x=
	1754385999; bh=0ooAY6SBkoVQOscUto4sVokJpcT9ts1hYIFzg7Bljyc=; b=R
	/jep08rztuMgW2zLdsAmr9B1YLkmqWKUNyoyMaMdNJG9j/MdEpH0lepHDuHixm7W
	0q08yX2fyXvUQohpbBdgj4ymr7rtHCn38bYLb4lD6DyLg4d/qVrYuXpF9DB226xF
	+r2dV5/GP8yeB734KIIWj7jsbQrCfWGKujEZwrAmkZf7dK8ZoHJgAJlpPX9WbtRT
	qpNOu0q4jk7Tkqj6/D/UwFpKJQKQbEozFlWhJ6BnghvAju3ZJmCfsd5w8PsBRVJE
	V2zsKMZ9B4rYXZ/Nr7MXUjCGqaXXmHSkXpakTX/X5zweZ+RTWgL1TheBqETJ0VmL
	/SBpPfIlFtN51MiDHYQfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754299599; x=1754385999; bh=0
	ooAY6SBkoVQOscUto4sVokJpcT9ts1hYIFzg7Bljyc=; b=ZfChBM+mj31RPzCJ3
	iapjaTD6NaG192cWIPmgRHxJ5xBKkKsn4hPv3z8p2plOta4o2czlinlW3tL+Gp6D
	o9urPs5Og6FlsgnvCfTSJHiK+VsDxupG+94zxaytHeQyNWCfS6IQpE/7Vs+LYrco
	nS74bVoKxiW+4AFK+umLE6U+9XtY9T4UAUej1QbI4+23AcAabchrKAPdIYU9MBYt
	zyGtdoHI0I5uGEMvANSi8GSxA+rLer5iKyWLFTx6BzrWWZwWx68zAChstfHw6EIK
	5TjxLiWEfoCI0LINdNUtbYPPK5zZBQCPZvCyle9J8Nw3vLWFTMRiKq8HgJPaMEn4
	M8VcA==
X-ME-Sender: <xms:z3yQaJQtvNNyuInTA79z3ArpSwznwsyBnmy05LxXbb4VshfMyUCn7Q>
    <xme:z3yQaOTylDd4bIMRAg9aT7-Q6kVmNPFZBU5IwmGtH5scd33yGHU_TlwomXviOIJKP
    jc1Yr-N_2We96RnxNY>
X-ME-Received: <xmr:z3yQaFRtdaROQGBK59kHEifhhSUqyDTSFjppUPGBT4GY9hdkoW-N1-pp5-UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopeihrghnjhhunhdriihhuheslhhinhhugidruggvvhdprhgtphhtthhopehlvghonh
    hrohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgv
    rhhtsehsvggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:z3yQaL7BvlxCylySNs5eimSeuFdGWP8oGH5rKge8Yv2enUnwGoVgUA>
    <xmx:z3yQaJ2LbUJcG0mXcdGtiJWghZpeE3gCc-YAnruH66iHch9SPNlgmQ>
    <xmx:z3yQaODHCOW2KSwa8E5oQ1rFLRB9AyHYgWHnLKlblAVXYiL_RHJHFg>
    <xmx:z3yQaMObQeKSyw-v4uyLwHXHd-w8sy82iDf5PcUZ6TTXYtupyHMAhw>
    <xmx:z3yQaGS8hWxNRj8TV4LKfVdu-A-OQapS9s6S1cK-naQzZkc4Vd10fq6Z>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:26:38 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec v2 1/3] xfrm: restore GSO for SW crypto
Date: Mon,  4 Aug 2025 11:26:25 +0200
Message-ID: <b5c3f4e2623d940ed51df2b79a2af4cc55b40a55.1754297051.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1754297051.git.sd@queasysnail.net>
References: <cover.1754297051.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 49431af6c4ef incorrectly assumes that the GSO path is only used
by HW offload, but it's also useful for SW crypto.

This patch re-enables GSO for SW crypto. It's not an exact revert to
preserve the other changes made to xfrm_dev_offload_ok afterwards, but
it reverts all of its effects.

Fixes: 49431af6c4ef ("xfrm: rely on XFRM offload")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
v2: unchanged, add the tags from v1

 net/xfrm/xfrm_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d2819baea414..1f88472aaac0 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -415,10 +415,12 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct net_device *dev = x->xso.dev;
 	bool check_tunnel_size;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
-	if ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
+	if ((!dev || dev == xfrm_dst_path(dst)->dev) &&
+	    !xdst->child->xfrm) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -430,6 +432,9 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
+	if (!dev)
+		return true;
+
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
 	switch (x->props.family) {
-- 
2.50.0


