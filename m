Return-Path: <netdev+bounces-275857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOblCxpz1GmSuAcAu9opvQ
	(envelope-from <netdev+bounces-275857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A50013A9492
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9BBA303CE9F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EEC372B57;
	Tue,  7 Apr 2026 02:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B7372B58
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530666; cv=none; b=R2WdTuhL0HKpbg0AzL5W0u9j6q159updd1UFOZiirXAumzejAjo2YmBQQG25ZFHqCQh3IB8eOVXLTcNtUpZyB1fDjbTbzmLT5C+eQpiK7ojpInsebezC4MPP8r/Iw2SAgc5FLvSODj/73F6bI1+hYjnr0HKAAjMjsOMZnvZfiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530666; c=relaxed/simple;
	bh=wgAMCwOdJzh6pDk9XzcL53HYT3MKwRlI2f8znAlIq28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGR3cYKW98evAKg9IYKc0WnF+/Fgzkp8uck4UDnSjexbDG7ArRxuFAP79iaQpzCUIkBhImOjPYwszrm1rjUeGkguj2xEZzLLGtSkQihO54+HHCT5lPur2dTyPEjSJWPPQQQDcZZ/p86z6BJiFYMKW9EumS88UD5NkA6ywQVFxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530614tba58799b
X-QQ-Originating-IP: 9GPHTmA0QcnWieAP9V48Q/9RJpkSis5ZcJTAe8BgX7s=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13266829711640812409
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 7/9] net: wangxun: schedule hardware stats update in watchdog
Date: Tue,  7 Apr 2026 10:56:14 +0800
Message-Id: <20260407025616.33652-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIAHdi1iQo+zSzc/nT8WSM15dBOH7aqA5uILSDr/8aFT+MDQSzQTQcEZ
	ttDzxF3rDcN8+zNqzrtA7WCmna3o8S65CXo8T7+JtX/8EPvitOyJ7WNdsANQUI95c4wipp6
	1rRMIPRg8NcQnd+OCHZX2gbJgdUsNKMmsxoyhnKUto32rhgp8qWAsQ9uoQredt7Nw/wizFc
	zy7Woatr8TCE59N7mdp1rJHyTJp3RgQrjTEyZZd7JXn2hScEE/UeDUVI54BXeywtEnMGR2B
	rV5X+kaRjn4AcGaoGdTmQCuEWgU9jPPmviXYMU2zHKT8yEPkObYggh45wssfCr1UGo8ZCip
	XMBrqPVTrT2TBxupAkb+0ddmBA72o2lZFa7SYwE/stdJXtrYtBZ5ARVcwBg7SQ6ifD6wSV1
	qI9d1+XbtSOQtdAfzs5cKqJ3erV58tHJg0anfZ1/bLuDarFHmuGLsIuJGAPmjplGqYR7uI6
	5Lckk/T35XzmizP+wYWPTZ1dsn/DSaz2Xb7p7Nv8C5uMjz5czw9LeLLuu4dJNPlnxiIQZVY
	nmnJlE6bXKGYXySJOeTvwrihAgoECMEl3lsV9li0NqoKTlmHKVy/1I/hNH6DEDMTg/tVSls
	5tkvHIuQKgxhF/FSKixkDaw5oUJCMrrCsO9ML76ZtUVrDfFUU4y6UxuBLf3pNkKcIC9Enj3
	GQ51XBlSMmSWY99TbU7E1oJnbCigUI8biBeRUTK/M/VHz8ioecWeMKZXFMqgPSihdBMydsy
	GAs2lFC6FNjKRoJhQXYZaJJ5wNRCJ3SIx6w+EesDnWEbUa7l8seRWFKP+jj4bay3IXmzSjW
	Ry3g9elqJlt0ZGqaQhJJfY3laG46Crkw9q7MGCTx0266OYbBJvyA8bBsJgo4R9NMKmH4vaR
	6ZWE9n8TNxjIBYe6rEaaOJh0bwSKYvMThg051Y9cgOWZIOWznfaBKbgCSinSOPhaeFkJFN4
	lpY1hBkyrdwBfdDUXaVNoMXQqlv59+FJ2+ABoXFcN3YUKy/tP6oU1C2tsmRAPUKtK/KX9v3
	kRO+J5mhswJrYFcwx5wAlCg+rcJbDjPveMAd17vsT5mXT542TGThv6gCr4TpTqsVGzUmUDO
	3tv+CtJM6VPNbqZlqRs5vfD2wc7dyTLnQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275857-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.414];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A50013A9492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hardware statistics should be updated periodically in the watchdog to
