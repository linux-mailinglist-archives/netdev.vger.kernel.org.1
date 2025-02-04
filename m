Return-Path: <netdev+bounces-162755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBCCA27DB1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D389B7A3B00
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE72206AB;
	Tue,  4 Feb 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MgWeM643"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268621C174
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705314; cv=none; b=oGI2HTTxWzEY+JcrdjQOc3NVDKLvEec9nQ04tYRDvMFD1jGDOLcP7ESzGJV2+AaktBayTM0wmcQgIHkOgE4wFTD2t1fXKor6Bckv8sJi7HONLoER4cwNRZLmJ9wEVz1BQjNpk+C/VE+/ZkQ2MzGDwLvti5jxYXMY85i8C+SEQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705314; c=relaxed/simple;
	bh=SkkgRL+aWhhRmH4pjJumNwBZl/4orWE7TU6iXYsD5o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/YnDVKeeZvVbGfNkzwhOurPJLoIO1OizNSJ2k1uDWo13UM/rvbNkl0GqaLlPrbTHda2Meg3pGfkT9Xm+WH3BTj7vEtmp7eR4KNYY1tob6YCeX3IjBAsKzuC0uMQT6796zJ9WnRpXDwbPebW5rDsIjwNjaWPlKXtWk+hTOXUoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MgWeM643; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so5437053e87.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738705308; x=1739310108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YkZDn5aiP46G0YmGmDePlUKCzJbx9gAEyIeepD9Ze8=;
        b=MgWeM6435d1eCDBJBaUGAog7dG8SftIWeb2+0FaTP/YPNyAFe9HB/KEPy2jYiuqAPj
         eXoEaoqlHCHlVtVRHo2lyf7sLkUWl7dVcuSVMAVS4poQTZ6wPdeOwIYLwKxywXQNmpeF
         GqwgQGwuaPmLM4XTz2d49LIIaVVpbDjrukBL92meKEm6ikk/7/ZH5PCJ9GaQn54m3+X0
         ojseNaOlnLAoDa1CG+v07tZUWWvFodpNEuXIIgTg6g0rERVBGxljjKi7svF5zDuveYXr
         09xti8ecVs0vnThXSHMDYC+fOyWViKKYeHCIxEcNYI8kFDSC57LOK2Z89Pnaxo5QjoCD
         9VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738705308; x=1739310108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YkZDn5aiP46G0YmGmDePlUKCzJbx9gAEyIeepD9Ze8=;
        b=E0Luye3Xt0MXI50n94j4HLxCI+ll79S5bzgg9bQunplHLzx11yRjuIIaeTwTzd/s/x
         vVq273d8AkcogItStxpCa0Rts/Y0M1cHNt9cD7OFBYbhHVEHMTrAuIPVlipL+mhhV9n8
         NOO2jevfkdgoatE1wTc8a3DR+myLOTm3QmoIcdQJX1Kw0CKRZBnH9KbDdsVsNZzHSf3f
         EJA1c9OXopTh4CMdjkwFnkJA+Ycj9NRDrmo3V0V+zKmNhEBbs47ljrPtiGIvb02fM7DA
         rTEn06gmCn/eTjWE3JZtv4S3ULVgPHzER9/SHuQzOUCvL3RaJkbGXWQH/ty2NB7PcBgx
         znQA==
X-Gm-Message-State: AOJu0YzzsuTUpvsQLIHrMDdOPV/UumTAKN0WVZATVoeOko779tziVuFL
	ItAREpS75Z++QVQ1myp1vNL3Gy3fjTRYbPnL34GJTUPQTFUtQcPQs18R7Ff6n9CPedF87b5JLKD
	/WF7GyJ+fCjVADjYcRNWPTh+2t1HecCm7
