Return-Path: <netdev+bounces-153001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3F9F6905
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50A6168464
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248C1B424F;
	Wed, 18 Dec 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYyWGnZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27E1ACEA3;
	Wed, 18 Dec 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533226; cv=none; b=odEObKLwGjXuW9ZITHphpL5HQG+Y3uudPTeLTYKcpfzhvo4Jdn5UtOkxywbDNZ5DFXhjcpWWOBuvhDeMOrNVjPG+hz0SQ5O9c4e+6ZkFdr5qL3Nip3nsJ+2ZQWDWsfVKScxLRIIp58/54tQoMwnK0KTQDBE6S4mIQKpEt63P0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533226; c=relaxed/simple;
	bh=pJxNJKaUf6zDb1m8+mn4rmuGwT+DvixiSUVm2dZq6eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkxQGhVU8r97VWV7ltKKPKOgUfwoCZULjcPEqbjUcA4lkSPMT5eOyjBRBdPoegviGge/zr97tza7stTJJiUt7UqhIRujLwVcyjqYJYcjD8ZD5Z50HmwH8D+DdBzVEyRCWyKFzqyb+mYV4uMzeBg3HuNc9JADG64+kH/Y5cOwpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYyWGnZu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725c86bbae7so5750784b3a.3;
        Wed, 18 Dec 2024 06:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533224; x=1735138024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7Rao6XieC9T0DL79hefU+Cc7jNmFKIhSEFIHF7BW+k=;
        b=cYyWGnZuqM/Ar6DWwZuTy1G/WNIyJIl5Rz9CeLnQWT+UhClJvCx1/RQ2qqSqZIZjy9
         qOFrrMG1Drl0ZDHggXnAoxTiB2+k1ELkqnLdh6NPeDInp6QdBwE+MHUdcMO40qIqtDe4
         sBzy1oG1eOKKb9/P/F4HhPIAl82n72L76WKiHrKY2G9r7Q17o3SCknC1tM2lyKqLCTjt
         a/aoxSCnb/uHq8DSx1FSPsASotJYAEwJBwU+gf9Zd3APudDrDqfphxMj2bHQkSjPFrtS
         YhyUf6sdb1tV4pmbZHqbV0rdytSpoeU0a7fdqAQkcN3dnAwBowDhVoKf2ZsBXb0L0mod
         ri/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533224; x=1735138024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7Rao6XieC9T0DL79hefU+Cc7jNmFKIhSEFIHF7BW+k=;
        b=iWlImZbXFCEHTawXi0+I2zBbeOpeW0UBYQb9Fc4grynkkaHHAAz90FsWL4BwfRQ01v
         nli+KNdgWdC2fxYVG2n0E9hFRPHdEqxabdj2XvdyYLwi3bWVZSB8ltnN682Gn8BYFHdy
         sHuSSpxrToWQZm+TWTEgfL2GXyNxCSYI7refG37oSH7ca4KwEjn703mGAOpwk23vP20Z
         Jx3Ns0Ey0tCv83hm8EPvNjV0wEw571+gItpAYADhZ2DvGr/lVZmGWBlO2ebdSBCT7iwa
         SAnk7NW8w0JDSXvKEtX17NCerxSbhMsjD3Kjyu+2JeOxeVjoJ5I9oAo9K6XdxyUG+NcN
         I0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZAILSirqJ7MYdU0+TuOQNzylPUnG/cTZM/NFhkd3aJjIFVvkxS3YJ85DzrLBioxMRlVCkj1WL@vger.kernel.org, AJvYcCWV+5DqR0KEoBv6kWlY9Gmm/sc5OXZZA+qLE80QhZ73osPPlyEdThllaH+ozifjS1/p2tW++nfNUFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsy53a+ROBkZ24Hva8J8fHBsPi6dicnBPzX8oG6wS/OFXNYlNk
	GE1zgFiuQsaEG1CtyxwV2Z75RLo3qJVElhqf7kfddiwTXtQiFz3U
X-Gm-Gg: ASbGncvXOIvJapIaHWbrvovG9DzWwwF2tqeR0D9JA2QNT6u/+UpR4AB6v1MEmQMdysY
	JK1TG0+1PWvM0gu1pTWY3nBH4SkGjfjGrglAj6QQi55FMdl5eoMp1lMyCYyK9xrh7ZQ6f9rCpOG
	xxsni6Cm1tnMU3ToMw6uQRKo1o8pstmNM/3hCSOhWlY1tXjUEqagKIIui3Ps6FVkNDM7maDimes
	njIGI6MdPM9bLnZaOUbIx2ZSEbeQ6vQMgNxhm033eivgg==
X-Google-Smtp-Source: AGHT+IEgWhwAzHgbjw0cJlvPT8gHa6hVp7fjys7VCgaJJLUz0t7KpBnFbrdASwxDvNBV6wqbH+litQ==
X-Received: by 2002:a05:6a21:8dc4:b0:1db:9367:d018 with SMTP id adf61e73a8af0-1e5b482c0ebmr5461992637.20.1734533224486;
        Wed, 18 Dec 2024 06:47:04 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:03 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v6 2/9] net: ethtool: add hds_config member in ethtool_netdev_state
Date: Wed, 18 Dec 2024 14:45:23 +0000
Message-Id: <20241218144530.2963326-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tcp-data-split is UNKNOWN mode, drivers arbitrarily handle it.
For example, bnxt_en driver automatically enables if at least one of
LRO/GRO/JUMBO is enabled.
If tcp-data-split is UNKNOWN and LRO is enabled, a driver returns
ENABLES of tcp-data-split, not UNKNOWN.
So, `ethtool -g eth0` shows tcp-data-split is enabled.

The problem is in the setting situation.
In the ethnl_set_rings(), it first calls get_ringparam() to get the
current driver's config.
At that moment, if driver's tcp-data-split config is UNKNOWN, it returns
ENABLE if LRO/GRO/JUMBO is enabled.
Then, it sets values from the user and driver's current config to
kernel_ethtool_ringparam.
Last it calls .set_ringparam().
The driver, especially bnxt_en driver receives
ETHTOOL_TCP_DATA_SPLIT_ENABLED.
But it can't distinguish whether it is set by the user or just the
current config.

When user updates ring parameter, the new hds_config value is updated
and current hds_config value is stored to old_hdsconfig.
Driver's .set_ringparam() callback can distinguish a passed
tcp-data-split value is came from user explicitly.
If .set_ringparam() is failed, hds_config is rollbacked immediately.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v6:
 - use hds_config instead of using tcp_data_split_mod.

v5:
 - Patch added.

 include/linux/ethtool.h | 2 ++
 net/ethtool/rings.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75c4d..4e451084d58a 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1134,12 +1134,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
+ * @hds_config:		HDS value from userspace.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
+	u8			hds_config;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
 };
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index b7865a14fdf8..2e8239a76234 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -203,6 +203,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
 					&kernel_ringparam, info->extack);
+	kernel_ringparam.tcp_data_split = dev->ethtool->hds_config;
 
 	ethnl_update_u32(&ringparam.rx_pending, tb[ETHTOOL_A_RINGS_RX], &mod);
 	ethnl_update_u32(&ringparam.rx_mini_pending,
@@ -252,6 +253,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
+	if (!ret)
+		dev->ethtool->hds_config = kernel_ringparam.tcp_data_split;
+
 	return ret < 0 ? ret : 1;
 }
 
-- 
2.34.1


