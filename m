Return-Path: <netdev+bounces-278506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHBlDhlf3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:36:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D73FBF79
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61F0A3084DE0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093E3EBF0F;
	Tue, 14 Apr 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE2M1ma0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A73EC2DD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180782; cv=none; b=MwT9PtPcY+XGO6bCsJTkZi6g6oO8fUzgauQDYKJ5bTdjJvNYtUXgyGeehXPYL6s6bqEFdVNnyVlsCgPOGyvFB0RhODbDtMrgOI+KIvtjSHMEiaqG2YDteLImDnA03QfY6WMoxzIdLPX4QNU2OhMUTuw9tJiK1ItPju6dW4R6dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180782; c=relaxed/simple;
	bh=cW1b161WL6TconDoEkhqZhBsnMI3QiEWMBYCnXK/k3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX+rluQJwjvrWR5weiYP3MfhTT+rnYLWPWVTNEAiGsfnQNO7wbj5868LMeQBooZaNp+zRdNuCZrTK0aYAJ3DTCQWbEppcuL2orHpR8iwhUJA6YzmwkMKd0YgvGY1UvcmZMKykaV9ozqE74PWHke9CBAlLNy27fZ24C4qNpdlda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE2M1ma0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso945871a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776180780; x=1776785580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmddVIQ8wGr99frrCwHRglOUUCwkkGiShQ/ZLd77AU0=;
        b=RE2M1ma0oFgjTBF3O9GsMuyqCBCOF3KpTwlruQHf3tVUqFXa6eRt6hWUByU90lU0uH
         4W5K5H2RwGb4Yz4iHliIv0T1r3dXR7CcEN++EYsylO4PZR9+QN2CYSUUzD8gH2U/RPy1
         HiFG5amO2RKwBtiFp7I2eXK3m7g9JMHDzNK3Pz3Pq8k/Ip1/47AmaSLMutXVFj0BpoM5
         +0KdszudbNdjfh7yIVT2A63Z8wJxhmO3ZewFZHx6/S7XY1CV5d/rQB/yjhlcecxkRGMM
         /nkge1e/R8Uryqcxg+R2u0g5NE3Ykb0dscxW30aiHOGS4GzAul0YAD0nv15pf++vxwKB
         GIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180780; x=1776785580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmddVIQ8wGr99frrCwHRglOUUCwkkGiShQ/ZLd77AU0=;
        b=dJdJXxvQ8xsqCwKU9Oc19CmM3GGQ8RWBPCVjwfgUhzxnLNiDbjm3K/ifz/aoBkRvb3
         qTshUHAfXdyiQ707RCfGIYbs8dMmVGv5wjcsimblL3D2j1yED3Qy8W+rmX1xE7o348jy
         2zB7RAla4UH84dmi9OjbzIlFxX9V7rokkiesLfR40TNdp4a56tLauQBUEd9C7YDNh9CZ
         xm1yBZ0oUn5lMPcs7yhrOc+3mO7bHpxfLv8d4gv0asKSDugv+QOM0/JOqm5lMUEF/NWb
         tloKWFQSDBopydmScKvjDhKUFeSBN4FmgxDitG1lkaTTN9O0uvzZilp90gjLWjenBH3A
         24Rg==
X-Forwarded-Encrypted: i=1; AFNElJ99gIX/HNaAZU06tAnqcZ08PvOT9FzjWmM/2HYsfeUtTlAeCpsT9dI82x6u+3ySofGI82a4AA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89UbSXNIBd6HZD0zcvbSoR4ExZKgQ93folfDrWtDTFN3/QtVU
	IjkFQ1sRbSohHEgtkkMuVX6jg+Szy4XqOwrmUclooUgXYVa4SFD/zfhT
X-Gm-Gg: AeBDiesJOQlvJ6WEfoUiqbgXY9td01066ctEWfjU7Z0L6hRc4qGilP1cvzHGgiiTi4P
	pCmi+FOEMBMRNOOIeWgEh6eOOBuzGyyVur3y060ztkflZgunAjTIuNROPHxAisFVJ7Nv8SeAMRR
	CpVA9gU9dl2mLGZzAP04+pP+euJEQo3Fgq5UztjREJvbta8tQVG4tUCAMifUidNW3E/SKBv2G59
	Yird7Pc/b5NLZ386ybpCvnz5sENac2p8ESATxo638PvzCLmzc69HbhGtxaap0LQ8pCT1/5BZgo2
	fUZn8cmA5xcz3NlLoi0qcRkC+hREj9bRN6SwiEuPHCkzX8Xt6tgqz567Pu0pU/7ftwuFI1kDm+C
	6bMxbud2WCCYP+la+7KzJ1mD+xs/QQjG9PSaX6jjSJIObp4tDsd3crF+cIsprUIVtuxIVY+e2xC
	VuLNKjxDRRz1/kf0pkt8vk+p4YxwE=