X-Gm-Gg: ASbGncsP+nPMUQcR4q/g3hhUVPnVwZxrzxwW1ZaCE6LqcItaSOKjfAf7H+loGZFH0W9
	HJ6JpsUI5fZqvpQev3zZJKI+omwpcLVHrbU6gNThEeOguAlOA5YpceO+FQpDJ/tJjb7LessU6Sq
	0d2O988/hkWrD2Owu50j1+zXowZKypTUodfcE2Mohmb3z2oPkXode6nnvrH27tdCbmwOP8cUFUW
	TYzEgq+exqq6rNEj1wK9divyLzAoajTE6Fh/yVgNEhOoTD493Ykcmnb6vTTWfTfP3/Kh8F4EGDV
	lYeNddV+UWG+IaFpbRSwM1MTZ7cu4G2yd9n6kdI=
X-Google-Smtp-Source: AGHT+IFYytsAx7QnkQuNjUJtxyv3Dx96zeS9SwWEsuo4ceOYnCkESLc0Ls7mDKdivbKiWU1TQz2zgZ3ZQ6LP
X-Received: by 2002:a05:6512:2245:b0:542:6f78:2ace with SMTP id 2adb3069b0e04-54405a68b4cmr81688e87.47.1738705307937;
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-543ebeb0459sm506587e87.89.2025.02.04.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:41:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 286A934063A;
	Tue,  4 Feb 2025 14:41:46 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 03F44E41434; Tue,  4 Feb 2025 14:41:46 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 04 Feb 2025 14:41:44 -0700
Subject: [PATCH v2 1/2] net, treewide: define and use MAC_ADDR_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netconsole-v2-1-5ef5eb5f6056@purestorage.com>
References: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
In-Reply-To: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

There are a few places in the tree which compute the length of the
string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
constant for this and use it where relevant. No functionality changes
are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/net/netconsole.c           | 2 +-
 drivers/nvmem/brcm_nvram.c         | 2 +-
 drivers/nvmem/layouts/u-boot-env.c | 2 +-
 include/linux/if_ether.h           | 3 +++
 lib/net_utils.c                    | 4 +---
 net/mac80211/debugfs_sta.c         | 5 +++--
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..78c143e65a3f337929f91f70b77e5bc88365eea7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -675,7 +675,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 	if (!mac_pton(buf, remote_mac))
 		goto out_unlock;
-	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
+	if (buf[MAC_ADDR_LEN] && buf[MAC_ADDR_LEN] != '\n')
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index b810df727b446b1762a1851750f743e0de6e8788..43608e45c58aa96a505d82733de1b24ef8d18a1b 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -100,7 +100,7 @@ static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 731e6f4f12b2bf28e4547d128954a095545ad461..4a6c0d0e6dc90a138bfbb402d401d41f59c021f8 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -37,7 +37,7 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427ad9cf58b50c79cbfe185615800dcb..afb2fdc0af653626034ae5e19309c8427272a828 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -19,6 +19,9 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/if_ether.h>
 
+/* XX:XX:XX:XX:XX:XX */
+#define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
+
 static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
 {
 	return (struct ethhdr *)skb_mac_header(skb);
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22f977409f7a6792bb1340f4e911c3..0aedd4854d85ba89dbf0e7451b3f6b197cfac1de 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,11 +7,9 @@
 
 bool mac_pton(const char *s, u8 *mac)
 {
-	size_t maxlen = 3 * ETH_ALEN - 1;
 	int i;
 
-	/* XX:XX:XX:XX:XX:XX */
-	if (strnlen(s, maxlen) < maxlen)
+	if (strnlen(s, MAC_ADDR_LEN) < MAC_ADDR_LEN)
 		return false;
 
 	/* Don't dirty result unless string is valid MAC. */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d3160086ac492d77092a0c8a74d2384b28c..29f45382367e4f6cceb0e0b5f04db1c408da712e 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -457,11 +457,12 @@ static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
 				  size_t count, loff_t *ppos)
 {
 	struct link_sta_info *link_sta = file->private_data;
-	u8 mac[3 * ETH_ALEN + 1];
+	u8 mac[MAC_ADDR_LEN + 2];
 
 	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
 
-	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+	return simple_read_from_buffer(userbuf, count, ppos, mac,
+				       MAC_ADDR_LEN + 1);
 }
 
 LINK_STA_OPS(addr);

-- 
2.34.1


