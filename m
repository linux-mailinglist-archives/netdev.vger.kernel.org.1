Return-Path: <netdev+bounces-263585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOTfAIm4p2mmjQAAu9opvQ
	(envelope-from <netdev+bounces-263585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:43:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0139B1FABDF
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 05:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1CE13022477
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 04:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2B37F757;
	Wed,  4 Mar 2026 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d966aDpB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB137F8A1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599427; cv=none; b=qTbpPQ1NQetWso1/K+pfyDA659rYA1TBigZEPNq4Cc2qWB5pKalXghK/ofBt308VMnYzU30b6dfJV7WR7x3G3Ioknl1IFDL7O2djyWKzy5SbctIUFT4k1Kdo98vN2x+aDtPO1Sb9Ysc14MNMd2DzfeF8SgYzR9tBxEqXTdFZemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599427; c=relaxed/simple;
	bh=aEAc2gwgulFkK5kSJjAT8k/xHVRlNPPgR9/2AgWpHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqt78F0bgPG9ewRtGyGahMG4DXsZ2nQ+Jk8KxaW+eSzICJxNzLnZiobePZjmEj2GjjqzAltd0J7TO9hzwJG6e+uOs6F7unaLWs6RyVMCac88eLVYwj1M8bxDt6qjPJAWfGpukFxCfhEcYHugx7S3pnI9OjQCUNP5A+Txb1LkTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d966aDpB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so74864965ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 20:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772599425; x=1773204225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pon6FFgpNcZUc3rL4tIv8eC0n5vN6LcD5w8iJv9NUIo=;
        b=d966aDpBhm+pOvf+xP45JbvcDLaHsZHGgk4czSFFisJz7xRnCFYmwgweV6EL8j7D0q
         IFbv2BPwbyi4TRdHAytLpEqIP3Kapw7qyc/svbnY3aLugjvkBdDqyGmZdwrFFdGSiXKS
         XrVsOOD6zXtovLZZSYIXoNqn1gk/Hj2U4d57WA11PjPORTKhEnucdxMvJH8Kqz6sMaWc
         DSEGIt9U+n6nxLBpNrnogegWVhzsKZnQW0A6XXn9mRjBcMDyhF150ZrQ+emj60eERBiv
         vLD8l9MltiQ8OsziJSUCpCwQZKkRAAd2+v8Q56OFFCXxO9/4UYusWAMl7VFow7TOIzzD
         uohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772599425; x=1773204225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pon6FFgpNcZUc3rL4tIv8eC0n5vN6LcD5w8iJv9NUIo=;
        b=UeRZrjSg8SidCuOOAkck8oTSqsMliPUcTUIGEUafYcmPgmStX9syc3R++7dVa5SHmE
         AcX96gWGMH6ZLxmRTyghm1x+BlAwxeMllnxUOWMzU+ak7/1Y0vMoVYm81nQcdGo+SUL2
         57GzDiha2/0nMehWQd7oX48IcIFbSrac0Y21Jo+BVOjTGVe2K73Oc/2i+SPs2lJ9V++N
         BpDlNEPeqsYNpKVfvnfmPzOcrsZjrRPutYO0sQtQRmIAVwmqeSok3xoNIqpk2p+lyoR3
         M9/VQeqwIHTfCaWwjkHMON8vhqCjBfbjV5iXsL3AbgI9UEBaYQRrNailvdQsOTJuUHXI
         edig==
X-Forwarded-Encrypted: i=1; AJvYcCU2pfpvoamSRoA7H16TI90RYJ/ipo2nrUVzPk9jWsomJR/yhWZdL9xG361lbN6jsdpzcLyd678=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSpVOpZeDaNq7vNdFbUWLF4UJMbRM9H4d4rE4AdHRTg8k2jZ+
	d/OuuvBF7g1ZeQFFzAliac6+NKAm8fBkczKxzMJ3noFNNSd4DTwuSefR
X-Gm-Gg: ATEYQzxkaxCFsqIjKPcAcNRuMD8n1769L/Y7pHC2y4VoR6ak5GhG32fRXhL4E/rKcwI
	6m2TFMzWvW6ivUdFa9raKxF3nbMHs7eY88HlQHDt/80cjdcvXMtPnU/DmX9Eg+Rp5MOQofsnm1e
	IJHYGSgdUw96lQe68wIJpsRMyRY3f9imuOs62E8HFzJfNmdBMaUKg+YDkoXEh5hqGXBhGINmaJA
	x4ieBc3dCChfr8M5qOpKTZKFAUn6H7wJI0Vu7zsUmJzmXsjfmOPxwH8ePWTxUIBSfJ8Ylk6csLp
	Bxd8z+1fQY8Kx0K4VpYKpQIDx7ec2+oIVhcnlzMxwZ86AaxsTkV16GJUKHoJE1ItOXRo9IKu74u
	kQlDujzF3zYK6pGtW29UB6xsEAtH3ZYKDhBDpyjKCVBza1QAsV8lzDPP9S2BzHQuETgiAr5Vkio
	szP8Glv36jr4HGZxjalWB1cwBmNshRr3w1xtHoGpVkYSXbd/xSS2wKZgFCskUx0/PFdMsU4X1T3
	J79RWh5Q4g=
X-Received: by 2002:a17:902:cecf:b0:2ae:5a0b:9ce8 with SMTP id d9443c01a7336-2ae6ab64a40mr8542135ad.45.1772599425314;
        Tue, 03 Mar 2026 20:43:45 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm188868145ad.24.2026.03.03.20.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:43:44 -0800 (PST)
From: bestswngs@gmail.com
To: security@kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] net/sched: teql: fix NULL pointer dereference in iptunnel_xmit on TEQL slave xmit
Date: Wed,  4 Mar 2026 12:42:18 +0800
Message-ID: <20260304044216.3517851-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0139B1FABDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263585-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Action: no action

