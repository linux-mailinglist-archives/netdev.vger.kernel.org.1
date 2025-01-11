Return-Path: <netdev+bounces-157417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684BA0A433
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D0188B238
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBA19DF64;
	Sat, 11 Jan 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajh9mq5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB9374F1;
	Sat, 11 Jan 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606753; cv=none; b=UaLFhAHU8mPYexH4qHOYmzA0471qQ/5OMKtpLhb8gt9xuaboC+eZULd6mVFh7uaGZ8xl1b94k0yMfQXTR+FJGdx8nO2Z6pxgk/SUuRQGJc6sAbJU6BVmUK+4yDzXVpYmmja6NDKyYIkY7FahWYilDrnP9J7Jgr2UQdp7iEzwBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606753; c=relaxed/simple;
	bh=WGu6vDMuc9AhNox5PTrNAaX0IeLh5kPU1Xfs9m2S7hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSlOWySpzMi4Br2YcmuOS/FHZPx07AEeYKIlaSSr1u8bNnuIPJg2KQ6FJR3706VGNANyCnloNuzoG/AQ5k/OWnSmkjGKTYR9r1VTWNuqDvriKfeofAqrW+iPwTEFwJjBNbrQU//x3jBE42z1cHFMUQQtKtbQcpp+RzPXd1CIEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajh9mq5X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21675fd60feso67267855ad.2;
        Sat, 11 Jan 2025 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606751; x=1737211551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGYhWUkw+Na2G/tYr31iX4XrARumPudcKMPC5N3X34A=;
        b=ajh9mq5X2H7wfjTq04NrCoKVf5V/QxRkU5oRP6ZMSuK28ggbOnGPTdP4h/4iU4rsql
         9+xKIpvbG3xLl8XMV0Hgvg8guwg5XConyF/5PiyCKDEj69H1yQTh1P25MGvGWr9h9Lom
         nYc8gcQcx1SV16H+x6lGZ3VArpdpBS811f4Vj35S3JUcaSExAWgA4XLUais3QZjROcwP
         CqtoFlgzi4PaCQaHKbFIqTM4ALtMD0bALsa6ijhmY5lnqlLCmettwBikv7AstNqA620j
         2vT80wgVniYTbUjr6wkc3DaliwIBD9BjaMvZ/ohyk9/ZtgYib/vWT5vw0ra9ubt0HE7Q
         LC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606751; x=1737211551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGYhWUkw+Na2G/tYr31iX4XrARumPudcKMPC5N3X34A=;
        b=hDzmPot2KMJJjYCAIRTHc5y3+M8Fvf7T8RzUzXtBOo8lzvbsPjl1gLfqwuTc+n2gVT
         z5fmJaRCkWNKHSY44efxfLLX9yUw5btzhXeVBsswpTRhmKZWX0QyyEGbYMyx+pxRl6DK
         I4mrJjLENCzKXxs0GhUCdVgcCLYuTm7aOAb/1+kVziFgdZN08sOzzhBRNLTfmyJ65vaq
         INdf/TLXMO5lNblPSlztP4ede8N5KySwInVKNo9VHm9Q3+8lnpn0ofPpR98IOIGmb/XN
         AFEEWdYnDLYC40B6H+aiY/BliUadMqc95i4ggIYoP3mgdNrtx6UgBfD5GwTcBOICHL9x
         vjIw==
X-Forwarded-Encrypted: i=1; AJvYcCVAvoy1b0Wh6Osb+vayKgueD26WV8fWzZBOpQhOmwEyWNFqcy2U00P5SreVPnlhZJ1Ie2VeeDAM@vger.kernel.org, AJvYcCWKrKXEnTu0CaLaVTf6rPZ5iZldYRIcsEbzecZ9JSJkEeh3V9/Mk3TqZNx3xw2R6XvR2DEe0F4YZwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqWFlKXut/9ngTsLjcF25A0NRJGhUyrHG6KKudPW6thh2nzjs
	ZguIKF1a5uMTFXaX5JAb+aN3DEJ5q5nW+4/dcakLJCEZbdDMabLL
X-Gm-Gg: ASbGncvu+jmUmltPXDNpyYgr7PvKrxiMhzSWn2wDHzZ1BJle/G+BAuVz971NiEkkr1u
	gDuDSPPUrBpHtfUWNtNF1geJElr9XY0UizPvsyUTjj4Gbmr5lngMYwSfS1OtkJ/ngyD0SvWggmP
	nuy6pQsZXv4vwjFp2/OF7xLEGWdFOty9xWAZN919xBtLZMz3YeGeU3i8+FSASuQ8cA1pAkVJCk8
	kgWH/Jl3djehFxCnbyvPs7rLAQx5OLCymdN3XLczLX7AQ==
X-Google-Smtp-Source: AGHT+IGhYsOWsTKHg9Mpf3L22ucdmXx84JGCpRfb1co5t/gRbf3jdEVXTI+K6NXdMh1RUL8AGQ3lrQ==
X-Received: by 2002:a05:6a00:1909:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72d220025bcmr22104359b3a.21.1736606750754;
        Sat, 11 Jan 2025 06:45:50 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:45:50 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
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
	linux-doc@vger.kernel.org
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
Subject: [PATCH net-next v8 01/10] net: ethtool: add hds_config member in ethtool_netdev_state
Date: Sat, 11 Jan 2025 14:45:04 +0000
Message-Id: <20250111144513.1289403-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v8:
 - No changes.

v7:
 - Add review tag from Jakub.
 - Add dev_xdp_sb_prog_count().

v6:
 - use hds_config instead of using tcp_data_split_mod.

v5:
 - Patch added.

 include/linux/ethtool.h   |  2 ++
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 12 ++++++++++++
 net/ethtool/rings.c       | 12 ++++++++++++
 4 files changed, 27 insertions(+)

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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e84602e0226c..a5f12ffa903e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4084,6 +4084,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
+u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 u32 dev_get_min_mp_channel_count(const struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aa..2701920fea05 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9482,6 +9482,18 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
+u8 dev_xdp_sb_prog_count(struct net_device *dev)
+{
+	u8 count = 0;
+	int i;
+
+	for (i = 0; i < __MAX_XDP_MODE; i++)
+		if (dev->xdp_state[i].prog &&
+		    !dev->xdp_state[i].prog->aux->xdp_has_frags)
+			count++;
+	return count;
+}
+
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index b7865a14fdf8..b2a2586b241f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -203,6 +203,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
 					&kernel_ringparam, info->extack);
+	kernel_ringparam.tcp_data_split = dev->ethtool->hds_config;
 
 	ethnl_update_u32(&ringparam.rx_pending, tb[ETHTOOL_A_RINGS_RX], &mod);
 	ethnl_update_u32(&ringparam.rx_mini_pending,
@@ -225,6 +226,14 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (!mod)
 		return 0;
 
+	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    dev_xdp_sb_prog_count(dev)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
+				    "tcp-data-split can not be enabled with single buffer XDP");
+		return -EINVAL;
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
@@ -252,6 +261,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
+	if (!ret)
+		dev->ethtool->hds_config = kernel_ringparam.tcp_data_split;
+
 	return ret < 0 ? ret : 1;
 }
 
-- 
2.34.1


