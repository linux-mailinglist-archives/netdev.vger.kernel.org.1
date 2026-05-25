Return-Path: <netdev+bounces-291280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLl0BlofFGobKAcAu9opvQ
	(envelope-from <netdev+bounces-291280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647825C8FBD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2DA3019B92
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504B33F588;
	Mon, 25 May 2026 10:07:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748C18B0F
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703621; cv=none; b=CV0gipYUd2QGD1cTx6c98pqOuEZ6IRihgjkmYYNGtBwlI1xu55riOub6yhaMfI0ZSH3rAzIH83U/wj/fW1nexWjDODSt9KH8WH0fV1uIMvNMFpt7QWEMeUD2TQvoMmprjGUGBc+QfRCrYUQyMT7hEWWHHh03AAYpjq3wfYRi+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703621; c=relaxed/simple;
	bh=TA8dPnMNyx8DJ2tuomc5fktwCh7iL/ZqAt0Qho2boDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOul9qd4aKzRSeHTTD9JHX3VAlOCDjJfOV4pDLFwuOMNzbGDzD0MrX3EokNJ7GV36kL6qtnyJYZpHvYb4gyhw7OJ4PjdtuMGCd1whSbf1eU8JDQvOdgvD3TTA4ZzH/+w+niZkydrb2E8e41TZfu/Cxk0gbZdEM6C0HzqURtteB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1779703560tc2982445
X-QQ-Originating-IP: gTcJGyVfsanwjMMXWVUGKt7q3WE13Tojls+Kte3cdho=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:05:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3612791413146679667
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
Subject: [PATCH net-next v2 3/3] net: txgbe: rework service event handling
Date: Mon, 25 May 2026 18:05:43 +0800
Message-Id: <20260525100543.27140-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260525100543.27140-1-jiawenwu@trustnetic.com>
References: <20260525100543.27140-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NC4p7XQIBeahMnnXmKR6cp0FIH9IOo0YOI3wSRA1ywZK/9803+J1esiD
	A4EtOX4YBBNS5T9itqu3SSG0PI++QD/UPukv5zELbyxm+H6f4pdgBXD7tY1y+pOecRURRpd
	+e1pQFhE7vMUAGEF2Vs6rvi1pcFApWJ09eNisjitzxteXEipfsbOuj4/XxEv90sRFcWg046
	m/KrYzvBHpQf/knsqQwuynK6RSrODjAPGnpRrSr/a3GHCXyBDeB6dp6fFssufJ345Ct4jib
	Cv11SKl95fmYFkkCXmtWWXVxSAwh6KxHMUy4LegQX2vOrzZvlKRY0w24FxQ1CLJwfQYuai+
	r+yxy/J24sZBEtm04yZecKmItBoKTsS5QR5sJyIJKp0WIb6bbM1yIawe37SFXahex8vHDMG
	u6dp1QMQ2OK5YLVJsqSZTBX0nSl9JjWWerNXFPd94eqQnJ1PABkShwo9Un/mLX5okmsIPzN
	DlJp2aY97UbVLKad7QUSGtdFIG8xSg9K53ykNaEoDSKXi8SV0wXzdlqyZdEbEhTfW2DnCP5
	T82y23Nwy4P9MRooG2n1F57t2YUF98SorDpd2ZUz/ywBP5/DExnyoWdpnrBB4mWKBerkwA8
	RJI1RYNq0grIB0zc/QkQJ+XVchSS50NKdJyEyosDCwsl4HTDXnfjK0d1fsY50C2gYlqEh+6
	xD6Pv8SO1iIN4tOoj/luNmpnOME4PogjDJrVfXCu6VbRIWv24HuBj6DAfhgjn2Wq3JGzl7M
	tQOvFk7jC37Yi9vqmo/y0gRoe9ysAEgiht8Us4ADJZbMqckAn/sD1t2DfFA2IAeNDIhY11C
	1SYXFQiHent+c3b24b3/imm22Yfe8jHm3rtyJIo3rd4eqccLUNx6B8yyFqWBIZ5Ry8Z4l59
	fiO083rHm0RyzjvtS9NV5MPt7cowp2oDZyFptVZJv9bWfwE5CQhVwou3llWa+3Fmr0geT/7
	2AdiXrACmIaEWklyB5HKRLlFBCXjkGL4glKNRW+NgsuxdfMxeWiWEzMLEAly2zDgRtU6UBc
	67AmhAPQ6AjqJhAuhbI03jhWxyacJgEr5fII4rDO1QwqwBQZZKBPagcZRlD9lQ8BTX9glSW
	GF6fhgsaqXqQb1xtIsyOpi50gHA3pdyrA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291280-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.484];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 647825C8FBD
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