From: Weiming Shi <bestswngs@gmail.com>

teql_master_xmit() calls netdev_start_xmit(skb, slave) to transmit
through slave devices, but does not update skb->dev to the slave device
beforehand.

When a gretap tunnel is a TEQL slave, the transmit path reaches
iptunnel_xmit() which saves dev = skb->dev (still pointing to teql0
master) and later calls iptunnel_xmit_stats(dev, pkt_len). This
function does:

    get_cpu_ptr(dev->tstats)

Since teql_master_setup() does not set dev->pcpu_stat_type to
NETDEV_PCPU_STAT_TSTATS, the core network stack never allocates tstats
for teql0, so dev->tstats is NULL. get_cpu_ptr(NULL) computes
NULL + __per_cpu_offset[cpu], resulting in a page fault.

 BUG: unable to handle page fault for address: ffff8880e6659018
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 68bc067 P4D 68bc067 PUD 0
 Oops: Oops: 0002 [#1] SMP KASAN PTI
 RIP: 0010:iptunnel_xmit (./include/net/ip_tunnels.h:664 net/ipv4/ip_tunnel_core.c:89)
 Call Trace:
  <TASK>
  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
  __gre_xmit (net/ipv4/ip_gre.c:478)
  gre_tap_xmit (net/ipv4/ip_gre.c:779)
  teql_master_xmit (net/sched/sch_teql.c:319)
  dev_hard_start_xmit (net/core/dev.c:3887)
  sch_direct_xmit (net/sched/sch_generic.c:347)
  __dev_queue_xmit (net/core/dev.c:4802)
  neigh_direct_output (net/core/neighbour.c:1660)
  ip_finish_output2 (net/ipv4/ip_output.c:237)
  __ip_finish_output.part.0 (net/ipv4/ip_output.c:315)
  ip_mc_output (net/ipv4/ip_output.c:369)
  ip_send_skb (net/ipv4/ip_output.c:1508)
  udp_send_skb (net/ipv4/udp.c:1195)
  udp_sendmsg (net/ipv4/udp.c:1485)
  inet_sendmsg (net/ipv4/af_inet.c:859)
  __sys_sendto (net/socket.c:2206)

Fix this by setting skb->dev = slave before calling
netdev_start_xmit(), so that tunnel xmit functions see the correct
slave device with properly allocated tstats.

Fixes: 039f50629b7f ("ip_tunnel: Move stats update to iptunnel_xmit()")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sched/sch_teql.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 6e4bdaa876ed..783300d8b019 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -315,6 +315,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 
+				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
-- 
2.43.0


