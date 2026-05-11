Return-Path: <netdev+bounces-286632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LWkBzTJAWoRjwEAu9opvQ
	(envelope-from <netdev+bounces-286632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:19:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249650D81D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363953005D2E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82963376483;
	Mon, 11 May 2026 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haM7+ffl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31573374722
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501503; cv=none; b=THYV400Kkdm5WW3oIIJbubyf5iwAZXSFQUs8LMpUjjHxxDO6Zyw/rt1SW4ZBr5lQh6UPTjsHpFDOi442ofLjRLo0DWVlI3N0S1D9zcHKH2ImWPql4PEV7cjq7Do0J4bVxOGsJrMcnrBchBz5vGrTh9LqFlXmH7GUlmeTh5PjjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501503; c=relaxed/simple;
	bh=zDIDQFn+g9lckgjVKIk0P2Ns1wxOnHnQ78kGDl4X6wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sO7J0nRmyGUJYbdgEE5Ud4y6d/h1qyDXA87nzFTVfpw1ELWFV2wXMBx/JgCIsNiU2u3SKVh3bnVrWPl0G64g3VQVKz43dqZBhanJSbLE0N68X9gJifbTyqUzrxCglhUWX/eOFNWL4TQWmcYwksUaGBPTakEbTqr5LBLSU7e+pkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haM7+ffl; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so11340928eec.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778501501; x=1779106301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hs534S+X0dZVP+pvepgGG5haFKXdeP4FpqB4r44PpkE=;
        b=haM7+fflD4Y/IpjRB0Ehsf1mr1MI0cSEFL4cSyeTXJ3dtzd5t2OgKL19R+GA2Mzn7O
         xmWo6dCdpj1Rjfc1/1fl7pgdcLj34OpJMMIHwDDPC60iSbaUC3+Y5VJh0X9NRhjQi/qp
         Q04et4p5BdKDfhvEz5yC3sD4V5OPsexobBdQ+4u6bMZbofMLZXoljWMD1BBMLltSKG1X
         +OTCoDW9hLMHpUt9usUZoK6ignNdvJKm7RVHLMnT48DDwqiqX7BkEEdOm8xgD89BFBwz
         Hw5+X26VSLpX7XrePqm0YSix6KMbeqR8XljEyQZvkmOGNg4thRUVaPWJaBU/rdA5BvYO
         szOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501501; x=1779106301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs534S+X0dZVP+pvepgGG5haFKXdeP4FpqB4r44PpkE=;
        b=iQvX2dDGmJeeGP45BMlE2q8rhrmzFNnxpzrjCfGm2TGbK/NKKshcCE6hIiv0drjkBb
         rFLXGYG+5ydpY1C6TvUmSER6ZF1UNneEyk7p6q++euYmdkNF7Yv0M/9Bf5Mr2ZHnpOUM
         goc8Eoo2LS3CyAgmFW6OeA2qmqMe4qLlZsZDhFmIi1Raiu4EkJzccgifibKx5mc+PgJF
         zC68l3xnfVFq2hbKDEScD9Yo3eH2EqtchoGpBsJAvTPPuUXr8S9DUkdID2GoCuvOvLbF
         qcPw72fe32lwq4I5bsBwXOYTUAkIa1T2J0s+Km00jz3Sig2htIPCn7wnQpj13F9KTSdK
         rWPg==
X-Gm-Message-State: AOJu0YzgjjtgLhcUEZlsd9m4mdAmWsm0Q16i+gkpdJ5yxd5yNus0Hyu0
	cwcZLAplaRamn1MZhnKt38i7NURho4XTXSCjcazjkmx3ooVMgwnXYc+R
X-Gm-Gg: Acq92OElTwR57NPea8N0Uwp4qkAoW4qPUrEBmzmUW39H5DXRVrwmmdAT23diAx/hH9k
	vXafoA6tUzzEEW6Jr+CnK7m8gK3w+Gev6rdy7NHrGYGnVkx5Soka1uHQ9gMtGwawF4AdWbfj2S0
	GYAnHrbkXr2tYe6dPEOQYgi2s+Eg/PFThp519bROuw+SbAZEvcrwg4kiklmFqR0aYqSBE7Uf0qH
	p9ShaXYYXK6f4rHTGVLWJHQ8HDyDiOwNuf5y7l5hetYIvnugQvgASmeQocfdqlAUW33GTbtVlTo
	zxL0Qw0CoYoEPgW0V/647hoWfrnXN8eof2CBScZoIGD9EkkrMl74y72SrcLQw7g9VBziJgSWce9
	BqxK3HnpSL2Gxq11q5iFPpMH/guEALbJthrN5OyEDmoR6BoyNaWXimq0vVL0gA8tFDLMSdIi740
	VpGa3g4Lx/GY988CutqDjmGOx9Fi+Z+Yx8U16b4Z9DinM01q0doSG9VXFCB9Q9bWx5hw5gr2pJh
	w+6/EsI5Em/upofQF3o
X-Received: by 2002:a05:693c:2b08:b0:2ea:5057:a304 with SMTP id 5a478bee46e88-2f54ad72533mr11567414eec.2.1778501501090;
        Mon, 11 May 2026 05:11:41 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm12879102eec.26.2026.05.11.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:11:40 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()
Date: Mon, 11 May 2026 05:00:18 -0700
Message-ID: <20260511120015.2298403-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7249650D81D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286632-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.686];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Action: add header
X-Spam: Yes

