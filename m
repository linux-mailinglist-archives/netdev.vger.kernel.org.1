Return-Path: <netdev+bounces-305097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DUe+Az7ES2rEZwEAu9opvQ
	(envelope-from <netdev+bounces-305097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:05:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E377125C4
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305097-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305097-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74D7C324CF71
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119CB3988FF;
	Mon,  6 Jul 2026 14:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640736F909;
	Mon,  6 Jul 2026 14:44:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349046; cv=none; b=LxxiWRsPWqe5eBeF4tYsDZkLo/dy5+IpsFmtNqVJ4yYusGHRxTv0PrdSIGBEbCFS1pTe5Fk+lO1dQQKEn2TFumlAcMq85d/5LLhjqJt74lWLRafYmgQlFqLlxX/XMS3Li6SRFzn6p0IIVWBBTA8cNeLE5B7rKg/6W0tui5bAS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349046; c=relaxed/simple;
	bh=0e8PzLzhR4haYX9abpVj4W9Aqs7E3nYBJAeC0EQ3q2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjFq+1ZWNtmFGpZMPdqEFqa52etDDpHp2R8gDdhf2pFyDzjEV0MKqL9UGEa/oUSjtmflZwJvrF2yvWqjMRgqDfvQjVpzAf0nkKu8KtYXLhZ/425AgpqC/5vBQRW1GVwWWsJZ4PCiiFJMQ7h3ExWrYm+tzprYEV1ibfPG9vBaQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAXoQQUv0tqcWs7Fw--.32970S2;
	Mon, 06 Jul 2026 22:43:33 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ice: propagate ETH56G deskew read errors
Date: Mon,  6 Jul 2026 22:43:25 +0800
Message-ID: <20260706144325.91320-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXoQQUv0tqcWs7Fw--.32970S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1Uuw1fZrWUWr4DWr1xXwb_yoW5tr4DpF
	Z3KF9rtF1rtw18WFZ7Xa1Iva15Cay2yrWDGws3Ka4vyFyDG34FqF10yFyxt3WUK34kCF17
	ZFnayF1fuFnFqFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRx-BiUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305097-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:pengpeng@iscas.ac.cn,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:jacob.e.keller@intel.com,m:arkadiusz.kubalewski@intel.com,m:karol.kolacinski@intel.com,m:sergey.temerkhanov@intel.com,m:michal.michalik@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.osuosl.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3E377125C4

ice_ptp_calc_deskew_eth56g() returns a u32 deskew value, but it also
returns the negative read_poll_timeout() error when the DESKEW valid bit
never appears. That converts the negative error into a large unsigned
deskew contribution, which can then be folded into the RX timestamp
offset and programmed into hardware.

Return the deskew value through an output parameter and propagate the
read error from ice_phy_set_offsets_eth56g() instead of using it as
offset data.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- add the Fixes tag requested by Jedrzej and Aleksandr
- clarify that @deskew is an output parameter
- target the patch at net as suggested by Aleksandr

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 28 +++++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8e5f97835954..cc424518a2a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1736,17 +1736,21 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
  * @ds: deskew multiplier
  * @rs: RS-FEC enabled
  * @spd: link speed
+ * @deskew: output parameter for the calculated deskew value
  *
- * Return: calculated deskew value
+ * Return: 0 on success, negative error code otherwise
  */
-static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
-				      bool rs, enum ice_eth56g_link_spd spd)
+static int ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
+				      bool rs, enum ice_eth56g_link_spd spd,
+				      u32 *deskew)
 {
 	u32 deskew_i, deskew_f;
 	int err;
 
-	if (!ds)
+	if (!ds) {
+		*deskew = 0;
 		return 0;
+	}
 
 	read_poll_timeout(ice_read_ptp_reg_eth56g, err,
 			  FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i), 500,
@@ -1766,7 +1770,9 @@ static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
 	deskew_i = FIELD_PREP(ICE_ETH56G_MAC_CFG_RX_OFFSET_INT, deskew_i);
 	/* Shift 3 fractional bits to the end of the integer part */
 	deskew_f <<= ICE_ETH56G_MAC_CFG_FRAC_W - PHY_REG_DESKEW_0_RLEVEL_FRAC_W;
-	return mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
+	*deskew = mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
+
+	return 0;
 }
 
 /**
@@ -1789,6 +1795,7 @@ static int ice_phy_set_offsets_eth56g(struct ice_hw *hw, u8 port,
 {
 	u32 rx_offset, tx_offset, bs_ds;
 	bool onestep, sfd;
+	int err;
 
 	onestep = hw->ptp.phy.eth56g.onestep_ena;
 	sfd = hw->ptp.phy.eth56g.sfd_ena;
@@ -1805,11 +1812,16 @@ static int ice_phy_set_offsets_eth56g(struct ice_hw *hw, u8 port,
 	if (sfd)
 		rx_offset = add_u32_u32_fx(rx_offset, cfg->rx_offset.sfd);
 
-	if (spd < ICE_ETH56G_LNK_SPD_40G)
+	if (spd < ICE_ETH56G_LNK_SPD_40G) {
 		bs_ds = ice_ptp_calc_bitslip_eth56g(hw, port, bs_ds, fc, rs,
 						    spd);
-	else
-		bs_ds = ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs, spd);
+	} else {
+		err = ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs, spd,
+						 &bs_ds);
+		if (err)
+			return err;
+	}
+
 	rx_offset = add_u32_u32_fx(rx_offset, bs_ds);
 	rx_offset &= ICE_ETH56G_MAC_CFG_RX_OFFSET_INT |
 		     ICE_ETH56G_MAC_CFG_RX_OFFSET_FRAC;
-- 
2.43.0


