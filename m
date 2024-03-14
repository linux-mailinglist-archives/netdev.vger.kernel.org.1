Return-Path: <netdev+bounces-79991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9AC87C55A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E71F22229
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1EFC09;
	Thu, 14 Mar 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dho5XwqT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B51A38F6
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456578; cv=none; b=HwGj+d862ZRDg0WQ6E/8CYT/DmeGie5Jo5D2Hk85SkQahAqDUsxPPopoeiQ6aFylFc/ARWZD5Xwn/jTiioMCn+tMbbHvLMB2Ewu2liIYu5dtL1dWazFgYjl8U9NaO8n6PHxyfljDc07TJBhGnAETlW2b/3nST9Nc1JicY46dqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456578; c=relaxed/simple;
	bh=Rb6VGQ6fQuJ1kItmWGWZ/UZCph3rADuYS2nrOD5wlqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhpx44Tk3IjP8NmoudOTUj1qbAAni93/0y+dhXah5jj/FviFv63t1/Wp0hQ4Tntm90u2/by8k+NYRNixqhGvYGsPS5+anj0G9hWENaNze+WHv2VrYsmEWkAd3EoZMHmJjn+Tdkb4znPS/92SofOlIjqUg+JT+AFIk1E4cInf5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Dho5XwqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840F3C433C7;
	Thu, 14 Mar 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dho5XwqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710456576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONzSgUSSJR4+w+0GGNLm2Fs6cV/TL8+9tLp9WRSxE20=;
	b=Dho5XwqTE6iyiihy8gTq4qapsUh84iQNva8QXRpkAOBZIo/+WTnjT/Nn7Ol8KteimSLgsG
	uIlx5pLYX6tBp+Qg22gS7yJwKfaPME3wn8J8w1pU+Zxi9+F2bk/kF5QgshLBODZnKOrqRp
	t48f7HdtuKEhTC0K1galZctGOL1BSDU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a2ab8b36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 22:49:35 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 3/6] wireguard: device: remove generic .ndo_get_stats64
Date: Thu, 14 Mar 2024 16:49:08 -0600
Message-ID: <20240314224911.6653-4-Jason@zx2c4.com>
In-Reply-To: <20240314224911.6653-1-Jason@zx2c4.com>
References: <20240314224911.6653-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 6aa071469e1c..3feb36ee5bfb 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -237,7 +237,6 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_open		= wg_open,
 	.ndo_stop		= wg_stop,
 	.ndo_start_xmit		= wg_xmit,
-	.ndo_get_stats64	= dev_get_tstats64
 };
 
 static void wg_destruct(struct net_device *dev)
-- 
2.44.0


