Return-Path: <netdev+bounces-262096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMHFF+6ZomlI4QQAu9opvQ
	(envelope-from <netdev+bounces-262096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:31:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A391C10A4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D4A317365F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9588836CDE4;
	Sat, 28 Feb 2026 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="auROnsco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19B36D4EE
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263701; cv=none; b=ToLQEYd1Zp1mjho5bwdlBkZutIlgGOHUwXKAjgKUlee3QWElzYR5LuQi8S7LCuut/VF3svFPWoDE9pClAskx6id8TZ9Icj92k9VmRNb6mt2NWbOld9RE2g+4HmpLc4mlLGzZGoXOjJNLO5HvdxJz3GgzGhRxEsBMl9rYRcomsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263701; c=relaxed/simple;
	bh=Cl80ZKXJBoDO8UxgzTglGvyYTX/zRYeOyfc1Tlsmw10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4HX7v9EKHsMo9ivubozkeOTQtI5zRYnqkA+Q2zXK7ViNOWRNx0EywUqctXOlOk+0ARwqWgoANB2xwWqagTuGwHBdwMo8/Xb+LVWxWk+Hw2Pz9LYJZLVW9MFPus9DIecthNqeIvqzBCaY6Ykt0DvBiHCtxPi6cTTwZyV/eY9k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=auROnsco; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2adc1d9ec56so19524465ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263699; x=1772868499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzqBWSezK0CyMjZJkl/71WrGqqwvvdRJlXXuEWKLGA0=;
        b=HQKX1/VIUTQW4g8Wldh61yVrERF0N+4IQMamDJnq1PnVs3eHJTXY5+8m8J8HFDozpt
         XcXAovVfklexmpjvOcGzj8EmSR89GLM0cnFlsgkhT/ZXOOdBIShV+I+0gaQTJ54dm5Qv
         6E5udek+iXbtUF2VI6bR5lHki6s/WqFpIORo8ZtSDcdcTfhsQWjsRrmNv+puO6Wdf80C
         +Fi0XsfE2SNLZwW3ejqDeQSBn1XvTiUYW/npFSycPK1CVZWDVGFDxzQLTjwMgMTLYgSo
         tbEULdaa8BQid1/vPRMbk9gSGDyKUhEYOxa+9On5/SrU6G5XZFr3GkuN8lL2kEvxWYyp
         oCAA==
X-Gm-Message-State: AOJu0YysoJGhEIoOXUXA89npB455WPEEMi/KfGhhYn07xft6dtke42QS
	z8UfVJO0amLPAdL6XfAt+su3ukGfw6cyV87Fgi2jZHk1MeMPCkXNoOsekznvHRVmpKxG9enPKcP
	z+t76SYNio8P0qbGvJFKb3V44y2Z7ZgCZZUj/CrZ6Z9w1DyrZyHOm6Pm1nvEh5h2snA1VCigwEp
	b8lbHTTV8Xl5Hp4XgFprbiVDBh/cGQe6NxBVlEi7g46s5yScsrt9fwaP8knheMz13lFaWLOtvC9
	RYfksHx71cyGe+t6Q==
X-Gm-Gg: ATEYQzx97DhCQphQLAhXu+90r+7hpfXv7BtibNPrpXQ9EXPjCceA12OdQKN2dmflpBJ
	EpEGsxNATW2vc0YYWRMtsSht4S5LfLjoi7taL/tQ+DGZKkYcCXoD6AUKhMNdF1CrrejHwZQOxpz
	EsIqQiNOk/ETulR+7fVidfWiujjyxi3cokMHAsYMW9Nsb41h/1dVkWWElU5imkYWGq4PxqogijJ
	kinqmTno/aaYZMfUOOilkRlMs1soTal15VNI04vdQwgpXjJMnUCVBJVApxT/tuFYMT6eory8YSo
	o5+o3A87XDiUkUUe86+MltJbMF8XYmxtvoiUSbeFsm33ywqg2Dzbgva0AUE+oYLlghZJTmakqt2
	xLDPfR4+WbcCo17+dWuXfTChJhf3gjcR0GDmzr5zl4wCd/QsvZaQ10jJGzxeCIdaK6TVqu/smh5
	6ReV6v87+av2XiKZNtKgWVI2DjqCeYvu6OfpYnyCR75r7n2/1Zt0PsCovkMpjQsqUhSw==
X-Received: by 2002:a17:903:2f8b:b0:2aa:e3da:52b5 with SMTP id d9443c01a7336-2ae2e3edc01mr55896605ad.9.1772263698558;
        Fri, 27 Feb 2026 23:28:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5dbaddsm8888795ad.28.2026.02.27.23.28.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 23:28:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-827448e844eso1433436b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772263697; x=1772868497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzqBWSezK0CyMjZJkl/71WrGqqwvvdRJlXXuEWKLGA0=;
        b=auROnsco1QuIM+p0fM04PUNnbJxT49kB0Ql35LG5/l7tfF+zNS6ReU01WlJrZh5Epa
         vahMm3rf4+4GMBD6Fb1bSuBzAD4FZTJd8SK21wDfpJZncZoA8uwBo7Z+GjHS8CEYp7jd
         GQSLN78QS9OBqswcVh7YiUoZHCJvZ5a85TsVE=
X-Received: by 2002:a05:6a00:1bc5:b0:827:28db:7a78 with SMTP id d2e1a72fcca58-8274d952a2dmr5889324b3a.17.1772263697041;
        Fri, 27 Feb 2026 23:28:17 -0800 (PST)
X-Received: by 2002:a05:6a00:1bc5:b0:827:28db:7a78 with SMTP id d2e1a72fcca58-8274d952a2dmr5889303b3a.17.1772263696518;
        Fri, 27 Feb 2026 23:28:16 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm6809267b3a.36.2026.02.27.23.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:28:16 -0800 (PST)
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
Subject: [PATCH net-next v3 5/8] bng_en: add support for link async events
Date: Sat, 28 Feb 2026 12:57:12 +0530
Message-ID: <20260228072715.1632280-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
References: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 98A391C10A4
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
index c734af6cfce..8678af3e749 100644
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
index c2b3511fc91..edde455dc85 100644
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
@@ -1255,3 +1270,35 @@ int bnge_set_link_ksettings(struct net_device *dev,
 set_setting_exit:
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
index 1c36f7dd02f..e02c0ef03e4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -160,6 +160,25 @@ static void bnge_sp_task(struct work_struct *work)
 		}
 	}
 
+	if (test_and_clear_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event)) {
+		int rc;
+
+		netdev_lock(bn->netdev);
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
+		netdev_unlock(bn->netdev);
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


