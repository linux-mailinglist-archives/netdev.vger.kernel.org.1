Return-Path: <netdev+bounces-270407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDBlJz77wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:35:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 181852EE4B8
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89E7E301469B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32F37FF6A;
	Mon, 23 Mar 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HAJ5Lmc8"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AB379991
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254902; cv=none; b=D2ivEkvAYajlCJuKzMtWGb9caP/hj2LYVJC0nvNYBaPLpBcHfkF9KoFYLowWaEab73SjQHb4RSYhJotkZsGCEsfbfMe2PAU3lqiX5cAKxAOH/oUgC47Ozr8y7mA02cME0esO6UWwbK1TiUHfSuEZrhyagsrUvFwobkzLC9fQPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254902; c=relaxed/simple;
	bh=3j+XZrCFIPBDHW6Yu2JsEsxSSdjtvt3Jjns1Q1JxkYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQrrw0mV8gQ6B5tcYcfXcaLHG4EyGXmyG8DP5uq2/qth3B6wG/Dt4ozuVJ9HHgyBl0OF3hQP2WeXihVAsT8edY9ZQqcbMcTuzUyUGxsgqU+RDVF23flXXpKepr57wLrViy1McZBQe3upJr/aHwUDzRrQu2FpOxUXPM1axOsiAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HAJ5Lmc8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 40B81207BE;
	Mon, 23 Mar 2026 09:34:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YcNHnYt_YkeB; Mon, 23 Mar 2026 09:34:56 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9C566207AC;
	Mon, 23 Mar 2026 09:34:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9C566207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254896;
	bh=N40GMO+OpI+C4m6aX++wL5AB3kryyXyFA1RbY2LB0ag=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=HAJ5Lmc8G6cyq0uoEEpxpxhJCm9OmGWHx/Ngf6Cy00v5HOzjC0V/6V4/1VWEzbwPD
	 3RdyqRGmIkH37lz+XgX6QODqk/X9vw5Uar3RTztPGNN9lgXPZy2OVUr9md2kjoQZeT
	 evFnEyCAKh7KsV7w4P38bpCVRVzNVcfrdXM1e8OFrToLSp0GNxH/tVuZ+Sd3tGQ9y6
	 UTHrauyLk/tNrj2PkHefQ/hxgaYIC6svUiesUrMVdpA4oMTyNTtTc8CKZ5k/w/Hy+c
	 jaLpCpuJR+62aC7JgvUYQHf/G+srsQQ21cIu0V/kWFGF0vresBzBcFRaZvbxBQyFdC
	 rn9znHNaPsz1g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:56 +0100
Received: (nullmailer pid 2741857 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 20/20] xfrm: iptfs: only publish mode_data after clone setup
Date: Mon, 23 Mar 2026 09:34:01 +0100
Message-ID: <20260323083440.2741292-21-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270407-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,1g4.org:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 181852EE4B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Moses <p@1g4.org>

iptfs_clone_state() stores x->mode_data before allocating the reorder
window. If that allocation fails, the code frees the cloned state and
returns -ENOMEM, leaving x->mode_data pointing at freed memory.

The xfrm clone unwind later runs destroy_state() through x->mode_data,
so the failed clone path tears down IPTFS state that clone_state()
already freed.

Keep the cloned IPTFS state private until all allocations succeed so
failed clones leave x->mode_data unset. The destroy path already
handles a NULL mode_data pointer.

Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 2c87290fe06c..7cd97c1dcd11 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2664,9 +2664,6 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 	if (!xtfs)
 		return -ENOMEM;
 
-	x->mode_data = xtfs;
-	xtfs->x = x;
-
 	xtfs->ra_newskb = NULL;
 	if (xtfs->cfg.reorder_win_size) {
 		xtfs->w_saved = kcalloc(xtfs->cfg.reorder_win_size,
@@ -2677,6 +2674,9 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 		}
 	}
 
+	x->mode_data = xtfs;
+	xtfs->x = x;
+
 	return 0;
 }
 
-- 
2.43.0


