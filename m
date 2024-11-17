Return-Path: <netdev+bounces-145684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFAF9D0624
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E952825F9
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403151DDA37;
	Sun, 17 Nov 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ib3Ej8zj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45C1DDA32
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878471; cv=none; b=nCwd0cY1mreP8L4QpmqZDfSm1kMfuC3jsVd71Uwm5w7icVem6BLDKqlIHKJm+w1pVSgtXdI+TBqvISAw8NuiQS/6DO94O260TIJ2BeUUjHAo27apj8CjDrmAb9L33MoUhsO8lF1U6C5T8Z0TEahLKssoP3JWn5o9KRh/uz5fUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878471; c=relaxed/simple;
	bh=myTrKPrEiCbr0l9ZVuL3vediqNX7OzsDWHXbBZFQFNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1YcX89SbJeb7xdEXXYwV7STdBhnUWWzmxxzp8ArW7rOazAShc03OhojwOyXMcGqJEy1DXoQGIA84QdNd9x/7NG3ep75OUMYLC0vrWWDHopZpB5pBUqwrZU4gFfR18Hs7JFTT3G83bAI1oskIkgeHsR5NgHvDXa7Cd+CSCNp97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ib3Ej8zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C53CC4CED8;
	Sun, 17 Nov 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ib3Ej8zj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731878469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAI3YYMq+wK8me9bfzDl3I3A7dq0Arq0Ow/Bnq4ULG8=;
	b=ib3Ej8zjyCaQ0SW8yLmZpXg/Ttw1XbfsWmf7onVXqPMFhO3a1AwjQQYX94LOXccbaYzb1l
	Zj0df8KocUmmDD0PaywHZO8Gy+KxxBhQ25aVCWqlC73AEHoVtilh9GItRrEWiU8f/FgpEm
	5ispf5wNiuA9paPoEkZQ+c3WP4yYCLs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 52a546eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 21:21:09 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Simon Horman <horms@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 1/4] wireguard: device: omit unnecessary memset of netdev private data
Date: Sun, 17 Nov 2024 22:20:27 +0100
Message-ID: <20241117212030.629159-2-Jason@zx2c4.com>
In-Reply-To: <20241117212030.629159-1-Jason@zx2c4.com>
References: <20241117212030.629159-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Klauser <tklauser@distanz.ch>

The memory for netdev_priv is allocated using kvzalloc in
alloc_netdev_mqs before rtnl_link_ops->setup is called so there is no
need to zero it again in wg_setup.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 45e9b908dbfb..a2ba71fbbed4 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -302,7 +302,6 @@ static void wg_setup(struct net_device *dev)
 	/* We need to keep the dst around in case of icmp replies. */
 	netif_keep_dst(dev);
 
-	memset(wg, 0, sizeof(*wg));
 	wg->dev = dev;
 }
 
-- 
2.46.0


