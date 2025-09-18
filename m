Return-Path: <netdev+bounces-224453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2385B8542B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AA4563B06
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548330C62E;
	Thu, 18 Sep 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eVkiIUBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1C226CF7
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205528; cv=none; b=AjbBxA65dmXzu8vjG7RbtwnpuHmfQWD5TmnHDDATGVrhfATU/AJ2JlqRgi6IQ1Igya3D8M05Otc5ep1T2MtpjNmGdKHAHFWjNz1kMI565sbkyeJLnyJB2Hrv4Pk8rkB622a/p+rAMKdIh8ICZoNUXubXuQDQ7haMYdYIrbUWUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205528; c=relaxed/simple;
	bh=aBRm/XwxIpa7dVLgAE2LsXwvOaMrrp+xrqYEgqGKLmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojje4Sf/txtuBRJx/znn4g6J1vNSURM3Nr+Sy5ON6qSp+OuBRTR2QfH59Si+GAgYpwg/kPLNl5C5aCeSDyXFRdvFd9FnfQTUyxpgJrztPqBjzuXlaA11pkszu6UTTUpomFTsyx5iHks2sq0yEJTQq/fzu/mIaizLlWsp7tfSyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eVkiIUBT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso8578675e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758205524; x=1758810324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6LeW8LgrC+7IoQsPqWLjDrbYdl5hrv+bJnva256Q8c=;
        b=eVkiIUBTt2Sdp9Ray80UNRhe6n0mH8Um+KkwgQzUkLihDqF9f3mxR15lUElO+BadYH
         7TtV4eY026rxFfk4qcqNNCYrJYbH2IA4mII/lq28MT7UOsySD3DLKVMeLcCgLDAJ8FE5
         QLahS9utmjDM5wNGNViMMIlAeWN3Z5ST3sFuxp8jUjYQSyYzosPUsJrIiHR4o89o7FrA
         csvJ4cy/3fcmbKkhjHx7n4rEKIn9PLf+mUnRNoHMaB7cepqV7Ep8IehTon/LWsr6JtKP
         rbE5SpMT8ekd3zcoB5fXy/ZSsTXQnVlP59OB2z84YU/rSyYewZOsCHTkhfTbaxyd42IO
         Qf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205524; x=1758810324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6LeW8LgrC+7IoQsPqWLjDrbYdl5hrv+bJnva256Q8c=;
        b=JNiouRXgEjwhvl8DXwGg9D8elwQPD9HwWQdwpy9jAx8LwAPvmkRsSwPgJl/GqZrezy
         Cmp0TQ3Lcu8eff4xH2HgoD0pKYg9zYsG1A1pPa4gxHxeYMbydBNUaleLG5BNO/+fhxz+
         q2sfQCmccg6+d8BUUMpRNtf2KEvIJRu8XhDT/EZmZBAbU35Vg1edL/U82NdhLftmoczW
         lgFwqJVV1BH1/+aB6UlSGtz1drz6al2/1o1Jawd/ZCOHnh/U32SiwFrdwfy/bP8ru6tN
         +CznBKt6d12x3urJvK3FFH239+tAnv9JM6Wp+CxnJowRBrzqx9ocSXmq5VwhArizEhSz
         dp3g==
X-Forwarded-Encrypted: i=1; AJvYcCWxImUc2yRU2e8TX/2+bFcmKNu6ewfsOyyUg799zkJEHf9OHXusnPol2Y6iRsg704RogsXivDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylivP7uwy/Fm5lUXtpCSMMHUZupfFiGBaIIHUx3JswnlePwI/i
	zHcnBZ1G6wGymiM87OspYV81LZxYldmZ3bNZd4UtWtkFx1cBwpGVYWqcO4zpRr8EXMQ=
X-Gm-Gg: ASbGncsBmMt3Ez5Pf5Ji9TTMToBmST38l9wZb4yRpqSIv4PNW9S+sQr28ROCvkb4wZf
	dNC0WEsbaJz7JzafqrOJ1o7liChYQ/1sQUHOTGLLTnhBySVNP9FCt8DQjYe+jjZjqqKBV+GxC2k
	aAo7VdTUXQXOuihH0ewPgtao26XXDf58rNAS3UYjdzMTtu1Ole56oodm6TfGm2X7iKqmfZFG36U
	vY8GeKLu1he3Kn+BIi/C5W+MZ0t/Nq/qM32GCUP95fp604jLzYw6E8IXDr4UBy65QD/poFTZxwW
	qHCoMcrzFxYbgiGNvxwOZukEBPEQIJQ9aATIi7OMZ19h0oCMbyCUy/OWH6zXzjpVye/Cya8KjA0
	K3ArdWOV/vt/Qve+HPu7wd8hKVoG7ia//8VOhKFSdiUfdnVAUxY+AhnBCvbqF2kKg
