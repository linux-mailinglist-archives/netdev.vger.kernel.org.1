Return-Path: <netdev+bounces-289319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPPWLkQZDGrrVwUAu9opvQ
	(envelope-from <netdev+bounces-289319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:03:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7735799A5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5B6C302FC21
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076A3E00B0;
	Tue, 19 May 2026 08:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB033DEAD2
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177737; cv=none; b=c2tuZdmjFdcNabovjleiPLqo9mF9EyolHjZRlm8K612jXAxYA79N8fNX9Up65kwaw9ynFMwcpbyz57B0Isge5Gevk+HHgUxEyal3K0O3CBgKAqnLwUU+aHsVQQBbL7b8plFcf45tomBzThW6ZmePmUZVBzXKtXD4Ba3AaOWD8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177737; c=relaxed/simple;
	bh=TA8dPnMNyx8DJ2tuomc5fktwCh7iL/ZqAt0Qho2boDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjZ3s8PoT46BguIHi473nZn+7ylZIsGavTjTKdIgVsa4axmLHsOkDGh7OT9VbW29I6NeDAFOT+VBcNorgcuDcWV9d3UuAPLvYsX+T9Qtvk+kxKhNsccqlCuLDv/Gcm30dthiXHbqxlynYxkhfLdx+Ii82YZwX/HgbCW9VPwWLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1779177671ted530f15
X-QQ-Originating-IP: ehbzqrgBMRFij0C9DzNICDNK7oY18nrG0EQDngRmp7U=
Received: from lap-jiawenwu.trustnetic.com ( [115.196.16.37])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 May 2026 16:01:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16504549583489526917
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v1 3/3] net: txgbe: rework service event handling
Date: Tue, 19 May 2026 16:00:48 +0800
Message-Id: <20260519080048.7448-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260519080048.7448-1-jiawenwu@trustnetic.com>
References: <20260519080048.7448-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: My96zzrsAKHGi9dphLhlJN6z6a2mBhjYdqgBvj0miNi0/LtCLysqlbfL
	rl+nRD0UkH56Xe/oZliAiDx6nDQQRxv3OtokW27fioRJLhFkbq2DMVEcx1MM1hXwwis6xE7
	/tNM+9mh5B+Z+unPxVlQUWEkfknHWRGjPCAeXgKoBYDPvQBFxteyLCQkzxfzPn+gfF9YYB9
	iLTAj1yV7YAGNKvI2QGV3aUG9icrAb0vi5oYPFKxd/MPSG+SuhylwglZcAKLSndTLzJ5iZs
	H0GvI9RxMxqC9HPKu+R3t8jRaUlndWTuApiLCGdid1z7p9oJ/QnXpEVMGF4qdJifbWrxuPw
	w64wGJvHE8xzN25HmZATdi0R1F3CMQbWxN5kS4e3vIX7e3rj//ytVAc/syyAnMaEuoRbe0O
	EekH+QdgnaMDjvuD16LN1Q7Zd+qazEJHii3GaaSO+7JwbS1jtK7iB3bas90YAummXnZ+ez3
	xTJOy5LkUhSCyE7xnMVWFTpYoKtXO88XwAz3JYO6o8TkcsZ8waP+9eoLf1R6pIbLy6tO6Nd
	RFXag5+AKxStX5yjSKM7t0vZYiS6S5RADlw65GLy035gC3IBe3UcEbceRkl8OSy7e3nd6mC
	D2IsKtoywTSJZwRYdvZ4YE3DhXKWD+r9zyu63uUdA/M01g3wGw1NOU6R5bSbwYM8gUXiRk8
	HFlwAtaKNfysl6DLrA/EQPYjrMaLWAxOOxiYCxUTEWEMyul9ei3EPCcfeZqqXoFVNBvmosj
	mGUCkgDr1gdBVKAI9bInJf8y5PSWOjb8z3X4OTspRXMfoXk+ydkYUFCPX5p0os/WKr9ShmL
	NnTea45pjENcojuIbj/hfBTqP7Xg0RZoo7CDJUhzfM0Absuc5rXGV2b7KU7kIhXwLYrwK5f
	5oFB6i5bxdHO9Z7M1rZF/jQY/e+wiKXFosw4/jq4w6CbGKpXc83Nho3OaEk7pF67hjTmtuj
	rFDFb1Q2OzqUy7J0gJK8iDf4mezf4wjIlZzhhrKtySSu3gdKKXDMB+xGzEHbF9krtAJ+i8m
	xMahegBuKSfHOrNaoSEZ9MTkRHQZ36xvfeveS8SowyJxgBw10CsH7aXooTOay348EDvxrpt
	6JyIEuQba3ajk6puaiilk0=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	TAGGED_FROM(0.00)[bounces-289319-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B7735799A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert to use test_and_clear_bit() for link event subtasks. Only re-arm
the WX_FLAG_NEED_MODULE_RESET flag when module is absent. Unsupported or
invalid modules no longer cause the service task to continuously retry
module identification.

Additionally, explicitly cancel service_task during device teardown to
ensure no pending asynchronous service work survives after the device
has entered the DOWN state.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 10 +++-------
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 19 ++++++-------------
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index f0514251d4f3..da1d3976ed33 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -186,19 +186,15 @@ static void txgbe_get_mac_link(struct wx *wx, int *speed)
 		*speed = SPEED_UNKNOWN;
 }
 
