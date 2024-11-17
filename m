Return-Path: <netdev+bounces-145687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734B9D0627
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0465B1F21878
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754CA1DDA21;
	Sun, 17 Nov 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UaBUHwo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E51DDA10
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878478; cv=none; b=JIvBuc8HaopNtXJSaJYj0BDVd7MT4W4F4OV0mlqAsgVZbk9MFKcmHuzGBmOo58sEwGwQ1XIVCECeb7iWggy4PQ1yFL6j8VdR/J9fKu55WixQnB5NXpUuKWxqxHCUedVFpkoMCSg2Hq2MCJDOl0oajqM5ffdILvaunfO4AItjd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878478; c=relaxed/simple;
	bh=aZ8mv1H8hAV5CmggfZBcJ/BBuPJho73gMOmFXaDj438=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4DMd1D32iekgz1Nsn4tJjXEUJ8+yqJb8AJZMSJ83WumVnjeWp0QRHwrppo5YQGwntw65GZUbmSr2TZg3Nv7ejkO14SWUzTUcQw7XLX1UWZ6iuAu8CemtCr54UlZ5DW/Ro5DBqX1qcR7GoMSYEqXwdFA8iUynNAgV+SSPauKl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=UaBUHwo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C6FC4CECD;
	Sun, 17 Nov 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UaBUHwo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731878476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3coEH8+ObZEE1tdbLgyTn35HDYTQZNWur0xxCUN62s=;
	b=UaBUHwo7cvA4cJwXW4mTBMrJ4+O+yCzTLvGtzetAjb7ghxzUBLtWdJG7F2VlagBpU26amW
	Cr+ogj2/02KRwAIUN6EASLsq0WnyepLhOk9n6Af7YH1qxddXAt6Pc9w3b1+wZN096sdsOs
	RJiy/qSvqxT8RlQq0Kf5okVIzNeEFy8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d50f56b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 21:21:16 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 4/4] wireguard: device: support big tcp GSO
Date: Sun, 17 Nov 2024 22:20:30 +0100
Message-ID: <20241117212030.629159-5-Jason@zx2c4.com>
In-Reply-To: <20241117212030.629159-1-Jason@zx2c4.com>
References: <20241117212030.629159-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

Advertise GSO_MAX_SIZE as TSO max size in order support BIG TCP for wireguard.
This helps to improve wireguard performance a bit when enabled as it allows
wireguard to aggregate larger skbs in wg_packet_consume_data_done() via
napi_gro_receive(), but also allows the stack to build larger skbs on xmit
where the driver then segments them before encryption inside wg_xmit().
We've seen a 15% improvement in TCP stream performance.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index a2ba71fbbed4..6cf173a008e7 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -302,6 +302,8 @@ static void wg_setup(struct net_device *dev)
 	/* We need to keep the dst around in case of icmp replies. */
 	netif_keep_dst(dev);
 
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 	wg->dev = dev;
 }
 
-- 
2.46.0


