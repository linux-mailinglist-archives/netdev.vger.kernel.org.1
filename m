Return-Path: <netdev+bounces-15013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92574538D
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 03:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E3F1C20754
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDC438F;
	Mon,  3 Jul 2023 01:27:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8147FB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF8AC433CB;
	Mon,  3 Jul 2023 01:27:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iRY8hJR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1688347666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vU3RCfgpG3KdwhpqFpp02kiLPLFZCp7TDcMNE+j7so=;
	b=iRY8hJR8i2eVuexomX9EezsGevM7ROEItROH313UlYQR+njzqHIHTkZoDeK4YyRD74+XsD
	NFlskBYmOugnyGJPbyVVd7fMFe3llY7hUFbKOIgJdIspDRVygjp0D0mBNnibkufui1zmlN
	wK8I305qCAyIVbrP08Zc6sRg+gYFC+w=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6c37c271 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jul 2023 01:27:46 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 3/3] wireguard: timers: move to using timer_delete_sync
Date: Mon,  3 Jul 2023 03:27:06 +0200
Message-ID: <20230703012723.800199-4-Jason@zx2c4.com>
In-Reply-To: <20230703012723.800199-1-Jason@zx2c4.com>
References: <20230703012723.800199-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation says that del_timer_sync is obsolete, and code should
use the equivalent timer_delete_sync instead, so switch to it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/timers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
index 53d8a57a0dfa..968bdb4df0b3 100644
--- a/drivers/net/wireguard/timers.c
+++ b/drivers/net/wireguard/timers.c
@@ -234,10 +234,10 @@ void wg_timers_init(struct wg_peer *peer)
 
 void wg_timers_stop(struct wg_peer *peer)
 {
-	del_timer_sync(&peer->timer_retransmit_handshake);
-	del_timer_sync(&peer->timer_send_keepalive);
-	del_timer_sync(&peer->timer_new_handshake);
-	del_timer_sync(&peer->timer_zero_key_material);
-	del_timer_sync(&peer->timer_persistent_keepalive);
+	timer_delete_sync(&peer->timer_retransmit_handshake);
+	timer_delete_sync(&peer->timer_send_keepalive);
+	timer_delete_sync(&peer->timer_new_handshake);
+	timer_delete_sync(&peer->timer_zero_key_material);
+	timer_delete_sync(&peer->timer_persistent_keepalive);
 	flush_work(&peer->clear_peer_work);
 }
-- 
2.41.0


