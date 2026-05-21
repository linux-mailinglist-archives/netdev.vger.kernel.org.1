Return-Path: <netdev+bounces-290294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFjOEknHDmrsCAYAu9opvQ
	(envelope-from <netdev+bounces-290294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B765A1750
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39F5831AE5BA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955EF3CC304;
	Thu, 21 May 2026 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDso3xmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F373C3C14
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352684; cv=none; b=Op6AuSd/Td6aUCRAPbUShRALsTdPRHhoWuiH+MXiGkn/ZJQNeSLdTfSt/KIBhgQSyUC4rYvn0BOazPv4FK2UtFSDThbs1aBLWXBdEXtQ0wLxRy/03h8VlnO9V+dE7SYs/AqVoTi2ZzbDn9NTP79cydJswj1hwId9LJ5t5vEie+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352684; c=relaxed/simple;
	bh=uClwDwQ9aMBOn1j7vC5jSbaTUBkTAZEZk5MPWjNbpow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtTntQWbn9vZwhmOk8U3iA2mdOTtt3lddjV/xqxLCFC5WON5bkqrdh+b2T6WaURaKJORoa4qj7VZMiNjS8E7H4xExhxvP1YmA9EKt/AaLMy+/Vv9bzkWaOJVc+Ze3RFxntUmNXpad4UmGiaK42qaJsvEJZDHHfygMwgOlX4b6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDso3xmV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-368ea877adbso796942a91.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352675; x=1779957475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sC1dlVSEJRn8MI2VFuxLlRNe963Fh6GRPhQWJKMRLww=;
        b=JDso3xmVZrl0P9qvnwAaH02BRgcD6UwMXoMED+ER7opASli1xVwWalfIBxsp7I3yg6
         oeaLxe7mhIOn+Pq4KO3S83nVDTgMWWMAAao3DwTtuX7Vj0vCFYk/6eOpkGZo9pKS2Ybc
         bAV56+l5wxX9b7gyAOFjEIaYSy/8hg4MbYZMjxmPWKbQEcabHdYojJKGEe/UJrVoiOby
         wQjhCTo9XaY8NiSuchnEAVbrwYcbInsH54xVOGhksvV5t8ZHFIZwmieIBS375TXLQ6Zd
         87xMQnJ1VrpqotuhIdNPEY4yp0a0jIWTcaoyj73EFLTjbUPUvMRxDKJxHdyC+4nvL2/e
         HyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352675; x=1779957475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC1dlVSEJRn8MI2VFuxLlRNe963Fh6GRPhQWJKMRLww=;
        b=Ma+WKY7qb/YBsORWxqZN74Uhl70E4jWoCID++fmG3MeiB8f2arvqOVrJ/njsQMvVpY
         oHqBQY5he2Urajj+IMorakgxBf7Ubinp3Jh6MfpNjprg45uyIQuaEIewBdfnaxXzg5ON
         6A2rPJ0fFakyv5kuhNzU/I99aL2yc18UNBfUPqr/57TTpZPoLw/mpG7JVF8EOwSEbWOk
         OxnmZ0ZZngQiZWwWFXXgbIsY627BmD4qI9aFMvBKgX21XKuyGRXaztS2G6uR8hni1Um/
         mjUJj2uhAV5ZKqsBkuiDcOnbHQezESO62BBL8NGV+WQ3nOY1hPHVcLw4DudBdMY+1ok/
         UhZw==
X-Forwarded-Encrypted: i=1; AFNElJ/yhhkkrbqubdvuKDd/fVwVy8+kgzPprcscpuCKszAFEblb4JPDCg69oXjl8/bRhj6/86/X9xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABnw8keCDEL4sNHsVWjSne1vZZ+4nMjXJ1ESuCJP83WLYOOWj
	qdeti8fmwRNKmEFxz6anHEjoGFQYyvIX8JMBmLtmpuiu1Eap/1IfGtEn
X-Gm-Gg: Acq92OEssiL/IvkuvMjWgDLvM+EQMqWqWOWWHthVtQV9x+Dx1o7Unj8K7jWRPBGm5jX
	aJV3oalRuhY0qhn22RDH5GyqNpWTj1Tbjzg4D+2+IurpG9xGJIa37b3MOK+KZHjikNvx2cVTDf+
	cjE8Eo0SgTJ7yl2BIUudAzNdcx007uPkz/rsIS190rU1CO1CYm4u90xEsebCpk2HaNgYTftNvMZ
	FwAgLjt3fRnUIZxJB/vKC508GRw9uXsPVb8B0WT7datuXA1nWiAGKtJx/2+XFskBSz6XUfdXLY5
	2+zhAL8daSyB8Hhc976/JW3mk41JsI0U+FlmzdSyUT7eT8iFFcr+EZUhVEQnn/pft10y+snF2bx
	rkDuydcv89ZxWJ3ejP2J1SnYDIBkg3iOzrnyqPIQRLk/FtHQStgHFn9OLPDB8zRY+LEzElvrmw5
	pkX31rsA4US3RPHCJsu/6R3C8WE0qy
X-Received: by 2002:a17:90b:2551:b0:369:224d:8beb with SMTP id 98e67ed59e1d1-36a45c526d0mr1156488a91.7.1779352674862;
        Thu, 21 May 2026 01:37:54 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0626b2sm28046326a12.6.2026.05.21.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:54 -0700 (PDT)
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
Subject: [PATCH] ovpn: fix peer refcount leak in TCP error paths
Date: Thu, 21 May 2026 04:37:39 -0400
Message-ID: <20260521083739.65061-1-jhapavitra98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290294-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3B765A1750
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
already pending.

Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/net/ovpn/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 5499c1572..d651ce85c 100644
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
@@ -282,8 +283,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			/* in case of TCP error we can't recover the VPN
 			 * stream therefore we abort the connection
 			 */
-			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			if (ovpn_peer_hold(peer))
+				if (!schedule_work(&peer->tcp.defer_del_work))
+					ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-- 
2.53.0


