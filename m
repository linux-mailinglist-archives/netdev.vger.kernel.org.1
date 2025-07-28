Return-Path: <netdev+bounces-210546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A1B13E0E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C4D7AAAA0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F174271456;
	Mon, 28 Jul 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RQUpPht/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwXdYAT/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8772621
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715887; cv=none; b=AjLntgkv8Pzt73/FTqpX+cdumjjGnG6xVE5Z2N+BQ/VeoWGWYg+/+2Ut5dkYTygUzKCteKvrLljlfeRmOORRHEQMHMEE+MmUsKdtsxQWYD/Zbo1Mm1Tuus2YAeJ31TiOPBzKMhIWDcl0WqZbBKKAl6gtZe9Sh/oOaZhsVyvUQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715887; c=relaxed/simple;
	bh=oL61CC2gESDhOaqe1Bqf4xl1dITqiXc2kZoWkeFcZgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6Tbmy3IdFuoiSR50RHh+QJhaa7e7nwkQB+zSpN67r/C5oNWO4V0e16+RXE3ySkTAH9U04TO9OLmBcPtRlEQ5gzBDLXo80zvdOgSDx5gRQON8gVLOYmBgEuT0orJ4zBBFB5/OeRChyfE3RLmzST1DiqyChQLQNqYwavCpj1QdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RQUpPht/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwXdYAT/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE535140023E;
	Mon, 28 Jul 2025 11:18:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 28 Jul 2025 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753715883; x=
	1753802283; bh=9IWHf7IhGHYk7uX3tEHjIHrBuEZT45nnF+kcZX5ug64=; b=R
	QUpPht/iDhAOgFM3DPA+TOt1FsfZ/pOLqptt0KetP6jznbI3Fgu+qP3uOj7GUgBG
	eRHsYOZJXHdv2l99eswd+RY528qfcbL2IT+c2KLIH1WXP4s4z9rw65A+Lw4XSjK3
	sDtGjj+q62Nn0pF6x4rIRD2jvdpxurP5qylysXuuIx3gzHa0lKtoABIUpaD6wNcy
	BLbg0+xfARCGYMcKz1X004/2yq5BLZ8bVldPW6o0/eDovZI/Nc6fTxV/E2m6hysY
	NvQnvxP4ROXuGXV8JucpSC2eB8vCm8sEJFR+rleKoJdxX9lphHW7Bby8WgwdE4Cw
	3kjq2eSo4qdleaMV67LuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1753715883; x=1753802283; bh=9
	IWHf7IhGHYk7uX3tEHjIHrBuEZT45nnF+kcZX5ug64=; b=ZwXdYAT/jtw6yFxlC
	q0zEWek+g9EU8YcnQwFUTOXQ/lA4lUnGglZQA2uKwq8tQNP2qeNu3OaSgnFjh86S
	YlBp0aykt8bD36erY+1jwGaURtkGVbr9/G1c4JMSkq5bvyscY8spjjWGoBK9HX2Z
	k3g+IKcUluNVTYFVcCwLyQOVEONPoX7ybhy9KOEFjwAARZMmmaziiNeHl3MjtBKv
	hsHcoy9X78PtFPQl3H7JAS4d/HPkUbcnG2dEnA9DQNRSdXAq2dZt8Tn675BlAG34
	F/dPY84RhRYwaEGKAaFJrFc78Tde6RT91EN1ICEM8ZIbYTSl0/VK9aYWdKEt9grE
	15t9g==
X-ME-Sender: <xms:q5SHaKWYbevpzG-zF6IBHiPuY77zVJGwG5zfW_9GgDwXof-CIgpArQ>
    <xme:q5SHaCHP_CUr5z5xPRIzr9zJafcurIZ3FPkIk7MQHRnLM8fu-hjNAg7JYkTjXyiDO
    u287_x3CloXNpYeE1o>
X-ME-Received: <xmr:q5SHaE0ByWTEItlWreLLgnYTG0NgiGQKp4ZMMo5iecth5P4jM-PZK3EOpYYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfetveeuleejieejieevhefghedu
    gfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthht
    ohephigrnhhjuhhnrdiihhhusehlihhnuhigrdguvghvpdhrtghpthhtoheplhgvohhnrh
    hosehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghr
    thesshgvtghunhgvthdrtghomh
X-ME-Proxy: <xmx:q5SHaMN40q56f08j6rLFpJErcL1ItazBk1rWZ8uxR2Qu3CDQhvf-dw>
    <xmx:q5SHaL723PlWY6ShU5FBME8fJ1C7SuL5qCcf4USC8G2x_FGolZi31Q>
    <xmx:q5SHaO0KJXpnB9ik9C9CDRs0DBbR8Nvc2gYeyxpQi5_w3w2Ct3E4NA>
    <xmx:q5SHaEzWg9mnddvQyBoJbc1kslULGMNipz-HCYArCI8704_pqH3jaw>
    <xmx:q5SHaHFUiLUwweHsAqa0bSC8ldqN53_20wV3IUhcIbLhNo7pQSzqXL6C>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:18:03 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec 1/3] xfrm: restore GSO for SW crypto
Date: Mon, 28 Jul 2025 17:17:18 +0200
Message-ID: <b5c3f4e2623d940ed51df2b79a2af4cc55b40a55.1753631391.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753631391.git.sd@queasysnail.net>
References: <cover.1753631391.git.sd@queasysnail.net>
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
---
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


