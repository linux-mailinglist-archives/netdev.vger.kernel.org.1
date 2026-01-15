Return-Path: <netdev+bounces-249979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C4D21DDB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0B56304790F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A4884A35;
	Thu, 15 Jan 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0lBX3U5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED97E110
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437253; cv=none; b=dRge7zL1ycpyaBXabuRj6oD1dFl6sImAkitmx1fpBgVAtqFwaF7YeeTbN+E/8vCpBhI0qzf2/pw6TP76kFMCEvcQGclWnKDkR2+YkXfbKsW/c8ZtBormN9KMVx6OAs3XFUjYCErZdh2IJwJn85sTJofURLs4eECYG3bImm+4XnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437253; c=relaxed/simple;
	bh=KN8xAeP8LgZ24GPQpKViMP6ugO15k1gdCD6ZncSDHVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJGYuPXX9cHX9pA21qpvXtA0Wi9RCKWa+Z4eW4f6D6cxv16D7ClUIFPSa3n7YN3yq2Bpwcuzq61ZAl77kniWzlOKZRL82umb5Xnlr4lgu674/V8M5+5wMG1l3s6AZqCWWFuDg0kEB47eHEDM0qUNP30cf94bNBaCBXu+5jUcAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0lBX3U5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so220228f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437250; x=1769042050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUjcSkNUgHk3opOQEogktGfBoytu+bhw6YgqnRkKHTc=;
        b=m0lBX3U5v5JcEVrFDYvLix2kv/pP7G+Po1OmeaT+aC3CBTdMhI3c4WvTw9zyB/0iqO
         5S5AEE86mmm8XboTyL0oGQAXUZje83RM1aJSiBTLr6z8CShcLt4GCrHAZe5RYRK4b2dh
         ZsiZ/D7Xa1wBmz40c/aS5o3Btp6WL/KGM3xvdZh43sU2eS9yZifiMvsrK4CRP7MLT4Um
         xuAOGJEAtU0DPqUOl+F3SrxXxhDGSyBLuW7qyOCzYr1oxv9mVTXrHEaK6cGKHzR/rFMt
         EilB0sW87bOxI5DCrLUNqxvrpk3froi5RZ9Eqw2utwgxvKI/nzEuBIzF8WopjOolxykG
         hpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437250; x=1769042050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUjcSkNUgHk3opOQEogktGfBoytu+bhw6YgqnRkKHTc=;
        b=tZubRRkOPIwJLHebsMwQ7mYetQSkZip8Svk93kCKxERtL38FEnCtZKhSLG1li+CfZx
         xlyRkKzx30xtSZocTg2WcvCM9DvlNuAQa/i+MKbrRQ0WJ7S5Ar0+yt804ETyOyok6PcR
         WE+g2P5G+XCe2ywvfCnl9R0gAhIWqej5swJYMXXE2uEU7Igwt3OpsttEt2bTsmX5yf11
         BmasAjAha3+ti4Q61s0jGlJZxd5QH4lqHAvoWBKnvpn14lE/fvPksHOOMP3Q98Iwvzgx
         29A2GF+Vy0Q5Shz4psaoYN0iSxvTsVTsBiKJKmuLFJw6d8UYKtl/VhkwNkUatxfLYC/P
         NIeQ==
X-Gm-Message-State: AOJu0YzMqMEUU1/r8M7tu+Bs4LC0rVtSt6ODGBc7d0Vxt432SRgcTqop
	LiH0n/ttN2hDJWE0OrWa1zsktAsK4FSj/UDY5bx6uWcJEbE0VZwmW4RhVguSGuiw
X-Gm-Gg: AY/fxX74UZEj8RusOOLFqr+5x3TROPq7eFsfI25gZ/EXOUWdG7j5TpEHGYhdzX9PQmh
	juj/69l/Bj4sGP1gr21ZZ8GXH2k1yg/iT9HP9YT5dBd14FOkctUuq+huM3fPJmGgJad8BzdxgW0
	EH96NhCg52RBrYT7d9P/UyhfFSVA5uZd9sJ3LhVeX7pDN44FPiC2sX3lTSEQhjymY/kT4U/hTUH
	lH0ZictsTxsFktoSQa7gfT2DA8Otm2axH/7scHq6rBag7hRamH1ilKy/TdZwvh33y8emIOiQO6r
	kc5nZ16uX5h/0NZA5XJ6vyrIv41Nvv6G9AmwbElSCRNdfwr8osBDYaFdtVmJytVtComt/TEQfAB
	sef+8H/EPqzWWWgc/vODz0KgBaYOQNb6kPncklvbqtGDch90Dj1LhM7pxzR/otYnr+J1/W1hQaU
	nPYX+eQT+y
X-Received: by 2002:a05:6000:2893:b0:42f:b65c:1e4f with SMTP id ffacd0b85a97d-4342c4ffd79mr5301450f8f.17.1768437249963;
        Wed, 14 Jan 2026 16:34:09 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6fca86sm2178294f8f.43.2026.01.14.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:34:09 -0800 (PST)
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
Subject: [PATCH net-next V2 5/5] eth: fbnic: Update RX mbox timeout value
Date: Wed, 14 Jan 2026 16:33:53 -0800
Message-ID: <20260115003353.4150771-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
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
Changelog:
V2:
  - Update return type of fbnic_mbx_wait_for_cmpl() to unsigned long
    to match with the return type of wait_for_completion_timeout()
  - Fix inverted fbnic_mbx_wait_for_cmpl() check in fbnic_flash_start()
    and fbnic_fw_reporter_dump()
---
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c | 8 ++++----
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      | 9 +++++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index b62b1d5b1453..f1c992f5fe94 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -178,7 +178,7 @@ fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
 		goto cmpl_free;
 
 	/* Wait for firmware to ack firmware upgrade start */
-	if (wait_for_completion_timeout(&cmpl->done, 10 * HZ))
+	if (fbnic_mbx_wait_for_cmpl(cmpl))
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
+		if (fbnic_mbx_wait_for_cmpl(fw_cmpl)) {
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
index 1ecd777aaada..b40f68187ad5 100644
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
@@ -129,6 +131,13 @@ struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
+static inline unsigned long
+fbnic_mbx_wait_for_cmpl(struct fbnic_fw_completion *cmpl)
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


