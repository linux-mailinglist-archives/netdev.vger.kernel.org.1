Return-Path: <netdev+bounces-277683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHmAMPwI2mkcyAgAu9opvQ
	(envelope-from <netdev+bounces-277683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBFF3DF001
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 052213012876
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF03317146;
	Sat, 11 Apr 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMGvZkLx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FC28C5CB
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896825; cv=none; b=GLgsKSwF6v9dN//2UdRAP61LLkNd8YnG/y7XcEsRX2pYDxaazwLjiFCvWrlEE55BIsaL6JA03m0kZsxo482w55Gwdsq3gD8gAbPzTN/MocCGSAD0uRhQnz4gZo86QxUU9X+gOZiXesfaPVJ9YjQyE3fN27qzQ/A32hh9IBY0wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896825; c=relaxed/simple;
	bh=mIRP6L+hb77SJIiAE3rkIP7boFxJE9dvNqAhHyLa+zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1B+wczlVaEuL8VroaobYum9hpphHJ+TFN4hvDLU+8mhL9kiBuHiHUtYQqr3B0vmrSvuZ9PWoq8APtfVZETfTY9rvl5vq+mJtdPoe+Rn5TKdasYk4eCiIX/3Y5T/o9oI4HmLVQOjnq7J8WS3y18LD4sQLFPjx4ny1dnzhlWKgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMGvZkLx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c12651da5so462473a91.2
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775896822; x=1776501622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gij9R0BiMf/CLJF+fbkJbgQX286SYIp1XpOlyH59MlQ=;
        b=SMGvZkLxv9G4ISNcKd3SG4ZfTidXAj+c4ucXqdZtpPiL7pNlMRSYYvgxHX9lEsXpP5
         NpYUz5s8Qq7NItfukbPEsKmG/NJb4ztFBUBD9DYS6TCcE7xZptVdMyM6klfDv/u175DB
         Vb5sZh0L5F/a4RenDGHfYZCX6Fg6wKnqJD7EZeErNj+zPWrEYgygmp8iI14CK8eDXKcJ
         qsjA0WrXW6qeKifbk+1sZwizNdw5VS1ssuA2xfkHnV4Voso6sVxjWINooUKk/CRIHH76
         bo0l3leNO1XsGGN6OM9yht63AEP9eEM0PnatfOk+8PWL41+IN2qrXYXfK/0J9xn37zFi
         H/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775896822; x=1776501622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gij9R0BiMf/CLJF+fbkJbgQX286SYIp1XpOlyH59MlQ=;
        b=Jsyq8NM5M3jVKGfALOQqodAC/Ug7LgsVgF5cftggqlMqCWlL9gxHIlyF+ncSJlgUXA
         cuIcHM6e71p+0iS2Bkv6ao7DAai8Mu0mW3VWdbJOIj5vvwwVIsbz5r2Yi5QVLjIOZaiY
         5yK19k+GyovhkRHCHag8wWltbE8S+7cvsTlLh+5thODHoD/P7y6WKKpG+0uqIZqHjUnn
         wxgSR0AER7V/O3nZVyamBW1Eey+decEAt1yt74w10ZvygcKxmKdFgPRLbdptQTZN6HET
         YoH6ysCF9ZGG0l2d/URa2TTGpBPSNglIHjFTsB4SrrU5Hdr9xmPj/QijJSoSIjx8OQZ9
         1vmw==
X-Forwarded-Encrypted: i=1; AJvYcCWHdjBrzTx6rn0CNu9PbrH48GmVhedzmAmCmF5dhv8WKr2Uwtqz7EBaz1kYPcr6BxGPNacCll4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50wCqPJNDHScz6URWNWkO9wJs8NDkY37Yme8jC4TPqPJwp4/q
	B5eGeYha5qcXG39wev7D03XFLG4tCvrfi0M/czgbwNDCa0SZPk4Hi+TX
X-Gm-Gg: AeBDiesr3Qgnkwj296eLRfnXBkiM6dSF24c+taepeIGM54ef02GA2eE47/9u0jKIx5X
	tysqh0nrFKH5rt4E1rHpyWOVS9Jok3T1FFbRTD0Xz9DjwvH8y0VYKZKApu+yYanLSUlGKQtqe3z
	XsQhOC51+2A8tMaOymhFaVlNyQomisj6VPG+bvGXYzJJ0+ZrRbPCwDliljbt8jBQtZKgoAekgjV
	eQ0FHZH8N4AeNGKroU+++CtN6SJ8Cthvk8eVS271M0tq4LXR+IT8sfD2mxVaA94qOVSKwBgITOq
	8ORm19vic1fyfNG4IAFLYk932Q/E/9QikYZ+yEA2wlWPqrUKfVhOrPlKs6pHsqw8Jb4XZ7SLbZu
	BHtcSHrWWKJuafNDdr42ZcolsBOd24j4SEU4e59McJuzaTUEjf/n6HuFs86XGErsZUmgg8TiZDq
	9w8rKb799uGdacK+D2tOqMEI74Zhs=
X-Received: by 2002:a17:902:c950:b0:2b2:5be3:ba34 with SMTP id d9443c01a7336-2b2d580c7dbmr37649635ad.0.1775896822160;
        Sat, 11 Apr 2026 01:40:22 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm53874255ad.71.2026.04.11.01.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:40:21 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: w@1wt.eu
Cc: chandrashekar.devegowda@intel.com,
	linux-wwan@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler
Date: Sat, 11 Apr 2026 04:39:57 -0400
Message-ID: <20260411083957.567676-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACBFF3DF001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
a loop bound over port_msg->data[] without checking that the message buffer
contains sufficient data. A modem sending port_count=65535 in a 12-byte
buffer triggers a slab-out-of-bounds read of up to 262140 bytes.

Add a struct_size() check after extracting port_count and before the loop.
Pass msg_len from both call sites: skb->len at the DPMAIF path after
skb_pull(), and the captured rt_feature->data_len at the handshake path.

Fixes: 1e3e8eb9b6e3 ("net: wwan: t7xx: Add control DMA interface")
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
2.51.0


