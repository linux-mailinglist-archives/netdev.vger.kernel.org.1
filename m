Return-Path: <netdev+bounces-149860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141DF9E7D98
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694CC286B44
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 00:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83110F4;
	Sat,  7 Dec 2024 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT3kp6gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F328F5;
	Sat,  7 Dec 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733532462; cv=none; b=uBWRWZsCt7GmUwN6qm+kuSqIXBO1RtHQk7EvFm5a6S1XGpLGwtWn+ruN5e+d8v3rE2cMDZMkrrh1QqIlHw12Grkh4KhrrbmwIAT/jKWR5ns8Vhvfigq/ULRro/bR6itS0epMqs2N9XW9dHt7IHLamk/7S53sm01HlqXKi7TkI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733532462; c=relaxed/simple;
	bh=nkYAwojMw5JTdOARTjlspFTmdqouqp69Xr5Kw/5TinE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHUjJdV3MGdv5I5j+KEXN3eaBO9WwiG9az9cnZEOc7PQGvTinP/1wa/ZQWO0AYnR835B1eeYChBk0vbczYjpfDlAbul1yh7Ez9mdP/18G5SeK9mmzADvHDtRPfgb8PpXRc4asmLRFyy63CLOJE3BIALUSs4xEWs703Q5nCDOhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT3kp6gd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7252fba4de1so2993932b3a.0;
        Fri, 06 Dec 2024 16:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733532460; x=1734137260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E84fDpFKmeEOI7rSMcS7qYzn6qrZ42lbUTz5EZVjbDU=;
        b=FT3kp6gd3wf37lZlAhciNJdSyWmaaFQ7kyVjSh+N33c4saJ8WRN4AOVArAgeM44HBj
         774bz9us/KzGLuckBLu1EOtpS49vRMFVfEoxNxxy+YHQS2++e/cE7Ql7Lls3givMu8MZ
         yEtC2SskEP3sbsIvUz9D++l1xxk+hnYVATuPiSwRstfsCacttIMLplJxEtfWweRbgmFy
         uUMSITBv1it39v1DvxyvucZuLw/50cm1s03gSldUmcfw/+TConn+O/kYRN+r2J9yJhNQ
         K0efKZHE+HFGu4zM3h/+jMiEHq+IIe4KuJnUgiWO8fXiq6TdqG/87nzK8qMy4CpAJWlY
         7P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733532460; x=1734137260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E84fDpFKmeEOI7rSMcS7qYzn6qrZ42lbUTz5EZVjbDU=;
        b=QWmFbkddBtWyqpbN57zZhnUj7JqRUPa5nPdyRUiZ4tce3rDyLef8V3+TPvpcLNeHVV
         ci2CZxl3ZcaLvYcxDpLKbwDnj6Ly3kSg4w2QRvNUVl2I54+ZSvIEn/ainQFTj1RcSQde
         XymJgmitbQArOvqK9httewEvqq92O70X/cqigSXoxKLNZGFu32aLdjpAODuCRE6vjsuv
         CLg4JeypT5zBM9LSWYujepN1eyPA+PZJJBjfMG1/Xa0fnDroqPZgist/gsLoGiA70sQW
         fZJSV7jZKG+IQUNH/ypV/6yDCxgGpZeygFqQbGWRtcVdQK84Z/749bL1DEW0rG6B3UKT
         lodQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbYLwK8ilCPPW0SUaI2Ejvs6BAMoO5J76y6QEEMw7fML9jrXJlWAdQ7+E6UXhcRbcG5SLegqRKo5Jchss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ0HnOpqiSDdDcOyGRLYoYYariZIJhY0eJg2rAJZjEeatF2Vu
	2qDkQ6s6pkdTZoCvYLjWirW3zNgbFX8Q9laENdxvu6i7z3POyxN0DDI7NLDt
X-Gm-Gg: ASbGnctoYueWWr3dfJDzCOkGVUIRou6kjLhnZP5Ua+HSiPdUgUK89p3khgF/2JzZ222
	vDng/p3FdQxuDZMiDPTWY6uExeybQHevHImgUVtIBT+sr+5uTPxy8aGe+q6CuHoHgsK3aHfQs8R
	oXjS6+//sbTiu48rCwMjHDbzS65s3yMqDi5iiYwxBpBvu39Lx4n4rUQ9cj9z5HTvhENtFWjjgc7
	cKRaLMB8jtGwsIt2bboNHaUOA==
X-Google-Smtp-Source: AGHT+IFm2A5sAnM7q31TLIQo4rY7sQap0MvV+rENKXkaVha9hZdDa7e3zwnwiNb5o2bboGDu2d4a/w==
X-Received: by 2002:a17:902:c948:b0:215:b468:1a48 with SMTP id d9443c01a7336-21614dadfa3mr80120455ad.26.1733532459842;
        Fri, 06 Dec 2024 16:47:39 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3f0cbsm34318875ad.53.2024.12.06.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 16:47:39 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 net-next iwl-next] net: intel: use ethtool string helpers
