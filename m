Return-Path: <netdev+bounces-260118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPdQCBuFnGm7IwQAu9opvQ
	(envelope-from <netdev+bounces-260118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0617A230
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5C7A312F53F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A731771B;
	Mon, 23 Feb 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HbwLO5xN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0832548B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864669; cv=none; b=Jb7wAIS25a7fqdRpzZR2mnaTnNVuHTfYEj0JQrN5jiZQCpAhqkf9/FN2NVhHyhPrjhTKcrxA2saTfqHZqjxBfzux9B6R8A6D/MV0GdtJn44u6oo0Ivh9Ej6Vo0Ry3yYA4ZraVytINgsW6UKHvUFUunSDhlw0xx2q6b+wFDU2v+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864669; c=relaxed/simple;
	bh=rbI+wS4h/nAII8/38ytw6Qa6YcvqjRY+zAAuPNjnqLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdGLdS+p7W2wBw9oQz0J9+Y8VMbIAeFaOF4cXBZRa2G9cGq15FIUt0NyQPo5DvQX+bRF/cPmp8iQWfz9zmCm3s28D5FGxshRvTow1bd782Jo5weAwHkIzkFx1JUa+QMgZeVD35hiDX0k1vJniHgUe13bx9Ts+AwJfabLuJBCiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HbwLO5xN; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso2808106a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864666; x=1772469466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXqcrYrUMpsk0hJeQOkUygfghc5Wbge/uByCmNLlVLs=;
        b=bnhVq4NxaXz0P9u1g9V064hja3h17B/jtpzrWe8h3A9pKmD6wxLXcYXFYydcxZfLF8
         dQDMq9rLeTsoO1zw1o0DaA3BFZ7yIZjIR1m1G02wIC1QSIai1sLV934q53Ui9i6c4xQs
         hqfGpmihuz1svfoYS9L/LM39eKNtJw/ZZKtQv8HmVbKIZZrlqig5euIjHgwx/F/boPVY
         in42uFBynj2tMiYCpBWD0G6cXv7r/WGucY0R2ZD7PuS8iHbEJIT0yH86FfsWa8qVGJ9j
         qYZ9gWDugd1KfWO7bmzQ/KGOgdx3ptaCjc6DXx7qWUS7cQeklZ34xQAxi//0tdTpLNPX
         ZObQ==
X-Gm-Message-State: AOJu0Ywe2Jw/CBgLQx+H3pPtIh3flxnlDIbZ4XhYqPJ98zIL5cyzElN5
	CpL6OeXLMWK6DB5RLX5dmH3iUAzYbNeb8xippVwpdUHIybVWlJd2LVyqgQ2P42EalYYY5ibHHa8
	RiWdqqNKOzFDAEMYYRLUUb8rfXw16QKpWGQqyujep18UxK7bnC4C2JS0m/r/bJPLv1Y3Cwj6Ohm
	F+JDL9BT/XE9waYU+nfxZMALfpEkXCcTHG5RRVGDPLW6GHuDheXfz85WyiOqW9zzJ3D4Tj4nWYU
	TCil3uvdbem1nFYHA==
X-Gm-Gg: ATEYQzy2YOWI+QbyXAqVvLMSbbsaxZ0JKQbas1g43Vde+xwSKUabUD66I93Yo+43q0a
	uLQYCOrP1mwOE3FH40H2yHfAF20isHBIUx4USvK4Ck6JYgGs8MnfMuChRX2nJvXKECdUEZaXxXv
	/D2Vtpb6KQPqmnoJoC+lQmetIE/3taiRUj+A4qfKPSf6njkb/eNyzeaB1bPkJnLTEHidM9dWnN+
	wH3UqpX6caTHmSD0UqUGJDGu6sa+aMLtADIqptYXl6Vqjs69q7adeChGZ7kuw/nBami+wXeg9tu
	S4YZgM43JBeKvEHRQbl60Lvv4sYMbmM0xrjtfEdlOtbPTu48DGuCWklI1vdcSKjhvrSiK/Q78ry
	dpB3560gpsLgE+Xqt/A1A6hs8t+mtbKBuKEUWtsG6KMy68dUVKg3jOZob/oPoIy+G1wv2Cy9H53
	tS+4s3R9JD/7AqSKhBKqez8hQwLP/KbeCd8szWpPI7PolYo6T9Teg2mlbuV9i4gvtCCQ==
X-Received: by 2002:a17:90b:4b10:b0:356:72f3:acaf with SMTP id 98e67ed59e1d1-358ae8dbc97mr7636767a91.32.1771864665794;
        Mon, 23 Feb 2026 08:37:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-358af8e2327sm1072440a91.4.2026.02.23.08.37.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:37:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ad7e454f38so187429355ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771864664; x=1772469464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXqcrYrUMpsk0hJeQOkUygfghc5Wbge/uByCmNLlVLs=;
        b=HbwLO5xNW1o6MbwmKV9qLsdZnuMJu4Un2dFmJcSHVldyro+2Y75aXPLSnb3TCRr9gL
         ANuGl/+AujIByV5fYAKl1h51CVW99OBZ8V7ByE5axaV3xvjgAyRGSsCyYA//2c3AY53V
         gzWR1YC8yba95PMR3ksI8YznFkkx60h6Gclzk=
X-Received: by 2002:a17:902:d502:b0:2a9:410:2413 with SMTP id d9443c01a7336-2ad7450552fmr95590005ad.29.1771864663905;
        Mon, 23 Feb 2026 08:37:43 -0800 (PST)
X-Received: by 2002:a17:902:d502:b0:2a9:410:2413 with SMTP id d9443c01a7336-2ad7450552fmr95589755ad.29.1771864663405;
        Mon, 23 Feb 2026 08:37:43 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3445fsm96763825ad.13.2026.02.23.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:37:43 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 4/7] bng_en: add support for link async events