X-Google-Smtp-Source: AGHT+IGNAo7C+zMY83r5ou8kSpMfx66wb7cWrnyjxz0Myg35w7WZ/V3ybbJLqy5zIvKk9BO8efSDMg==
X-Received: by 2002:a05:600c:1c82:b0:45d:d68c:2a43 with SMTP id 5b1f17b1804b1-46206f04ef8mr55880735e9.33.1758205523876;
        Thu, 18 Sep 2025 07:25:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32085823sm63270675e9.0.2025.09.18.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:25:23 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/3] net: replace use of system_wq with system_percpu_wq
Date: Thu, 18 Sep 2025 16:24:26 +0200
Message-ID: <20250918142427.309519-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918142427.309519-1-marco.crivellari@suse.com>
References: <20250918142427.309519-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/sfc/efx_channels.c       |  2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c |  2 +-
 drivers/net/phy/sfp.c                         | 12 ++++++------
 net/bridge/br_cfm.c                           |  6 +++---
 net/bridge/br_mrp.c                           |  8 ++++----
 net/ceph/mon_client.c                         |  2 +-
 net/core/skmsg.c                              |  2 +-
 net/devlink/core.c                            |  2 +-
 net/ipv4/inet_fragment.c                      |  2 +-
 net/netfilter/nf_conntrack_ecache.c           |  2 +-
 net/openvswitch/dp_notify.c                   |  2 +-
 net/rfkill/input.c                            |  2 +-
 net/smc/smc_core.c                            |  2 +-
 net/vmw_vsock/af_vsock.c                      |  2 +-
 14 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 0f66324ed351..ed3a96ebc7f3 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1281,7 +1281,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
 		time = jiffies - channel->rfs_last_expiry;
 		/* Would our quota be >= 20? */
 		if (channel->rfs_filter_count * time >= 600 * HZ)
-			mod_delayed_work(system_wq, &channel->filter_work, 0);
+			mod_delayed_work(system_percpu_wq, &channel->filter_work, 0);
 #endif
 
 		/* There is no race here; although napi_disable() will
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 703419866d18..fc075ab6b7b5 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1300,7 +1300,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
 		time = jiffies - channel->rfs_last_expiry;
 		/* Would our quota be >= 20? */
 		if (channel->rfs_filter_count * time >= 600 * HZ)
-			mod_delayed_work(system_wq, &channel->filter_work, 0);
+			mod_delayed_work(system_percpu_wq, &channel->filter_work, 0);
 #endif
 
 		/* There is no race here; although napi_disable() will
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4cd1d6c51dc2..eaccd92253a1 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -912,7 +912,7 @@ static void sfp_soft_start_poll(struct sfp *sfp)
 
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) &&
 	    !sfp->need_poll)
-		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
 	mutex_unlock(&sfp->st_mutex);
 }
 
@@ -1683,7 +1683,7 @@ static void sfp_hwmon_probe(struct work_struct *work)
 	err = sfp_read(sfp, true, 0, &sfp->diag, sizeof(sfp->diag));
 	if (err < 0) {
 		if (sfp->hwmon_tries--) {
-			mod_delayed_work(system_wq, &sfp->hwmon_probe,
+			mod_delayed_work(system_percpu_wq, &sfp->hwmon_probe,
 					 T_PROBE_RETRY_SLOW);
 		} else {
 			dev_warn(sfp->dev, "hwmon probe failed: %pe\n",
@@ -1710,7 +1710,7 @@ static void sfp_hwmon_probe(struct work_struct *work)
 static int sfp_hwmon_insert(struct sfp *sfp)
 {
 	if (sfp->have_a2 && sfp->id.ext.diagmon & SFP_DIAGMON_DDM) {
-		mod_delayed_work(system_wq, &sfp->hwmon_probe, 1);
+		mod_delayed_work(system_percpu_wq, &sfp->hwmon_probe, 1);
 		sfp->hwmon_tries = R_PROBE_RETRY_SLOW;
 	}
 
@@ -2564,7 +2564,7 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 		/* Force a poll to re-read the hardware signal state after
 		 * sfp_sm_mod_probe() changed state_hw_mask.
 		 */
