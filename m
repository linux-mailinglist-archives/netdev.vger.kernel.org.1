Return-Path: <netdev+bounces-145685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA29D0625
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B361F21B81
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280C1DDC06;
	Sun, 17 Nov 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p2JsW7sE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4A1DDA32
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878473; cv=none; b=b8T/doGIv7wJ9bS1QGRO7HZlYsfK8iAyTjqmNqb6q7ZkNAIxgBSR6mqdtR6s4icy1lqPoYJ+YORKNhj3gF1cC+puM3ieA+Js37VyN9NHbJTNDs832EmE7oo8rbtFi1zTvvlvRLdrjAY3R/XweDrUDbRxc9o5BNBC1jGy2NjAVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878473; c=relaxed/simple;
	bh=TWpXHz18BmTz1HqGLrwkKlxAc3zXBYyPHZZ+Xr51kFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATcdtAaL9jJtEqy3Dsfg/rLTuwAfSgBpTf730YTaPbu7w+G8XRMKaNpiJNvPcdRZQT6GSLxM6veS+vB8e5mbfZNxgyqs35mZB08X3MHl8gvxK57Dl6FgKOBQrioiwPoBaRZHWZk8JzFNtphZ+X9JXHlweMYuIJjNWxSCjBGqHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=p2JsW7sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9C3C4CECD;
	Sun, 17 Nov 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p2JsW7sE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731878471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOXBQOJcaUccVx9FJFub+6t78xbHQ8Uulb/NRgyVCN0=;
	b=p2JsW7sEFkbMJCrf2ankl7uauBJMMLx6eMujKCJ+bd9H0I7qrcXTupGMUwcGdRXvT5Dxk/
	NhOhNzLn1GZnQrrYH8dHIQ85rN8A/DghlaLo/7wQUZBbWtNtH6WRm7tWezIHmH0Ljtf8ol
	lBgXnRUVw5VptgV9YhK1MuWe5hoZ4Ls=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d9dc98f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 21:21:11 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 2/4] wireguard: allowedips: remove redundant selftest call
Date: Sun, 17 Nov 2024 22:20:28 +0100
Message-ID: <20241117212030.629159-3-Jason@zx2c4.com>
In-Reply-To: <20241117212030.629159-1-Jason@zx2c4.com>
References: <20241117212030.629159-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>

This commit fixes a useless call issue detected by Coverity (CID
1508092). The call to horrible_allowedips_lookup_v4 is unnecessary as
its return value is never checked.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/selftest/allowedips.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 3d1f64ff2e12..25de7058701a 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -383,7 +383,6 @@ static __init bool randomized_test(void)
 		for (i = 0; i < NUM_QUERIES; ++i) {
 			get_random_bytes(ip, 4);
 			if (lookup(t.root4, 32, ip) != horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip)) {
-				horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip);
 				pr_err("allowedips random v4 self-test: FAIL\n");
 				goto free;
 			}
-- 
2.46.0