Date: Mon, 23 Feb 2026 22:06:38 +0530
Message-ID: <20260223163641.755200-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260118-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8DD0617A230
X-Rspamd-Action: no action

Register for firmware asynchronous events, including link-status,
link-speed, and PHY configuration changes. Upon event reception,
re-query the PHY and update ethtool settings accordingly.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 17 ++++++-
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 47 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  4 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 19 ++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++--
 5 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 3e6a5bd45a0..43d5ba15728 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -15,6 +15,13 @@
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
 
+static const u16 bnge_async_events_arr[] = {
+	ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE,
+	ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE,
+	ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE,
+	ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE,
+};
+
 int bnge_hwrm_ver_get(struct bnge_dev *bd)
 {
 	u32 dev_caps_cfg, hwrm_ver, hwrm_spec_code;
@@ -166,10 +173,12 @@ int bnge_hwrm_fw_set_time(struct bnge_dev *bd)
 
 int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
 {
+	DECLARE_BITMAP(async_events_bmap, 256);
+	u32 *events = (u32 *)async_events_bmap;
 	struct hwrm_func_drv_rgtr_output *resp;
 	struct hwrm_func_drv_rgtr_input *req;
 	u32 flags;
-	int rc;
+	int rc, i;
 
 	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
 	if (rc)
@@ -190,6 +199,12 @@ int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
 	req->ver_min = cpu_to_le16(DRV_VER_MIN);
 	req->ver_upd = cpu_to_le16(DRV_VER_UPD);
 
+	memset(async_events_bmap, 0, sizeof(async_events_bmap));
+	for (i = 0; i < ARRAY_SIZE(bnge_async_events_arr); i++)
+		__set_bit(bnge_async_events_arr[i], async_events_bmap);
+	for (i = 0; i < ARRAY_SIZE(req->async_event_fwd); i++)
+		req->async_event_fwd[i] |= cpu_to_le32(events[i]);
+
 	resp = bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
 	if (!rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index f037229db7b..9f0f9b4db1d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -94,6 +94,21 @@ static void bnge_set_auto_speed(struct bnge_net *bn)
 	elink_info->advertising_pam4 = link_info->auto_pam4_link_speeds;
 }
 
+static u16 bnge_get_force_speed(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+
+	link_info = &bd->link_info;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2)
+		return link_info->force_link_speed2;
+	if (elink_info->req_signal_mode == BNGE_SIG_MODE_PAM4)
+		return link_info->force_pam4_link_speed;
+	return link_info->force_link_speed;
+}
+
 static void bnge_set_force_speed(struct bnge_net *bn)
 {
 	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
@@ -1262,3 +1277,35 @@ int bnge_set_link_ksettings(struct net_device *dev,
 
 	return rc;
 }
+
+void bnge_link_async_event_process(struct bnge_net *bn,
+				   u16 event_id, u32 evt_data)
+{
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE: {
+		struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+
+		/* print unsupported speed warning in forced speed mode only */
+		if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED) &&
+		    (evt_data & BNGE_SPEED_CFG_CHANGE_SP_NOT_SUPP)) {
+			u16 fw_speed = bnge_get_force_speed(bn);
+			u32 speed = bnge_fw_to_ethtool_speed(fw_speed);
+
+			if (speed != SPEED_UNKNOWN)
+				netdev_warn(bn->netdev, "Link speed %d no longer supported\n",
+					    speed);
+		}
+		set_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT, &bn->sp_event);
+		fallthrough;
+	}
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE:
+		set_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT, &bn->sp_event);
+		fallthrough;
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
+		set_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
index 12be5cab579..bdcb75a941c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -197,4 +197,8 @@ int bnge_set_link_ksettings(struct net_device *dev,
 int bnge_get_link_ksettings(struct net_device *dev,
 			    struct ethtool_link_ksettings *lk_ksettings);
 u32 bnge_get_link(struct net_device *dev);
+#define BNGE_SPEED_CFG_CHANGE_SP_NOT_SUPP	BIT(17)
+
+void bnge_link_async_event_process(struct bnge_net *bn,
+				   u16 event_id, u32 evt_data);
 #endif /* _BNGE_LINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 2ad0021d38e..4909727547e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -164,6 +164,25 @@ static void bnge_sp_task(struct work_struct *work)
 		}
 	}
 