-int txgbe_set_phy_link(struct wx *wx)
+void txgbe_set_phy_link(struct wx *wx)
 {
 	int speed, autoneg, duplex, err;
 
 	txgbe_get_link_capabilities(wx, &speed, &autoneg, &duplex);
 
 	err = txgbe_set_phy_link_hostif(wx, speed, autoneg, duplex);
-	if (err) {
+	if (err)
 		wx_err(wx, "Failed to setup link\n");
-		return err;
-	}
-
-	return 0;
 }
 
 static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
@@ -362,7 +358,7 @@ int txgbe_identify_module(struct wx *wx)
 	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
 	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP28) {
 		wx_err(wx, "Invalid module\n");
-		return -ENODEV;
+		return -EINVAL;
 	}
 
 	if (id->transceiver_type == 0xFF)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
index 4f6df0ee860b..379c74ad19c6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
@@ -10,7 +10,7 @@ int txgbe_test_hostif(struct wx *wx);
 int txgbe_read_eeprom_hostif(struct wx *wx,
 			     struct txgbe_hic_i2c_read *buffer,
 			     u32 length, u8 *data);
-int txgbe_set_phy_link(struct wx *wx);
+void txgbe_set_phy_link(struct wx *wx);
 int txgbe_identify_module(struct wx *wx);
 void txgbe_setup_link(struct wx *wx);
 int txgbe_phylink_init_aml(struct txgbe *txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6755464b4637..ce82e13aa8ae 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -93,31 +93,23 @@ static void txgbe_module_detection_subtask(struct wx *wx)
 {
 	int err;
 
-	if (!test_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
+	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
 		return;
 
 	/* wait for SFF module ready */
 	msleep(200);
 
 	err = txgbe_identify_module(wx);
-	if (err)
-		return;
-
-	clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
+	if (err == -ENODEV)
+		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
 }
 
 static void txgbe_link_config_subtask(struct wx *wx)
 {
-	int err;
-
-	if (!test_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
+	if (!test_and_clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
 		return;
 
-	err = txgbe_set_phy_link(wx);
-	if (err)
-		return;
-
-	clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
+	txgbe_set_phy_link(wx);
 }
 
 /**
@@ -233,6 +225,7 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_napi_disable_all(wx);
 
 	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 
 	if (wx->bus.func < 2)
 		wr32m(wx, TXGBE_MIS_PRB_CTL, TXGBE_MIS_PRB_CTL_LAN_UP(wx->bus.func), 0);
-- 
2.51.0