-		mod_delayed_work(system_wq, &sfp->poll, 1);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, 1);
 
 		err = sfp_hwmon_insert(sfp);
 		if (err)
@@ -3009,7 +3009,7 @@ static void sfp_poll(struct work_struct *work)
 	// it's unimportant if we race while reading this.
 	if (sfp->state_soft_mask & (SFP_F_LOS | SFP_F_TX_FAULT) ||
 	    sfp->need_poll)
-		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
 }
 
 static struct sfp *sfp_alloc(struct device *dev)
@@ -3179,7 +3179,7 @@ static int sfp_probe(struct platform_device *pdev)
 	}
 
 	if (sfp->need_poll)
-		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
+		mod_delayed_work(system_percpu_wq, &sfp->poll, poll_jiffies);
 
 	/* We could have an issue in cases no Tx disable pin is available or
 	 * wired as modules using a laser as their light source will continue to
diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index a3c755d0a09d..c2c1c7d44c61 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -134,7 +134,7 @@ static void ccm_rx_timer_start(struct br_cfm_peer_mep *peer_mep)
 	 * of the configured CC 'expected_interval'
 	 * in order to detect CCM defect after 3.25 interval.
 	 */
-	queue_delayed_work(system_wq, &peer_mep->ccm_rx_dwork,
+	queue_delayed_work(system_percpu_wq, &peer_mep->ccm_rx_dwork,
 			   usecs_to_jiffies(interval_us / 4));
 }
 
@@ -285,7 +285,7 @@ static void ccm_tx_work_expired(struct work_struct *work)
 		ccm_frame_tx(skb);
 
 	interval_us = interval_to_us(mep->cc_config.exp_interval);
-	queue_delayed_work(system_wq, &mep->ccm_tx_dwork,
+	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork,
 			   usecs_to_jiffies(interval_us));
 }
 
@@ -809,7 +809,7 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
 	 * to send first frame immediately
 	 */
 	mep->ccm_tx_end = jiffies + usecs_to_jiffies(tx_info->period * 1000000);
-	queue_delayed_work(system_wq, &mep->ccm_tx_dwork, 0);
+	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork, 0);
 
 save:
 	mep->cc_ccm_tx_info = *tx_info;
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index fd2de35ffb3c..3c36fa24bc05 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -341,7 +341,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
 out:
 	rcu_read_unlock();
 
-	queue_delayed_work(system_wq, &mrp->test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->test_work,
 			   usecs_to_jiffies(mrp->test_interval));
 }
 
@@ -418,7 +418,7 @@ static void br_mrp_in_test_work_expired(struct work_struct *work)
 out:
 	rcu_read_unlock();
 
-	queue_delayed_work(system_wq, &mrp->in_test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->in_test_work,
 			   usecs_to_jiffies(mrp->in_test_interval));
 }
 
