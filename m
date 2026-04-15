Return-Path: <netdev+bounces-278719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJRBLyVR32nLRgAAu9opvQ
	(envelope-from <netdev+bounces-278719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:49:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A10740223F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49255302D759
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406D33D47BA;
	Wed, 15 Apr 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSjKUm7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9D3D47AA
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242977; cv=none; b=TZIUDqUolx/fFqcPWJ181OzphOlVJDZoyDt9px6fYQbih6Cdvsf0kBjrGO0AHbi/qP7q6tUKyed+nn2rSCgMCewLjV2wrhfVkbIGcs5Hwta5Y4lIrjvtkDDzpKSHTNggqgite5rL47AjCw+QSam75h2/MCHIVCyEZCgX78cNnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242977; c=relaxed/simple;
	bh=MnPayftqVi09a3drMg0t4qocs6aUdLqOEGb/ORTQOB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scukZHh2eNoCbjZEx9i5ObB78f/ApxQexHpuUlO1DXiGAaQt2fQCD+v/1f8pmcOayxFzuh0DduD9wzyOxokqBZCUI235F2vlsfc0n/9WnBLOjU1Yyrmr/zm/wc0yRGPQjhKicwT2VHyuQykgyoCDASP58F3bo24tuBZ3zbvCIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSjKUm7d; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a3e79fe2b8so4420725ad.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242974; x=1776847774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBagG6nPdWPH/FpnMTW4SeLjEl1Kaw67bUgUq4EnXws=;
        b=eSjKUm7dsGebnmPXytVIxQwt/PXAmeoo9EViyJJzaR4zi0CDjGKU/jQf4KH2cBF3yZ
         mmJpzT0mNk1HTEJ0Oesm4yVUnxY2Y03DkGWGwwf6CVW/FiHGcHyfc5urtVEIgi5xw1lG
         Jx8Y17wLENmfA81zVJRIKGeVrzQ0wE5HApOBBjErXklhTtoeAUXltoiz4FNsAhKCfFPk
         yJm+3wvvVLArGoplxxf75ntiFB+MCCLm2ZVRzHFM46+svKuGIdmeFqqVvAf2GeFWbPMI
         J64rMU2v9lFs11wBGI/6B+8w20qXXkT9x7WfsUV/lomfd5ttke3lD9QZ8AvS1W9P7iB6
         c+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242974; x=1776847774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBagG6nPdWPH/FpnMTW4SeLjEl1Kaw67bUgUq4EnXws=;
        b=MhQ1sCReR63WaeE4M5r5jQM0b0GcCXAXOkZFS+GunNOsVLfH1kx5ViP31WwArgeH3E
         bxlc5oWTJ2q09XQoY67DfPnuRqyBfgSXeJbGcB34pUJL0zhWhFlsyX7JxbLGEEWHE1V8
         7v9i2/od0xC6HciB/KnSPvUBZmc3o/c7UX9xTE8IWHgxCLy/Oj5+yGKkNlA3JJtdIk76
         x708Z2lJ2P26/2c44D8Rq1I7eeEm9XcrbU7b3XajiOnyluE4/Cu6cDMVD9rSnkHkEncC
         kfVsDAcsMWeOSGMAkNgQ8ftt3LFuGv2VQgw4XExM2FJpiP42b0n6jucCSViQpmS/Hxi0
         GWPA==
X-Forwarded-Encrypted: i=1; AFNElJ+TRTi/9Czc6SAPYjPOsoELvjm1ocupXQJMOxHT0RxaDIkTy4tNFiWIYH/MhfzZ01qOHPuQCA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMA6GDL2yMjbXtmmVR9gF0CgdeXks1sOOPSHNmg4SZ3svBKxB
	nhZiuAwd3Bul7UEQnHTt49uqJ0kXySJMvOA8nOdOIZyBM6NLDemfDp8T
X-Gm-Gg: AeBDievrrBMpgaBGsuwGJnebiry7lcK8O+J8ac1KSCaaB55R6WDPx9BW4jb0BRTwzCf
	1GfXA3HIHwFH44Y9kMaG291G7bwBTbZfGhg0DvcTaJ3Zy9LjAxlb8NgzAdJtiYYQhJxavbpFFpT
	BTbQrfQView8ozUNxTTfyen2UvlIy26slN5sJL/rzVwm97DWqikpj6td13II/Cg+/HZnV5oGYHE
	m4bstXk8cWpcj4XaT8j3mlHpCgLXqvbqidfpHFO2IXNh9SDSpHX2mAyHeWAw72zOX7JFWuejMRW
	GLyhJwgkhqrryiJ7dw97JnjnFen/L/hecxl7LE83Q03ZkFLkCDjC6YScQ/C/1MZ5Vz6F5jyZNe8
	Qk1Ta+tE5Qd49+wd0ZOQlu6SpXPakdEcvhXKRf3O1uqumZ6wEKuIQ814hDVk3qLbSWLi7h3/MuG
	TacHvgSGa+0bmCh+R+02yiKJr8Lgp2
X-Received: by 2002:a17:902:8e8b:b0:2ae:464f:fe3e with SMTP id d9443c01a7336-2b4775b794bmr7402045ad.5.1776242974047;
        Wed, 15 Apr 2026 01:49:34 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782ac324sm18807255ad.65.2026.04.15.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:49:33 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu
Cc: pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v3] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Wed, 15 Apr 2026 04:47:28 -0400
Message-ID: <20260415084728.1709824-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ad5p7XlSOKoaQC5D@1wt.eu>
References: <ad5p7XlSOKoaQC5D@1wt.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-278719-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5A10740223F
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
 
 		ft_spt_st = FIELD_GET(FEATURE_MSK, rt_feature->support_info);
 		if (ft_spt_st != MTK_FEATURE_MUST_BE_SUPPORTED)
 			return -EINVAL;
 
-		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM)
-			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data);
+		if (i == RT_ID_MD_PORT_ENUM || i == RT_ID_AP_PORT_ENUM) {
+			t7xx_port_enum_msg_handler(ctl->md, rt_feature->data,
+						   feat_data_len);
+		}
 	}
 
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


