Return-Path: <netdev+bounces-180625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C7A81E62
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F69C16F09E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC925A2CB;
	Wed,  9 Apr 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="vwYt2zIG"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B241DB122
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184139; cv=none; b=bLt8BpxEFNweyQAnnCzQ6mqCB0DJAbhSBcRgOY0MkUTEbQkQ1mwKY27Hh/cB7fKOvgcZ7Wdg96EIaFP5noHDlsRrZqpIOgz8tJ7D7tu1JRBDTBtKYXSCNODHF8AaOBjrRDYcelS8T+tGW7k8gFJN99rB8Ipw8hWWmOVJYkgonjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184139; c=relaxed/simple;
	bh=2i2ElOIHfFUI+rwIecUgEWQFs7ppPsXbnxnflwFBinQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOcZCVofl21A89/jHD0ChlgWlRb6FxJr1zNGLIKpyFM5MKGa8ViliUQdIh5wC8nuEGpWLQWdkyEIs6ZYGT2tC5H3fa0qdS5D+Cq+slVWGwuBx87ubIBvXd8ToZ4KgSXJl5CfHYFcVUrcNzTEKGmExRIACY8M7TCmcDuVItBk4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=vwYt2zIG; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744184135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xVNzRLY98u++RB6J7qNPYReDNZiCtKlLPCUCWoran5g=;
	b=vwYt2zIG96v/HlPtlQQh/axiq13T/ab/FTWwcFvZ+LU0+JhFY5QkKNKRo5xId/9YpGMlsd
	4nV6dwT037bA/9LFftdGLxNKKD8Txz+R87VX5ezFaaivXIVih8ASCbbiABGgq0f2/uiMxU
	JiEPtE5aUcPY0hu9AaZDZGvld9NzIPk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting enabled
Date: Wed,  9 Apr 2025 09:35:24 +0200
Message-Id: <20250409073524.557189-1-sven@narfation.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in this place and thus there was an imbalance when trying to
remove the interfaces.

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f9662653..7cd4bdcee439 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
-- 
2.39.5


