Return-Path: <netdev+bounces-155018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D96A00B06
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4445163F43
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA681F9A81;
	Fri,  3 Jan 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3EqT//s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4CC442C;
	Fri,  3 Jan 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916631; cv=none; b=CfmH3V0JeBk0OwHtHOzhS0h87ue1/omTCmXEuegTx7OtvsG9leGsb06YlGmCz63oNC9KZrOkxixPpKEFDrfUORvT+fHig//PkuGr1FOgWFUpyzQgQOQ0xqYbs3vPNqPC5t7AypG3aJJ1HKh7wvEPwCWS2yd6O3VbCN8Dpud4Ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916631; c=relaxed/simple;
	bh=7WlBGENIy2oPZVIfFIEmJXuBuP8Ivq681Nkvtdqy9sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDjgfj+rSMf+QrztcaaP+bcE4/9qG+1dtn6+G94P6a5qrTTtoZs4zDG8cD1ruy63untGvbQ2rfbfFQIiCN6Apv+0PhBmpBCLx10cbNALKxW9Tpj2V1raTEpiUsCg3xfvQPpBFoyRv/yTrnEcfz0EPuf6VCnWP7X0S6xKyokjoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3EqT//s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21670dce0a7so94692895ad.1;
        Fri, 03 Jan 2025 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916629; x=1736521429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qURv+YWuHhVC9usfYzqIZMJoKHODK3qRvWWEegQVoXI=;
        b=U3EqT//s91tqH2aV4Wa2ma4aDB+wKmA4M6evE8V2pDuORk+8XqYFlYkFa6WID18F1p
         LsN70ieqi33dwPEEgSe0Y+iApU+qeJ6T0OY3PpgcFADLTF1Iq54eV3yOWG/MtCOidGIE
         nPWJTeY61TMx3NYXn7Hfdl4WzCbrjf4ApiEPmvLmJ6LHGIwYXjF3yf72zsvGqNWCj7d5
         i08G+gDWUBYdHnD1ewtltGs9v2B6kXRsJSMcKCf0bmsUwfa404E+YokVjGSFrfJ3yEtb
         NSJgv4CuO1xH/VC4EsXnJKz7yTPxVOJjD8wg28NXuykvfwBzSJny95KW1eNmnhJfy1lk
         pZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916629; x=1736521429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qURv+YWuHhVC9usfYzqIZMJoKHODK3qRvWWEegQVoXI=;
        b=ZT1S1dGo+f82oFNt3nGgmxTJDXAo0JgWJ7fgyT8M3yU/8HLwpKEYztG/AxumUF+k8S
         iB/uzpSX9cb0Tw+CQYlNVqjur38LKj+kCHYBZ+N3XSKGyUh6KFEEwO11tOPeiZzZosNQ
         RXzZwdIsGBPGpflt4lfcPJTqwz5+ftwd22Jt/tCtn27Au+PSYEqNRgsjk6VqJ+6Ml/WL
         z+rz1veKObFixQ0SkAN0QexL5ds8U7EB3WkaX3aBtYzyqKQ9Ea3eiHfH3VJovpTBM6ki
         N7d5dRSpa7n9QLExwe2vQPFnOjJVHbd6nNkeYm32a6QeDOItiC7DhoAo1N5MF4cpwiM+
         1jMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Qwl4n/D77slV52TGKM1G5PwaniTBYGHeH0hN7VHCz3GWmWzBo+GlstjbIy9Jw0JHcQdJcnM4@vger.kernel.org, AJvYcCW6ui4Mmzo7Aqt3PK8++S4FV5NY1pvMUQ+xj/XKOKAlbC/OVt0QRV+2k7qlMDe/JSigQwT53vGa1iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJrMCiUOva//XXl0wNiFmfTxg5pDVPwTdFf2OjiikrD6s4elH
	UXu9YzPwuUjoA9VERxQJZH5gZo52xImnsMeTxlSxoagMn/l0QyLM
X-Gm-Gg: ASbGncvNhCkHPf39+A/p9SZk6Bc/hY4EO5ZMm7P2WK48prVrw6bR8tDZbIo0ODiDAi9
	8kxybu2JwOQAWZCYlXqzlO2q7mLDWuDocdV1qkg1b1qrqs39XiUonRuWcNvTEHokCxpISg1frgj
	nIQ4qQclArghU+gaas3bRRclaWOYV3sIURLGpUuIpA4WQOg3sUVRr7xYsYBhrSz9HYVxuOilUyr
	WuSV+tZOxcaMkA8nkubVq+UwnvjLdzcU+97qyyXGMKCkw==
X-Google-Smtp-Source: AGHT+IEKbKSiMUJ711ZK8IL+7z7h3fbU8nBtMpx9rbNPnFsaEiA/bR0ady7uNzOW0h6l2O5/0knKLw==
X-Received: by 2002:a17:902:e809:b0:215:603e:2141 with SMTP id d9443c01a7336-219e6ea0218mr745619905ad.19.1735916628490;
        Fri, 03 Jan 2025 07:03:48 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:03:47 -0800 (PST)
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
Subject: [PATCH net-next v7 01/10] net: ethtool: add hds_config member in ethtool_netdev_state
Date: Fri,  3 Jan 2025 15:03:16 +0000
Message-Id: <20250103150325.926031-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
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
index 2593019ad5b1..2b06450cacd4 100644
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
index c7f3dea3e0eb..bc98f4920e12 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9480,6 +9480,18 @@ u8 dev_xdp_prog_count(struct net_device *dev)
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


