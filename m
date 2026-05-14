Return-Path: <netdev+bounces-287949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGyuBf/BBWpMbAIAu9opvQ
	(envelope-from <netdev+bounces-287949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1B541BBF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D11FD302FA81
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739693DCDAB;
	Thu, 14 May 2026 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joHd7VqW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592C3DD847
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761544; cv=none; b=m/X3s8iADz+ehUYhw/I6zZ5/S0W1ZTB4J+pSMwg2ZoVPjdJo2AYwJVPPiElFcQU+Fyb8i19jf9h0zucpdpKjcvqKriOVR/gsICf+NhhRJRuxtpeRP8A0GdFyMUH/iKLTAPX52VdOATBjIRKQ5kcZBs3CAY3jqBI+mi+fVuMO1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761544; c=relaxed/simple;
	bh=GWRH6hphvhsisFn1cxPBy+jAUW8KI/+DwEy5yky2kxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7KYMzBMGTophXkVlMqFwhd1bbq4m2OxUxW/UopedkqulYIBOsaB8+1sPaCCmSyak0HClbLL+EYiFDVrMUN87jpwmOT6VjxUbeoCqZveVeaPfgZiA8sP+VqSc2kjeUnRMq3vjinDZ4jWTx0/EoqijzS70vHG/XUI0xQNtmb/zsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joHd7VqW; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30246cfd41aso698062eec.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778761542; x=1779366342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbykJ4T0zyQx/rAy7sIaAM3Rb6SS30XnKPE5KGlPmyM=;
        b=joHd7VqWeO67A5UaRjKVMqy3G3iUdkInk/l/8lraztcAaMExjJRhQ4afQHRTVn/0K3
         QWfL5Utu6Gw2KZDK9+oGfIQVjtbHha9LeSX+Y3oT0+j6zmyvlId2Fdf27OIcmgTutzX8
         y6xws3C0B+7PLqk3wor9o4aWO666tS0r/ZpDtOr2OId1CQUm0K+cJZg2PEkSgvkcYkP5
         4R/nCsGywhj/sMYpWV77l+JfNtGpf8qOMHkLvwKu8WIQk+Hygv8vlRt7gysngto7vwak
         3d0Mn+6KhpYfRC9o57GuXSRGrkutSqpssOU3+VGs81h4yT6F/U8FMcWL+rHxG3dXUOqM
         TmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778761542; x=1779366342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbykJ4T0zyQx/rAy7sIaAM3Rb6SS30XnKPE5KGlPmyM=;
        b=FinBLFPiBxVs0p9P9NYdUJ+SgxDbb8j9O1kK04DLK0HY3pS5fjevHyYvGy/m4v/ZEf
         UZkFMrXYskhRmAuCZ6Bs2gp8G2jRxhqVU29bR483AQSBoiKeNnav/+H/0OR7VSmfKamW
         sS5WkQIvZduGcbWVPFAtV4dDFHWNWh+Hnyrp6miyh6B//tONrMiVXsEMRPXF7CYZRZPE
         x7jeDpIDNzHd720vCFik7Wa3h4o7gDgdinWq2Tu8vYIDEtQaut3hIENmQ8icyHPDU8Mp
         qBkXTpaIWp2WuEXScRshvHTwpcTMBcCP9p44SYYPXHIrgMWvKoOHzu8SMEsDZ4yopa8U
         8WXQ==
X-Gm-Message-State: AOJu0YwzJ7Fn3Sn6eoN2+sFYMeDhBj2TjMCLBbuaMr7fv7WZrRCnpO7m
	PWHvOMLMU1zYVcAPTvF5EItMEqSl4OVjP9Frqu8EW1W3r4mjdwcYy6vL
X-Gm-Gg: Acq92OHXq1SJYYHr8LapkCPYHFrckyPTPa2Df2gLQ3ftHrglnv9l9s7wbkL3yGXrYk8
	006wUQWpUq3uBhwClkiGbvegPu3PHq07apSQhGwn2j/6PPH3KVi6Qgyu7ECOupZTjvP6G73EcO2
	lY9HYuyyRdBAqIJ26OK3PSAL/sA2zzijM4CF1RSpJ+KnHnkt2ixQcL/MQbA00GK87bdGRGk2s6E
	hAHbGnVmqMA3L9jaRv4cksoVcsih6NG3yoH3C2kkwMF5k3pmawmZPDkAyaMk9yUTneBk7ZdR2EI
	/NgcF+HCn8sfgzoP4gE1d7SkGigVFuzTSZGt/5EQQCGqnHNFlQPUCs/p4YK2fBQIPGPdIocFFhP
	vDrhmaWwKNC5ePSMtYAMcShGE3Ylweo/v/bhCW43p49UiA+WP8wDUaW/TvnZ39Ao8mPeOmPyZkr
	OXEDr3YUYvPIJAZhNGEX66VA3w6AAA4/9vXOxnJiOCw2pNTX7CryGvW1JLGbQIS6W0a5uM0m56c
	lzwofpE7w==
X-Received: by 2002:a05:7301:2b07:b0:2dd:6937:79bc with SMTP id 5a478bee46e88-30153adf44amr3957855eec.6.1778761541639;
        Thu, 14 May 2026 05:25:41 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm2659303eec.25.2026.05.14.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:25:39 -0700 (PDT)
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
Subject: [PATCH net v2] net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()
Date: Thu, 14 May 2026 05:25:12 -0700
Message-ID: <20260514122511.3083479-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52D1B541BBF
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
	TAGGED_FROM(0.00)[bounces-287949-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.947];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

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

Add an rcu_head field to struct rmnet_endpoint and replace kfree() with
kfree_rcu() so the endpoint memory remains valid through the RCU grace
period. Also remove the rmnet_vnd_dellink() call and inline only the
nr_rmnet_devs decrement, since rmnet_vnd_dellink() would set
ep->egress_dev to NULL during the grace period, creating a data race
with lockless readers.

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Assisted-by: Claude:claude-opus-4-7
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: 
 - Fix From/Sob mismatch
 - Add [net] subject prefix
 - Use kfree_rcu() with embedded rcu_head instead of
   kfree_rcu_mightsleep() to avoid sleeping under rtnl (Jakub)
 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 8 ++++----
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 269c0449760c..78d4df55740a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -213,8 +213,8 @@ static void rmnet_dellink(struct net_device *dev, struct list_head *head)
 	ep = rmnet_get_endpoint(real_port, mux_id);
 	if (ep) {
 		hlist_del_init_rcu(&ep->hlnode);
-		rmnet_vnd_dellink(mux_id, real_port, ep);
-		kfree(ep);
+		real_port->nr_rmnet_devs--;
+		kfree_rcu(ep, rcu);
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
+			kfree_rcu(ep, rcu);
 		}
 		rmnet_unregister_real_device(real_dev);
 		unregister_netdevice_many(&list);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index ed112d51ac5a..f50fae1c6bdd 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -18,6 +18,7 @@ struct rmnet_endpoint {
 	u8 mux_id;
 	struct net_device *egress_dev;
 	struct hlist_node hlnode;
+	struct rcu_head rcu;
 };
 
 struct rmnet_egress_agg_params {
-- 
2.43.0


