Return-Path: <netdev+bounces-180626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C95A81E61
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A61BA4933
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B0259C93;
	Wed,  9 Apr 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Vhg2ETxI"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDABF1586C8
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184145; cv=none; b=UvH4wg1Hr3yK+9JPjqFMGRUBtK6MkjXdNxke7XxIvPdL9P4f4yPb4y4kUXpNrg2d5UbwxcWTbub0vg45cxwQvXYbOc7ydAvTeKqCOaAkTmnslon0Be19BuOitlegRK5BAEwjJ57QIJ6TTsgcTtXg3STw2XugUCz4aFraG1iS5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184145; c=relaxed/simple;
	bh=c5kq3MmJR0znm4JNsEVYsis8JOzDOHdPfDOEOxf6OYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JP78gfaa3LEiz54ppScqh/HEF3a/XJ7eAjh9tsga4DroGRvZAabuFXJ0LK167EeWRnb1cSoROLzqGOxiQ9BCu1cuwt14mWBvx67gQIbpBQ6iUVOKVKcIO8AC2O0bWlqoctRcQkbgxHN8slEJj8V1eNdcQ2bTUSt1BUGTI3ZA+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Vhg2ETxI; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744183811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NahKR4D7zw6yAZl62BqbkPPNvwTaypc5laDZMUthQtg=;
	b=Vhg2ETxIPSTvVWXaj9ILySdSaaS4rDCbdSTM/Ab7bXZZ8scMcgT7ThHW+XGZMDsGmSzntR
	N71GC5ShIfZNESMvWAbZ7N0BMMvgaen0cyKtZUxEMb+wEmpKcoXRVRymjfH5lDRKJLPgQs
	lsmbfyCHfvcnuM1wQ6azex22hq0/4+s=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>
Subject: batman-adv: Fix double-hold of meshif when getting enabled
Date: Wed,  9 Apr 2025 09:30:00 +0200
Message-Id: <20250409073000.556263-1-sven@narfation.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f96626531053bbf8f58a31f28f625a9d80f9..7cd4bdcee43935b9e5fb7d1696430909b7af67b4 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);