X-Received: by 2002:a17:90b:4b8d:b0:35b:94db:fdaf with SMTP id 98e67ed59e1d1-35e44297be3mr10689923a91.4.1776180779704;
        Tue, 14 Apr 2026 08:32:59 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fcdeb2c59sm68388a91.4.2026.04.14.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:32:59 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: pabeni@redhat.com
Cc: w@1wt.eu,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Tue, 14 Apr 2026 11:31:56 -0400
Message-ID: <20260414153201.1633720-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad4-bTbjtxbUXDU9@1wt.eu>
References: <ad4-bTbjtxbUXDU9@1wt.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[1wt.eu,intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278506-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E88D73FBF79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a struct_size() check after extracting port_count and before the loop.
Pass msg_len to t7xx_port_enum_msg_handler() and use it to validate
the message size before accessing port_msg->data[].
Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the captured rt_feature->data_len at the handshake path.

Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
Cc: stable@vger.kernel.org
Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 14 +++++++-------
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 12 +++++++++---
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 7968e208d..d0559fe16 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -453,25 +453,25 @@ static int t7xx_parse_host_rt_data(struct t7xx_fsm_ctl *ctl, struct t7xx_sys_inf
 {
 	enum mtk_feature_support_type ft_spt_st, ft_spt_cfg;
 	struct mtk_runtime_feature *rt_feature;
+	size_t feat_data_len;
 	int i, offset;
 
 	offset = sizeof(struct feature_query);
 	for (i = 0; i < FEATURE_COUNT && offset < data_length; i++) {
 		rt_feature = data + offset;
-		offset += sizeof(*rt_feature) + le32_to_cpu(rt_feature->data_len);
-
+		feat_data_len = le32_to_cpu(rt_feature->data_len);
+		offset += sizeof(*rt_feature) + feat_data_len;
 		ft_spt_cfg = FIELD_GET(FEATURE_MSK, core->feature_set[i]);
 		if (ft_spt_cfg != MTK_FEATURE_MUST_BE_SUPPORTED)
 			continue;
-
 		ft_spt_st = FIELD_GET(FEATURE_MSK, rt_feature->support_info);
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
-
-		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
+		}
 	}
-
 	return 0;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index ae632ef96..d984a688d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -124,7 +124,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
  * * 0		- Success.
  * * -EFAULT	- Message check failure.
  */
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)
 {
 	struct device *dev = &md->t7xx_dev->pdev->dev;
 	unsigned int version, port_count, i;
@@ -141,6 +141,13 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
 	}
 
 	port_count = FIELD_GET(PORT_MSG_PRT_CNT, le32_to_cpu(port_msg->info));
+
+	if (msg_len < struct_size(port_msg, data, port_count)) {
+		dev_err(dev, "Port enum msg too short: need %zu, have %zu\n",
+			struct_size(port_msg, data, port_count), msg_len);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < port_count; i++) {
 		u32 port_info = le32_to_cpu(port_msg->data[i]);
 		unsigned int ch_id;
@@ -154,7 +161,6 @@ int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
 
 	return 0;
 }
-
 static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
@@ -191,7 +197,7 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 
 	case CTL_ID_PORT_ENUM:
 		skb_pull(skb, sizeof(*ctrl_msg_h));
-		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data);
+		ret = t7xx_port_enum_msg_handler(ctl->md, (struct port_msg *)skb->data, skb->len);
 		if (!ret)
 			ret = port_ctl_send_msg_to_md(port, CTL_ID_PORT_ENUM, 0);
 		else
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index f0918b36e..7c3190bf0 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -103,7 +103,7 @@ void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
 void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state);
-int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg);
+int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len);
 int t7xx_port_proxy_chl_enable_disable(struct port_proxy *port_prox, unsigned int ch_id,
 				       bool en_flag);
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id);
-- 
2.53.0


