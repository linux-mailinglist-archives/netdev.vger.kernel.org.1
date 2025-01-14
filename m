Return-Path: <netdev+bounces-158140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D765A10949
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7D91886F81
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE2E145A17;
	Tue, 14 Jan 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2yHlqdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD341369AE;
	Tue, 14 Jan 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864971; cv=none; b=h0mtiRZ8QZ9hHS5PLNW2ESiwtJUVsuWS6/l1nUyikGoYPl1CI8+yiqL6qCYvLSULRaCNTP1gDIRIpV1U2ts2DiA+uUVh7DL9og+gfg96VXYhJ5eJvQITkEdIB9D9Gk6pSNd/SmMmyhR3TvwW2LUWatJiy8xMj+k+kL/mD+i3qEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864971; c=relaxed/simple;
	bh=yNnKMRknuezoR6ppUMw3FyyltXhOL9VK+7dDoUvZ7+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgW5IxB9pk0uCsybCkMXnhtWNILxCkqzUoXgJdD7UNBacJTU7qfLuEKE5s8XGQiiAntWoMhMnBr4Yu5yS76D29b9/GjTMOf/lvhE2fOWGpfT2uRAndWU1krl0Ok+81+Dh6guzl5p7K5GC5m9KURy7wkdE9HBV9Eh0oxkurCf0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2yHlqdm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21654fdd5daso95167305ad.1;
        Tue, 14 Jan 2025 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864969; x=1737469769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7AxqqkxgDKYMkGcpzMFHZETKDFuEliMwfcWuyEaZeg=;
        b=V2yHlqdmxLiDPVMcRfpFwtOlW9CHDCdmxA/UCox95G6XI1NvSvivGc4NvEyQ1r8SRA
         7tDjw3u/D7348ztXyNFRIHqL++w7g/aTv5P4HzQvOuFN+yWBC0qqeWTogKujYXuzetYR
         D6HWvDKHzm5pVCPZclM6vJCTcfr2UUK2r4RXoMSdkFyPazOzlZ6d8dfq66e85n1jJLg/
         BAVqvs8KvPXq387XfxcVrU2orXMu8sxIUHSPeWL2X4mpkAGYex9HO3pGYqRrFGmOUTFs
         A3dPDan1PEXDiQYVl3y0J5sv/Epx+VFYKI5yln48ZvnUVJunzDeY7g8SoxcROI0pgWCA
         boHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864969; x=1737469769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7AxqqkxgDKYMkGcpzMFHZETKDFuEliMwfcWuyEaZeg=;
        b=XSBwe18VZQEiXPbiZlF1sQnkIctSwtRhiiZ1WQjStm3lGlwEKn+Atlkn//EqqJoicD
         WAqMYAUNmeJdXcRNA5FWIRyznAjE+VmSIuOwoj5dVSiO72B/lleq24UtDmbLOOVlEnVh
         4UE7/KUBBbiploCLIExkg/rODQa1ZfFf8hl9jIgqTPzendPDy96EqYZI1HSMDv6VB7YN
         lQpKcb6bdc0QsHtiOomfOZ8Q47RFwtiRbJqILHk4k/yuGZ6x79GivoEqyJ3LP3NkLS27
         ZljzZtbxr36m1mM/FabyWgtHbKxrr5QDG/FID0iQjzZggRKekFU0dy0QD7NuNt6JuVKu
         ae8g==
X-Forwarded-Encrypted: i=1; AJvYcCVpunm3Weqbpy0w+CuJJ6d46B7PTEDxWWBsSAb+8F6s+eTlpW+wuND9VypIUo/QcpT8A/o/NLj6@vger.kernel.org, AJvYcCXJWKWKHIVhAqwLD+MBwFE8La186QxrcWVOxEN9U7UsrWJCxOr8LHKOQOHCQODxfO71nCVsaZZa33A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYiRilpUnvu6aZEBxNcq0vLcaDGxoyIGIhQXmIoG0+uc5sX59p
	o+p7HtImMrAErorks4hnxFhkztFPCoPi7j60MTGO1on+I80L+ib1
X-Gm-Gg: ASbGncvZK5OHeBVcJSNUq78vfkb83UwU2XcliXbVlX3gw5KOGVHquE1WNwo1zM5446z
	7J6zFd/U6K/97RI1ia7yapzpPSAnVnq/himEdXzD2Y4Uk5HRQeoPIeADhPb/jzMsu3kgwUbCbSO
	DcOLqt3UYYwJwKeAKgttqZhUk1rZLeDugd5QnO5sNDIpZLWTT38zBkQ6BZmgi3Eqb/og0O7Tu60
	lzDwlcJIYA4qu1KcFe8jgtmP3y1LJ/VsmLUJ4yfwKWyRQ==
X-Google-Smtp-Source: AGHT+IFyQl72ZwmloyTPJrmnhuvp5mXCeP9PLeZW/l7gA7DNgGzQIAZf3ki4fLObuQ5bqVRFus2kFA==
X-Received: by 2002:a05:6a00:3c93:b0:728:9d19:d2ea with SMTP id d2e1a72fcca58-72d21f4b3a1mr38589844b3a.13.1736864969216;
        Tue, 14 Jan 2025 06:29:29 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:29:28 -0800 (PST)
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
Subject: [PATCH net-next v9 01/10] net: ethtool: add hds_config member in ethtool_netdev_state
Date: Tue, 14 Jan 2025 14:28:43 +0000
Message-Id: <20250114142852.3364986-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
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

v9:
 - No changes.

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
index 20a86bd5f4e3..d79bd201c1c8 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1157,12 +1157,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
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
index bced03fb349e..3e6336775baf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4082,6 +4082,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
+u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 u32 dev_get_min_mp_channel_count(const struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index fda4e1039bf0..5ef817d656ef 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9550,6 +9550,18 @@ u8 dev_xdp_prog_count(struct net_device *dev)
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