@@ -725,7 +725,7 @@ int br_mrp_start_test(struct net_bridge *br,
 	mrp->test_max_miss = test->max_miss;
 	mrp->test_monitor = test->monitor;
 	mrp->test_count_miss = 0;
-	queue_delayed_work(system_wq, &mrp->test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->test_work,
 			   usecs_to_jiffies(test->interval));
 
 	return 0;
@@ -865,7 +865,7 @@ int br_mrp_start_in_test(struct net_bridge *br,
 	mrp->in_test_end = jiffies + usecs_to_jiffies(in_test->period);
 	mrp->in_test_max_miss = in_test->max_miss;
 	mrp->in_test_count_miss = 0;
-	queue_delayed_work(system_wq, &mrp->in_test_work,
+	queue_delayed_work(system_percpu_wq, &mrp->in_test_work,
 			   usecs_to_jiffies(in_test->interval));
 
 	return 0;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab66b599ac47..c227ececa925 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -314,7 +314,7 @@ static void __schedule_delayed(struct ceph_mon_client *monc)
 		delay = CEPH_MONC_PING_INTERVAL;
 
 	dout("__schedule_delayed after %lu\n", delay);
-	mod_delayed_work(system_wq, &monc->delayed_work,
+	mod_delayed_work(system_percpu_wq, &monc->delayed_work,
 			 round_jiffies_relative(delay));
 }
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 83c78379932e..2ac7731e1e0a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -876,7 +876,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 	sk_psock_stop(psock);
 
 	INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
-	queue_rcu_work(system_wq, &psock->rwork);
+	queue_rcu_work(system_percpu_wq, &psock->rwork);
 }
 EXPORT_SYMBOL_GPL(sk_psock_drop);
 
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 7203c39532fc..58093f49c090 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -320,7 +320,7 @@ static void devlink_release(struct work_struct *work)
 void devlink_put(struct devlink *devlink)
 {
 	if (refcount_dec_and_test(&devlink->refcount))
-		queue_rcu_work(system_wq, &devlink->rwork);
+		queue_rcu_work(system_percpu_wq, &devlink->rwork);
 }
 
 struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp)
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 470ab17ceb51..025895eb6ec5 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -183,7 +183,7 @@ static void fqdir_work_fn(struct work_struct *work)
 	rhashtable_free_and_destroy(&fqdir->rhashtable, inet_frags_free_cb, NULL);
 
 	if (llist_add(&fqdir->free_list, &fqdir_free_list))
-		queue_delayed_work(system_wq, &fqdir_free_work, HZ);
+		queue_delayed_work(system_percpu_wq, &fqdir_free_work, HZ);
 }
 
 int fqdir_init(struct fqdir **fqdirp, struct inet_frags *f, struct net *net)
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index af68c64acaab..81baf2082604 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -301,7 +301,7 @@ void nf_conntrack_ecache_work(struct net *net, enum nf_ct_ecache_state state)
 		net->ct.ecache_dwork_pending = true;
 	} else if (state == NFCT_ECACHE_DESTROY_SENT) {
 		if (!hlist_nulls_empty(&cnet->ecache.dying_list))
-			mod_delayed_work(system_wq, &cnet->ecache.dwork, 0);
+			mod_delayed_work(system_percpu_wq, &cnet->ecache.dwork, 0);
 		else
 			net->ct.ecache_dwork_pending = false;
 	}
diff --git a/net/openvswitch/dp_notify.c b/net/openvswitch/dp_notify.c
index 7af0cde8b293..a2af90ee99af 100644
--- a/net/openvswitch/dp_notify.c
+++ b/net/openvswitch/dp_notify.c
@@ -75,7 +75,7 @@ static int dp_device_event(struct notifier_block *unused, unsigned long event,
 
 		/* schedule vport destroy, dev_put and genl notification */
 		ovs_net = net_generic(dev_net(dev), ovs_net_id);
-		queue_work(system_wq, &ovs_net->dp_notify_work);
+		queue_work(system_percpu_wq, &ovs_net->dp_notify_work);
 	}
 
 	return NOTIFY_DONE;
diff --git a/net/rfkill/input.c b/net/rfkill/input.c
index 598d0a61bda7..53d286b10843 100644
--- a/net/rfkill/input.c
+++ b/net/rfkill/input.c
@@ -159,7 +159,7 @@ static void rfkill_schedule_global_op(enum rfkill_sched_op op)
 	rfkill_op_pending = true;
 	if (op == RFKILL_GLOBAL_OP_EPO && !rfkill_is_epo_lock_active()) {
 		/* bypass the limiter for EPO */
-		mod_delayed_work(system_wq, &rfkill_op_work, 0);
+		mod_delayed_work(system_percpu_wq, &rfkill_op_work, 0);
 		rfkill_last_scheduled = jiffies;
 	} else
 		rfkill_schedule_ratelimited();
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2a559a98541c..e216d237865b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -85,7 +85,7 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
 	if (!lgr->freeing) {
-		mod_delayed_work(system_wq, &lgr->free_work,
+		mod_delayed_work(system_percpu_wq, &lgr->free_work,
 				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
 						SMC_LGR_FREE_DELAY_CLNT :
 						SMC_LGR_FREE_DELAY_SERV);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 0538948d5fd9..4c2db6cca557 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1649,7 +1649,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			 * reschedule it, then ungrab the socket refcount to
 			 * keep it balanced.
 			 */
-			if (mod_delayed_work(system_wq, &vsk->connect_work,
+			if (mod_delayed_work(system_percpu_wq, &vsk->connect_work,
 					     timeout))
 				sock_put(sk);
 
-- 
2.51.0


