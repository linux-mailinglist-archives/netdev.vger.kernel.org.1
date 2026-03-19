Return-Path: <netdev+bounces-269307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDQ3E/SPu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:56:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 964392C6615
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3530A31A209C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA62314D0B;
	Thu, 19 Mar 2026 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hv0Efmlo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB12DCF52
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899570; cv=none; b=Zdr7l7Wf8vYuNUzwaT5IcBrFpD7zZGi5ep28oWf66DfFsRqpK8tAa0IY6mF9sntQyzOWYgMhv7rKvAG8XnGPm9vGNR/0HhC5xQClrVUJbI1RaAoVQtz2Br0nu2cxN+wa5rUsCKxeTxQ4nDrykFZk/ZxTmmcJBqqxuyHyOQHdx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899570; c=relaxed/simple;
	bh=5q3LLdThLJcUefA8Xuh1O5R7wfiiqqxIiJlFBLi6Ez4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCmkU1kbjfKJGzpUpHo0lVyK4nbLoO5Vff24hEI+vFKtxFgHoEWP8TYLskcjKb6ZWbh0P0j+J57aUA+WFfzl9yPKyIks83gVlGkIgKZoI9TjUNY8MEDGPoKVNzk35PvCGqUDsKFHBF8o6O1TLT0SfkoQIRiXqEN9OTawbJw2Zs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hv0Efmlo; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64ad8435f46so873741d50.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899567; x=1774504367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83WaAUqVbcTeAKRqYyPrzzE/KyYoTYZTFZXmMYL7wNs=;
        b=Ow77h3mTempeDGGpSJwuUXHczTtKRgyJS5JIeYoIlifNNkJ03NuTGX0j23VlZKmti4
         IEjqAYwarzaaRQO6F9nz2yud+68vivpoChifZ/h/Ib24YQgovBhRDDMsThXRleROvF/l
         zMoG9rEUaZm5gCWNB3JglMl6lqXx7eMQw9g/aD9eEuuRjCvoFEPGh793B/88tC1MoNM2
         fUmaVuGL/AJogx0C0erw0R4eHTQHRn6C9K/THD7zVyAdSx+zBBX/Uw4LetL6+pExCWDU
         E6faD7yoAUQuqSzTTEQqAU2xCID7UnzQgxaqLCAd7Xv3Rb41G4RvoQohl4fxKVlsnBiO
         6w4w==
X-Gm-Message-State: AOJu0YzuT181AYBdK1OgsPHYDZ31PFVLdc5PozUSqttLHeNNiJstvl9d
	1G/RRGyqM2WxEoj6NcGx3b1uPsqHYiU7ufoEuKoFKz1svfnkmF1w/ZW4IMLFE3w6AqOJKdPgGWW
	jSNKi6wLg/mhRR5D8g4ic5X9FbLOq11XvFVjVGQ2jF2bqk+agbkrKr65HNOZQxpU72kclCDRvhU
	L+ApjtDq5jvqwEdRHZjV5rHfkAAFHJJgaoM20t1wEucFbGvUBexgUT5ISswBtM0wZxFDrM7dyGj
	1sURQTbfg==
X-Gm-Gg: ATEYQzzNF5L74MKhTUNS9IwYFNnH43VfnoQAplpSqKeSqOk/7cE+3ArORVhXGp1bvhB
	h0Xy9GvWc3uO+/l0QQU4kOcz0YwAwGHOprxr2ZpNU0Pb/uyedt0OFxYmf5imuZtpESBXR4rBskq
	1jrMSBifB9W/qih2p3SItbw2N09rIAceousk0ULbIL7n8i2cFN9hbDvtoF1wSXYgInhjBedsSGg
	npO9ERwdI/rqMGJzAufq3Pu2lLroEgWN5mesqv3zyPwJW8N3ZWzSDxCOCKg05UPGBaOJl3dequn
	zKpffHuWkkSzwC/F1bseWqojI/m1AtMk3kNCSjHqPcrWBLWE29uHZf+EIps27WPlMBfhAV29QC+
	UHZqITDULwZTuBxXoIxOcqoHbVXwUL4cbVokh7x4G+CrSlYONHu3IYjHj/s6hmNljAdpiRqK7pZ
	gdGsL7R7rm6MLNSxk5BzbMR24LOHcv3ichDI2k5ee7q+G4X5exIljXymY=
X-Received: by 2002:a05:690c:c14a:b0:79a:54a9:6cdf with SMTP id 00721157ae682-79a71ca6f3cmr52451167b3.60.1773899567060;
        Wed, 18 Mar 2026 22:52:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79a713d76d0sm4458367b3.7.2026.03.18.22.52.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:52:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64c9a6d733cso1198935d50.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899566; x=1774504366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83WaAUqVbcTeAKRqYyPrzzE/KyYoTYZTFZXmMYL7wNs=;
        b=Hv0EfmloZW2hnRO3tam5EJL0E3Ha3N2Oakbe/5/A4zEeKkppEgV1UE0mYwvESP/rsw
         sLfctCpTcKklZhodWSL2OikthzoRR6E3Dfocff+6XWQpdnaVy74ENPT2xya1SnsN4EIV
         UB/4wcmj9+EeM2DHMR29hlI+4ciNiBPI0k6js=
X-Received: by 2002:a05:690e:1209:b0:64e:9f7f:1c1b with SMTP id 956f58d0204a3-64e9f7f2000mr1303275d50.19.1773899566173;
        Wed, 18 Mar 2026 22:52:46 -0700 (PDT)
X-Received: by 2002:a05:690e:1209:b0:64e:9f7f:1c1b with SMTP id 956f58d0204a3-64e9f7f2000mr1303256d50.19.1773899565687;
        Wed, 18 Mar 2026 22:52:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:52:45 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v8 05/10] bng_en: add support for link async events
Date: Thu, 19 Mar 2026 11:21:19 +0530
Message-ID: <20260319055124.1350670-6-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269307-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 964392C6615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Register for firmware asynchronous events, including link-status,
link-speed, and PHY configuration changes. Upon event reception,
re-query the PHY and update ethtool settings accordingly.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 17 ++++++-
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 47 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  4 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 17 +++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++--
 5 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 1cc62883d3c7..07ba66e3d3de 100644
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
index 03beb5593069..99fc8fda1623 100644
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
@@ -1254,3 +1269,35 @@ int bnge_set_link_ksettings(struct net_device *dev,
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
index 70d0901b9a32..cadc26cfbcf5 100644
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
index 29c703f3c9a1..af69d4d8bafb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -156,6 +156,23 @@ static void bnge_sp_task(struct work_struct *work)
 		}
 	}
 
+	if (test_and_clear_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event)) {
+		int rc;
+
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
+	}
+
 	netdev_unlock(bn->netdev);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index a2616f037557..88f9cf1db308 100644
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
2.47.1


