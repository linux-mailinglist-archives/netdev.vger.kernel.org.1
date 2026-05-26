Return-Path: <netdev+bounces-291550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAtkAllCFWrJTwcAu9opvQ
	(envelope-from <netdev+bounces-291550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:48:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F715D14FB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5FA6301FA9E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6B3B2D38;
	Tue, 26 May 2026 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="W+YOWzO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801A371068
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778131; cv=none; b=Xi9kZT6YKuvJO+KBmKrDNc0z7CWmZpWIp1/PWMPt0yA7iKP83Oe6QXrhQS1vaAJ/HaPJ2PaJISpN7luRU5WbyrnnBJmqSVZKaNTMrO7ATzHtbHRKCr6K891drEZA/shw6joxXHu0f7qH3TVNkTAc7TYdjTlBLA0LPY0oN6iwTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778131; c=relaxed/simple;
	bh=gyAh/5BliGuIaW7B5syE80ICfyLg9YjsdEs8y0Fj4vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHGnlFmS0eb0prV7H7ghubLE+QB2JC7IoCGBzLgY59UNEzmGXd6PsGDsI5KuzltD0fBhbBKZz7dzdevqxciNt1uIXcAuSQ3L//JyLycHKePeZYTk77hR/Ye2PfuGGMjGrsothWytFD4T/HVhNFUO5hc8wBgrq5fDyBGbcduUp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=W+YOWzO3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-837b39eb078so7071651b3a.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1779778125; x=1780382925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/iQlSdODyUFcZUiDfoqt+9/8YQPirYzjTroKpMrHK0=;
        b=W+YOWzO3MkyTaBjieBobsQ8JHUHJ/k99DqJFBxsaaDNabDqun21FrY7DbcLz1sNiQP
         4fNDW1c44xyohYuq6UndBjh6livOgMEy0Q4WRg2suE2nCiTPmDYumgcaeQH/T9TwDUdB
         MtxnXzLETxat9WrzAUojnmFwkyjNsJosEN1wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778125; x=1780382925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/iQlSdODyUFcZUiDfoqt+9/8YQPirYzjTroKpMrHK0=;
        b=Vq6ai1updIsUgAZjQIztNISA+BFaJPIoSal8ue4wlRGHXDAV4Jw//882yDgig7g/Hr
         HLlmilkPnRlM4UhiAFZDznAkQhYdM6Vp0HOYpMX4poIdwLmFnKf7jvF/4y4SXKL98lxy
         kxVAp6AqXzTI0unPbFL6D5VpkMZTGQkASl5rbt5BOB8iTCSgpGFOI29GwzEZaun/wng8
         rUd5kQ95WfVvwb0FVz8XI+QEdYvmt6MiqTXG64fB0daJguNGqn+ZKGOfG8syU2agTKBn
         9FzwV2Rj2PZs14dxOfwoq0t68oR6cfhpTi987a5S5RylF2+Ud9mwIcbff5Git3+rYa/u
         kkAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PHOC2YrR+scco588oWD2KSvD/Yjv+0gFGQYSQkDsLIQT+4do9dLQM6mim2gBqN+l92boSleQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqQa+UgJmuLiJAur/nKJqaoQADh45SYqcD/YI1p24Bi+RPsIz
	DMlH+qDA2ozI1MQr3l/kTzO0ZhCdizGjFkhdd/C78UcTSysAruHRdQJF+ftboWdXUOE=
X-Gm-Gg: Acq92OHCg3zD7Jo5nvt+xBxNViJQ3fkpqgTzUrbWgDT5GuN7bsPTchlDuLBC0sJjIhO
	3Jv4NvgvaJvQSp7nE5mAafsi9+YEdva5JUGfJvLr83SyeD4unDHweYZBYd2oyR1pdO8606nfTkG
	cfPiL13SehUNuTxKKOaikJrB9KeY9NiYPO0GzM2JekdInnev+U/b2Q9aSu7F1ZsEFCGdUe08Aor
	f06fWXGf/x4tNzgYovg09nSLcxgarhb0yfKZbzJUxxnZ/I5aUC/1MCJcBrfWGRLwB5EnUaITIT8
	3TThDoqsrweUVKzGOaRhBvse+UxsgiPYCYoVMWd9bqCY94xUUQrisRp/1I0PAjOKF4AEsSDxPMh
	mOnitfb2he5HDDVtgsTLsepI0PYW9NP4c12FDa8gMbgU4w3M18m0/zu8Jh03vW9TguKt9AeO60W
	mkNv5GS0CzSUWSISGeL8CpTrRaOpFP/WqyrgG2aCOZ7YfOMqLf0A==
X-Received: by 2002:a05:6a00:2da4:b0:82a:6ef8:cb43 with SMTP id d2e1a72fcca58-8415f53dbe4mr15892684b3a.19.1779778125518;
        Mon, 25 May 2026 23:48:45 -0700 (PDT)
Received: from ubuntu.. ([147.46.174.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164e9e7cdsm11909392b3a.34.2026.05.25.23.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 23:48:44 -0700 (PDT)
From: Soowan Park <swan2718@snu.ac.kr>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Soowan Park <swan2718@snu.ac.kr>
Subject: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
Date: Tue, 26 May 2026 15:48:35 +0900
Message-ID: <20260526064835.2233822-1-swan2718@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291550-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[swan2718@snu.ac.kr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,snu.ac.kr:email,snu.ac.kr:mid,snu.ac.kr:dkim]
X-Rspamd-Queue-Id: B7F715D14FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

batadv_dat_purge() is a periodic delayed work that re-queues itself via
batadv_dat_start_timer() at the end of each run. When the mesh interface
is torn down, batadv_dat_free() calls cancel_delayed_work_sync() to stop
the purge work before freeing the DAT hash table.

However, cancel_delayed_work_sync() leaves the work in an enabled state.
If the purge work is currently executing and re-queues itself before
cancel_delayed_work_sync() internally marks it for cancellation, the
newly queued work escapes cancellation. This re-queued work then fires
after batadv_dat_hash_free() has already freed the hash table but before
the pointer is set to NULL, causing __batadv_dat_purge() to operate on a
dangling pointer that passes the NULL check, and spin indefinitely on a
spinlock in freed memory.

Replace cancel_delayed_work_sync() with disable_delayed_work_sync(),
which additionally disables the work so that any concurrent
queue_delayed_work() call from the running batadv_dat_purge() is
silently rejected. This guarantees no re-queued work can fire after
disable_delayed_work_sync() returns.

Found by syzkaller.

Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Soowan Park <swan2718@snu.ac.kr>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0a8bd95e2f99..9dce7da4282c 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -837,7 +837,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->dat.work);
+	disable_delayed_work_sync(&bat_priv->dat.work);
 
 	batadv_dat_hash_free(bat_priv);
 }
-- 
2.43.0


