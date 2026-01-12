Return-Path: <netdev+bounces-249204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F0D15695
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 091A6306A0FE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2140334685;
	Mon, 12 Jan 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTdkW46B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45B3314A4
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252790; cv=none; b=l9cR1gTBVcpDfaGxbFF5jNd0k3ZwA+ryv8ovA0jwNa+AsjI4beh3qgscvf7jxyesUIyul4GjT69B/VtDixxza6+Pcu5u/fUUjQY9R0plE1DZNw7ZaKKs8U9/I3E9LM92qwQFqT71B8Y9TmpE6nwf3nh8wesz+OovspCIazjrd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252790; c=relaxed/simple;
	bh=cBaSneO3G8JG82D/yoyPYipUckqBoHncZZnPNTnNl7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRMXtHBLB7PpE9Tj1emZHJZ1E2fNVpGoVRKpI7Mqqms1xuMzSlmKreA1jMTMBQ1sZsmVYs2cdNJAJD0HVf13XPdBVdP2Jt01hzISGI/Vu2JHeF2H9YQni7/96XmrHajaAp5Hy1YxAeV8s5+G5sePiF0o6+IjJWwPMYXOP0Hu8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTdkW46B; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so5862733f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252787; x=1768857587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfkJ70X7i+DzmBcf9MkkYuEVs5JrNN1cnSapPu5TUt4=;
        b=WTdkW46Bx7pUNDDGW4zoHYNoKZqISBgwcXq9DWoAtxoki0ep0tWXRQ7NPhsPr8PSNu
         0332bRxl0e4Cytx3/CLv7QCXorrDU9B9WJwle0GGVJs9nyKX+CDMQCSy/tSCD2ysnIsn
         fB0kLFmSftktmqzjVEfkAXy9LjiGDwP3mY9SFmPd4LfQr0IGSJwiM26IwOWL35psdlAK
         W2IUBEl4nVf1fIytAMGIX4CfClIRNkSKy4CqKKAdIIL3/chktE5VIOSMODE6bYe28SeN
         w+YVpNe0EZ+ina/z6pSwyzXvPgwF0E7Hx7XjEFjmxYUrUfLxje31LLTCuP2x0ftl6J4V
         0r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252787; x=1768857587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfkJ70X7i+DzmBcf9MkkYuEVs5JrNN1cnSapPu5TUt4=;
        b=XbHIQLt9P4J5cEZb960x+lWhvQ4Sy1XNpWOsb2LRcoqDnTa9xDpBC3U0nUnyDR83mb
         4KhaTfXNytQ2ja5Tv2lHkDeD2YHYI2vhnSH5lqQ/BNjX1auyUM36SGia0FSRev63jifc
         xll2X2721TlcTKcEIN1Mjwml0mQkb0ryBLS8nrBGlovA7+r840YU7UFiYPyIJ5kK3A8y
         VR/hy8n5jf8qDRwZe96riCtLX6nQ7mnVJUVIeatS+nzNoFBwGRdN8PcdICFmfUD3pnWR
         H6+2geA0ZkW33GVlh0KeZlvGbkJIMz2pMj9ydpFCRdq2wdfHkyWnjpqkObbT3pO59vQH
         4dgw==
X-Gm-Message-State: AOJu0Yy4BLC+wyue19RUcBkA+s3l7vqNvD3e5OGyphur2TRV1aSaZW8v
	XGJnpJ9I5hqlYGeBZjnuZGc2z3zcsRA4C5Wwqwkz1L8ApEno0AzTLQVAioiwzM7B
X-Gm-Gg: AY/fxX5QdDBQLnKH4IT9x7PHJ4ToBUDEqsBN2l8fKBPYlm9xavTpaJpXlOwYhO/G4kp
	iseBxc1UoUXj5GBnjh9u70560lnR7roGYDISVCqFhgxrx+Q6HtRyMBs7iSi9Pq70AqoSGftj5Xq
	L+KtykZ9fyJqE5Ruuq7wcKmLWY877yNKiigFO4aSoCAD0e1XnjKLwfFhD7pbGwDaBEo6Z/c+Be3
	n3xCUCny+LQMTnFhSu6PdQIdzDSB9dNy6SMsN7wjYgZnk/ewgiwPS9wGsG+KTrcki1SjlbxetfW
	lQ8Q+9YTf4j2TjFZpe9PaVje6f5Lh/JTmYDa1ZITMQXqF0pl0S665Hhd4kipijlasNSpLsvfmTF
	P0K2H+JdqEMwRuNoLoyTN/4I6p869nc8ZLpM4Yj4a7hDfw9QMmjsFkkvvOjKVQVDz4WJTiAmXqj
	E/Inlh12Pn
