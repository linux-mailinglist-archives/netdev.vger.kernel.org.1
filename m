Return-Path: <netdev+bounces-174327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABAA5E4C5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72C117C512
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94D7259489;
	Wed, 12 Mar 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FtyPwsMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0441F0996
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809121; cv=none; b=e6vZecL2kZ5/J36NN7/bA8pz4XCwUzOdzLUxYt3/r2/a7x5v6UPbpKgVtd4XOLflx2Hc6t9swUYr++XKrJsNuBiPG8f5CdJ/DoMa51r4DxKT0aRjacsEa0kEi5X9dyekMcZXakh7za7j39ESGJgXmbaC30MuwNU2z9JgbiCJWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809121; c=relaxed/simple;
	bh=DCiRCv2YP+zAqkYxz2M9tKKS8ND4+qlaQKA6qe1QI1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNJjV8gXDqH8dXJkij2klBpSxwFPC4Ze3svKTRakfU9IoxW1ksB0PSXms6WQWLvuwVhYG2OdJ1sOyDAnX6znEC6r+lbhM/gO4b+1x80iAOiosPqw6E4wk7G6gIYlIBUC4WGdMbnPx54oOgXDRn3YRPCNSqUDVsXSLDNbeVWFRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FtyPwsMV; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6e8fca43972so2495526d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741809118; x=1742413918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYRtGetn5eI0U7XLCVsTKGE5sj4vx1TXbmWxNemKl/g=;
        b=FtyPwsMVxUtJKMg0Bbkw7FsO7KhCpAuW9XDc2+HIu/BIqjXpkfoH8B/oR9IoYRi8pO
         e7NPIA/lzNRNnezRHwFqIUZqD7bcMa9PLq2Itl2NjVT+qUSv3FFVYw7RL9vsx7nly1l8
         U3j36hgHhn7b/hcPSmgOfaIuA/rHnn77haXtW+zOS8C195TqutXlvZqG8RWv12WxwrxX
         TxICz/Ver9d1Ru3WWBfuxhku91huMNvA4fsCiv2uSbs919Un2VDlRayz6MKK2lbYVd39
         TnS7qWUvq39odP8u1WymUKtZmGohwHcDt7ULU5TJIHk+HUmPSXl5gc/cadZz+SeecXpj
         qVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809118; x=1742413918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYRtGetn5eI0U7XLCVsTKGE5sj4vx1TXbmWxNemKl/g=;
        b=i3UgEtbuiaPkCG5VcOyNlEHe0vv9JJ4SJcZA3EGbcQgGMydPTL2lxgvo88QgllVI8k
         2H8XPV5e9zitRXIRstZV2DzYqCg4qr/Q0HMW0gOkwD3Ys1CQVO1ZfeEyXB2SFpdIYcZO
         R4MYmuLiGiIkjl3yVsanUtiWSya5CKgZZnzI47KgG1S1vDFhV1BCujxdiyOuAnQ9bY0h
         l9AMtf6fD00fyIDXTzoHSRm26lU1L5pEnIMKdcbC22CwvmH2Zhi4JBE5XsvmZfLoVF04
         UqqWnnaHogtqRPnUnquPeZaf4+kk4w3rN3tYt1sV8ZgOz4S1BrUz3T70I0l9eBvGU5W0
         6gLA==
X-Gm-Message-State: AOJu0Yy+tNdZR0JzPkbENPWezeS1eyDi0VgHVm1IzkhrhBMFvyTSOMuD
	cLC6gkdVhqACEXCurNNbzXgsC72Ro9KBmN3BqH54gieNXlKR4VYwonF7CgmMk1v9V7wE809wiUN
	UbVrtbQoP3eGaa42s7Mw5Zt2IDr81r7HJnOm5ojzgmxD6Voa9
X-Gm-Gg: ASbGnctLrfecMSaIOMwX5FNmZ9f2Ivfhad4Sb3najtPGlN8VrWL1ANfE1AaIKoJlQQp
	pB6QrCPvZMFQPCjShxd3bZ5g/i06OQxG7Jr7983JsPHy7VREUyxIjqlteyKSTn70kMcVPiJC9/h
	hROMeyT+KBN+zRkvDgrTG4/1o72h+QoZDTgAv/Iu8fbe09qgiNP7jLD9lueJZx+kM3wcZS7fapZ
	rKnbLrweiRQcwYj2ewkc+jgprQhosBSHUpimzsFWDJtkf4wrsBRCjAzPDQL4+bdTPgYoeNusxNy
	7j8qdXC4+IrtxG28L6lii+peomP0ugyHB30=