prevent 32-bit registers from overflowing. This is also required for the
upcoming pause frame accounting logic, which relies on regular statistics
sampling.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  9 +++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 36 ++++++++++++++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 05731a50d85f..31259f69c0e2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2513,6 +2513,7 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
+	spin_lock_init(&wx->hw_stats_lock);
 	mutex_init(&wx->reset_lock);
 	bitmap_zero(wx->state, WX_STATE_NBITS);
 	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
@@ -2845,6 +2846,12 @@ void wx_update_stats(struct wx *wx)
 	u64 restart_queue = 0, tx_busy = 0;
 	u32 i;
 
+	if (!netif_running(wx->netdev) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
+	spin_lock(&wx->hw_stats_lock);
+
 	/* gather some stats to the wx struct that are per queue */
 	for (i = 0; i < wx->num_rx_queues; i++) {
 		struct wx_ring *rx_ring = wx->rx_ring[i];
@@ -2913,6 +2920,8 @@ void wx_update_stats(struct wx *wx)
 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
 	     i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
+
+	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 0fbdda63b141..7831c5035be8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1354,6 +1354,7 @@ struct wx {
 	bool default_up;
 
 	struct wx_hw_stats stats;
+	spinlock_t hw_stats_lock; /* spinlock for accessing to hw stats */
 	u64 tx_busy;
 	u64 non_eop_descs;
 	u64 restart_queue;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8c9d505721b1..d8e3827a8b1f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -138,6 +138,26 @@ static int ngbe_sw_init(struct wx *wx)
 	return 0;
 }
 
+/**
+ * ngbe_service_task - manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+static void ngbe_service_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, service_task);
+
+	wx_update_stats(wx);
+
+	wx_service_event_complete(wx);
+}
+
+static void ngbe_init_service(struct wx *wx)
+{
+	timer_setup(&wx->service_timer, wx_service_timer, 0);
+	INIT_WORK(&wx->service_task, ngbe_service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+
 /**
  * ngbe_irq_enable - Enable default interrupt generation settings
  * @wx: board private structure
@@ -368,6 +388,10 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_napi_disable_all(wx);
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
+
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, false);
 	wx_irq_disable(wx);
@@ -407,6 +431,7 @@ void ngbe_up(struct wx *wx)
 	wx_napi_enable_all(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
+	mod_timer(&wx->service_timer, jiffies);
 
 	/* clear any pending interrupts, may auto mask */
 	rd32(wx, WX_PX_IC(0));
@@ -770,9 +795,11 @@ static int ngbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	ngbe_init_service(wx);
+
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
-		goto err_free_mac_table;
+		goto err_cancel_service;
 
 	/* phy Interface Configuration */
 	err = ngbe_mdio_init(wx);
@@ -792,6 +819,9 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx_control_hw(wx, false);
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
+err_cancel_service:
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -820,6 +850,10 @@ static void ngbe_remove(struct pci_dev *pdev)
 	netdev = wx->netdev;
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
+
+	timer_shutdown_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 0dd128aa18da..ec32a5f422f2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -130,6 +130,7 @@ static void txgbe_service_task(struct work_struct *work)
 
 	txgbe_module_detection_subtask(wx);
 	txgbe_link_config_subtask(wx);
+	wx_update_stats(wx);
 
 	wx_service_event_complete(wx);
 }
-- 
2.48.1


