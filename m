Return-Path: <netdev+bounces-274924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBFvDjlvz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A56CD391CF3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 193B230AE92B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B6378D8E;
	Fri,  3 Apr 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gomX4v5H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7311361DA8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201916; cv=none; b=la8wDXmcFcHCIgRT3s1nhImFXDeTVo0XwOM/i4i+CGiVTgSlRws6zMW1O1BdjqJaX7R1Yl+QcmKev/EXCAv1cyX9Pxkm+WH2+DagVd9FYMa7YF+pYokgmysnzaIh6y6Qlg6vZwk4Dz2olqQEFtndIL1nTrEtgUnV2wVOdoDpTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201916; c=relaxed/simple;
	bh=EjYjgwiOnKLxziRX51q2OxgLzh+hWJgbZkGWEZLOJ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdKmRAyayMscPfXjrNQtmZ8IkZqbb1jrPo1rbW4pzDgEdA4NkFjzcSnNrrKl88qZOWYTuM9rHRFYeCRCZ4//iwUgiBf0+D40ha2U3mdsFDyYZeWRFPjosAaVIOMey7sK78J+ABPU4TNHSxsmxggFEUYyKVJdQu+/WHMXvv0zDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gomX4v5H; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35d95017a68so895937a91.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201914; x=1775806714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZC3ac4115lsgagZnqjuv2Trln6vcbIo8SxQmTDzf28=;
        b=AM6IHUfAxALs7Od/chUjco6WM/Ht7CX8F2KHz1UecrVQqLicQlyJ80zk660FLhBbcE
         R+rGwKV/qjKNuGyPsBoWHuIgGWFKZel7W8rP+QLG+w/TY5WJfgFcsbi8/7/sM9Dw5bbu
         feKGSCkH1bvSmAdEapGR/DmDoTI+0I14fgdzGzfK0DEe0J9aXo7v6fQXoycOM9xvwXas
         Kujeui3IE64qI2kM6bsTYjlMCpcIQ/CFYscN8E8TXiMx6JUGgzy0w4pl450KkG3Hbn6B
         sR3aUl80UVr8DmDusJVWVveEJvvQM13j0Ih2IhjEOJpkp5e+TD8HjltwDtHHhXOW4G/+
         m1lQ==
X-Gm-Message-State: AOJu0YwqcEy7XnnPr1hFPuVuk9h/OglciShkSR4y0LGk7bLedLeC2kGG
	lUKGd3UC0xgQlO5RcpIFAWqiRmyYoNjMDrrKll1pBAyc0sdTnIxn02I8ygFAOYb9WXz5Md1AqOh
	24lMN15CLSOchWgDUM0L8ks9ofS5GE5rxkG8DrB+QyVdr4tzswLYSIZDH7eowcHwsOhr3UDQ0ij
	g05AvOF0Fa7WB/0fo/Bvi7AVfMEfKgI9T6r4AtL6jC6+IsAeJxOghAyOhji725IUAbohcjHT6r3
	O2LM4IOMcphtD3L8w==
X-Gm-Gg: AeBDievG+HOBTs2H/5NYHgl+hMw8xJYyfASXJIeXIV63G1PJfAfRm4pPvAGv2K0GVDX
	sDOuQNguadnsh7nXYD5n43u++VRhJHqgh7+jgnCFR9bt+BJIk90pBnqn+Z7gYJZo1r0zAZLZe7V
	0Yr6l6qd/BVaSs8yEnNY8uzFSWw6tRb+SGCjOQBHf79ribiDpM6nBzCS/tToCbqf73Fw1I0MUvT
	T9fdkPsmG3b4r/7CA2RSEAePSIOz3NzezyEiboFjn8uBPVUQO+PVxCfTlyeK47mb8/RTQkdyFOA
	JlmbQ3zVxpXhtrhNZlmPj+fS0I3eL8fJGh9PoV/4cjYTohCYOK6tTYdjs+jQonXIWN2AbEEV/bW
	cMI6/XpFfJCiLYBCa0C8YdmWvqz4ZSCr7ebSe2e0ffYbLFY3qiAchTmmpiqqMDwPWHh0pO0yLFF
	6QxgG9uu4qa6dzLRMW6KEAXT28HbQqQs+aA33rmP4HKTm/KENlAxo8J8aKSyDg0I8=
X-Received: by 2002:a17:90b:3952:b0:35b:a9f3:62ee with SMTP id 98e67ed59e1d1-35de69d6c96mr1815489a91.27.1775201914136;
        Fri, 03 Apr 2026 00:38:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35de7caa2b2sm57667a91.1.2026.04.03.00.38.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1987201a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201912; x=1775806712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZC3ac4115lsgagZnqjuv2Trln6vcbIo8SxQmTDzf28=;
        b=gomX4v5HTqOWe31GrkDVXcOup8DgDbuhcs2d+iBq4W8XyX0vn3YfucB9bAXg13BIR5
         1cAW5GYZNsmfrrNXCTcLUiv8u5Y8Rjye0+junYIk5KnOlahHFXQbOMOUlaZgm2XtZhkk
         T2aX2cFklXBKgP5svxuuLa1RK1m7D59QCA9ZM=