X-Google-Smtp-Source: AGHT+IG8G2fqpAX9NOzJpaQxtmcyOaiVc4bp7o5AyrM46xE8vYXcaoMGbXH33QDSTNtKIpbVmi5cFA==
X-Received: by 2002:a05:6000:184d:b0:431:3a5:d9c1 with SMTP id ffacd0b85a97d-432c37c8701mr23008987f8f.30.1768252787008;
        Mon, 12 Jan 2026 13:19:47 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d9610671sm22909598f8f.34.2026.01.12.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:19:46 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V0.5 5/5] eth: fbnic: Update RX mbox timeout value
Date: Mon, 12 Jan 2026 13:19:25 -0800
Message-ID: <20260112211925.2551576-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While waiting for completions on read requests, driver is using
different timeout values for different messages. Make use of a single
timeout value.

Introduce a wrapper function to handle the wait, which also simplify
maintaining the 80 char line limit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c | 8 ++++----
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      | 8 ++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index b62b1d5b1453..193f554717b3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -178,7 +178,7 @@ fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
 		goto cmpl_free;
 
 	/* Wait for firmware to ack firmware upgrade start */
-	if (wait_for_completion_timeout(&cmpl->done, 10 * HZ))
+	if (!fbnic_mbx_wait_for_cmpl(cmpl))
 		err = cmpl->result;
 	else
 		err = -ETIMEDOUT;
@@ -252,7 +252,7 @@ fbnic_flash_component(struct pldmfw *context,
 		goto err_no_msg;
 
 	while (offset < size) {
-		if (!wait_for_completion_timeout(&cmpl->done, 15 * HZ)) {
+		if (!fbnic_mbx_wait_for_cmpl(cmpl)) {
 			err = -ETIMEDOUT;
 			break;
 		}
@@ -390,7 +390,7 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
 				   "Failed to transmit core dump info msg");
 		goto cmpl_free;
 	}
-	if (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+	if (!fbnic_mbx_wait_for_cmpl(fw_cmpl)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Timed out waiting on core dump info");
 		err = -ETIMEDOUT;
@@ -447,7 +447,7 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
 				goto cmpl_cleanup;
 		}
 
-		if (wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+		if (!fbnic_mbx_wait_for_cmpl(fw_cmpl)) {
 			reinit_completion(&fw_cmpl->done);
 		} else {
 			NL_SET_ERR_MSG_FMT_MOD(extack,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 693ebdf38705..61b8005a0db5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1671,7 +1671,7 @@ fbnic_get_module_eeprom_by_page(struct net_device *netdev,
 		goto exit_free;
 	}
 
-	if (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+	if (!fbnic_mbx_wait_for_cmpl(fw_cmpl)) {
 		err = -ETIMEDOUT;
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Timed out waiting for firmware response");
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 1ecd777aaada..6b3fb163d381 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -4,6 +4,7 @@
 #ifndef _FBNIC_FW_H_
 #define _FBNIC_FW_H_
 
+#include <linux/completion.h>
 #include <linux/if_ether.h>
 #include <linux/types.h>
 
@@ -36,6 +37,7 @@ struct fbnic_fw_mbx {
  *                       + INDEX_SZ))
  */
 #define FBNIC_FW_MAX_LOG_HISTORY		14
+#define FBNIC_MBX_RX_TO_SEC			10
 
 struct fbnic_fw_ver {
 	u32 version;
@@ -129,6 +131,12 @@ struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
+static inline bool fbnic_mbx_wait_for_cmpl(struct fbnic_fw_completion *cmpl)
+{
+	return wait_for_completion_timeout(&cmpl->done,
+					   FBNIC_MBX_RX_TO_SEC * HZ);
+}
+
 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
 do {									\
 	const u32 __rev_id = _rev_id;					\
-- 
2.47.3


