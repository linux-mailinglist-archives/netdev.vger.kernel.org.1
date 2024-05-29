Return-Path: <netdev+bounces-99053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95108D38C7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC69B254E8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FA1E528;
	Wed, 29 May 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WWLuLCz0"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99961CAB9;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991781; cv=none; b=dJGqS+CrcNTLuEc6DornNfZmSwJrBYnNLj25EqvQ6JmrPZuXk2i2omw683+6R159TgpAoDMSIwpFNrIh5HXhcSBiWPqyrFqNT1N2VG3D60VLghr6WPTbxFdA+V3TN7ryufG6W1M9O0Bq0tJGHf+aJOkS6oFX+zzITGMRJAB0k6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991781; c=relaxed/simple;
	bh=EE8hcs+isT5TXVZKbPFgdGRhLAGqQ6f253Jfi78I8/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WO946fXh9N57anzBpVj5au/3azwETwxU+e5xfSJz5+mj924AP0OQTr1el4ZmMnL+Ta375Jb+uxiY7uMbX+PbxWFtPESC/NhsmODnl5i/1UwBxicd3Nm16APnAMT5k97sF3D2Q4O7CKhAF6C/xhX3kGeeUgQ3Jr0Ory51eBFYCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WWLuLCz0; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65A714000E;
	Wed, 29 May 2024 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSF0k4DneQQluljDXoTkiwEr3edARiAPThUUTe0SImA=;
	b=WWLuLCz0Xa10/FR8s25LxI6k5i7/YpOV8db5n4HMf65ACyucNecthkor/85hSpjLaj71SW
	fQIF8AkBAmzrxwoijTSQbs7JbAW+0cMZ3yq1xAHjUkTa40SpL0CupRHjqEYjgiLWDRfl4D
	TocOnsv3inQYEBOC44gfLrdIcuAD6qITdXsjZwEAXFFQ0n4LJ6aUJglIKV12JvL45kEu1Y
	aeYTu0SnCRFxtgpZBulBn1LrYtfuSUBi/HjD4CUoGs/G5N8iBjeVoLK3i6bbUEsThD/6iZ
	Wmo83i9kh/jyOmQ/5qImIrBU1M95cpnYDfQtEqP8W/fgLRIMizMY6TO82DwyBw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 29 May 2024 16:09:29 +0200
Subject: [PATCH 2/8] net: ethtool: pse-pd: Expand C33 PSE status with
 class, power and status message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-feature_poe_power_cap-v1-2-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

This update expands the status information provided by ethtool for PSE c33.
It includes details such as the detected class, current power delivered,
and a detailed status message.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/pse-pd/pse.h           |  8 ++++++++
 include/uapi/linux/ethtool_netlink.h |  3 +++
 net/ethtool/pse-pd.c                 | 22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 6eec24ffa866..04219ca20d60 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -36,12 +36,20 @@ struct pse_control_config {
  *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
  * @c33_pw_status: power detection status of the PSE.
  *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
+ * @c33_pw_class: detected class of a powered PD
+ *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
+ * @c33_actual_pw: power currently delivered by the PSE in mW
+ *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
+ * @c33_pw_status_msg: detailed power detection status of the PSE
  */
 struct pse_control_status {
 	enum ethtool_podl_pse_admin_state podl_admin_state;
 	enum ethtool_podl_pse_pw_d_status podl_pw_status;
 	enum ethtool_c33_pse_admin_state c33_admin_state;
 	enum ethtool_c33_pse_pw_d_status c33_pw_status;
+	u32 c33_pw_class;
+	u32 c33_actual_pw;
+	const char *c33_pw_status_msg;
 };
 
 /**
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index b49b804b9495..c3f288b737e6 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -915,6 +915,9 @@ enum {
 	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
 	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
 	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_PW_STATUS_MSG,	/* binary */
+	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2c981d443f27..faddc14efbea 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -86,6 +86,13 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
 	if (st->c33_pw_status > 0)
 		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
+	if (st->c33_pw_class > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
+	if (st->c33_actual_pw > 0)
+		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW */
+	if (st->c33_pw_status_msg)
+		/* _C33_PSE_PW_STATUS_MSG */
+		len += nla_total_size(strlen(st->c33_pw_status_msg) + 1);
 
 	return len;
 }
@@ -117,6 +124,21 @@ static int pse_fill_reply(struct sk_buff *skb,
 			st->c33_pw_status))
 		return -EMSGSIZE;
 
+	if (st->c33_pw_class > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_CLASS,
+			st->c33_pw_class))
+		return -EMSGSIZE;
+
+	if (st->c33_actual_pw > 0 &&
+	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_ACTUAL_PW,
+			st->c33_actual_pw))
+		return -EMSGSIZE;
+
+	if (st->c33_pw_status_msg &&
+	    nla_put_string(skb, ETHTOOL_A_C33_PSE_PW_STATUS_MSG,
+			   st->c33_pw_status_msg))
+		return -EMSGSIZE;
+
 	return 0;
 }
 

-- 
2.34.1


