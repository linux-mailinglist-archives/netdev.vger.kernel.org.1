Return-Path: <netdev+bounces-79993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE487C55C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B83D1F21CFB
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87D6749A;
	Thu, 14 Mar 2024 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jZlTpBvj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B8F9FE
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456583; cv=none; b=U/+B/Jy7LlXRf2ZvcoLmXY1SPifbrjrNDLg5+5QCkrMk96EUa3InAazJqnnCV+vVnfSSQzP930B7OP5zYMwlCFSAb1uaVuaJp1kaE7mIzLuPGfeYXp4+u+OgyfRHqjBtX7p2nX1XHmUMD/9/DXKuQHdn81vCUkyoHPpLyNRR1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456583; c=relaxed/simple;
	bh=bU6hlmxcqfU1Mxcll51ElUgz3IWARHp5+sq9lgA6Jz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1Mr6hQOb+TfFd6fKvKXZwqMZrkawIC9U6mYL8M15eZJiYAEGHT95Wj8PIMe8fBMVKj9e3VQTZDIfDXgIYWolWjltM+d6U9XyrnG3suEDAL6z8OV/FQXp0TLlIJGfWj5PCsli42/e6I2iZ6+pS/hl/YvPe6I+JfipcEandpoQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jZlTpBvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E117FC433C7;
	Thu, 14 Mar 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jZlTpBvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710456582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UyQhYgFCQahP0/R8bE2J4qjkZMtAjwtv3j+YGBRP2M=;
	b=jZlTpBvjEbaHGOxAV1n/oyQCucdXp9H5VmRJ/dlKC75UEyp1f4qmATqVHAYhTf1lBi6Eig
	xrxfB+GoV4ujCYcjpvyjvwyL3BJ1NXj4XUnZyN5s1oF/UjHJvylSMIHEO9h7A307hfwMNv
	10vbPT3mrRSFgP9YsQaadWzAAG2NF0A=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ec59dc69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 22:49:42 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 5/6] wireguard: netlink: access device through ctx instead of peer
Date: Thu, 14 Mar 2024 16:49:10 -0600
Message-ID: <20240314224911.6653-6-Jason@zx2c4.com>
In-Reply-To: <20240314224911.6653-1-Jason@zx2c4.com>
References: <20240314224911.6653-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit fixed a bug that led to a NULL peer->device being
dereferenced. It's actually easier and faster performance-wise to
instead get the device from ctx->wg. This semantically makes more sense
too, since ctx->wg->peer_allowedips.seq is compared with
ctx->allowedips_seq, basing them both in ctx. This also acts as a
defence in depth provision against freed peers.

Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index c17aee454fa3..f7055180ba4a 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -164,8 +164,8 @@ get_peer(struct wg_peer *peer, struct sk_buff *skb, struct dump_ctx *ctx)
 	if (!allowedips_node)
 		goto no_allowedips;
 	if (!ctx->allowedips_seq)
-		ctx->allowedips_seq = peer->device->peer_allowedips.seq;
-	else if (ctx->allowedips_seq != peer->device->peer_allowedips.seq)
+		ctx->allowedips_seq = ctx->wg->peer_allowedips.seq;
+	else if (ctx->allowedips_seq != ctx->wg->peer_allowedips.seq)
 		goto no_allowedips;
 
 	allowedips_nest = nla_nest_start(skb, WGPEER_A_ALLOWEDIPS);
-- 
2.44.0


