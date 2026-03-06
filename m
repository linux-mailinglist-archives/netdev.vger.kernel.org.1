Return-Path: <netdev+bounces-264693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PjxE4R1qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4221C1BF
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9FEF3050EF2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95300370D71;
	Fri,  6 Mar 2026 06:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3837107B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778840; cv=none; b=dGmnIczgeEPEr1Gtl35LMXKxpKHsiYTLXzlenBDT2q/o/R8JsNTnZqtw3YsM7quzbVhVEKSuC5E6IHhg6mJwLe8Ny/rPw4qimu/XX3DDBJDSt03Bse4jgWSEcYtVbtlWo+aaPkvUQnzSg+9iovnmDAiUzN97ikgK0FN8HEkq+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778840; c=relaxed/simple;
	bh=+8bPcs+VPVRneVB1YBXHXMKsZyVyDIXRPpHdkb6IHTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kv6BBYwqzgVCS9lGzS7t+H0ObybC7DKDl+1Ycp62g9qggSRyRrE0rlco6BVVX9c3i5MA+u8iOsVpH6V6drzO0o+llWF/OfeY0u+MIwYHBlAXskEcgqiCeIjSavzxvJXZ6z5ohKH9L7Hd8fjp+6I9tA2xU44ooPpWQAhhyMUIQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778774t1c0281e6
X-QQ-Originating-IP: NQYf1FoU5pB+DtxdahYoxg/4uDSi44Mw3WzPT/RcQqA=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:32:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9286073491793904433
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 04/10] net: ngbe: improve the reset flow
Date: Fri,  6 Mar 2026 14:32:05 +0800
Message-Id: <20260306063211.20536-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260306063211.20536-1-jiawenwu@trustnetic.com>
References: <20260306063211.20536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NzXPRyUPkQJhSG5HcS8nTl2lQ8RROVITjKS3jHcOxKf6mpX8IG6oIhww
	ygQJnvE+p3kMzKBESL3qIeQsua3RbQrzzt7WHijUKOFLcyz1dKTOtS+MHV+Ce/AhAsDWSb7
	VNyp3Gp/6azZkWXVKvp7BhaWfD//l5WX9frXlUOl1mqDuDecyjozgUnZ1AqG/Ba7p3s89+5
	QcaSj5fSs0BwnYOq5K2/zOzBsLY8eAwzCXXkKa82OGDy7AdfHHDZMxugqXKQyCmhcrvNyY8
	ijs3Og/8gJc7iC+1VK2jQDji7TVmRIUvcSaaFk/uXQ+TKd6xpE0npi1ktmPQlnOIB3Aaiv+
	EwQx9F1DcilDIs/zh2PI9He1fM69TyTL4fMyDqbKaGUfIWQVhXimgPiKcnITDPiqXL3YrrW
	MEpCxB1HZnXSK4DSTpVikA3UoFuntKli6wfRHvi+ZoDNf/8I8aHnWcddTlq7b8nfckI2Mv8
	AvsjkEOmfZnGMY892sSx6HIA5LYKJSsvDrnj/ARxCPrWxgWPqjUJH9uGOsuond+INAUuMdH
	qBLG2ezZu8FzxmsDbJNrrFmZFq5AYCFmS4+k9neQnIOUPKrHudBMJhpU3qeHWnPtfkGgfTQ
	by2egJ1Uwoa6vhl3b6t54ISy9YKe69rwoRc+1c0xDfSV5ov9Bmcc1civKGvQ8A5VBkilq/4
	9Mu9C8xF0XZZbb0gJNOHPetsTIhKdL8E5zDSRslfaG2zRaDuV8UCrCVPPZCAlDoDW8WaW1V
	72uclxrgZgBwhkihxbpBZRmFTzfZPuYwVF/8UfsveoIcdZ2zm3n0faj67q1UpR9eOP+ctqG
	3e68GLDYcOZV9yjBSEqpu+8namVOTEKzLOtxg8p4KMCTA+2laRY2QQTMHJdZlerThxNRjSH
	6vIj+pZNa7U54spATBz0edI43h8Q1iVYyO883lmyu55TOtHZVpKx3NwOS9X5/9zGnVKP2CF
	+im65lCqyvbFtg0iZbTSkvjHVMoInhS05DB/gIIgM5H5YT9odDtsgIDbZZQkCNUJAtlTCcX
	PSR4Rt6isdvJxUDroiBrT8j7SLq7MaE31GnNKU2cixKiPm/6N7zRNmqLxP+oxf44eYP6K6U
	E5rKz8Q3PwL5S6EqYVnasTll9jyrrLzFg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: BEA4221C1BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264693-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Action: no action

Implement wx->do_reset() for ngbe driver, and improve the specific reset
flow. Add ngbe_reset_hw() in ngbe_reset(), to make the device connected
to the external PHY (i.e. wx->mac_type != em_mac_type_mdi) do proper LAN
reset, at all times device reset is required.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Joe Damato <joe@dama.to>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 49 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 2b6356622a13..b86980c2418f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -60,7 +60,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8c9d505721b1..f25a5fcab319 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
 
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
+	wx->do_reset = ngbe_do_reset;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -383,6 +384,12 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_reset(struct wx *wx)
 {
+	int err;
+
+	err = ngbe_reset_hw(wx);
+	if (err)
+		wx_err(wx, "Hardware Error: %d\n", err);
+
 	wx_flush_sw_mac_table(wx);
 	wx_mac_set_default_filter(wx, wx->mac.addr);
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
@@ -398,7 +405,7 @@ void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-void ngbe_up(struct wx *wx)
+static void ngbe_up_complete(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
@@ -463,7 +470,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	wx_ptp_init(wx);
 
-	ngbe_up(wx);
+	ngbe_up_complete(wx);
 
 	return 0;
 err_dis_phy:
@@ -502,6 +509,12 @@ static int ngbe_close(struct net_device *netdev)
 	return 0;
 }
 
+void ngbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	ngbe_up_complete(wx);
+}
+
 static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 {
 	struct wx *wx = pci_get_drvdata(pdev);
@@ -563,6 +576,8 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	 */
 	if (netif_running(dev))
 		ngbe_close(dev);
+	else
+		ngbe_reset(wx);
 
 	wx_clear_interrupt_scheme(wx);
 
@@ -579,6 +594,34 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void ngbe_reinit_locked(struct wx *wx)
+{
+	int err = 0;
+
+	netif_trans_update(wx->netdev);
+
+	err = wx_set_state_reset(wx);
+	if (err) {
+		wx_err(wx, "wait device reset timeout\n");
+		return;
+	}
+
+	ngbe_down(wx);
+	ngbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+void ngbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		ngbe_reinit_locked(wx);
+	else
+		ngbe_reset(wx);
+}
+
 static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_open               = ngbe_open,
 	.ndo_stop               = ngbe_close,
@@ -858,7 +901,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
-	ngbe_reset_hw(wx);
+	ngbe_reset(wx);
 	rtnl_lock();
 	err = wx_init_interrupt_scheme(wx);
 	if (!err && netif_running(netdev))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 7077a0da4c98..4f648f272c08 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,5 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
+void ngbe_do_reset(struct net_device *netdev);
 
 #endif /* _NGBE_TYPE_H_ */
-- 
2.48.1