X-Received: by 2002:a17:90b:3f4d:b0:35d:93ff:2859 with SMTP id 98e67ed59e1d1-35de69a6469mr1963271a91.22.1775201912381;
        Fri, 03 Apr 2026 00:38:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4d:b0:35d:93ff:2859 with SMTP id 98e67ed59e1d1-35de69a6469mr1963256a91.22.1775201911985;
        Fri, 03 Apr 2026 00:38:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:31 -0700 (PDT)
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
Subject: [PATCH net-next v11 05/10] bng_en: add support for link async events
Date: Fri,  3 Apr 2026 13:07:19 +0530
Message-ID: <20260403073724.194360-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A56CD391CF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register for firmware asynchronous events, including link-status,
link-speed, and PHY configuration changes. Upon event reception,
re-query the PHY and update ethtool settings accordingly.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 19 +++++++++-
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 18 ++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 23 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++++++---
 5 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index acb712ddbd7e..de51add96ac3 100644
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
 	struct hwrm_func_drv_rgtr_output *resp;
 	struct hwrm_func_drv_rgtr_input *req;
+	u32 events[8];
 	u32 flags;
-	int rc;
+	int rc, i;
 
 	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
 	if (rc)
@@ -190,6 +199,14 @@ int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
 	req->ver_min = cpu_to_le16(DRV_VER_MIN);
 	req->ver_upd = cpu_to_le16(DRV_VER_UPD);
 
+	memset(async_events_bmap, 0, sizeof(async_events_bmap));
+	for (i = 0; i < ARRAY_SIZE(bnge_async_events_arr); i++)
+		__set_bit(bnge_async_events_arr[i], async_events_bmap);
+
+	bitmap_to_arr32(events, async_events_bmap, 256);
+	for (i = 0; i < ARRAY_SIZE(req->async_event_fwd); i++)
+		req->async_event_fwd[i] |= cpu_to_le32(events[i]);
+
 	resp = bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
 	if (!rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
index 7751bf07740f..9633f5b1b2f0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -1293,3 +1293,21 @@ int bnge_set_link_ksettings(struct net_device *dev,
 set_setting_exit:
 	return rc;
 }
+
+void bnge_link_async_event_process(struct bnge_net *bn, u16 event_id)
+{
+	switch (event_id) {
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE:
+		set_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT, &bn->sp_event);
+		break;
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE:
+	case ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE:
+		set_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT, &bn->sp_event);
+		break;
+	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE:
+		set_bit(BNGE_LINK_CHNG_SP_EVENT, &bn->sp_event);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
index 70d0901b9a32..d498d1d11a5b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_link.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -197,4 +197,5 @@ int bnge_set_link_ksettings(struct net_device *dev,
 int bnge_get_link_ksettings(struct net_device *dev,
 			    struct ethtool_link_ksettings *lk_ksettings);
 u32 bnge_get_link(struct net_device *dev);
+void bnge_link_async_event_process(struct bnge_net *bn, u16 event_id);
 #endif /* _BNGE_LINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 185f5bfce1d5..90458b323120 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -136,6 +136,7 @@ static void bnge_timer(struct timer_list *t)
 static void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
+	bool speed_chng, cfg_chng, link_chng;
 	struct bnge_dev *bd = bn->bd;
 
 	netdev_lock(bn->netdev);
@@ -156,6 +157,28 @@ static void bnge_sp_task(struct work_struct *work)
 		}
 	}
 
+	speed_chng = test_and_clear_bit(BNGE_LINK_SPEED_CHNG_SP_EVENT,
+					&bn->sp_event);
+	cfg_chng = test_and_clear_bit(BNGE_LINK_CFG_CHANGE_SP_EVENT,
+				      &bn->sp_event);
+	link_chng = test_and_clear_bit(BNGE_LINK_CHNG_SP_EVENT,
+				       &bn->sp_event);
+
+	if (speed_chng || cfg_chng || link_chng) {
+		int rc;
+
+		if (speed_chng)
+			bnge_hwrm_phy_qcaps(bd);
+
+		rc = bnge_update_link(bn, true);
+		if (rc)
+			netdev_err(bn->netdev, "SP task cannot update link (rc: %d)\n",
+				   rc);
+
+		if (speed_chng || cfg_chng)
+			bnge_init_ethtool_link_settings(bn);
+	}
+
 	netdev_unlock(bn->netdev);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index a2616f037557..7d45e057f2e8 100644
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
+		bnge_link_async_event_process(bn, event_id);
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


