Return-Path: <netdev+bounces-262995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ/3MolJpmleNgAAu9opvQ
	(envelope-from <netdev+bounces-262995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:38:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC41E81EA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CBC3305AC86
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B83254A3;
	Tue,  3 Mar 2026 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ1jM8pM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB00175A93
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505478; cv=none; b=nN5Wbpzjc0PUITV8Ry4NvCEDQhpfsx4F059CcrE5IE3SdNeoplRe6GoV4xGdsNtlGyOSFbp2jJglkFBLGdaR2LJD+cRvOy8+go4DB1XDxaCxN0cct2Y7QdMP8LsBdiuTwfc8HomS7fVwwf7cor5AfJO9v5EDRX4NfznzVURk/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505478; c=relaxed/simple;
	bh=2zSIQjoD5HzJbTl8YywahZl6NmBNEeimp7YTp6apzkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fURToA5ClOUWxeYwZCIE5eKFQwgvcFn/BNI+tOyij9KyuHnWAE1vSi/wlSWIz0jhNDVYuDWdb/axTXEGo67jOHqU2KdsTWxLDXHDCuHifHi+/YDxC3Az4MBULAbRVdyff+NN5/P7m7wjMhWAyaHmZ3NE7FAy4b1sxL1BODIasM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ1jM8pM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a871daa98fso39783375ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 18:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772505477; x=1773110277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqdd7vCaCMSA3FVo2YxHVRb4LFpGd903ZjBDEK+PvAg=;
        b=MZ1jM8pMMHdQ/svnreUYHDS8J58iPy57p88hRjyvPrYxHX1k4/5UH6oid0sklfuVaX
         tSEKwwfGHAXPnOe9n/TeI/IKPHoxh1QaUtsp3joPscw0PqOiuyf9WwGGOKkQZK1rZTFh
         RlnQBt6CFlkIQeIr6k3OO5wkXDLG4ODJ4rj/4Qjmsp3Io3uv2Cly1/JHBmZGy+oFcRcp
         GFMBl9rWg1TxbL5yCV6x59RmUeUKk/OX/3NGygRzocLnyjDc/DzSIB8BTuW/hI9f3gP6
         L22NmC7eDjIlLU8gAFPl7RvPKeXOjQfY1aDrrdUhtYHzAOaiVNiVb2MIkcpJVWC1D6ua
         AL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505477; x=1773110277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqdd7vCaCMSA3FVo2YxHVRb4LFpGd903ZjBDEK+PvAg=;
        b=tB1NeSsq1l2LymsHYZd00UkwWTSRAXR5IEdb/HNhIL9EHICpLecdgrU4pNQyyUum+s
         eGnwsrTPBB7abyR0bwC5iaONZ4AWeSHWu7FzqQg9ypegNZlt8a4jhkPgQeGUMZWg8TZg
         Xp42TRmqjzxDbBkivHh8Wy0+zwDZMukO06u+UoqP2rPqncVIbHHzbOXoJiUjNARA2Ytu
         HoNAzzU85aamOnrc8yWiScOG/yTzVNSiP4umUkvTCx2hjrW35B5ZfQL2o72xPkt3tNy8
         VCv4vwMjrRpKs4sH8URj9gzrOsP9QwGLTZqwKHKqnW1kV7/qsqvCtadNgsxYDUCvQ4y6
         Oguw==
X-Forwarded-Encrypted: i=1; AJvYcCWYzn5Zx5ff1IN3gXJ7IsFtBLrG5eEjZ4plTg+1cc5p/SW/tdLltbPQWeyDZnaiDS1G0/OWZlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyckR52FrRvQzxvx3gJu17AP84Dy3fJcCiqQhsxViZIZiGKUADL
	TDN3u++rW1RGYu8BqHYkRGlvGiyahsjFemb89O51Ewlet82DyS5Jozn0
X-Gm-Gg: ATEYQzz4GS60Vx/5dn/e+u2urRPAyL+1yovhROTXxTDRZ4KOsklzv1fcx5JA5ShVusJ
	qUx5NRdjtCn0D/y3RTgxws49HsJB5xYqQs0hnTNSZh+bIrirW6/UwFHfnlc8DV/UNIv16p6NI2B
	+0SPUBIBSCQRS38art8fKzAice171FEZQ/LDb0q6vyHz97D3OBstCI50ysqbCvGXzbaarrYr3o5
	7HazgZLUQuCF/v6SECQAwQbGWC8WvvodRUJBSGe5Xfb+IN/NKrkHjkxA1jPiH3fb+DjSo/VD/d2
	RcgP6pyhwpFtoNEuZVWDcWu8d9LRW8X0/v3U8A+FWR8lNvcLCzkAKR5gnMBBk68nlXAdJWH3Pt/
	ioJYvoKDvM+LV5133pahWg1geS7k4B2idxFvH0Ng3dSD6UuZ7ac2+ze2AzTYTFLUD3qT9LNiu3M
	yvn6Igqh+JyKuxSmrToclEeJnJU483FlIcyRtxAhGtV9IeKsVgG5QSnC7VVAL75Mv7jsKajZ10f
	okMZGWiVeI=
X-Received: by 2002:a17:902:e78b:b0:2a0:e5cd:80a1 with SMTP id d9443c01a7336-2ae2e4b950cmr155022575ad.41.1772505476957;
        Mon, 02 Mar 2026 18:37:56 -0800 (PST)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c51sm83961005ad.19.2026.03.02.18.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:37:56 -0800 (PST)
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
Subject: [PATCH net] net/core: add xmit recursion limit to qdisc transmit path
Date: Tue,  3 Mar 2026 10:29:48 +0800
Message-ID: <20260303022947.3061602-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31FC41E81EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262995-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Action: no action

From: Weiming Shi <bestswngs@gmail.com>

__dev_queue_xmit() has two transmit code paths depending on whether the
device has a qdisc attached:

  1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
  2. No-qdisc path: calls dev_hard_start_xmit() directly

Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
recursion protection to the no-qdisc path via dev_xmit_recursion()
check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
path performs no recursion depth checking at all.

This allows unbounded recursion through qdisc-attached devices. For
example, a bond interface in broadcast mode with gretap slaves whose
remote endpoints route back through the bond creates an infinite
transmit loop that exhausts the kernel stack:

  BUG: KASAN: stack-out-of-bounds in blake2s.constprop.0+0xe7/0x160
  Write of size 32 at addr ffff88810033fed0 by task kworker/0:1/11
  Workqueue: mld mld_ifc_work
  Call Trace:
   <TASK>
   __build_flow_key.constprop.0 (net/ipv4/route.c:515)
   ip_rt_update_pmtu (net/ipv4/route.c:1073)
   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:84)
   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
   gre_tap_xmit (net/ipv4/ip_gre.c:779)
   dev_hard_start_xmit (net/core/dev.c:3887)
   sch_direct_xmit (net/sched/sch_generic.c:347)
   __dev_queue_xmit (net/core/dev.c:4802)
   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
   dev_hard_start_xmit (net/core/dev.c:3887)
   __dev_queue_xmit (net/core/dev.c:4841)
   ip_finish_output2 (net/ipv4/ip_output.c:237)
   ip_output (net/ipv4/ip_output.c:438)
   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
   gre_tap_xmit (net/ipv4/ip_gre.c:779)
   dev_hard_start_xmit (net/core/dev.c:3887)
   sch_direct_xmit (net/sched/sch_generic.c:347)
   __dev_queue_xmit (net/core/dev.c:4802)
   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
   dev_hard_start_xmit (net/core/dev.c:3887)
   __dev_queue_xmit (net/core/dev.c:4841)
   ip_finish_output2 (net/ipv4/ip_output.c:237)
   ip_output (net/ipv4/ip_output.c:438)
   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:86)
   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
   gre_tap_xmit (net/ipv4/ip_gre.c:779)
   dev_hard_start_xmit (net/core/dev.c:3887)
   sch_direct_xmit (net/sched/sch_generic.c:347)
   __dev_queue_xmit (net/core/dev.c:4802)
   bond_dev_queue_xmit (drivers/net/bonding/bond_main.c:312)
   bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5279)
   bond_start_xmit (drivers/net/bonding/bond_main.c:5530)
   dev_hard_start_xmit (net/core/dev.c:3887)
   __dev_queue_xmit (net/core/dev.c:4841)
   mld_sendpack
   mld_ifc_work
   process_one_work
   worker_thread
   </TASK>

  poc (76) used greatest stack depth: 8 bytes left

The per-queue qdisc_run_begin() serialization does not prevent this
because each gretap slave can have multiple TX queues, so each
recursion level may select a different queue. The q->owner check also
fails because each level operates on a different qdisc instance.

Fix by adding the same recursion protection to the qdisc path that
the no-qdisc path already has: check dev_xmit_recursion() before
entering __dev_xmit_skb(), and bracket the call with
dev_xmit_recursion_inc()/dec() to properly track nesting depth
across both transmit paths.

Fixes: bbd8a0d3a3b6 ("net: Avoid enqueuing skb for default qdiscs")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index c1a9f7fdcffa..d5d929df67be 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4799,7 +4799,17 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	trace_net_dev_queue(skb);
 	if (q->enqueue) {
+		if (unlikely(dev_xmit_recursion())) {
+			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+					     dev->name);
+			rc = -ENETDOWN;
+			dev_core_stats_tx_dropped_inc(dev);
+			kfree_skb_list(skb);
+			goto out;
+		}
+		dev_xmit_recursion_inc();
 		rc = __dev_xmit_skb(skb, q, dev, txq);
+		dev_xmit_recursion_dec();
 		goto out;
 	}
 
-- 
2.43.0