Date: Fri,  6 Dec 2024 16:47:37 -0800
Message-ID: <20241207004737.33936-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer. Cleans up the code quite well.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: avoid variable renames in established locations.
 v3: change custom get_strings to u8** to make sure pointer increments
 get propagated.
 v2: add iwl-next tag. use inline int in for loops.
 drivers/net/ethernet/intel/e100.c             |  6 ++--
 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 +++---
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 ++++----
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 +++---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  5 +--
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  9 ++---
 drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 +++---
 drivers/net/ethernet/intel/igc/igc_ethtool.c  | 17 +++++----
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  6 ++--
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 ++++++++-----------
 11 files changed, 64 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 3a5bbda235cb..15bb637ac1dd 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2722,10 +2722,12 @@ static void e100_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, e100_gstrings_test, sizeof(e100_gstrings_test));
+		for (int i = 0; i < E100_TEST_LEN; i++)
+			ethtool_puts(&data, e100_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
-		memcpy(data, e100_gstrings_stats, sizeof(e100_gstrings_stats));
+		for (int i = 0; i < E100_STATS_LEN; i++)
+			ethtool_puts(&data, e100_gstrings_stats[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index d06d29c6c037..33222fadb3b9 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1839,18 +1839,18 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 static void e1000_get_strings(struct net_device *netdev, u32 stringset,
 			      u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, e1000_gstrings_test, sizeof(e1000_gstrings_test));
+		for (i = 0; i < E1000_TEST_LEN; i++)
+			ethtool_puts(&data, e1000_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, e1000_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = e1000_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		/* BUG_ON(p - data != E1000_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..ab590b69c14f 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2075,23 +2075,23 @@ static void e1000_get_ethtool_stats(struct net_device *netdev,
 static void e1000_get_strings(struct net_device __always_unused *netdev,
 			      u32 stringset, u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, e1000_gstrings_test, sizeof(e1000_gstrings_test));
+		for (i = 0; i < E1000_TEST_LEN; i++)
+			ethtool_puts(&data, e1000_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < E1000_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, e1000_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = e1000_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, e1000e_priv_flags_strings,
-		       E1000E_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < E1000E_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, e1000e_priv_flags_strings[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 1bc5b6c0b897..fb03bb30154a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -122,7 +122,7 @@ static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Mailbox test (on/offline)"
 };
 
-#define FM10K_TEST_LEN (sizeof(fm10k_gstrings_test) / ETH_GSTRING_LEN)
+#define FM10K_TEST_LEN ARRAY_SIZE(fm10k_gstrings_test)
 
 enum fm10k_self_test_types {
 	FM10K_TEST_MBX,
@@ -182,15 +182,15 @@ static void fm10k_get_strings(struct net_device *dev,
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, fm10k_gstrings_test,
-		       FM10K_TEST_LEN * ETH_GSTRING_LEN);
+		for (int i = 0; i < FM10K_TEST_LEN; i++)
+			ethtool_puts(&data, fm10k_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		fm10k_get_stat_strings(dev, data);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, fm10k_prv_flags,
-		       FM10K_PRV_FLAG_LEN * ETH_GSTRING_LEN);
+		for (int i = 0; i < FM10K_PRV_FLAG_LEN; i++)
+			ethtool_puts(&data, fm10k_prv_flags[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bce5b76f1e7a..753b559a2fc5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -426,7 +426,7 @@ static const char i40e_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)"
 };
 
-#define I40E_TEST_LEN (sizeof(i40e_gstrings_test) / ETH_GSTRING_LEN)
+#define I40E_TEST_LEN ARRAY_SIZE(i40e_gstrings_test)
 
 struct i40e_priv_flags {
 	char flag_string[ETH_GSTRING_LEN];
@@ -2531,8 +2531,8 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, i40e_gstrings_test,
-		       I40E_TEST_LEN * ETH_GSTRING_LEN);
+		for (int i = 0; i < I40E_TEST_LEN; i++)
+			ethtool_puts(&data, i40e_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		i40e_get_stat_strings(netdev, data);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3072634bf049..04194efe8b49 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -83,7 +83,7 @@ static const char ice_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)",
 };
 
-#define ICE_TEST_LEN (sizeof(ice_gstrings_test) / ETH_GSTRING_LEN)
+#define ICE_TEST_LEN ARRAY_SIZE(ice_gstrings_test)
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
  * but they aren't. This device is capable of supporting multiple
@@ -1496,7 +1496,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 		}
 		break;
 	case ETH_SS_TEST:
-		memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
+			ethtool_puts(&p, ice_gstrings_test[i]);
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ca6ccbc13954..7a44a735eac5 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -123,7 +123,7 @@ static const char igb_gstrings_test[][ETH_GSTRING_LEN] = {
 	[TEST_LOOP] = "Loopback test  (offline)",
 	[TEST_LINK] = "Link test   (on/offline)"
 };
-#define IGB_TEST_LEN (sizeof(igb_gstrings_test) / ETH_GSTRING_LEN)
+#define IGB_TEST_LEN ARRAY_SIZE(igb_gstrings_test)
 
 static const char igb_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IGB_PRIV_FLAGS_LEGACY_RX	BIT(0)
@@ -2352,7 +2352,8 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, igb_gstrings_test, sizeof(igb_gstrings_test));
+		for (i = 0; i < IGB_TEST_LEN; i++)
+			ethtool_puts(&p, igb_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
@@ -2374,8 +2375,8 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 		/* BUG_ON(p - data != IGB_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, igb_priv_flags_strings,
-		       IGB_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGB_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&p, igb_priv_flags_strings[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
index 83b97989a6bd..2da95ea66718 100644
--- a/drivers/net/ethernet/intel/igbvf/ethtool.c
+++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
@@ -412,18 +412,18 @@ static int igbvf_get_sset_count(struct net_device *dev, int stringset)
 static void igbvf_get_strings(struct net_device *netdev, u32 stringset,
 			      u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igbvf_gstrings_test, sizeof(igbvf_gstrings_test));
+		for (i = 0; i < IGBVF_TEST_LEN; i++)
+			ethtool_puts(&data, igbvf_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGBVF_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, igbvf_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = igbvf_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 817838677817..2db80aaa7920 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -104,7 +104,7 @@ static const char igc_gstrings_test[][ETH_GSTRING_LEN] = {
 	[TEST_LINK] = "Link test   (on/offline)"
 };
 
-#define IGC_TEST_LEN (sizeof(igc_gstrings_test) / ETH_GSTRING_LEN)
+#define IGC_TEST_LEN ARRAY_SIZE(igc_gstrings_test)
 
 #define IGC_GLOBAL_STATS_LEN	\
 	(sizeof(igc_gstrings_stats) / sizeof(struct igc_stats))
@@ -763,19 +763,22 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 				    u8 *data)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
+	const char *str;
 	u8 *p = data;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igc_gstrings_test,
-		       IGC_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGC_TEST_LEN; i++)
+			ethtool_puts(&p, igc_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
 			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
-		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
-			ethtool_puts(&p, igc_gstrings_net_stats[i].stat_string);
+		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++) {
+			str = igc_gstrings_net_stats[i].stat_string;
+			ethtool_puts(&p, str);
+		}
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
@@ -791,8 +794,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 		/* BUG_ON(p - data != IGC_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, igc_priv_flags_strings,
-		       IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IGC_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&p, igc_priv_flags_strings[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 9482e0cca8b7..91d67a341edc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -129,7 +129,7 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Interrupt test (offline)", "Loopback test  (offline)",
 	"Link test   (on/offline)"
 };
-#define IXGBE_TEST_LEN sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN
+#define IXGBE_TEST_LEN ARRAY_SIZE(ixgbe_gstrings_test)
 
 static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IXGBE_PRIV_FLAGS_LEGACY_RX	BIT(0)
@@ -1439,8 +1439,8 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 		/* BUG_ON(p - data != IXGBE_STATS_LEN * ETH_GSTRING_LEN); */
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, ixgbe_priv_flags_strings,
-		       IXGBE_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IXGBE_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&p, ixgbe_priv_flags_strings[i]);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 7ac53171b041..f63a9f683e20 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -70,7 +70,7 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Link test   (on/offline)"
 };
 
-#define IXGBEVF_TEST_LEN (sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN)
+#define IXGBEVF_TEST_LEN ARRAY_SIZE(ixgbe_gstrings_test)
 
 static const char ixgbevf_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IXGBEVF_PRIV_FLAGS_LEGACY_RX	BIT(0)
@@ -504,43 +504,35 @@ static void ixgbevf_get_strings(struct net_device *netdev, u32 stringset,
 				u8 *data)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	char *p = (char *)data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *ixgbe_gstrings_test,
-		       IXGBEVF_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IXGBEVF_TEST_LEN; i++)
+			ethtool_puts(&data, ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IXGBEVF_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, ixgbevf_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = ixgbevf_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
-
 		for (i = 0; i < adapter->num_tx_queues; i++) {
-			sprintf(p, "tx_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "tx_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
 		}
 		for (i = 0; i < adapter->num_xdp_queues; i++) {
-			sprintf(p, "xdp_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "xdp_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "xdp_queue_%u_packets", i);
+			ethtool_sprintf(&data, "xdp_queue_%u_bytes", i);
 		}
 		for (i = 0; i < adapter->num_rx_queues; i++) {
-			sprintf(p, "rx_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "rx_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
 		}
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(data, ixgbevf_priv_flags_strings,
-		       IXGBEVF_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < IXGBEVF_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, ixgbevf_priv_flags_strings[i]);
 		break;
 	}
 }
-- 
2.47.0