X-Google-Smtp-Source: AGHT+IEpd1n+zzrnYjXjt4Wcq2+V1OtkThON8chLUhDq12vQ6C1Wi7nzCRD/w3CyyorQpZG20KFdLxUKaqOq
X-Received: by 2002:a05:6214:212b:b0:6e8:ff23:66d6 with SMTP id 6a1803df08f44-6e9005aef8emr294464566d6.9.1741809118314;
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8f70a4f7esm5309096d6.33.2025.03.12.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3EF593403C7;
	Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 32A87E400CB; Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 12 Mar 2025 13:51:46 -0600
Subject: [PATCH net-next v6 1/2] net, treewide: define and use
 MAC_ADDR_STR_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-netconsole-v6-1-3437933e79b8@purestorage.com>
References: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
In-Reply-To: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Simon Horman <horms@verge.net.au>
X-Mailer: b4 0.14.2

There are a few places in the tree which compute the length of the
string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
constant for this and use it where relevant. No functionality changes
are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@verge.net.au>
---
 drivers/net/netconsole.c           | 2 +-
 drivers/nvmem/brcm_nvram.c         | 2 +-
 drivers/nvmem/layouts/u-boot-env.c | 2 +-
 include/linux/if_ether.h           | 3 +++
 lib/net_utils.c                    | 4 +---
 net/mac80211/debugfs_sta.c         | 7 ++++---
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 098ea9eb02373d8bb6c8b9fd6e75a89cc4743dbc..43757b5c021698977040ad1cb0f355d59cd8ae3f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -739,7 +739,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 	if (!mac_pton(buf, remote_mac))
 		goto out_unlock;
-	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
+	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
 		goto out_unlock;
 	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
 
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index b810df727b446b1762a1851750f743e0de6e8788..b4cf245fb2467d281111001bb7ed8db5993a09b2 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -100,7 +100,7 @@ static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_STR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 731e6f4f12b2bf28e4547d128954a095545ad461..436426d4e8f910b51b92f88acddfbb40d374587a 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -37,7 +37,7 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 {
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes != MAC_ADDR_STR_LEN)
 		return -EINVAL;
 
 	if (!mac_pton(buf, mac))
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 8a9792a6427ad9cf58b50c79cbfe185615800dcb..61b7335aa037c7232a0caa45572043057c02dde3 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -19,6 +19,9 @@
 #include <linux/skbuff.h>
 #include <uapi/linux/if_ether.h>
 
+/* XX:XX:XX:XX:XX:XX */
+#define MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1)
+
 static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
 {
 	return (struct ethhdr *)skb_mac_header(skb);
diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22f977409f7a6792bb1340f4e911c3..215cda672fee1b5a029c2b61529c6813c0edab11 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,11 +7,9 @@
 
 bool mac_pton(const char *s, u8 *mac)
 {
-	size_t maxlen = 3 * ETH_ALEN - 1;
 	int i;
 
-	/* XX:XX:XX:XX:XX:XX */
-	if (strnlen(s, maxlen) < maxlen)
+	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
 		return false;
 
 	/* Don't dirty result unless string is valid MAC. */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index a67a9d3160086ac492d77092a0c8a74d2384b28c..a8948f4d983e5edee45d90ad267582657ed38e38 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -457,11 +457,12 @@ static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
 				  size_t count, loff_t *ppos)
 {
 	struct link_sta_info *link_sta = file->private_data;
-	u8 mac[3 * ETH_ALEN + 1];
+	u8 mac[MAC_ADDR_STR_LEN + 2];
 
 	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
 
-	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+	return simple_read_from_buffer(userbuf, count, ppos, mac,
+				       MAC_ADDR_STR_LEN + 1);
 }
 
 LINK_STA_OPS(addr);
@@ -1240,7 +1241,7 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	struct ieee80211_local *local = sta->local;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct dentry *stations_dir = sta->sdata->debugfs.subdir_stations;
-	u8 mac[3*ETH_ALEN];
+	u8 mac[MAC_ADDR_STR_LEN + 1];
 
 	if (!stations_dir)
 		return;

-- 
2.34.1