From: Security Analysis <xmei5@asu.edu>

rmnet_dellink() removes the endpoint from the hash table with
hlist_del_init_rcu() and then immediately frees it with kfree(). However,
RCU readers on the receive path (rmnet_rx_handler ->
__rmnet_map_ingress_handler) may still hold a reference to the endpoint and
dereference ep->egress_dev after the memory has been freed. The endpoint is
a kmalloc-32 object, and the stale read at offset 8 corresponds to the
egress_dev pointer.

  BUG: unable to handle page fault for address: ffffffffde942eef
  Oops: 0002 [#1] SMP NOPTI
  CPU: 1 UID: 0 PID: 137 Comm: poc_write Not tainted 7.0.0+ #4 PREEMPTLAZY
  RIP: 0010:rmnet_vnd_rx_fixup (rmnet_vnd.c:27)
  Call Trace:
   <TASK>
   __rmnet_map_ingress_handler (rmnet_handlers.c:48 rmnet_handlers.c:101)
   rmnet_rx_handler (rmnet_handlers.c:129 rmnet_handlers.c:235)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6096)
   __netif_receive_skb_one_core (net/core/dev.c:6208)
   netif_receive_skb (net/core/dev.c:6467)
   tun_get_user (drivers/net/tun.c:1955)
   tun_chr_write_iter (drivers/net/tun.c:2003)
   vfs_write (fs/read_write.c:688)
   ksys_write (fs/read_write.c:740)
   </TASK>

Replace kfree() with kfree_rcu_mightsleep() so the endpoint memory remains
valid through the RCU grace period. Also remove the rmnet_vnd_dellink() call
and inline only the nr_rmnet_devs decrement, since rmnet_vnd_dellink() would
set ep->egress_dev to NULL during the grace period, creating a data race with
lockless readers.

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Assisted-by: Claude:claude-opus-4-7
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 269c0449760c..2e17a43aec5a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -213,8 +213,8 @@ static void rmnet_dellink(struct net_device *dev, struct list_head *head)
 	ep = rmnet_get_endpoint(real_port, mux_id);
 	if (ep) {
 		hlist_del_init_rcu(&ep->hlnode);
-		rmnet_vnd_dellink(mux_id, real_port, ep);
-		kfree(ep);
+		real_port->nr_rmnet_devs--;
+		kfree_rcu_mightsleep(ep);
 	}
 
 	netdev_upper_dev_unlink(real_dev, dev);
@@ -238,9 +238,9 @@ static void rmnet_force_unassociate_device(struct net_device *real_dev)
 		hash_for_each_safe(port->muxed_ep, bkt_ep, tmp_ep, ep, hlnode) {
 			unregister_netdevice_queue(ep->egress_dev, &list);
 			netdev_upper_dev_unlink(real_dev, ep->egress_dev);
-			rmnet_vnd_dellink(ep->mux_id, port, ep);
 			hlist_del_init_rcu(&ep->hlnode);
-			kfree(ep);
+			port->nr_rmnet_devs--;
+			kfree_rcu_mightsleep(ep);
 		}
 		rmnet_unregister_real_device(real_dev);
 		unregister_netdevice_many(&list);
-- 
2.43.0


