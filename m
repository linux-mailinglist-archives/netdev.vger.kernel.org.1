Return-Path: <netdev+bounces-291072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L8DK1ttEWpLlwYAu9opvQ
	(envelope-from <netdev+bounces-291072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:03:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8C5BE174
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67B8300B137
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07237CD3A;
	Sat, 23 May 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbhsukAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749A346798
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779526992; cv=none; b=BUEDtHcJVsqe+5WuJ5maMUd1HiRYIPaQAUX8pUpOELC1pV7PS9jq3W7qCLKlLFe8b/O4hvXgTcQ6IS8b4hc9L861CSGTKxi6WlpJ5Bvx2tZJ0yfJICsBX+vEHFLmTGaAFNWzQoLzYOAbzTbEG0LVqDZokFpTUU0g5lvNWc4I+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779526992; c=relaxed/simple;
	bh=NyOrWaSzjDO04+EJ0r5MjIKBFB0Wus/T/TpI1QhQ40w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5GKqcbgbXYAMquc2Xttgpr2wz8NzIOI0IA3TWMP5MAonrFH2tDurIsZKGk2sIfSjJ/oZ8QdmgLxCiHwQ3AjbbDdH7YHemJVU1tNb52TZrVIh24PmWR0jQ3bG9ypT68ybGxp7hDh6kgf1yvBIL5JtRLRWrX+w9tTAdvtiwfAWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbhsukAp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-365deee00c3so741642a91.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779526990; x=1780131790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlf3lX6f/Toq78lh77so2DPy7wd2/N6OZVLGcG+13uI=;
        b=nbhsukApuv7jU/TZH/PpxrPYSUo0KZJ22kqkbqyrj3KWxSK0JH/Z/uioU78vOe9df4
         NLh7TD8vMf4CBdTzRF/89czukZ0j6oVgZwAgOg7Ebpk74AORYV5RpD7JzeM7Nqn/yme3
         al4KFfhXfu87EyG+yZlBS1quBZSKjZm0Rg7jFy8dYSo9+YL4uGKuIhWmelPP62IjsU68
         SmLMr/yZCDKxdhdxdjlea/2UD06oyWWD2U7wNLdk/tzjj/jOQuyyPBWO7GNGk8Oru/HZ
         11yBYb8WgPxQEUW37iYd74mUJblOfJ4GrNwi2QopG7zSzog1Jg/rePJJ7oGUbf8lVBxd
         8dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779526990; x=1780131790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlf3lX6f/Toq78lh77so2DPy7wd2/N6OZVLGcG+13uI=;
        b=dSckk8XBL/dhI0DeUaQgz6dSzGV3A9HEXbXsxtO7bOXB67rvTrn95wBbGJxyBbbU2C
         f4j2b1qsqocVWwzzrIZsFP5PWVAEbVNDp9q2+CQH4nrde9iWF1ZI7pbXlJ2y1xKe074V
         8ycoAvgwyPlyzd25wA2k5jQI0r1ZCA2SAGdQyMCqOwxnlVy9jL+XeRchGt5HpsJnS/RR
         PhJSX4abgt/0HMmutqCC38NK3R/ZLb9kieCqTU43WQz6fbgaZO05yRUUptBChPrpbr79
         KW+Mvu9caMcm7fe9zZbyTCy+YKoMBiw/Djg6msEOyPB0pVK1lpBaZkmondkTkKiVUvNE
         R01A==
X-Forwarded-Encrypted: i=1; AFNElJ+Kh6WoFN0QLYoWO/FrQq/PHMMIGHLbmoY1E3/UiWxZLzrHKzHUl1lj2k9fMtQWLPChtA5/HAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoORsco39k4OFjYR7HnrR76qWTJ53Br05Ln2ed2Lp5FgoJsf5
	mt4J6HG/C44ltfr92sE2CoatDa9e9W8INKpy5IYS6Ju8e5SOjeODdALV
X-Gm-Gg: Acq92OEvkZOyV+uGWn2hi/vImmcAt9q+x9h5lRlyp7fGizQDk6FV76/5qj4x0lvYauX
	TbJdNeEFsFNhVWIM3oQ8YZRoXjkzF6+wdOE1iotJM/NMXPmPoVdjpA0yXtaR7NRQmT6nDwKmiUR
	SWZIXY0hK7WTXx57/khZAedbx9ENDdaQcPWi+vNzjsj4oNvZ1TT5VgYAStbnKToNNY5ClbXOXFj
	XmZiTaSM0KMJRpjDw2cHF2tq2mZbmrOWRWbTpQYraPJ88IFUcxLNyyNbBwss4nJrS67Ske/OQHZ
	bBYp8A6v44wbZiIIbW9y6GPFUJFEIJkXj4w1ZSExhItjy7iI72N91nPxy3b/4TG33kVq0bhf6lF
	VohaB/CWs91xy9zYYL9Yjj9Kgoc/APDYSyVO0Z+ip5umfQ85D3X5foBx7Cd0lh7IxEZwnJTmc0S
	VhGQCZJzzFjiPS55/7Lg==
X-Received: by 2002:a17:90b:3807:b0:368:58d4:de03 with SMTP id 98e67ed59e1d1-36a676216b9mr4370598a91.6.1779526990059;
        Sat, 23 May 2026 02:03:10 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6f0baca7sm2525148a91.2.2026.05.23.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:03:09 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: antonio@openvpn.net
Cc: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v3] ovpn: fix peer refcount leak in TCP error paths
Date: Sat, 23 May 2026 05:02:43 -0400
Message-ID: <20260523090244.504790-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291072-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 11E8C5BE174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When either the TCP RX or TX error path calls ovpn_peer_hold() followed
by schedule_work(&peer->tcp.defer_del_work), and the work item is already
pending from the other path, schedule_work() returns false and the work
runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
exactly once, the extra reference taken by the losing path is never
dropped, leaking the peer object.

The race window:

  CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
  ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
  schedule_work()    <- queued      schedule_work()    <- NO-OP
                                    (work already pending)
  ovpn_tcp_peer_del_work runs:
    ovpn_peer_del()
    ovpn_peer_put()  <- refcnt+1
                                   <- peer never freed

Fix by checking the return value of schedule_work() in both paths and
calling ovpn_peer_put() to drop the extra reference if the work was
already pending. ovpn_peer_hold() is kept unconditional in the TX path
as it cannot fail at that point.

Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
Changes since v2:
  - Include RX path fix in the diff (was missing from v2)
  - Link: https://lore.kernel.org/netdev/20260522091718.270956-1-jhapavitra98@gmail.com/

Changes since v1:
  - TX path: keep ovpn_peer_hold() unconditional per Antonio Quartulli's
    review; only check schedule_work() return value
  - Link: https://lore.kernel.org/netdev/20260521083739.65061-1-jhapavitra98@gmail.com/
---
 drivers/net/ovpn/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 5499c1572..2c7d830e7 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -151,7 +151,8 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* take reference for deferred peer deletion. should never fail */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
-	schedule_work(&peer->tcp.defer_del_work);
+	if (!schedule_work(&peer->tcp.defer_del_work))
+		ovpn_peer_put(peer);
 	dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -283,7 +284,8 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			 * stream therefore we abort the connection
 			 */
 			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			if (!schedule_work(&peer->tcp.defer_del_work))
+				ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-- 
2.53.0