+	if (test_and_clear_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event)) {
+		int rc;
+
+		mutex_lock(&bd->link_lock);
+		if (test_and_clear_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT,
+				       &bn->sp_event))
+			bnge_hwrm_phy_qcaps(bd);
+
+		rc = bnge_update_link(bn, true);
+		if (rc)
+			netdev_err(bn->netdev, "SP task cannot update link (rc: %d)\n",
+				   rc);
+
+		if (test_and_clear_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT,
+				       &bn->sp_event))
+			bnge_init_ethtool_link_settings(bn);
+		mutex_unlock(&bd->link_lock);
+	}
+
 	/* Ensure all sp_task work is done before clearing the state */
 	smp_mb__before_atomic();
 	clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index a2616f03755..88f9cf1db30 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1128,6 +1128,29 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 	}
 }
 
+static void bnge_async_event_process(struct bnge_net *bn,
+				     struct hwrm_async_event_cmpl *cmpl)
+{
+	u16 event_id = le16_to_cpu(cmpl->event_id);
+	u32 data1 = le32_to_cpu(cmpl->event_data1);
+	u32 data2 = le32_to_cpu(cmpl->event_data2);
+
+	netdev_dbg(bn->netdev, "hwrm event 0x%x {0x%x, 0x%x}\n",
+		   event_id, data1, data2);
+
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
+		bnge_link_async_event_process(bn, event_id, data1);
+		break;
+	default:
+		return;
+	}
+	__bnge_queue_sp_work(bn);
+}
+
 static void
 bnge_hwrm_update_token(struct bnge_dev *bd, u16 seq_id,
 		       enum bnge_hwrm_wait_state state)
@@ -1146,7 +1169,7 @@ bnge_hwrm_update_token(struct bnge_dev *bd, u16 seq_id,
 	dev_err(bd->dev, "Invalid hwrm seq id %d\n", seq_id);
 }
 
-static int bnge_hwrm_handler(struct bnge_dev *bd, struct tx_cmp *txcmp)
+static int bnge_hwrm_handler(struct bnge_net *bn, struct tx_cmp *txcmp)
 {
 	struct hwrm_cmpl *h_cmpl = (struct hwrm_cmpl *)txcmp;
 	u16 cmpl_type = TX_CMP_TYPE(txcmp), seq_id;
@@ -1154,10 +1177,14 @@ static int bnge_hwrm_handler(struct bnge_dev *bd, struct tx_cmp *txcmp)
 	switch (cmpl_type) {
 	case CMPL_BASE_TYPE_HWRM_DONE:
 		seq_id = le16_to_cpu(h_cmpl->sequence_id);
-		bnge_hwrm_update_token(bd, seq_id, BNGE_HWRM_COMPLETE);
+		bnge_hwrm_update_token(bn->bd, seq_id, BNGE_HWRM_COMPLETE);
 		break;
 
 	case CMPL_BASE_TYPE_HWRM_ASYNC_EVENT:
+		bnge_async_event_process(bn,
+					 (struct hwrm_async_event_cmpl *)txcmp);
+		break;
+
 	default:
 		break;
 	}
@@ -1235,7 +1262,7 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
 				    cmp_type == CMPL_BA_TY_HWRM_ASY_EVT)) {
-			bnge_hwrm_handler(bn->bd, txcmp);
+			bnge_hwrm_handler(bn, txcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
@@ -1355,7 +1382,7 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 						      budget - work_done);
 			nqr->has_more_work |= cpr->has_more_work;
 		} else {
-			bnge_hwrm_handler(bn->bd, (struct tx_cmp *)nqcmp);
+			bnge_hwrm_handler(bn, (struct tx_cmp *)nqcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-- 
2.47.3


